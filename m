Received: from eggs.gnu.org ([2001:4830:134:3::10]:41178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGhSe-0003DV-0W
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGhSZ-0005v5-Vr
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGhSZ-0005ur-Qr
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:11 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 13 Dec 2016 15:25:01 +0800
Message-Id: <1481613903-17467-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v2 0/2] VT-d supports 48 bits address
 width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, famz@redhat.com, mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, peterx@redhat.com

(V2 is mostly a re-written of V1, so no change log is appended)

The first patch did some check to make sure the CE GAW bits are always
valid.

The second patch extended VT-d GAW (Guest Address Width) from 39 bits
to 48 bits by providing "aw-bits" parameter for intel-iommu.

Test done:

- boot vm without "aw-bits" or "aw-bits=39": guest boots with 39 bits
- boot vm with "aw-bits=48": guest boots with 48 bits
- boot vm with illegal aw-bits: guest refuses to boot

Please review. Thanks,

Peter Xu (2):
  intel_iommu: check validity for GAW bits in CE
  intel_iommu: provide "aw-bits" parameter

 hw/i386/acpi-build.c           |  8 +++++++-
 hw/i386/intel_iommu.c          | 38 ++++++++++++++++++++++++++++++++------
 hw/i386/intel_iommu_internal.h | 13 ++++++-------
 include/hw/i386/intel_iommu.h  |  1 +
 4 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.7.4
