Received: from eggs.gnu.org ([2001:4830:134:3::10]:41464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3W-0005wF-7e
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVH3V-0003Vy-JK
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:53782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dVH3V-0003Sz-9q
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:47:49 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 12 Jul 2017 20:40:20 +0800
Message-Id: <1499863221-16206-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v12 7/8] mm: export symbol of next_zone and
 first_online_pgdat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
Cc: virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

This patch enables for_each_zone()/for_each_populated_zone() to be
invoked by a kernel module.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 mm/mmzone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index a51c0a6..08a2a3a 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -13,6 +13,7 @@ struct pglist_data *first_online_pgdat(void)
 {
 	return NODE_DATA(first_online_node);
 }
+EXPORT_SYMBOL_GPL(first_online_pgdat);
 
 struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
 {
@@ -41,6 +42,7 @@ struct zone *next_zone(struct zone *zone)
 	}
 	return zone;
 }
+EXPORT_SYMBOL_GPL(next_zone);
 
 static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
 {
-- 
2.7.4
