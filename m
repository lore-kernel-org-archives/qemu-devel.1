Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67409C3A59D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F1722DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F1722DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03Nd-0007L2-7X
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i03LT-0005rZ-0k
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i03LR-00024d-1U
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:34:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i03LM-0001mP-Ib; Tue, 20 Aug 2019 08:34:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1131918C890D;
 Tue, 20 Aug 2019 12:34:31 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45BC95C21F;
 Tue, 20 Aug 2019 12:34:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:34:15 +0200
Message-Id: <20190820123417.27930-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 20 Aug 2019 12:34:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full
 16550 UART support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Since there has been some activity on the list asking about
Rasberry PI USB support, I had a look a some previous unfinished
work and rebased it to share, in case it helps hobbyist interested
in improving these machines.

This series is some proof-of-concept on improving the AUX UART
support. See the commit description for various TODO/questions.

This can be tested using files documented by Peter Maydell in
his blog post:
https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspberry=
-pi-3-model/

And using the kernel command line arguments suggested by Guenter Roeck:

qemu-system-aarch64 -M raspi3 -m 1024 \
  -kernel raspi3/bootpart/vmlinuz-4.14.0-3-arm64 \
  -initrd raspi3/bootpart/initrd.img-4.14.0-3-arm64 \
  -dtb raspi3/bootpart/bcm2837-rpi-3-b.dtb \
  -append 'earlycon=3Duart8250,mmio32,0x3f215040 rdinit=3D/sbin/init pani=
c=3D-1 console=3DttyS1,115200' \
  -drive file=3Draspi3/2018-01-08-raspberry-pi-3-buster-PREVIEW.img,forma=
t=3Draw,if=3Dsd \
  -serial null -serial stdio \
  -d unimp,guest_errors -trace bcm283\*
27459@1566304158.228297:bcm2835_sdhost_edm_change (device reset) EDM now =
0xc60f
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.0-3-arm64 (debian-kernel@lists.debian.o=
rg) (gcc version 7.2.0 (Debian 7.2.0-18)) #1 SMP Debian 4.14.12-2 (2018-0=
1-06)
[    0.000000] Boot CPU: AArch64 Processor [410fd034]
[    0.000000] Machine model: Raspberry Pi 3 Model B
[    0.000000] earlycon: uart8250 at MMIO32 0x000000003f215040 (options '=
')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 64 MiB at 0x0000000038000000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x000000003=
bffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x37fdf180-0x37fe0c7f]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000003bffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003bffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003bf=
fffff]
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 22 pages/cpu @ffff800037f74000 s51608 r81=
92 d30312 u90112
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 241=
920
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: earlycon=3Duart8250,mmio32,0x3f215040=
 rdinit=3D/sbin/init panic=3D-1 console=3DttyS1,115200
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 864772K/983040K available (8252K kernel code, 1448=
K rwdata, 2692K rodata, 4480K init, 601K bss, 52732K reserved, 65536K cma=
-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   ( =
  128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (1=
29022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff000008890000   ( =
 8256 KB)
[    0.000000]     .rodata : 0xffff000008890000 - 0xffff000008b40000   ( =
 2752 KB)
[    0.000000]       .init : 0xffff000008b40000 - 0xffff000008fa0000   ( =
 4480 KB)
[    0.000000]       .data : 0xffff000008fa0000 - 0xffff00000910a200   ( =
 1449 KB)
[    0.000000]        .bss : 0xffff00000910a200 - 0xffff0000091a0910   ( =
  602 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   ( =
 4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   ( =
   16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   ( =
 2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0000f00000   ( =
   15 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff80003c000000   ( =
  960 MB)
[    0.000000] ftrace: allocating 30760 entries in 121 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_ids=3D4=
.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
bcm2836_control_write: Bad offset 0
bcm2836_control_write: Bad offset 8
[    0.000000] arch_timer: WARNING: Invalid trigger for IRQ2, assuming le=
vel low
[    0.000000] arch_timer: WARNING: Please fix your firmware
[    0.000000] arch_timer: cp15 timer(s) running at 62.50MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_=
cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
[    0.001154] sched_clock: 56 bits at 62MHz, resolution 16ns, wraps ever=
y 4398046511096ns
[    0.068563] Console: colour dummy device 80x25
[    0.081268] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 125.00 BogoMIPS (lpj=3D250000)
[    0.083225] pid_max: default: 32768 minimum: 301
[    0.094763] Security Framework initialized
[    0.096254] Yama: disabled by default; enable with sysctl kernel.yama.=
*
[    0.113385] AppArmor: AppArmor initialized
[    0.127602] Dentry cache hash table entries: 131072 (order: 8, 1048576=
 bytes)
[    0.135573] Inode-cache hash table entries: 65536 (order: 7, 524288 by=
tes)
[    0.137705] Mount-cache hash table entries: 2048 (order: 2, 16384 byte=
s)
[    0.138861] Mountpoint-cache hash table entries: 2048 (order: 2, 16384=
 bytes)
[    0.369415] ASID allocator initialised with 65536 entries
[    0.376083] Hierarchical SRCU implementation.
[    0.437838] EFI services will not be available.
[    0.462860] smp: Bringing up secondary CPUs ...
[    0.487588] Detected VIPT I-cache on CPU1
[    0.490893] arch_timer: WARNING: Invalid trigger for IRQ2, assuming le=
vel low
[    0.490944] arch_timer: WARNING: Please fix your firmware
[    0.491388] CPU1: Booted secondary processor [410fd034]
[    0.546624] Detected VIPT I-cache on CPU2
[    0.547535] arch_timer: WARNING: Invalid trigger for IRQ2, assuming le=
vel low
[    0.547632] arch_timer: WARNING: Please fix your firmware
[    0.548032] CPU2: Booted secondary processor [410fd034]
[    0.574539] Detected VIPT I-cache on CPU3
[    0.575101] arch_timer: WARNING: Invalid trigger for IRQ2, assuming le=
vel low
[    0.575150] arch_timer: WARNING: Please fix your firmware
[    0.575367] CPU3: Booted secondary processor [410fd034]
[    0.578684] smp: Brought up 1 node, 4 CPUs
[    0.584515] SMP: Total of 4 processors activated.
[    0.585656] CPU features: detected feature: 32-bit EL0 Support
[    0.603653] CPU: All CPU(s) started at EL2
[    0.607831] alternatives: patching kernel code
[    0.695440] devtmpfs: initialized
[    0.806025] Registered cp15_barrier emulation handler
[    0.806837] Registered setend emulation handler
[    0.816246] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
[    0.818294] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.864640] pinctrl core: initialized pinctrl subsystem
[    0.929209] DMI not present or invalid.
[    0.955714] NET: Registered protocol family 16
[    1.063727] cpuidle: using governor ladder
[    1.068747] cpuidle: using governor menu
[    1.079439] vdso: 2 pages (1 code @ ffff000008896000, 1 data @ ffff000=
008fa5000)
[    1.081031] hw-breakpoint: found 6 breakpoint and 4 watchpoint registe=
rs.
[    1.127784] DMA: preallocated 256 KiB pool for atomic allocations
[    1.137470] Serial: AMBA PL011 UART driver
[    1.195277] uart-pl011 3f201000.serial: could not find pctldev for nod=
e /soc/gpio@7e200000/uart0_gpio32, deferring probe
[    1.398312] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
[    1.436505] ACPI: Interpreter disabled.
[    1.461028] vgaarb: loaded
[    1.473307] EDAC MC: Ver: 3.0.0
[    1.481644] dmi: Firmware registration failed.
[    1.543428] clocksource: Switched to clocksource arch_sys_counter
[    2.815434] VFS: Disk quotas dquot_6.6.0
[    2.817156] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
[    2.850332] AppArmor: AppArmor Filesystem Enabled
[    2.854670] pnp: PnP ACPI: disabled
[    3.035675] NET: Registered protocol family 2
[    3.071712] TCP established hash table entries: 8192 (order: 4, 65536 =
bytes)
[    3.073599] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
[    3.075011] TCP: Hash tables configured (established 8192 bind 8192)
[    3.082515] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    3.083954] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    3.094971] NET: Registered protocol family 1
[    3.123313] Unpacking initramfs...

Here it hangs, even with CPRMAN patch from Guenter:
https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03153.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  hw/char/serial: Add a helper to set the divisor register
  hw/char/bcm2835_aux: Provide full 16550 UART support

 hw/arm/bcm2835_peripherals.c  |   2 -
 hw/char/bcm2835_aux.c         | 211 +++-------------------------------
 hw/char/serial.c              |   6 +
 include/hw/char/bcm2835_aux.h |   7 +-
 include/hw/char/serial.h      |   1 +
 5 files changed, 27 insertions(+), 200 deletions(-)

--=20
2.20.1


