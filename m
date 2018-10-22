Received: from eggs.gnu.org ([2001:4830:134:3::10]:48516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gEV9R-0006Uy-Rt
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gEV9J-0007aV-PN
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:01:25 -0400
Received: from synology.com ([59.124.61.242]:37690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuchenlin@synology.com>)
	id 1gEV98-0007Ta-OO
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:01:09 -0400
From: yuchenlin@synology.com
Date: Mon, 22 Oct 2018 16:00:53 +0800
Message-Id: <20181022080053.9379-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH] vga_int: remove unused function protype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

Signed-off-by: yuchenlin <yuchenlin@synology.com>
---
 hw/display/vga_int.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 6e4fa48a79..55c418eab5 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -166,7 +166,6 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
                           const MemoryRegionPortio **vbe_ports);
 void vga_common_reset(VGACommonState *s);
 
-void vga_sync_dirty_bitmap(VGACommonState *s);
 void vga_dirty_log_start(VGACommonState *s);
 void vga_dirty_log_stop(VGACommonState *s);
 
-- 
2.18.0
