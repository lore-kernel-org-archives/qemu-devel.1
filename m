Received: from eggs.gnu.org ([2001:4830:134:3::10]:35363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilwi-0000tL-5o
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilwf-0003cX-4V
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:56:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eilwe-0003bm-TY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:56:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 212682821A
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 18:56:48 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 05 Feb 2018 11:56:47 -0700
Message-ID: <20180205185416.14391.5739.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 00/11] VFIO updates 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-request' into staging (2018-02-02 18:54:11 +0000)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180205.0

for you to fetch changes up to 98cc546baeedd43373ecd44c2392bbe9f0bc484c:

  vfio/pci: Add option to disable GeForce quirks (2018-02-05 11:27:15 -0700)

----------------------------------------------------------------
VFIO updates 2018-02-05

 - SPAPR in-kernel TCE accleration (Alexey Kardashevskiy)

 - MSI-X relocation (Alex Williamson)

 - Add missing platform mutex init (Eric Auger)

 - Redundant variable cleanup (Alexey Kardashevskiy)

 - Option to disable GeForce quirks (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (6):
      vfio/pci: Fixup VFIOMSIXInfo comment
      vfio/pci: Add base BAR MemoryRegion
      vfio/pci: Emulate BARs
      qapi: Create DEFINE_PROP_OFF_AUTO_PCIBAR
      vfio/pci: Allow relocating MSI-X MMIO
      vfio/pci: Add option to disable GeForce quirks

Alexey Kardashevskiy (4):
      memory/iommu: Add get_attr()
      vfio/spapr: Use iommu memory region's get_attr()
      spapr/iommu: Enable in-kernel TCE acceleration via VFIO KVM device
      vfio/common: Remove redundant copy of local variable

Eric Auger (1):
      hw/vfio/platform: Init the interrupt mutex

 hw/core/qdev-properties.c    |  11 +++
 hw/ppc/spapr_iommu.c         |  19 +++++
 hw/vfio/common.c             |  28 ++++++-
 hw/vfio/pci-quirks.c         |   9 +-
 hw/vfio/pci.c                | 195 +++++++++++++++++++++++++++++++++++++------
 hw/vfio/pci.h                |   7 +-
 hw/vfio/platform.c           |   2 +
 hw/vfio/trace-events         |   3 +
 include/exec/memory.h        |  22 +++++
 include/hw/qdev-properties.h |   4 +
 memory.c                     |  13 +++
 qapi/common.json             |  26 ++++++
 target/ppc/kvm.c             |   7 +-
 target/ppc/kvm_ppc.h         |   6 ++
 14 files changed, 321 insertions(+), 31 deletions(-)
