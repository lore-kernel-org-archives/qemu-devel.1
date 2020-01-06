Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24FC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 07:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D05215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 07:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D05215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioN5n-0008Ga-Sy
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 02:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ioN56-0007qJ-Aa
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 02:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ioN54-0005yq-S3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 02:45:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:56388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ioN54-0005xy-MZ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 02:45:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ioN53-0003Y3-5G
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 07:45:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 16D802E80C8
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 07:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jan 2020 07:39:45 -0000
From: Fabian Godehardt <1856837@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm gcc9.2 segfault
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fgodeh pmaydell
X-Launchpad-Bug-Reporter: Fabian Godehardt (fgodeh)
X-Launchpad-Bug-Modifier: Fabian Godehardt (fgodeh)
References: <157666594314.15384.3778802807711797985.malonedeb@wampee.canonical.com>
Message-Id: <157829638549.28004.14832998592685884564.malone@chaenomeles.canonical.com>
Subject: [Bug 1856837] Re: qemu 4.2.0 arm  segmentation fault with gcc 9.2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 88b6b6f469a104b7d359e7bc3a9627fb15bd02b9
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

Sorry for the delay. I added the sysroot, the binary and the files causing =
the segfault.
Please let me know if there is something missing.

I used the following commands to let it run:

export LD_LIBRARY_PATH=3D/opt/qemu-test/test1/lib
/opt/qemu-test/test1/bin/qemu-arm "/opt/qemu-test/test1/files/mksnapshot.ar=
m" --log-snapshot-positions --logfile "/tmp/snapshot.log" --random-seed 314=
159265 "/tmp/snapshot.cc"


Thanks again!
Fabian

** Attachment added: "Tarball containing sysroot, qemu binary and files"
   https://bugs.launchpad.net/qemu/+bug/1856837/+attachment/5317851/+files/=
qemu-segfault-v8.tar.xz

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

