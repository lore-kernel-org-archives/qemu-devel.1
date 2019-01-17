Received: from eggs.gnu.org ([209.51.188.92]:43282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjxwx-00088i-JF
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjxm9-0004Xn-Kf
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:51:26 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 17 Jan 2019 13:51:12 +1100
Message-Id: <20190117025115.81178-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 0/3] spapr_pci,
 vfio: NVIDIA V100 + P9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>


This is for passing through NVIDIA V100 GPUs on POWER9 systems.

This implements a subdriver for NVIDIA V100 GPU with coherent memory and
NPU/ATS support available in the POWER9 CPU.

1/3 is not strictly related but since new memory also needs to be mapped
to the 64bit DMA window and it is located quite high in the address space,
some adjustments are needed.


This is based on dwg/ppc-for-4.0 sha1 a0a8bff and requires headers update
from v5.0-rc1 staged by Paolo already.

Please comment. Thanks.



Alexey Kardashevskiy (3):
  vfio/spapr: Fix indirect levels calculation
  vfio: Make vfio_get_region_info_cap public
  spapr: Support NVIDIA V100 GPU with NVLink2

 hw/vfio/pci.h                 |   2 +
 include/hw/pci-host/spapr.h   |   9 +
 include/hw/ppc/spapr.h        |   3 +-
 include/hw/vfio/vfio-common.h |   2 +
 hw/ppc/spapr.c                |  25 ++-
 hw/ppc/spapr_pci.c            | 333 +++++++++++++++++++++++++++++++++-
 hw/vfio/common.c              |   2 +-
 hw/vfio/pci-quirks.c          | 120 ++++++++++++
 hw/vfio/pci.c                 |  14 ++
 hw/vfio/spapr.c               |  38 +++-
 hw/vfio/trace-events          |   6 +-
 11 files changed, 539 insertions(+), 15 deletions(-)

-- 
2.17.1
