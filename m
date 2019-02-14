Received: from eggs.gnu.org ([209.51.188.92]:55343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gu9T6-0007GX-Qz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gu9T5-0005mT-VX
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:21:52 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 14 Feb 2019 16:21:40 +1100
Message-Id: <20190214052144.59541-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 0/4] spapr_pci,
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>

This is for passing through NVIDIA V100 GPUs on POWER9 systems.

This implements a subdriver for NVIDIA V100 GPU with coherent memory and
NPU/ATS support available in the POWER9 CPU.

1/4 is a preparation for bigger DMA windows.
2/4 is a small cleanup.

Here is the kernel driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci?h=v5.0-rc6&id=7f92891778dff62303c070ac81de7b7d80de331a

SLOF changes already went in.

This depends on "pci: Move NVIDIA vendor id to the rest of ids" (posted separately).

This is based on sha1
1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to sungem for mac99 machine".

Please comment. Thanks.



Alexey Kardashevskiy (4):
  vfio/spapr: Fix indirect levels calculation
  vfio/spapr: Rename local systempagesize variable
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
 hw/vfio/spapr.c               |  47 +++--
 hw/vfio/trace-events          |   6 +-
 11 files changed, 545 insertions(+), 18 deletions(-)

-- 
2.17.1
