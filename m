Received: from eggs.gnu.org ([2001:4830:134:3::10]:34420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej8Ck-0003dZ-I7
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej8Cg-00036j-Jo
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:42:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ej8Cg-00036L-4P
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:42:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EBABC04AC72
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 18:42:49 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 06 Feb 2018 11:42:46 -0700
Message-ID: <20180206184101.14644.84734.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 00/11] VFIO updates 2018-02-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 20e0d439a6ded635ec89f6135c08cd5541c68962:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180204' into staging (2018-02-06 14:21:41 +0000)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180206.0

for you to fetch changes up to db32d0f43839627f54a1a7f8eee17baa770f52d2:

  vfio/pci: Add option to disable GeForce quirks (2018-02-06 11:08:27 -0700)

----------------------------------------------------------------
VFIO updates 2018-02-06

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
 hw/ppc/spapr_iommu.c         |  18 ++++
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
 14 files changed, 320 insertions(+), 31 deletions(-)
