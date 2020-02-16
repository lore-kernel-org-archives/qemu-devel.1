Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37396C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 18:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0540F20857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 18:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0540F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3OF8-0005z2-3Q
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 13:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j3OE2-0005Vg-6Y
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j3OE0-0002g9-Mi
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:01:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:32990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j3OE0-0002aU-Cq
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:01:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j3ODx-000497-Sk
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 18:00:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D65482E80C0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 18:00:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Feb 2020 17:55:04 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1863486@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158187215227.14879.6112716414047440782.malonedeb@soybean.canonical.com>
Message-Id: <158187570483.30895.800794268964862185.malone@wampee.canonical.com>
Subject: [Bug 1863486] Re: aarch64/tcg crash with malloc(): unsorted double
 linked list corrupted
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e8f6a09d86bf30a03a0653252ff742e91f07dcf9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1863486 <1863486@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maybe the same problem we had with U-boot, the SoC starts with only 1
core enabled.

I'm now trying with `-global bcm2836.enabled-cpus=3D1`.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863486

Title:
  aarch64/tcg crash with malloc(): unsorted double linked list corrupted

Status in QEMU:
  New

Bug description:
  Based on commit b29c3e23f64938784c42ef9fca896829e3c19120,
  QEMU configured with --enable-debug --extra-cflags=3D-ggdb.

  Download Raspberry Pi 3 UEFI Firmware v1.15 from:
  https://github.com/pbatard/RPi3/releases/tag/v1.15
  (unzip RPi3_UEFI_Firmware_v1.15.zip)

  Run QEMU with:

  $ qemu-system-aarch64 -M raspi3 \
    -serial null -serial stdio \
    -device loader,file=3DRPI_EFI.fd,force-raw=3Dtrue =


  Normal behavior:

  NOTICE:  Booting Trusted Firmware
  NOTICE:  BL1: v2.1(release):v2.1
  NOTICE:  BL1: Built : 15:26:06, May 13 2019
  NOTICE:  rpi3: Detected: Raspberry Pi 3 Model B (1GB, Sony, UK) [0x00a020=
82]
  NOTICE:  BL1: Booting BL2
  ERROR:   rpi3_sdhost: timeout status 0x40
  NOTICE:  BL2: v2.1(release):v2.1
  NOTICE:  BL2: Built : 15:26:01, May 13 2019
  NOTICE:  BL1: Booting BL31
  NOTICE:  BL31: v2.1(release):v2.1
  NOTICE:  BL31: Built : 15:26:04, May 13 2019
  =3DUEFI firmware (version UEFI Firmware v1.15 built at 11:58:44 on Feb 14=
 2020)
  =3D=3D=3D=3D=3D=3D=3D=3D

  Synchronous Exception at 0x0000000037A1A4E8

  But I sometimes get:

  NOTICE:  Booting Trusted Firmware
  NOTICE:  BL1: v2.1(release):v2.1
  NOTICE:  BL1: Built : 15:26:06, May 13 2019
  NOTICE:  rpi3: Detected: Raspberry Pi 3 Model B (1GB, Sony, UK) [0x00a020=
82]
  NOTICE:  BL1: Booting BL2
  ERROR:   rpi3_sdhost: timeout status 0x40
  NOTICE:  BL2: v2.1(release):v2.1
  NOTICE:  BL2: Built : 15:26:01, May 13 2019
  NOTICE:  BL1: Booting BL31
  NOTICE:  BL31: v2.1(release):v2.1
  NOTICE:  BL31: Built : 15:26:04, May 13 2019
  =3DUEFI firmware (version UEFI Firmware v1.15 built at 11:58:44 on Feb 14=
 2020)
  =3D=3D=3D=3D=3D=3D=3D=3Dmalloc(): unsorted double linked list corrupted

  Thread 3 "qemu-system-aar" received signal SIGABRT, Aborted.
  [Switching to Thread 0x7fffe9c22700 (LWP 22746)]
  0x00007ffff515ce35 in raise () from /lib64/libc.so.6
  (gdb) bt
  #0  0x00007ffff515ce35 in raise () at /lib64/libc.so.6
  #1  0x00007ffff5147895 in abort () at /lib64/libc.so.6
  #2  0x00007ffff51a008f in __libc_message () at /lib64/libc.so.6
  #3  0x00007ffff51a740c in  () at /lib64/libc.so.6
  #4  0x00007ffff51aa48c in _int_malloc () at /lib64/libc.so.6
  #5  0x00007ffff51aad4e in _int_memalign () at /lib64/libc.so.6
  #6  0x00007ffff51abdda in _mid_memalign () at /lib64/libc.so.6
  #7  0x00007ffff51ad3c6 in posix_memalign () at /lib64/libc.so.6
  #8  0x00007ffff7be2407 in slab_allocator_alloc_chunk () at /lib64/libglib=
-2.0.so.0
  #9  0x00007ffff7be3573 in g_slice_alloc () at /lib64/libglib-2.0.so.0
  #10 0x00007ffff7bf410a in g_tree_insert_internal () at /lib64/libglib-2.0=
.so.0
  #11 0x0000555555853f10 in tcg_tb_insert (tb=3D0x7fffd44b4d80 <code_gen_bu=
ffer+4934995>) at tcg/tcg.c:425
  #12 0x00005555558dbe3d in tb_gen_code (cpu=3D0x555556afa640, pc=3D9333329=
60, cs_base=3D0, flags=3D2216689664, cflags=3D-16252928) at accel/tcg/trans=
late-all.c:1875
  #13 0x00005555558d7c73 in tb_find (cpu=3D0x555556afa640, last_tb=3D0x7fff=
d44b4c40 <code_gen_buffer+4934675>, tb_exit=3D0, cf_mask=3D524288) at accel=
/tcg/cpu-exec.c:406
  #14 0x00005555558d8543 in cpu_exec (cpu=3D0x555556afa640) at accel/tcg/cp=
u-exec.c:730
  #15 0x00005555558981e1 in tcg_cpu_exec (cpu=3D0x555556afa640) at cpus.c:1=
405
  #16 0x0000555555898a37 in qemu_tcg_cpu_thread_fn (arg=3D0x555556afa640) a=
t cpus.c:1713
  #17 0x0000555556057af8 in qemu_thread_start (args=3D0x555557511570) at ut=
il/qemu-thread-posix.c:519
  #18 0x00007ffff52f34c0 in start_thread () at /lib64/libpthread.so.0
  #19 0x00007ffff5221163 in clone () at /lib64/libc.so.6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863486/+subscriptions

