Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218DFC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC7B214AF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC7B214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgNa-000235-54
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:22:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hNgM5-0001Iy-1M
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hNgM3-0002fF-VC
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:20:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:42412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hNgM3-0002eq-Pj
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:20:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hNgM2-0004NA-DC
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 16:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 606102E80CB
	for <qemu-devel@nongnu.org>; Mon,  6 May 2019 16:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 May 2019 16:09:31 -0000
From: felix <1827871@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: freeze reboot tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: felix.von.s
X-Launchpad-Bug-Reporter: felix (felix.von.s)
X-Launchpad-Bug-Modifier: felix (felix.von.s)
References: <155714332421.19976.6267811887776978448.malonedeb@gac.canonical.com>
Message-Id: <155715897136.31524.13391559380805176680.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18953";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 6c1c2bfd2d9230977a498b72ad9aa8e1cceb3a94
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1827871] Re: Race condition when rebooting with
 the TCG backend
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
Reply-To: Bug 1827871 <1827871@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Never mind, 0ec7e6779fc830e5b4e6a448d75317fafcf69477 fixed this.

This can be closed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1827871

Title:
  Race condition when rebooting with the TCG backend

Status in QEMU:
  New

Bug description:
  Reporting this as present in QEMU 3.1.0, although I don't see any
  commit in current git master
  (a6ae23831b05a11880b40f7d58e332c45a6b04f7) that would suggest this
  issue is fixed.

      $ uname -a
      Linux boole 4.19.0-4-686-pae #1 SMP Debian 4.19.28-2 (2019-03-15) i68=
6 GNU/Linux
      $ qemu -version
      QEMU emulator version 3.1.0 (Debian 1:3.1+dfsg-7)
      Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project develope=
rs

  Here's an excerpt from the code which handles reboot requests in
  SeaBIOS 1.12, located in src/fw/shadow.c:

      // Request a QEMU system reset.  Do the reset in this function as
      // the BIOS code was overwritten above and not all BIOS
      // functionality may be available.

      // Attempt PCI style reset
      outb(0x02, PORT_PCI_REBOOT);
      outb(0x06, PORT_PCI_REBOOT);

      // Next try triple faulting the CPU to force a reset
      asm volatile("int3");

  This compiles to the following:

      (qemu) x/10i 0xf1993
      0x000f1993:  b0 02                    movb     $2, %al
      0x000f1995:  ee                       outb     %al, %dx
      0x000f1996:  b0 06                    movb     $6, %al
      0x000f1998:  ee                       outb     %al, %dx
      0x000f1999:  cc                       int3     =

      0x000f199a:  80 3d 0d 53 0f 00 08     cmpb     $8, 0xf530d
      0x000f19a1:  75 52                    jne      0xf19f5
      0x000f19a3:  a1 10 53 0f 00           movl     0xf5310, %eax
      0x000f19a8:  8b 15 14 53 0f 00        movl     0xf5314, %edx
      0x000f19ae:  89 c3                    movl     %eax, %ebx

  Now, with the TCG backend, upon reaching the second outb instruction,
  the thread executing JIT-ed opcodes invokes
  qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET). This signals
  another thread to reset the guest CPU registers to their initial
  state. However, the execution thread is *not* stopped, which means it
  will keep executing already-translated instructions in the TCG buffer.
  In particular, the bootstrap value of the EIP register will be
  overwritten. On my machine, this usually results in the guest CPU
  finding itself in real mode, CS base 0xffff0000, EIP 0x0000199e, which
  in real mode disassembles to this:

      (qemu) xp/1i 0xf199e
      0x000f199e:  0f 00 08                 strw     0(%bx, %si)

  This instruction triggers a #UD exception, and given that SeaBIOS
  handles #UD by immediately returning, it manifests as the guest
  locking up with 100% CPU usage every other reboot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1827871/+subscriptions

