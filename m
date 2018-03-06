Received: from eggs.gnu.org ([2001:4830:134:3::10]:60641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et9GD-0000Ai-KA
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et9GC-00052C-HB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:51:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et9GC-00051g-Bd
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:51:52 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 10:51:32 +0100
Message-Id: <20180306095135.21285-7-kraxel@redhat.com>
In-Reply-To: <20180306095135.21285-1-kraxel@redhat.com>
References: <20180306095135.21285-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v7 6/9] vfio/common: cleanup in
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
Cc: intel-gvt-dev@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>

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
