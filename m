Received: from eggs.gnu.org ([2001:4830:134:3::10]:33707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxYfY-0007wC-V1
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxYfS-0005I5-Uy
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxYfS-0005HY-Hz
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:15:54 -0400
Date: Thu, 28 Sep 2017 10:15:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170928131531.GQ4115@localhost.localdomain>
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<560aa8ff-c87d-78a3-9d94-b32df6b27834@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560aa8ff-c87d-78a3-9d94-b32df6b27834@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Mark conventional/PCIe/hybrid PCI
 devices using interface names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Sep 28, 2017 at 12:39:23PM +0300, Marcel Apfelbaum wrote:
> On 27/09/2017 22:56, Eduardo Habkost wrote:
> > Changes v1 -> v2:
> > * Use "Conventional PCI" instead of "legacy PCI"
> >    * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > * Mark base-xhci as hybrid too
> >    * Reported-by: Marcel Apfelbaum <marcel@redhat.com>
> > * Mark pcie-pci-bridge as PCI Express only
> > * New Conventional PCI devices: sungem, sunhme
> > 
> > v1 was a reimplementation of one portion of an old RFC:
> >    Subject: [RFC v2 00/20] qmp: Report bus information on
> >             'query-machines'
> > 
> > This series marks each PCI device type as Conventional PCI, PCI
> > Express, or "hybrid".  It uses two new QOM interface names to do
> > that: INTERFACE_CONVENTIONAL_PCI_DEVICE
> > ("conventional-pci-device") and INTERFACE_PCIE_DEVICE
> > ("pci-express-device").  Conventional PCI devices will implement
> > only the former; PCIe-only devices will implement only the
> > latter; hybrid devices will implement both interfaces.
> > 
> > With this, management software will then be able to use
> > qom-list-types to find out which PCI devices are
> > conventional/express/hybrid.
> > 
> > In the future, the new interface names can be used in the
> > bus/slot querying commands, to indicate which types of devices
> > are accepted on each slot.
> > 
> > The last patch in the series adds an assertion to the PCI device
> > class code, to ensure we won't forget to add the corresponding
> > interface names to new PCI device classes.
> > 
> 
> Hi Eduardo,
> 
> Now we need to get rid of the "is_express" field,
> otherwise we have the same information on two places.

Agreed, it's on my TODO-list.  is_express is completely
inconsistent on hybrid devices (some of them have is_express=0,
some of them have is_express=1).

-- 
Eduardo
