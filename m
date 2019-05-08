Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA31C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479772173B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479772173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=quantentunnel.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQvc-0002qI-Hc
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 14:04:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOQsK-0001A7-7a
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOQsI-0007hf-CH
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:01:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:39302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hOQsH-0007fk-Cx
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:01:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hOQsF-0000d6-TX
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 18:00:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DBEA72E8041
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 18:00:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 May 2019 17:54:19 -0000
From: Frederick Metzengerstein <merak@quantentunnel.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: metzengerstein
X-Launchpad-Bug-Reporter: Frederick Metzengerstein (metzengerstein)
X-Launchpad-Bug-Modifier: Frederick Metzengerstein (metzengerstein)
References: <155733764243.16739.6026352756192984678.malonedeb@gac.canonical.com>
Message-Id: <155733806029.20754.8771334243558515890.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18961";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: af359bf9268d44e11010f554dbbe2bac2cdd42bf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Wed, 08 May 2019 14:01:15 -0400
Subject: [Qemu-devel] [Bug 1828272] Re: 4.0 breaks keyboard autorepeat in
 guests with xserver
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
Reply-To: Bug 1828272 <1828272@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  Description:
  In a linux/bsd guest within X, pressing and holding a key for a short tim=
e causes an endless repeat of that key in the guest. The release of the key=
 gets ignored.
  Example 1: pressing and holding 'a' for a few seconds results in typing o=
f 'aaaaaaaaaaaa...' endlessly.
  Example 2: pressing and holding 'Backspace' for a few seconds results in =
deleting all your previously typed text.
  =

  It doesn't happen within a VT in the guest. It also doesn't happen with
  guests that run windows, reactos or haiku for example.
  =

  The problem goes away, when disabling xorgs autorepeat function via "xset=
 -r" in the host.
  Normally, this setting should not have any effect on the guest, since it =
has it's own autorepeat setting. So there is some conflict here.
  =

  Steps to reproduce:
  Start any linux/bsd guest system with xserver, open a terminal, press and=
 hold a key for a short time: Look how it gets typed endlessly (Try a few t=
imes if it doesn't happen immediately).
  The easiest way is to run a linux live cd, like this (Link to example iso=
 :http://download.grml.org/grml64-full_2018.12.iso)
- $ qemu-system-x86_64 -enable-kvm -m 512 -boot d -cdrom grml64-full_2018.1=
2.iso
+ $ qemu-system-x86_64 -enable-kvm -m 512 -net none -boot d -cdrom grml64-f=
ull_2018.12.iso
  =

  Qemu version info:
  QEMU emulator version 4.0.0
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
  =

  System info:
  Linux **** 5.0.13-arch1-1-ARCH #1 SMP PREEMPT Sun May 5 18:05:41 UTC 2019=
 x86_64 GNU/Linux

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1828272

Title:
  4.0 breaks keyboard autorepeat in guests with xserver

Status in QEMU:
  New

Bug description:
  Description:
  In a linux/bsd guest within X, pressing and holding a key for a short tim=
e causes an endless repeat of that key in the guest. The release of the key=
 gets ignored.
  Example 1: pressing and holding 'a' for a few seconds results in typing o=
f 'aaaaaaaaaaaa...' endlessly.
  Example 2: pressing and holding 'Backspace' for a few seconds results in =
deleting all your previously typed text.

  It doesn't happen within a VT in the guest. It also doesn't happen
  with guests that run windows, reactos or haiku for example.

  The problem goes away, when disabling xorgs autorepeat function via "xset=
 -r" in the host.
  Normally, this setting should not have any effect on the guest, since it =
has it's own autorepeat setting. So there is some conflict here.

  Steps to reproduce:
  Start any linux/bsd guest system with xserver, open a terminal, press and=
 hold a key for a short time: Look how it gets typed endlessly (Try a few t=
imes if it doesn't happen immediately).
  The easiest way is to run a linux live cd, like this (Link to example iso=
 :http://download.grml.org/grml64-full_2018.12.iso)
  $ qemu-system-x86_64 -enable-kvm -m 512 -net none -boot d -cdrom grml64-f=
ull_2018.12.iso

  Qemu version info:
  QEMU emulator version 4.0.0
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  System info:
  Linux **** 5.0.13-arch1-1-ARCH #1 SMP PREEMPT Sun May 5 18:05:41 UTC 2019=
 x86_64 GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1828272/+subscriptions

