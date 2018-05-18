Received: from eggs.gnu.org ([2001:4830:134:3::10]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fJfyy-00049t-Ix
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fJfyr-000704-9W
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:03:44 -0400
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:53789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fJfyq-0006wT-VY
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:03:37 -0400
Received: from player771.ha.ovh.net (unknown [10.109.120.25])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 131591B8520
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 16:03:28 +0200 (CEST)
Date: Fri, 18 May 2018 16:03:21 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180518160321.418a21db@bahia.lan>
In-Reply-To: <8fb8a591-081f-97ad-2d26-8941c323f8b2@xenosoft.de>
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
	<20180518141642.6ad639ac@bahia.lan>
	<8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
	<8fb8a591-081f-97ad-2d26-8941c323f8b2@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Fri, 18 May 2018 15:38:40 +0200
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> Am 18.05.2018 um 14:33 schrieb Christian Zigotzky:
> > On 18 May 2018 at 2:16PM, Greg Kurz wrote: =20
> >> On Fri, 18 May 2018 13:50:42 +0200
> >> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> >> =20
> >>> On 18 May 2018 at 1:13PM, Greg Kurz wrote: =20
> >>>> And of course your kernel should be built with virtio support. =20
> >>> I think I have enabled virtio support. Please find attached my kernel
> >>> config.
> >>> =20
> >> Indeed, what about passing root=3D/dev/vda3 to the kernel ?
> >> =20
> > ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel=20
> > /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/u=
Image-4.17=20
> > -drive=20
> > file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/u=
buntu_MATE_16.04_PowerPC.img,index=3D0,if=3Dvirtio=20
> > -net nic,vlan=3D0,model=3De1000 -net user,vlan=3D0 -append "rw=20
> > root=3D/dev/vda3" -machine dt_compatible=3Dfsl,,P5020DS
> >
> > or
> >
> > ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel=20
> > /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/u=
Image-4.17=20
> > -machine dt_compatible=3Dfsl,,P5020DS -device virtio-scsi -drive=20
> > if=3Dnone,id=3Dc1,file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_=
LTS_PowerPC_QEMU/ubuntu_MATE_16.04_PowerPC.img=20
> > -device scsi-cd,drive=3Dc1 -append "root=3D/dev/vda3"
> >
> > or
> >
> > ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -nographic -kernel=20
> > /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/u=
Image-4.17=20
> > -machine dt_compatible=3Dfsl,,P5020DS -drive=20
> > if=3Dvirtio,file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_Po=
werPC_QEMU/ubuntu_MATE_16.04_PowerPC.img=20
> > -append "root=3D/dev/vda3"
> >
> > Output:
> >
> > [=C2=A0=C2=A0=C2=A0 0.000000] MMU: Supported page sizes
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 4 KB as direct
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096 =
KB as direct
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384 KB as=
 direct
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 65536 KB as=
 direct
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0=C2=A0=C2=A0 262144 KB as dire=
ct
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0=C2=A0 1048576 KB as direct
> > [=C2=A0=C2=A0=C2=A0 0.000000] MMU: Book3E HW tablewalk not supported
> > [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 4.17.0-rc5_A-EON_A1-X5000=20
> > (christian@christian-virtual-machine) (gcc version 5.4.0 20160609=20
> > (Ubuntu 5.4.0-6ubuntu1~16.04.4)) #1 SMP Mon May 14 09:34:52 CEST 2018
> > [=C2=A0=C2=A0=C2=A0 0.000000] Using CoreNet Generic machine description
> > [=C2=A0=C2=A0=C2=A0 0.000000] bootconsole [udbg0] enabled
> > [=C2=A0=C2=A0=C2=A0 0.000000] CPU maps initialized for 1 thread per core
> > [=C2=A0=C2=A0=C2=A0 0.000000] -----------------------------------------=
------------
> > [=C2=A0=C2=A0=C2=A0 0.000000] phys_mem_size=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 0x80000000
> > [=C2=A0=C2=A0=C2=A0 0.000000] dcache_bsize=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x40
> > [=C2=A0=C2=A0=C2=A0 0.000000] icache_bsize=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x40
> > [=C2=A0=C2=A0=C2=A0 0.000000] cpu_features=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x00000003008001b4
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 possible=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 0x00000003009003b4
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 always=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x00000003008003b4
> > [=C2=A0=C2=A0=C2=A0 0.000000] cpu_user_features =3D 0xcc008000 0x080000=
00
> > [=C2=A0=C2=A0=C2=A0 0.000000] mmu_features=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x000a0010
> > [=C2=A0=C2=A0=C2=A0 0.000000] firmware_features =3D 0x0000000000000000
> > [=C2=A0=C2=A0=C2=A0 0.000000] -----------------------------------------=
------------
> > [=C2=A0=C2=A0=C2=A0 0.000000] CoreNet Generic board
> > [=C2=A0=C2=A0=C2=A0 0.000000] Zone ranges:
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [mem 0x0000000000000000-0x000000007fffffff]
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA32=C2=A0=C2=A0=C2=A0 empty
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 Normal=C2=A0=C2=A0 empty
> > [=C2=A0=C2=A0=C2=A0 0.000000] Movable zone start for each node
> > [=C2=A0=C2=A0=C2=A0 0.000000] Early memory node ranges
> > [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x00=
00000000000000-0x000000007fffffff]
> > [=C2=A0=C2=A0=C2=A0 0.000000] Initmem setup node 0 [mem=20
> > 0x0000000000000000-0x000000007fffffff]
> > [=C2=A0=C2=A0=C2=A0 0.000000] MMU: Allocated 2112 bytes of context maps=
 for 255 contexts
> > [=C2=A0=C2=A0=C2=A0 0.000000] percpu: Embedded 21 pages/cpu @=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ptrval) s48080=20
> > r0 d37936 u1048576
> > [=C2=A0=C2=A0=C2=A0 0.000000] Built 1 zonelists, mobility grouping on.=
=C2=A0 Total pages:=20
> > 517120
> > [=C2=A0=C2=A0=C2=A0 0.000000] Kernel command line: root=3D/dev/vda3
> > [=C2=A0=C2=A0=C2=A0 0.000000] Dentry cache hash table entries: 262144 (=
order: 9,=20
> > 2097152 bytes)
> > [=C2=A0=C2=A0=C2=A0 0.000000] Inode-cache hash table entries: 131072 (o=
rder: 8,=20
> > 1048576 bytes)
> > [=C2=A0=C2=A0=C2=A0 0.000000] Memory: 1975688K/2097152K available (1208=
8K kernel=20
> > code, 2072K rwdata, 8172K rodata, 412K init, 727K bss, 121464K=20
> > reserved, 0K cma-reserved)
> > [=C2=A0=C2=A0=C2=A0 0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D1, Nodes=3D1
> > [=C2=A0=C2=A0=C2=A0 0.000000] Hierarchical RCU implementation.
> > [=C2=A0=C2=A0=C2=A0 0.000000] =C2=A0=C2=A0=C2=A0 RCU event tracing is e=
nabled.
> > [=C2=A0=C2=A0=C2=A0 0.000000] =C2=A0=C2=A0=C2=A0 RCU restricting CPUs f=
rom NR_CPUS=3D4 to nr_cpu_ids=3D1.
> > [=C2=A0=C2=A0=C2=A0 0.000000] RCU: Adjusting geometry for rcu_fanout_le=
af=3D16,=20
> > nr_cpu_ids=3D1
> > [=C2=A0=C2=A0=C2=A0 0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated =
irqs: 16
> > [=C2=A0=C2=A0=C2=A0 0.000000] mpic: Setting up MPIC " OpenPIC=C2=A0 " v=
ersion 1.2 at=20
> > fe0040000, max 1 CPUs
> > [=C2=A0=C2=A0=C2=A0 0.000000] mpic: ISU size: 512, shift: 9, mask: 1ff
> > [=C2=A0=C2=A0=C2=A0 0.000000] mpic: Initializing for 512 sources
> > [=C2=A0=C2=A0=C2=A0 0.000150] clocksource: timebase: mask: 0xffffffffff=
ffffff=20
> > max_cycles: 0x5c4093a7d1, max_idle_ns: 440795210635 ns
> > [=C2=A0=C2=A0=C2=A0 0.000485] clocksource: timebase mult[2800000] shift=
[24] registered
> > [=C2=A0=C2=A0=C2=A0 0.004932] Console: colour dummy device 80x25
> > [=C2=A0=C2=A0=C2=A0 0.005543] pid_max: default: 32768 minimum: 301
> > [=C2=A0=C2=A0=C2=A0 0.006251] Mount-cache hash table entries: 4096 (ord=
er: 3, 32768=20
> > bytes)
> > [=C2=A0=C2=A0=C2=A0 0.006441] Mountpoint-cache hash table entries: 4096=
 (order: 3,=20
> > 32768 bytes)
> > [=C2=A0=C2=A0=C2=A0 0.021361] e500 family performance monitor hardware =
support=20
> > registered
> > [=C2=A0=C2=A0=C2=A0 0.022294] Hierarchical SRCU implementation.
> > [=C2=A0=C2=A0=C2=A0 0.024402] smp: Bringing up secondary CPUs ...
> > [=C2=A0=C2=A0=C2=A0 0.024609] smp: Brought up 1 node, 1 CPU
> > [=C2=A0=C2=A0=C2=A0 0.024811] Using standard scheduler topology
> > [=C2=A0=C2=A0=C2=A0 0.030061] devtmpfs: initialized
> > [=C2=A0=C2=A0=C2=A0 0.033704] random: get_random_u32 called from=20
> > .bucket_table_alloc+0x170/0x1c0 with crng_init=3D0
> > [=C2=A0=C2=A0=C2=A0 0.035459] clocksource: jiffies: mask: 0xffffffff ma=
x_cycles:=20
> > 0xffffffff, max_idle_ns: 1911260446275000 ns
> > [=C2=A0=C2=A0=C2=A0 0.035764] futex hash table entries: 256 (order: 2, =
16384 bytes)
> > [=C2=A0=C2=A0=C2=A0 0.037098] xor: measuring software checksum speed
> > [=C2=A0=C2=A0=C2=A0 0.046584]=C2=A0=C2=A0=C2=A0 8regs=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0 2620.000 MB/sec
> > [=C2=A0=C2=A0=C2=A0 0.056774]=C2=A0=C2=A0=C2=A0 8regs_prefetch:=C2=A0 2=
380.000 MB/sec
> > [=C2=A0=C2=A0=C2=A0 0.066974]=C2=A0=C2=A0=C2=A0 32regs=C2=A0=C2=A0=C2=
=A0 :=C2=A0 2608.000 MB/sec
> > [=C2=A0=C2=A0=C2=A0 0.077165]=C2=A0=C2=A0=C2=A0 32regs_prefetch:=C2=A0 =
2360.000 MB/sec
> > [=C2=A0=C2=A0=C2=A0 0.077313] xor: using function: 8regs (2620.000 MB/s=
ec)
> > [=C2=A0=C2=A0=C2=A0 0.087868] NET: Registered protocol family 16
> > [=C2=A0=C2=A0=C2=A0 0.091070] cpuidle: using governor ladder
> > [=C2=A0=C2=A0=C2=A0 0.091259] cpuidle: using governor menu
> > [=C2=A0=C2=A0=C2=A0 0.097159] Machine: QEMU ppce500
> > [=C2=A0=C2=A0=C2=A0 0.097258] SoC family: QorIQ
> > [=C2=A0=C2=A0=C2=A0 0.097343] SoC ID: svr:0x00000000, Revision: 0.0
> > [=C2=A0=C2=A0=C2=A0 0.111905] PCI: Probing PCI hardware
> > [=C2=A0=C2=A0=C2=A0 0.216930] raid6: int64x1=C2=A0 gen()=C2=A0 1324 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.234228] raid6: int64x1=C2=A0 xor()=C2=A0=C2=A0 84=
5 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.251545] raid6: int64x2=C2=A0 gen()=C2=A0 1718 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.268864] raid6: int64x2=C2=A0 xor()=C2=A0 1275 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.286186] raid6: int64x4=C2=A0 gen()=C2=A0 1800 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.303854] raid6: int64x4=C2=A0 xor()=C2=A0 1316 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.321316] raid6: int64x8=C2=A0 gen()=C2=A0=C2=A0 94=
1 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.338625] raid6: int64x8=C2=A0 xor()=C2=A0=C2=A0 78=
1 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.338752] raid6: using algorithm int64x4 gen() 1800=
 MB/s
> > [=C2=A0=C2=A0=C2=A0 0.338900] raid6: .... xor() 1316 MB/s, rmw enabled
> > [=C2=A0=C2=A0=C2=A0 0.339063] raid6: using intx1 recovery algorithm
> > [=C2=A0=C2=A0=C2=A0 0.339817] Freescale Elo series DMA driver
> > [=C2=A0=C2=A0=C2=A0 0.341262] vgaarb: loaded
> > [=C2=A0=C2=A0=C2=A0 0.342302] SCSI subsystem initialized
> > [=C2=A0=C2=A0=C2=A0 0.344113] usbcore: registered new interface driver =
usbfs
> > [=C2=A0=C2=A0=C2=A0 0.344428] usbcore: registered new interface driver =
hub
> > [=C2=A0=C2=A0=C2=A0 0.344684] usbcore: registered new device driver usb
> > [=C2=A0=C2=A0=C2=A0 0.345268] pps_core: LinuxPPS API ver. 1 registered
> > [=C2=A0=C2=A0=C2=A0 0.345404] pps_core: Software ver. 5.3.6 - Copyright=
 2005-2007=20
> > Rodolfo Giometti <giometti@linux.it>
> > [=C2=A0=C2=A0=C2=A0 0.345695] PTP clock support registered
> > [=C2=A0=C2=A0=C2=A0 0.348569] EDAC MC: Ver: 3.0.0
> > [=C2=A0=C2=A0=C2=A0 0.351386] Advanced Linux Sound Architecture Driver =
Initialized.
> > [=C2=A0=C2=A0=C2=A0 0.355672] NET: Registered protocol family 8
> > [=C2=A0=C2=A0=C2=A0 0.355814] NET: Registered protocol family 20
> > [=C2=A0=C2=A0=C2=A0 0.359236] clocksource: Switched to clocksource time=
base
> > [=C2=A0=C2=A0=C2=A0 0.361400] FS-Cache: Loaded
> > [=C2=A0=C2=A0=C2=A0 0.362211] CacheFiles: Loaded
> > [=C2=A0=C2=A0=C2=A0 0.390263] NET: Registered protocol family 2
> > [=C2=A0=C2=A0=C2=A0 0.393486] tcp_listen_portaddr_hash hash table entri=
es: 1024=20
> > (order: 2, 16384 bytes)
> > [=C2=A0=C2=A0=C2=A0 0.393746] TCP established hash table entries: 16384=
 (order: 5,=20
> > 131072 bytes)
> > [=C2=A0=C2=A0=C2=A0 0.394154] TCP bind hash table entries: 16384 (order=
: 6, 262144=20
> > bytes)
> > [=C2=A0=C2=A0=C2=A0 0.394505] TCP: Hash tables configured (established =
16384 bind 16384)
> > [=C2=A0=C2=A0=C2=A0 0.395361] UDP hash table entries: 1024 (order: 3, 3=
2768 bytes)
> > [=C2=A0=C2=A0=C2=A0 0.395637] UDP-Lite hash table entries: 1024 (order:=
 3, 32768 bytes)
> > [=C2=A0=C2=A0=C2=A0 0.396638] NET: Registered protocol family 1
> > [=C2=A0=C2=A0=C2=A0 0.399430] RPC: Registered named UNIX socket transpo=
rt module.
> > [=C2=A0=C2=A0=C2=A0 0.399619] RPC: Registered udp transport module.
> > [=C2=A0=C2=A0=C2=A0 0.399743] RPC: Registered tcp transport module.
> > [=C2=A0=C2=A0=C2=A0 0.399867] RPC: Registered tcp NFSv4.1 backchannel t=
ransport module.
> > [=C2=A0=C2=A0=C2=A0 0.406335] Initialise system trusted keyrings
> > [=C2=A0=C2=A0=C2=A0 0.408668] workingset: timestamp_bits=3D62 max_order=
=3D19 bucket_order=3D0
> > [=C2=A0=C2=A0=C2=A0 0.416796] zbud: loaded
> > [=C2=A0=C2=A0=C2=A0 0.420149] squashfs: version 4.0 (2009/01/31) Philli=
p Lougher
> > [=C2=A0=C2=A0=C2=A0 0.436150] ntfs: driver 2.1.32 [Flags: R/W].
> > [=C2=A0=C2=A0=C2=A0 0.436705] jffs2: version 2.2. (NAND) (SUMMARY)=C2=
=A0 =C2=A9 2001-2006 Red=20
> > Hat, Inc.
> > [=C2=A0=C2=A0=C2=A0 0.438486] fuse init (API version 7.26)
> > [=C2=A0=C2=A0=C2=A0 0.451573] NET: Registered protocol family 38
> > [=C2=A0=C2=A0=C2=A0 0.451885] async_tx: api initialized (async)
> > [=C2=A0=C2=A0=C2=A0 0.452277] Key type asymmetric registered
> > [=C2=A0=C2=A0=C2=A0 0.452455] Asymmetric key parser 'x509' registered
> > [=C2=A0=C2=A0=C2=A0 0.452880] Block layer SCSI generic (bsg) driver ver=
sion 0.4=20
> > loaded (major 249)
> > [=C2=A0=C2=A0=C2=A0 0.453203] io scheduler noop registered
> > [=C2=A0=C2=A0=C2=A0 0.453337] io scheduler deadline registered
> > [=C2=A0=C2=A0=C2=A0 0.453651] io scheduler cfq registered (default)
> > [=C2=A0=C2=A0=C2=A0 0.453798] io scheduler mq-deadline registered
> > [=C2=A0=C2=A0=C2=A0 0.453962] io scheduler kyber registered
> > [=C2=A0=C2=A0=C2=A0 0.455337] crc32: CRC_LE_BITS =3D 64, CRC_BE BITS =
=3D 64
> > [=C2=A0=C2=A0=C2=A0 0.455484] crc32: self tests passed, processed 22594=
4 bytes in=20
> > 442445 nsec
> > [=C2=A0=C2=A0=C2=A0 0.456221] crc32c: CRC_LE_BITS =3D 64
> > [=C2=A0=C2=A0=C2=A0 0.456327] crc32c: self tests passed, processed 2259=
44 bytes in=20
> > 226608 nsec
> > [=C2=A0=C2=A0=C2=A0 0.486173] crc32_combine: 8373 self tests passed
> > [=C2=A0=C2=A0=C2=A0 0.515206] crc32c_combine: 8373 self tests passed
> > [=C2=A0=C2=A0=C2=A0 0.689268] Serial: 8250/16550 driver, 4 ports, IRQ s=
haring enabled
> > [=C2=A0=C2=A0=C2=A0 0.694784] console [ttyS0] disabled
> > [=C2=A0=C2=A0=C2=A0 0.716358] serial8250.0: ttyS0 at MMIO 0xfe0004500 (=
irq =3D 42,=20
> > base_baud =3D 115200) is a 16550A
> > [=C2=A0=C2=A0=C2=A0 0.717314] console [ttyS0] enabled
> > [=C2=A0=C2=A0=C2=A0 0.717314] console [ttyS0] enabled
> > [=C2=A0=C2=A0=C2=A0 0.717686] bootconsole [udbg0] disabled
> > [=C2=A0=C2=A0=C2=A0 0.717686] bootconsole [udbg0] disabled
> > [=C2=A0=C2=A0=C2=A0 0.719049] ePAPR hypervisor byte channel driver
> > [=C2=A0=C2=A0=C2=A0 0.721125] [drm] radeon kernel modesetting enabled.
> > [=C2=A0=C2=A0=C2=A0 0.746621] brd: module loaded
> > [=C2=A0=C2=A0=C2=A0 0.759781] loop: module loaded
> > [=C2=A0=C2=A0=C2=A0 0.761701] zram: Added device: zram0
> > [=C2=A0=C2=A0=C2=A0 0.771074] libphy: Fixed MDIO Bus: probed
> > [=C2=A0=C2=A0=C2=A0 0.772711] PPP generic driver version 2.4.2
> > [=C2=A0=C2=A0=C2=A0 0.778222] PPP BSD Compression module registered
> > [=C2=A0=C2=A0=C2=A0 0.778382] PPP Deflate Compression module registered
> > [=C2=A0=C2=A0=C2=A0 0.778614] PPP MPPE Compression module registered
> > [=C2=A0=C2=A0=C2=A0 0.778763] NET: Registered protocol family 24
> > [=C2=A0=C2=A0=C2=A0 0.780125] ehci_hcd: USB 2.0 'Enhanced' Host Control=
ler (EHCI) Driver
> > [=C2=A0=C2=A0=C2=A0 0.780421] ehci-pci: EHCI PCI platform driver
> > [=C2=A0=C2=A0=C2=A0 0.780682] ohci_hcd: USB 1.1 'Open' Host Controller =
(OHCI) Driver
> > [=C2=A0=C2=A0=C2=A0 0.781057] ohci-pci: OHCI PCI platform driver
> > [=C2=A0=C2=A0=C2=A0 0.781671] ehci-fsl: Freescale EHCI Host controller =
driver
> > [=C2=A0=C2=A0=C2=A0 0.781999] usbcore: registered new interface driver =
usblp
> > [=C2=A0=C2=A0=C2=A0 0.782258] usbcore: registered new interface driver =
usb-storage
> > [=C2=A0=C2=A0=C2=A0 0.782655] usbcore: registered new interface driver =
usbserial_generic
> > [=C2=A0=C2=A0=C2=A0 0.783005] usbserial: USB Serial support registered =
for generic
> > [=C2=A0=C2=A0=C2=A0 0.783247] usbcore: registered new interface driver =
ftdi_sio
> > [=C2=A0=C2=A0=C2=A0 0.783465] usbserial: USB Serial support registered =
for FTDI USB=20
> > Serial Device
> > [=C2=A0=C2=A0=C2=A0 0.786824] mousedev: PS/2 mouse device common for al=
l mice
> > [=C2=A0=C2=A0=C2=A0 0.787567] i2c /dev entries driver
> > [=C2=A0=C2=A0=C2=A0 0.793355] device-mapper: ioctl: 4.39.0-ioctl (2018-=
04-03)=20
> > initialised: dm-devel@redhat.com
> > [=C2=A0=C2=A0=C2=A0 0.793900] sdhci: Secure Digital Host Controller Int=
erface driver
> > [=C2=A0=C2=A0=C2=A0 0.794146] sdhci: Copyright(c) Pierre Ossman
> > [=C2=A0=C2=A0=C2=A0 0.794353] sdhci-pltfm: SDHCI platform and OF driver=
 helper
> > [=C2=A0=C2=A0=C2=A0 0.796047] ledtrig-cpu: registered to indicate activ=
ity on CPUs
> > [=C2=A0=C2=A0=C2=A0 0.796402] hidraw: raw HID events driver (C) Jiri Ko=
sina
> > [=C2=A0=C2=A0=C2=A0 0.798040] usbcore: registered new interface driver =
usbhid
> > [=C2=A0=C2=A0=C2=A0 0.798199] usbhid: USB HID core driver
> > [=C2=A0=C2=A0=C2=A0 0.798403] Freescale hypervisor management driver
> > [=C2=A0=C2=A0=C2=A0 0.798544] fsl-hv: no hypervisor found
> > [=C2=A0=C2=A0=C2=A0 0.816356] usbcore: registered new interface driver =
snd-usb-audio
> > [=C2=A0=C2=A0=C2=A0 0.816614] usbcore: registered new interface driver =
snd-ua101
> > [=C2=A0=C2=A0=C2=A0 0.816845] usbcore: registered new interface driver =
snd-usb-usx2y
> > [=C2=A0=C2=A0=C2=A0 0.817389] ipip: IPv4 and MPLS over IPv4 tunneling d=
river
> > [=C2=A0=C2=A0=C2=A0 0.818797] IPv4 over IPsec tunneling driver
> > [=C2=A0=C2=A0=C2=A0 0.820198] Initializing XFRM netlink socket
> > [=C2=A0=C2=A0=C2=A0 0.821242] NET: Registered protocol family 10
> > [=C2=A0=C2=A0=C2=A0 0.830017] Segment Routing with IPv6
> > [=C2=A0=C2=A0=C2=A0 0.830723] mip6: Mobile IPv6
> > [=C2=A0=C2=A0=C2=A0 0.832292] sit: IPv6, IPv4 and MPLS over IPv4 tunnel=
ing driver
> > [=C2=A0=C2=A0=C2=A0 0.834447] NET: Registered protocol family 17
> > [=C2=A0=C2=A0=C2=A0 0.834691] NET: Registered protocol family 15
> > [=C2=A0=C2=A0=C2=A0 0.835396] lec:lane_module_init: lec.c: initialized
> > [=C2=A0=C2=A0=C2=A0 0.835567] mpoa:atm_mpoa_init: mpc.c: initialized
> > [=C2=A0=C2=A0=C2=A0 0.835763] l2tp_core: L2TP core driver, V2.0
> > [=C2=A0=C2=A0=C2=A0 0.840489] DCCP: Activated CCID 2 (TCP-like)
> > [=C2=A0=C2=A0=C2=A0 0.840655] DCCP: Activated CCID 3 (TCP-Friendly Rate=
 Control)
> > [=C2=A0=C2=A0=C2=A0 0.842064] sctp: Hash tables configured (bind 256/25=
6)
> > [=C2=A0=C2=A0=C2=A0 0.847782] NET: Registered protocol family 21
> > [=C2=A0=C2=A0=C2=A0 0.849268] Registered RDS/tcp transport
> > [=C2=A0=C2=A0=C2=A0 0.849399] tipc: Activated (version 2.0.0)
> > [=C2=A0=C2=A0=C2=A0 0.849674] NET: Registered protocol family 30
> > [=C2=A0=C2=A0=C2=A0 0.851092] tipc: Started in single node mode
> > [=C2=A0=C2=A0=C2=A0 0.853171] Key type dns_resolver registered
> > [=C2=A0=C2=A0=C2=A0 0.854525] batman_adv: B.A.T.M.A.N. advanced 2018.1 =
(compatibility=20
> > version 15) loaded
> > [=C2=A0=C2=A0=C2=A0 0.855060] drmem: No dynamic reconfiguration memory =
found
> > [=C2=A0=C2=A0=C2=A0 0.856447] Loading compiled-in X.509 certificates
> > [=C2=A0=C2=A0=C2=A0 0.857307] zswap: loaded using pool lzo/zbud
> > [=C2=A0=C2=A0=C2=A0 0.860584] Btrfs loaded, crc32c=3Dcrc32c-generic
> > [=C2=A0=C2=A0=C2=A0 0.863663] Key type encrypted registered
> > [=C2=A0=C2=A0=C2=A0 0.864688] hctosys: unable to open rtc device (rtc0)
> > [=C2=A0=C2=A0=C2=A0 0.865363] ALSA device list:
> > [=C2=A0=C2=A0=C2=A0 0.865462]=C2=A0=C2=A0 #0: Virtual MIDI Card 1
> > [=C2=A0=C2=A0=C2=A0 0.869543] md: Waiting for all devices to be availab=
le before=20
> > autodetect
> > [=C2=A0=C2=A0=C2=A0 0.869723] md: If you don't use raid, use raid=3Dnoa=
utodetect
> > [=C2=A0=C2=A0=C2=A0 0.872156] md: Autodetecting RAID arrays.
> > [=C2=A0=C2=A0=C2=A0 0.872294] md: autorun ...
> > [=C2=A0=C2=A0=C2=A0 0.872379] md: ... autorun DONE.
> > [=C2=A0=C2=A0=C2=A0 0.874278] VFS: Cannot open root device "vda3" or=20
> > unknown-block(0,0): error -6
> > [=C2=A0=C2=A0=C2=A0 0.874465] Please append a correct "root=3D" boot op=
tion; here are=20
> > the available partitions:
> > [=C2=A0=C2=A0=C2=A0 0.874760] 0100=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram0
> > [=C2=A0=C2=A0=C2=A0 0.874792]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.875039] 0101=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram1
> > [=C2=A0=C2=A0=C2=A0 0.875045]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.875206] 0102=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram2
> > [=C2=A0=C2=A0=C2=A0 0.875211]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.875367] 0103=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram3
> > [=C2=A0=C2=A0=C2=A0 0.875371]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.875526] 0104=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram4
> > [=C2=A0=C2=A0=C2=A0 0.875530]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.875683] 0105=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram5
> > [=C2=A0=C2=A0=C2=A0 0.875687]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.875840] 0106=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram6
> > [=C2=A0=C2=A0=C2=A0 0.875844]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.876042] 0107=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram7
> > [=C2=A0=C2=A0=C2=A0 0.876047]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.876206] 0108=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram8
> > [=C2=A0=C2=A0=C2=A0 0.876210]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.876365] 0109=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram9
> > [=C2=A0=C2=A0=C2=A0 0.876369]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.876522] 010a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram10
> > [=C2=A0=C2=A0=C2=A0 0.876526]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.876680] 010b=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram11
> > [=C2=A0=C2=A0=C2=A0 0.876684]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.876839] 010c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram12
> > [=C2=A0=C2=A0=C2=A0 0.876843]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.877055] 010d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram13
> > [=C2=A0=C2=A0=C2=A0 0.877060]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.877218] 010e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram14
> > [=C2=A0=C2=A0=C2=A0 0.877222]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.877376] 010f=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 131072 ram15
> > [=C2=A0=C2=A0=C2=A0 0.877380]=C2=A0 (driver?)
> > [=C2=A0=C2=A0=C2=A0 0.877622] Kernel panic - not syncing: VFS: Unable t=
o mount root=20
> > fs on unknown-block(0,0)
> > [=C2=A0=C2=A0=C2=A0 0.878241] Rebooting in 180 seconds..
> > =20
> OK, I figured out, that the kernel doesn't detect any virtio device. I=20
> enabled the devices in the kernel config. Maybe another kernel option is=
=20
> missing. Any ideas?
>=20

Yeah, I was thinking about something like that as well... unfortunately,
I'm not familiar with ppce500 boards and I don't know what drivers are
needed...=20

> -- Christian
>=20
