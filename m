Received: from eggs.gnu.org ([2001:4830:134:3::10]:53253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1egN1G-0006y9-N1
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1egN1C-0001hg-Rv
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:55:38 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 30 Jan 2018 14:55:25 +1100
Message-Id: <20180130035527.47336-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 0/2] vfio-pci: Allow mmap of MSIX BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Auger Eric <eric.auger@redhat.com>

This is to enable MSIX BAR mapping to the guest and by the same time
avoid failing on p2p DMA mappings. This attempt makes a try to
separate p2p handling from msix.


This is based on sha1
a6506a9 Suraj Jitindar Singh "target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  vfio/common: Add 'p2p' property to enable DMA mapping of MMIO regions
  RFC: vfio-pci: Allow mmap of MSIX BAR

 include/hw/vfio/vfio-common.h |  2 ++
 linux-headers/linux/vfio.h    |  5 +++
 hw/ppc/spapr.c                |  7 ++++
 hw/vfio/common.c              | 74 +++++++++++++++++++++++++++++++++++++++----
 hw/vfio/pci.c                 | 11 +++++++
 5 files changed, 92 insertions(+), 7 deletions(-)

-- 
2.11.0
