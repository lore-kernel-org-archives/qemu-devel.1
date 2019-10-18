Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21309CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF2B222D1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF2B222D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMjl-00029c-5X
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iLMis-0001i9-NI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iLMir-0002xG-Ic
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:30:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:47468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iLMir-0002w0-DC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iLMiq-00041Y-2q
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0F9AC2E80C7
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Oct 2019 07:24:22 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1848556@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paelzer rodsmith
X-Launchpad-Bug-Reporter: Rod Smith (rodsmith)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <157133449178.19203.719001918774596241.malonedeb@gac.canonical.com>
Message-Id: <157138346253.25391.9203038438005514845.malone@chaenomeles.canonical.com>
Subject: [Bug 1848556] Re: qemu-img check failing on remote image in Eoan
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e4803d809f921df265cb7aed48b6ce60494ad1da
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1848556 <1848556@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The stuck poll is at:
#0  0x00007fafb935ad26 in __GI_ppoll (fds=3D0x560dba615670, nfds=3D1, timeo=
ut=3D<optimized out>, timeout@entry=3D0x0, sigmask=3Dsigmask@entry=3D0x0) a=
t ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000560db89550b9 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<opt=
imized out>, __fds=3D<optimized out>) at /usr/include/x86_64-linux-gnu/bits=
/poll2.h:77
#2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, timeout=3D=
<optimized out>) at ./util/qemu-timer.c:322
#3  0x0000560db89570eb in aio_poll (ctx=3Dctx@entry=3D0x560dba5e83b0, block=
ing=3Dblocking@entry=3Dtrue) at ./util/aio-posix.c:666
#4  0x0000560db888c21d in bdrv_check (bs=3D<optimized out>, res=3D<optimize=
d out>, fix=3D<optimized out>) at ./block.c:4149
#5  0x0000560db887e6ab in collect_image_check (bs=3D0x560dba5ed680, check=
=3D0x560dba6143d0, filename=3D0x7ffe3d7c48d7 "http://localhost:80/bionic-se=
rver-cloudimg-amd64.img", fix=3D<optimized out>, =

    fmt=3D<optimized out>) at ./qemu-img.c:615
#6  0x0000560db88825e1 in img_check (argc=3D<optimized out>, argv=3D<optimi=
zed out>) at ./qemu-img.c:774
#7  0x0000560db887bd2e in main (argc=3D2, argv=3D<optimized out>) at ./qemu=
-img.c:4987

And from strace we know that the FD is from
260 [pid 20469]      0.000067 eventfd2(0, EFD_CLOEXEC|EFD_NONBLOCK) =3D 8 <=
0.000041>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1848556

Title:
  qemu-img check failing on remote image in Eoan

Status in QEMU:
  Confirmed

Bug description:
  The "qemu-img check" function is failing on remote (HTTP-hosted)
  images, beginning with Ubuntu 19.10 (qemu-utils version 1:4.0+dfsg-
  0ubuntu9). With previous versions, through Ubuntu 19.04/qemu-utils
  version 1:3.1+dfsg-2ubuntu3.5, the following worked:

  $ /usr/bin/qemu-img check  http://10.193.37.117/cloud/eoan-server-cloudim=
g-amd64.img
  No errors were found on the image.
  19778/36032 =3D 54.89% allocated, 90.34% fragmented, 89.90% compressed cl=
usters
  Image end offset: 514064384

  The 10.193.37.117 server holds an Apache server that hosts the cloud
  images on a LAN. Beginning with Ubuntu 19.10/qemu-utils 1:4.0+dfsg-
  0ubuntu9, the same command never returns. (I've left it for up to an
  hour with no change.) I'm able to wget the image from the same server
  and installation on which qemu-img check fails. I've tried several
  .img files on the server, ranging from Bionic to Eoan, with the same
  results with all of them.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1848556/+subscriptions

