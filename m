Received: from eggs.gnu.org ([2001:4830:134:3::10]:50561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1enjPd-0001ie-ST
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1enjPa-0003nD-Bu
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:15:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1enjPa-0003mj-7X
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:15:10 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 19 Feb 2018 12:14:56 +0100
Message-Id: <20180219111458.25983-6-kraxel@redhat.com>
In-Reply-To: <20180219111458.25983-1-kraxel@redhat.com>
References: <20180219111458.25983-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/7] vfio/common: cleanup in
 vfio_region_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f895e3c335..6a8203a532 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -858,6 +858,13 @@ void vfio_region_finalize(VFIORegion *region)
     g_free(region->mmaps);
 
     trace_vfio_region_finalize(region->vbasedev->name, region->nr);
+
+    region->mem = NULL;
+    region->mmaps = NULL;
+    region->nr_mmaps = 0;
+    region->size = 0;
+    region->flags = 0;
+    region->nr = 0;
 }
 
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
-- 
2.9.3
