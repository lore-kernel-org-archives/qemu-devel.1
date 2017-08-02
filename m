Received: from eggs.gnu.org ([2001:4830:134:3::10]:46182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dctzn-0007El-Ms
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dctzk-0003w1-8h
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dctzj-0003v6-VS
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:47:28 -0400
Date: Wed, 2 Aug 2017 16:47:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170802164551-mutt-send-email-mst@kernel.org>
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-6-git-send-email-zuban32s@gmail.com>
	<491f77fc-974c-33dd-3974-08ab61d2c078@redhat.com>
	<CAKSfGUCTom8YBs8wOHMX_MpzDF1efB8_USb4tuW+hcAdoG2xvw@mail.gmail.com>
	<20170802003910-mutt-send-email-mst@kernel.org>
	<17a71bfc-1933-f707-2504-c9c699534cea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a71bfc-1933-f707-2504-c9c699534cea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Alexander Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net

On Wed, Aug 02, 2017 at 12:23:46AM +0200, Laszlo Ersek wrote:
> On 08/01/17 23:39, Michael S. Tsirkin wrote:
> > On Wed, Aug 02, 2017 at 12:33:12AM +0300, Alexander Bezzubikov wrote:
> >> 2017-08-01 23:31 GMT+03:00 Laszlo Ersek <lersek@redhat.com>:
> >>> (Whenever my comments conflict with Michael's or Marcel's, I defer to them.)
> >>>
> >>> On 07/29/17 01:37, Aleksandr Bezzubikov wrote:
> >>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> >>>> ---
> >>>>  docs/pcie.txt            |  46 ++++++++++--------
> >>>>  docs/pcie_pci_bridge.txt | 121 +++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  2 files changed, 147 insertions(+), 20 deletions(-)
> >>>>  create mode 100644 docs/pcie_pci_bridge.txt
> >>>>
> >>>> diff --git a/docs/pcie.txt b/docs/pcie.txt
> >>>> index 5bada24..338b50e 100644
> >>>> --- a/docs/pcie.txt
> >>>> +++ b/docs/pcie.txt
> >>>> @@ -46,7 +46,7 @@ Place only the following kinds of devices directly on the Root Complex:
> >>>>      (2) PCI Express Root Ports (ioh3420), for starting exclusively PCI Express
> >>>>          hierarchies.
> >>>>
> >>>> -    (3) DMI-PCI Bridges (i82801b11-bridge), for starting legacy PCI
> >>>> +    (3) PCIE-PCI Bridge (pcie-pci-bridge), for starting legacy PCI
> >>>>          hierarchies.
> >>>>
> >>>>      (4) Extra Root Complexes (pxb-pcie), if multiple PCI Express Root Buses
> >>>
> >>> When reviewing previous patches modifying / adding this file, I
> >>> requested that we spell out "PCI Express" every single time. I'd like to
> >>> see the same in this patch, if possible.
> >>
> >> OK, I didn't know it.
> >>
> >>>
> >>>> @@ -55,18 +55,18 @@ Place only the following kinds of devices directly on the Root Complex:
> >>>>     pcie.0 bus
> >>>>     ----------------------------------------------------------------------------
> >>>>          |                |                    |                  |
> >>>> -   -----------   ------------------   ------------------   --------------
> >>>> -   | PCI Dev |   | PCIe Root Port |   | DMI-PCI Bridge |   |  pxb-pcie  |
> >>>> -   -----------   ------------------   ------------------   --------------
> >>>> +   -----------   ------------------   -------------------   --------------
> >>>> +   | PCI Dev |   | PCIe Root Port |   | PCIE-PCI Bridge |   |  pxb-pcie  |
> >>>> +   -----------   ------------------   -------------------   --------------
> >>>>
> >>>>  2.1.1 To plug a device into pcie.0 as a Root Complex Integrated Endpoint use:
> >>>>            -device <dev>[,bus=pcie.0]
> >>>>  2.1.2 To expose a new PCI Express Root Bus use:
> >>>>            -device pxb-pcie,id=pcie.1,bus_nr=x[,numa_node=y][,addr=z]
> >>>> -      Only PCI Express Root Ports and DMI-PCI bridges can be connected
> >>>> +      Only PCI Express Root Ports, PCIE-PCI bridges and DMI-PCI bridges can be connected
> >>>
> >>> It would be nice if we could keep the flowing text wrapped to 80 chars.
> >>>
> >>> Also, here you add the "PCI Express-PCI" bridge to the list of allowed
> >>> controllers (and you keep DMI-PCI as permitted), but above DMI was
> >>> replaced. I think these should be made consistent -- we should make up
> >>> our minds if we continue to recommend the DMI-PCI bridge or not. If not,
> >>> then we should eradicate all traces of it. If we want to keep it at
> >>> least for compatibility, then it should remain as fully documented as it
> >>> is now.
> >>
> >> Now I'm beginning to think that we shouldn't keep the DMI-PCI bridge
> >> even for compatibility and may want to use a new PCIE-PCI bridge
> >> everywhere (of course, except some cases when users are
> >> sure they need exactly DMI-PCI bridge for some reason)
> > 
> > Can dmi-pci support shpc? why doesn't it? For compatibility?
> 
> I don't know why, but the fact that it doesn't is the reason libvirt
> settled on auto-creating a dmi-pci bridge and a pci-pci bridge under
> that for Q35. The reasoning was (IIRC Laine's words correctly) that the
> dmi-pci bridge cannot receive hotplugged devices, while the pci-pci
> bridge cannot be connected to the root complex. So both were needed.
> 
> Thanks
> Laszlo

OK. Is it true that dmi-pci + pci-pci under it will allow hotplug
on Q35 if we just flip the bit in _OSC?
