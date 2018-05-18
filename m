Received: from eggs.gnu.org ([2001:4830:134:3::10]:34988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJfb3-0007Vu-LZ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJfb1-0000FY-0s
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:39:01 -0400
From: Christian Zigotzky <chzigotzky@xenosoft.de>
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
	<20180518141642.6ad639ac@bahia.lan>
	<8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
Message-ID: <8fb8a591-081f-97ad-2d26-8941c323f8b2@xenosoft.de>
Date: Fri, 18 May 2018 15:38:40 +0200
MIME-Version: 1.0
In-Reply-To: <8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Subject: Re: [Qemu-devel] [PPC64] P5020DS: Booting from img possible
 (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

Am 18.05.2018 um 14:33 schrieb Christian Zigotzky:
> On 18 May 2018 at 2:16PM, Greg Kurz wrote:
>> On Fri, 18 May 2018 13:50:42 +0200
>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>
>>> On 18 May 2018 at 1:13PM, Greg Kurz wrote:
>>>> And of course your kernel should be built with virtio support.
>>> I think I have enabled virtio support. Please find attached my kernel
>>> config.
>>>
>> Indeed, what about passing root=/dev/vda3 to the kernel ?
>>
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel 
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17 
> -drive 
> file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img,index=0,if=virtio 
> -net nic,vlan=0,model=e1000 -net user,vlan=0 -append "rw 
> root=/dev/vda3" -machine dt_compatible=fsl,,P5020DS
>
> or
>
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel 
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17 
> -machine dt_compatible=fsl,,P5020DS -device virtio-scsi -drive 
> if=none,id=c1,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img 
> -device scsi-cd,drive=c1 -append "root=/dev/vda3"
>
> or
>
> ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel 
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17 
> -machine dt_compatible=fsl,,P5020DS -drive 
> if=virtio,file=/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img 
> -append "root=/dev/vda3"
>
> Output:
>
> [    0.000000] MMU: Supported page sizes
> [    0.000000]          4 KB as direct
> [    0.000000]       4096 KB as direct
> [    0.000000]      16384 KB as direct
> [    0.000000]      65536 KB as direct
> [    0.000000]     262144 KB as direct
> [    0.000000]    1048576 KB as direct
> [    0.000000] MMU: Book3E HW tablewalk not supported
> [    0.000000] Linux version 4.17.0-rc5_A-EON_A1-X5000 
> (christian@christian-virtual-machine) (gcc version 5.4.0 20160609 
> (Ubuntu 5.4.0-6ubuntu1~16.04.4)) #1 SMP Mon May 14 09:34:52 CEST 2018
> [    0.000000] Using CoreNet Generic machine description
> [    0.000000] bootconsole [udbg0] enabled
> [    0.000000] CPU maps initialized for 1 thread per core
> [    0.000000] -----------------------------------------------------
> [    0.000000] phys_mem_size     = 0x80000000
> [    0.000000] dcache_bsize      = 0x40
> [    0.000000] icache_bsize      = 0x40
> [    0.000000] cpu_features      = 0x00000003008001b4
> [    0.000000]   possible        = 0x00000003009003b4
> [    0.000000]   always          = 0x00000003008003b4
> [    0.000000] cpu_user_features = 0xcc008000 0x08000000
> [    0.000000] mmu_features      = 0x000a0010
> [    0.000000] firmware_features = 0x0000000000000000
> [    0.000000] -----------------------------------------------------
> [    0.000000] CoreNet Generic board
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem 
> 0x0000000000000000-0x000000007fffffff]
> [    0.000000] MMU: Allocated 2112 bytes of context maps for 255 contexts
> [    0.000000] percpu: Embedded 21 pages/cpu @        (ptrval) s48080 
> r0 d37936 u1048576
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 
> 517120
> [    0.000000] Kernel command line: root=/dev/vda3
> [    0.000000] Dentry cache hash table entries: 262144 (order: 9, 
> 2097152 bytes)
> [    0.000000] Inode-cache hash table entries: 131072 (order: 8, 
> 1048576 bytes)
> [    0.000000] Memory: 1975688K/2097152K available (12088K kernel 
> code, 2072K rwdata, 8172K rodata, 412K init, 727K bss, 121464K 
> reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]     RCU event tracing is enabled.
> [    0.000000]     RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, 
> nr_cpu_ids=1
> [    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
> [    0.000000] mpic: Setting up MPIC " OpenPIC  " version 1.2 at 
> fe0040000, max 1 CPUs
> [    0.000000] mpic: ISU size: 512, shift: 9, mask: 1ff
> [    0.000000] mpic: Initializing for 512 sources
> [    0.000150] clocksource: timebase: mask: 0xffffffffffffffff 
> max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
> [    0.000485] clocksource: timebase mult[2800000] shift[24] registered
> [    0.004932] Console: colour dummy device 80x25
> [    0.005543] pid_max: default: 32768 minimum: 301
> [    0.006251] Mount-cache hash table entries: 4096 (order: 3, 32768 
> bytes)
> [    0.006441] Mountpoint-cache hash table entries: 4096 (order: 3, 
> 32768 bytes)
> [    0.021361] e500 family performance monitor hardware support 
> registered
> [    0.022294] Hierarchical SRCU implementation.
> [    0.024402] smp: Bringing up secondary CPUs ...
> [    0.024609] smp: Brought up 1 node, 1 CPU
> [    0.024811] Using standard scheduler topology
> [    0.030061] devtmpfs: initialized
> [    0.033704] random: get_random_u32 called from 
> .bucket_table_alloc+0x170/0x1c0 with crng_init=0
> [    0.035459] clocksource: jiffies: mask: 0xffffffff max_cycles: 
> 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.035764] futex hash table entries: 256 (order: 2, 16384 bytes)
> [    0.037098] xor: measuring software checksum speed
> [    0.046584]    8regs     :  2620.000 MB/sec
> [    0.056774]    8regs_prefetch:  2380.000 MB/sec
> [    0.066974]    32regs    :  2608.000 MB/sec
> [    0.077165]    32regs_prefetch:  2360.000 MB/sec
> [    0.077313] xor: using function: 8regs (2620.000 MB/sec)
> [    0.087868] NET: Registered protocol family 16
> [    0.091070] cpuidle: using governor ladder
> [    0.091259] cpuidle: using governor menu
> [    0.097159] Machine: QEMU ppce500
> [    0.097258] SoC family: QorIQ
> [    0.097343] SoC ID: svr:0x00000000, Revision: 0.0
> [    0.111905] PCI: Probing PCI hardware
> [    0.216930] raid6: int64x1  gen()  1324 MB/s
> [    0.234228] raid6: int64x1  xor()   845 MB/s
> [    0.251545] raid6: int64x2  gen()  1718 MB/s
> [    0.268864] raid6: int64x2  xor()  1275 MB/s
> [    0.286186] raid6: int64x4  gen()  1800 MB/s
> [    0.303854] raid6: int64x4  xor()  1316 MB/s
> [    0.321316] raid6: int64x8  gen()   941 MB/s
> [    0.338625] raid6: int64x8  xor()   781 MB/s
> [    0.338752] raid6: using algorithm int64x4 gen() 1800 MB/s
> [    0.338900] raid6: .... xor() 1316 MB/s, rmw enabled
> [    0.339063] raid6: using intx1 recovery algorithm
> [    0.339817] Freescale Elo series DMA driver
> [    0.341262] vgaarb: loaded
> [    0.342302] SCSI subsystem initialized
> [    0.344113] usbcore: registered new interface driver usbfs
> [    0.344428] usbcore: registered new interface driver hub
> [    0.344684] usbcore: registered new device driver usb
> [    0.345268] pps_core: LinuxPPS API ver. 1 registered
> [    0.345404] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
> Rodolfo Giometti <giometti@linux.it>
> [    0.345695] PTP clock support registered
> [    0.348569] EDAC MC: Ver: 3.0.0
> [    0.351386] Advanced Linux Sound Architecture Driver Initialized.
> [    0.355672] NET: Registered protocol family 8
> [    0.355814] NET: Registered protocol family 20
> [    0.359236] clocksource: Switched to clocksource timebase
> [    0.361400] FS-Cache: Loaded
> [    0.362211] CacheFiles: Loaded
> [    0.390263] NET: Registered protocol family 2
> [    0.393486] tcp_listen_portaddr_hash hash table entries: 1024 
> (order: 2, 16384 bytes)
> [    0.393746] TCP established hash table entries: 16384 (order: 5, 
> 131072 bytes)
> [    0.394154] TCP bind hash table entries: 16384 (order: 6, 262144 
> bytes)
> [    0.394505] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.395361] UDP hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.395637] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
> [    0.396638] NET: Registered protocol family 1
> [    0.399430] RPC: Registered named UNIX socket transport module.
> [    0.399619] RPC: Registered udp transport module.
> [    0.399743] RPC: Registered tcp transport module.
> [    0.399867] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.406335] Initialise system trusted keyrings
> [    0.408668] workingset: timestamp_bits=62 max_order=19 bucket_order=0
> [    0.416796] zbud: loaded
> [    0.420149] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.436150] ntfs: driver 2.1.32 [Flags: R/W].
> [    0.436705] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red 
> Hat, Inc.
> [    0.438486] fuse init (API version 7.26)
> [    0.451573] NET: Registered protocol family 38
> [    0.451885] async_tx: api initialized (async)
> [    0.452277] Key type asymmetric registered
> [    0.452455] Asymmetric key parser 'x509' registered
> [    0.452880] Block layer SCSI generic (bsg) driver version 0.4 
> loaded (major 249)
> [    0.453203] io scheduler noop registered
> [    0.453337] io scheduler deadline registered
> [    0.453651] io scheduler cfq registered (default)
> [    0.453798] io scheduler mq-deadline registered
> [    0.453962] io scheduler kyber registered
> [    0.455337] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
> [    0.455484] crc32: self tests passed, processed 225944 bytes in 
> 442445 nsec
> [    0.456221] crc32c: CRC_LE_BITS = 64
> [    0.456327] crc32c: self tests passed, processed 225944 bytes in 
> 226608 nsec
> [    0.486173] crc32_combine: 8373 self tests passed
> [    0.515206] crc32c_combine: 8373 self tests passed
> [    0.689268] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.694784] console [ttyS0] disabled
> [    0.716358] serial8250.0: ttyS0 at MMIO 0xfe0004500 (irq = 42, 
> base_baud = 115200) is a 16550A
> [    0.717314] console [ttyS0] enabled
> [    0.717314] console [ttyS0] enabled
> [    0.717686] bootconsole [udbg0] disabled
> [    0.717686] bootconsole [udbg0] disabled
> [    0.719049] ePAPR hypervisor byte channel driver
> [    0.721125] [drm] radeon kernel modesetting enabled.
> [    0.746621] brd: module loaded
> [    0.759781] loop: module loaded
> [    0.761701] zram: Added device: zram0
> [    0.771074] libphy: Fixed MDIO Bus: probed
> [    0.772711] PPP generic driver version 2.4.2
> [    0.778222] PPP BSD Compression module registered
> [    0.778382] PPP Deflate Compression module registered
> [    0.778614] PPP MPPE Compression module registered
> [    0.778763] NET: Registered protocol family 24
> [    0.780125] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.780421] ehci-pci: EHCI PCI platform driver
> [    0.780682] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    0.781057] ohci-pci: OHCI PCI platform driver
> [    0.781671] ehci-fsl: Freescale EHCI Host controller driver
> [    0.781999] usbcore: registered new interface driver usblp
> [    0.782258] usbcore: registered new interface driver usb-storage
> [    0.782655] usbcore: registered new interface driver usbserial_generic
> [    0.783005] usbserial: USB Serial support registered for generic
> [    0.783247] usbcore: registered new interface driver ftdi_sio
> [    0.783465] usbserial: USB Serial support registered for FTDI USB 
> Serial Device
> [    0.786824] mousedev: PS/2 mouse device common for all mice
> [    0.787567] i2c /dev entries driver
> [    0.793355] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) 
> initialised: dm-devel@redhat.com
> [    0.793900] sdhci: Secure Digital Host Controller Interface driver
> [    0.794146] sdhci: Copyright(c) Pierre Ossman
> [    0.794353] sdhci-pltfm: SDHCI platform and OF driver helper
> [    0.796047] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.796402] hidraw: raw HID events driver (C) Jiri Kosina
> [    0.798040] usbcore: registered new interface driver usbhid
> [    0.798199] usbhid: USB HID core driver
> [    0.798403] Freescale hypervisor management driver
> [    0.798544] fsl-hv: no hypervisor found
> [    0.816356] usbcore: registered new interface driver snd-usb-audio
> [    0.816614] usbcore: registered new interface driver snd-ua101
> [    0.816845] usbcore: registered new interface driver snd-usb-usx2y
> [    0.817389] ipip: IPv4 and MPLS over IPv4 tunneling driver
> [    0.818797] IPv4 over IPsec tunneling driver
> [    0.820198] Initializing XFRM netlink socket
> [    0.821242] NET: Registered protocol family 10
> [    0.830017] Segment Routing with IPv6
> [    0.830723] mip6: Mobile IPv6
> [    0.832292] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    0.834447] NET: Registered protocol family 17
> [    0.834691] NET: Registered protocol family 15
> [    0.835396] lec:lane_module_init: lec.c: initialized
> [    0.835567] mpoa:atm_mpoa_init: mpc.c: initialized
> [    0.835763] l2tp_core: L2TP core driver, V2.0
> [    0.840489] DCCP: Activated CCID 2 (TCP-like)
> [    0.840655] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
> [    0.842064] sctp: Hash tables configured (bind 256/256)
> [    0.847782] NET: Registered protocol family 21
> [    0.849268] Registered RDS/tcp transport
> [    0.849399] tipc: Activated (version 2.0.0)
> [    0.849674] NET: Registered protocol family 30
> [    0.851092] tipc: Started in single node mode
> [    0.853171] Key type dns_resolver registered
> [    0.854525] batman_adv: B.A.T.M.A.N. advanced 2018.1 (compatibility 
> version 15) loaded
> [    0.855060] drmem: No dynamic reconfiguration memory found
> [    0.856447] Loading compiled-in X.509 certificates
> [    0.857307] zswap: loaded using pool lzo/zbud
> [    0.860584] Btrfs loaded, crc32c=crc32c-generic
> [    0.863663] Key type encrypted registered
> [    0.864688] hctosys: unable to open rtc device (rtc0)
> [    0.865363] ALSA device list:
> [    0.865462]   #0: Virtual MIDI Card 1
> [    0.869543] md: Waiting for all devices to be available before 
> autodetect
> [    0.869723] md: If you don't use raid, use raid=noautodetect
> [    0.872156] md: Autodetecting RAID arrays.
> [    0.872294] md: autorun ...
> [    0.872379] md: ... autorun DONE.
> [    0.874278] VFS: Cannot open root device "vda3" or 
> unknown-block(0,0): error -6
> [    0.874465] Please append a correct "root=" boot option; here are 
> the available partitions:
> [    0.874760] 0100          131072 ram0
> [    0.874792]  (driver?)
> [    0.875039] 0101          131072 ram1
> [    0.875045]  (driver?)
> [    0.875206] 0102          131072 ram2
> [    0.875211]  (driver?)
> [    0.875367] 0103          131072 ram3
> [    0.875371]  (driver?)
> [    0.875526] 0104          131072 ram4
> [    0.875530]  (driver?)
> [    0.875683] 0105          131072 ram5
> [    0.875687]  (driver?)
> [    0.875840] 0106          131072 ram6
> [    0.875844]  (driver?)
> [    0.876042] 0107          131072 ram7
> [    0.876047]  (driver?)
> [    0.876206] 0108          131072 ram8
> [    0.876210]  (driver?)
> [    0.876365] 0109          131072 ram9
> [    0.876369]  (driver?)
> [    0.876522] 010a          131072 ram10
> [    0.876526]  (driver?)
> [    0.876680] 010b          131072 ram11
> [    0.876684]  (driver?)
> [    0.876839] 010c          131072 ram12
> [    0.876843]  (driver?)
> [    0.877055] 010d          131072 ram13
> [    0.877060]  (driver?)
> [    0.877218] 010e          131072 ram14
> [    0.877222]  (driver?)
> [    0.877376] 010f          131072 ram15
> [    0.877380]  (driver?)
> [    0.877622] Kernel panic - not syncing: VFS: Unable to mount root 
> fs on unknown-block(0,0)
> [    0.878241] Rebooting in 180 seconds..
>
OK, I figured out, that the kernel doesn't detect any virtio device. I 
enabled the devices in the kernel config. Maybe another kernel option is 
missing. Any ideas?

-- Christian
