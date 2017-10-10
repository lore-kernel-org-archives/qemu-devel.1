Received: from eggs.gnu.org ([2001:4830:134:3::10]:44741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1vHo-0007ng-PE
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1vHj-0001e5-Vf
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1vHj-0001dA-PF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:27 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 16:13:23 +0200
Message-Id: <20171010141323.14049-4-kraxel@redhat.com>
In-Reply-To: <20171010141323.14049-1-kraxel@redhat.com>
References: <20171010141323.14049-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] vga: add ram_addr_t cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: d@vidbuchanan.co.uk, Gerd Hoffmann <kraxel@redhat.com>

Reported by Coverity.

Fixes: CID 1381409
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 1afceb6f16..1d19f6bc48 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1485,7 +1485,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     disp_width = width;
 
     region_start = (s->start_addr * 4);
-    region_end = region_start + s->line_offset * height;
+    region_end = region_start + (ram_addr_t)s->line_offset * height;
     if (region_end > s->vbe_size) {
         /* wraps around (can happen with cirrus vbe modes) */
         region_start = 0;
-- 
2.9.3
