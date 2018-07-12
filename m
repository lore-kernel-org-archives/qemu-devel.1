Received: from eggs.gnu.org ([2001:4830:134:3::10]:40089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fdiiF-0000mH-8R
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 17:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fdiiA-0006Do-3l
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 17:01:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fdii9-0006DU-VG
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 17:01:14 -0400
Date: Fri, 13 Jul 2018 00:01:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180713000054-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180710050913-mutt-send-email-mst@kernel.org>
	<20180710142857.GA17258@troi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710142857.GA17258@troi>
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
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Tue, Jul 10, 2018 at 09:28:57AM -0500, Venu Busireddy wrote:
> On 2018-07-10 05:11:18 +0300, Michael S. Tsirkin wrote:
> > On Fri, Jun 29, 2018 at 05:19:03PM -0500, Venu Busireddy wrote:
> > > The current patch set includes all the feedback received for proposals [3]
> > > and [4]. For the sake of completeness, patch for the virtio specification
> > > is also included here. Following is the updated proposal.
> > > 
> > > 1. Extend the virtio specification to include a new virtio PCI capability
> > >    "VIRTIO_PCI_CAP_GROUP_ID_CFG".
> > 
> > ....
> > 
> > >  default-configs/arm-softmmu.mak             |   1 +
> > >  default-configs/i386-softmmu.mak            |   1 +
> > >  default-configs/x86_64-softmmu.mak          |   1 +
> > >  hw/pci-bridge/Makefile.objs                 |   1 +
> > >  hw/pci-bridge/pci_bridge_dev.c              |  10 +
> > >  hw/pci-bridge/pcie_downstream.c             | 220 ++++++++++++++++++++
> > >  hw/pci-bridge/pcie_downstream.h             |  10 +
> > >  hw/pci/pci_bridge.c                         |  34 +++
> > >  hw/virtio/virtio-pci.c                      |  15 ++
> > >  hw/virtio/virtio-pci.h                      |   3 +-
> > >  include/hw/pci/pci.h                        |  37 ++--
> > >  include/hw/pci/pci_bridge.h                 |   2 +
> > >  include/hw/pci/pcie.h                       |   1 +
> > >  include/standard-headers/linux/virtio_pci.h |   8 +
> > >  14 files changed, 326 insertions(+), 18 deletions(-)
> > >  create mode 100644 hw/pci-bridge/pcie_downstream.c
> > >  create mode 100644 hw/pci-bridge/pcie_downstream.h
> > 
> > I don't see the spec patch here.
> 
> Since the spec patch is in a different repo, I could not get 'git
> format-patch' to combine them together. As a result, I added the spec
> patch itself to the patches, but it is not in the cover letter.
> 
> I can combine them manually, and repost. Do you want me do that? 
> 
> Thanks,
> 
> Venu

It's ok, I found it now.

-- 
MST
