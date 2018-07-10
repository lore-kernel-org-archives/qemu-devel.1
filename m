Received: from eggs.gnu.org ([2001:4830:134:3::10]:56410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fctde-00057k-DT
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fctdb-0002Nt-8l
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:29:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fctda-0002N2-W5
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:29:07 -0400
Date: Tue, 10 Jul 2018 09:28:57 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20180710142857.GA17258@troi>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180710050913-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710050913-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Use of unique identifier for
 pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 2018-07-10 05:11:18 +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 29, 2018 at 05:19:03PM -0500, Venu Busireddy wrote:
> > The current patch set includes all the feedback received for proposals [3]
> > and [4]. For the sake of completeness, patch for the virtio specification
> > is also included here. Following is the updated proposal.
> > 
> > 1. Extend the virtio specification to include a new virtio PCI capability
> >    "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> 
> ....
> 
> >  default-configs/arm-softmmu.mak             |   1 +
> >  default-configs/i386-softmmu.mak            |   1 +
> >  default-configs/x86_64-softmmu.mak          |   1 +
> >  hw/pci-bridge/Makefile.objs                 |   1 +
> >  hw/pci-bridge/pci_bridge_dev.c              |  10 +
> >  hw/pci-bridge/pcie_downstream.c             | 220 ++++++++++++++++++++
> >  hw/pci-bridge/pcie_downstream.h             |  10 +
> >  hw/pci/pci_bridge.c                         |  34 +++
> >  hw/virtio/virtio-pci.c                      |  15 ++
> >  hw/virtio/virtio-pci.h                      |   3 +-
> >  include/hw/pci/pci.h                        |  37 ++--
> >  include/hw/pci/pci_bridge.h                 |   2 +
> >  include/hw/pci/pcie.h                       |   1 +
> >  include/standard-headers/linux/virtio_pci.h |   8 +
> >  14 files changed, 326 insertions(+), 18 deletions(-)
> >  create mode 100644 hw/pci-bridge/pcie_downstream.c
> >  create mode 100644 hw/pci-bridge/pcie_downstream.h
> 
> I don't see the spec patch here.

Since the spec patch is in a different repo, I could not get 'git
format-patch' to combine them together. As a result, I added the spec
patch itself to the patches, but it is not in the cover letter.

I can combine them manually, and repost. Do you want me do that? 

Thanks,

Venu
