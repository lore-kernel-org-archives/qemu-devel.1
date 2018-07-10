Received: from eggs.gnu.org ([2001:4830:134:3::10]:56569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fci7g-0006ky-Op
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fci7d-0004tg-K0
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:11:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fci7d-0004t0-Di
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:11:21 -0400
Date: Tue, 10 Jul 2018 05:11:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710050913-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629221907.3662-1-venu.busireddy@oracle.com>
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

On Fri, Jun 29, 2018 at 05:19:03PM -0500, Venu Busireddy wrote:
> The current patch set includes all the feedback received for proposals [3]
> and [4]. For the sake of completeness, patch for the virtio specification
> is also included here. Following is the updated proposal.
> 
> 1. Extend the virtio specification to include a new virtio PCI capability
>    "VIRTIO_PCI_CAP_GROUP_ID_CFG".

....

>  default-configs/arm-softmmu.mak             |   1 +
>  default-configs/i386-softmmu.mak            |   1 +
>  default-configs/x86_64-softmmu.mak          |   1 +
>  hw/pci-bridge/Makefile.objs                 |   1 +
>  hw/pci-bridge/pci_bridge_dev.c              |  10 +
>  hw/pci-bridge/pcie_downstream.c             | 220 ++++++++++++++++++++
>  hw/pci-bridge/pcie_downstream.h             |  10 +
>  hw/pci/pci_bridge.c                         |  34 +++
>  hw/virtio/virtio-pci.c                      |  15 ++
>  hw/virtio/virtio-pci.h                      |   3 +-
>  include/hw/pci/pci.h                        |  37 ++--
>  include/hw/pci/pci_bridge.h                 |   2 +
>  include/hw/pci/pcie.h                       |   1 +
>  include/standard-headers/linux/virtio_pci.h |   8 +
>  14 files changed, 326 insertions(+), 18 deletions(-)
>  create mode 100644 hw/pci-bridge/pcie_downstream.c
>  create mode 100644 hw/pci-bridge/pcie_downstream.h

I don't see the spec patch here.

-- 
MST
