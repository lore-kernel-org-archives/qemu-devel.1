Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464EEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0289C20737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh92jN/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0289C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHW9P-000094-02
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sophian.yoma@gmail.com>) id 1jHW8l-00085R-5i
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sophian.yoma@gmail.com>) id 1jHW8j-0003nY-0A
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:17:59 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:33071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sophian.yoma@gmail.com>)
 id 1jHW8i-0003m1-PD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:17:56 -0400
Received: by mail-pg1-x532.google.com with SMTP id d17so3214922pgo.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fYjGDS2NX/oQX0v5hpGOSTn8tFNsrZNG+Uta72o6+Ww=;
 b=lh92jN/70yOVErP6r5Jg7wzXCDluC1L+hhvPNgNSo5ZXvfhmrw8Sj/cOSY8bZkKxaU
 8KqDz8FI2g/EGW5heE3855zpD4VYJr9UZzntFOPnRRbtPY9jUyZzfa10yw2kr+okDdAz
 s9w0YzHmfwxTuNuVMgqNNg5Cyu5+rzOHh8xcS0GAsdYBmYhkMnptSw1uXgpurUJqE/w5
 GjjbdQZjkQMpKv9/2G8ksegCGoC4w7P7x6QLRozj/dbGYM6aHx5b9jAPle7OmjwdwZQi
 mQJ1aXNpxCzijYV8ovhSyEPHH1mJOGbOfinjCyi7K1C42pD4cSkOHO13b9Pn3Tv0M2pZ
 EzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fYjGDS2NX/oQX0v5hpGOSTn8tFNsrZNG+Uta72o6+Ww=;
 b=nHkKTlMTyV8HuF+l5DbDOF+ozozmv9tKvIprs0wng6mj3OLBcMpXBMbaU7Ot1uuSTa
 pfXzH955VPNXLq3B6ickSh1yoSYG/A+QXHVjq6QW1GdFrSyWZc9FmbuF6mmqSLr8ZyNV
 pxsX9/oRGJXDYMJagQoUvsd3loT154zJluEx9tnmVsZegv/gsMiP38Gb394DOhTUl43c
 zdiIc44bP0dCR+Gnrm75VJqqkOperK5xdCaiAaavaJWgq6VvlBP1LsIFJtN+JJTCZgoH
 sVuqXXLhRo4DURaPLC4ajTCK1aMeGGQTUo2XlbBDfy2a/LiuG3UhK6s1EQdfdQrgTIWG
 gf/g==
X-Gm-Message-State: ANhLgQ3mWDUxPLEHXauWy/97mld1IvTmoHNjHjAYIqcGd4+VAHsuRSbo
 DlvEV7Et7tws0op2pa8Sb2XVBXjj4Vg56VPwm7s=
X-Google-Smtp-Source: ADFU+vulSCW6AHKgCfpND5n0bTkWXXz2PGCnDmaPqyoFBDPhs3zfzavGKcWf+u4ldaaobRPypKodIAW1YfNBbrWflH0=
X-Received: by 2002:a63:a54:: with SMTP id z20mr9710679pgk.372.1585243075298; 
 Thu, 26 Mar 2020 10:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADUS3onjS+T-SSYC6ocKNm3oXsCpiQbDa0eJobhOnts3gZ_gEw@mail.gmail.com>
 <CAFEAcA8tU58_Bdpp7tmpF+X4D5zyxpV4pA-wz97EpP41SQ7sqA@mail.gmail.com>
 <CADUS3o=1XSzi-DdK2gNm4-WEwPsEWc8Tfn4j9Fxy92JAg9Lktw@mail.gmail.com>
 <CAFEAcA94V+8qPyfMyvk8+F3_KpOG7sBcpc5DViDE+jZ1aEwA9A@mail.gmail.com>
 <CADUS3on6Dtk7+r2=d2nUJhz87xxJspYJhgDFEWgi3SLVmhHRUw@mail.gmail.com>
 <CAFEAcA9ai_WUE6Z+Le4AHGRtsPYkSo8W_hRJ2GTjAK+p6WRi4A@mail.gmail.com>
In-Reply-To: <CAFEAcA9ai_WUE6Z+Le4AHGRtsPYkSo8W_hRJ2GTjAK+p6WRi4A@mail.gmail.com>
From: yoma sophian <sophian.yoma@gmail.com>
Date: Fri, 27 Mar 2020 01:17:43 +0800
Message-ID: <CADUS3ommYf+tDTRwPVKaXxhSBeja50KFS7K_q+WnKDnFchyGQg@mail.gmail.com>
Subject: Re: qemu-system-aarch64 windows binary run Arm64 defconfig kernel not
 working
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::532
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
> Are you using a 32-bit Windows qemu binary or a 64-bit one?
> (I'm wondering if this is a 32-bit vs 64-bit bug.)

unfortunately, 32-bit Windows qemu binary still fail on booting
upstream arm64 defconfig kernel.
in below log, I 1st purposely type wrong option, such that you can
tell where the binary located.
Then as you can see "synchronous external abort" still happens.

thanks for ur kind help,

$ qemu-system-aarch64 -v
C:\Program Files (x86)\qemu\qemu-system-aarch64.exe: -v: invalid option

$ qemu-system-aarch64 --version
QEMU emulator version 4.2.0 (v4.2.0-11797-g2890edc853-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

$ ./run_script/run.sh
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
[ 0.000313] sched_clock: 56 bits at 62MHz, resolution 16ns, wraps
every 4398046511096ns
[ 0.012734] Console: colour dummy device 80x25
[ 0.016333] Calibrating delay loop (skipped), value calculated using
timer frequency.. 125.00 BogoMIPS (lpj=250000)
[ 0.016608] pid_max: default: 32768 minimum: 301
[ 0.018603] LSM: Security Framework initializing
[ 0.020522] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[ 0.020596] Mountpoint-cache hash table entries: 2048 (order: 2, 16384
bytes, linear)
[ 0.109764] ASID allocator initialised with 32768 entries
[ 0.118473] rcu: Hierarchical SRCU implementation.
[ 0.132871] EFI services will not be available.
[ 0.134747] smp: Bringing up secondary CPUs ...
[ 0.178926] Detected PIPT I-cache on CPU1
[ 0.180097] CPU1: Booted secondary processor 0x0000000001 [0x411fd070]
[ 0.185193] smp: Brought up 1 node, 2 CPUs
[ 0.185252] SMP: Total of 2 processors activated.
[ 0.185318] CPU features: detected: 32-bit EL0 Support
[ 0.185433] CPU features: detected: CRC32 instructions
[ 0.215643] CPU: All CPU(s) started at EL1
[ 0.216146] alternatives: patching kernel code
[ 0.248177] devtmpfs: initialized
[ 0.268462] KASLR disabled due to lack of seed
[ 0.274809] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[ 0.275044] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[ 0.282272] pinctrl core: initialized pinctrl subsystem
[ 0.300201] thermal_sys: Registered thermal governor 'step_wise'
[ 0.300320] thermal_sys: Registered thermal governor 'power_allocator'
[ 0.301456] DMI not present or invalid.
[ 0.310602] NET: Registered protocol family 16
[ 0.332898] DMA: preallocated 256 KiB pool for atomic allocations
[ 0.333150] audit: initializing netlink subsys (disabled)
[ 0.336925] audit: type=2000 audit(0.248:1): state=initialized
audit_enabled=0 res=1
[ 0.343107] cpuidle: using governor menu
[ 0.345335] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[ 0.352482] Serial: AMBA PL011 UART driver
[ 0.394376] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 39,
base_baud = 0) is a PL011 rev1
[ 0.412735] printk: console [ttyAMA0] enabled
[ 0.467001] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[ 0.467266] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[ 0.467440] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[ 0.467622] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[ 0.507384] cryptd: max_cpu_qlen set to 1000
[ 0.537532] ACPI: Interpreter disabled.
[ 0.543439] iommu: Default domain type: Translated
[ 0.545728] vgaarb: loaded
[ 0.548771] SCSI subsystem initialized
[ 0.553790] usbcore: registered new interface driver usbfs
[ 0.554385] usbcore: registered new interface driver hub
[ 0.554991] usbcore: registered new device driver usb
[ 0.557793] pps_core: LinuxPPS API ver. 1 registered
[ 0.557960] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[ 0.558365] PTP clock support registered
[ 0.559200] EDAC MC: Ver: 3.0.0
[ 0.575205] FPGA manager framework
[ 0.576756] Advanced Linux Sound Architecture Driver Initialized.
[ 0.597299] clocksource: Switched to clocksource arch_sys_counter
[ 0.599284] VFS: Disk quotas dquot_6.6.0
[ 0.599669] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[ 0.602371] pnp: PnP ACPI: disabled
[ 0.630821] NET: Registered protocol family 2
[ 0.643916] tcp_listen_portaddr_hash hash table entries: 512 (order:
1, 8192 bytes, linear)
[ 0.644357] TCP established hash table entries: 8192 (order: 4, 65536
bytes, linear)
[ 0.645308] TCP bind hash table entries: 8192 (order: 5, 131072 bytes, linear)
[ 0.646197] TCP: Hash tables configured (established 8192 bind 8192)
[ 0.650350] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[ 0.651015] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[ 0.653868] NET: Registered protocol family 1
[ 0.666347] RPC: Registered named UNIX socket transport module.
[ 0.666645] RPC: Registered udp transport module.
[ 0.666779] RPC: Registered tcp transport module.
[ 0.666912] RPC: Registered tcp NFSv4.1 backchannel transport module.
[ 0.667290] PCI: CLS 0 bytes, default 64
[ 0.679016] hw perfevents: enabled with armv8_pmuv3 PMU driver, 5
counters available
[ 0.680728] kvm [1]: HYP mode not available
[ 0.722870] Initialise system trusted keyrings
[ 0.726140] workingset: timestamp_bits=44 max_order=18 bucket_order=0
[ 0.756716] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[ 0.763460] NFS: Registering the id_resolver key type
[ 0.764417] Key type id_resolver registered
[ 0.764740] Key type id_legacy registered
[ 0.765560] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[ 0.767085] 9p: Installing v9fs 9p2000 file system support
[ 0.797365] Key type asymmetric registered
[ 0.797624] Asymmetric key parser 'x509' registered
[ 0.798510] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[ 0.799155] io scheduler mq-deadline registered
[ 0.799438] io scheduler kyber registered
[ 0.830765] pl061_gpio 9030000.pl061: PL061 GPIO chip registered
[ 0.838016] pci-host-generic 3f000000.pcie: host bridge /pcie@10000000 ranges:
[ 0.839143] pci-host-generic 3f000000.pcie: IO
0x003eff0000..0x003effffff -> 0x0000000000
[ 0.840424] pci-host-generic 3f000000.pcie: MEM
0x0010000000..0x003efeffff -> 0x0010000000
[ 0.840864] pci-host-generic 3f000000.pcie: MEM
0x8000000000..0xffffffffff -> 0x8000000000
[ 0.842407] pci-host-generic 3f000000.pcie: ECAM at [mem
0x3f000000-0x3fffffff] for [bus 00-0f]
[ 0.845097] pci-host-generic 3f000000.pcie: PCI host bridge to bus 0000:00
[ 0.845705] pci_bus 0000:00: root bus resource [bus 00-0f]
[ 0.846074] pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
[ 0.846263] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
[ 0.846544] pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff]
[ 0.848766] Internal error: synchronous external abort: 96000010 [#1]
PREEMPT SMP
[ 0.849165] Modules linked in:
[ 0.849774] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
5.5.0-rc7-00017-gb87a2ead99b2 #1
[ 0.850021] Hardware name: linux,dummy-virt (DT)
[ 0.850410] pstate: 20000085 (nzCv daIf -PAN -UAO)
[ 0.850596] pc : pci_generic_config_read+0x34/0xd0
[ 0.850751] lr : pci_generic_config_read+0x20/0xd0
[ 0.850892] sp : ffff80001002b8f0
[ 0.851008] x29: ffff80001002b8f0 x28: 0000000000000000
[ 0.851208] x27: ffff8000113e8068 x26: 0000000000000000
[ 0.851338] x25: ffff00003d9ff400 x24: 0000000000000000
[ 0.851502] x23: ffff800011a6d2e8 x22: ffff80001002ba14
[ 0.851656] x21: ffff00003db06000 x20: ffff80001002b964
[ 0.851818] x19: 0000000000000004 x18: ffffffffffffffff
[ 0.851970] x17: 0000000000000007 x16: 0000000000000001
[ 0.852122] x15: ffff8000118498c8 x14: ffff80009002b657
[ 0.852289] x13: ffff80001002b665 x12: ffff800011861a38
[ 0.852433] x11: 0000000000000000 x10: 0000000005f5e0ff
[ 0.852620] x9 : ffff80001002b5f0 x8 : 000000000000000f
[ 0.852810] x7 : 000000000000000c x6 : 0000000000000000
[ 0.853247] x5 : 0000000000000014 x4 : ffff00003db4f900
[ 0.853415] x3 : 0000000000000000 x2 : 0000000000000000
[ 0.853589] x1 : 0000000000000000 x0 : ffff800012000000
[ 0.854020] Call trace:
[ 0.854307] pci_generic_config_read+0x34/0xd0
[ 0.854481] pci_bus_read_config_dword+0xa4/0xc8
[ 0.854646] pci_bus_generic_read_dev_vendor_id+0x34/0x168
[ 0.854827] pci_bus_read_dev_vendor_id+0x48/0x68
[ 0.854968] pci_scan_single_device+0x84/0xf0
[ 0.855130] pci_scan_slot+0x6c/0x120
[ 0.855241] pci_scan_child_bus_extend+0x50/0x298
[ 0.855395] pci_scan_root_bus_bridge+0xd0/0xe8
[ 0.855550] pci_host_probe+0x18/0xc0
[ 0.855690] pci_host_common_probe+0xf0/0x1e8
[ 0.855819] gen_pci_probe+0x2c/0x38
[ 0.855952] platform_drv_probe+0x50/0xb0
[ 0.856077] really_probe+0x108/0x360
[ 0.856199] driver_probe_device+0x58/0x100
[ 0.856329] device_driver_attach+0x6c/0x78
[ 0.856467] __driver_attach+0xb0/0xf0
[ 0.856599] bus_for_each_dev+0x68/0xc8
[ 0.856714] driver_attach+0x20/0x28
[ 0.856831] bus_add_driver+0x160/0x1f0
[ 0.856964] driver_register+0x60/0x110
[ 0.857087] __platform_driver_register+0x44/0x50
[ 0.857230] gen_pci_driver_init+0x18/0x20
[ 0.857346] do_one_initcall+0x58/0x1a0
[ 0.857465] kernel_init_freeable+0x19c/0x20c
[ 0.857610] kernel_init+0x10/0x108
[ 0.857705] ret_from_fork+0x10/0x1c
[ 0.858448] Code: 7100067f 54000400 71000a7f 54000240 (88dffc01)
[ 0.859497] ---[ end trace 251a70cc566bf644 ]---
[ 0.860322] note: swapper/0[1] exited with preempt_count 1
[ 0.860760] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[ 0.861148] SMP: stopping secondary CPUs
[ 0.861807] Kernel Offset: disabled
[ 0.862230] CPU features: 0x10002,20006082
[ 0.862395] Memory Limit: none
[ 0.862751] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

