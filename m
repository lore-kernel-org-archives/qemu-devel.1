Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A70CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 05:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD84206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 05:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD84206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMQTc-0000I9-Uk
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 01:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iMQRB-0007Ar-Cs
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 01:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iMQR8-0004aA-EH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 01:41:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:58904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iMQR8-0004ZZ-3j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 01:40:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iMQR6-0003um-2u
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 05:40:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1445C2E80C3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 05:40:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Oct 2019 05:33:10 -0000
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: kvm powerpcm qemu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aik-ozlabs dwg sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Satheesh Rajendran (sathnaga)
References: <157061153044.21976.18153238088035049329.malonedeb@gac.canonical.com>
Message-Id: <157163599061.9920.18172508080925201943.malone@soybean.canonical.com>
Subject: [Bug 1847440] Re: ppc64le: KVM guest fails to boot with an error
 `virtio_scsi: probe of virtio1 failed with error -22` on master
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4edb9762df913aa69ac07f486c3973e5e3054c10
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
Reply-To: Bug 1847440 <1847440@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Domain vm1 started
Connected to domain vm1
Escape character is ^]
Populating /vdevice methods
Populating /vdevice/vty@30000000
Populating /vdevice/nvram@71000000
Populating /pci@800000020000000
                     00 0800 (D) : 1af4 1000    virtio [ net ]
                     00 1000 (D) : 1af4 1004    virtio [ scsi ]
Populating /pci@800000020000000/scsi@2
       SCSI: Looking for devices
          100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
                     00 1800 (D) : 1b36 000d    serial bus [ usb-xhci ]
                     00 2000 (D) : 1af4 1002    unknown-legacy-device*
No NVRAM common partition, re-initializing...
Scanning USB =

  XHCI: Initializing
Using default console: /vdevice/vty@30000000
     =

  Welcome to Open Firmware

  Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php


Trying to load:  from: /pci@800000020000000/scsi@2/disk@100000000000000 ...=
   Successfully loaded


OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 4.13.9-300.fc27.ppc64le (mockbuild@buildvm-=
ppc64le-06.ppc.fedoraproject.org) (gcc version 7.2.1 20170915 (Red Hat 7.2.=
1-2) (GCC)) #1 SMP Mon Oct 23 13:28:27 UTC 2017
Detected machine type: 0000000000000101
command line: BOOT_IMAGE=3D/boot/vmlinuz-4.13.9-300.fc27.ppc64le root=3DUUI=
D=3D500d2159-c568-459e-8864-1c21b3519a80 ro console=3Dtty0 console=3DttyS0,=
115200 console=3Dhvc0
Max number of cores passed to firmware: 1024 (NR_CPUS =3D 1024)
Calling ibm,client-architecture-support...Node not supported =

Node not supported =

 not implemented
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000046a0000
  alloc_top    : 0000000010000000
  alloc_top_hi : 0000001400000000
  rmo_top      : 0000000010000000
  ram_top      : 0000001400000000
instantiating rtas at 0x000000000daf0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000046b0000 -> 0x00000000046b0b3f
Device tree struct  0x00000000046c0000 -> 0x00000000046d0000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000002000000 ...
[    0.000000] Page sizes from device-tree:
[    0.000000] Page size shift =3D 12 AP=3D0x0
[    0.000000] Page size shift =3D 16 AP=3D0x5
[    0.000000] Page size shift =3D 21 AP=3D0x1
[    0.000000] Page size shift =3D 30 AP=3D0x2
[    0.000000] Using radix MMU under hypervisor
[    0.000000] Mapped range 0x0 - 0x1400000000 with 0x40000000
[    0.000000] Process table c0000013ff000000 and radix root for kernel: c0=
000000014c0000
[    0.000000] Linux version 4.13.9-300.fc27.ppc64le (mockbuild@buildvm-ppc=
64le-06.ppc.fedoraproject.org) (gcc version 7.2.1 20170915 (Red Hat 7.2.1-2=
) (GCC)) #1 SMP Mon Oct 23 13:28:27 UTC 2017
[    0.000000] Found initrd at 0xc000000003900000:0xc0000000046967f5
[    0.000000] Using pSeries machine description
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Partition configured for 2 cpus.
[    0.000000] CPU maps initialized for 1 thread per core
 -> smp_release_cpus()
spinning_secondaries =3D 1
 <- smp_release_cpus()
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    =3D 0x0
[    0.000000] phys_mem_size     =3D 0x1400000000
[    0.000000] dcache_bsize      =3D 0x80
[    0.000000] icache_bsize      =3D 0x80
[    0.000000] cpu_features      =3D 0x075c7a7c18500249
[    0.000000]   possible        =3D 0x5fffffff18500649
[    0.000000]   always          =3D 0x0000000018100040
[    0.000000] cpu_user_features =3D 0xdc0065c2 0xaee00000
[    0.000000] mmu_features      =3D 0x3c006041
[    0.000000] firmware_features =3D 0x00000001455a445f
[    0.000000] -----------------------------------------------------
[    0.000000] numa:   NODE_DATA [mem 0x13fffe7e80-0x13ffff1b7f]
[    0.000000] PCI host bridge /pci@800000020000000  ranges:
[    0.000000]   IO 0x0000200000000000..0x000020000000ffff -> 0x00000000000=
00000
[    0.000000]  MEM 0x0000200080000000..0x00002000ffffffff -> 0x00000000800=
00000 =

[    0.000000]  MEM 0x0000210000000000..0x000021ffffffffff -> 0x00002100000=
00000 =

[    0.000000] OF: PCI: PROBE_ONLY disabled
[    0.000000] PPC64 nvram contains 65536 bytes
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000013ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x00000013ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000013fffff=
fff]
[    0.000000] percpu: Embedded 3 pages/cpu @c0000013fef80000 s151064 r0 d4=
5544 u196608
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 1309440
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-4.13.9-300.f=
c27.ppc64le root=3DUUID=3D500d2159-c568-459e-8864-1c21b3519a80 ro console=
=3Dtty0 console=3DttyS0,115200 console=3Dhvc0
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] Memory: 83754240K/83886080K available (11968K kernel code, 1=
792K rwdata, 3136K rodata, 4288K init, 2405K bss, 131840K reserved, 0K cma-=
reserved)
[    0.000000] random: get_random_u64 called from cache_random_seq_create+0=
xa0/0x180 with crng_init=3D0
[    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D2, =
Nodes=3D1
[    0.000000] ftrace: allocating 29419 entries in 11 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D1024 to nr_cpu_ids=3D2.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
[    0.000000] time_init: 56 bit decrementer (max: 7fffffffffffff)
[    0.000483] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: =
0x761537d007, max_idle_ns: 440795202126 ns
[    0.001327] clocksource: timebase mult[1f40000] shift[24] registered
[    0.001868] Console: colour dummy device 80x25
[    0.002310] console [tty0] enabled
[    0.002588] console [hvc0] enabled
[    0.002588] console [hvc0] enabled
[    0.002890] bootconsole [udbg0] disabled
[    0.002890] bootconsole [udbg0] disabled
[    0.003238] pid_max: default: 32768 minimum: 301
[    0.003336] Security Framework initialized
[    0.003361] Yama: becoming mindful.
[    0.003387] SELinux:  Initializing.
[    0.008989] Dentry cache hash table entries: 8388608 (order: 10, 6710886=
4 bytes)
[    0.011926] Inode-cache hash table entries: 4194304 (order: 9, 33554432 =
bytes)
[    0.012030] Mount-cache hash table entries: 131072 (order: 4, 1048576 by=
tes)
[    0.012237] Mountpoint-cache hash table entries: 131072 (order: 4, 10485=
76 bytes)
[    0.012576] EEH: pSeries platform initialized
[    0.012611] POWER9 performance monitor hardware support registered
[    0.012664] Hierarchical SRCU implementation.
[    0.013001] smp: Bringing up secondary CPUs ...
[    0.015623] smp: Brought up 1 node, 2 CPUs
[    0.015662] numa: Node 0 CPUs: 0-1
[    0.019886] devtmpfs: initialized
[    0.024963] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 19112604462750000 ns
[    0.025027] futex hash table entries: 512 (order: 0, 65536 bytes)
[    0.025177] NET: Registered protocol family 16
[    0.027932] EEH: No capable adapters found
[    0.030363] cpuidle: using governor menu
[    0.031979] pstore: using zlib compression
[    0.032005] pstore: Registered nvram as persistent store backend
Linux ppc64le
#1 SMP Mon Oct 2[    0.035136] PCI: Probing PCI hardware
[    0.035185] PCI host bridge to bus 0000:00
[    0.035210] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bu=
s address [0x0000-0xffff])
[    0.035260] pci_bus 0000:00: root bus resource [mem 0x200080000000-0x200=
0ffffffff] (bus address [0x80000000-0xffffffff])
[    0.035318] pci_bus 0000:00: root bus resource [mem 0x210000000000-0x21f=
fffffffff]
[    0.035360] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.037044] IOMMU table initialized, virtual merging enabled
[    0.037088] iommu: Adding device 0000:00:01.0 to group 0, default domain=
 type -1
[    0.037145] pci 0000:00:01.0: of_irq_parse_pci: failed with rc=3D134
[    0.037190] iommu: Adding device 0000:00:02.0 to group 0, default domain=
 type -1
[    0.037242] pci 0000:00:02.0: of_irq_parse_pci: failed with rc=3D134
[    0.037286] iommu: Adding device 0000:00:03.0 to group 0, default domain=
 type -1
[    0.037337] pci 0000:00:03.0: of_irq_parse_pci: failed with rc=3D134
[    0.037380] iommu: Adding device 0000:00:04.0 to group 0, default domain=
 type -1
[    0.037442] pci 0000:00:04.0: of_irq_parse_pci: failed with rc=3D134
[    0.043219] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.043275] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.051951] vgaarb: loaded
[    0.052021] SCSI subsystem initialized
[    0.054039] usbcore: registered new interface driver usbfs
[    0.054076] usbcore: registered new interface driver hub
[    0.054113] usbcore: registered new device driver usb
[    0.055226] EDAC MC: Ver: 3.0.0
[    0.060393] NetLabel: Initializing
[    0.060419] NetLabel:  domain hash size =3D 128
[    0.060447] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.060492] NetLabel:  unlabeled traffic allowed by default
[    0.062836] clocksource: Switched to clocksource timebase
[    0.073228] VFS: Disk quotas dquot_6.6.0
[    0.073275] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 by=
tes)
[    0.318455] NET: Registered protocol family 2
[    0.318612] TCP established hash table entries: 524288 (order: 6, 419430=
4 bytes)
[    0.319695] TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
[    0.319940] TCP: Hash tables configured (established 524288 bind 65536)
[    0.320000] UDP hash table entries: 65536 (order: 5, 2097152 bytes)
[    0.320342] UDP-Lite hash table entries: 65536 (order: 5, 2097152 bytes)
[    0.320713] NET: Registered protocol family 1
[    0.320782] pci 0000:00:03.0: enabling device (0000 -> 0002)
[    0.320897] Unpacking initramfs...
[    0.536932] Freeing initrd memory: 13888K
[    0.540445] rtas_flash: no firmware flash support
[    0.540685] audit: initializing netlink subsys (disabled)
[    0.544654] Initialise system trusted keyrings
[    0.544693] Key type blacklist registered
[    0.545355] audit: type=3D2000 audit(1571635628.541:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.547068] workingset: timestamp_bits=3D38 max_order=3D21 bucket_order=
=3D0
[    0.548074] zbud: loaded
[    0.693638] random: fast init done
[    0.756362] NET: Registered protocol family 38
[    0.756416] Key type asymmetric registered
[    0.756450] Asymmetric key parser 'x509' registered
[    0.756535] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 250)
[    0.757780] io scheduler noop registered
[    0.757818] io scheduler deadline registered
[    0.757900] io scheduler cfq registered (default)
[    0.757944] io scheduler mq-deadline registered
[    0.758947] atomic64_test: passed
[    0.773254] libphy: Fixed MDIO Bus: probed
[    0.775507] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.775573] ehci-pci: EHCI PCI platform driver
[    0.775625] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.775685] ohci-pci: OHCI PCI platform driver
[    0.775734] uhci_hcd: USB Universal Host Controller Interface driver
[    0.775841] xhci_hcd 0000:00:03.0: enabling device (0000 -> 0002)
[    0.775953] xhci_hcd 0000:00:03.0: xHCI Host Controller
[    0.777192] xhci_hcd 0000:00:03.0: new USB bus registered, assigned bus =
number 1
[    0.777541] xhci_hcd 0000:00:03.0: ibm,query-pe-dma-windows(2026) 1800 2=
000 0 returned -3
[    0.778091] xhci_hcd 0000:00:03.0: hcc params 0x00087001 hci version 0x1=
00 quirks 0x00000010
[    0.778169] xhci_hcd 0000:00:03.0: No msi-x/msi found and no IRQ in BIOS
[    0.778223] xhci_hcd 0000:00:03.0: startup error -22
[    0.778268] xhci_hcd 0000:00:03.0: USB bus 1 deregistered
[    0.780041] xhci_hcd 0000:00:03.0: init 0000:00:03.0 fail, -22
[    0.780101] xhci_hcd: probe of 0000:00:03.0 failed with error -22
[    0.780174] usbcore: registered new interface driver usbserial
[    0.780233] usbcore: registered new interface driver usbserial_generic
[    0.780291] usbserial: USB Serial support registered for generic
[    0.782554] mousedev: PS/2 mouse device common for all mice
[    0.782886] rtc-generic rtc-generic: rtc core: registered rtc-generic as=
 rtc0
[    0.783012] device-mapper: uevent: version 1.0.3
[    0.784846] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised:=
 dm-devel@redhat.com
[    0.786176] hidraw: raw HID events driver (C) Jiri Kosina
[    0.786257] usbcore: registered new interface driver usbhid
[    0.786300] usbhid: USB HID core driver
[    0.786388] drop_monitor: Initializing network drop monitor service
[    0.786511] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.786564] Initializing XFRM netlink socket
[    0.786734] NET: Registered protocol family 10
[    0.794930] Segment Routing with IPv6
[    0.794983] mip6: Mobile IPv6
[    0.795015] NET: Registered protocol family 17
[    0.800017] registered taskstats version 1
[    0.800060] Loading compiled-in X.509 certificates
[    0.850282] Loaded X.509 cert 'Fedora kernel signing key: a878db2990f3e3=
239cc963ffd6fea115d9415954'
[    0.850347] zswap: loaded using pool lzo/zbud
[    0.857402] Key type big_key registered
[    0.864367] Key type encrypted registered
[    0.865572] rtc-generic rtc-generic: setting system clock to 2019-10-21 =
05:27:08 UTC (1571635628)
[    0.866653] Freeing unused kernel memory: 4288K
[    0.866684] This architecture does not have kernel memory protection.
[    0.872683] systemd[1]: systemd 234 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierar=
chy=3Dhybrid)
[    0.872817] systemd[1]: Detected virtualization kvm.
[    0.872855] systemd[1]: Detected architecture ppc64-le.
[    0.872885] systemd[1]: Running in initial RAM disk.

Welcome to Fedora 27 (Twenty Seven) dracut-046-5.fc27 (Initramfs)!

[    0.873073] systemd[1]: Set hostname to <atest-guest>.
[    0.952006] systemd[1]: Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Audit Socket.
[    0.952292] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
[    0.952488] systemd[1]: Reached target Paths.
[  OK  ] Reached target Paths.
[    0.952639] systemd[1]: Reached target Local File Systems.
[  OK  ] Reached target Local File Systems.
[    0.952816] systemd[1]: Reached target Timers.
[  OK  ] Reached target Timers.
[  OK  ] Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket.
[  OK  ] Reached target Swap.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Created slice System Slice.
         Starting Create Volatile Files and Directories...
         Starting Create list of required st=E2=80=A6ce nodes for the curre=
nt kernel...
[  OK  ] Reached target Slices.
         Starting Journal Service...
         Starting Apply Kernel Variables...
[  OK  ] Started Create Volatile Files and Directories.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Create list of required sta=E2=80=A6vice nodes for the cur=
rent kernel.
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Create Static Device Nodes in /dev.
[    0.967752] audit: type=3D1130 audit(1571635628.603:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-tmpf=
iles-setup-dev comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
         Starting udev Kernel Device Manager...
[  OK  ] Started Journal Service.
[    0.973468] audit: type=3D1130 audit(1571635628.608:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-jour=
nald comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
? terminal=3D? res=3Dsuccess'
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
[    0.975851] audit: type=3D1130 audit(1571635628.610:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-udev=
d comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? t=
erminal=3D? res=3Dsuccess'
         Mounting Kernel Configuration File System...
[  OK  ] Mounted Kernel Configuration File System.
[    1.039675] virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
[    1.039749] virtio-pci 0000:00:01.0: virtio_pci: leaving for legacy driv=
er
[    1.041139] synth uevent: /devices/vio: failed to send uevent
[    1.041140] vio vio: uevent: failed to send synthetic uevent
[  OK  ] Started udev Coldplug all Devices.
[    1.042946] audit: type=3D1130 [audit(1571635628  OK  id=3D1 umid=3D0 au=
id=3D429496] Reached target R7295 ses=3D4294967e295 subj=3Dkernel mote File=
 Systemmsg=3D'unit=3Dsystemsd-udev-trigger c (Pre).omm=3D"systemd" ex
e=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuc=
cess'
[    1.043884] virtio-pci 0000:00:02.0: enabling device (0000 -> 0003)
[    1.043908] virtio-pci 0000:00:02.0: virtio_pci: leaving for legacy driv=
er
[    1.043979] virtio-pci 0000:00:04.0: enabling device (0000 -> 0003)
[    1.044003] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driv=
er
[  OK  ] Reached target Remote File Systems.
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Basic System.
[    1.102715] virtio_scsi: probe of virtio1 failed with error -22
[**    ] A start job is running for dev-disk=E2=80=A619a80.device (1min 50s=
 / no limit)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847440

Title:
  ppc64le: KVM guest fails to boot with an error `virtio_scsi: probe of
  virtio1 failed with error -22` on master

Status in QEMU:
  New

Bug description:
  PowerPC KVM Guest fails to boot on current qemu master, bad commit:
  e68cd0cb5cf49d334abe17231a1d2c28b846afa2

  Env:
  HW: IBM Power9
  Host Kernel: 5.4.0-rc2-00038-ge3280b54afed
  Guest Kernel: 4.13.9-300.fc27.ppc64le
  Qemu: https://github.com/qemu/qemu.git (master)
  Libvirt: 5.4.0

  Guest boot gets stuck:
  ...
  [  OK  ] Mounted Kernel Configuration File System.
  [    7.598740] virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
  [    7.598828] virtio-pci 0000:00:01.0: virtio_pci: leaving for legacy dr=
iver
  [    7.598957] virtio-pci 0000:00:02.0: enabling device (0000 -> 0003)
  [    7.599017] virtio-pci 0000:00:02.0: virtio_pci: leaving for legacy dr=
iver
  [    7.599123] virtio-pci 0000:00:04.0: enabling device (0000 -> 0003)
  [    7.599182] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy dr=
iver
  [    7.620620] synth uevent: /devices/vio: failed to send uevent
  [    7.620624] vio vio: uevent: failed to send synthetic uevent
  [  OK  ] Started udev Coldplug all Devices.
  [    7.624559] audit: type=3D1130 audit(1570610300.990:5): pid=3D1 uid=3D=
0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-ud=
ev-trigger comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
  [  OK  ] Reached target System Initialization.
  [  OK  ] Reached target Basic System.
  [  OK  ] Reached target Remote File Systems (Pre).
  [  OK  ] Reached target Remote File Systems.
  [    7.642961] virtio_scsi: probe of virtio1 failed with error -22
  [ ***  ] A start job is running for dev-disk=E2=80=A621b3519a80.device (1=
4s / no limit)
  ...

  git bisect, yielded a bad commit
  [e68cd0cb5cf49d334abe17231a1d2c28b846afa2] spapr: Render full FDT on
  ibm,client-architecture-support, reverting this commit boot the guest
  properly.

  git bisect start
  # good: [9e06029aea3b2eca1d5261352e695edc1e7d7b8b] Update version for v4.=
1.0 release
  git bisect good 9e06029aea3b2eca1d5261352e695edc1e7d7b8b
  # bad: [98b2e3c9ab3abfe476a2b02f8f51813edb90e72d] Merge remote-tracking b=
ranch 'remotes/stefanha/tags/block-pull-request' into staging
  git bisect bad 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d
  # good: [56e6250ede81b4e4b4ddb623874d6c3cdad4a96d] target/arm: Convert T1=
6, nop hints
  git bisect good 56e6250ede81b4e4b4ddb623874d6c3cdad4a96d
  # good: [5d69cbdfdd5cd6dadc9f0c986899844a0e4de703] tests/tcg: target/s390=
x: Test MVC
  git bisect good 5d69cbdfdd5cd6dadc9f0c986899844a0e4de703
  # good: [88112488cf228df8b7588c8aa38e16ecd0dff48e] qapi: Make check_type(=
)'s array case a bit more obvious
  git bisect good 88112488cf228df8b7588c8aa38e16ecd0dff48e
  # good: [972bd57689f1e11311d86b290134ea2ed9c7c11e] ppc/kvm: Skip writing =
DPDES back when in run time state
  git bisect good 972bd57689f1e11311d86b290134ea2ed9c7c11e
  # bad: [1aba8716c8335e88b8c358002a6e1ac89f7dd258] ppc/pnv: Remove the XIC=
SFabric Interface from the POWER9 machine
  git bisect bad 1aba8716c8335e88b8c358002a6e1ac89f7dd258
  # bad: [00ed3da9b5c2e66e796a172df3e19545462b9c90] xics: Minor fixes for X=
ICSFabric interface
  git bisect bad 00ed3da9b5c2e66e796a172df3e19545462b9c90
  # good: [33432d7737b53c92791f90ece5dbe3b7bb1c79f5] target/ppc: introduce =
set_dfp{64,128}() helper functions
  git bisect good 33432d7737b53c92791f90ece5dbe3b7bb1c79f5
  # good: [f6d4c423a222f02bfa84a49c3d306d7341ec9bab] target/ppc: remove unn=
ecessary if() around calls to set_dfp{64,128}() in DFP macros
  git bisect good f6d4c423a222f02bfa84a49c3d306d7341ec9bab
  # bad: [e68cd0cb5cf49d334abe17231a1d2c28b846afa2] spapr: Render full FDT =
on ibm,client-architecture-support
  git bisect bad e68cd0cb5cf49d334abe17231a1d2c28b846afa2
  # good: [c4ec08ab70bab90685d1443d6da47293e3aa312a] spapr-pci: Stop provid=
ing assigned-addresses
  git bisect good c4ec08ab70bab90685d1443d6da47293e3aa312a
  # first bad commit: [e68cd0cb5cf49d334abe17231a1d2c28b846afa2] spapr: Ren=
der full FDT on ibm,client-architecture-support

  attached vmxml.

  qemu commandline:
  /home/sath/qemu/ppc64-softmmu/qemu-system-ppc64 -name guest=3Dvm1,debug-t=
hreads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/=
libvirt/qemu/domain-19-vm1/master-key.aes -machine pseries-4.2,accel=3Dkvm,=
usb=3Doff,dump-guest-core=3Doff -m 81920 -overcommit mem-lock=3Doff -smp 51=
2,sockets=3D1,cores=3D128,threads=3D4 -uuid fd4a5d54-0216-490e-82d2-1d4e896=
83b3d -display none -no-user-config -nodefaults -chardev socket,id=3Dcharmo=
nitor,fd=3D24,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3D=
control -rtc base=3Dutc -no-shutdown -boot strict=3Don -device qemu-xhci,id=
=3Dusb,bus=3Dpci.0,addr=3D0x3 -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.=
0,addr=3D0x2 -drive file=3D/home/sath/tests/data/avocado-vt/images/jeos-27-=
ppc64le_vm1.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0 -device s=
csi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Ddrive-scsi=
0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1 -netdev ta=
p,fd=3D26,id=3Dhostnet0,vhost=3Don,vhostfd=3D27 -device virtio-net-pci,netd=
ev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:e6:df:24,bus=3Dpci.0,addr=3D0x1 -cha=
rdev pty,id=3Dcharserial0 -device spapr-vty,chardev=3Dcharserial0,id=3Dseri=
al0,reg=3D0x30000000 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,a=
ddr=3D0x4 -M pseries,ic-mode=3Dxics -msg timestamp=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847440/+subscriptions

