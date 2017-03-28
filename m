Received: from eggs.gnu.org ([2001:4830:134:3::10]:44834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csn4s-0007Pu-2Y
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csn4n-0003wL-69
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:06:10 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 28 Mar 2017 20:05:27 +1100
Message-Id: <20170328090530.20052-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 0/3] vfio-pci,
 spapr: Allow in-kernel acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

This is my current working tree to support kernel's
"powerpc/kvm/vfio: Enable in-kernel acceleration".

Please comment. Thanks.



Alexey Kardashevskiy (3):
  memory: Add get_fd() hook for IOMMU MR
  vfio-pci: Reorder group-to-container attaching
  vfio: Enable in-kernel acceleration via VFIO KVM device

 include/exec/memory.h         |  2 ++
 include/hw/vfio/vfio-common.h |  1 +
 target/ppc/kvm_ppc.h          |  6 ++++++
 hw/ppc/spapr_iommu.c          | 12 ++++++++++++
 hw/vfio/common.c              | 34 ++++++++++++++++++++++++----------
 hw/vfio/spapr.c               | 26 ++++++++++++++++++++++++++
 target/ppc/kvm.c              |  7 ++++++-
 hw/vfio/trace-events          |  1 +
 8 files changed, 78 insertions(+), 11 deletions(-)

-- 
2.11.0
