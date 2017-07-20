Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dY5nH-0006Fc-0z
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dY5nC-0002z0-4a
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:22:43 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 20 Jul 2017 17:22:28 +1000
Message-Id: <20170720072231.35054-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 0/3] fio-pci,
 spapr: Allow in-kernel TCE ops acceleration
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

Changes:
v4:
* rebased on the latest upstream with IOMMU MR QOM and
VFIO initialization reordering

v3:
* fixed multiple architectures with respect to IOMMU MR
* removed sPAPRIOMMUMemoryRegion

v2:
* QOM'fy of IOMMUMemoryRegion
* fix comments from v1 review



This is based on sha1
6887dc6700 Peter Maydell "Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170718' into staging".

Please comment. Thanks.



Alexey Kardashevskiy (3):
  spapr_iommu: Realloc guest visible TCE table when hot(un)plugging
    vfio-pci
  vfio/spapr: Add a notifier for PPC64 HV/PR KVM about new group
    attached to LIOBN
  spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device

 include/hw/ppc/spapr.h        | 15 +++++++++++++++
 include/hw/vfio/vfio-common.h |  2 ++
 target/ppc/kvm_ppc.h          |  6 ++++++
 hw/ppc/spapr_iommu.c          | 45 +++++++++++++++++++++++++------------------
 hw/vfio/common.c              | 10 ++++++++++
 hw/vfio/spapr.c               | 39 +++++++++++++++++++++++++++++++++++++
 target/ppc/kvm.c              |  7 ++++++-
 hw/vfio/trace-events          |  1 +
 8 files changed, 105 insertions(+), 20 deletions(-)

-- 
2.11.0
