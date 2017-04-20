Received: from eggs.gnu.org ([2001:4830:134:3::10]:46958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H6s-0001Lz-CI
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H6o-0004LZ-HL
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H6o-0004LM-BM
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:47:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:46:50 -0300
Message-Id: <20170420184705.25018-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] Machine queue for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>

This includes a few IOMMU fixes because Michael is away this
week.

The following changes since commit da92ada855036c55bd08b0b0c64c7551d56f35=
86:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
70420' into staging (2017-04-20 17:41:34 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-pull-request

for you to fetch changes up to be9721f400f7e5395bb2a257c291557df8f3f833:

  qdev: Constify local variable returned by blk_bs (2017-04-20 15:22:41 -=
0300)

----------------------------------------------------------------
Machine queue for 2.10

----------------------------------------------------------------

Eduardo Habkost (1):
  qdev: Make "hotplugged" property read-only

Jason Wang (1):
  intel_iommu: use the correct memory region for device IOTLB
    notification

Krzysztof Kozlowski (2):
  qdev: Constify value passed to qdev_prop_set_macaddr
  qdev: Constify local variable returned by blk_bs

Peter Xu (10):
  memory: add section range info for IOMMU notifier
  memory: provide IOMMU_NOTIFIER_FOREACH macro
  memory: provide iommu_replay_all()
  memory: introduce memory_region_notify_one()
  memory: add MemoryRegionIOMMUOps.replay() callback
  intel_iommu: provide its own replay() callback
  intel_iommu: allow dynamic switch of IOMMU region
  intel_iommu: enable remote IOTLB
  hostmem: introduce host_memory_backend_mr_inited()
  hostmem: use host_memory_backend_mr_inited() where proper

Thomas Huth (1):
  hw/core/null-machine: Print error message when using the -kernel
    parameter

 hw/i386/intel_iommu_internal.h   |   1 +
 include/exec/memory.h            |  49 ++++-
 include/hw/i386/intel_iommu.h    |  10 +
 include/hw/qdev-properties.h     |   3 +-
 include/sysemu/hostmem.h         |   1 +
 backends/hostmem-file.c          |   6 +-
 backends/hostmem.c               |  19 +-
 hw/core/null-machine.c           |   6 +
 hw/core/qdev-properties-system.c |   2 +-
 hw/core/qdev-properties.c        |   3 +-
 hw/core/qdev.c                   |   9 +-
 hw/i386/intel_iommu.c            | 442 +++++++++++++++++++++++++++++++++=
++++--
 hw/vfio/common.c                 |  12 +-
 hw/virtio/vhost.c                |  13 +-
 memory.c                         |  52 ++++-
 hw/i386/trace-events             |  10 +-
 16 files changed, 584 insertions(+), 54 deletions(-)

--=20
2.11.0.259.g40922b1
