Received: from eggs.gnu.org ([2001:4830:134:3::10]:59269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8OK-0008Uw-Qx
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8OH-000648-MO
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dF8OH-000644-DG
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:33 -0400
Date: Mon, 29 May 2017 03:18:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/13] pci, virtio, vhost: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 811bf15114bff4d46735acedbd72b906616ce365:

  acpi-test: update expected files (2017-05-29 03:07:57 +0300)

----------------------------------------------------------------
pci, virtio, vhost: fixes

A bunch of fixes all over the place. Most notably this fixes
the new MTU feature when using vhost.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ladi Prosek (1):
      pc: ACPI BIOS: use highest NUMA node for hotplug mem hole SRAT entry

Maxime Coquelin (2):
      virtio_net: Bypass backends for MTU feature negotiation
      vhost-user: pass message as a pointer to process_message_reply()

Michael S. Tsirkin (1):
      acpi-test: update expected files

Peter Xu (9):
      memory: tune last param of iommu_ops.translate()
      memory: remove the last param in memory_region_iommu_replay()
      x86-iommu: use DeviceClass properties
      intel_iommu: renaming context entry helpers
      intel_iommu: provide vtd_ce_get_type()
      intel_iommu: use IOMMU_ACCESS_FLAG()
      intel_iommu: allow dev-iotlb context entry conditionally
      intel_iommu: support passthrough (PT)
      intel_iommu: turn off pt before 2.9

 hw/i386/intel_iommu_internal.h      |   1 +
 include/exec/memory.h               |  15 +-
 include/hw/compat.h                 |   8 +
 include/hw/i386/x86-iommu.h         |   1 +
 include/hw/virtio/virtio-net.h      |   1 +
 include/hw/virtio/virtio.h          |   1 +
 exec.c                              |   3 +-
 hw/alpha/typhoon.c                  |   2 +-
 hw/dma/rc4030.c                     |   2 +-
 hw/i386/acpi-build.c                |   7 +-
 hw/i386/amd_iommu.c                 |   4 +-
 hw/i386/intel_iommu.c               | 313 ++++++++++++++++++++++++++----------
 hw/i386/x86-iommu.c                 |  48 +-----
 hw/net/virtio-net.c                 |  17 +-
 hw/pci-host/apb.c                   |   2 +-
 hw/ppc/spapr_iommu.c                |   2 +-
 hw/s390x/s390-pci-bus.c             |   2 +-
 hw/s390x/s390-pci-inst.c            |   2 +-
 hw/vfio/common.c                    |   2 +-
 hw/virtio/vhost-user.c              |  12 +-
 memory.c                            |   7 +-
 hw/i386/trace-events                |   2 +
 tests/acpi-test-data/pc/SRAT.memhp  | Bin 264 -> 264 bytes
 tests/acpi-test-data/q35/SRAT.memhp | Bin 264 -> 264 bytes
 24 files changed, 299 insertions(+), 155 deletions(-)
