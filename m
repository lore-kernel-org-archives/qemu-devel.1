Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C00C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005B9222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7KjHw31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005B9222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXj1-0006Xy-Pf
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg7-0004Gc-U9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg3-0002i1-Oi
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg0-0002dB-23; Thu, 26 Sep 2019 13:35:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so3735284wrt.2;
 Thu, 26 Sep 2019 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X5E8a57tJOmGA1IoWBlI4ynhtwnzGDa/inS2XNZ8gbU=;
 b=b7KjHw31QPDxO6HVKM1svEXGGIHbf6mJhfmv9XTRk9d9DqYY50GPAw42UT5oVEuHEg
 i282SlUU9SQIrED30UdmG7zDUQ3ofR6rPrDMfrYvf2L+lZKUN6JO8a9xZSrh1pVDpp9k
 OlJA3w7HQK67h+TFavRmtpDY6QfL6XMfE7VEa9Vvb3KyOWm4zSnr5q2zpt3Nh9UQS9DR
 hn5mkJy22OLoRhO2BPXetORqukxRqGDPJNF1YUwxvWRgIWfscLOoka2WNvK8HOKfxXCX
 jdV6iFeiMiuA3nEL3OrBcWwU3y2eEAgWQBVUkkSUWNab19YX0Xd4toXOPwJvStqDF2Kk
 Hndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=X5E8a57tJOmGA1IoWBlI4ynhtwnzGDa/inS2XNZ8gbU=;
 b=la6EJeEuCw0YuMftR7S2MBxjC9LtldtezmrOCdsCVanwRsTI5qagkiBiVV7H8ZjWkz
 pqsiKJQ4uPVRLwcoO67BXJcrok09k2GFtk4Y01MuYjpIGWukFpXjVtKpdArWCY3dGDQF
 mSw7bsY8BdKWjaCwtQq84k73UENiKtSQOCQAlyvLHYKhKD+bQ3O/tEhosfdtZg5h5Qgl
 NqX7i+HJ5cMU1uY2F8lYCCQ2VSG0pE0SusY1PpN2ZL8erIW4IUYHNDQinNTC8+E1vLa8
 R+UKmGZvbYSZp0MkYOSl5ychVqAdMpHjrKI2EzzwNuD5SEjIEh5HvHiZRbG/NukUz5EO
 HUwg==
X-Gm-Message-State: APjAAAWoVZ4HJArypaPPJZ0sWyQgpFSAZNB+oom6k/LDuTSlC89dN/3Z
 T/lhsS/NyyqHfF4VGr739t2vQibXyIM=
X-Google-Smtp-Source: APXvYqzb3g26DhBYaJv5Bg8fFqajv3Ym6DuNbP3LfeCtVW8Dy7MCVUQz+WEF8H67uU2jmHMb1eNeGA==
X-Received: by 2002:adf:ee4d:: with SMTP id w13mr2744448wro.90.1569519271771; 
 Thu, 26 Sep 2019 10:34:31 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/19] hw/arm/raspi: Improve Raspberry Pi 2/3 reliability
Date: Thu, 26 Sep 2019 19:34:08 +0200
Message-Id: <20190926173428.10713-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I previously posted a RFC for the Raspberry Pi 4:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg642241.html
and got it almost working (boots Linux kernel to userland, sadly
I'm still having timeout issues with the eMMC block).
However since it is quite usable, I started to clean up to post
the series and realized it is way too big for Peter Maydell, so
I'm following his rule of thumb by splitting in 3 sets of ~20
functional patches.

In this first series, we pay old debts with these models. Linux
evolved and recent kernels were barely usable. U-boot now ticks,
Linux stops to Oops every so and then. We can use more than one
console at a time (think pppd?).

Then we add various tests to confirm our effort made sense, and
to avoid regressions.

Laurent, Cheng, do you mind testing on U-Boot?

In the next part we'll improve/update the MBox/Properties and the
interrupt controller blocks.

Finally the last part adds the raspi4.

Please review.

Regards,

Phil.

---

The tests added are already enabled on our Travis-CI.
It takes me <2min to run all the tests:

$ make aarch64-softmmu/all check-venv
$ ./tests/venv/bin/avocado --show=app,console run -t machine:raspi2 -t machine:raspi3 tests/acceptance
JOB ID     : 10bf6593659f0b191941265c19fe3dbf1652c3e7
JOB LOG    : /home/phil/avocado/job-results/job-2019-09-26T19.04-10bf659/job.log
 (1/4) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_uart0: \console: [    0.000000] Booting Linux on physical CPU 0xf00
console: [    0.000000] Linux version 4.14.98-v7+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 SMP Tue Feb 12 20:27:48 GMT 2019
console: [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
console: [    0.000000] CPU: div instructions available: patching division code
console: [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
console: [    0.000000] OF: fdt: Machine model: Raspberry Pi 2 Model B
console: [    0.000000] earlycon: pl11 at MMIO 0x3f201000 (options '')
console: [    0.000000] bootconsole [pl11] enabled
console: [    0.000000] Memory policy: Data cache writealloc
console: [    0.000000] cma: Reserved 8 MiB at 0x3b800000
console: [    0.000000] percpu: Embedded 17 pages/cpu @baf2e000 s38720 r8192 d22720 u69632
console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 243600
console: [    0.000000] Kernel command line: printk.time=0 earlycon=pl011,0x3f201000 console=ttyAMA0
PASS (6.74 s)
 (2/4) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_uart1: -console: [    0.000000] Booting Linux on physical CPU 0xf00
console: [    0.000000] Linux version 4.14.98-v7+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 SMP Tue Feb 12 20:27:48 GMT 2019
console: [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
console: [    0.000000] CPU: div instructions available: patching division code
console: [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
console: [    0.000000] OF: fdt: Machine model: Raspberry Pi 2 Model B
console: [    0.000000] earlycon: uart8250 at MMIO32 0x3f215040 (options '')
console: [    0.000000] bootconsole [uart8250] enabled
console: [    0.000000] Memory policy: Data cache writealloc
console: [    0.000000] cma: Reserved 8 MiB at 0x3b800000
console: [    0.000000] percpu: Embedded 17 pages/cpu @baf2e000 s38720 r8192 d22720 u69632
console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 243600
console: [    0.000000] Kernel command line: printk.time=0 earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200
PASS (6.69 s)
 (3/4) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi3_initrd_uart0: -console: [    0.000000] Booting Linux on physical CPU 0x0
console: [    0.000000] Linux version 4.14.0-3-arm64 (debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18)) #1 SMP Debian 4.14.12-2 (2018-01-06)
console: [    0.000000] Boot CPU: AArch64 Processor [410fd034]
console: [    0.000000] Machine model: Raspberry Pi 3 Model B
console: [    0.000000] earlycon: pl11 at MMIO 0x000000003f201000 (options '')
console: [    0.000000] bootconsole [pl11] enabled
console: [    0.000000] efi: Getting EFI parameters from FDT:
console: [    0.000000] efi: UEFI not found.
console: [    0.000000] cma: Reserved 64 MiB at 0x0000000038000000
console: [    0.000000] NUMA: No NUMA configuration found
console: [    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x000000003bffffff]
console: [    0.000000] NUMA: NODE_DATA [mem 0x37fdc380-0x37fdde7f]
console: [    0.000000] Zone ranges:
console: [    0.000000]   DMA      [mem 0x0000000000000000-0x000000003bffffff]
console: [    0.000000]   Normal   empty
console: [    0.000000] Movable zone start for each node
console: [    0.000000] Early memory node ranges
console: [    0.000000]   node   0: [mem 0x0000000000000000-0x000000003bffffff]
console: [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003bffffff]
\console: [    0.000000] /cpus/cpu@1: missing enable-method property
console: [    0.000000] /cpus/cpu@2: missing enable-method property
console: [    0.000000] /cpus/cpu@3: missing enable-method property
console: [    0.000000] random: fast init done
console: [    0.000000] percpu: Embedded 22 pages/cpu @ffff800037fb3000 s51608 r8192 d30312 u90112
console: [    0.000000] Detected VIPT I-cache on CPU0
console: [    0.000000] CPU features: enabling workaround for ARM erratum 845719
console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 241920
console: [    0.000000] Policy zone: DMA
console: [    0.000000] Kernel command line: printk.time=0 earlycon=pl011,0x3f201000 console=ttyAMA0 panic=-1 noreboot
console: PID hash table entries: 4096 (order: 3, 32768 bytes)
console: Memory: 879888K/983040K available (8252K kernel code, 1448K rwdata, 2692K rodata, 4480K init, 601K bss, 37616K reserved, 65536K cma-reserved)
console: Virtual kernel memory layout:
console: modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
console: vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
console: .text : 0xffff000008080000 - 0xffff000008890000   (  8256 KB)
console: .rodata : 0xffff000008890000 - 0xffff000008b40000   (  2752 KB)
console: .init : 0xffff000008b40000 - 0xffff000008fa0000   (  4480 KB)
console: .data : 0xffff000008fa0000 - 0xffff00000910a200   (  1449 KB)
console: .bss : 0xffff00000910a200 - 0xffff0000091a0910   (   602 KB)
console: fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
console: PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
console: vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
console: 0xffff7e0000000000 - 0xffff7e0000f00000   (    15 MB actual)
console: memory  : 0xffff800000000000 - 0xffff80003c000000   (   960 MB)
console: ftrace: allocating 30760 entries in 121 pages
\console: Hierarchical RCU implementation.
console: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=1.
console: RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
console: NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
console: arch_timer: WARNING: Invalid trigger for IRQ2, assuming level low
console: arch_timer: WARNING: Please fix your firmware
console: arch_timer: cp15 timer(s) running at 62.50MHz (phys).
console: clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
console: sched_clock: 56 bits at 62MHz, resolution 16ns, wraps every 4398046511096ns
console: Console: colour dummy device 80x25
console: Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=250000)
console: pid_max: default: 32768 minimum: 301
console: Security Framework initialized
console: Yama: disabled by default; enable with sysctl kernel.yama.*
console: AppArmor: AppArmor initialized
console: Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
console: Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
console: Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
console: Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
console: ASID allocator initialised with 65536 entries
console: Hierarchical SRCU implementation.
console: EFI services will not be available.
console: smp: Bringing up secondary CPUs ...
console: smp: Brought up 1 node, 1 CPU
console: SMP: Total of 1 processors activated.
console: CPU features: detected feature: 32-bit EL0 Support
console: CPU: All CPU(s) started at EL2
console: alternatives: patching kernel code
|console: devtmpfs: initialized
console: Registered cp15_barrier emulation handler
console: Registered setend emulation handler
console: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
console: futex hash table entries: 256 (order: 3, 32768 bytes)
console: pinctrl core: initialized pinctrl subsystem
console: DMI not present or invalid.
console: NET: Registered protocol family 16
console: cpuidle: using governor ladder
console: cpuidle: using governor menu
console: vdso: 2 pages (1 code @ ffff000008896000, 1 data @ ffff000008fa5000)
console: hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
console: DMA: preallocated 256 KiB pool for atomic allocations
console: Serial: AMBA PL011 UART driver
console: uart-pl011 3f201000.serial: could not find pctldev for node /soc/gpio@7e200000/uart0_pins, deferring probe
console: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
console: ACPI: Interpreter disabled.
console: vgaarb: loaded
console: EDAC MC: Ver: 3.0.0
console: dmi: Firmware registration failed.
/console: clocksource: Switched to clocksource arch_sys_counter
-console: VFS: Disk quotas dquot_6.6.0
console: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
console: AppArmor: AppArmor Filesystem Enabled
console: pnp: PnP ACPI: disabled
\console: NET: Registered protocol family 2
console: TCP established hash table entries: 8192 (order: 4, 65536 bytes)
console: TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
console: TCP: Hash tables configured (established 8192 bind 8192)
console: UDP hash table entries: 512 (order: 2, 16384 bytes)
console: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
console: NET: Registered protocol family 1
console: Unpacking initramfs...
console: Freeing initrd memory: 3268K
console: kvm [1]: 8-bit VMID
console: kvm [1]: IDMAP page: 87a000
console: kvm [1]: HYP VA range: 800000000000:ffffffffffff
console: kvm [1]: Invalid trigger for IRQ4, assuming level low
console: kvm [1]: virtual timer IRQ4
console: kvm [1]: Hyp mode initialized successfully
|console: audit: initializing netlink subsys (disabled)
console: audit: type=2000 audit(4.436:1): state=initialized audit_enabled=0 res=1
console: workingset: timestamp_bits=44 max_order=18 bucket_order=0
console: zbud: loaded
/console: Key type asymmetric registered
console: Asymmetric key parser 'x509' registered
console: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
console: io scheduler noop registered
console: io scheduler deadline registered
console: io scheduler cfq registered (default)
console: io scheduler mq-deadline registered
console: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
console: bcm2835-aux-uart 3f215040.serial: irq not found - -517
console: Serial: AMBA driver
console: msm_serial: driver initialized
console: cacheinfo: Unable to detect cache hierarchy for CPU 0
console: mousedev: PS/2 mouse device common for all mice
console: ledtrig-cpu: registered to indicate activity on CPUs
console: dmi-sysfs: dmi entry is absent.
console: bcm2835-mbox 3f00b880.mailbox: mailbox enabled
console: NET: Registered protocol family 10
console: Segment Routing with IPv6
console: mip6: Mobile IPv6
console: NET: Registered protocol family 17
console: mpls_gso: MPLS GSO support
console: registered taskstats version 1
console: zswap: loaded using pool lzo/zbud
console: AppArmor: AppArmor sha1 policy hashing enabled
console: ima: No TPM chip found, activating TPM-bypass! (rc=-19)
console: 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 72, base_baud = 0) is a PL011 rev2
console: console [ttyAMA0] enabled
console: console [ttyAMA0] enabled
console: bootconsole [pl11] disabled
console: bootconsole [pl11] disabled
console: bcm2835-aux-uart 3f215040.serial: irq not found - -517
console: raspberrypi-firmware soc:firmware: Attached to firmware from 1970-01-05 00:12
console: bcm2835-aux-uart 3f215040.serial: irq not found - -517
-console: hctosys: unable to open rtc device (rtc0)
console: uart-pl011 3f201000.serial: no DMA platform data
console: Freeing unused kernel memory: 4480K
\console: mount: mounting devtmpfs on /dev failed: Device or resource busy
-console: Starting logging: OK
\console: Initializing random number generator... done.
/console: Starting network: OK
-console: Found console ttyAMA0
\console: Boot successful.
console: cat /proc/cpuinfo
console: / # cat /proc/cpuinfo
|console: processor     : 0
console: BogoMIPS       : 125.00
console: Featuresuname -a
console: : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
console: CPU implementer        : 0x41
console: CPU architecture: 8
console: CPU variant    : 0x0
console: CPU part       : 0xd03
console: CPU revision   : 4
console: / # uname -a
console: Linux buildroot 4.14.0-3-arm64 #1 SMP Debian 4.14.12-2 (2018-01-06) aarch64 GNU/Linux
console: reboot
console: / # reboot
/console: / # Found console ttyAMA0
\console: Stopping network: OK
|console: Saving random seed... done.
console: Stopping logging: OK
/console: umount: devtmpfs busy - remounted read-only
console: umount: can't unmount /: Invalid argument
console: The system is going down NOW!
console: Sent SIGTERM to all processes
-console: Sent SIGKILL to all processes
console: Requesting system reboot
\console: kvm: exiting hardware virtualization
console: reboot: Restarting system
PASS (36.65 s)
 (4/4) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi3_initrd_sd_temp: /console: [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
console: [    0.000000] Linux version 4.19.71-v8-13ce09db830e+ (sakaki@kurosawa) (gcc version 8.3.0 (Gentoo 8.3.0-r1 p1.1)) #1 SMP PREEMPT Tue Sep 10 13:07:40 GMT 2019
console: [    0.000000] Machine model: Raspberry Pi 3 Model B
console: [    0.000000] earlycon: pl11 at MMIO 0x000000003f201000 (options '')
console: [    0.000000] bootconsole [pl11] enabled
console: [    0.000000] efi: Getting EFI parameters from FDT:
console: [    0.000000] efi: UEFI not found.
console: [    0.000000] cma: Reserved 8 MiB at 0x000000003b800000
-console: [    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x464 with crng_init=0
console: [    0.000000] percpu: Embedded 24 pages/cpu s57368 r8192 d32744 u98304
console: [    0.000000] Detected VIPT I-cache on CPU0
console: [    0.000000] CPU features: enabling workaround for ARM erratum 843419
console: [    0.000000] CPU features: enabling workaround for ARM erratum 845719
\console: [    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 241920
console: [    0.000000] Kernel command line: printk.time=0 earlycon=pl011,0x3f201000 console=ttyAMA0 root=/dev/mmcblk0 rootwait rw panic=-1 noreboot
console: Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
console: Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
console: Memory: 941500K/983040K available (7676K kernel code, 880K rwdata, 2368K rodata, 2752K init, 918K bss, 33348K reserved, 8192K cma-reserved)
console: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
console: ftrace: allocating 26487 entries in 104 pages
-console: rcu: Preemptible hierarchical RCU implementation.
console: Tasks RCU enabled.
console: NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
console: arch_timer: cp15 timer(s) running at 62.50MHz (phys).
console: clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
console: sched_clock: 56 bits at 62MHz, resolution 16ns, wraps every 4398046511096ns
\console: Console: colour dummy device 80x25
console: Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=62500)
console: pid_max: default: 32768 minimum: 301
console: Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
console: Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
console: ASID allocator initialised with 32768 entries
console: rcu: Hierarchical SRCU implementation.
console: EFI services will not be available.
console: smp: Bringing up secondary CPUs ...
console: Detected VIPT I-cache on CPU1
console: CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
console: Detected VIPT I-cache on CPU2
console: CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
console: Detected VIPT I-cache on CPU3
console: CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
console: smp: Brought up 1 node, 4 CPUs
console: SMP: Total of 4 processors activated.
console: CPU features: detected: 32-bit EL0 Support
|console: CPU: All CPU(s) started at EL2
console: alternatives: patching kernel code
console: devtmpfs: initialized
console: Enabled cp15_barrier support
console: Enabled setend support
console: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
console: futex hash table entries: 1024 (order: 4, 65536 bytes)
console: pinctrl core: initialized pinctrl subsystem
console: DMI not present or invalid.
console: NET: Registered protocol family 16
/console: cpuidle: using governor menu
console: vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
console: hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
console: DMA: preallocated 256 KiB pool for atomic allocations
console: Serial: AMBA PL011 UART driver
console: bcm2835-mbox 3f00b880.mailbox: mailbox enabled
\console: bcm2835-dma 3f007000.dma: DMA legacy API manager at (____ptrval____), dmachans=0x1
console: SCSI subsystem initialized
console: usbcore: registered new interface driver usbfs
console: usbcore: registered new interface driver hub
console: usbcore: registered new device driver usb
console: raspberrypi-firmware soc:firmware: Attached to firmware from 1970-01-05 00:12, variant unknown
console: raspberrypi-firmware soc:firmware: Firmware hash is ffffffff08542080ffffff8008023bb0ffffff80
console: clocksource: Switched to clocksource arch_sys_counter
-console: VFS: Disk quotas dquot_6.6.0
console: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
console: FS-Cache: Loaded
console: CacheFiles: Loaded
\console: NET: Registered protocol family 2
console: tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 8192 bytes)
console: TCP established hash table entries: 8192 (order: 4, 65536 bytes)
console: TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
console: TCP: Hash tables configured (established 8192 bind 8192)
console: UDP hash table entries: 512 (order: 2, 16384 bytes)
console: UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
console: NET: Registered protocol family 1
console: RPC: Registered named UNIX socket transport module.
console: RPC: Registered udp transport module.
console: RPC: Registered tcp transport module.
console: RPC: Registered tcp NFSv4.1 backchannel transport module.
console: hw perfevents: enabled with armv8_cortex_a53 PMU driver, 5 counters available
console: Initialise system trusted keyrings
console: workingset: timestamp_bits=46 max_order=18 bucket_order=0
console: FS-Cache: Netfs 'nfs' registered for caching
console: NFS: Registering the id_resolver key type
console: Key type id_resolver registered
console: Key type id_legacy registered
|console: Key type asymmetric registered
console: Asymmetric key parser 'x509' registered
console: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
console: io scheduler noop registered
console: io scheduler deadline registered
console: io scheduler cfq registered (default)
console: io scheduler mq-deadline registered
console: io scheduler kyber registered
console: bcm2835-aux-uart 3f215040.serial: unable to register 8250 port - -22
console: bcm2835-aux-uart: probe of 3f215040.serial failed with error -22
console: bcm2835-rng 3f104000.rng: hwrng registered
console: vc-mem: phys_addr:0x00000000 mem_base=0x00000000 mem_size:0x00000000(0 MiB)
console: cacheinfo: Unable to detect cache hierarchy for CPU 0
/console: brd: module loaded
console: loop: module loaded
console: Loading iSCSI transport class v2.0-870.
console: libphy: Fixed MDIO Bus: probed
console: usbcore: registered new interface driver lan78xx
console: usbcore: registered new interface driver smsc95xx
console: dwc_otg: version 3.00a 10-AUG-2012 (platform bus)
console: dwc2 3f980000.usb: dwc2_core_reset: HANG! AHB Idle timeout GRSTCTL GRSTCTL_AHBIDLE
console: dwc2: probe of 3f980000.usb failed with error -16
console: usbcore: registered new interface driver usb-storage
console: bcm2835_thermal 3f212000.thermal: Clock tsens running at 19200000 Hz is outside of the recommended range: 1.92 to 5MHz
console: bcm2835-wdt bcm2835-wdt: Broadcom BCM2835 watchdog timer
console: bcm2835-cpufreq: min=700000 max=700000
console: raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (0 81)
console: raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (0 81)
console: pwrseq_simple: probe of wifi-pwrseq failed with error -5
console: sdhci: Secure Digital Host Controller Interface driver
console: sdhci: Copyright(c) Pierre Ossman
console: sdhost-bcm2835 3f202000.mmc: /aliases ID not available
console: sdhost: log_buf @ (____ptrval____) (fb840000)
-console: mmc0: sdhost-bcm2835 loaded - DMA enabled (>1)
console: sdhci-pltfm: SDHCI platform and OF driver helper
console: raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 config (0 82)
console: raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 state (0 82)
console: leds-gpio: probe of leds failed with error -5
console: ledtrig-cpu: registered to indicate activity on CPUs
console: hidraw: raw HID events driver (C) Jiri Kosina
console: usbcore: registered new interface driver usbhid
console: usbhid: USB HID core driver
console: Initializing XFRM netlink socket
console: NET: Registered protocol family 17
console: Key type dns_resolver registered
console: mmc0: host does not support reading read-only switch, assuming write-enable
console: mmc0: Problem switching card into high-speed mode!
console: registered taskstats version 1
console: Loading compiled-in X.509 certificates
console: mmc0: new SD card at address 4567
console: mmcblk0: mmc0:4567 QEMU! 10.0 MiB
console: 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 66, base_baud = 0) is a PL011 rev2
console: console [ttyAMA0] enabled
console: console [ttyAMA0] enabled
console: bootconsole [pl11] disabled
console: bootconsole [pl11] disabled
console: of_cfs_init
console: of_cfs_init: OK
console: uart-pl011 3f201000.serial: no DMA platform data
console: EXT4-fs (mmcblk0): mounting ext2 file system using the ext4 subsystem
console: EXT4-fs (mmcblk0): mounted filesystem without journal. Opts: (null)
console: VFS: Mounted root (ext2 filesystem) on device 179:0.
\console: devtmpfs: mounted
console: Freeing unused kernel memory: 2752K
console: Run /sbin/init as init process
\console: mount: mounting devtmpfs on /dev failed: Device or resource busy
|console: EXT4-fs (mmcblk0): re-mounted. Opts: (null)
|console: Starting logging: OK
|console: Initializing random number generator... random: dd: uninitialized urandom read (512 bytes read)
console: done.
\console: Starting network: OK
/console: Found console ttyAMA0
\console: Boot successful.
console: cat /proc/cpuinfo
|console: / # cat /proc/cpuinfo
/console: processor     : 0
console: BogoMIPS       : 125.00
console: Features       : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
console: CPU implementer        : 0x41
console: CPU architecture: 8
console: CPU variant    : 0x0
console: CPU part       : 0xd03
console: CPU revision   : 4
console: processor      : 1
console: BogoMIPS       : 125.00
console: Features       : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
console: CPU implementer        : 0x41
console: CPU architecture: 8
console: CPU variant    : 0x0
console: CPU part       : 0xd03
console: CPU revision   : 4
console: processor      : 2
console: BogoMIPS       : 125.00
console: Features       : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
console: CPU implementer        : 0x41
console: CPU architecture: 8
console: CPU variant    : 0x0
console: CPU part       : 0xd03
console: CPU revision   : 4
console: processor      : 3
console: BogoMIPS       : 125.00
console: Features       : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
console: CPU implementer        : 0x41
console: CPU architecture: 8
console: CPU variant    : 0x0
console: CPU part       : 0xd03
console: CPU revision   : 4
console: Hardware       : BCM2835
console: Model          : Raspberry Pi 3 Model B
console: cat /sys/devices/virtual/thermal/thermal_zone0/temp
console: / # cat /sys/devices/virtual/thermal/thermal_zone0/temp
console: 25178
console: reboot
-console: / # reboot
\console: / # Found console ttyAMA0
\console: Stopping network: hrtimer: interrupt took 5480528 ns
/console: OK
\console: Saving random seed... random: dd: uninitialized urandom read (512 bytes read)
console: done.
/console: Stopping logging: OK
\console: umount: devtmpfs busy - remounted read-only
console: EXT4-fs (mmcblk0): re-mounted. Opts: (null)
console: The system is going down NOW!
console: Sent SIGTERM to all processes
|console: Sent SIGKILL to all processes
console: Requesting system reboot
/console: reboot: Restarting system
PASS (66.14 s)
RESULTS    : PASS 4 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
JOB TIME   : 116.67 s

Philippe Mathieu-Daudé (19):
  hw/arm/raspi: Use the IEC binary prefix definitions
  hw/arm/bcm2835_peripherals: Improve logging
  hw/arm/bcm2835_peripherals: Name various address spaces
  hw/arm/bcm2835: Rename some definitions
  hw/arm/bcm2835: Add various unimplemented peripherals
  hw/char/bcm2835_aux: Add trace events
  hw/misc/bcm2835_mbox: Add trace events
  hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal sensor
  hw/arm/bcm2835_peripherals: Use the thermal sensor block
  hw/timer/bcm2835: Add the BCM2835 SYS_timer
  hw/arm/bcm2835_peripherals: Use the SYS_timer
  hw/arm/bcm2835_peripherals: Add Clock/Power/Reset Manager blocks
  hw/arm/raspi: Define various blocks base addresses
  python/qemu/machine: Allow to use other serial consoles than default
  tests/boot_linux_console: Extract the gunzip() helper
  tests/boot_linux_console: Add a test for the Raspberry Pi 2
  tests/boot_linux_console: Test the raspi2 UART1 (16550 based)
  tests/boot_linux_console: Boot Linux and run few commands on raspi3
  tests/boot_linux_console: Test SDHCI and termal sensor on raspi3

 hw/arm/bcm2835_peripherals.c           |  86 +++++-
 hw/arm/bcm2836.c                       |   2 +-
 hw/arm/raspi.c                         |   4 +-
 hw/char/bcm2835_aux.c                  |  60 ++--
 hw/char/trace-events                   |   4 +
 hw/display/bcm2835_fb.c                |   2 +-
 hw/dma/bcm2835_dma.c                   |  10 +-
 hw/intc/bcm2836_control.c              |   7 +-
 hw/misc/Makefile.objs                  |   2 +
 hw/misc/bcm2835_cprman.c               | 383 +++++++++++++++++++++++++
 hw/misc/bcm2835_mbox.c                 |  14 +-
 hw/misc/bcm2835_property.c             |  20 +-
 hw/misc/bcm2835_thermal.c              | 109 +++++++
 hw/misc/trace-events                   |  14 +
 hw/timer/Makefile.objs                 |   1 +
 hw/timer/bcm2835_systmr.c              | 100 +++++++
 hw/timer/trace-events                  |   4 +
 include/hw/arm/bcm2835_peripherals.h   |  18 ++
 include/hw/arm/raspi_platform.h        |  70 +++--
 include/hw/misc/bcm2835_cprman.h       |  32 +++
 include/hw/misc/bcm2835_thermal.h      |  27 ++
 include/hw/timer/bcm2835_systmr.h      |  30 ++
 python/qemu/machine.py                 |   5 +-
 tests/acceptance/boot_linux_console.py | 147 +++++++++-
 24 files changed, 1087 insertions(+), 64 deletions(-)
 create mode 100644 hw/misc/bcm2835_cprman.c
 create mode 100644 hw/misc/bcm2835_thermal.c
 create mode 100644 hw/timer/bcm2835_systmr.c
 create mode 100644 include/hw/misc/bcm2835_cprman.h
 create mode 100644 include/hw/misc/bcm2835_thermal.h
 create mode 100644 include/hw/timer/bcm2835_systmr.h

-- 
2.20.1


