Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA04C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C111C2067B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 04:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C111C2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWr7-0006tQ-KX
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 23:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqJ-0005VZ-3S
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:38028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaWqG-0000At-UU
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 23:25:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaWqE-0002t7-MY
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A80042E8130
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 04:25:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2020 04:17:20 -0000
From: Launchpad Bug Tracker <1715715@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cbparker janitor mark-cave-ayland th-huth
X-Launchpad-Bug-Reporter: Brad Parker (cbparker)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <150480734842.32058.3488330551186130563.malonedeb@soybean.canonical.com>
Message-Id: <160454984026.10129.11833851074669572793.malone@loganberry.canonical.com>
Subject: [Bug 1715715] Re: [qemu-ppc] Segfault when booting from HD after
 MacOS9 install
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 03f89532e383b4994b4a8b796ef43c075d659d3c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1715715 <1715715@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715715

Title:
  [qemu-ppc] Segfault when booting from HD after MacOS9 install

Status in QEMU:
  Expired

Bug description:
  I created an empty 128G qcow2 image and booted from a Mac OS 9.2.1
  Install CD, in which I was able to install the OS successfully to the
  hard drive. Upon reboot, this time from the hard drive directly, qemu-
  system-ppc segfaults. Host system is Ubuntu 16.04.2 with latest qemu
  commit.

  qemu --version reports "2.10.50 (v2.10.0-244-gb07d1c2-dirty)", but I
  used git commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e and built
  with "./configure --target-list=3Dppc-softmmu --enable-debug --disable-
  strip".

  Here is the command-line arguments:

  qemu-system-ppc -boot c -g 1024x768x32 -M mac99 -m 256 -prom-env
  'auto-boot?=3Dtrue' -prom-env 'boot-args=3D-v' -prom-env 'vga-ndrv?=3Dtru=
e'
  -drive file=3D../os9.img,format=3Draw,media=3Dcdrom -drive
  file=3DMacOS9.qcow2,format=3Dqcow2,media=3Ddisk -spice
  port=3D5901,password=3DXXX -net nic,model=3Drtl8139 -net user -monitor st=
dio

  And the GDB backtrace:

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  0x0000559065fe7d3a in timer_mod (ts=3D0x0, expire_time=3D888960717010=
) at util/qemu-timer.c:462
  462         timer_mod_ns(ts, expire_time * ts->scale);
  [Current thread is 1 (Thread 0x7f60e43cb700 (LWP 9853))]
  (gdb) bt
  #0  0x0000559065fe7d3a in timer_mod (ts=3D0x0, expire_time=3D888960717010=
) at util/qemu-timer.c:462
  #1  0x0000559065d63769 in openpic_tmr_set_tmr (tmr=3D0x5590676fa7e0, val=
=3D96, enabled=3Dtrue) at hw/intc/openpic.c:861
  #2  0x0000559065d63995 in openpic_tmr_write (opaque=3D0x5590676f71f0, add=
r=3D16, val=3D96, len=3D4) at hw/intc/openpic.c:912
  #3  0x0000559065b02811 in memory_region_write_accessor (mr=3D0x5590676f77=
10, addr=3D32, value=3D0x7f60e43c7da8, size=3D4, shift=3D0, mask=3D42949672=
95, attrs=3D...) at /home/bp/qemu/memory.c:529
  #4  0x0000559065b02a29 in access_with_adjusted_size (addr=3D32, value=3D0=
x7f60e43c7da8, size=3D1, access_size_min=3D4, access_size_max=3D4, access=
=3D0x559065b02727 <memory_region_write_accessor>, mr=3D0x5590676f7710, attr=
s=3D...) at /home/bp/qemu/memory.c:595
  #5  0x0000559065b051eb in memory_region_dispatch_write (mr=3D0x5590676f77=
10, addr=3D32, data=3D96, size=3D1, attrs=3D...) at /home/bp/qemu/memory.c:=
1337
  #6  0x0000559065aa3a36 in address_space_write_continue (as=3D0x559067614d=
90, addr=3D2147750160, attrs=3D..., buf=3D0x7f60e43c7ed0 "`_'\310`\177", le=
n=3D1, addr1=3D32, l=3D1, mr=3D0x5590676f7710) at /home/bp/qemu/exec.c:2942
  #7  0x0000559065aa3b84 in address_space_write (as=3D0x559067614d90, addr=
=3D2147750160, attrs=3D..., buf=3D0x7f60e43c7ed0 "`_'\310`\177", len=3D1) a=
t /home/bp/qemu/exec.c:2987
  #8  0x0000559065aa2ec0 in subpage_write (opaque=3D0x7f60c8275fc0, addr=3D=
272, value=3D96, len=3D1, attrs=3D...) at /home/bp/qemu/exec.c:2565
  #9  0x0000559065b02906 in memory_region_write_with_attrs_accessor (mr=3D0=
x7f60c8275fc0, addr=3D272, value=3D0x7f60e43c7fc8, size=3D1, shift=3D0, mas=
k=3D255, attrs=3D...) at /home/bp/qemu/memory.c:555
  #10 0x0000559065b029d3 in access_with_adjusted_size (addr=3D272, value=3D=
0x7f60e43c7fc8, size=3D1, access_size_min=3D1, access_size_max=3D8, access=
=3D0x559065b02818 <memory_region_write_with_attrs_accessor>, mr=3D0x7f60c82=
75fc0, attrs=3D...) at /home/bp/qemu/memory.c:590
  #11 0x0000559065b0523a in memory_region_dispatch_write (mr=3D0x7f60c8275f=
c0, addr=3D272, data=3D96, size=3D1, attrs=3D...) at /home/bp/qemu/memory.c=
:1344
  #12 0x0000559065b175db in io_writex (env=3D0x7f60e43d42a0, iotlbentry=3D0=
x7f60e43e8130, mmu_idx=3D3, val=3D96, addr=3D2147750160, retaddr=3D14005415=
8295744, size=3D1) at /home/bp/qemu/accel/tcg/cputlb.c:807
  #13 0x0000559065b18055 in io_writeb (env=3D0x7f60e43d42a0, mmu_idx=3D3, i=
ndex=3D65, val=3D96 '`', addr=3D2147750160, retaddr=3D140054158295744) at /=
home/bp/qemu/softmmu_template.h:265
  #14 0x0000559065b181ea in helper_ret_stb_mmu (env=3D0x7f60e43d42a0, addr=
=3D2147750160, val=3D96 '`', oi=3D3, retaddr=3D140054158295744) at /home/bp=
/qemu/softmmu_template.h:300
  #15 0x00007f60e65ac2c0 in code_gen_buffer ()
  #16 0x0000559065b1ff26 in cpu_tb_exec (cpu=3D0x7f60e43cc010, itb=3D0x7f60=
e65ac5c0 <code_gen_buffer+935318>) at /home/bp/qemu/accel/tcg/cpu-exec.c:166
  #17 0x0000559065b20bfd in cpu_loop_exec_tb (cpu=3D0x7f60e43cc010, tb=3D0x=
7f60e65ac5c0 <code_gen_buffer+935318>, last_tb=3D0x7f60e43c8678, tb_exit=3D=
0x7f60e43c8674) at /home/bp/qemu/accel/tcg/cpu-exec.c:578
  #18 0x0000559065b20eed in cpu_exec (cpu=3D0x7f60e43cc010) at /home/bp/qem=
u/accel/tcg/cpu-exec.c:676
  #19 0x0000559065aebc3d in tcg_cpu_exec (cpu=3D0x7f60e43cc010) at /home/bp=
/qemu/cpus.c:1270
  #20 0x0000559065aebe64 in qemu_tcg_rr_cpu_thread_fn (arg=3D0x7f60e43cc010=
) at /home/bp/qemu/cpus.c:1365
  #21 0x00007f60f56f06ba in start_thread (arg=3D0x7f60e43cb700) at pthread_=
create.c:333
  #22 0x00007f60f542682d in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:109

  Any idea what is going on?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715715/+subscriptions

