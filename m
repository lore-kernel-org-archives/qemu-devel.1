Received: from eggs.gnu.org ([2001:4830:134:3::10]:35970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT2C9-0004zi-19
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT2C5-0005Dx-PM
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dT2C5-0005DQ-Cw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:31:25 -0400
References: <895558F6EA4E3B41AC93A00D163B7274162E2512@SHSMSX103.ccr.corp.intel.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <503895c7-4649-a568-2ee4-0fea1908fd60@redhat.com>
Date: Thu, 6 Jul 2017 10:31:19 +0200
MIME-Version: 1.0
In-Reply-To: <895558F6EA4E3B41AC93A00D163B7274162E2512@SHSMSX103.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] The maximum limit of virtual network device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wu, Jiaxin" <jiaxin.wu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>

Hi Jiaxin,

it's nice to see a question from you on qemu-devel! :)

On 07/06/17 08:20, Wu, Jiaxin wrote:
> Hello experts,
>
> We know QEMU has the capability to create the multiple network devices
> in one QEMU guest with the -device syntax. But I met the below failure
> when I'm trying to create more than 30 virtual devices with the each
> TAP backend:
>
> qemu-system-x86_64: -device e1000: PCI: no slot/function available for
> e1000, all in use.
>
> The corresponding QEMU command shows as following:
>
> sudo qemu-system-x86_64 \
>   -pflash OVMF.fd \
>   -global e1000.romfile="" \
>   -netdev tap,id=hostnet0,ifname=tap0,script=no,downscript=no \
>   -device e1000,netdev=hostnet0 \
>   -netdev tap,id=hostnet1,ifname=tap1,script=no,downscript=no \
>   -device e1000,netdev=hostnet1 \
>   -netdev tap,id=hostnet2,ifname=tap2,script=no,downscript=no \
>   -device e1000,netdev=hostnet2 \
>   -netdev tap,id=hostnet3,ifname=tap3,script=no,downscript=no \
>   -device e1000,netdev=hostnet3 \
>   -netdev tap,id=hostnet4,ifname=tap4,script=no,downscript=no \
>   -device e1000,netdev=hostnet4 \
>   -netdev tap,id=hostnet5,ifname=tap5,script=no,downscript=no \
>   -device e1000,netdev=hostnet5 \
>   -netdev tap,id=hostnet6,ifname=tap6,script=no,downscript=no \
>   -device e1000,netdev=hostnet6 \
>   -netdev tap,id=hostnet7,ifname=tap7,script=no,downscript=no \
>   -device e1000,netdev=hostnet7 \
>   -netdev tap,id=hostnet8,ifname=tap8,script=no,downscript=no \
>   -device e1000,netdev=hostnet8 \
>   -netdev tap,id=hostnet9,ifname=tap9,script=no,downscript=no \
>   -device e1000,netdev=hostnet9 \
>   -netdev tap,id=hostnet10,ifname=tap10,script=no,downscript=no \
>   -device e1000,netdev=hostnet10 \
>   -netdev tap,id=hostnet11,ifname=tap11,script=no,downscript=no \
>   -device e1000,netdev=hostnet11 \
>   -netdev tap,id=hostnet12,ifname=tap12,script=no,downscript=no \
>   -device e1000,netdev=hostnet12 \
>   -netdev tap,id=hostnet13,ifname=tap13,script=no,downscript=no \
>   -device e1000,netdev=hostnet13 \
>   -netdev tap,id=hostnet14,ifname=tap14,script=no,downscript=no \
>   -device e1000,netdev=hostnet14 \
>   -netdev tap,id=hostnet15,ifname=tap15,script=no,downscript=no \
>   -device e1000,netdev=hostnet15 \
>   -netdev tap,id=hostnet16,ifname=tap16,script=no,downscript=no \
>   -device e1000,netdev=hostnet16 \
>   -netdev tap,id=hostnet17,ifname=tap17,script=no,downscript=no \
>   -device e1000,netdev=hostnet17 \
>   -netdev tap,id=hostnet18,ifname=tap18,script=no,downscript=no \
>   -device e1000,netdev=hostnet18 \
>   -netdev tap,id=hostnet19,ifname=tap19,script=no,downscript=no \
>   -device e1000,netdev=hostnet19 \
>   -netdev tap,id=hostnet20,ifname=tap20,script=no,downscript=no \
>   -device e1000,netdev=hostnet20 \
>   -netdev tap,id=hostnet21,ifname=tap21,script=no,downscript=no \
>   -device e1000,netdev=hostnet21 \
>   -netdev tap,id=hostnet22,ifname=tap22,script=no,downscript=no \
>   -device e1000,netdev=hostnet22 \
>   -netdev tap,id=hostnet23,ifname=tap23,script=no,downscript=no \
>   -device e1000,netdev=hostnet23 \
>   -netdev tap,id=hostnet24,ifname=tap24,script=no,downscript=no \
>   -device e1000,netdev=hostnet24 \
>   -netdev tap,id=hostnet25,ifname=tap25,script=no,downscript=no \
>   -device e1000,netdev=hostnet25 \
>   -netdev tap,id=hostnet26,ifname=tap26,script=no,downscript=no \
>   -device e1000,netdev=hostnet26 \
>   -netdev tap,id=hostnet27,ifname=tap27,script=no,downscript=no \
>   -device e1000,netdev=hostnet27 \
>   -netdev tap,id=hostnet28,ifname=tap28,script=no,downscript=no \
>   -device e1000,netdev=hostnet28 \
>   -netdev tap,id=hostnet29,ifname=tap29,script=no,downscript=no \
>   -device e1000,netdev=hostnet29
>
> From above,  the max limit of virtual network device in one guest is
> about 29? If not, how can I avoid such failure? My use case is to
> create more than 150 network devices in one guest. Please provide your
> comments on this.

You are seeing the above symptom because the above command line
instructs QEMU to do the following:
- use the i440fx machine type,
- use a single PCI bus (= the main root bridge),
- add the e1000 cards to separate slots (always using function 0) on
  that bus.

Accordingly, there are three things you can do to remedy this:

- Use the Q35 machine type and work with a PCI Express hierarchy rather
  than a PCI hierarchy. I'm mentioning this only for completeness,
  because it won't directly help your use case. But, I certainly want to
  highlight "docs/pcie.txt". Please read it sometime; it has nice
  examples and makes good points.

- Use multiple PCI bridges to attach the devices. For this, several ways
  are possible:

  - use multiple root buses, with the pxb or pxb-pcie devices (see
    "docs/pci_expander_bridge.txt" and "docs/pcie.txt")

  - use multiple normal PCI bridges

  - use multiple PCI Express root ports or downstream ports (but for
    this, you'll likely have to use the PCI Express variant of the
    e1000, namely e1000e)

- If you don't need hot-plug / hot-unplug, aggregate eights of e1000
  NICs into multifunction PCI devices.

Now, I would normally recommend sticking with i440fx for simplicity.
However, each PCI bridge requires 4KB of IO space (meaning (1 + 5) * 4KB
= 24KB),  and OVMF on the i440fx does not support that much (only
0x4000). So, I'll recommend Q35 for IO space purposes; OVMF on Q35
provides 0xA000 (40KB).

For scaling higher than this, a PCI Express hierarchy should be used
with PCI Express devices that require no IO space at all. However, that
setup is even more problematic *for now*; please see section "3. IO
space issues" in "docs/pcie.txt". We have open OVMF and QEMU BZs for
limiting IO space allocation to cases when it is really necessary:

  https://bugzilla.redhat.com/show_bug.cgi?id=1344299
  https://bugzilla.redhat.com/show_bug.cgi?id=1434740

Therefore I guess the simplest example I can give now is:
- use Q35 (for a larger IO space),
- plug a DMI-PCI bridge into the root bridge,
- plug 5 PCI bridges into the DMI-PCI bridge,
- plug 31 NICs per PCI bridge, each NIC into a separate slot.

This follows the following recommendation of "2.3 PCI only hierarchy" in
"docs/pcie.txt" (slightly rewrapped here):

> 2.3 PCI only hierarchy
> ======================
> Legacy PCI devices can be plugged into pcie.0 as Integrated Endpoints,
> but, as mentioned in section 5, doing so means the legacy PCI
> device in question will be incapable of hot-unplugging.
> Besides that use DMI-PCI Bridges (i82801b11-bridge) in combination
> with PCI-PCI Bridges (pci-bridge) to start PCI hierarchies.
>
> Prefer flat hierarchies. For most scenarios a single DMI-PCI Bridge
> (having 32 slots) and several PCI-PCI Bridges attached to it (each
> supporting also 32 slots) will support hundreds of legacy devices. The
> recommendation is to populate one PCI-PCI Bridge under the DMI-PCI
> Bridge until is full and then plug a new PCI-PCI Bridge...

Here's a command line. Please note that the OVMF boot may take quite
long with this, as the E3522X2.EFI driver from BootUtil (-D
E1000_ENABLE) binds all 150 e1000 NICs in succession! Watching the OVMF
debug log is recommended.

qemu-system-x86_64 \
  \
  -machine q35,vmport=off,accel=kvm \
  -pflash OVMF.fd \
  -global e1000.romfile="" \
  -m 2048 \
  -debugcon file:debug.log \
  -global isa-debugcon.iobase=0x402 \
  \
  -netdev tap,id=hostnet0,ifname=tap0,script=no,downscript=no \
  -netdev tap,id=hostnet1,ifname=tap1,script=no,downscript=no \
  -netdev tap,id=hostnet2,ifname=tap2,script=no,downscript=no \
  -netdev tap,id=hostnet3,ifname=tap3,script=no,downscript=no \
  -netdev tap,id=hostnet4,ifname=tap4,script=no,downscript=no \
  -netdev tap,id=hostnet5,ifname=tap5,script=no,downscript=no \
  -netdev tap,id=hostnet6,ifname=tap6,script=no,downscript=no \
  -netdev tap,id=hostnet7,ifname=tap7,script=no,downscript=no \
  -netdev tap,id=hostnet8,ifname=tap8,script=no,downscript=no \
  -netdev tap,id=hostnet9,ifname=tap9,script=no,downscript=no \
  -netdev tap,id=hostnet10,ifname=tap10,script=no,downscript=no \
  -netdev tap,id=hostnet11,ifname=tap11,script=no,downscript=no \
  -netdev tap,id=hostnet12,ifname=tap12,script=no,downscript=no \
  -netdev tap,id=hostnet13,ifname=tap13,script=no,downscript=no \
  -netdev tap,id=hostnet14,ifname=tap14,script=no,downscript=no \
  -netdev tap,id=hostnet15,ifname=tap15,script=no,downscript=no \
  -netdev tap,id=hostnet16,ifname=tap16,script=no,downscript=no \
  -netdev tap,id=hostnet17,ifname=tap17,script=no,downscript=no \
  -netdev tap,id=hostnet18,ifname=tap18,script=no,downscript=no \
  -netdev tap,id=hostnet19,ifname=tap19,script=no,downscript=no \
  -netdev tap,id=hostnet20,ifname=tap20,script=no,downscript=no \
  -netdev tap,id=hostnet21,ifname=tap21,script=no,downscript=no \
  -netdev tap,id=hostnet22,ifname=tap22,script=no,downscript=no \
  -netdev tap,id=hostnet23,ifname=tap23,script=no,downscript=no \
  -netdev tap,id=hostnet24,ifname=tap24,script=no,downscript=no \
  -netdev tap,id=hostnet25,ifname=tap25,script=no,downscript=no \
  -netdev tap,id=hostnet26,ifname=tap26,script=no,downscript=no \
  -netdev tap,id=hostnet27,ifname=tap27,script=no,downscript=no \
  -netdev tap,id=hostnet28,ifname=tap28,script=no,downscript=no \
  -netdev tap,id=hostnet29,ifname=tap29,script=no,downscript=no \
  -netdev tap,id=hostnet30,ifname=tap30,script=no,downscript=no \
  -netdev tap,id=hostnet31,ifname=tap31,script=no,downscript=no \
  -netdev tap,id=hostnet32,ifname=tap32,script=no,downscript=no \
  -netdev tap,id=hostnet33,ifname=tap33,script=no,downscript=no \
  -netdev tap,id=hostnet34,ifname=tap34,script=no,downscript=no \
  -netdev tap,id=hostnet35,ifname=tap35,script=no,downscript=no \
  -netdev tap,id=hostnet36,ifname=tap36,script=no,downscript=no \
  -netdev tap,id=hostnet37,ifname=tap37,script=no,downscript=no \
  -netdev tap,id=hostnet38,ifname=tap38,script=no,downscript=no \
  -netdev tap,id=hostnet39,ifname=tap39,script=no,downscript=no \
  -netdev tap,id=hostnet40,ifname=tap40,script=no,downscript=no \
  -netdev tap,id=hostnet41,ifname=tap41,script=no,downscript=no \
  -netdev tap,id=hostnet42,ifname=tap42,script=no,downscript=no \
  -netdev tap,id=hostnet43,ifname=tap43,script=no,downscript=no \
  -netdev tap,id=hostnet44,ifname=tap44,script=no,downscript=no \
  -netdev tap,id=hostnet45,ifname=tap45,script=no,downscript=no \
  -netdev tap,id=hostnet46,ifname=tap46,script=no,downscript=no \
  -netdev tap,id=hostnet47,ifname=tap47,script=no,downscript=no \
  -netdev tap,id=hostnet48,ifname=tap48,script=no,downscript=no \
  -netdev tap,id=hostnet49,ifname=tap49,script=no,downscript=no \
  -netdev tap,id=hostnet50,ifname=tap50,script=no,downscript=no \
  -netdev tap,id=hostnet51,ifname=tap51,script=no,downscript=no \
  -netdev tap,id=hostnet52,ifname=tap52,script=no,downscript=no \
  -netdev tap,id=hostnet53,ifname=tap53,script=no,downscript=no \
  -netdev tap,id=hostnet54,ifname=tap54,script=no,downscript=no \
  -netdev tap,id=hostnet55,ifname=tap55,script=no,downscript=no \
  -netdev tap,id=hostnet56,ifname=tap56,script=no,downscript=no \
  -netdev tap,id=hostnet57,ifname=tap57,script=no,downscript=no \
  -netdev tap,id=hostnet58,ifname=tap58,script=no,downscript=no \
  -netdev tap,id=hostnet59,ifname=tap59,script=no,downscript=no \
  -netdev tap,id=hostnet60,ifname=tap60,script=no,downscript=no \
  -netdev tap,id=hostnet61,ifname=tap61,script=no,downscript=no \
  -netdev tap,id=hostnet62,ifname=tap62,script=no,downscript=no \
  -netdev tap,id=hostnet63,ifname=tap63,script=no,downscript=no \
  -netdev tap,id=hostnet64,ifname=tap64,script=no,downscript=no \
  -netdev tap,id=hostnet65,ifname=tap65,script=no,downscript=no \
  -netdev tap,id=hostnet66,ifname=tap66,script=no,downscript=no \
  -netdev tap,id=hostnet67,ifname=tap67,script=no,downscript=no \
  -netdev tap,id=hostnet68,ifname=tap68,script=no,downscript=no \
  -netdev tap,id=hostnet69,ifname=tap69,script=no,downscript=no \
  -netdev tap,id=hostnet70,ifname=tap70,script=no,downscript=no \
  -netdev tap,id=hostnet71,ifname=tap71,script=no,downscript=no \
  -netdev tap,id=hostnet72,ifname=tap72,script=no,downscript=no \
  -netdev tap,id=hostnet73,ifname=tap73,script=no,downscript=no \
  -netdev tap,id=hostnet74,ifname=tap74,script=no,downscript=no \
  -netdev tap,id=hostnet75,ifname=tap75,script=no,downscript=no \
  -netdev tap,id=hostnet76,ifname=tap76,script=no,downscript=no \
  -netdev tap,id=hostnet77,ifname=tap77,script=no,downscript=no \
  -netdev tap,id=hostnet78,ifname=tap78,script=no,downscript=no \
  -netdev tap,id=hostnet79,ifname=tap79,script=no,downscript=no \
  -netdev tap,id=hostnet80,ifname=tap80,script=no,downscript=no \
  -netdev tap,id=hostnet81,ifname=tap81,script=no,downscript=no \
  -netdev tap,id=hostnet82,ifname=tap82,script=no,downscript=no \
  -netdev tap,id=hostnet83,ifname=tap83,script=no,downscript=no \
  -netdev tap,id=hostnet84,ifname=tap84,script=no,downscript=no \
  -netdev tap,id=hostnet85,ifname=tap85,script=no,downscript=no \
  -netdev tap,id=hostnet86,ifname=tap86,script=no,downscript=no \
  -netdev tap,id=hostnet87,ifname=tap87,script=no,downscript=no \
  -netdev tap,id=hostnet88,ifname=tap88,script=no,downscript=no \
  -netdev tap,id=hostnet89,ifname=tap89,script=no,downscript=no \
  -netdev tap,id=hostnet90,ifname=tap90,script=no,downscript=no \
  -netdev tap,id=hostnet91,ifname=tap91,script=no,downscript=no \
  -netdev tap,id=hostnet92,ifname=tap92,script=no,downscript=no \
  -netdev tap,id=hostnet93,ifname=tap93,script=no,downscript=no \
  -netdev tap,id=hostnet94,ifname=tap94,script=no,downscript=no \
  -netdev tap,id=hostnet95,ifname=tap95,script=no,downscript=no \
  -netdev tap,id=hostnet96,ifname=tap96,script=no,downscript=no \
  -netdev tap,id=hostnet97,ifname=tap97,script=no,downscript=no \
  -netdev tap,id=hostnet98,ifname=tap98,script=no,downscript=no \
  -netdev tap,id=hostnet99,ifname=tap99,script=no,downscript=no \
  -netdev tap,id=hostnet100,ifname=tap100,script=no,downscript=no \
  -netdev tap,id=hostnet101,ifname=tap101,script=no,downscript=no \
  -netdev tap,id=hostnet102,ifname=tap102,script=no,downscript=no \
  -netdev tap,id=hostnet103,ifname=tap103,script=no,downscript=no \
  -netdev tap,id=hostnet104,ifname=tap104,script=no,downscript=no \
  -netdev tap,id=hostnet105,ifname=tap105,script=no,downscript=no \
  -netdev tap,id=hostnet106,ifname=tap106,script=no,downscript=no \
  -netdev tap,id=hostnet107,ifname=tap107,script=no,downscript=no \
  -netdev tap,id=hostnet108,ifname=tap108,script=no,downscript=no \
  -netdev tap,id=hostnet109,ifname=tap109,script=no,downscript=no \
  -netdev tap,id=hostnet110,ifname=tap110,script=no,downscript=no \
  -netdev tap,id=hostnet111,ifname=tap111,script=no,downscript=no \
  -netdev tap,id=hostnet112,ifname=tap112,script=no,downscript=no \
  -netdev tap,id=hostnet113,ifname=tap113,script=no,downscript=no \
  -netdev tap,id=hostnet114,ifname=tap114,script=no,downscript=no \
  -netdev tap,id=hostnet115,ifname=tap115,script=no,downscript=no \
  -netdev tap,id=hostnet116,ifname=tap116,script=no,downscript=no \
  -netdev tap,id=hostnet117,ifname=tap117,script=no,downscript=no \
  -netdev tap,id=hostnet118,ifname=tap118,script=no,downscript=no \
  -netdev tap,id=hostnet119,ifname=tap119,script=no,downscript=no \
  -netdev tap,id=hostnet120,ifname=tap120,script=no,downscript=no \
  -netdev tap,id=hostnet121,ifname=tap121,script=no,downscript=no \
  -netdev tap,id=hostnet122,ifname=tap122,script=no,downscript=no \
  -netdev tap,id=hostnet123,ifname=tap123,script=no,downscript=no \
  -netdev tap,id=hostnet124,ifname=tap124,script=no,downscript=no \
  -netdev tap,id=hostnet125,ifname=tap125,script=no,downscript=no \
  -netdev tap,id=hostnet126,ifname=tap126,script=no,downscript=no \
  -netdev tap,id=hostnet127,ifname=tap127,script=no,downscript=no \
  -netdev tap,id=hostnet128,ifname=tap128,script=no,downscript=no \
  -netdev tap,id=hostnet129,ifname=tap129,script=no,downscript=no \
  -netdev tap,id=hostnet130,ifname=tap130,script=no,downscript=no \
  -netdev tap,id=hostnet131,ifname=tap131,script=no,downscript=no \
  -netdev tap,id=hostnet132,ifname=tap132,script=no,downscript=no \
  -netdev tap,id=hostnet133,ifname=tap133,script=no,downscript=no \
  -netdev tap,id=hostnet134,ifname=tap134,script=no,downscript=no \
  -netdev tap,id=hostnet135,ifname=tap135,script=no,downscript=no \
  -netdev tap,id=hostnet136,ifname=tap136,script=no,downscript=no \
  -netdev tap,id=hostnet137,ifname=tap137,script=no,downscript=no \
  -netdev tap,id=hostnet138,ifname=tap138,script=no,downscript=no \
  -netdev tap,id=hostnet139,ifname=tap139,script=no,downscript=no \
  -netdev tap,id=hostnet140,ifname=tap140,script=no,downscript=no \
  -netdev tap,id=hostnet141,ifname=tap141,script=no,downscript=no \
  -netdev tap,id=hostnet142,ifname=tap142,script=no,downscript=no \
  -netdev tap,id=hostnet143,ifname=tap143,script=no,downscript=no \
  -netdev tap,id=hostnet144,ifname=tap144,script=no,downscript=no \
  -netdev tap,id=hostnet145,ifname=tap145,script=no,downscript=no \
  -netdev tap,id=hostnet146,ifname=tap146,script=no,downscript=no \
  -netdev tap,id=hostnet147,ifname=tap147,script=no,downscript=no \
  -netdev tap,id=hostnet148,ifname=tap148,script=no,downscript=no \
  -netdev tap,id=hostnet149,ifname=tap149,script=no,downscript=no \
  \
  -device i82801b11-bridge,id=dmi-pci-bridge \
  \
  -device pci-bridge,id=bridge-1,chassis_nr=1,bus=dmi-pci-bridge \
  -device pci-bridge,id=bridge-2,chassis_nr=2,bus=dmi-pci-bridge \
  -device pci-bridge,id=bridge-3,chassis_nr=3,bus=dmi-pci-bridge \
  -device pci-bridge,id=bridge-4,chassis_nr=4,bus=dmi-pci-bridge \
  -device pci-bridge,id=bridge-5,chassis_nr=5,bus=dmi-pci-bridge \
  \
  -device e1000,netdev=hostnet0,bus=bridge-1,addr=0x1.0 \
  -device e1000,netdev=hostnet1,bus=bridge-1,addr=0x2.0 \
  -device e1000,netdev=hostnet2,bus=bridge-1,addr=0x3.0 \
  -device e1000,netdev=hostnet3,bus=bridge-1,addr=0x4.0 \
  -device e1000,netdev=hostnet4,bus=bridge-1,addr=0x5.0 \
  -device e1000,netdev=hostnet5,bus=bridge-1,addr=0x6.0 \
  -device e1000,netdev=hostnet6,bus=bridge-1,addr=0x7.0 \
  -device e1000,netdev=hostnet7,bus=bridge-1,addr=0x8.0 \
  -device e1000,netdev=hostnet8,bus=bridge-1,addr=0x9.0 \
  -device e1000,netdev=hostnet9,bus=bridge-1,addr=0xa.0 \
  -device e1000,netdev=hostnet10,bus=bridge-1,addr=0xb.0 \
  -device e1000,netdev=hostnet11,bus=bridge-1,addr=0xc.0 \
  -device e1000,netdev=hostnet12,bus=bridge-1,addr=0xd.0 \
  -device e1000,netdev=hostnet13,bus=bridge-1,addr=0xe.0 \
  -device e1000,netdev=hostnet14,bus=bridge-1,addr=0xf.0 \
  -device e1000,netdev=hostnet15,bus=bridge-1,addr=0x10.0 \
  -device e1000,netdev=hostnet16,bus=bridge-1,addr=0x11.0 \
  -device e1000,netdev=hostnet17,bus=bridge-1,addr=0x12.0 \
  -device e1000,netdev=hostnet18,bus=bridge-1,addr=0x13.0 \
  -device e1000,netdev=hostnet19,bus=bridge-1,addr=0x14.0 \
  -device e1000,netdev=hostnet20,bus=bridge-1,addr=0x15.0 \
  -device e1000,netdev=hostnet21,bus=bridge-1,addr=0x16.0 \
  -device e1000,netdev=hostnet22,bus=bridge-1,addr=0x17.0 \
  -device e1000,netdev=hostnet23,bus=bridge-1,addr=0x18.0 \
  -device e1000,netdev=hostnet24,bus=bridge-1,addr=0x19.0 \
  -device e1000,netdev=hostnet25,bus=bridge-1,addr=0x1a.0 \
  -device e1000,netdev=hostnet26,bus=bridge-1,addr=0x1b.0 \
  -device e1000,netdev=hostnet27,bus=bridge-1,addr=0x1c.0 \
  -device e1000,netdev=hostnet28,bus=bridge-1,addr=0x1d.0 \
  -device e1000,netdev=hostnet29,bus=bridge-1,addr=0x1e.0 \
  -device e1000,netdev=hostnet30,bus=bridge-1,addr=0x1f.0 \
  \
  -device e1000,netdev=hostnet31,bus=bridge-2,addr=0x1.0 \
  -device e1000,netdev=hostnet32,bus=bridge-2,addr=0x2.0 \
  -device e1000,netdev=hostnet33,bus=bridge-2,addr=0x3.0 \
  -device e1000,netdev=hostnet34,bus=bridge-2,addr=0x4.0 \
  -device e1000,netdev=hostnet35,bus=bridge-2,addr=0x5.0 \
  -device e1000,netdev=hostnet36,bus=bridge-2,addr=0x6.0 \
  -device e1000,netdev=hostnet37,bus=bridge-2,addr=0x7.0 \
  -device e1000,netdev=hostnet38,bus=bridge-2,addr=0x8.0 \
  -device e1000,netdev=hostnet39,bus=bridge-2,addr=0x9.0 \
  -device e1000,netdev=hostnet40,bus=bridge-2,addr=0xa.0 \
  -device e1000,netdev=hostnet41,bus=bridge-2,addr=0xb.0 \
  -device e1000,netdev=hostnet42,bus=bridge-2,addr=0xc.0 \
  -device e1000,netdev=hostnet43,bus=bridge-2,addr=0xd.0 \
  -device e1000,netdev=hostnet44,bus=bridge-2,addr=0xe.0 \
  -device e1000,netdev=hostnet45,bus=bridge-2,addr=0xf.0 \
  -device e1000,netdev=hostnet46,bus=bridge-2,addr=0x10.0 \
  -device e1000,netdev=hostnet47,bus=bridge-2,addr=0x11.0 \
  -device e1000,netdev=hostnet48,bus=bridge-2,addr=0x12.0 \
  -device e1000,netdev=hostnet49,bus=bridge-2,addr=0x13.0 \
  -device e1000,netdev=hostnet50,bus=bridge-2,addr=0x14.0 \
  -device e1000,netdev=hostnet51,bus=bridge-2,addr=0x15.0 \
  -device e1000,netdev=hostnet52,bus=bridge-2,addr=0x16.0 \
  -device e1000,netdev=hostnet53,bus=bridge-2,addr=0x17.0 \
  -device e1000,netdev=hostnet54,bus=bridge-2,addr=0x18.0 \
  -device e1000,netdev=hostnet55,bus=bridge-2,addr=0x19.0 \
  -device e1000,netdev=hostnet56,bus=bridge-2,addr=0x1a.0 \
  -device e1000,netdev=hostnet57,bus=bridge-2,addr=0x1b.0 \
  -device e1000,netdev=hostnet58,bus=bridge-2,addr=0x1c.0 \
  -device e1000,netdev=hostnet59,bus=bridge-2,addr=0x1d.0 \
  -device e1000,netdev=hostnet60,bus=bridge-2,addr=0x1e.0 \
  -device e1000,netdev=hostnet61,bus=bridge-2,addr=0x1f.0 \
  \
  -device e1000,netdev=hostnet62,bus=bridge-3,addr=0x1.0 \
  -device e1000,netdev=hostnet63,bus=bridge-3,addr=0x2.0 \
  -device e1000,netdev=hostnet64,bus=bridge-3,addr=0x3.0 \
  -device e1000,netdev=hostnet65,bus=bridge-3,addr=0x4.0 \
  -device e1000,netdev=hostnet66,bus=bridge-3,addr=0x5.0 \
  -device e1000,netdev=hostnet67,bus=bridge-3,addr=0x6.0 \
  -device e1000,netdev=hostnet68,bus=bridge-3,addr=0x7.0 \
  -device e1000,netdev=hostnet69,bus=bridge-3,addr=0x8.0 \
  -device e1000,netdev=hostnet70,bus=bridge-3,addr=0x9.0 \
  -device e1000,netdev=hostnet71,bus=bridge-3,addr=0xa.0 \
  -device e1000,netdev=hostnet72,bus=bridge-3,addr=0xb.0 \
  -device e1000,netdev=hostnet73,bus=bridge-3,addr=0xc.0 \
  -device e1000,netdev=hostnet74,bus=bridge-3,addr=0xd.0 \
  -device e1000,netdev=hostnet75,bus=bridge-3,addr=0xe.0 \
  -device e1000,netdev=hostnet76,bus=bridge-3,addr=0xf.0 \
  -device e1000,netdev=hostnet77,bus=bridge-3,addr=0x10.0 \
  -device e1000,netdev=hostnet78,bus=bridge-3,addr=0x11.0 \
  -device e1000,netdev=hostnet79,bus=bridge-3,addr=0x12.0 \
  -device e1000,netdev=hostnet80,bus=bridge-3,addr=0x13.0 \
  -device e1000,netdev=hostnet81,bus=bridge-3,addr=0x14.0 \
  -device e1000,netdev=hostnet82,bus=bridge-3,addr=0x15.0 \
  -device e1000,netdev=hostnet83,bus=bridge-3,addr=0x16.0 \
  -device e1000,netdev=hostnet84,bus=bridge-3,addr=0x17.0 \
  -device e1000,netdev=hostnet85,bus=bridge-3,addr=0x18.0 \
  -device e1000,netdev=hostnet86,bus=bridge-3,addr=0x19.0 \
  -device e1000,netdev=hostnet87,bus=bridge-3,addr=0x1a.0 \
  -device e1000,netdev=hostnet88,bus=bridge-3,addr=0x1b.0 \
  -device e1000,netdev=hostnet89,bus=bridge-3,addr=0x1c.0 \
  -device e1000,netdev=hostnet90,bus=bridge-3,addr=0x1d.0 \
  -device e1000,netdev=hostnet91,bus=bridge-3,addr=0x1e.0 \
  -device e1000,netdev=hostnet92,bus=bridge-3,addr=0x1f.0 \
  \
  -device e1000,netdev=hostnet93,bus=bridge-4,addr=0x1.0 \
  -device e1000,netdev=hostnet94,bus=bridge-4,addr=0x2.0 \
  -device e1000,netdev=hostnet95,bus=bridge-4,addr=0x3.0 \
  -device e1000,netdev=hostnet96,bus=bridge-4,addr=0x4.0 \
  -device e1000,netdev=hostnet97,bus=bridge-4,addr=0x5.0 \
  -device e1000,netdev=hostnet98,bus=bridge-4,addr=0x6.0 \
  -device e1000,netdev=hostnet99,bus=bridge-4,addr=0x7.0 \
  -device e1000,netdev=hostnet100,bus=bridge-4,addr=0x8.0 \
  -device e1000,netdev=hostnet101,bus=bridge-4,addr=0x9.0 \
  -device e1000,netdev=hostnet102,bus=bridge-4,addr=0xa.0 \
  -device e1000,netdev=hostnet103,bus=bridge-4,addr=0xb.0 \
  -device e1000,netdev=hostnet104,bus=bridge-4,addr=0xc.0 \
  -device e1000,netdev=hostnet105,bus=bridge-4,addr=0xd.0 \
  -device e1000,netdev=hostnet106,bus=bridge-4,addr=0xe.0 \
  -device e1000,netdev=hostnet107,bus=bridge-4,addr=0xf.0 \
  -device e1000,netdev=hostnet108,bus=bridge-4,addr=0x10.0 \
  -device e1000,netdev=hostnet109,bus=bridge-4,addr=0x11.0 \
  -device e1000,netdev=hostnet110,bus=bridge-4,addr=0x12.0 \
  -device e1000,netdev=hostnet111,bus=bridge-4,addr=0x13.0 \
  -device e1000,netdev=hostnet112,bus=bridge-4,addr=0x14.0 \
  -device e1000,netdev=hostnet113,bus=bridge-4,addr=0x15.0 \
  -device e1000,netdev=hostnet114,bus=bridge-4,addr=0x16.0 \
  -device e1000,netdev=hostnet115,bus=bridge-4,addr=0x17.0 \
  -device e1000,netdev=hostnet116,bus=bridge-4,addr=0x18.0 \
  -device e1000,netdev=hostnet117,bus=bridge-4,addr=0x19.0 \
  -device e1000,netdev=hostnet118,bus=bridge-4,addr=0x1a.0 \
  -device e1000,netdev=hostnet119,bus=bridge-4,addr=0x1b.0 \
  -device e1000,netdev=hostnet120,bus=bridge-4,addr=0x1c.0 \
  -device e1000,netdev=hostnet121,bus=bridge-4,addr=0x1d.0 \
  -device e1000,netdev=hostnet122,bus=bridge-4,addr=0x1e.0 \
  -device e1000,netdev=hostnet123,bus=bridge-4,addr=0x1f.0 \
  \
  -device e1000,netdev=hostnet124,bus=bridge-5,addr=0x1.0 \
  -device e1000,netdev=hostnet125,bus=bridge-5,addr=0x2.0 \
  -device e1000,netdev=hostnet126,bus=bridge-5,addr=0x3.0 \
  -device e1000,netdev=hostnet127,bus=bridge-5,addr=0x4.0 \
  -device e1000,netdev=hostnet128,bus=bridge-5,addr=0x5.0 \
  -device e1000,netdev=hostnet129,bus=bridge-5,addr=0x6.0 \
  -device e1000,netdev=hostnet130,bus=bridge-5,addr=0x7.0 \
  -device e1000,netdev=hostnet131,bus=bridge-5,addr=0x8.0 \
  -device e1000,netdev=hostnet132,bus=bridge-5,addr=0x9.0 \
  -device e1000,netdev=hostnet133,bus=bridge-5,addr=0xa.0 \
  -device e1000,netdev=hostnet134,bus=bridge-5,addr=0xb.0 \
  -device e1000,netdev=hostnet135,bus=bridge-5,addr=0xc.0 \
  -device e1000,netdev=hostnet136,bus=bridge-5,addr=0xd.0 \
  -device e1000,netdev=hostnet137,bus=bridge-5,addr=0xe.0 \
  -device e1000,netdev=hostnet138,bus=bridge-5,addr=0xf.0 \
  -device e1000,netdev=hostnet139,bus=bridge-5,addr=0x10.0 \
  -device e1000,netdev=hostnet140,bus=bridge-5,addr=0x11.0 \
  -device e1000,netdev=hostnet141,bus=bridge-5,addr=0x12.0 \
  -device e1000,netdev=hostnet142,bus=bridge-5,addr=0x13.0 \
  -device e1000,netdev=hostnet143,bus=bridge-5,addr=0x14.0 \
  -device e1000,netdev=hostnet144,bus=bridge-5,addr=0x15.0 \
  -device e1000,netdev=hostnet145,bus=bridge-5,addr=0x16.0 \
  -device e1000,netdev=hostnet146,bus=bridge-5,addr=0x17.0 \
  -device e1000,netdev=hostnet147,bus=bridge-5,addr=0x18.0 \
  -device e1000,netdev=hostnet148,bus=bridge-5,addr=0x19.0 \
  -device e1000,netdev=hostnet149,bus=bridge-5,addr=0x1a.0

Thanks
Laszlo
