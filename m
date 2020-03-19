Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1749C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870152072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870152072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqCd-0001u6-Mi
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jEqBd-0000Oq-7t
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jEqBb-0004if-QP
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:05:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:34506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jEqBa-0004gb-T9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:05:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jEqBZ-0005Ek-Ch
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 08:05:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5DF132E80C3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 08:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Mar 2020 07:52:02 -0000
From: Dongwhan Kim <1868055@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: eastson83
X-Launchpad-Bug-Reporter: Dongwhan Kim (eastson83)
X-Launchpad-Bug-Modifier: Dongwhan Kim (eastson83)
Message-Id: <158460432256.11238.315491712700748145.malonedeb@soybean.canonical.com>
Subject: [Bug 1868055] [NEW] cannot run golang app with docker,
 version 17.09.1-ce, disabling core 0 and qemu-arm, version 2.7.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6ce65e275262c616683a65c8cc56dc78a36ef6db
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1868055 <1868055@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello!
I figure out that sometimes simple go application is not working.
I am using docker + qemu-arm + go( for armv7l).

These are version info below.

root@VDBS1535:~# docker -v
Docker version 17.09.1-ce, build 19e2cf6

bash-3.2# qemu-arm --version
qemu-arm version 2.7.0, Copyright (c) 2003-2016 Fabrice Bellard and the QEM=
U Project developers

$ go version
go version go1.12.6 linux/arm
$ go env
GOARCH=3D"arm"
GOBIN=3D""
GOCACHE=3D"/home/quickbuild/.cache/go-build"
GOEXE=3D""
GOFLAGS=3D""
GOHOSTARCH=3D"arm"
GOHOSTOS=3D"linux"
GOOS=3D"linux"
GOPATH=3D"/home/quickbuild/go"
GOPROXY=3D""
GORACE=3D""
GOROOT=3D"/usr/lib/golang"
GOTMPDIR=3D""
GOTOOLDIR=3D"/usr/lib/golang/pkg/tool/linux_arm"
GCCGO=3D"gccgo"
GOARM=3D"7"
CC=3D"gcc"
CXX=3D"g++"
CGO_ENABLED=3D"1"
GOMOD=3D""
CGO_CFLAGS=3D"-g -O2"
CGO_CPPFLAGS=3D""
CGO_CXXFLAGS=3D"-g -O2"
CGO_FFLAGS=3D"-g -O2"
CGO_LDFLAGS=3D"-g -O2"
PKG_CONFIG=3D"pkg-config"
GOGCCFLAGS=3D"-fPIC -marm -pthread -fmessage-length=3D0 -fdebug-prefix-map=
=3D/tmp/go-build242285369=3D/tmp/go-build -gno-record-gcc-switches"

This issue is come only when I disable core 0 using a command below.
please check "--cpuset-cpus=3D1-55" option.

sudo docker run --privileged -d -i -t --cpuset-cpus=3D1-55 --mount
type=3Dbind,source=3D"/home/dw83kim/mnt",destination=3D"/mnt" --network host
--name=3D"ubuntu_core1" ubuntu:xenial-20200212


This is what I have tested in the environment above.

package main
func main(){
    for i:=3D0; i<1000; i++ {
        println("Hello world")
    }
}

This is one of the error logs have faced sometimes not always.

bash-3.2# go run test.go
fatal error: schedule: holding locks
panic during panic
SIGILL: illegal instruction
PC=3D0xc9ec4c m=3D3 sigcode=3D2

goroutine 122 [runnable]:
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)
bash-3.2#

Please check it.
Thanks in advance.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1868055

Title:
  cannot run golang app with docker, version 17.09.1-ce, disabling core
  0 and qemu-arm, version 2.7.

Status in QEMU:
  New

Bug description:
  Hello!
  I figure out that sometimes simple go application is not working.
  I am using docker + qemu-arm + go( for armv7l).

  These are version info below.

  root@VDBS1535:~# docker -v
  Docker version 17.09.1-ce, build 19e2cf6

  bash-3.2# qemu-arm --version
  qemu-arm version 2.7.0, Copyright (c) 2003-2016 Fabrice Bellard and the Q=
EMU Project developers

  $ go version
  go version go1.12.6 linux/arm
  $ go env
  GOARCH=3D"arm"
  GOBIN=3D""
  GOCACHE=3D"/home/quickbuild/.cache/go-build"
  GOEXE=3D""
  GOFLAGS=3D""
  GOHOSTARCH=3D"arm"
  GOHOSTOS=3D"linux"
  GOOS=3D"linux"
  GOPATH=3D"/home/quickbuild/go"
  GOPROXY=3D""
  GORACE=3D""
  GOROOT=3D"/usr/lib/golang"
  GOTMPDIR=3D""
  GOTOOLDIR=3D"/usr/lib/golang/pkg/tool/linux_arm"
  GCCGO=3D"gccgo"
  GOARM=3D"7"
  CC=3D"gcc"
  CXX=3D"g++"
  CGO_ENABLED=3D"1"
  GOMOD=3D""
  CGO_CFLAGS=3D"-g -O2"
  CGO_CPPFLAGS=3D""
  CGO_CXXFLAGS=3D"-g -O2"
  CGO_FFLAGS=3D"-g -O2"
  CGO_LDFLAGS=3D"-g -O2"
  PKG_CONFIG=3D"pkg-config"
  GOGCCFLAGS=3D"-fPIC -marm -pthread -fmessage-length=3D0 -fdebug-prefix-ma=
p=3D/tmp/go-build242285369=3D/tmp/go-build -gno-record-gcc-switches"

  This issue is come only when I disable core 0 using a command below.
  please check "--cpuset-cpus=3D1-55" option.

  sudo docker run --privileged -d -i -t --cpuset-cpus=3D1-55 --mount
  type=3Dbind,source=3D"/home/dw83kim/mnt",destination=3D"/mnt" --network h=
ost
  --name=3D"ubuntu_core1" ubuntu:xenial-20200212

  =

  This is what I have tested in the environment above.

  package main
  func main(){
      for i:=3D0; i<1000; i++ {
          println("Hello world")
      }
  }

  This is one of the error logs have faced sometimes not always.

  bash-3.2# go run test.go
  fatal error: schedule: holding locks
  panic during panic
  SIGILL: illegal instruction
  PC=3D0xc9ec4c m=3D3 sigcode=3D2

  goroutine 122 [runnable]:
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)
  bash-3.2#

  Please check it.
  Thanks in advance.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1868055/+subscriptions

