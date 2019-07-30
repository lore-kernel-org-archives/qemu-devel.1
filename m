Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6DAC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7812087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7812087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQIN-0000iY-Gh
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52456)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hsQGE-0004pl-SK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hsQGD-0007N7-LF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:44772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hsQGD-0007MP-F6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:25:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hsQGC-0005bt-E3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 11:25:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 65F7B2E804C
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 11:25:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jul 2019 11:19:07 -0000
From: =?utf-8?b?RWxvdWFuIEFwcMOpcsOp?= <1838277@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: elouan-appere pmaydell
X-Launchpad-Bug-Reporter: =?utf-8?q?Elouan_App=C3=A9r=C3=A9_=28elouan-apper?=
 =?utf-8?q?e=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Elouan_App=C3=A9r=C3=A9_=28elouan-apper?=
 =?utf-8?q?e=29?=
References: <156441235921.17753.6613889826588806043.malonedeb@gac.canonical.com>
Message-Id: <156448554711.10327.14717048835632191041.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 14de2f18c468554e038a106631f0ca8257dddbbb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838277] Re: qemu-system-aarch64: regression: TCG
 sometimes using wrong values for VBAR_EL2 despite it being correctly
 reported to GDB
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
Reply-To: Bug 1838277 <1838277@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> For me that test binary seems to work (with a QEMU built from upstream
git commit 893dc8300c80e3dc32f3) : at least it boots and prints various
messages ending with "Hello from Thermosphere!"

my bad, I wasn't precise enough. Right now, test binary should display a
crash dump (=3D> exceptions.c) following __builtin_trap() but doesn't.

Here is what happens:

Expected behavior: code steps into $VBAR_EL2+0x200, $VBAR_EL2 being reporte=
d to be its expected value
Actual behavior: code steps into 0+0x200

(gdb) disas
Dump of assembler code for function main:
   0x00000000600000e8 <+0>:     ldr     w1, [x18, #16]
   0x00000000600000ec <+4>:     str     x30, [sp, #-16]!
   0x00000000600000f0 <+8>:     cbnz    w1, 0x60000110 <main+40>
   0x00000000600000f4 <+12>:    mov     w0, #0xc200                     // =
#49664
   0x00000000600000f8 <+16>:    movk    w0, #0x1, lsl #16
   0x00000000600000fc <+20>:    bl      0x60000d10 <uartInit>
   0x0000000060000100 <+24>:    adrp    x0, 0x60001000 <unknown_exception>
   0x0000000060000104 <+28>:    add     x0, x0, #0x8be
   0x0000000060000108 <+32>:    bl      0x60000128 <serialLog>
=3D> 0x000000006000010c <+36>:    brk     #0x3e8
   0x0000000060000110 <+40>:    adrp    x0, 0x60001000 <unknown_exception>
   0x0000000060000114 <+44>:    add     x0, x0, #0x8d8
   0x0000000060000118 <+48>:    bl      0x60000128 <serialLog>
   0x000000006000011c <+52>:    mov     w0, #0x0                        // =
#0
   0x0000000060000120 <+56>:    ldr     x30, [sp], #16
   0x0000000060000124 <+60>:    ret
End of assembler dump.
(gdb) stepi
^C
Thread 1 received signal SIGINT, Interrupt.
0x0000000000000200 in ?? ()
(gdb) p $VBAR_EL2
$10 =3D 0x60001000

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838277

Title:
  qemu-system-aarch64: regression: TCG sometimes using wrong values for
  VBAR_EL2 despite it being correctly reported to GDB

Status in QEMU:
  New

Bug description:
  Affects 3.1.0 (latest stable release) and latest commit
  (893dc8300c80e3dc32f31e968cf7aa0904da50c3) but did *not* affect 2.11
  (qemu from bionic ubuntu LTS).

  With the following code and shell commands:

  test.s:

  .text
  mov x0, #0x60000000
  msr vbar_el2, x0
  dsb sy
  isb sy

  $ aarch64-none-elf-as test.s -o test.o
  $ aarch64-none-elf-objcopy -S -O binary test.o test.bin
  $ qemu-system-aarch64 -nographic -machine virt,virtualization=3Don -cpu c=
ortex-a57 -kernel test.bin -s -S

  vbar_el2 is still 0 after the code, instead of being the expected
  0x60000000. (see screenshot).

  This regression doesn't seem to happen for vbar_el1 &
  virtualization=3Doff.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838277/+subscriptions

