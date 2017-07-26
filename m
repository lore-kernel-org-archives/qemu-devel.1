Received: from eggs.gnu.org ([2001:4830:134:3::10]:38188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daRNU-0002eO-Lm
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1daRNP-0004Df-OM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1daRNP-0004BD-Fx
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:49:43 -0400
Date: Wed, 26 Jul 2017 21:49:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170726214852-mutt-send-email-mst@kernel.org>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<d0bd04f4-1ac4-0e3a-885f-2ceb6180f69a@redhat.com>
	<dfb9663b-c31b-2def-9df6-754fb18bb27f@redhat.com>
	<b3936955-d84a-d2ba-e1a0-3ca90547ece7@redhat.com>
	<c1502763-61e8-159a-4455-37e833ca5b6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1502763-61e8-159a-4455-37e833ca5b6d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/4] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, kraxel@redhat.com, seabios@seabios.org, kevin@koconnor.net, qemu-devel@nongnu.org, konrad.wilk@oracle.com

On Wed, Jul 26, 2017 at 07:22:42PM +0300, Marcel Apfelbaum wrote:
> On 26/07/2017 18:20, Laszlo Ersek wrote:
> > On 07/26/17 08:48, Marcel Apfelbaum wrote:
> > > On 25/07/2017 18:46, Laszlo Ersek wrote:
> > 
> > [snip]
> > 
> > > > (2) Bus range reservation, and hotplugging bridges. What's the
> > > > motivation? Our recommendations in "docs/pcie.txt" suggest flat
> > > > hierarchies.
> > > > 
> > > 
> > > It remains flat. You have one single PCIE-PCI bridge plugged
> > > into a PCIe Root Port, no deep nesting.
> > > 
> > > The reason is to be able to support legacy PCI devices without
> > > "committing" with a DMI-PCI bridge in advance. (Keep Q35 without)
> > > legacy hw.
> > > 
> > > The only way to support PCI devices in Q35 is to have them cold-plugged
> > > into the pcie.0 bus, which is good, but not enough for expanding the
> > > Q35 usability in order to make it eventually the default
> > > QEMU x86 machine (I know this is another discussion and I am in
> > > minority, at least for now).
> > > 
> > > The plan is:
> > > Start Q35 machine as usual, but one of the PCIe Root Ports includes
> > > hints for firmware needed t support legacy PCI devices. (IO Ports range,
> > > extra bus,...)
> > > 
> > > Once a pci device is needed you have 2 options:
> > > 1. Plug a PCIe-PCI bridge into a PCIe Root Port and the PCI device
> > >     in the bridge.
> > > 2. Hotplug a PCIe-PCI bridge into a PCIe Root Port and then hotplug
> > >     a PCI device into the bridge.
> > 
> 
> Hi Laszlo,
> 
> > Thank you for the explanation, it makes the intent a lot clearer.
> > 
> > However, what does the hot-pluggability of the PCIe-PCI bridge buy us?
> > In other words, what does it buy us when we do not add the PCIe-PCI
> > bridge immediately at guest startup, as an integrated device?
> >  > Why is it a problem to "commit" in advance? I understand that we might
> > not like the DMI-PCI bridge (due to it being legacy), but what speaks
> > against cold-plugging the PCIe-PCI bridge either as an integrated device
> > in pcie.0 (assuming that is permitted), or cold-plugging the PCIe-PCI
> > bridge in a similarly cold-plugged PCIe root port?
> > 
> 
> We want to keep Q35 clean, and for most cases we don't want any
> legacy PCI stuff if not especially required.

BTW, what are the PCI devices that we actually need?

-- 
MST
