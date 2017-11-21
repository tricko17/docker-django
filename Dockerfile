FROM alpine:3.6

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/main" >> /etc/apk/repositories


RUN apk add --update python3 python3-dev postgresql-client postgresql-dev build-base gettext vim bash
RUN pip3 install --upgrade pip

RUN mkdir /code
WORKDIR /code

ADD requirements.txt /code/requirements.txt
RUN pip3 install -r /code/requirements.txt

ADD script_run.sh /code/script_run.sh
ADD script_build.sh /code/script_build.sh
ADD script_test.sh /code/script_test.sh

# Define port 
EXPOSE 8000

# since we will be "always" mounting the volume, we can set this up
# ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["python3"]
