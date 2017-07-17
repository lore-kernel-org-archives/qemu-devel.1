Received: from eggs.gnu.org ([2001:4830:134:3::10]:41642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1vK-00066g-Pw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1vK-0003PZ-3N
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:02:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1vJ-0003PL-T5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:02:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD74C5F7B0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:02:36 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 17:02:28 +0800
Message-Id: <1500282150-28190-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] VT-d: some enhancements on iotlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

v4:
- removed patch 2 (x-iotlb-size patch) and patch 4 (mru list for
  iotlb) [mst]
- used VTD_PAGE_SIZE_4K for patch 1 [Jason]

v3:
- fix issue reported by patchew on style

v2:
- rebase to master
- removed all "info iommu" patches for now
  (is it bad to introduce new HMP commands without QMP? I thought not,
   but in case I missed anything, please kindly let me know...)

Patch 1: fixes a very rare PT path issue on iova value. It didn't
break anything since it's merely not touched (only if when IOMMU
enabled, then set one device to PT), but still better fix it.

Patch 2: introduce "x-iotlb-size" to tune iotlb size, or to turn it
off (e.g., when we want to measure how iotlb affects one payload).

Patch 3: some refine on iotlb entry.

Patch 4: implemented MRU list algorithm for iotlb.

Please review. Thanks,

Peter Xu (2):
  intel_iommu: fix iova for pt
  intel_iommu: use access_flags for iotlb

 hw/i386/intel_iommu.c          | 19 +++++++++----------
 hw/i386/intel_iommu_internal.h |  1 -
 include/hw/i386/intel_iommu.h  |  3 +--
 3 files changed, 10 insertions(+), 13 deletions(-)

-- 
2.7.4
