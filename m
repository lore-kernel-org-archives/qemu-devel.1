Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FAEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387A221D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387A221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZ6G-0000yA-FE
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1itZ5X-0000Eh-Iy
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1itZ5T-0001KT-R4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:35:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:46226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1itZ5T-0001Jo-L3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:35:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1itZ5R-00077e-SX
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:35:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D55B02E80CD
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:35:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jan 2020 15:26:28 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm gcc9.2 segfault
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fgodeh pmaydell
X-Launchpad-Bug-Reporter: Fabian Godehardt (fgodeh)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <157666594314.15384.3778802807711797985.malonedeb@wampee.canonical.com>
Message-Id: <157953398861.24612.16671820632562065829.malone@chaenomeles.canonical.com>
Subject: [Bug 1856837] Re: qemu 4.2.0 arm  segmentation fault with gcc 9.2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f1052173880d8dae43faa7c2fc45da1b42227143";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1783b07db55f9fcb9987db49b9190eb4124d351f
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
Reply-To: Bug 1856837 <1856837@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the point of the segfault, QEMU is correctly delivering a segfault to
the guest because it has attempted to dereference a NULL pointer. You
can see this if you run QEMU with the '-g 1234' option and connect an
arm-aware gdb to it:

(gdb) disas $pc-32,$pc+32
Dump of assembler code from 0x2bf24c to 0x2bf28c:
   0x002bf24c:  ldr     r4, [r0, #296]  ; 0x128
   0x002bf250:  mov     r6, r1
   0x002bf254:  add     r8, r0, #40     ; 0x28
   0x002bf258:  mov     r5, #0
   0x002bf25c:  b       0x2bf268
   0x002bf260:  cmp     r5, r6
   0x002bf264:  bge     0x2bf2d4
   0x002bf268:  mov     r12, r4
=3D> 0x002bf26c:  ldr     r4, [r4]
   0x002bf270:  ldr     r3, [r12, #12]
   0x002bf274:  tst     r3, #512        ; 0x200
   0x002bf278:  bne     0x2bf2c0
   0x002bf27c:  tst     r3, #1024       ; 0x400
   0x002bf280:  ubfx    r1, r3, #11, #1
   0x002bf284:  bne     0x2bf2c0
   0x002bf288:  tst     r3, #2048       ; 0x800
End of assembler dump.
(gdb) print /x $r4
$3 =3D 0x0

It looks like this is in the middle of somebody's garbage collector (the
elf symbol is _ZN2v88internal10PagedSpace14AdvanceSweeperEi).

The next step would be to find out what was going on in the run-up to
that that resulted in the NULL pointer. That's a bit of guest-level
debugging work that would be much easier with the source code. If you
can debug where something unexpected happens to the guest that would
probably help -- this is likely to be a much longer piece of debugging
than I'm afraid I have time to do.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856837

Title:
  qemu 4.2.0 arm  segmentation fault with gcc 9.2

Status in QEMU:
  New

Bug description:
  As discussed with f4bug yesterday on IRC here comes the bug
  description.

  I'm building/configured qemu-4.2.0 on an x86_64 (gcc (Debian
  6.3.0-18+deb9u1) 6.3.0 20170516) with target-list "arm-softmmu,arm-
  linux-user" and debug enabled. I use the arm-linux-user variant,
  "qemu-arm".

  Then i'm trying to cross-compile (arm gcc) an old version of googles
  v8 (as i need this version of the lib for binary compatibility) which
  uses qemu during build.

  It worked with gcc 5.4.0 but not with 9.2.0. I also tried with 6.5.0,
  7.4.0 and 8.3.0 but those are also causing the same segmentation
  fault.

  The executed command wich breaks qemu is:

   qemu-arm /tmp/build/out/arm.release/mksnapshot.arm --log-snapshot-
  positions --logfile
  /tmp/build/out/arm.release/obj.host/v8_snapshot/geni/snapshot.log
  --random-seed 314159265 /tmp/build/out/arm.release/obj.host/v8_snap

  The printed error message is:

  ARMv7=3D1 VFP3=3D1 VFP32DREGS=3D1 NEON=3D0 SUDIV=3D0 UNALIGNED_ACCESSES=
=3D1 MOVW_MOVT_IMMEDIATE_LOADS=3D0 USE_EABI_HARDFLOAT=3D1
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  Calling qemu with gdb gives the following information:

   Thread 1 "qemu-arm" received signal SIGSEGV, Segmentation fault.
   0x0000555555d63d11 in static_code_gen_buffer ()

  and

   (gdb) bt
   #0  0x0000555555d63d11 in static_code_gen_buffer ()
   #1  0x0000555555628d58 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D0x55=
5557c33930) at =

   /tmp/build/qemu/accel/tcg/cpu-exec.c:172
   #2  cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>, last_tb=3D<syntheti=
c pointer>, tb=3D<optimized out>, =

   cpu=3D0x555557c33930) at /tmp/build/qemu/accel/tcg/cpu-exec.c:618
   #3  cpu_exec (cpu=3Dcpu@entry=3D0x555557c2b660) at /tmp/build/qemu/accel=
/tcg/cpu-exec.c:731
   #4  0x0000555555661578 in cpu_loop (env=3D0x555557c33930) at /tmp/build/=
qemu/linux-user/arm/cpu_loop.c:219
  #5  0x00005555555d6d76 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at /tmp/build/qemu/linux-user/main.c:865

  Calling qemu-arm with debug switch "-d in_asm,int,op_opt" shows the
  log in the attached file.

  Thanks for any hints!
  Fabian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856837/+subscriptions

