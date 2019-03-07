Received: from eggs.gnu.org ([209.51.188.92]:40555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1h1lEH-0007LW-DV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 00:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1h1lEF-0005Gf-Dd
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 00:06:01 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  7 Mar 2019 16:05:15 +1100
Message-Id: <20190307050518.64968-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 0/3] spapr_pci,
 vfio: NVIDIA V100 + POWER9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Gavin Shan <gwshan@linux.vnet.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>

This is for passing through NVIDIA V100 GPUs on POWER9 systems.

This implements a subdriver for NVIDIA V100 GPU with coherent memory and
NPU/ATS support available in the POWER9 CPU.

Here is the kernel driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci?h=v5.0-rc6&id=7f92891778dff62303c070ac81de7b7d80de331a


This is based on David's ppc-for-4.0 sha1
28aa643760dd Suraj Jitindar Singh "target/ppc/spapr: Clear partition table entry when allocating hash table".

Please comment. Thanks.



Alexey Kardashevskiy (3):
  spapr_iommu: Do not replay mappings from just created DMA window
  vfio: Make vfio_get_region_info_cap public
  spapr: Support NVIDIA V100 GPU with NVLink2

 hw/ppc/Makefile.objs          |   2 +-
 hw/vfio/pci.h                 |   2 +
 include/hw/pci-host/spapr.h   |  45 ++++
 include/hw/ppc/spapr.h        |   4 +-
 include/hw/vfio/vfio-common.h |   2 +
 hw/ppc/spapr.c                |  29 ++-
 hw/ppc/spapr_iommu.c          |  31 +++
 hw/ppc/spapr_pci.c            |  19 ++
 hw/ppc/spapr_pci_nvlink2.c    | 441 ++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas_ddw.c       |  10 +
 hw/vfio/common.c              |   2 +-
 hw/vfio/pci-quirks.c          | 120 +++++++++
 hw/vfio/pci.c                 |  14 ++
 hw/vfio/trace-events          |   4 +
 14 files changed, 719 insertions(+), 6 deletions(-)
 create mode 100644 hw/ppc/spapr_pci_nvlink2.c

-- 
2.17.1
