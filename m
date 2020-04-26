Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65069C55191
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 08:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388282071C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 08:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388282071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSclt-0003Zz-6r
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 04:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jSbkw-0000zQ-5j
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jSbkr-0005TD-Pw
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:31:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:36978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jSbkr-0005MC-9I
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 03:31:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jSbkp-0003ZT-Mf
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2020 07:31:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AA0982E80E7
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2020 07:31:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2020 07:17:47 -0000
From: chenhao <563278383@qq.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 563278383-t duanev miki4242 mkdolata vvaltchev
X-Launchpad-Bug-Reporter: Alain Kalker (miki4242)
X-Launchpad-Bug-Modifier: chenhao (563278383-t)
References: <20170425183112.19801.4371.malonedeb@soybean.canonical.com>
Message-Id: <158788546766.17636.572314808145068160.malone@wampee.canonical.com>
Subject: [Bug 1686170] Re: qemu-system-x86_64+gdb: unable to correctly
 disassemble "real mode" (i8086) instructions after attaching to QEMU started
 with "-S -s" options
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4e8f82b037f803277bb2e3e472b9d85e9d97757d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 03:30:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sun, 26 Apr 2020 04:35:31 -0400
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
Reply-To: Bug 1686170 <1686170@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I had the same problem when I tried to run
[boot.asm](https://github.com/yifengyou/The-design-and-implementation-
of-a-64-bit-os/blob/master/code/c03/1/boot.asm).

i tested `qemu-system-x86_64` and `qemu-system-i386` with
[gdb_init_real_mode.txt](https://github.com/mhugo/gdb_init_real_mode/blob/m=
aster/gdbinit_real_mode.txt)
and
[target.xml](https://gist.githubusercontent.com/MatanShahar/1441433e19637cf=
1bb46b1aa38a90815/raw/2687fb5daf60cf6aa8435efc8450d89f1ccf2205/target.xml),
all faild.

my env:
1. deepin 15.11 x86_64

    - qemu: QEMU emulator version 4.2.94 // qemu 5.0.0-rc4
    - gdb: GNU gdb (Debian 7.12-6) 7.12.0.20161007-git
1. ubuntu 20.04

    - qemu: QEMU emulator version 4.2.0 (Debian 1:4.2-3ubuntu6)
    - gdb: GNU gdb (Ubuntu 9.1-0ubuntu1) 9.1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686170

Title:
  qemu-system-x86_64+gdb: unable to correctly disassemble "real mode"
  (i8086) instructions after attaching to QEMU started with "-S -s"
  options

Status in QEMU:
  New

Bug description:
  OS: Void Linux x86_64 (glibc)
  QEMU version: 2.9.0
  GDB version: 7.12.1

  Problem description:

  After I updated QEMU from version 2.8.1 to 2.9.0, I found that when I try=
 to connect GDB to a running QEMU and try to debug Real mode machine code, =
I can no longer set architecture to 'i8086'.
  To be able to connect to QEMU from GDB at all, I have to specify one of t=
he 64 bit architectures, which among other things leads to incorrect disass=
embly listings. This makes debugging Real mode bootloaders, bootsectors and=
 BIOS code much more difficult.

  Steps to reproduce:

  - Run QEMU
  - In another terminal, run GDB
  - In GDB, connect to QEMU
  - In GDB, disassemble some Real mode machine code.

  Expected results (from QEMU version 2.8.1):

      [terminal #1]
      $ qemu-system-x86_64 -S -s

      [terminal #2]
      (gdb) set architecture i8086
      warning: A handler for the OS ABI "GNU/Linux" is not built =

      into this configuration
      of GDB.  Attempting to continue with the default i8086 settings.

      The target architecture is assumed to be i8086
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      0x0000fff0 in ?? ()
      (gdb) x/i $cs*16+$eip
         0xffff0:	ljmp   $0xf000,$0xe05b

  Actual results:

      [terminal #1]
      $ qemu-system-x86_64 -S -s

      [terminal #2]
      $ gdb -q
      (gdb) set architecture i8086 =

      warning: A handler for the OS ABI "GNU/Linux" is not built into this =
configuration
      of GDB.  Attempting to continue with the default i8086 settings.

      The target architecture is assumed to be i8086
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      Remote 'g' packet reply is too long: =

      [..snip..]

  Workarounds tried:

    - Try different architecures
      (gdb) set architecture i386:intel
      The target architecture is assumed to be i386:intel
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      Remote 'g' packet reply is too long: =

      [..snip..]
      (gdb) set architecture i386:x86-64
      The target architecture is assumed to be i386:x86-64
      (gdb) target remote :1234
      Remote debugging using :1234
      warning: No executable has been specified and target does not support
      determining executable automatically.  Try using the "file" command.
      0x000000000000fff0 in ?? ()

  The last try finally allowed me to connect to QEMU, but as can be
  expected from using an incorrect architecture setting, disassembly
  output is complete gibberish:

      (gdb) x/10i $cs*16+$rip
         0xffff0:	(bad)  =

         0xffff1:	pop    %rbx
         0xffff2:	loopne 0xffff4
         0xffff4:	lock xor %dh,(%rsi)
         0xffff7:	(bad)  =

         0xffff8:	xor    (%rbx),%dh
         0xffffa:	(bad)  =

         0xffffb:	cmp    %edi,(%rcx)
         0xffffd:	add    %bh,%ah
         0xfffff:	add    %al,(%rax)

  Discussion:

  I think I've traced the problem to the following commit: "x86: Fix x86_64=
 'g' packet response to gdb from 32-bit mode."[1].
  While I admire the effort to make life for people using GDB to debug QEMU=
 VMs, I think the problem here is with GDB and can't be fixed entirely from=
 the side of QEMU without breaking other features.

  In fact, there is a well-known workaround to this problem published on
  OSDev Wiki (Workaround #1)[2] which doesn't require patching either
  QEMU or GDB. This workaround has worked for me using several previous
  versions of QEMU.

      $ gdb -q
      (gdb) set architecture i8086
      (gdb) target remote :1234
      (gdb) break some_breakpoint_in_32_bit_or_64_bit_code
      (gdb) continue
      [...]
      Remote 'g' packet reply is too long: [...]
      (gdb) disconnect # IMPORTANT STEP #1
      (gdb) set architecture i386:x86-64
      (gdb) target remote :1234 # IMPORTANT STEP #2
      (gdb) continue

  [1]: http://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3De3592bc9d841c397eed=
a87f0019fab94ff71004b
  [2]: http://wiki.osdev.org/QEMU_and_GDB_in_long_mode#Workaround_1:_Reconn=
ecting

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686170/+subscriptions

