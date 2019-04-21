Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246EAC10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 19:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C0520870
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 19:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C0520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56545 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIIZe-0006eE-1V
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 15:56:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIIYp-0006In-0A
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 15:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIIYn-0001n8-Ug
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 15:55:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:52742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIIYn-0001mq-PR
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 15:55:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIIYm-0004Sz-Nc
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 19:55:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 93C882E805D
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 19:55:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Apr 2019 19:48:48 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: multithreading raspberry tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell rth timemaster5
X-Launchpad-Bug-Reporter: TimeMaster (timemaster5)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <155531602468.14046.8896369782282114161.malonedeb@gac.canonical.com>
Message-Id:
 <155587612901.7202.10344473436376690538.launchpad@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d0db510777dfbd4dffedb08e07728ea2df2d914c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1824768] Re: Qemu ARMv7 TCG MultiThreading for
 i386 guest doesn't work
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1824768 <1824768@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421194848.wrLgGbEGvLHTwnsodWNrxJLcwHQwrAuSUROh0cBumyM@z>

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824768

Title:
  Qemu ARMv7 TCG MultiThreading for i386 guest doesn't work

Status in QEMU:
  Incomplete

Bug description:
  Using any Linux image (in this case Alpine Linux iso) I want to
  utilise all cores of my Raspberry with --accel,thread=3Dmulti. I know
  there is a probably still problem with memory ordering of the host,
  but I have also seen some very old commits which could potentially
  help with it.

  But anyway, with version qemu-i386 version 3.1.0 (Debian 1:3.1+dfsg-7)
  I can see OpenRC starting up services and then the kernel crash.

  With version QEMU emulator version 3.1.93 (v4.0.0-rc3-dirty)
  The whole machine crash with this error:
  Illegal instruction

  Using command:
  ./qemu-system-i386 -cdrom alpine.iso --accel tcg,thread=3Dmulti

  Full Console Output:
  qemu-system-i386: warning: Guest expects a stronger memory ordering than =
the host provides
  This may cause strange/hard to debug errors
  Illegal instruction

  Kernel:
  Linux raspberrypi 4.14.98-v7+ #1200 SMP Tue Feb 12 20:27:48 GMT 2019 armv=
7l GNU/Linux

  CPU:
  ARMv7 Processor rev 5 (v7l)
  Features: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt v=
fpd32 lpae evtstrm
  4 cores

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824768/+subscriptions

