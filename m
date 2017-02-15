Received: from eggs.gnu.org ([2001:4830:134:3::10]:34479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ce8x5-0004x1-5N
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ce8x1-0000Ey-Pb
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:25:35 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:43019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1ce8x1-0000EN-Hl
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:25:31 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1FNO3Wp056490
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 18:25:30 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 2B5906D
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 18:25:30 -0500 (EST)
Received: from sendprodmail04.cc.columbia.edu (sendprodmail04.cc.columbia.edu
	[128.59.72.16]) by hazelnut (Postfix) with ESMTP id 15E9C7E
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 18:25:30 -0500 (EST)
Received: from mail-ua0-f200.google.com (mail-ua0-f200.google.com
	[209.85.217.200])
	by sendprodmail04.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v1FNPT8s012262
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 18:25:29 -0500
Received: by mail-ua0-f200.google.com with SMTP id t17so876117uae.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 15:25:29 -0800 (PST)
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com.
	[209.85.213.42]) by smtp.gmail.com with ESMTPSA id
	w15sm1363589uaw.32.2017.02.15.15.25.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 Feb 2017 15:25:28 -0800 (PST)
Received: by mail-vk0-f42.google.com with SMTP id t8so812726vke.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 15:25:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170215155035.3f7220c4@t450s.home>
References: <CAHyh4xiVKjd+D=qaizUZ02O8xLYhpoVKOqC9cR0ZWWyLq9HtbQ@mail.gmail.com>
	<20170208031216.GA5151@pxdev.xzpeter.org>
	<CAHyh4xg7NVPjXu3c+xGWNzQqwLgFqFJTPo4SgN-X+FNuHjGihQ@mail.gmail.com>
	<CAHyh4xhOPmfLoU_fvtbBF1Wqbzji9q6rp_bRN38qfnwvhQq+9A@mail.gmail.com>
	<20170209035250.GB22153@pxdev.xzpeter.org>
	<CAHyh4xi9KZm13mJnE3-EyYkkyN4YDKKwbeJ68AumCBM7kgr+MQ@mail.gmail.com>
	<20170214073551.GA9055@pxdev.xzpeter.org>
	<CAHyh4xiATAV801U7zjK1F_B+7e2bDWhH1-gpFKF3U1jNmCfScw@mail.gmail.com>
	<20170215025243.GA3988@pxdev.xzpeter.org>
	<CAHyh4xg0sY2woR5BPVd6uiESpu6U9PHYs7a173sQ7BcLSVk5Hg@mail.gmail.com>
	<20170215155035.3f7220c4@t450s.home>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Wed, 15 Feb 2017 18:25:26 -0500
Message-ID: <CAHyh4xi-WbHETaU85gAmbipR+nvUGhcqcVmD_T4AU4tD4Cm=Hg@mail.gmail.com>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, mst@redhat.com, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Wed, Feb 15, 2017 at 5:50 PM, Alex Williamson <alex.williamson@redhat.com
> wrote:

> On Wed, 15 Feb 2017 17:05:35 -0500
> Jintack Lim <jintack@cs.columbia.edu> wrote:
>
> > On Tue, Feb 14, 2017 at 9:52 PM, Peter Xu <peterx@redhat.com> wrote:
> >
> > > On Tue, Feb 14, 2017 at 07:50:39AM -0500, Jintack Lim wrote:
> > >
> > > [...]
> > >
> > > > > > >> > I misunderstood what you said?
> > > > > > >
> > > > > > > I failed to understand why an vIOMMU could help boost
> performance.
> > > :(
> > > > > > > Could you provide your command line here so that I can try to
> > > > > > > reproduce?
> > > > > >
> > > > > > Sure. This is the command line to launch L1 VM
> > > > > >
> > > > > > qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
> > > > > > -m 12G -device intel-iommu,intremap=on,eim=off,caching-mode=on \
> > > > > > -drive file=/mydata/guest0.img,format=raw --nographic -cpu host
> \
> > > > > > -smp 4,sockets=4,cores=1,threads=1 \
> > > > > > -device vfio-pci,host=08:00.0,id=net0
> > > > > >
> > > > > > And this is for L2 VM.
> > > > > >
> > > > > > ./qemu-system-x86_64 -M q35,accel=kvm \
> > > > > > -m 8G \
> > > > > > -drive file=/vm/l2guest.img,format=raw --nographic -cpu host \
> > > > > > -device vfio-pci,host=00:03.0,id=net0
> > > > >
> > > > > ... here looks like these are command lines for L1/L2 guest, rather
> > > > > than L1 guest with/without vIOMMU?
> > > > >
> > > >
> > > > That's right. I thought you were asking about command lines for L1/L2
> > > guest
> > > > :(.
> > > > I think I made the confusion, and as I said above, I didn't mean to
> talk
> > > > about the performance of L1 guest with/without vIOMMO.
> > > > We can move on!
> > >
> > > I see. Sure! :-)
> > >
> > > [...]
> > >
> > > > >
> > > > > Then, I *think* above assertion you encountered would fail only if
> > > > > prev == 0 here, but I still don't quite sure why was that
> happening.
> > > > > Btw, could you paste me your "lspci -vvv -s 00:03.0" result in
> your L1
> > > > > guest?
> > > > >
> > > >
> > > > Sure. This is from my L1 guest.
> > >
> > > Hmm... I think I found the problem...
> > >
> > > >
> > > > root@guest0:~# lspci -vvv -s 00:03.0
> > > > 00:03.0 Network controller: Mellanox Technologies MT27500 Family
> > > > [ConnectX-3]
> > > > Subsystem: Mellanox Technologies Device 0050
> > > > Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > > > Stepping- SERR+ FastB2B- DisINTx+
> > > > Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort-
> > > > <MAbort- >SERR- <PERR- INTx-
> > > > Latency: 0, Cache Line Size: 64 bytes
> > > > Interrupt: pin A routed to IRQ 23
> > > > Region 0: Memory at fe900000 (64-bit, non-prefetchable) [size=1M]
> > > > Region 2: Memory at fe000000 (64-bit, prefetchable) [size=8M]
> > > > Expansion ROM at fea00000 [disabled] [size=1M]
> > > > Capabilities: [40] Power Management version 3
> > > > Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-
> > > )
> > > > Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > > Capabilities: [48] Vital Product Data
> > > > Product Name: CX354A - ConnectX-3 QSFP
> > > > Read-only fields:
> > > > [PN] Part number: MCX354A-FCBT
> > > > [EC] Engineering changes: A4
> > > > [SN] Serial number: MT1346X00791
> > > > [V0] Vendor specific: PCIe Gen3 x8
> > > > [RV] Reserved: checksum good, 0 byte(s) reserved
> > > > Read/write fields:
> > > > [V1] Vendor specific: N/A
> > > > [YA] Asset tag: N/A
> > > > [RW] Read-write area: 105 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 253 byte(s) free
> > > > [RW] Read-write area: 252 byte(s) free
> > > > End
> > > > Capabilities: [9c] MSI-X: Enable+ Count=128 Masked-
> > > > Vector table: BAR=0 offset=0007c000
> > > > PBA: BAR=0 offset=0007d000
> > > > Capabilities: [60] Express (v2) Root Complex Integrated Endpoint,
> MSI 00
> > > > DevCap: MaxPayload 256 bytes, PhantFunc 0
> > > > ExtTag- RBE+
> > > > DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
> > > > RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > > > MaxPayload 256 bytes, MaxReadReq 4096 bytes
> > > > DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
> > > > DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
> > > > Supported
> > > > DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF
> > > Disabled
> > > > Capabilities: [100 v0] #00
> > >
> > > Here we have the head of ecap capability as cap_id==0, then when we
> > > boot the l2 guest with the same device, we'll first copy this
> > > cap_id==0 cap, then when adding the 2nd ecap, we'll probably encounter
> > > problem since pcie_find_capability_list() will thought there is no cap
> > > at all (cap_id==0 is skipped).
> > >
> > > Do you want to try this "hacky patch" to see whether it works for you?
> > >
> >
> > Thanks for following this up!
> >
> > I just tried this, and I got some different message this time.
> >
> > qemu-system-x86_64: vfio: Cannot reset device 0000:00:03.0, no available
> > reset mechanism.
> > qemu-system-x86_64: vfio: Cannot reset device 0000:00:03.0, no available
> > reset mechanism.
>
> Possibly very true, it might affect the reliability of the device in
> the l2 guest, but shouldn't prevent it from being assigned.  What's the
> reset mechanism on the physical device (lspci -vvv from host please).
>

Thanks, Alex.
This is from the host (L0).

08:00.0 Network controller: Mellanox Technologies MT27500 Family
[ConnectX-3]
Subsystem: Mellanox Technologies Device 0050
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 31
Region 0: Memory at d9f00000 (64-bit, non-prefetchable) [disabled] [size=1M]
Region 2: Memory at d5000000 (64-bit, prefetchable) [disabled] [size=8M]
Expansion ROM at d9000000 [disabled] [size=1M]
Capabilities: [40] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [48] Vital Product Data
Product Name: CX354A - ConnectX-3 QSFP
Read-only fields:
[PN] Part number: MCX354A-FCBT
[EC] Engineering changes: A4
[SN] Serial number: MT1346X00624
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
Capabilities: [9c] MSI-X: Enable- Count=128 Masked-
Vector table: BAR=0 offset=0007c000
PBA: BAR=0 offset=0007d000
Capabilities: [60] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 unlimited
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 256 bytes, MaxReadReq 4096 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #8, Speed 8GT/s, Width x8, ASPM L0s, Exit Latency L0s
unlimited, L1 unlimited
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt-
ABWMgmt-
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
Supported
DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,
EqualizationPhase1+
EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
Capabilities: [c0] Vendor Specific Information: Len=18 <?>
Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
ARICap: MFVC- ACS-, Next Function: 0
ARICtl: MFVC- ACS-, Function Group: 0
Capabilities: [148 v1] Device Serial Number f4-52-14-03-00-15-51-10
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
Capabilities: [18c v1] #19
Kernel driver in use: vfio-pci


Thanks,
>
> Alex
>
>
