Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB175C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FBD206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FBD206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcDX9-0003Bt-3W
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 15:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcDV4-0002ch-RX
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:10:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:49166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kcDV0-0004lJ-Ji
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:10:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kcDUx-0008Q1-Hf
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 20:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 840A92E800F
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 20:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 20:03:13 -0000
From: Peter Maydell <1706296@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee bonzini dgilbert-h pmaydell
 programmingkidx rjones-redhat th-huth
X-Launchpad-Bug-Reporter: Richard Jones (rjones-redhat)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
Message-Id: <160495219335.13610.14775335763532384194.malone@gac.canonical.com>
Subject: [Bug 1706296] Re: Booting NT 4 disk causes
 /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed:
 (!qemu_mutex_iothread_locked())
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 4b627e8b8356d503fb6eadd46f72d2dd7150284b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 11:16:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1706296 <1706296@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

commit 8b81253332b5a3f claims in its subject line that it "fixes
#1706296", and it implements Paolo's option (2) from comment #4. So I'd
go with "already fixed". The bug has a simple reproducer in the report
though, so it's also easy to test...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1706296

Title:
  Booting NT 4 disk causes
  /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion
  failed: (!qemu_mutex_iothread_locked())

Status in QEMU:
  Incomplete

Bug description:
  Grab the NT 4 disk from
  https://archive.org/details/Microsoft_Windows_NT_Server_Version_4.0_227-0=
75
  -385_CD-KEY_419-1343253_1996

  Try to boot it as follows:

  qemu-system-x86_64 -hda disk.img -cdrom Microsoft_Windows_NT_Server_Versi=
on_4.0_227-075-385_CD-KEY_419-1343253_1996.iso -m 2048 -boot d -machine pc,=
accel=3Dtcg
  WARNING: Image format was not specified for 'disk.img' and probing guesse=
d raw.
           Automatically detecting the format is dangerous for raw images, =
write operations on block 0 will be restricted.
           Specify the 'raw' format explicitly to remove the restrictions.
  **
  ERROR:/home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion=
 failed: (!qemu_mutex_iothread_locked())
  Aborted (core dumped)

  The stack trace in the failing thread is:

  Thread 4 (Thread 0x7fffb0418700 (LWP 21979)):
  #0  0x00007fffdd89b64b in raise () at /lib64/libc.so.6
  #1  0x00007fffdd89d450 in abort () at /lib64/libc.so.6
  #2  0x00007fffdff8c75d in g_assertion_message () at /lib64/libglib-2.0.so=
.0
  #3  0x00007fffdff8c7ea in g_assertion_message_expr ()
      at /lib64/libglib-2.0.so.0
  #4  0x00005555557a7d00 in qemu_mutex_lock_iothread ()
      at /home/rjones/d/qemu/cpus.c:1580
  #5  0x00005555557cb429 in io_writex (env=3Denv@entry=3D0x555556751400, io=
tlbentry=3D0x55555675b678, =

      iotlbentry@entry=3D0x5aaaaae40c918, val=3Dval@entry=3D8, addr=3Daddr@=
entry=3D2148532220, retaddr=3D0, retaddr@entry=3D93825011136120, size=3Dsiz=
e@entry=3D4)
      at /home/rjones/d/qemu/accel/tcg/cputlb.c:795
  #6  0x00005555557ce0f7 in io_writel (retaddr=3D93825011136120, addr=3D214=
8532220, val=3D8, index=3D255, mmu_idx=3D21845, env=3D0x555556751400)
      at /home/rjones/d/qemu/softmmu_template.h:265
  #7  0x00005555557ce0f7 in helper_le_stl_mmu (env=3Denv@entry=3D0x55555675=
1400, addr=3Daddr@entry=3D2148532220, val=3Dval@entry=3D8, oi=3D<optimized =
out>, retaddr=3D93825011136120, retaddr@entry=3D0) at /home/rjones/d/qemu/s=
oftmmu_template.h:300
  #8  0x000055555587c0a4 in cpu_stl_kernel_ra (env=3D0x555556751400, ptr=3D=
2148532220, v=3D8, retaddr=3D0) at /home/rjones/d/qemu/include/exec/cpu_lds=
t_template.h:182
  #9  0x0000555555882610 in do_interrupt_protected (is_hw=3D<optimized out>=
, next_eip=3D<optimized out>, error_code=3D2, is_int=3D<optimized out>, int=
no=3D<optimized out>, env=3D0x555556751400) at /home/rjones/d/qemu/target/i=
386/seg_helper.c:758
  #10 0x0000555555882610 in do_interrupt_all (cpu=3Dcpu@entry=3D0x555556749=
170, intno=3D<optimized out>, is_int=3D<optimized out>, error_code=3D2, nex=
t_eip=3D<optimized out>, is_hw=3Dis_hw@entry=3D0) at /home/rjones/d/qemu/ta=
rget/i386/seg_helper.c:1252
  #11 0x00005555558839d3 in x86_cpu_do_interrupt (cs=3D0x555556749170)
      at /home/rjones/d/qemu/target/i386/seg_helper.c:1298
  #12 0x00005555557d2ccb in cpu_handle_exception (ret=3D<synthetic pointer>=
, cpu=3D0x5555566a4590) at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:465
  #13 0x00005555557d2ccb in cpu_exec (cpu=3Dcpu@entry=3D0x555556749170)
      at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:670
  #14 0x00005555557a855a in tcg_cpu_exec (cpu=3D0x555556749170)
      at /home/rjones/d/qemu/cpus.c:1270
  #15 0x00005555557a855a in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out=
>)
      at /home/rjones/d/qemu/cpus.c:1365
  #16 0x00007fffddc3d36d in start_thread () at /lib64/libpthread.so.0
  #17 0x00007fffdd975b9f in clone () at /lib64/libc.so.6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1706296/+subscriptions

