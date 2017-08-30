Received: from eggs.gnu.org ([2001:4830:134:3::10]:52645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dmzUx-0003yh-PV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dmzUw-000730-CW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:41:23 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:37497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1dmzUw-00072s-5E
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:41:22 -0400
Received: by mail-io0-x22d.google.com with SMTP id d78so1867747ioe.4
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 02:41:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170829081305.7a2685c6@w520.home>
References: <20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
	<20170731234626.7664be18@w520.home>
	<CAMxP3BTfMad-ycWHqmW+aVM7rv2CJSv-dmEFUveGBqAWvfbBjQ@mail.gmail.com>
	<20170801090158.35d18f10@w520.home>
	<CAMxP3BRkzXBRPZw9fpCu-w4Fusn6ng_knk1cAz=EDBAiw9UnqA@mail.gmail.com>
	<20170807095224.5438ef8c@w520.home>
	<20170808230043-mutt-send-email-mst@kernel.org>
	<CAMxP3BR=WHKJxcWKH27dcC7DTKGD2y7r12teAUSmMkwp1VDafA@mail.gmail.com>
	<20170822105659.75b5c7e0@w520.home>
	<20170822205940-mutt-send-email-mst@kernel.org>
	<CAMxP3BSNPjRZGOULZ0zKBq8v5Rqv9f5xasx+BD57c=oAS5tSWg@mail.gmail.com>
	<20170829081305.7a2685c6@w520.home>
From: Bob Chen <a175818323@gmail.com>
Date: Wed, 30 Aug 2017 17:41:20 +0800
Message-ID: <CAMxP3BRFzyyHemEW-2DFRd7r9Py-bkjY7vQRNeBfuhN0XKupJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] =?utf-8?q?About_virtio_device_hotplug_in_Q35!_?=
	=?utf-8?b?44CQ5aSW5Z+f6YKu5Lu2LuiwqOaFjuafpemYheOAkQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

I think I have observed what you said...

The link speed on host remained 8GT/s until I finished running
p2pBandwidthLatencyTest
for the first time. Then it became 2.5GT/s...


# lspci -s 09:00.0 -vvv
09:00.0 3D controller: NVIDIA Corporation GM204GL [Tesla M60] (rev a1)
Subsystem: NVIDIA Corporation Device 115e
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 32 bytes
Interrupt: pin A routed to IRQ 7
NUMA node: 0
Region 0: Memory at 92000000 (32-bit, non-prefetchable) [size=16M]
Region 1: Memory at 3b800000000 (64-bit, prefetchable) [size=8G]
Region 3: Memory at 3ba00000000 (64-bit, prefetchable) [size=32M]
Capabilities: [60] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [78] Express (v2) Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 25.000W
DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported-
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
LnkCap: Port #16, Speed 8GT/s, Width x16, ASPM not supported, Exit Latency
L0s <1us, L1 <4us
ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt-
ABWMgmt-
DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR+, OBFF Via message
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+,
EqualizationPhase1+
EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
Status: NegoPending- InProgress-
Capabilities: [250 v1] Latency Tolerance Reporting
Max snoop latency: 0ns
Max no snoop latency: 0ns
Capabilities: [258 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1- L1_PM_Substates+
Capabilities: [128 v1] Power Budgeting <?>
Capabilities: [420 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024
<?>
Capabilities: [900 v1] #19
Kernel driver in use: vfio-pci
Kernel modules: nouveau
