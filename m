Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCABC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AFE20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AFE20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrZ3-00076E-RO
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 07:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtrYQ-0006eu-Mg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:50:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:49522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtrYO-0006QX-4F
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:50:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jtrYL-0005AO-2j
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 11:50:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E36082E80F0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 11:50:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2020 11:40:22 -0000
From: Nirman Narang <1886793@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier nirmannarang
X-Launchpad-Bug-Reporter: Nirman Narang (nirmannarang)
X-Launchpad-Bug-Modifier: Nirman Narang (nirmannarang)
References: <159420215057.30952.7191975282964377029.malonedeb@wampee.canonical.com>
Message-Id: <159438122253.8035.666882663732298644.malone@wampee.canonical.com>
Subject: [Bug 1886793] Re: "go install" command fails while running inside
 s390x docker container on x86_64 host using qemu
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 40ca314b712eba6569223fcb9fbc3b35123a4c30
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 07:50:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1886793 <1886793@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cloned qemu source code, checked out latest tag v5.0.0, built and
installed the same on x86 Ubuntu host using "make" and "make install".

root:~# qemu-s390x --version
qemu-s390x version 5.0.0 (v5.0.0-dirty)
Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers


root:~# wget -q https://storage.googleapis.com/golang/go1.14.2.linux-s390x.=
tar.gz
root:~# chmod ugo+r go1.14.2.linux-s390x.tar.gz
root:~# rm -rf /usr/local/go /usr/bin/go
root:~# tar -C /usr/local -xzf go1.14.2.linux-s390x.tar.gz
root:~# ln -sf /usr/local/go/bin/go /usr/bin/
root:~# ln -sf /usr/local/go/bin/gofmt /usr/bin/
root:~# ln -sf /usr/bin/gcc /usr/bin/s390x-linux-gnu-gcc
root:~# go version
-bash: /usr/bin/go: cannot execute binary file: Exec format error
root:~# qemu-s390x /usr/bin/go version
/lib/ld64.so.1: No such file or directory

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886793

Title:
  "go install" command fails while running inside s390x docker container
  on x86_64 host using qemu

Status in QEMU:
  New

Bug description:
  Steps to reproduce the issue:

  Register x86_64 host with the latest qemu-user-static.
  docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

  Build the following Docker Image using following Dockerfile.s390x
  using command docker build -t test/crossbuild:latest-s390x -f
  Dockerfile.s390x .

  Dockerfile.s390x

  ##############################################
  FROM alpine:3.11 as qemu
  ARG QEMU_VERSION=3D5.0.0-2
  ARG QEMU_ARCHS=3D"s390x"
  RUN apk --update add curl
  #Enable non-native runs on amd64 architecture hosts
  RUN for i in ${QEMU_ARCHS}; do curl -L https://github.com/multiarch/qemu-=
user-static/releases/download/v${QEMU_VERSION}/qemu-${i}-static.tar.gz | ta=
r zxvf - -C /usr/bin; done
  RUN chmod +x /usr/bin/qemu-*

  FROM s390x/golang:1.14.2-alpine3.11
  MAINTAINER LoZ Open Source Ecosystem (https://www.ibm.com/developerworks/=
community/groups/community/lozopensource)

  ARG MANIFEST_TOOL_VERSION=3Dv1.0.2

  #Enable non-native builds of this image on an amd64 hosts.
  #This must be the first RUN command in this file!
  COPY --from=3Dqemu /usr/bin/qemu-*-static /usr/bin/

  #Install su-exec for use in the entrypoint.sh (so processes run as the ri=
ght user)
  #Install bash for the entry script (and because it's generally useful)
  #Install curl to download glide
  #Install git for fetching Go dependencies
  #Install ssh for fetching Go dependencies
  #Install mercurial for fetching go dependencies
  #Install wget since it's useful for fetching
  #Install make for building things
  #Install util-linux for column command (used for output formatting).
  #Install grep and sed for use in some Makefiles (e.g. pulling versions ou=
t of glide.yaml)
  #Install shadow for useradd (it allows to use big UID)
  RUN apk update && apk add --no-cache su-exec curl bash git openssh mercur=
ial make wget util-linux tini file grep sed shadow
  RUN apk upgrade --no-cache

  #Disable ssh host key checking
  RUN echo 'Host *' >> /etc/ssh/ssh_config \
  =C2=A0=C2=A0&& echo '    StrictHostKeyChecking no' >> /etc/ssh/ssh_config

  #Disable cgo so that binaries we build will be fully static.
  ENV CGO_ENABLED=3D0

  #Recompile the standard library with cgo disabled.  This prevents the sta=
ndard library from being
  #marked stale, causing full rebuilds every time.
  RUN go install -v std

  #Install glide
  RUN go get github.com/Masterminds/glide
  ENV GLIDE_HOME /home/user/.glide

  #Install dep
  RUN go get github.com/golang/dep/cmd/dep

  #Install ginkgo CLI tool for running tests
  RUN go get github.com/onsi/ginkgo/ginkgo

  #Install linting tools.
  RUN wget -O - -q https://install.goreleaser.com/github.com/golangci/golan=
gci-lint.sh | sh -s v1.20.0
  RUN golangci-lint --version

  #Install license checking tool.
  RUN go get github.com/pmezard/licenses

  #Install tool to merge coverage reports.
  RUN go get github.com/wadey/gocovmerge

  #Install CLI tool for working with yaml files
  RUN go get github.com/mikefarah/yaml

  #Delete all the Go sources that were downloaded, we only rely on the bina=
ries
  RUN rm -rf /go/src/*

  #Install vgo (should be removed once we take Go 1.11)
  RUN go get -u golang.org/x/vgo

  #Ensure that everything under the GOPATH is writable by everyone
  RUN chmod -R 777 $GOPATH

  RUN curl -sSL https://github.com/estesp/manifest-tool/releases/download/$=
{MANIFEST_TOOL_VERSION}/manifest-tool-linux-s390x > manifest-tool && \
  =C2=A0=C2=A0=C2=A0=C2=A0chmod +x manifest-tool && \
  =C2=A0=C2=A0=C2=A0=C2=A0mv manifest-tool /usr/bin/

  COPY entrypoint.sh /usr/local/bin/entrypoint.sh
  ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
  ##################################################################

  =

  The build just hangs at RUN go install -v std


  Also, while running the same command inside s390x container on x86_64
  host, error Illegal instruction (core dumped) is thrown.

  Register x86_64 host with the latest qemu-user-static.
  docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

  docker run -it -v /home/test/qemu-s390x-static:/usr/bin/qemu-s390x-
  static s390x/golang:1.14.2-alpine3.11

  Inside s390x container:

  apk update && apk add --no-cache su-exec curl bash git openssh mercurial =
make wget util-linux tini file grep sed shadow
  apk upgrade --no-cache

  #Disable cgo so that binaries we build will be fully static.
  export CGO_ENABLED=3D0
  go install -v std

  =

  This gives the following error:
  Illegal instruction (core dumped)

  =

  Environment:
  x86_64 Ub18.04 4.15.0-101-generic Ubuntu SMP x86_64 GNU/Linux

  QEMU user static version: 5.0.0-2

  Container application: Docker

  Client: Docker Engine - Community
  =C2=A0Version:           19.03.11
  =C2=A0API version:       1.40
  =C2=A0Go version:        go1.13.10
  =C2=A0Git commit:        42e35e61f3
  =C2=A0Built:             Mon Jun  1 09:12:22 2020
  =C2=A0OS/Arch:           linux/amd64
  =C2=A0Experimental:      false

  Server: Docker Engine - Community
  =C2=A0Engine:
  =C2=A0=C2=A0Version:          19.03.11
  =C2=A0=C2=A0API version:      1.40 (minimum version 1.12)
  =C2=A0=C2=A0Go version:       go1.13.10
  =C2=A0=C2=A0Git commit:       42e35e61f3
  =C2=A0=C2=A0Built:            Mon Jun  1 09:10:54 2020
  =C2=A0=C2=A0OS/Arch:          linux/amd64
  =C2=A0=C2=A0Experimental:     false
  =C2=A0containerd:
  =C2=A0=C2=A0Version:          1.2.13
  =C2=A0=C2=A0GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
  =C2=A0runc:
  =C2=A0=C2=A0Version:          1.0.0-rc10
  =C2=A0=C2=A0GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
  =C2=A0docker-init:
  =C2=A0=C2=A0Version:          0.18.0
  =C2=A0=C2=A0GitCommit:        fec3683

  Additional information optionally:
  When I build the same Dockerfile.s390x on an s390x machine, it is built s=
uccessfully.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886793/+subscriptions

