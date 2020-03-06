Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C73AC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A0C2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A0C2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACIe-0005xZ-BP
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jACHh-00055j-GB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jACHf-0000HB-Bt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:40:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:42054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jACHd-0000CO-EQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:40:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jACHa-0001LQ-Fp
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 12:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7683C2E80C3
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 12:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Mar 2020 12:32:47 -0000
From: Gerd Hoffmann <1863023@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kraxel-redhat yifanlu
X-Launchpad-Bug-Reporter: Yifan (yifanlu)
X-Launchpad-Bug-Modifier: Gerd Hoffmann (kraxel-redhat)
References: <158154403075.14879.10753031266357045514.malonedeb@soybean.canonical.com>
Message-Id: <158349796809.11926.16006452736724629765.malone@soybean.canonical.com>
Subject: [Bug 1863023] Re: Deadlock in QXL
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e8a849f859ce107448660abfd3cbd271ff93a4c0
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
Reply-To: Bug 1863023 <1863023@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any change if you remove the graphic_hw_update() call in
qxl_enter_vga_mode()?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863023

Title:
  Deadlock in QXL

Status in QEMU:
  New

Bug description:
  This is on qemu 4.2.0 OSX host, running fresh Windows 7 with SPICE
  guest tools just installed.

  Command line: `qemu-system-x86_64 -qmp
  tcp:localhost:4444,server,nowait -smp cpus=3D2 -boot order=3Dd -m 2048
  -soundhw hda -drive file=3Dhda.img,if=3Dide,media=3Ddisk -spice
  port=3D5930,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff
  ,playback-compression=3Doff,streaming-video=3Doff -vga qxl -device
  rtl8139,netdev=3Dnet0 -netdev user,id=3Dnet0`

  After the Windows logo, the screen is black. I dump the two vCPU
  threads:

  ```
  * thread #16
    * frame #0: 0x00007fff523b8ce6 libsystem_kernel.dylib`__psynch_cvwait +=
 10
      frame #1: 0x00007fff52467185 libsystem_pthread.dylib`_pthread_cond_wa=
it + 701
      frame #2: 0x0000000110bf88bd qemu-system-x86_64`qemu_cond_wait_impl(c=
ond=3D0x000000011121e8d0, mutex=3D0x000000011120ba48, file=3D"cpus-common.c=
", line=3D144) at qemu-thread-posix.c:173:11 [opt]
      frame #3: 0x0000000110926a59 qemu-system-x86_64`do_run_on_cpu(cpu=3D<=
unavailable>, func=3D<unavailable>, data=3D<unavailable>, mutex=3D0x0000000=
11120ba48) at cpus-common.c:144:9 [opt]
      frame #4: 0x000000011080c50a qemu-system-x86_64`memory_region_snapsho=
t_and_clear_dirty at memory.c:2595:5 [opt]
      frame #5: 0x000000011080c4d7 qemu-system-x86_64`memory_region_snapsho=
t_and_clear_dirty(mr=3D<unavailable>, addr=3D0, size=3D2359296, client=3D<u=
navailable>) at memory.c:2107 [opt]
      frame #6: 0x0000000110849fe1 qemu-system-x86_64`vga_update_display [i=
nlined] vga_draw_graphic(s=3D<unavailable>, full_update=3D0) at vga.c:1661:=
16 [opt]
      frame #7: 0x000000011084996a qemu-system-x86_64`vga_update_display(op=
aque=3D<unavailable>) at vga.c:1785 [opt]
      frame #8: 0x00000001109b261d qemu-system-x86_64`qxl_hard_reset(d=3D0x=
00007f84f8730000, loadvm=3D0) at qxl.c:1285:5 [opt]
      frame #9: 0x000000011080ac97 qemu-system-x86_64`memory_region_write_a=
ccessor(mr=3D0x00007f84f8741fb0, addr=3D5, value=3D<unavailable>, size=3D1,=
 shift=3D<unavailable>, mask=3D<unavailable>, attrs=3DMemTxAttrs @ 0x000070=
000786d890) at memory.c:483:5 [opt]
      frame #10: 0x000000011080ab31 qemu-system-x86_64`memory_region_dispat=
ch_write [inlined] access_with_adjusted_size(addr=3D<unavailable>, value=3D=
0x00000000015c6100, size=3D<unavailable>, access_size_min=3D<unavailable>, =
access_size_max=3D<unavailable>, access_fn=3D<unavailable>, mr=3D<unavailab=
le>, attrs=3D<unavailable>) at memory.c:544:18 [opt]
      frame #11: 0x000000011080aafd qemu-system-x86_64`memory_region_dispat=
ch_write(mr=3D<unavailable>, addr=3D<unavailable>, data=3D22831360, op=3D32=
644, attrs=3DMemTxAttrs @ 0x000070000786d8c0) at memory.c:1475 [opt]
      frame #12: 0x00000001107b080d qemu-system-x86_64`address_space_stb(as=
=3D<unavailable>, addr=3D<unavailable>, val=3D22831360, attrs=3DMemTxAttrs =
@ r12, result=3D0x0000000000000000) at memory_ldst.inc.c:378:13 [opt]
      frame #13: 0x0000000118570230

  * thread #18
    * frame #0: 0x00007fff523b8ce6 libsystem_kernel.dylib`__psynch_cvwait +=
 10
      frame #1: 0x00007fff52467185 libsystem_pthread.dylib`_pthread_cond_wa=
it + 701
      frame #2: 0x0000000110bf88bd qemu-system-x86_64`qemu_cond_wait_impl(c=
ond=3D0x000000011121e860, mutex=3D0x000000011121e818, file=3D"cpus-common.c=
", line=3D196) at qemu-thread-posix.c:173:11 [opt]
      frame #3: 0x0000000110926c44 qemu-system-x86_64`start_exclusive at cp=
us-common.c:196:9 [opt]
      frame #4: 0x0000000110837c35 qemu-system-x86_64`cpu_exec_step_atomic(=
cpu=3D0x00007f8518290000) at cpu-exec.c:265:9 [opt]
      frame #5: 0x00000001107fcf95 qemu-system-x86_64`qemu_tcg_cpu_thread_f=
n(arg=3D0x00007f8518290000) at cpus.c:1799:17 [opt]
      frame #6: 0x0000000110bf911e qemu-system-x86_64`qemu_thread_start(arg=
s=3D<unavailable>) at qemu-thread-posix.c:519:9 [opt]
      frame #7: 0x00007fff52466e65 libsystem_pthread.dylib`_pthread_start +=
 148
      frame #8: 0x00007fff5246283b libsystem_pthread.dylib`thread_start + 15
  ```

  Seems like thread #16 had a STB to QXL MMIO registers which caused it
  to call `qxl_hard_reset` and eventually made its way to
  `do_run_on_cpu` which waits for `qemu_work_cond`. The only way
  `qemu_work_cond` is set is if one of the two vCPU executes the queued
  work at the end of the TCG execution. Thread #16 is stuck waiting, so
  what about thread #18? Thread #18 is waiting for `exclusive_cond`
  which is set once all the other CPUs are done running (but thread #16
  is waiting still). So classic deadlock.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863023/+subscriptions

