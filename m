Received: from eggs.gnu.org ([2001:4830:134:3::10]:47054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1cdcZJ-0002DG-9d
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1cdcZF-0006xh-9d
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:50:53 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:34238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1cdcZF-0006vK-1o
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:50:49 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1ECo4SD031001
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:50:42 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id A67EB6D
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:50:42 -0500 (EST)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 9A7EF6D
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:50:42 -0500 (EST)
Received: from mail-ua0-f199.google.com (mail-ua0-f199.google.com
	[209.85.217.199])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1ECog2A018911
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:50:42 -0500
Received: by mail-ua0-f199.google.com with SMTP id x12so1623437uax.6
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:50:42 -0800 (PST)
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com.
	[209.85.213.52])
	by smtp.gmail.com with ESMTPSA id b33sm98612uaa.29.2017.02.14.04.50.40
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Feb 2017 04:50:40 -0800 (PST)
Received: by mail-vk0-f52.google.com with SMTP id k127so79147896vke.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:50:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170214073551.GA9055@pxdev.xzpeter.org>
References: <CAHyh4xiVKjd+D=qaizUZ02O8xLYhpoVKOqC9cR0ZWWyLq9HtbQ@mail.gmail.com>
	<20170208031216.GA5151@pxdev.xzpeter.org>
	<CAHyh4xg7NVPjXu3c+xGWNzQqwLgFqFJTPo4SgN-X+FNuHjGihQ@mail.gmail.com>
	<CAHyh4xhOPmfLoU_fvtbBF1Wqbzji9q6rp_bRN38qfnwvhQq+9A@mail.gmail.com>
	<20170209035250.GB22153@pxdev.xzpeter.org>
	<CAHyh4xi9KZm13mJnE3-EyYkkyN4YDKKwbeJ68AumCBM7kgr+MQ@mail.gmail.com>
	<20170214073551.GA9055@pxdev.xzpeter.org>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Tue, 14 Feb 2017 07:50:39 -0500
Message-ID: <CAHyh4xiATAV801U7zjK1F_B+7e2bDWhH1-gpFKF3U1jNmCfScw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] iommu emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, Alex Williamson <alex.williamson@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Tue, Feb 14, 2017 at 2:35 AM, Peter Xu <peterx@redhat.com> wrote:

> On Thu, Feb 09, 2017 at 08:01:14AM -0500, Jintack Lim wrote:
> > On Wed, Feb 8, 2017 at 10:52 PM, Peter Xu <peterx@redhat.com> wrote:
> > > (cc qemu-devel and Alex)
> > >
> > > On Wed, Feb 08, 2017 at 09:14:03PM -0500, Jintack Lim wrote:
> > >> On Wed, Feb 8, 2017 at 10:49 AM, Jintack Lim <jintack@cs.columbia.edu>
> wrote:
> > >> > Hi Peter,
> > >> >
> > >> > On Tue, Feb 7, 2017 at 10:12 PM, Peter Xu <peterx@redhat.com>
> wrote:
> > >> >> On Tue, Feb 07, 2017 at 02:16:29PM -0500, Jintack Lim wrote:
> > >> >>> Hi Peter and Michael,
> > >> >>
> > >> >> Hi, Jintack,
> > >> >>
> > >> >>>
> > >> >>> I would like to get some help to run a VM with the emulated
> iommu. I
> > >> >>> have tried for a few days to make it work, but I couldn't.
> > >> >>>
> > >> >>> What I want to do eventually is to assign a network device to the
> > >> >>> nested VM so that I can measure the performance of applications
> > >> >>> running in the nested VM.
> > >> >>
> > >> >> Good to know that you are going to use [4] to do something useful.
> :-)
> > >> >>
> > >> >> However, could I ask why you want to measure the performance of
> > >> >> application inside nested VM rather than host? That's something I
> am
> > >> >> just curious about, considering that virtualization stack will
> > >> >> definitely introduce overhead along the way, and I don't know
> whether
> > >> >> that'll affect your measurement to the application.
> > >> >
> > >> > I have added nested virtualization support to KVM/ARM, which is
> under
> > >> > review now. I found that application performance running inside the
> > >> > nested VM is really bad both on ARM and x86, and I'm trying to
> figure
> > >> > out what's the real overhead. I think one way to figure that out is
> to
> > >> > see if the direct device assignment to L2 helps to reduce the
> overhead
> > >> > or not.
> > >
> > > I see. IIUC you are trying to use an assigned device to replace your
> > > old emulated device in L2 guest to see whether performance will drop
> > > as well, right? Then at least I can know that you won't need a nested
> > > VT-d here (so we should not need a vIOMMU in L2 guest).
> >
> > That's right.
> >
> > >
> > > In that case, I think we can give it a shot, considering that L1 guest
> > > will use vfio-pci for that assigned device as well, and when L2 guest
> > > QEMU uses this assigned device, it'll use a static mapping (just to
> > > map the whole GPA for L2 guest) there, so even if you are using a
> > > kernel driver in L2 guest with your to-be-tested application, we
> > > should still be having a static mapping in vIOMMU in L1 guest, which
> > > is IMHO fine from performance POV.
> > >
> > > I cced Alex in case I missed anything here.
> > >
> > >> >
> > >> >>
> > >> >> Another thing to mention is that (in case you don't know that),
> device
> > >> >> assignment with VT-d protection would be even slower than generic
> VMs
> > >> >> (without Intel IOMMU protection) if you are using generic kernel
> > >> >> drivers in the guest, since we may need real-time DMA translation
> on
> > >> >> data path.
> > >> >>
> > >> >
> > >> > So, this is the comparison between using virtio and using the device
> > >> > assignment for L1? I have tested application performance running
> > >> > inside L1 with and without iommu, and I found that the performance
> is
> > >> > better with iommu.
>
> Here iiuc you mean that "L1 guest with vIOMMU performs better than
> when without vIOMMU", while ...
>

Ah, I think I wrote the second sentence wrong. What I really meant is that
I tested the performance using virtio and the device direct assignment for
L1.


>
> > >> > I thought whether the device is assigned to L1 or
> > >> > L2, the DMA translation is done by iommu, which is pretty fast?
> Maybe
> > >> > I misunderstood what you said?
> > >
> > > I failed to understand why an vIOMMU could help boost performance. :(
> > > Could you provide your command line here so that I can try to
> > > reproduce?
> >
> > Sure. This is the command line to launch L1 VM
> >
> > qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
> > -m 12G -device intel-iommu,intremap=on,eim=off,caching-mode=on \
> > -drive file=/mydata/guest0.img,format=raw --nographic -cpu host \
> > -smp 4,sockets=4,cores=1,threads=1 \
> > -device vfio-pci,host=08:00.0,id=net0
> >
> > And this is for L2 VM.
> >
> > ./qemu-system-x86_64 -M q35,accel=kvm \
> > -m 8G \
> > -drive file=/vm/l2guest.img,format=raw --nographic -cpu host \
> > -device vfio-pci,host=00:03.0,id=net0
>
> ... here looks like these are command lines for L1/L2 guest, rather
> than L1 guest with/without vIOMMU?
>

That's right. I thought you were asking about command lines for L1/L2 guest
:(.
I think I made the confusion, and as I said above, I didn't mean to talk
about the performance of L1 guest with/without vIOMMO.
We can move on!


>
> >
> > >
> > > Besides, what I mentioned above is just in case you don't know that
> > > vIOMMU will drag down the performance in most cases.
> > >
> > > I think here to be more explicit, the overhead of vIOMMU is different
> > > for assigned devices and emulated ones.
> > >
> > >   (1) For emulated devices, the overhead is when we do the
> > >       translation, or say when we do the DMA operation. We need
> > >       real-time translation which should drag down the performance.
> > >
> > >   (2) For assigned devices (our case), the overhead is when we setup
> > >       the pages (since we are trapping the setup procedures via CM
> > >       bit). However, after it's setup, we should have no much
> > >       performance drag when we really do the data transfer (during
> > >       DMA) since that'll all be done in the hardware IOMMU (no matter
> > >       whether the device is assigned to L1/L2 guest).
> > >
> > > Now, after I know your use case now (use vIOMMU in L1 guest, don't use
> > > vIOMMU in L2 guest, only use assigned devices), I suspect we would
> > > have no big problem according to (2).
> > >
> > >> >
> > >> >>>
> > >> >>> First, I am having trouble to boot a VM with the emulated iommu. I
> > >> >>> have posted my problem to the qemu user mailing list[1],
> > >> >>
> > >> >> Here I would suggest that you cc qemu-devel as well next time:
> > >> >>
> > >> >>   qemu-devel@nongnu.org
> > >> >>
> > >> >> Since I guess not all people are registered to qemu-discuss, at
> least
> > >> >> I am not in that loop. Imho cc qemu-devel could let the question
> > >> >> spread to more people, and it'll get a higher chance to be
> answered.
> > >> >
> > >> > Thanks. I'll cc qemu-devel next time.
> > >> >
> > >> >>
> > >> >>> but to put it
> > >> >>> in a nutshell, I'd like to know the setting I can reuse to boot a
> VM
> > >> >>> with the emulated iommu. (e.g. how to create a VM with q35 chipset
> > >> >>> and/or libvirt xml if you use virsh).
> > >> >>
> > >> >> IIUC you are looking for device assignment for the nested VM case.
> So,
> > >> >> firstly, you may need my tree to run this (see below). Then, maybe
> you
> > >> >> can try to boot a L1 guest with assigned device (under VT-d
> > >> >> protection), with command:
> > >> >>
> > >> >> $qemu -M q35,accel=kvm,kernel-irqchip=split -m 1G \
> > >> >>       -device intel-iommu,intremap=on,eim=off,caching-mode=on \
> > >> >>       -device vfio-pci,host=$HOST_PCI_ADDR \
> > >> >>       $YOUR_IMAGE_PATH
> > >> >>
> > >> >
> > >> > Thanks! I'll try this right away.
> > >> >
> > >> >> Here $HOST_PCI_ADDR should be something like 05:00.0, which is the
> > >> >> host PCI address of the device to be assigned to guest.
> > >> >>
> > >> >> (If you go over the cover letter in [4], you'll see similar command
> > >> >>  line there, though with some more devices assigned, and with
> traces)
> > >> >>
> > >> >> If you are playing with nested VM, you'll also need a L2 guest,
> which
> > >> >> will be run inside the L1 guest. It'll require similar command
> line,
> > >> >> but I would suggest you first try a L2 guest without intel-iommu
> > >> >> device. Frankly speaking I haven't played with that yet, so just
> let
> > >> >> me know if you got any problem, which is possible. :-)
> > >> >>
> > >>
> > >> I was able to boot L2 guest without assigning a network device
> > >> successfully. (host iommu was on, L1 iommu was on, and the network
> > >> device was assigned to L1)
> > >>
> > >> Then, I unbound the network device in L1 and bound it to vfio-pci.
> > >> When I try to run L2 with the following command, I got an assertion.
> > >>
> > >> # ./qemu-system-x86_64 -M q35,accel=kvm \
> > >> -m 8G \
> > >> -drive file=/vm/l2guest.img,format=raw --nographic -cpu host \
> > >> -device vfio-pci,host=00:03.0,id=net0
> > >>
> > >> qemu-system-x86_64: hw/pci/pcie.c:686: pcie_add_capability: Assertion
> > >> `prev >= 0x100' failed.
> > >> Aborted (core dumped)
> > >>
> > >> Thoughts?
> > >
> > > I don't know whether it'll has anything to do with how vfio-pci works,
> > > anyway I cced Alex and the list in case there is quick answer.
> > >
> > > I'll reproduce this nested case and update when I got anything.
> >
> > Thanks!
>
> I tried to reproduce this issue with the following 10g network card:
>
> 00:03.0 Ethernet controller: Intel Corporation Ethernet Controller
> 10-Gigabit X540-AT2 (rev 01)
>
> In my case, both L1/L2 guests can boot with the assigned device. I
> also did a quick netperf TCP STREAM test, the result is (in case you
> are interested):
>
>    L1 guest: 1.12Gbps
>    L2 guest: 8.26Gbps
>
> First of all, just to confirm that you were using the same qemu binary
> in both host and L1 guest, right?
>

Right. I'm using your branch.


>
> Then, I *think* above assertion you encountered would fail only if
> prev == 0 here, but I still don't quite sure why was that happening.
> Btw, could you paste me your "lspci -vvv -s 00:03.0" result in your L1
> guest?
>

Sure. This is from my L1 guest.

root@guest0:~# lspci -vvv -s 00:03.0
00:03.0 Network controller: Mellanox Technologies MT27500 Family
[ConnectX-3]
Subsystem: Mellanox Technologies Device 0050
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 23
Region 0: Memory at fe900000 (64-bit, non-prefetchable) [size=1M]
Region 2: Memory at fe000000 (64-bit, prefetchable) [size=8M]
Expansion ROM at fea00000 [disabled] [size=1M]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] Vital Product Data
Product Name: CX354A - ConnectX-3 QSFP
Read-only fields:
[PN] Part number: MCX354A-FCBT
[EC] Engineering changes: A4
[SN] Serial number: MT1346X00791
[V0] Vendor specific: PCIe Gen3 x8
[RV] Reserved: checksum good, 0 byte(s) reserved
Read/write fields:
[V1] Vendor specific: N/A
[YA] Asset tag: N/A
[RW] Read-write area: 105 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 253 byte(s) free
[RW] Read-write area: 252 byte(s) free
End
Capabilities: [9c] MSI-X: Enable+ Count=128 Masked-
Vector table: BAR=0 offset=0007c000
PBA: BAR=0 offset=0007d000
Capabilities: [60] Express (v2) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 256 bytes, MaxReadReq 4096 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
Capabilities: [100 v0] #00
Capabilities: [148 v1] Device Serial Number f4-52-14-03-00-15-5b-80
Capabilities: [154 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES- TLP+ FCP+ CmpltTO+ CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
ECRC+ UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
Kernel driver in use: mlx4_core



> Thanks,
>
> -- peterx
>
>
