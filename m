Received: from eggs.gnu.org ([2001:4830:134:3::10]:55707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fryJa-0002CE-As
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fryJY-0006c5-89
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:35860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fryJY-0006bX-1t
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:30:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fryJX-0003BS-B0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5074E2E8041
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 04:17:30 -0000
From: Launchpad Bug Tracker <1471583@bugs.launchpad.net>
Reply-To: Bug 1471583 <1471583@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150705175825.18932.46509.malonedeb@chaenomeles.canonical.com>
Message-Id: <153482505067.29888.4426776446336899839.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1471583] Re: QCA988X Wifi Card Not PCI Passing
 Through
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1471583

Title:
  QCA988X Wifi Card Not PCI Passing Through

Status in QEMU:
  Expired

Bug description:
  CPU:  Intel(R) Xeon(R) CPU E3-1265L v3 @ 2.50GHz
  KVM:  qemu-kvm-1.5.3-86.el7_1.2.x86_64
  Kernel:  4.1.1-1.el7.elrepo.x86_64, and kernel-3.10.0-229.7.2.el7.x86_64
  Host & Guest: CentOS 7.1
  Using virt-manager-1.1.0-12.el7.noarch to create, configure, and start gu=
est

  I am trying to do a PCI passthrough of a QCA988X wifi card.  It's a Doodl=
e Labs military-grade 802.11ac miniPCI card, which uses the ath10k kernel d=
river.  This card configures nicely on the host, and seems to pass through =
to the guest, but early in the boot of the guest it says "Unknown header ty=
pe" at the wifi's bus address.  And sure enough, lspci -vv on the host then=
 shows:
          !!! Unknown header type 7f
          Kernel driver in use: vfio-pci

  When the guest has booted, of course it shows as an Unclassified
  device.  Host and guest must run at least kernel 4.0 so the wifi
  card's current firmware will load, and so that its driver comes with
  the kernel.  I have both host and guest set up for the wifi card.  I
  tried running kernel 3.10 in the host and passing through the PCI
  device, but same behavior.

  I am passing through to the guest an Intel i350 ethernet card just
  fine, in fact I'm passing through two of its SR-IOV virt interfaces to
  the guest, so that works.

  On the host, before I start the guest, the wifi card looks like this
  (lspci -vv):

  0a:00.0 Network controller: Qualcomm Atheros QCA988x 802.11ac Wireless Ne=
twork Adapter
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
          Latency: 0, Cache Line Size: 64 bytes
          Interrupt: pin A routed to IRQ 43
          Region 0: Memory at f7000000 (64-bit, non-prefetchable) [size=3D2=
M]
          Expansion ROM at f7200000 [disabled] [size=3D64K]
          Capabilities: [40] Power Management version 2
                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1=
+,D2+,D3hot+,D3cold+)
                  Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
          Capabilities: [50] MSI: Enable+ Count=3D8/8 Maskable+ 64bit-
                  Address: fee00618  Data: 0000
                  Masking: 00000000  Pending: 00000000
          Capabilities: [70] Express (v2) Endpoint, MSI 00
                  DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s un=
limited, L1 <64us
                          ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                  DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Uns=
upported-
                          RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                          MaxPayload 128 bytes, MaxReadReq 512 bytes
                  DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ =
TransPend-
                  LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Ex=
it Latency L0s <4us, L1 <64us
                          ClockPM- Surprise- LLActRep- BwNot-
                  LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                  LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ D=
LActive- BWMgmt- ABWMgmt-
                  DevCap2: Completion Timeout: Not Supported, TimeoutDis+, =
LTR-, OBFF Not Supported
                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, L=
TR-, OBFF Disabled
                  LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Spe=
edDis-
                           Transmit Margin: Normal Operating Range, EnterMo=
difiedCompliance- ComplianceSOS-
                           Compliance De-emphasis: -6dB
                  LnkSta2: Current De-emphasis Level: -6dB, EqualizationCom=
plete-, EqualizationPhase1-
                           EqualizationPhase2-, EqualizationPhase3-, LinkEq=
ualizationRequest-
          Capabilities: [100 v1] Advanced Error Reporting
                  UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                  UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                  UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                  CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFat=
alErr-
                  CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFat=
alErr+
                  AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- =
ChkEn-
          Capabilities: [140 v1] Virtual Channel
                  Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                  Arb:    Fixed- WRR32- WRR64- WRR128-
                  Ctrl:   ArbSelect=3DFixed
                  Status: InProgress-
                  VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopT=
rans-
                          Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR=
256-
                          Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D=
01
                          Status: NegoPending- InProgress-
          Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-=
00
          Kernel driver in use: ath10k_pci

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1471583/+subscriptions
