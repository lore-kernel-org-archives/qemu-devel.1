Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30349C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E951320829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E951320829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1B7c-0001FC-7W
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1AzQ-00058I-8D
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:01:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:47132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1AzN-0005we-1K
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:01:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k1AzK-0007t5-Q3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 16:00:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C1D1F2E80E7
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 16:00:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2020 15:54:33 -0000
From: Alexander Bulekov <1889621@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr philmd pmaydell
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <159611622900.2711.11274153830927420832.malonedeb@gac.canonical.com>
 <159612310142.16310.15462691731262899664.malone@wampee.canonical.com>
Message-Id: <20200730155433.qgssu2bcff6n62u3@mozz.bu.edu>
Subject: Re: [Bug 1889621] Re: ARM Highbank Crashes Realted to GIC
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3b757a1ea6583be8d6875bb434a9a8b5b351ecec
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 09:45:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1889621 <1889621@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200730 1531, Philippe Mathieu-Daud=C3=A9 wrote:
> Why put all these bugs in the same ticket?

Thought they might have a similar root cause, though that is evidently
wrong..

> For reproducer #2:
> =

> writeq 0xfff11f00 0x613a650f0fda6555 does:
> =

> gic_dist_write dist write at 0x00000f00 size 4: 0x0fda6555
> =

> 0x0fda6555 =3D> IRQ 341, mask type 3 illegal -> DPRINTF("Bad Soft Int
> target filter\n");
> =

> mask =3D ALL_CPU_MASK =3D 0xff
> =

> Having:
> =

> #define GIC_NR_SGIS 16
> uint8_t sgi_pending[GIC_NR_SGIS][GIC_NCPU];
> =

> s->sgi_pending[irq][target_cpu] |=3D (1 << cpu);
>                ^^^
>                   \ OOB access.
> =

> ** Changed in: qemu
>        Status: New =3D> Confirmed
> =

> ** Tags added: arm
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1889621
> =

> Title:
>   ARM Highbank Crashes Realted to GIC
> =

> Status in QEMU:
>   Confirmed
> =

> Bug description:
>   Hello,
>   Here are some QTest reproducers for crashes on ARM Highbank that all se=
em to be related to the gic device.
> =

>   Reproducer 1:
>   cat << EOF | ./arm-softmmu/qemu-system-arm -machine highbank \
>   -nographic -monitor none -serial none -qtest stdio
>   writel 0xfff11f00 0x8405f559
>   writel 0xfff117fd 0x5c057bd8
>   EOF
> =

>   =3D=3D10595=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x62b=
000013e01 (pc 0x55b6ab85cc91 bp 0x7fff60bd4d70 sp 0x7fff60bd4ce0 T0)
>   =3D=3D10595=3D=3DThe signal is caused by a READ memory access.
>       #0 0x55b6ab85cc91 in gic_get_current_cpu /home/alxndr/Development/q=
emu/general-fuzz/hw/intc/arm_gic.c:60:12
>       #1 0x55b6ab85e1bd in gic_dist_writeb /home/alxndr/Development/qemu/=
general-fuzz/hw/intc/arm_gic.c:1182:11
>       #2 0x55b6ab855a97 in gic_dist_write /home/alxndr/Development/qemu/g=
eneral-fuzz/hw/intc/arm_gic.c:1514:9
>       #3 0x55b6aa1650d4 in memory_region_write_with_attrs_accessor /home/=
alxndr/Development/qemu/general-fuzz/softmmu/memory.c:503:12
>       #4 0x55b6aa163ac6 in access_with_adjusted_size /home/alxndr/Develop=
ment/qemu/general-fuzz/softmmu/memory.c:544:18
>       #5 0x55b6aa161f35 in memory_region_dispatch_write /home/alxndr/Deve=
lopment/qemu/general-fuzz/softmmu/memory.c:1473:13
>       #6 0x55b6a9313949 in flatview_write_continue /home/alxndr/Developme=
nt/qemu/general-fuzz/exec.c:3176:23
>       #7 0x55b6a92fca11 in flatview_write /home/alxndr/Development/qemu/g=
eneral-fuzz/exec.c:3216:14
>       #8 0x55b6a92fc54e in address_space_write /home/alxndr/Development/q=
emu/general-fuzz/exec.c:3308:18
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

>   Reproducer 2:
>   cat << EOF | ./arm-softmmu/qemu-system-arm -machine highbank \
>   -nographic -monitor none -serial none -qtest stdio
>   writeq 0xfff11f00 0x613a650f0fda6555
>   EOF
> =

>   =3D=3D1375=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addres=
s 0x608000001c80 at pc 0x5618928c486e bp 0x7ffe22c4ee10 sp 0x7ffe22c4ee08
>   READ of size 8 at 0x608000001c80 thread T0
>       #0 0x5618928c486d in address_space_translate_iommu /home/alxndr/Dev=
elopment/qemu/general-fuzz/exec.c:451:23
>       #1 0x561892850acc in flatview_do_translate /home/alxndr/Development=
/qemu/general-fuzz/exec.c:524:16
>       #2 0x5618928514ad in flatview_translate /home/alxndr/Development/qe=
mu/general-fuzz/exec.c:584:15
>       #3 0x5618928b1e14 in flatview_write_continue /home/alxndr/Developme=
nt/qemu/general-fuzz/exec.c:3199:14
>       #4 0x56189289aa11 in flatview_write /home/alxndr/Development/qemu/g=
eneral-fuzz/exec.c:3216:14
>       #5 0x56189289a54e in address_space_write /home/alxndr/Development/q=
emu/general-fuzz/exec.c:3308:18
>       #6 0x5618937a5e13 in qtest_process_command /home/alxndr/Development=
/qemu/general-fuzz/softmmu/qtest.c:452:13
>       #7 0x56189379d89f in qtest_process_inbuf /home/alxndr/Development/q=
emu/general-fuzz/softmmu/qtest.c:710:9
>       #8 0x56189379c680 in qtest_read /home/alxndr/Development/qemu/gener=
al-fuzz/softmmu/qtest.c:722:5
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

>   Reproducer 3:
>   cat << EOF | ./arm-softmmu/qemu-system-arm -machine highbank \
>   -nographic -monitor none -serial none -qtest stdio
>   writeq 0xfff11000 0x700000b
>   writeq 0xfff11f00 0x4f4f4fff54a7afaf
>   writel 0xfff10100 0x600001ff
>   EOF
> =

>   =3D=3D23743=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addre=
ss 0x62b000006a92 at pc 0x55d690d980e1 bp 0x7ffe606082d0 sp 0x7ffe606082c8
>   READ of size 1 at 0x62b000006a92 thread T0
>       #0 0x55d690d980e0 in gic_get_best_irq /home/alxndr/Development/qemu=
/general-fuzz/hw/intc/arm_gic.c:94:13
>       #1 0x55d690d9485b in gic_update_internal /home/alxndr/Development/q=
emu/general-fuzz/hw/intc/arm_gic.c:185:13
>       #2 0x55d690d90376 in gic_update /home/alxndr/Development/qemu/gener=
al-fuzz/hw/intc/arm_gic.c:226:5
>       #3 0x55d690dc0879 in gic_cpu_write /home/alxndr/Development/qemu/ge=
neral-fuzz/hw/intc/arm_gic.c:1758:9
>       #4 0x55d690da41c0 in gic_thiscpu_write /home/alxndr/Development/qem=
u/general-fuzz/hw/intc/arm_gic.c:1777:12
>       #5 0x55d68f6b30d4 in memory_region_write_with_attrs_accessor /home/=
alxndr/Development/qemu/general-fuzz/softmmu/memory.c:503:12
>       #6 0x55d68f6b1ac6 in access_with_adjusted_size /home/alxndr/Develop=
ment/qemu/general-fuzz/softmmu/memory.c:544:18
>       #7 0x55d68f6aff35 in memory_region_dispatch_write /home/alxndr/Deve=
lopment/qemu/general-fuzz/softmmu/memory.c:1473:13
>       #8 0x55d68e861949 in flatview_write_continue /home/alxndr/Developme=
nt/qemu/general-fuzz/exec.c:3176:23
>       #9 0x55d68e84aa11 in flatview_write /home/alxndr/Development/qemu/g=
eneral-fuzz/exec.c:3216:14
>       #10 0x55d68e84a54e in address_space_write /home/alxndr/Development/=
qemu/general-fuzz/exec.c:3308:18
>       #11 0x55d68f755537 in qtest_process_command /home/alxndr/Developmen=
t/qemu/general-fuzz/softmmu/qtest.c:447:13
>       #12 0x55d68f74d89f in qtest_process_inbuf /home/alxndr/Development/=
qemu/general-fuzz/softmmu/qtest.c:710:9
>       #13 0x55d68f74c680 in qtest_read /home/alxndr/Development/qemu/gene=
ral-fuzz/softmmu/qtest.c:722:5
>       #14 0x55d692dddc36 in qemu_chr_be_write_impl /home/alxndr/Developme=
nt/qemu/general-fuzz/chardev/char.c:188:9
>       #15 0x55d692dddd79 in qemu_chr_be_write /home/alxndr/Development/qe=
mu/general-fuzz/chardev/char.c:200:9
>       #16 0x55d692df105e in fd_chr_read /home/alxndr/Development/qemu/gen=
eral-fuzz/chardev/char-fd.c:68:9
>       #17 0x55d692f395df in qio_channel_fd_source_dispatch /home/alxndr/D=
evelopment/qemu/general-fuzz/io/channel-watch.c:84:12
>       #18 0x7f69a1b50897 in g_main_context_dispatch (/usr/lib/x86_64-linu=
x-gnu/libglib-2.0.so.0+0x4e897)
>       #19 0x55d6932f5c83 in glib_pollfds_poll /home/alxndr/Development/qe=
mu/general-fuzz/util/main-loop.c:217:9
>       #20 0x55d6932f35b6 in os_host_main_loop_wait /home/alxndr/Developme=
nt/qemu/general-fuzz/util/main-loop.c:240:5
>       #21 0x55d6932f2f97 in main_loop_wait /home/alxndr/Development/qemu/=
general-fuzz/util/main-loop.c:516:11
>       #22 0x55d68f76c62d in qemu_main_loop /home/alxndr/Development/qemu/=
general-fuzz/softmmu/vl.c:1676:9
>       #23 0x55d692f6f20c in main /home/alxndr/Development/qemu/general-fu=
zz/softmmu/main.c:49:5
>       #24 0x7f69a06d6e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2=
.30/csu/../csu/libc-start.c:308:16
>       #25 0x55d68e753459 in _start (/home/alxndr/Development/qemu/general=
-fuzz/build/arm-softmmu/qemu-system-arm+0x3254459)
> =

>   0x62b000006a92 is located 2 bytes to the right of 26768-byte region [0x=
62b000000200,0x62b000006a90)
>   allocated by thread T0 here:
>       #0 0x55d68e7cbe4d in malloc (/home/alxndr/Development/qemu/general-=
fuzz/build/arm-softmmu/qemu-system-arm+0x32cce4d)
>       #1 0x7f69a1b56500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.=
0.so.0+0x54500)
>       #2 0x55d69254f231 in object_new /home/alxndr/Development/qemu/gener=
al-fuzz/qom/object.c:708:12
>       #3 0x55d69034bf01 in qdev_new /home/alxndr/Development/qemu/general=
-fuzz/hw/core/qdev.c:136:12
>       #4 0x55d68f2b7aa4 in calxeda_init /home/alxndr/Development/qemu/gen=
eral-fuzz/hw/arm/highbank.c:319:15
>       #5 0x55d68f2b6466 in highbank_init /home/alxndr/Development/qemu/ge=
neral-fuzz/hw/arm/highbank.c:411:5
>       #6 0x55d6903d43f1 in machine_run_board_init /home/alxndr/Developmen=
t/qemu/general-fuzz/hw/core/machine.c:1134:5
>       #7 0x55d68f77e0ee in qemu_init /home/alxndr/Development/qemu/genera=
l-fuzz/softmmu/vl.c:4356:5
>       #8 0x55d692f6f207 in main /home/alxndr/Development/qemu/general-fuz=
z/softmmu/main.c:48:5
>       #9 0x7f69a06d6e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.=
30/csu/../csu/libc-start.c:308:16
> =

>   =

>   Let me know if I can provide any further info.
>   -Alex
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1889621/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1889621

Title:
  ARM Highbank Crashes Realted to GIC

Status in QEMU:
  Confirmed

Bug description:
  Hello,
  Here are some QTest reproducers for crashes on ARM Highbank that all seem=
 to be related to the gic device.

  Reproducer 1:
  cat << EOF | ./arm-softmmu/qemu-system-arm -machine highbank \
  -nographic -monitor none -serial none -qtest stdio
  writel 0xfff11f00 0x8405f559
  writel 0xfff117fd 0x5c057bd8
  EOF

  =3D=3D10595=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x62b00=
0013e01 (pc 0x55b6ab85cc91 bp 0x7fff60bd4d70 sp 0x7fff60bd4ce0 T0)
  =3D=3D10595=3D=3DThe signal is caused by a READ memory access.
      #0 0x55b6ab85cc91 in gic_get_current_cpu /home/alxndr/Development/qem=
u/general-fuzz/hw/intc/arm_gic.c:60:12
      #1 0x55b6ab85e1bd in gic_dist_writeb /home/alxndr/Development/qemu/ge=
neral-fuzz/hw/intc/arm_gic.c:1182:11
      #2 0x55b6ab855a97 in gic_dist_write /home/alxndr/Development/qemu/gen=
eral-fuzz/hw/intc/arm_gic.c:1514:9
      #3 0x55b6aa1650d4 in memory_region_write_with_attrs_accessor /home/al=
xndr/Development/qemu/general-fuzz/softmmu/memory.c:503:12
      #4 0x55b6aa163ac6 in access_with_adjusted_size /home/alxndr/Developme=
nt/qemu/general-fuzz/softmmu/memory.c:544:18
      #5 0x55b6aa161f35 in memory_region_dispatch_write /home/alxndr/Develo=
pment/qemu/general-fuzz/softmmu/memory.c:1473:13
      #6 0x55b6a9313949 in flatview_write_continue /home/alxndr/Development=
/qemu/general-fuzz/exec.c:3176:23
      #7 0x55b6a92fca11 in flatview_write /home/alxndr/Development/qemu/gen=
eral-fuzz/exec.c:3216:14
      #8 0x55b6a92fc54e in address_space_write /home/alxndr/Development/qem=
u/general-fuzz/exec.c:3308:18
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Reproducer 2:
  cat << EOF | ./arm-softmmu/qemu-system-arm -machine highbank \
  -nographic -monitor none -serial none -qtest stdio
  writeq 0xfff11f00 0x613a650f0fda6555
  EOF

  =3D=3D1375=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address =
0x608000001c80 at pc 0x5618928c486e bp 0x7ffe22c4ee10 sp 0x7ffe22c4ee08
  READ of size 8 at 0x608000001c80 thread T0
      #0 0x5618928c486d in address_space_translate_iommu /home/alxndr/Devel=
opment/qemu/general-fuzz/exec.c:451:23
      #1 0x561892850acc in flatview_do_translate /home/alxndr/Development/q=
emu/general-fuzz/exec.c:524:16
      #2 0x5618928514ad in flatview_translate /home/alxndr/Development/qemu=
/general-fuzz/exec.c:584:15
      #3 0x5618928b1e14 in flatview_write_continue /home/alxndr/Development=
/qemu/general-fuzz/exec.c:3199:14
      #4 0x56189289aa11 in flatview_write /home/alxndr/Development/qemu/gen=
eral-fuzz/exec.c:3216:14
      #5 0x56189289a54e in address_space_write /home/alxndr/Development/qem=
u/general-fuzz/exec.c:3308:18
      #6 0x5618937a5e13 in qtest_process_command /home/alxndr/Development/q=
emu/general-fuzz/softmmu/qtest.c:452:13
      #7 0x56189379d89f in qtest_process_inbuf /home/alxndr/Development/qem=
u/general-fuzz/softmmu/qtest.c:710:9
      #8 0x56189379c680 in qtest_read /home/alxndr/Development/qemu/general=
-fuzz/softmmu/qtest.c:722:5
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Reproducer 3:
  cat << EOF | ./arm-softmmu/qemu-system-arm -machine highbank \
  -nographic -monitor none -serial none -qtest stdio
  writeq 0xfff11000 0x700000b
  writeq 0xfff11f00 0x4f4f4fff54a7afaf
  writel 0xfff10100 0x600001ff
  EOF

  =3D=3D23743=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x62b000006a92 at pc 0x55d690d980e1 bp 0x7ffe606082d0 sp 0x7ffe606082c8
  READ of size 1 at 0x62b000006a92 thread T0
      #0 0x55d690d980e0 in gic_get_best_irq /home/alxndr/Development/qemu/g=
eneral-fuzz/hw/intc/arm_gic.c:94:13
      #1 0x55d690d9485b in gic_update_internal /home/alxndr/Development/qem=
u/general-fuzz/hw/intc/arm_gic.c:185:13
      #2 0x55d690d90376 in gic_update /home/alxndr/Development/qemu/general=
-fuzz/hw/intc/arm_gic.c:226:5
      #3 0x55d690dc0879 in gic_cpu_write /home/alxndr/Development/qemu/gene=
ral-fuzz/hw/intc/arm_gic.c:1758:9
      #4 0x55d690da41c0 in gic_thiscpu_write /home/alxndr/Development/qemu/=
general-fuzz/hw/intc/arm_gic.c:1777:12
      #5 0x55d68f6b30d4 in memory_region_write_with_attrs_accessor /home/al=
xndr/Development/qemu/general-fuzz/softmmu/memory.c:503:12
      #6 0x55d68f6b1ac6 in access_with_adjusted_size /home/alxndr/Developme=
nt/qemu/general-fuzz/softmmu/memory.c:544:18
      #7 0x55d68f6aff35 in memory_region_dispatch_write /home/alxndr/Develo=
pment/qemu/general-fuzz/softmmu/memory.c:1473:13
      #8 0x55d68e861949 in flatview_write_continue /home/alxndr/Development=
/qemu/general-fuzz/exec.c:3176:23
      #9 0x55d68e84aa11 in flatview_write /home/alxndr/Development/qemu/gen=
eral-fuzz/exec.c:3216:14
      #10 0x55d68e84a54e in address_space_write /home/alxndr/Development/qe=
mu/general-fuzz/exec.c:3308:18
      #11 0x55d68f755537 in qtest_process_command /home/alxndr/Development/=
qemu/general-fuzz/softmmu/qtest.c:447:13
      #12 0x55d68f74d89f in qtest_process_inbuf /home/alxndr/Development/qe=
mu/general-fuzz/softmmu/qtest.c:710:9
      #13 0x55d68f74c680 in qtest_read /home/alxndr/Development/qemu/genera=
l-fuzz/softmmu/qtest.c:722:5
      #14 0x55d692dddc36 in qemu_chr_be_write_impl /home/alxndr/Development=
/qemu/general-fuzz/chardev/char.c:188:9
      #15 0x55d692dddd79 in qemu_chr_be_write /home/alxndr/Development/qemu=
/general-fuzz/chardev/char.c:200:9
      #16 0x55d692df105e in fd_chr_read /home/alxndr/Development/qemu/gener=
al-fuzz/chardev/char-fd.c:68:9
      #17 0x55d692f395df in qio_channel_fd_source_dispatch /home/alxndr/Dev=
elopment/qemu/general-fuzz/io/channel-watch.c:84:12
      #18 0x7f69a1b50897 in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e897)
      #19 0x55d6932f5c83 in glib_pollfds_poll /home/alxndr/Development/qemu=
/general-fuzz/util/main-loop.c:217:9
      #20 0x55d6932f35b6 in os_host_main_loop_wait /home/alxndr/Development=
/qemu/general-fuzz/util/main-loop.c:240:5
      #21 0x55d6932f2f97 in main_loop_wait /home/alxndr/Development/qemu/ge=
neral-fuzz/util/main-loop.c:516:11
      #22 0x55d68f76c62d in qemu_main_loop /home/alxndr/Development/qemu/ge=
neral-fuzz/softmmu/vl.c:1676:9
      #23 0x55d692f6f20c in main /home/alxndr/Development/qemu/general-fuzz=
/softmmu/main.c:49:5
      #24 0x7f69a06d6e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #25 0x55d68e753459 in _start (/home/alxndr/Development/qemu/general-f=
uzz/build/arm-softmmu/qemu-system-arm+0x3254459)

  0x62b000006a92 is located 2 bytes to the right of 26768-byte region [0x62=
b000000200,0x62b000006a90)
  allocated by thread T0 here:
      #0 0x55d68e7cbe4d in malloc (/home/alxndr/Development/qemu/general-fu=
zz/build/arm-softmmu/qemu-system-arm+0x32cce4d)
      #1 0x7f69a1b56500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.=
so.0+0x54500)
      #2 0x55d69254f231 in object_new /home/alxndr/Development/qemu/general=
-fuzz/qom/object.c:708:12
      #3 0x55d69034bf01 in qdev_new /home/alxndr/Development/qemu/general-f=
uzz/hw/core/qdev.c:136:12
      #4 0x55d68f2b7aa4 in calxeda_init /home/alxndr/Development/qemu/gener=
al-fuzz/hw/arm/highbank.c:319:15
      #5 0x55d68f2b6466 in highbank_init /home/alxndr/Development/qemu/gene=
ral-fuzz/hw/arm/highbank.c:411:5
      #6 0x55d6903d43f1 in machine_run_board_init /home/alxndr/Development/=
qemu/general-fuzz/hw/core/machine.c:1134:5
      #7 0x55d68f77e0ee in qemu_init /home/alxndr/Development/qemu/general-=
fuzz/softmmu/vl.c:4356:5
      #8 0x55d692f6f207 in main /home/alxndr/Development/qemu/general-fuzz/=
softmmu/main.c:48:5
      #9 0x7f69a06d6e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.30=
/csu/../csu/libc-start.c:308:16

  =

  Let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1889621/+subscriptions

