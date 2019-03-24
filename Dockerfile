FROM node:10-alpine
LABEL maintainer="Krzysztof Suszynski <krzysztof.suszynski@wavesoftware.pl>"

WORKDIR /src

RUN apk add --no-cache --virtual .build-deps \
  git python make g++ \
  && apk add --no-cache openssh-client \
  && git clone https://github.com/krishnasrinivas/wetty --branch master /src \
  && npm install \
  && apk del .build-deps \
  && adduser -h /src -D term \
  && npm run-script build

ADD run.sh /src

# Default ENV params used by wetty
ENV REMOTE_SSH_SERVER 127.0.0.1
ENV REMOTE_SSH_PORT 22

EXPOSE 3000

ENTRYPOINT "./run.sh"
