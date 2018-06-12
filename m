Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fSeM5-0007CV-Uk
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fSeM5-0003gH-07
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:08:41 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 12 Jun 2018 10:08:24 +0200
Message-Id: <1528790908-23441-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] ARM SMMUv3: IOTLB Emulation and VHOST
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, jia.he@hxt-semitech.com, hejianet@gmail.com

This series brings translation configuration caching and IOTLB
emulation.  The last patch implements VHOST integration and
allows to run VSMMUv3 along with VHOST emulated end points.

The first patch fixes the passthrough mode bug reported by Jia.
It reworks the translate function and this series needed to be
rebased on it.

Best Regards

Eric

This series can be found at:
v1: https://github.com/eauger/qemu/tree/v2.12.0-vsmmu-optim-v2
Previous version at:
v1: https://github.com/eauger/qemu/tree/v2.12.0-vsmmu-optim-v1

History:
v1 -> v2:
- addition of the 1st patch (including addr_mask fix)
- addition of the per device mutex as on intel iommu

v1: [1] v12 last 3 patches resent in this series
[1] [PATCH v12 00/17] ARM SMMUv3 Emulation Support
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04344.html


Eric Auger (3):
  hw/arm/smmuv3: Cache/invalidate config data
  hw/arm/smmuv3: IOTLB emulation
  hw/arm/smmuv3: Add notifications on invalidation

Jia He (1):
  hw/arm/smmuv3: Fix translate error handling

 hw/arm/smmu-common.c         | 118 +++++++++++-
 hw/arm/smmuv3-internal.h     |  12 +-
 hw/arm/smmuv3.c              | 420 +++++++++++++++++++++++++++++++++++++++----
 hw/arm/trace-events          |  27 ++-
 include/hw/arm/smmu-common.h |  24 +++
 include/hw/arm/smmuv3.h      |   1 +
 6 files changed, 558 insertions(+), 44 deletions(-)

-- 
2.5.5
