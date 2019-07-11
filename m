Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C7C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC9F2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC9F2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlbf0-0007rg-Fn
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 12:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37701)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hlbeq-0007TW-Ni
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hlbep-000648-4t
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:10:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:38414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hlbeo-000639-VD
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:10:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hlben-0000lZ-K7
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 16:10:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7EEBD2E8078
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 16:10:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jul 2019 15:59:26 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell tfine
X-Launchpad-Bug-Reporter: Troy Fine (tfine)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <156018983401.31409.602642212914113436.malonedeb@gac.canonical.com>
Message-Id: <156286076762.23597.2923214207828356122.launchpad@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 12a48abe926fb6db911f4ddaed1f224476dcf772
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1832250] Re: arm32v6/golang:1.10-alpine is broken
 for qemu 2.8 on MacOS cross-compilation
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
Reply-To: Bug 1832250 <1832250@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1832250

Title:
  arm32v6/golang:1.10-alpine is broken for qemu 2.8 on MacOS cross-
  compilation

Status in QEMU:
  Incomplete

Bug description:
  FROM arm32v6/golang:1.10-alpine

  docker build -t openhorizon/ibm.gps_arm:2.0.7 -f ./Dockerfile.arm .
  Sending build context to Docker daemon  110.6kB
  Step 1/12 : FROM arm32v6/golang:1.10-alpine
  1.10-alpine: Pulling from arm32v6/golang
  05276f4299f2: Pull complete =

  5657e63df536: Pull complete =

  febca98d0249: Pull complete =

  5053a7aa5dea: Pull complete =

  d048463a3701: Pull complete =

  b628c679d668: Pull complete =

  Digest: sha256:94c5fd97b17d0e9fe89e011446bedda4784cb0af7a60494989e2a21c0d=
cba92f
  Status: Downloaded newer image for arm32v6/golang:1.10-alpine
   ---> 3110964e8c9a
  Step 2/12 : RUN apk --no-cache update && apk add git
   ---> Running in 14ffb11506bb
  fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/armhf/APKINDEX.tar.gz
  fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/armhf/APKINDEX.=
tar.gz
  v3.9.4-24-g4e2ff29bbe [http://dl-cdn.alpinelinux.org/alpine/v3.9/main]
  v3.9.4-25-g65097c9cdc [http://dl-cdn.alpinelinux.org/alpine/v3.9/communit=
y]
  OK: 9547 distinct packages available
  fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/armhf/APKINDEX.tar.gz
  fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/armhf/APKINDEX.=
tar.gz
  (1/7) Installing nghttp2-libs (1.35.1-r0)
  (2/7) Installing libssh2 (1.8.2-r0)
  (3/7) Installing libcurl (7.64.0-r2)
  (4/7) Installing libgcc (8.3.0-r0)
  (5/7) Installing expat (2.2.6-r0)
  (6/7) Installing pcre2 (10.32-r1)
  (7/7) Installing git (2.20.1-r0)
  Executing busybox-1.29.3-r10.trigger
  OK: 18 MiB in 22 packages
  Removing intermediate container 14ffb11506bb
   ---> 6890ea7ed09b
  Step 3/12 : RUN mkdir -p /build/bin
   ---> Running in 44e52d78d7b4
  Removing intermediate container 44e52d78d7b4
   ---> 0763afda41d1
  Step 4/12 : COPY src /build/src
   ---> 05bab9a72a34
  Step 5/12 : WORKDIR /build
   ---> Running in 5a663caff249
  Removing intermediate container 5a663caff249
   ---> 5a6ca53c00de
  Step 6/12 : RUN env GOPATH=3D/build GOOPTIONS_ARM=3D'CGO_ENABLED=3D0 GOOS=
=3Dlinux GOARCH=3Darm GOARM=3D6' go get github.com/kellydunn/golang-geo
   ---> Running in 05b09ee0c206
  Removing intermediate container 05b09ee0c206
   ---> e68c6e222e51
  Step 7/12 : RUN env GOPATH=3D/build GOOPTIONS_ARM=3D'CGO_ENABLED=3D0 GOOS=
=3Dlinux GOARCH=3Darm GOARM=3D6' go build -o /build/bin/armv6_gps /build/sr=
c/main.go
   ---> Running in ea6d2707e35f
  qemu-arm: /build/qemu-rwi8RH/qemu-2.8+dfsg/translate-all.c:175: tb_lock: =
Assertion `!have_tb_lock' failed.
  qemu-arm: /build/qemu-rwi8RH/qemu-2.8+dfsg/translate-all.c:175: tb_lock: =
Assertion `!have_tb_lock' failed.
  The command '/bin/sh -c env GOPATH=3D/build GOOPTIONS_ARM=3D'CGO_ENABLED=
=3D0 GOOS=3Dlinux GOARCH=3Darm GOARM=3D6' go build -o /build/bin/armv6_gps =
/build/src/main.go' returned a non-zero code: 139
  make: *** [build] Error 139

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1832250/+subscriptions

