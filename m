Received: from eggs.gnu.org ([2001:4830:134:3::10]:56158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPK-0004iO-VE
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPI-00073V-5D
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPH-00073F-R2
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:08 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:16 +0300
Message-Id: <1533815202-11967-4-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 03/29] vmsvga: Explictly mark deprecated
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>, Liran Alon <liran.alon@oracle.com>

From: Leonid Shatz <leonid.shatz@oracle.com>

These commands are neither mentioned nor documented in VMware SVGA
development-kit and Linux vmware-svga driver source code.
Thus, they should be subject to future deletion, if not encountered in practice.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 56 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f8c5b64cfd7c..a244f43a866f 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -248,33 +248,33 @@ static const char *vmsvga_guest_id[] = {
 enum {
     SVGA_CMD_INVALID_CMD = 0,
     SVGA_CMD_UPDATE = 1,
-    SVGA_CMD_RECT_FILL = 2,
+    SVGA_CMD_RECT_FILL = 2,               /* deprecated */
     SVGA_CMD_RECT_COPY = 3,
-    SVGA_CMD_DEFINE_BITMAP = 4,
-    SVGA_CMD_DEFINE_BITMAP_SCANLINE = 5,
-    SVGA_CMD_DEFINE_PIXMAP = 6,
-    SVGA_CMD_DEFINE_PIXMAP_SCANLINE = 7,
-    SVGA_CMD_RECT_BITMAP_FILL = 8,
-    SVGA_CMD_RECT_PIXMAP_FILL = 9,
-    SVGA_CMD_RECT_BITMAP_COPY = 10,
-    SVGA_CMD_RECT_PIXMAP_COPY = 11,
-    SVGA_CMD_FREE_OBJECT = 12,
-    SVGA_CMD_RECT_ROP_FILL = 13,
-    SVGA_CMD_RECT_ROP_COPY = 14,
-    SVGA_CMD_RECT_ROP_BITMAP_FILL = 15,
-    SVGA_CMD_RECT_ROP_PIXMAP_FILL = 16,
-    SVGA_CMD_RECT_ROP_BITMAP_COPY = 17,
-    SVGA_CMD_RECT_ROP_PIXMAP_COPY = 18,
+    SVGA_CMD_DEFINE_BITMAP = 4,           /* deprecated */
+    SVGA_CMD_DEFINE_BITMAP_SCANLINE = 5,  /* deprecated */
+    SVGA_CMD_DEFINE_PIXMAP = 6,           /* deprecated */
+    SVGA_CMD_DEFINE_PIXMAP_SCANLINE = 7,  /* deprecated */
+    SVGA_CMD_RECT_BITMAP_FILL = 8,        /* deprecated */
+    SVGA_CMD_RECT_PIXMAP_FILL = 9,        /* deprecated */
+    SVGA_CMD_RECT_BITMAP_COPY = 10,       /* deprecated */
+    SVGA_CMD_RECT_PIXMAP_COPY = 11,       /* deprecated */
+    SVGA_CMD_FREE_OBJECT = 12,            /* deprecated */
+    SVGA_CMD_RECT_ROP_FILL = 13,          /* deprecated */
+    SVGA_CMD_RECT_ROP_COPY = 14,          /* deprecated */
+    SVGA_CMD_RECT_ROP_BITMAP_FILL = 15,   /* deprecated */
+    SVGA_CMD_RECT_ROP_PIXMAP_FILL = 16,   /* deprecated */
+    SVGA_CMD_RECT_ROP_BITMAP_COPY = 17,   /* deprecated */
+    SVGA_CMD_RECT_ROP_PIXMAP_COPY = 18,   /* deprecated */
     SVGA_CMD_DEFINE_CURSOR = 19,
-    SVGA_CMD_DISPLAY_CURSOR = 20,
-    SVGA_CMD_MOVE_CURSOR = 21,
+    SVGA_CMD_DISPLAY_CURSOR = 20,         /* deprecated */
+    SVGA_CMD_MOVE_CURSOR = 21,            /* deprecated */
     SVGA_CMD_DEFINE_ALPHA_CURSOR = 22,
-    SVGA_CMD_DRAW_GLYPH = 23,
-    SVGA_CMD_DRAW_GLYPH_CLIPPED = 24,
+    SVGA_CMD_DRAW_GLYPH = 23,             /* deprecated */
+    SVGA_CMD_DRAW_GLYPH_CLIPPED = 24,     /* deprecated */
     SVGA_CMD_UPDATE_VERBOSE = 25,
-    SVGA_CMD_SURFACE_FILL = 26,
-    SVGA_CMD_SURFACE_COPY = 27,
-    SVGA_CMD_SURFACE_ALPHA_BLEND = 28,
+    SVGA_CMD_SURFACE_FILL = 26,           /* deprecated */
+    SVGA_CMD_SURFACE_COPY = 27,           /* deprecated */
+    SVGA_CMD_SURFACE_ALPHA_BLEND = 28,    /* deprecated */
     SVGA_CMD_FRONT_ROP_FILL = 29,
     SVGA_CMD_FENCE = 30,
 };
@@ -692,7 +692,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
          * If they are not encountered in real world scenarious, they should be
          * completely removed.
          */
-        case SVGA_CMD_RECT_FILL:
+        case SVGA_CMD_RECT_FILL: /* deprecated */
             len -= 6;
             if (len < 0) {
                 goto rewind;
@@ -715,10 +715,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
          * Unimplemented commands that we gracefully skip their
          * arguments so we can avoid FIFO desync
          */
-        case SVGA_CMD_RECT_ROP_FILL:
+        case SVGA_CMD_RECT_ROP_FILL: /* deprecated */
             args = 6;
             goto badcmd;
-        case SVGA_CMD_RECT_ROP_COPY:
+        case SVGA_CMD_RECT_ROP_COPY: /* deprecated */
             args = 7;
             goto badcmd;
         case SVGA_CMD_DEFINE_ALPHA_CURSOR:
@@ -733,7 +733,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             y = vmsvga_fifo_read(s);
             args = x * y;
             goto badcmd;
-        case SVGA_CMD_DRAW_GLYPH_CLIPPED:
+        case SVGA_CMD_DRAW_GLYPH_CLIPPED: /* deprecated */
             len -= 4;
             if (len < 0) {
                 goto rewind;
@@ -742,7 +742,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             vmsvga_fifo_read(s);
             args = 7 + (vmsvga_fifo_read(s) >> 2);
             goto badcmd;
-        case SVGA_CMD_SURFACE_ALPHA_BLEND:
+        case SVGA_CMD_SURFACE_ALPHA_BLEND: /* deprecated */
             args = 12;
             goto badcmd;
 
-- 
1.9.1
