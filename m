Received: from eggs.gnu.org ([2001:4830:134:3::10]:35602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzz42-0002pt-0z
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dzz3y-0006Ts-VZ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 01:51:18 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  5 Oct 2017 16:50:35 +1100
Message-Id: <20171005055037.7767-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 0/2] vfio-pci,
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is my current working tree to support kernel's
"powerpc/kvm/vfio: Enable in-kernel acceleration".

Changes:
v5:
* changed IOMMU MR callbacks and reworked the whole thing as
David suggested

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
e040047a4d Greg Kurz "spapr: sanity check size of the CAS buffer".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  memory/iommu/vfio: Define add_vfio_group() callback
  spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device

 include/exec/memory.h |  4 ++++
 target/ppc/kvm_ppc.h  |  6 ++++++
 hw/ppc/spapr_iommu.c  | 34 ++++++++++++++++++++++++++++++++++
 hw/vfio/common.c      | 15 +++++++++++++++
 target/ppc/kvm.c      |  7 ++++++-
 hw/ppc/trace-events   |  1 +
 6 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.11.0
