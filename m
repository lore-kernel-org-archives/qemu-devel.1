Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4922AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CBE2076F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Taictrs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CBE2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGmRc-0006QC-1n
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 12:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sophian.yoma@gmail.com>) id 1jGmQU-0005ZV-B7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sophian.yoma@gmail.com>) id 1jGmQS-00075o-2l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:29:14 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sophian.yoma@gmail.com>)
 id 1jGmQR-00074A-Sd
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:29:12 -0400
Received: by mail-pl1-x644.google.com with SMTP id e1so2578079plt.9
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x5WUmBphe+z2qsIPn5r944BIYeBp3I7D5SYY6KiJG1g=;
 b=Taictrs6IQ8of95VOU+R7RvcNuwekU4cjbKqqm9Gtioy94yUVg1hGSR4yI5WhZ5z2Y
 9WtglZvDBlRy70zyp/wfv1IjoAhkr33wG71juVDWshmvhG5wzpzMpVYNOobF7GeC6YU+
 3bo8nxmWPMX0yzXKceCm3Tczf2NQbEl4k8dcNP7JPeqgl6svSXYIaFccWMFlrV2EyzBF
 oiP728K79YWdvviZSHZWtDTDh4dTjsqBN4ohIQvdwsyDb+g5QQQhKCysWzFzP8gf+S3V
 85uvZoFy7ti22YY5Y9fWBs5B5x47NlflOZ8l6QWk+UgiRCFQbeFpb0bwM8xR8H3w8Q/m
 xYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x5WUmBphe+z2qsIPn5r944BIYeBp3I7D5SYY6KiJG1g=;
 b=M5D417P6qm7WWFud2bA2+eZ72DBifx5azwF+hFoZMgUiF3jaC6380Rx/SvhA8zCQsJ
 Qnw/CfHKmOGeRgWaoSNUa29fETmX4dUfz+7tjHKxYKBnPw7+0TU9fEZbP4x6rrUTSHKC
 5xqMZBVFbR2Nksq/pdY7U/JgDNmPvSnElJwoxTaoQxvT9VeEdAnziGd10ChB1wXQ4e2L
 X1vKlvMEjAUsicJY8CGp4syJ97ZtUYg1LRfRf/Z0G9861j4A8teQ0rHoHksXNIpid2Mq
 pNj7tsK3b9EG3TFuArYx/RGMsE62wqdObpjpVCVEFt3NXRUOCKknl2aryfPRXNWELqqx
 fTGQ==
X-Gm-Message-State: ANhLgQ2GRHJlRaJGS7ZBTEgQ4ZNXwORCiRFNAHr/5Fz/ZqN5aTWJYBuI
 QcYUKy0+iZTyWWHOYLMwczq5k44EYfalWUw/rK8=
X-Google-Smtp-Source: ADFU+vs//WVCOnXkcTOgJeIc2mqhw63aX9kiqxzUhTSJ4CIc9ChCT0//aIdFrQd8y4ePL2oKOa/ILcDgOuMcinA4Ovw=
X-Received: by 2002:a17:902:bd90:: with SMTP id
 q16mr1911512pls.143.1585067350382; 
 Tue, 24 Mar 2020 09:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <CADUS3onjS+T-SSYC6ocKNm3oXsCpiQbDa0eJobhOnts3gZ_gEw@mail.gmail.com>
 <CAFEAcA8tU58_Bdpp7tmpF+X4D5zyxpV4pA-wz97EpP41SQ7sqA@mail.gmail.com>
 <CADUS3o=1XSzi-DdK2gNm4-WEwPsEWc8Tfn4j9Fxy92JAg9Lktw@mail.gmail.com>
 <CAFEAcA94V+8qPyfMyvk8+F3_KpOG7sBcpc5DViDE+jZ1aEwA9A@mail.gmail.com>
In-Reply-To: <CAFEAcA94V+8qPyfMyvk8+F3_KpOG7sBcpc5DViDE+jZ1aEwA9A@mail.gmail.com>
From: yoma sophian <sophian.yoma@gmail.com>
Date: Wed, 25 Mar 2020 00:28:59 +0800
Message-ID: <CADUS3on6Dtk7+r2=d2nUJhz87xxJspYJhgDFEWgi3SLVmhHRUw@mail.gmail.com>
Subject: Re: qemu-system-aarch64 windows binary run Arm64 defconfig kernel not
 working
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hi Peter:

> Hi; I can't reproduce this (Linux host) either with QEMU
> head-of-git (commit 29e0855c5af62bbb0b) or with QEMU 4.2.0.
> I used kernel commit 16fbf79b0f83bc7 (which is 5.6-rc7).

In my experiments, the booting fail ONLY happens on Windows qemu binary.

>
> Your repro instructions said to use the upstream (torvalds)
> kernel, but your log file says you were running:
>
> [    0.000000] Linux version 4.14.128-00888-g15ac2b5e934a-dirty
> (mtk20533@mtkslt1006) (Android (5220042 based on r346389c) clang
> version 8.0.7 (https://android.googlesource.com/toolchain/clang
> b55f2d4ebfd35bf643d27dbca1bb228957008617)
> (https://android.googlesource.com/toolchain/llvm
> 3c393fe7a7e13b0fba4ac75a01aa683d7a5b11cd) (based on LLVM 8.0.7svn)) #8
> SMP PREEMPT Thu Feb 20 17:45:16 CST 2020
>

That is my bad.
I originally use kernel 4.4 then tried on kernel 5.5, but both of them
are all booting fail
with windows qemu binary.

Below is upstream kernel 5.5 booting fail log.
BTW, is there any QEMU debug info I can deliver when running its windows binary?
thanks for ur kind help,

[ 0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd070]
[ 0.000000] Linux version 5.5.0-rc7-00017-gb87a2ead99b2
(guest@ubuntu14_04) (gcc version 6.1.1 20160711 (Linaro GCC
6.1-2016.08)) #1 SMP PREEMPT Mon Mar 23 15:05:29 CST 2020
[ 0.000000] Machine model: linux,dummy-virt
[ 0.000000] efi: Getting EFI parameters from FDT:
[ 0.000000] efi: UEFI not found.
[ 0.000000] cma: Reserved 32 MiB at 0x000000007e000000
[ 0.000000] NUMA: No NUMA configuration found
[ 0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x000000007fffffff]
[ 0.000000] NUMA: NODE_DATA [mem 0x7ddf3100-0x7ddf4fff]
[ 0.000000] Zone ranges:
[ 0.000000] DMA [mem 0x0000000040000000-0x000000007fffffff]
[ 0.000000] DMA32 empty
[ 0.000000] Normal empty
[ 0.000000] Movable zone start for each node
[ 0.000000] Early memory node ranges
[ 0.000000] node 0: [mem 0x0000000040000000-0x000000007fffffff]
[ 0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000007fffffff]
[ 0.000000] psci: probing for conduit method from DT.
[ 0.000000] psci: PSCIv0.2 detected in firmware.
[ 0.000000] psci: Using standard PSCI v0.2 function IDs
[ 0.000000] psci: Trusted OS migration not required
[ 0.000000] percpu: Embedded 22 pages/cpu s53016 r8192 d28904 u90112
[ 0.000000] Detected PIPT I-cache on CPU0
[ 0.000000] CPU features: detected: ARM erratum 832075
[ 0.000000] CPU features: detected: ARM erratum 834220
[ 0.000000] CPU features: detected: EL2 vector hardening
[ 0.000000] ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware
[ 0.000000] CPU features: detected: ARM erratum 1319367
[ 0.000000] Built 1 zonelists, mobility grouping on. Total pages: 258048
[ 0.000000] Policy zone: DMA
[ 0.000000] Kernel command line: console=ttyAMA0 root=/dev/vda
[ 0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576
bytes, linear)
[ 0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288
bytes, linear)
[ 0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[ 0.000000] Memory: 968848K/1048576K available (12284K kernel code,
1922K rwdata, 6776K rodata, 5184K init, 458K bss, 46960K reserved,
32768K cma-reserved)
[ 0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[ 0.000000] rcu: Preemptible hierarchical RCU implementation.
[ 0.000000] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=2.
[ 0.000000] Tasks RCU enabled.
[ 0.000000] rcu: RCU calculated value of scheduler-enlistment delay is
25 jiffies.
[ 0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[ 0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[ 0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
[ 0.000000] random: get_random_bytes called from
start_kernel+0x2b8/0x454 with crng_init=0
[ 0.000000] arch_timer: cp15 timer(s) running at 62.50MHz (virt).
[ 0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
[ 0.000231] sched_clock: 56 bits at 62MHz, resolution 16ns, wraps
every 4398046511096ns
[ 0.009220] Console: colour dummy device 80x25
[ 0.011796] Calibrating delay loop (skipped), value calculated using
timer frequency.. 125.00 BogoMIPS (lpj=250000)
[ 0.011986] pid_max: default: 32768 minimum: 301
[ 0.013212] LSM: Security Framework initializing
[ 0.014729] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[ 0.014779] Mountpoint-cache hash table entries: 2048 (order: 2, 16384
bytes, linear)
[ 0.085147] ASID allocator initialised with 32768 entries
[ 0.094222] rcu: Hierarchical SRCU implementation.
[ 0.107838] EFI services will not be available.
[ 0.109558] smp: Bringing up secondary CPUs ...
[ 0.136498] Detected PIPT I-cache on CPU1
[ 0.137332] CPU1: Booted secondary processor 0x0000000001 [0x411fd070]
[ 0.140722] smp: Brought up 1 node, 2 CPUs
[ 0.140771] SMP: Total of 2 processors activated.
[ 0.140829] CPU features: detected: 32-bit EL0 Support
[ 0.140921] CPU features: detected: CRC32 instructions
[ 0.205018] CPU: All CPU(s) started at EL1
[ 0.205399] alternatives: patching kernel code
[ 0.227472] devtmpfs: initialized
[ 0.238957] KASLR disabled due to lack of seed
[ 0.244182] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[ 0.244358] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[ 0.249066] pinctrl core: initialized pinctrl subsystem
[ 0.262448] thermal_sys: Registered thermal governor 'step_wise'
[ 0.262545] thermal_sys: Registered thermal governor 'power_allocator'
[ 0.263436] DMI not present or invalid.
[ 0.269833] NET: Registered protocol family 16
[ 0.282386] DMA: preallocated 256 KiB pool for atomic allocations
[ 0.282569] audit: initializing netlink subsys (disabled)
[ 0.285159] audit: type=2000 audit(0.236:1): state=initialized
audit_enabled=0 res=1
[ 0.291762] cpuidle: using governor menu
[ 0.293291] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[ 0.300776] Serial: AMBA PL011 UART driver
[ 0.333078] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 39,
base_baud = 0) is a PL011 rev1
[ 0.351253] printk: console [ttyAMA0] enabled
[ 0.388955] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[ 0.389332] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[ 0.389638] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[ 0.389938] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[ 0.425032] cryptd: max_cpu_qlen set to 1000
[ 0.450001] ACPI: Interpreter disabled.
[ 0.454581] iommu: Default domain type: Translated
[ 0.456965] vgaarb: loaded
[ 0.460952] SCSI subsystem initialized
[ 0.466230] usbcore: registered new interface driver usbfs
[ 0.466835] usbcore: registered new interface driver hub
[ 0.467468] usbcore: registered new device driver usb
[ 0.469247] pps_core: LinuxPPS API ver. 1 registered
[ 0.469443] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[ 0.469834] PTP clock support registered
[ 0.470386] EDAC MC: Ver: 3.0.0
[ 0.474573] FPGA manager framework
[ 0.475525] Advanced Linux Sound Architecture Driver Initialized.
[ 0.487929] clocksource: Switched to clocksource arch_sys_counter
[ 0.489422] VFS: Disk quotas dquot_6.6.0
[ 0.489839] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[ 0.494808] pnp: PnP ACPI: disabled
[ 0.521542] NET: Registered protocol family 2
[ 0.529604] tcp_listen_portaddr_hash hash table entries: 512 (order:
1, 8192 bytes, linear)
[ 0.530031] TCP established hash table entries: 8192 (order: 4, 65536
bytes, linear)
[ 0.530505] TCP bind hash table entries: 8192 (order: 5, 131072 bytes, linear)
[ 0.531009] TCP: Hash tables configured (established 8192 bind 8192)
[ 0.533297] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[ 0.533820] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[ 0.535875] NET: Registered protocol family 1
[ 0.540835] RPC: Registered named UNIX socket transport module.
[ 0.541123] RPC: Registered udp transport module.
[ 0.541295] RPC: Registered tcp transport module.
[ 0.541448] RPC: Registered tcp NFSv4.1 backchannel transport module.
[ 0.541796] PCI: CLS 0 bytes, default 64
[ 0.550705] hw perfevents: enabled with armv8_pmuv3 PMU driver, 5
counters available
[ 0.551392] kvm [1]: HYP mode not available
[ 0.583448] Initialise system trusted keyrings
[ 0.586039] workingset: timestamp_bits=44 max_order=18 bucket_order=0
[ 0.602088] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[ 0.606029] NFS: Registering the id_resolver key type
[ 0.606739] Key type id_resolver registered
[ 0.607043] Key type id_legacy registered
[ 0.607417] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[ 0.608898] 9p: Installing v9fs 9p2000 file system support
[ 0.625536] Key type asymmetric registered
[ 0.625768] Asymmetric key parser 'x509' registered
[ 0.626292] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[ 0.626704] io scheduler mq-deadline registered
[ 0.626951] io scheduler kyber registered
[ 0.646051] pl061_gpio 9030000.pl061: PL061 GPIO chip registered
[ 0.650026] pci-host-generic 3f000000.pcie: host bridge /pcie@10000000 ranges:
[ 0.650899] pci-host-generic 3f000000.pcie: IO
0x003eff0000..0x003effffff -> 0x0000000000
[ 0.651736] pci-host-generic 3f000000.pcie: MEM
0x0010000000..0x003efeffff -> 0x0010000000
[ 0.652058] pci-host-generic 3f000000.pcie: MEM
0x8000000000..0xffffffffff -> 0x8000000000
[ 0.653399] pci-host-generic 3f000000.pcie: ECAM at [mem
0x3f000000-0x3fffffff] for [bus 00-0f]
[ 0.655059] pci-host-generic 3f000000.pcie: PCI host bridge to bus 0000:00
[ 0.655522] pci_bus 0000:00: root bus resource [bus 00-0f]
[ 0.655854] pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
[ 0.656746] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
[ 0.657397] pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff]
[ 0.659018] Internal error: synchronous external abort: 96000010 [#1]
PREEMPT SMP
[ 0.659642] Modules linked in:
[ 0.660350] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.5.0-rc7-00017-gb87a2ead99b2 #1
[ 0.660839] Hardware name: linux,dummy-virt (DT)
[ 0.661247] pstate: 20000085 (nzCv daIf -PAN -UAO)
[ 0.661456] pc : pci_generic_config_read+0x34/0xd0
[ 0.661648] lr : pci_generic_config_read+0x20/0xd0
[ 0.661837] sp : ffff80001002b8f0
[ 0.661966] x29: ffff80001002b8f0 x28: 0000000000000000
[ 0.662229] x27: ffff8000113e8068 x26: 0000000000000000
[ 0.662434] x25: ffff00003d9fb400 x24: 0000000000000000
[ 0.662651] x23: ffff800011a6d2e8 x22: ffff80001002ba14
[ 0.662788] x21: ffff00003db7b800 x20: ffff80001002b964
[ 0.662951] x19: 0000000000000004 x18: ffffffffffffffff
[ 0.663148] x17: 0000000000000007 x16: 0000000000000001
[ 0.663296] x15: ffff8000118498c8 x14: ffff80009002b657
[ 0.663455] x13: ffff80001002b665 x12: ffff800011861a38
[ 0.663610] x11: 0000000000000000 x10: 0000000005f5e0ff
[ 0.663808] x9 : ffff80001002b5f0 x8 : 000000000000000f
[ 0.663973] x7 : 000000000000000c x6 : 0000000000000000
[ 0.664133] x5 : 0000000000000014 x4 : ffff00003d0a4f00
[ 0.664315] x3 : 0000000000000000 x2 : 0000000000000000
[ 0.664469] x1 : 0000000000000000 x0 : ffff800012000000
[ 0.664836] Call trace:
[ 0.665070] pci_generic_config_read+0x34/0xd0
[ 0.665234] pci_bus_read_config_dword+0xa4/0xc8
[ 0.665422] pci_bus_generic_read_dev_vendor_id+0x34/0x168
[ 0.665619] pci_bus_read_dev_vendor_id+0x48/0x68
[ 0.665795] pci_scan_single_device+0x84/0xf0
[ 0.665981] pci_scan_slot+0x6c/0x120
[ 0.666113] pci_scan_child_bus_extend+0x50/0x298
[ 0.666261] pci_scan_root_bus_bridge+0xd0/0xe8
[ 0.666409] pci_host_probe+0x18/0xc0
[ 0.666549] pci_host_common_probe+0xf0/0x1e8
[ 0.666683] gen_pci_probe+0x2c/0x38
[ 0.666794] platform_drv_probe+0x50/0xb0
[ 0.666916] really_probe+0x108/0x360
[ 0.667050] driver_probe_device+0x58/0x100
[ 0.667204] device_driver_attach+0x6c/0x78
[ 0.667359] __driver_attach+0xb0/0xf0
[ 0.667485] bus_for_each_dev+0x68/0xc8
[ 0.667606] driver_attach+0x20/0x28
[ 0.667754] bus_add_driver+0x160/0x1f0
[ 0.667882] driver_register+0x60/0x110
[ 0.668005] __platform_driver_register+0x44/0x50
[ 0.668158] gen_pci_driver_init+0x18/0x20
[ 0.668292] do_one_initcall+0x58/0x1a0
[ 0.668408] kernel_init_freeable+0x19c/0x20c
[ 0.668542] kernel_init+0x10/0x108
[ 0.668726] ret_from_fork+0x10/0x1c
[ 0.669383] Code: 7100067f 54000400 71000a7f 54000240 (88dffc01)
[ 0.670178] ---[ end trace 828481ecefd863c8 ]---
[ 0.670478] note: swapper/0[1] exited with preempt_count 1
[ 0.670849] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[ 0.671268] SMP: stopping secondary CPUs
[ 0.671669] Kernel Offset: disabled
[ 0.672004] CPU features: 0x10002,20006082
[ 0.672256] Memory Limit: none
[ 0.672801] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

