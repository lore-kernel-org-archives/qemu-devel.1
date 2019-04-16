Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8659C282DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD238222B2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD238222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOVk-0006A4-RU
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:52:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGOTt-0004ro-BQ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGOTs-0003z1-3k
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:35654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGOTr-0003xr-Sr
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGOTq-0000Gg-If
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 13:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8C2762E80C0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 13:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 13:44:51 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: multithreading raspberry tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell timemaster5
X-Launchpad-Bug-Reporter: TimeMaster (timemaster5)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155531602468.14046.8896369782282114161.malonedeb@gac.canonical.com>
Message-Id:
 <155542229151.14327.13184512347374441450.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2b461ef0a56d7a372f60caf2498645e205d0c5b0
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
Message-ID: <20190416134451.s-V2cc_GceYOpYp0My8GlOt2739Tg1vdubOdFHsH6SY@z>

This is expected. The warning from QEMU is telling you that MTTCG is not
supported for the combination of an Arm host and an x86 guest. It warns
that you might see "strange errors", and indeed you saw an error. Don't
try to use MTTCG here.

I think this warning should probably just be an error -- QEMU shouldn't
allow the user to select a feature which we know is not going to work
reliably.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824768

Title:
  Qemu ARMv7 TCG MultiThreading for i386 guest doesn't work

Status in QEMU:
  New

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

