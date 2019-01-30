FROM centos

ENV FLY_URL=https://github.com/concourse/concourse/releases/download/v4.2.2/fly_linux_amd64
ENV OC_URL=https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz

RUN yum update -y yum install -y epel-release && yum install -y git curl jq openssh-clients wget && yum clean all

WORKDIR /tmp
RUN wget $FLY_URL && mv fly* /bin/fly && chmod +x /bin/fly
RUN wget $OC_URL && tar xfz openshift-origin* && rm *.tar.gz && mv openshift-origin*/oc /bin/oc

COPY ipa.crt /etc/pki/ca-trust/source/anchors/ipa.crt
COPY openshift.crt /etc/pki/ca-trust/source/anchors/openshift.crt
RUN update-ca-trust

CMD [ "/bin/bash" ]
