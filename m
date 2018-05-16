Received: from eggs.gnu.org ([2001:4830:134:3::10]:42539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIxOa-0002ls-4L
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIxOY-0000QI-Uw
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:27:12 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 16 May 2018 14:31:11 -0400
Message-Id: <1526495474-26394-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] ARM SMMUv3: IOTLB Emulation and VHOST
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

Those patches were previously included in [1]. Now that the
core implementation is upstream let's try to optimize it.

The first 2 patches implement configuration structure caching
and IOTLB emulation.

The last patch implements VHOST integration and allows to run
VSMMUv3 along with VHOST emulated end points.

Best Regards

Eric

[1] [PATCH v12 00/17] ARM SMMUv3 Emulation Support
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04344.html

This series can be found at:
v12: https://github.com/eauger/qemu/tree/vv2.12.0-vsmmu-optim-v1
Previous version at:
v12: https://github.com/eauger/qemu/tree/v2.12.0-SMMU-v12 ([1])

History:
v1: [1] last 3 patches resent in this series

Eric Auger (3):
  hw/arm/smmuv3: Cache/invalidate config data
  hw/arm/smmuv3: IOTLB emulation
  hw/arm/smmuv3: Add notifications on invalidation

 hw/arm/smmu-common.c         | 119 +++++++++++++++-
 hw/arm/smmuv3.c              | 330 +++++++++++++++++++++++++++++++++++++++++--
 hw/arm/trace-events          |  21 +++
 include/hw/arm/smmu-common.h |  24 ++++
 4 files changed, 480 insertions(+), 14 deletions(-)

-- 
1.8.3.1
