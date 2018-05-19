Received: from eggs.gnu.org ([2001:4830:134:3::10]:53280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhenwei.pi@youruncloud.com>) id 1fJzUp-00051z-HO
	for qemu-devel@nongnu.org; Sat, 19 May 2018 06:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhenwei.pi@youruncloud.com>) id 1fJzUi-0007MX-Rh
	for qemu-devel@nongnu.org; Sat, 19 May 2018 06:53:55 -0400
Received: from mail139-36.mail.alibaba.com ([198.11.139.36]:57602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhenwei.pi@youruncloud.com>)
	id 1fJzUh-0007Gn-Ur
	for qemu-devel@nongnu.org; Sat, 19 May 2018 06:53:48 -0400
From: zhenwei pi <zhenwei.pi@youruncloud.com>
Date: Sat, 19 May 2018 18:21:52 +0800
Message-Id: <1526725312-32767-1-git-send-email-zhenwei.pi@youruncloud.com>
Subject: [Qemu-devel] [PATCH] cirrus: format code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, ehabkost@redhat.com
Cc: zhenwei.pi@youruncloud.com, qemu-devel@nongnu.org

replace tab with spaces and fix some comments

Signed-off-by: zhenwei pi <zhenwei.pi@youruncloud.com>
---
 hw/display/cirrus_vga.c | 1662 +++++++++++++++++++++++------------------------
 1 file changed, 831 insertions(+), 831 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 138ae96..6319889 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -76,12 +76,12 @@
 #define CIRRUS_MEMSIZE_512k        0x08
 #define CIRRUS_MEMSIZE_1M          0x10
 #define CIRRUS_MEMSIZE_2M          0x18
-#define CIRRUS_MEMFLAGS_BANKSWITCH 0x80	// bank switching is enabled.
+#define CIRRUS_MEMFLAGS_BANKSWITCH 0x80        // bank switching is enabled.
 
 // sequencer 0x12
 #define CIRRUS_CURSOR_SHOW         0x01
 #define CIRRUS_CURSOR_HIDDENPEL    0x02
-#define CIRRUS_CURSOR_LARGE        0x04	// 64x64 if set, 32x32 if clear
+#define CIRRUS_CURSOR_LARGE        0x04        // 64x64 if set, 32x32 if clear
 
 // sequencer 0x17
 #define CIRRUS_BUSTYPE_VLBFAST   0x10
@@ -89,12 +89,12 @@
 #define CIRRUS_BUSTYPE_VLBSLOW   0x30
 #define CIRRUS_BUSTYPE_ISA       0x38
 #define CIRRUS_MMIO_ENABLE       0x04
-#define CIRRUS_MMIO_USE_PCIADDR  0x40	// 0xb8000 if cleared.
+#define CIRRUS_MMIO_USE_PCIADDR  0x40          // 0xb8000 if cleared.
 #define CIRRUS_MEMSIZEEXT_DOUBLE 0x80
 
 // control 0x0b
 #define CIRRUS_BANKING_DUAL             0x01
-#define CIRRUS_BANKING_GRANULARITY_16K  0x20	// set:16k, clear:4k
+#define CIRRUS_BANKING_GRANULARITY_16K  0x20   // set:16k, clear:4k
 
 // control 0x30
 #define CIRRUS_BLTMODE_BACKWARDS        0x01
@@ -143,43 +143,43 @@
 #define CIRRUS_BLTMODEEXT_DWORDGRANULARITY 0x01
 
 // memory-mapped IO
-#define CIRRUS_MMIO_BLTBGCOLOR        0x00	// dword
-#define CIRRUS_MMIO_BLTFGCOLOR        0x04	// dword
-#define CIRRUS_MMIO_BLTWIDTH          0x08	// word
-#define CIRRUS_MMIO_BLTHEIGHT         0x0a	// word
-#define CIRRUS_MMIO_BLTDESTPITCH      0x0c	// word
-#define CIRRUS_MMIO_BLTSRCPITCH       0x0e	// word
-#define CIRRUS_MMIO_BLTDESTADDR       0x10	// dword
-#define CIRRUS_MMIO_BLTSRCADDR        0x14	// dword
-#define CIRRUS_MMIO_BLTWRITEMASK      0x17	// byte
-#define CIRRUS_MMIO_BLTMODE           0x18	// byte
-#define CIRRUS_MMIO_BLTROP            0x1a	// byte
-#define CIRRUS_MMIO_BLTMODEEXT        0x1b	// byte
-#define CIRRUS_MMIO_BLTTRANSPARENTCOLOR 0x1c	// word?
-#define CIRRUS_MMIO_BLTTRANSPARENTCOLORMASK 0x20	// word?
-#define CIRRUS_MMIO_LINEARDRAW_START_X 0x24	// word
-#define CIRRUS_MMIO_LINEARDRAW_START_Y 0x26	// word
-#define CIRRUS_MMIO_LINEARDRAW_END_X  0x28	// word
-#define CIRRUS_MMIO_LINEARDRAW_END_Y  0x2a	// word
-#define CIRRUS_MMIO_LINEARDRAW_LINESTYLE_INC 0x2c	// byte
-#define CIRRUS_MMIO_LINEARDRAW_LINESTYLE_ROLLOVER 0x2d	// byte
-#define CIRRUS_MMIO_LINEARDRAW_LINESTYLE_MASK 0x2e	// byte
-#define CIRRUS_MMIO_LINEARDRAW_LINESTYLE_ACCUM 0x2f	// byte
-#define CIRRUS_MMIO_BRESENHAM_K1      0x30	// word
-#define CIRRUS_MMIO_BRESENHAM_K3      0x32	// word
-#define CIRRUS_MMIO_BRESENHAM_ERROR   0x34	// word
-#define CIRRUS_MMIO_BRESENHAM_DELTA_MAJOR 0x36	// word
-#define CIRRUS_MMIO_BRESENHAM_DIRECTION 0x38	// byte
-#define CIRRUS_MMIO_LINEDRAW_MODE     0x39	// byte
-#define CIRRUS_MMIO_BLTSTATUS         0x40	// byte
+#define CIRRUS_MMIO_BLTBGCOLOR        0x00                // dword
+#define CIRRUS_MMIO_BLTFGCOLOR        0x04                // dword
+#define CIRRUS_MMIO_BLTWIDTH          0x08                // word
+#define CIRRUS_MMIO_BLTHEIGHT         0x0a                // word
+#define CIRRUS_MMIO_BLTDESTPITCH      0x0c                // word
+#define CIRRUS_MMIO_BLTSRCPITCH       0x0e                // word
+#define CIRRUS_MMIO_BLTDESTADDR       0x10                // dword
+#define CIRRUS_MMIO_BLTSRCADDR        0x14                // dword
+#define CIRRUS_MMIO_BLTWRITEMASK      0x17                // byte
+#define CIRRUS_MMIO_BLTMODE           0x18                // byte
+#define CIRRUS_MMIO_BLTROP            0x1a                // byte
+#define CIRRUS_MMIO_BLTMODEEXT        0x1b                // byte
+#define CIRRUS_MMIO_BLTTRANSPARENTCOLOR 0x1c              // word?
+#define CIRRUS_MMIO_BLTTRANSPARENTCOLORMASK 0x20          // word?
+#define CIRRUS_MMIO_LINEARDRAW_START_X 0x24               // word
+#define CIRRUS_MMIO_LINEARDRAW_START_Y 0x26               // word
+#define CIRRUS_MMIO_LINEARDRAW_END_X  0x28                // word
+#define CIRRUS_MMIO_LINEARDRAW_END_Y  0x2a                // word
+#define CIRRUS_MMIO_LINEARDRAW_LINESTYLE_INC 0x2c         // byte
+#define CIRRUS_MMIO_LINEARDRAW_LINESTYLE_ROLLOVER 0x2d    // byte
+#define CIRRUS_MMIO_LINEARDRAW_LINESTYLE_MASK 0x2e        // byte
+#define CIRRUS_MMIO_LINEARDRAW_LINESTYLE_ACCUM 0x2f       // byte
+#define CIRRUS_MMIO_BRESENHAM_K1      0x30                // word
+#define CIRRUS_MMIO_BRESENHAM_K3      0x32                // word
+#define CIRRUS_MMIO_BRESENHAM_ERROR   0x34                // word
+#define CIRRUS_MMIO_BRESENHAM_DELTA_MAJOR 0x36            // word
+#define CIRRUS_MMIO_BRESENHAM_DIRECTION 0x38              // byte
+#define CIRRUS_MMIO_LINEDRAW_MODE     0x39                // byte
+#define CIRRUS_MMIO_BLTSTATUS         0x40                // byte
 
 #define CIRRUS_PNPMMIO_SIZE         0x1000
 
 struct CirrusVGAState;
 typedef void (*cirrus_bitblt_rop_t) (struct CirrusVGAState *s,
                                      uint32_t dstaddr, uint32_t srcaddr,
-				     int dstpitch, int srcpitch,
-				     int bltwidth, int bltheight);
+                                     int dstpitch, int srcpitch,
+                                     int bltwidth, int bltheight);
 typedef void (*cirrus_fill_t)(struct CirrusVGAState *s,
                               uint32_t dstaddr, int dst_pitch,
                               int width, int height);
@@ -694,8 +694,8 @@ static inline void cirrus_bitblt_bgcol(CirrusVGAState *s)
 }
 
 static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
-				     int off_pitch, int bytesperline,
-				     int lines)
+                                     int off_pitch, int bytesperline,
+                                     int lines)
 {
     int y;
     int off_cur;
@@ -768,8 +768,8 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
              s->cirrus_blt_dstpitch,
              s->cirrus_blt_width, s->cirrus_blt_height);
     cirrus_invalidate_region(s, s->cirrus_blt_dstaddr,
-			     s->cirrus_blt_dstpitch, s->cirrus_blt_width,
-			     s->cirrus_blt_height);
+                             s->cirrus_blt_dstpitch, s->cirrus_blt_width,
+                             s->cirrus_blt_height);
     cirrus_bitblt_reset(s);
     return 1;
 }
@@ -833,8 +833,8 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
 
     (*s->cirrus_rop) (s, s->cirrus_blt_dstaddr,
                       s->cirrus_blt_srcaddr,
-		      s->cirrus_blt_dstpitch, s->cirrus_blt_srcpitch,
-		      s->cirrus_blt_width, s->cirrus_blt_height);
+                      s->cirrus_blt_dstpitch, s->cirrus_blt_srcpitch,
+                      s->cirrus_blt_width, s->cirrus_blt_height);
 
     if (notify) {
         dpy_gfx_update(s->vga.con, dx, dy,
@@ -846,8 +846,8 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
        changed since qemu_console_copy implies this */
 
     cirrus_invalidate_region(s, s->cirrus_blt_dstaddr,
-				s->cirrus_blt_dstpitch, s->cirrus_blt_width,
-				s->cirrus_blt_height);
+                                s->cirrus_blt_dstpitch, s->cirrus_blt_width,
+                                s->cirrus_blt_height);
 
     return 1;
 }
@@ -914,7 +914,7 @@ static void cirrus_bitblt_reset(CirrusVGAState * s)
     int need_update;
 
     s->vga.gr[0x31] &=
-	~(CIRRUS_BLT_START | CIRRUS_BLT_BUSY | CIRRUS_BLT_FIFOUSED);
+        ~(CIRRUS_BLT_START | CIRRUS_BLT_BUSY | CIRRUS_BLT_FIFOUSED);
     need_update = s->cirrus_srcptr != &s->cirrus_bltbuf[0]
         || s->cirrus_srcptr_end != &s->cirrus_bltbuf[0];
     s->cirrus_srcptr = &s->cirrus_bltbuf[0];
@@ -938,24 +938,24 @@ static int cirrus_bitblt_cputovideo(CirrusVGAState * s)
     s->cirrus_srcptr_end = &s->cirrus_bltbuf[0];
 
     if (s->cirrus_blt_mode & CIRRUS_BLTMODE_PATTERNCOPY) {
-	if (s->cirrus_blt_mode & CIRRUS_BLTMODE_COLOREXPAND) {
-	    s->cirrus_blt_srcpitch = 8;
-	} else {
+        if (s->cirrus_blt_mode & CIRRUS_BLTMODE_COLOREXPAND) {
+            s->cirrus_blt_srcpitch = 8;
+        } else {
             /* XXX: check for 24 bpp */
-	    s->cirrus_blt_srcpitch = 8 * 8 * s->cirrus_blt_pixelwidth;
-	}
-	s->cirrus_srccounter = s->cirrus_blt_srcpitch;
+            s->cirrus_blt_srcpitch = 8 * 8 * s->cirrus_blt_pixelwidth;
+        }
+        s->cirrus_srccounter = s->cirrus_blt_srcpitch;
     } else {
-	if (s->cirrus_blt_mode & CIRRUS_BLTMODE_COLOREXPAND) {
+        if (s->cirrus_blt_mode & CIRRUS_BLTMODE_COLOREXPAND) {
             w = s->cirrus_blt_width / s->cirrus_blt_pixelwidth;
             if (s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_DWORDGRANULARITY)
                 s->cirrus_blt_srcpitch = ((w + 31) >> 5);
             else
                 s->cirrus_blt_srcpitch = ((w + 7) >> 3);
-	} else {
+        } else {
             /* always align input size to 32 bits */
-	    s->cirrus_blt_srcpitch = (s->cirrus_blt_width + 3) & ~3;
-	}
+            s->cirrus_blt_srcpitch = (s->cirrus_blt_width + 3) & ~3;
+        }
         s->cirrus_srccounter = s->cirrus_blt_srcpitch * s->cirrus_blt_height;
     }
 
@@ -982,12 +982,12 @@ static int cirrus_bitblt_videotovideo(CirrusVGAState * s)
     int ret;
 
     if (s->cirrus_blt_mode & CIRRUS_BLTMODE_PATTERNCOPY) {
-	ret = cirrus_bitblt_videotovideo_patterncopy(s);
+        ret = cirrus_bitblt_videotovideo_patterncopy(s);
     } else {
-	ret = cirrus_bitblt_videotovideo_copy(s);
+        ret = cirrus_bitblt_videotovideo_copy(s);
     }
     if (ret)
-	cirrus_bitblt_reset(s);
+        cirrus_bitblt_reset(s);
     return ret;
 }
 
@@ -1006,9 +1006,9 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
     s->cirrus_blt_dstpitch = (s->vga.gr[0x24] | (s->vga.gr[0x25] << 8));
     s->cirrus_blt_srcpitch = (s->vga.gr[0x26] | (s->vga.gr[0x27] << 8));
     s->cirrus_blt_dstaddr =
-	(s->vga.gr[0x28] | (s->vga.gr[0x29] << 8) | (s->vga.gr[0x2a] << 16));
+        (s->vga.gr[0x28] | (s->vga.gr[0x29] << 8) | (s->vga.gr[0x2a] << 16));
     s->cirrus_blt_srcaddr =
-	(s->vga.gr[0x2c] | (s->vga.gr[0x2d] << 8) | (s->vga.gr[0x2e] << 16));
+        (s->vga.gr[0x2c] | (s->vga.gr[0x2d] << 8) | (s->vga.gr[0x2e] << 16));
     s->cirrus_blt_mode = s->vga.gr[0x30];
     s->cirrus_blt_modeext = s->vga.gr[0x33];
     blt_rop = s->vga.gr[0x32];
@@ -1032,33 +1032,33 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
 
     switch (s->cirrus_blt_mode & CIRRUS_BLTMODE_PIXELWIDTHMASK) {
     case CIRRUS_BLTMODE_PIXELWIDTH8:
-	s->cirrus_blt_pixelwidth = 1;
-	break;
+        s->cirrus_blt_pixelwidth = 1;
+        break;
     case CIRRUS_BLTMODE_PIXELWIDTH16:
-	s->cirrus_blt_pixelwidth = 2;
-	break;
+        s->cirrus_blt_pixelwidth = 2;
+        break;
     case CIRRUS_BLTMODE_PIXELWIDTH24:
-	s->cirrus_blt_pixelwidth = 3;
-	break;
+        s->cirrus_blt_pixelwidth = 3;
+        break;
     case CIRRUS_BLTMODE_PIXELWIDTH32:
-	s->cirrus_blt_pixelwidth = 4;
-	break;
+        s->cirrus_blt_pixelwidth = 4;
+        break;
     default:
 #ifdef DEBUG_BITBLT
-	printf("cirrus: bitblt - pixel width is unknown\n");
+        printf("cirrus: bitblt - pixel width is unknown\n");
 #endif
-	goto bitblt_ignore;
+        goto bitblt_ignore;
     }
     s->cirrus_blt_mode &= ~CIRRUS_BLTMODE_PIXELWIDTHMASK;
 
     if ((s->
-	 cirrus_blt_mode & (CIRRUS_BLTMODE_MEMSYSSRC |
-			    CIRRUS_BLTMODE_MEMSYSDEST))
-	== (CIRRUS_BLTMODE_MEMSYSSRC | CIRRUS_BLTMODE_MEMSYSDEST)) {
+         cirrus_blt_mode & (CIRRUS_BLTMODE_MEMSYSSRC |
+                            CIRRUS_BLTMODE_MEMSYSDEST))
+        == (CIRRUS_BLTMODE_MEMSYSSRC | CIRRUS_BLTMODE_MEMSYSDEST)) {
 #ifdef DEBUG_BITBLT
-	printf("cirrus: bitblt - memory-to-memory copy is requested\n");
+        printf("cirrus: bitblt - memory-to-memory copy is requested\n");
 #endif
-	goto bitblt_ignore;
+        goto bitblt_ignore;
     }
 
     if ((s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_SOLIDFILL) &&
@@ -1102,28 +1102,28 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
                 s->cirrus_rop = cirrus_patternfill[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
             }
         } else {
-	    if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
-		if (s->cirrus_blt_pixelwidth > 2) {
-		    printf("src transparent without colorexpand must be 8bpp or 16bpp\n");
-		    goto bitblt_ignore;
-		}
-		if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
-		    s->cirrus_blt_dstpitch = -s->cirrus_blt_dstpitch;
-		    s->cirrus_blt_srcpitch = -s->cirrus_blt_srcpitch;
-		    s->cirrus_rop = cirrus_bkwd_transp_rop[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
-		} else {
-		    s->cirrus_rop = cirrus_fwd_transp_rop[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
-		}
-	    } else {
-		if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
-		    s->cirrus_blt_dstpitch = -s->cirrus_blt_dstpitch;
-		    s->cirrus_blt_srcpitch = -s->cirrus_blt_srcpitch;
-		    s->cirrus_rop = cirrus_bkwd_rop[rop_to_index[blt_rop]];
-		} else {
-		    s->cirrus_rop = cirrus_fwd_rop[rop_to_index[blt_rop]];
-		}
-	    }
-	}
+            if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
+                if (s->cirrus_blt_pixelwidth > 2) {
+                    printf("src transparent without colorexpand must be 8bpp or 16bpp\n");
+                    goto bitblt_ignore;
+                }
+                if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
+                    s->cirrus_blt_dstpitch = -s->cirrus_blt_dstpitch;
+                    s->cirrus_blt_srcpitch = -s->cirrus_blt_srcpitch;
+                    s->cirrus_rop = cirrus_bkwd_transp_rop[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
+                } else {
+                    s->cirrus_rop = cirrus_fwd_transp_rop[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
+                }
+            } else {
+                if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
+                    s->cirrus_blt_dstpitch = -s->cirrus_blt_dstpitch;
+                    s->cirrus_blt_srcpitch = -s->cirrus_blt_srcpitch;
+                    s->cirrus_rop = cirrus_bkwd_rop[rop_to_index[blt_rop]];
+                } else {
+                    s->cirrus_rop = cirrus_fwd_rop[rop_to_index[blt_rop]];
+                }
+            }
+        }
         // setup bitblt engine.
         if (s->cirrus_blt_mode & CIRRUS_BLTMODE_MEMSYSSRC) {
             if (!cirrus_bitblt_cputovideo(s))
@@ -1149,11 +1149,11 @@ static void cirrus_write_bitblt(CirrusVGAState * s, unsigned reg_value)
     s->vga.gr[0x31] = reg_value;
 
     if (((old_value & CIRRUS_BLT_RESET) != 0) &&
-	((reg_value & CIRRUS_BLT_RESET) == 0)) {
-	cirrus_bitblt_reset(s);
+        ((reg_value & CIRRUS_BLT_RESET) == 0)) {
+        cirrus_bitblt_reset(s);
     } else if (((old_value & CIRRUS_BLT_START) == 0) &&
-	       ((reg_value & CIRRUS_BLT_START) != 0)) {
-	cirrus_bitblt_start(s);
+               ((reg_value & CIRRUS_BLT_START) != 0)) {
+        cirrus_bitblt_start(s);
     }
 }
 
@@ -1173,15 +1173,15 @@ static void cirrus_get_offsets(VGACommonState *s1,
     uint32_t start_addr, line_offset, line_compare;
 
     line_offset = s->vga.cr[0x13]
-	| ((s->vga.cr[0x1b] & 0x10) << 4);
+        | ((s->vga.cr[0x1b] & 0x10) << 4);
     line_offset <<= 3;
     *pline_offset = line_offset;
 
     start_addr = (s->vga.cr[0x0c] << 8)
-	| s->vga.cr[0x0d]
-	| ((s->vga.cr[0x1b] & 0x01) << 16)
-	| ((s->vga.cr[0x1b] & 0x0c) << 15)
-	| ((s->vga.cr[0x1d] & 0x80) << 12);
+        | s->vga.cr[0x0d]
+        | ((s->vga.cr[0x1b] & 0x01) << 16)
+        | ((s->vga.cr[0x1b] & 0x0c) << 15)
+        | ((s->vga.cr[0x1d] & 0x80) << 12);
     *pstart_addr = start_addr;
 
     line_compare = s->vga.cr[0x18] |
@@ -1196,18 +1196,18 @@ static uint32_t cirrus_get_bpp16_depth(CirrusVGAState * s)
 
     switch (s->cirrus_hidden_dac_data & 0xf) {
     case 0:
-	ret = 15;
-	break;			/* Sierra HiColor */
+        ret = 15;
+        break;                        /* Sierra HiColor */
     case 1:
-	ret = 16;
-	break;			/* XGA HiColor */
+        ret = 16;
+        break;                        /* XGA HiColor */
     default:
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: invalid DAC value %x in 16bpp\n",
-	       (s->cirrus_hidden_dac_data & 0xf));
+        printf("cirrus: invalid DAC value %x in 16bpp\n",
+               (s->cirrus_hidden_dac_data & 0xf));
 #endif
-	ret = 15;		/* XXX */
-	break;
+        ret = 15;                /* XXX */
+        break;
     }
     return ret;
 }
@@ -1218,33 +1218,33 @@ static int cirrus_get_bpp(VGACommonState *s1)
     uint32_t ret = 8;
 
     if ((s->vga.sr[0x07] & 0x01) != 0) {
-	/* Cirrus SVGA */
-	switch (s->vga.sr[0x07] & CIRRUS_SR7_BPP_MASK) {
-	case CIRRUS_SR7_BPP_8:
-	    ret = 8;
-	    break;
-	case CIRRUS_SR7_BPP_16_DOUBLEVCLK:
-	    ret = cirrus_get_bpp16_depth(s);
-	    break;
-	case CIRRUS_SR7_BPP_24:
-	    ret = 24;
-	    break;
-	case CIRRUS_SR7_BPP_16:
-	    ret = cirrus_get_bpp16_depth(s);
-	    break;
-	case CIRRUS_SR7_BPP_32:
-	    ret = 32;
-	    break;
-	default:
+        /* Cirrus SVGA */
+        switch (s->vga.sr[0x07] & CIRRUS_SR7_BPP_MASK) {
+        case CIRRUS_SR7_BPP_8:
+            ret = 8;
+            break;
+        case CIRRUS_SR7_BPP_16_DOUBLEVCLK:
+            ret = cirrus_get_bpp16_depth(s);
+            break;
+        case CIRRUS_SR7_BPP_24:
+            ret = 24;
+            break;
+        case CIRRUS_SR7_BPP_16:
+            ret = cirrus_get_bpp16_depth(s);
+            break;
+        case CIRRUS_SR7_BPP_32:
+            ret = 32;
+            break;
+        default:
 #ifdef DEBUG_CIRRUS
-	    printf("cirrus: unknown bpp - sr7=%x\n", s->vga.sr[0x7]);
+            printf("cirrus: unknown bpp - sr7=%x\n", s->vga.sr[0x7]);
 #endif
-	    ret = 8;
-	    break;
-	}
+            ret = 8;
+            break;
+        }
     } else {
-	/* VGA */
-	ret = 0;
+        /* VGA */
+        ret = 0;
     }
 
     return ret;
@@ -1277,36 +1277,36 @@ static void cirrus_update_bank_ptr(CirrusVGAState * s, unsigned bank_index)
     unsigned offset;
     unsigned limit;
 
-    if ((s->vga.gr[0x0b] & 0x01) != 0)	/* dual bank */
-	offset = s->vga.gr[0x09 + bank_index];
-    else			/* single bank */
-	offset = s->vga.gr[0x09];
+    if ((s->vga.gr[0x0b] & 0x01) != 0)        /* dual bank */
+        offset = s->vga.gr[0x09 + bank_index];
+    else                        /* single bank */
+        offset = s->vga.gr[0x09];
 
     if ((s->vga.gr[0x0b] & 0x20) != 0)
-	offset <<= 14;
+        offset <<= 14;
     else
-	offset <<= 12;
+        offset <<= 12;
 
     if (s->real_vram_size <= offset)
-	limit = 0;
+        limit = 0;
     else
-	limit = s->real_vram_size - offset;
+        limit = s->real_vram_size - offset;
 
     if (((s->vga.gr[0x0b] & 0x01) == 0) && (bank_index != 0)) {
-	if (limit > 0x8000) {
-	    offset += 0x8000;
-	    limit -= 0x8000;
-	} else {
-	    limit = 0;
-	}
+        if (limit > 0x8000) {
+            offset += 0x8000;
+            limit -= 0x8000;
+        } else {
+            limit = 0;
+        }
     }
 
     if (limit > 0) {
-	s->cirrus_bank_base[bank_index] = offset;
-	s->cirrus_bank_limit[bank_index] = limit;
+        s->cirrus_bank_base[bank_index] = offset;
+        s->cirrus_bank_limit[bank_index] = limit;
     } else {
-	s->cirrus_bank_base[bank_index] = 0;
-	s->cirrus_bank_limit[bank_index] = 0;
+        s->cirrus_bank_base[bank_index] = 0;
+        s->cirrus_bank_limit[bank_index] = 0;
     }
 }
 
@@ -1319,158 +1319,158 @@ static void cirrus_update_bank_ptr(CirrusVGAState * s, unsigned bank_index)
 static int cirrus_vga_read_sr(CirrusVGAState * s)
 {
     switch (s->vga.sr_index) {
-    case 0x00:			// Standard VGA
-    case 0x01:			// Standard VGA
-    case 0x02:			// Standard VGA
-    case 0x03:			// Standard VGA
-    case 0x04:			// Standard VGA
-	return s->vga.sr[s->vga.sr_index];
-    case 0x06:			// Unlock Cirrus extensions
-	return s->vga.sr[s->vga.sr_index];
+    case 0x00:                        // Standard VGA
+    case 0x01:                        // Standard VGA
+    case 0x02:                        // Standard VGA
+    case 0x03:                        // Standard VGA
+    case 0x04:                        // Standard VGA
+        return s->vga.sr[s->vga.sr_index];
+    case 0x06:                        // Unlock Cirrus extensions
+        return s->vga.sr[s->vga.sr_index];
     case 0x10:
     case 0x30:
     case 0x50:
-    case 0x70:			// Graphics Cursor X
+    case 0x70:                        // Graphics Cursor X
     case 0x90:
     case 0xb0:
     case 0xd0:
-    case 0xf0:			// Graphics Cursor X
-	return s->vga.sr[0x10];
+    case 0xf0:                        // Graphics Cursor X
+        return s->vga.sr[0x10];
     case 0x11:
     case 0x31:
     case 0x51:
-    case 0x71:			// Graphics Cursor Y
+    case 0x71:                        // Graphics Cursor Y
     case 0x91:
     case 0xb1:
     case 0xd1:
-    case 0xf1:			// Graphics Cursor Y
-	return s->vga.sr[0x11];
-    case 0x05:			// ???
-    case 0x07:			// Extended Sequencer Mode
-    case 0x08:			// EEPROM Control
-    case 0x09:			// Scratch Register 0
-    case 0x0a:			// Scratch Register 1
-    case 0x0b:			// VCLK 0
-    case 0x0c:			// VCLK 1
-    case 0x0d:			// VCLK 2
-    case 0x0e:			// VCLK 3
-    case 0x0f:			// DRAM Control
-    case 0x12:			// Graphics Cursor Attribute
-    case 0x13:			// Graphics Cursor Pattern Address
-    case 0x14:			// Scratch Register 2
-    case 0x15:			// Scratch Register 3
-    case 0x16:			// Performance Tuning Register
-    case 0x17:			// Configuration Readback and Extended Control
-    case 0x18:			// Signature Generator Control
-    case 0x19:			// Signal Generator Result
-    case 0x1a:			// Signal Generator Result
-    case 0x1b:			// VCLK 0 Denominator & Post
-    case 0x1c:			// VCLK 1 Denominator & Post
-    case 0x1d:			// VCLK 2 Denominator & Post
-    case 0x1e:			// VCLK 3 Denominator & Post
-    case 0x1f:			// BIOS Write Enable and MCLK select
+    case 0xf1:                        // Graphics Cursor Y
+        return s->vga.sr[0x11];
+    case 0x05:                        // ???
+    case 0x07:                        // Extended Sequencer Mode
+    case 0x08:                        // EEPROM Control
+    case 0x09:                        // Scratch Register 0
+    case 0x0a:                        // Scratch Register 1
+    case 0x0b:                        // VCLK 0
+    case 0x0c:                        // VCLK 1
+    case 0x0d:                        // VCLK 2
+    case 0x0e:                        // VCLK 3
+    case 0x0f:                        // DRAM Control
+    case 0x12:                        // Graphics Cursor Attribute
+    case 0x13:                        // Graphics Cursor Pattern Address
+    case 0x14:                        // Scratch Register 2
+    case 0x15:                        // Scratch Register 3
+    case 0x16:                        // Performance Tuning Register
+    case 0x17:                        // Configuration Readback and Extended Control
+    case 0x18:                        // Signature Generator Control
+    case 0x19:                        // Signal Generator Result
+    case 0x1a:                        // Signal Generator Result
+    case 0x1b:                        // VCLK 0 Denominator & Post
+    case 0x1c:                        // VCLK 1 Denominator & Post
+    case 0x1d:                        // VCLK 2 Denominator & Post
+    case 0x1e:                        // VCLK 3 Denominator & Post
+    case 0x1f:                        // BIOS Write Enable and MCLK select
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: handled inport sr_index %02x\n", s->vga.sr_index);
+        printf("cirrus: handled inport sr_index %02x\n", s->vga.sr_index);
 #endif
-	return s->vga.sr[s->vga.sr_index];
+        return s->vga.sr[s->vga.sr_index];
     default:
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: inport sr_index %02x\n", s->vga.sr_index);
+        printf("cirrus: inport sr_index %02x\n", s->vga.sr_index);
 #endif
-	return 0xff;
-	break;
+        return 0xff;
+        break;
     }
 }
 
 static void cirrus_vga_write_sr(CirrusVGAState * s, uint32_t val)
 {
     switch (s->vga.sr_index) {
-    case 0x00:			// Standard VGA
-    case 0x01:			// Standard VGA
-    case 0x02:			// Standard VGA
-    case 0x03:			// Standard VGA
-    case 0x04:			// Standard VGA
-	s->vga.sr[s->vga.sr_index] = val & sr_mask[s->vga.sr_index];
-	if (s->vga.sr_index == 1)
+    case 0x00:                        // Standard VGA
+    case 0x01:                        // Standard VGA
+    case 0x02:                        // Standard VGA
+    case 0x03:                        // Standard VGA
+    case 0x04:                        // Standard VGA
+        s->vga.sr[s->vga.sr_index] = val & sr_mask[s->vga.sr_index];
+        if (s->vga.sr_index == 1)
             s->vga.update_retrace_info(&s->vga);
         break;
-    case 0x06:			// Unlock Cirrus extensions
-	val &= 0x17;
-	if (val == 0x12) {
-	    s->vga.sr[s->vga.sr_index] = 0x12;
-	} else {
-	    s->vga.sr[s->vga.sr_index] = 0x0f;
-	}
-	break;
+    case 0x06:                        // Unlock Cirrus extensions
+        val &= 0x17;
+        if (val == 0x12) {
+            s->vga.sr[s->vga.sr_index] = 0x12;
+        } else {
+            s->vga.sr[s->vga.sr_index] = 0x0f;
+        }
+        break;
     case 0x10:
     case 0x30:
     case 0x50:
-    case 0x70:			// Graphics Cursor X
+    case 0x70:                        // Graphics Cursor X
     case 0x90:
     case 0xb0:
     case 0xd0:
-    case 0xf0:			// Graphics Cursor X
-	s->vga.sr[0x10] = val;
+    case 0xf0:                        // Graphics Cursor X
+        s->vga.sr[0x10] = val;
         s->vga.hw_cursor_x = (val << 3) | (s->vga.sr_index >> 5);
-	break;
+        break;
     case 0x11:
     case 0x31:
     case 0x51:
-    case 0x71:			// Graphics Cursor Y
+    case 0x71:                        // Graphics Cursor Y
     case 0x91:
     case 0xb1:
     case 0xd1:
-    case 0xf1:			// Graphics Cursor Y
-	s->vga.sr[0x11] = val;
+    case 0xf1:                        // Graphics Cursor Y
+        s->vga.sr[0x11] = val;
         s->vga.hw_cursor_y = (val << 3) | (s->vga.sr_index >> 5);
-	break;
-    case 0x07:			// Extended Sequencer Mode
-    cirrus_update_memory_access(s);
-    case 0x08:			// EEPROM Control
-    case 0x09:			// Scratch Register 0
-    case 0x0a:			// Scratch Register 1
-    case 0x0b:			// VCLK 0
-    case 0x0c:			// VCLK 1
-    case 0x0d:			// VCLK 2
-    case 0x0e:			// VCLK 3
-    case 0x0f:			// DRAM Control
-    case 0x13:			// Graphics Cursor Pattern Address
-    case 0x14:			// Scratch Register 2
-    case 0x15:			// Scratch Register 3
-    case 0x16:			// Performance Tuning Register
-    case 0x18:			// Signature Generator Control
-    case 0x19:			// Signature Generator Result
-    case 0x1a:			// Signature Generator Result
-    case 0x1b:			// VCLK 0 Denominator & Post
-    case 0x1c:			// VCLK 1 Denominator & Post
-    case 0x1d:			// VCLK 2 Denominator & Post
-    case 0x1e:			// VCLK 3 Denominator & Post
-    case 0x1f:			// BIOS Write Enable and MCLK select
-	s->vga.sr[s->vga.sr_index] = val;
+        break;
+    case 0x07:                        // Extended Sequencer Mode
+        cirrus_update_memory_access(s);
+    case 0x08:                        // EEPROM Control
+    case 0x09:                        // Scratch Register 0
+    case 0x0a:                        // Scratch Register 1
+    case 0x0b:                        // VCLK 0
+    case 0x0c:                        // VCLK 1
+    case 0x0d:                        // VCLK 2
+    case 0x0e:                        // VCLK 3
+    case 0x0f:                        // DRAM Control
+    case 0x13:                        // Graphics Cursor Pattern Address
+    case 0x14:                        // Scratch Register 2
+    case 0x15:                        // Scratch Register 3
+    case 0x16:                        // Performance Tuning Register
+    case 0x18:                        // Signature Generator Control
+    case 0x19:                        // Signature Generator Result
+    case 0x1a:                        // Signature Generator Result
+    case 0x1b:                        // VCLK 0 Denominator & Post
+    case 0x1c:                        // VCLK 1 Denominator & Post
+    case 0x1d:                        // VCLK 2 Denominator & Post
+    case 0x1e:                        // VCLK 3 Denominator & Post
+    case 0x1f:                        // BIOS Write Enable and MCLK select
+        s->vga.sr[s->vga.sr_index] = val;
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: handled outport sr_index %02x, sr_value %02x\n",
-	       s->vga.sr_index, val);
+        printf("cirrus: handled outport sr_index %02x, sr_value %02x\n",
+               s->vga.sr_index, val);
 #endif
-	break;
-    case 0x12:			// Graphics Cursor Attribute
-	s->vga.sr[0x12] = val;
+        break;
+    case 0x12:                        // Graphics Cursor Attribute
+        s->vga.sr[0x12] = val;
         s->vga.force_shadow = !!(val & CIRRUS_CURSOR_SHOW);
 #ifdef DEBUG_CIRRUS
         printf("cirrus: cursor ctl SR12=%02x (force shadow: %d)\n",
                val, s->vga.force_shadow);
 #endif
         break;
-    case 0x17:			// Configuration Readback and Extended Control
-	s->vga.sr[s->vga.sr_index] = (s->vga.sr[s->vga.sr_index] & 0x38)
+    case 0x17:                        // Configuration Readback and Extended Control
+        s->vga.sr[s->vga.sr_index] = (s->vga.sr[s->vga.sr_index] & 0x38)
                                    | (val & 0xc7);
         cirrus_update_memory_access(s);
         break;
     default:
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: outport sr_index %02x, sr_value %02x\n",
+        printf("cirrus: outport sr_index %02x, sr_value %02x\n",
                s->vga.sr_index, val);
 #endif
-	break;
+        break;
     }
 }
 
@@ -1492,9 +1492,9 @@ static int cirrus_read_hidden_dac(CirrusVGAState * s)
 static void cirrus_write_hidden_dac(CirrusVGAState * s, int reg_value)
 {
     if (s->cirrus_hidden_dac_lockindex == 4) {
-	s->cirrus_hidden_dac_data = reg_value;
+        s->cirrus_hidden_dac_data = reg_value;
 #if defined(DEBUG_CIRRUS)
-	printf("cirrus: outport hidden DAC, value %02x\n", reg_value);
+        printf("cirrus: outport hidden DAC, value %02x\n", reg_value);
 #endif
     }
     s->cirrus_hidden_dac_lockindex = 0;
@@ -1517,8 +1517,8 @@ static int cirrus_vga_read_palette(CirrusVGAState * s)
         val = s->vga.palette[s->vga.dac_read_index * 3 + s->vga.dac_sub_index];
     }
     if (++s->vga.dac_sub_index == 3) {
-	s->vga.dac_sub_index = 0;
-	s->vga.dac_read_index++;
+        s->vga.dac_sub_index = 0;
+        s->vga.dac_read_index++;
     }
     return val;
 }
@@ -1534,8 +1534,8 @@ static void cirrus_vga_write_palette(CirrusVGAState * s, int reg_value)
             memcpy(&s->vga.palette[s->vga.dac_write_index * 3], s->vga.dac_cache, 3);
         }
         /* XXX update cursor */
-	s->vga.dac_sub_index = 0;
-	s->vga.dac_write_index++;
+        s->vga.dac_sub_index = 0;
+        s->vga.dac_write_index++;
     }
 }
 
@@ -1552,25 +1552,25 @@ static int cirrus_vga_read_gr(CirrusVGAState * s, unsigned reg_index)
         return s->cirrus_shadow_gr0;
     case 0x01: // Standard VGA, FGCOLOR 0x000000ff
         return s->cirrus_shadow_gr1;
-    case 0x02:			// Standard VGA
-    case 0x03:			// Standard VGA
-    case 0x04:			// Standard VGA
-    case 0x06:			// Standard VGA
-    case 0x07:			// Standard VGA
-    case 0x08:			// Standard VGA
+    case 0x02:                        // Standard VGA
+    case 0x03:                        // Standard VGA
+    case 0x04:                        // Standard VGA
+    case 0x06:                        // Standard VGA
+    case 0x07:                        // Standard VGA
+    case 0x08:                        // Standard VGA
         return s->vga.gr[s->vga.gr_index];
-    case 0x05:			// Standard VGA, Cirrus extended mode
+    case 0x05:                        // Standard VGA, Cirrus extended mode
     default:
-	break;
+        break;
     }
 
     if (reg_index < 0x3a) {
-	return s->vga.gr[reg_index];
+        return s->vga.gr[reg_index];
     } else {
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: inport gr_index %02x\n", reg_index);
+        printf("cirrus: inport gr_index %02x\n", reg_index);
 #endif
-	return 0xff;
+        return 0xff;
     }
 }
 
@@ -1581,88 +1581,88 @@ cirrus_vga_write_gr(CirrusVGAState * s, unsigned reg_index, int reg_value)
     printf("gr%02x: %02x\n", reg_index, reg_value);
 #endif
     switch (reg_index) {
-    case 0x00:			// Standard VGA, BGCOLOR 0x000000ff
-	s->vga.gr[reg_index] = reg_value & gr_mask[reg_index];
-	s->cirrus_shadow_gr0 = reg_value;
-	break;
-    case 0x01:			// Standard VGA, FGCOLOR 0x000000ff
-	s->vga.gr[reg_index] = reg_value & gr_mask[reg_index];
-	s->cirrus_shadow_gr1 = reg_value;
-	break;
-    case 0x02:			// Standard VGA
-    case 0x03:			// Standard VGA
-    case 0x04:			// Standard VGA
-    case 0x06:			// Standard VGA
-    case 0x07:			// Standard VGA
-    case 0x08:			// Standard VGA
-	s->vga.gr[reg_index] = reg_value & gr_mask[reg_index];
-        break;
-    case 0x05:			// Standard VGA, Cirrus extended mode
-	s->vga.gr[reg_index] = reg_value & 0x7f;
+    case 0x00:                        // Standard VGA, BGCOLOR 0x000000ff
+        s->vga.gr[reg_index] = reg_value & gr_mask[reg_index];
+        s->cirrus_shadow_gr0 = reg_value;
+        break;
+    case 0x01:                        // Standard VGA, FGCOLOR 0x000000ff
+        s->vga.gr[reg_index] = reg_value & gr_mask[reg_index];
+        s->cirrus_shadow_gr1 = reg_value;
+        break;
+    case 0x02:                        // Standard VGA
+    case 0x03:                        // Standard VGA
+    case 0x04:                        // Standard VGA
+    case 0x06:                        // Standard VGA
+    case 0x07:                        // Standard VGA
+    case 0x08:                        // Standard VGA
+        s->vga.gr[reg_index] = reg_value & gr_mask[reg_index];
+        break;
+    case 0x05:                        // Standard VGA, Cirrus extended mode
+        s->vga.gr[reg_index] = reg_value & 0x7f;
         cirrus_update_memory_access(s);
-	break;
-    case 0x09:			// bank offset #0
-    case 0x0A:			// bank offset #1
-	s->vga.gr[reg_index] = reg_value;
-	cirrus_update_bank_ptr(s, 0);
-	cirrus_update_bank_ptr(s, 1);
+        break;
+    case 0x09:                        // bank offset #0
+    case 0x0A:                        // bank offset #1
+        s->vga.gr[reg_index] = reg_value;
+        cirrus_update_bank_ptr(s, 0);
+        cirrus_update_bank_ptr(s, 1);
         cirrus_update_memory_access(s);
         break;
     case 0x0B:
-	s->vga.gr[reg_index] = reg_value;
-	cirrus_update_bank_ptr(s, 0);
-	cirrus_update_bank_ptr(s, 1);
+        s->vga.gr[reg_index] = reg_value;
+        cirrus_update_bank_ptr(s, 0);
+        cirrus_update_bank_ptr(s, 1);
         cirrus_update_memory_access(s);
-	break;
-    case 0x10:			// BGCOLOR 0x0000ff00
-    case 0x11:			// FGCOLOR 0x0000ff00
-    case 0x12:			// BGCOLOR 0x00ff0000
-    case 0x13:			// FGCOLOR 0x00ff0000
-    case 0x14:			// BGCOLOR 0xff000000
-    case 0x15:			// FGCOLOR 0xff000000
-    case 0x20:			// BLT WIDTH 0x0000ff
-    case 0x22:			// BLT HEIGHT 0x0000ff
-    case 0x24:			// BLT DEST PITCH 0x0000ff
-    case 0x26:			// BLT SRC PITCH 0x0000ff
-    case 0x28:			// BLT DEST ADDR 0x0000ff
-    case 0x29:			// BLT DEST ADDR 0x00ff00
-    case 0x2c:			// BLT SRC ADDR 0x0000ff
-    case 0x2d:			// BLT SRC ADDR 0x00ff00
-    case 0x2f:                  // BLT WRITEMASK
-    case 0x30:			// BLT MODE
-    case 0x32:			// RASTER OP
-    case 0x33:			// BLT MODEEXT
-    case 0x34:			// BLT TRANSPARENT COLOR 0x00ff
-    case 0x35:			// BLT TRANSPARENT COLOR 0xff00
-    case 0x38:			// BLT TRANSPARENT COLOR MASK 0x00ff
-    case 0x39:			// BLT TRANSPARENT COLOR MASK 0xff00
-	s->vga.gr[reg_index] = reg_value;
-	break;
-    case 0x21:			// BLT WIDTH 0x001f00
-    case 0x23:			// BLT HEIGHT 0x001f00
-    case 0x25:			// BLT DEST PITCH 0x001f00
-    case 0x27:			// BLT SRC PITCH 0x001f00
-	s->vga.gr[reg_index] = reg_value & 0x1f;
-	break;
-    case 0x2a:			// BLT DEST ADDR 0x3f0000
-	s->vga.gr[reg_index] = reg_value & 0x3f;
+        break;
+    case 0x10:                        // BGCOLOR 0x0000ff00
+    case 0x11:                        // FGCOLOR 0x0000ff00
+    case 0x12:                        // BGCOLOR 0x00ff0000
+    case 0x13:                        // FGCOLOR 0x00ff0000
+    case 0x14:                        // BGCOLOR 0xff000000
+    case 0x15:                        // FGCOLOR 0xff000000
+    case 0x20:                        // BLT WIDTH 0x0000ff
+    case 0x22:                        // BLT HEIGHT 0x0000ff
+    case 0x24:                        // BLT DEST PITCH 0x0000ff
+    case 0x26:                        // BLT SRC PITCH 0x0000ff
+    case 0x28:                        // BLT DEST ADDR 0x0000ff
+    case 0x29:                        // BLT DEST ADDR 0x00ff00
+    case 0x2c:                        // BLT SRC ADDR 0x0000ff
+    case 0x2d:                        // BLT SRC ADDR 0x00ff00
+    case 0x2f:                        // BLT WRITEMASK
+    case 0x30:                        // BLT MODE
+    case 0x32:                        // RASTER OP
+    case 0x33:                        // BLT MODEEXT
+    case 0x34:                        // BLT TRANSPARENT COLOR 0x00ff
+    case 0x35:                        // BLT TRANSPARENT COLOR 0xff00
+    case 0x38:                        // BLT TRANSPARENT COLOR MASK 0x00ff
+    case 0x39:                        // BLT TRANSPARENT COLOR MASK 0xff00
+        s->vga.gr[reg_index] = reg_value;
+        break;
+    case 0x21:                        // BLT WIDTH 0x001f00
+    case 0x23:                        // BLT HEIGHT 0x001f00
+    case 0x25:                        // BLT DEST PITCH 0x001f00
+    case 0x27:                        // BLT SRC PITCH 0x001f00
+        s->vga.gr[reg_index] = reg_value & 0x1f;
+        break;
+    case 0x2a:                        // BLT DEST ADDR 0x3f0000
+        s->vga.gr[reg_index] = reg_value & 0x3f;
         /* if auto start mode, starts bit blt now */
         if (s->vga.gr[0x31] & CIRRUS_BLT_AUTOSTART) {
             cirrus_bitblt_start(s);
         }
-	break;
-    case 0x2e:			// BLT SRC ADDR 0x3f0000
-	s->vga.gr[reg_index] = reg_value & 0x3f;
-	break;
-    case 0x31:			// BLT STATUS/START
-	cirrus_write_bitblt(s, reg_value);
-	break;
+        break;
+    case 0x2e:                        // BLT SRC ADDR 0x3f0000
+        s->vga.gr[reg_index] = reg_value & 0x3f;
+        break;
+    case 0x31:                        // BLT STATUS/START
+        cirrus_write_bitblt(s, reg_value);
+        break;
     default:
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: outport gr_index %02x, gr_value %02x\n", reg_index,
-	       reg_value);
+        printf("cirrus: outport gr_index %02x, gr_value %02x\n", reg_index,
+               reg_value);
 #endif
-	break;
+        break;
     }
 }
 
@@ -1675,125 +1675,125 @@ cirrus_vga_write_gr(CirrusVGAState * s, unsigned reg_index, int reg_value)
 static int cirrus_vga_read_cr(CirrusVGAState * s, unsigned reg_index)
 {
     switch (reg_index) {
-    case 0x00:			// Standard VGA
-    case 0x01:			// Standard VGA
-    case 0x02:			// Standard VGA
-    case 0x03:			// Standard VGA
-    case 0x04:			// Standard VGA
-    case 0x05:			// Standard VGA
-    case 0x06:			// Standard VGA
-    case 0x07:			// Standard VGA
-    case 0x08:			// Standard VGA
-    case 0x09:			// Standard VGA
-    case 0x0a:			// Standard VGA
-    case 0x0b:			// Standard VGA
-    case 0x0c:			// Standard VGA
-    case 0x0d:			// Standard VGA
-    case 0x0e:			// Standard VGA
-    case 0x0f:			// Standard VGA
-    case 0x10:			// Standard VGA
-    case 0x11:			// Standard VGA
-    case 0x12:			// Standard VGA
-    case 0x13:			// Standard VGA
-    case 0x14:			// Standard VGA
-    case 0x15:			// Standard VGA
-    case 0x16:			// Standard VGA
-    case 0x17:			// Standard VGA
-    case 0x18:			// Standard VGA
-	return s->vga.cr[s->vga.cr_index];
-    case 0x24:			// Attribute Controller Toggle Readback (R)
+    case 0x00:                        // Standard VGA
+    case 0x01:                        // Standard VGA
+    case 0x02:                        // Standard VGA
+    case 0x03:                        // Standard VGA
+    case 0x04:                        // Standard VGA
+    case 0x05:                        // Standard VGA
+    case 0x06:                        // Standard VGA
+    case 0x07:                        // Standard VGA
+    case 0x08:                        // Standard VGA
+    case 0x09:                        // Standard VGA
+    case 0x0a:                        // Standard VGA
+    case 0x0b:                        // Standard VGA
+    case 0x0c:                        // Standard VGA
+    case 0x0d:                        // Standard VGA
+    case 0x0e:                        // Standard VGA
+    case 0x0f:                        // Standard VGA
+    case 0x10:                        // Standard VGA
+    case 0x11:                        // Standard VGA
+    case 0x12:                        // Standard VGA
+    case 0x13:                        // Standard VGA
+    case 0x14:                        // Standard VGA
+    case 0x15:                        // Standard VGA
+    case 0x16:                        // Standard VGA
+    case 0x17:                        // Standard VGA
+    case 0x18:                        // Standard VGA
+        return s->vga.cr[s->vga.cr_index];
+    case 0x24:                        // Attribute Controller Toggle Readback (R)
         return (s->vga.ar_flip_flop << 7);
-    case 0x19:			// Interlace End
-    case 0x1a:			// Miscellaneous Control
-    case 0x1b:			// Extended Display Control
-    case 0x1c:			// Sync Adjust and Genlock
-    case 0x1d:			// Overlay Extended Control
-    case 0x22:			// Graphics Data Latches Readback (R)
-    case 0x25:			// Part Status
-    case 0x27:			// Part ID (R)
-	return s->vga.cr[s->vga.cr_index];
-    case 0x26:			// Attribute Controller Index Readback (R)
-	return s->vga.ar_index & 0x3f;
-	break;
+    case 0x19:                        // Interlace End
+    case 0x1a:                        // Miscellaneous Control
+    case 0x1b:                        // Extended Display Control
+    case 0x1c:                        // Sync Adjust and Genlock
+    case 0x1d:                        // Overlay Extended Control
+    case 0x22:                        // Graphics Data Latches Readback (R)
+    case 0x25:                        // Part Status
+    case 0x27:                        // Part ID (R)
+        return s->vga.cr[s->vga.cr_index];
+    case 0x26:                        // Attribute Controller Index Readback (R)
+        return s->vga.ar_index & 0x3f;
+        break;
     default:
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: inport cr_index %02x\n", reg_index);
+        printf("cirrus: inport cr_index %02x\n", reg_index);
 #endif
-	return 0xff;
+        return 0xff;
     }
 }
 
 static void cirrus_vga_write_cr(CirrusVGAState * s, int reg_value)
 {
     switch (s->vga.cr_index) {
-    case 0x00:			// Standard VGA
-    case 0x01:			// Standard VGA
-    case 0x02:			// Standard VGA
-    case 0x03:			// Standard VGA
-    case 0x04:			// Standard VGA
-    case 0x05:			// Standard VGA
-    case 0x06:			// Standard VGA
-    case 0x07:			// Standard VGA
-    case 0x08:			// Standard VGA
-    case 0x09:			// Standard VGA
-    case 0x0a:			// Standard VGA
-    case 0x0b:			// Standard VGA
-    case 0x0c:			// Standard VGA
-    case 0x0d:			// Standard VGA
-    case 0x0e:			// Standard VGA
-    case 0x0f:			// Standard VGA
-    case 0x10:			// Standard VGA
-    case 0x11:			// Standard VGA
-    case 0x12:			// Standard VGA
-    case 0x13:			// Standard VGA
-    case 0x14:			// Standard VGA
-    case 0x15:			// Standard VGA
-    case 0x16:			// Standard VGA
-    case 0x17:			// Standard VGA
-    case 0x18:			// Standard VGA
-	/* handle CR0-7 protection */
-	if ((s->vga.cr[0x11] & 0x80) && s->vga.cr_index <= 7) {
-	    /* can always write bit 4 of CR7 */
-	    if (s->vga.cr_index == 7)
-		s->vga.cr[7] = (s->vga.cr[7] & ~0x10) | (reg_value & 0x10);
-	    return;
-	}
-	s->vga.cr[s->vga.cr_index] = reg_value;
-	switch(s->vga.cr_index) {
-	case 0x00:
-	case 0x04:
-	case 0x05:
-	case 0x06:
-	case 0x07:
-	case 0x11:
-	case 0x17:
-	    s->vga.update_retrace_info(&s->vga);
-	    break;
-	}
-        break;
-    case 0x19:			// Interlace End
-    case 0x1a:			// Miscellaneous Control
-    case 0x1b:			// Extended Display Control
-    case 0x1c:			// Sync Adjust and Genlock
-    case 0x1d:			// Overlay Extended Control
-	s->vga.cr[s->vga.cr_index] = reg_value;
+    case 0x00:                        // Standard VGA
+    case 0x01:                        // Standard VGA
+    case 0x02:                        // Standard VGA
+    case 0x03:                        // Standard VGA
+    case 0x04:                        // Standard VGA
+    case 0x05:                        // Standard VGA
+    case 0x06:                        // Standard VGA
+    case 0x07:                        // Standard VGA
+    case 0x08:                        // Standard VGA
+    case 0x09:                        // Standard VGA
+    case 0x0a:                        // Standard VGA
+    case 0x0b:                        // Standard VGA
+    case 0x0c:                        // Standard VGA
+    case 0x0d:                        // Standard VGA
+    case 0x0e:                        // Standard VGA
+    case 0x0f:                        // Standard VGA
+    case 0x10:                        // Standard VGA
+    case 0x11:                        // Standard VGA
+    case 0x12:                        // Standard VGA
+    case 0x13:                        // Standard VGA
+    case 0x14:                        // Standard VGA
+    case 0x15:                        // Standard VGA
+    case 0x16:                        // Standard VGA
+    case 0x17:                        // Standard VGA
+    case 0x18:                        // Standard VGA
+        /* handle CR0-7 protection */
+        if ((s->vga.cr[0x11] & 0x80) && s->vga.cr_index <= 7) {
+            /* can always write bit 4 of CR7 */
+            if (s->vga.cr_index == 7)
+                s->vga.cr[7] = (s->vga.cr[7] & ~0x10) | (reg_value & 0x10);
+            return;
+        }
+        s->vga.cr[s->vga.cr_index] = reg_value;
+        switch(s->vga.cr_index) {
+        case 0x00:
+        case 0x04:
+        case 0x05:
+        case 0x06:
+        case 0x07:
+        case 0x11:
+        case 0x17:
+            s->vga.update_retrace_info(&s->vga);
+            break;
+        }
+        break;
+    case 0x19:                        // Interlace End
+    case 0x1a:                        // Miscellaneous Control
+    case 0x1b:                        // Extended Display Control
+    case 0x1c:                        // Sync Adjust and Genlock
+    case 0x1d:                        // Overlay Extended Control
+        s->vga.cr[s->vga.cr_index] = reg_value;
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: handled outport cr_index %02x, cr_value %02x\n",
-	       s->vga.cr_index, reg_value);
+        printf("cirrus: handled outport cr_index %02x, cr_value %02x\n",
+               s->vga.cr_index, reg_value);
 #endif
-	break;
-    case 0x22:			// Graphics Data Latches Readback (R)
-    case 0x24:			// Attribute Controller Toggle Readback (R)
-    case 0x26:			// Attribute Controller Index Readback (R)
-    case 0x27:			// Part ID (R)
-	break;
-    case 0x25:			// Part Status
+        break;
+    case 0x22:                        // Graphics Data Latches Readback (R)
+    case 0x24:                        // Attribute Controller Toggle Readback (R)
+    case 0x26:                        // Attribute Controller Index Readback (R)
+    case 0x27:                        // Part ID (R)
+        break;
+    case 0x25:                        // Part Status
     default:
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: outport cr_index %02x, cr_value %02x\n",
+        printf("cirrus: outport cr_index %02x, cr_value %02x\n",
                s->vga.cr_index, reg_value);
 #endif
-	break;
+        break;
     }
 }
 
@@ -1809,103 +1809,103 @@ static uint8_t cirrus_mmio_blt_read(CirrusVGAState * s, unsigned address)
 
     switch (address) {
     case (CIRRUS_MMIO_BLTBGCOLOR + 0):
-	value = cirrus_vga_read_gr(s, 0x00);
-	break;
+        value = cirrus_vga_read_gr(s, 0x00);
+        break;
     case (CIRRUS_MMIO_BLTBGCOLOR + 1):
-	value = cirrus_vga_read_gr(s, 0x10);
-	break;
+        value = cirrus_vga_read_gr(s, 0x10);
+        break;
     case (CIRRUS_MMIO_BLTBGCOLOR + 2):
-	value = cirrus_vga_read_gr(s, 0x12);
-	break;
+        value = cirrus_vga_read_gr(s, 0x12);
+        break;
     case (CIRRUS_MMIO_BLTBGCOLOR + 3):
-	value = cirrus_vga_read_gr(s, 0x14);
-	break;
+        value = cirrus_vga_read_gr(s, 0x14);
+        break;
     case (CIRRUS_MMIO_BLTFGCOLOR + 0):
-	value = cirrus_vga_read_gr(s, 0x01);
-	break;
+        value = cirrus_vga_read_gr(s, 0x01);
+        break;
     case (CIRRUS_MMIO_BLTFGCOLOR + 1):
-	value = cirrus_vga_read_gr(s, 0x11);
-	break;
+        value = cirrus_vga_read_gr(s, 0x11);
+        break;
     case (CIRRUS_MMIO_BLTFGCOLOR + 2):
-	value = cirrus_vga_read_gr(s, 0x13);
-	break;
+        value = cirrus_vga_read_gr(s, 0x13);
+        break;
     case (CIRRUS_MMIO_BLTFGCOLOR + 3):
-	value = cirrus_vga_read_gr(s, 0x15);
-	break;
+        value = cirrus_vga_read_gr(s, 0x15);
+        break;
     case (CIRRUS_MMIO_BLTWIDTH + 0):
-	value = cirrus_vga_read_gr(s, 0x20);
-	break;
+        value = cirrus_vga_read_gr(s, 0x20);
+        break;
     case (CIRRUS_MMIO_BLTWIDTH + 1):
-	value = cirrus_vga_read_gr(s, 0x21);
-	break;
+        value = cirrus_vga_read_gr(s, 0x21);
+        break;
     case (CIRRUS_MMIO_BLTHEIGHT + 0):
-	value = cirrus_vga_read_gr(s, 0x22);
-	break;
+        value = cirrus_vga_read_gr(s, 0x22);
+        break;
     case (CIRRUS_MMIO_BLTHEIGHT + 1):
-	value = cirrus_vga_read_gr(s, 0x23);
-	break;
+        value = cirrus_vga_read_gr(s, 0x23);
+        break;
     case (CIRRUS_MMIO_BLTDESTPITCH + 0):
-	value = cirrus_vga_read_gr(s, 0x24);
-	break;
+        value = cirrus_vga_read_gr(s, 0x24);
+        break;
     case (CIRRUS_MMIO_BLTDESTPITCH + 1):
-	value = cirrus_vga_read_gr(s, 0x25);
-	break;
+        value = cirrus_vga_read_gr(s, 0x25);
+        break;
     case (CIRRUS_MMIO_BLTSRCPITCH + 0):
-	value = cirrus_vga_read_gr(s, 0x26);
-	break;
+        value = cirrus_vga_read_gr(s, 0x26);
+        break;
     case (CIRRUS_MMIO_BLTSRCPITCH + 1):
-	value = cirrus_vga_read_gr(s, 0x27);
-	break;
+        value = cirrus_vga_read_gr(s, 0x27);
+        break;
     case (CIRRUS_MMIO_BLTDESTADDR + 0):
-	value = cirrus_vga_read_gr(s, 0x28);
-	break;
+        value = cirrus_vga_read_gr(s, 0x28);
+        break;
     case (CIRRUS_MMIO_BLTDESTADDR + 1):
-	value = cirrus_vga_read_gr(s, 0x29);
-	break;
+        value = cirrus_vga_read_gr(s, 0x29);
+        break;
     case (CIRRUS_MMIO_BLTDESTADDR + 2):
-	value = cirrus_vga_read_gr(s, 0x2a);
-	break;
+        value = cirrus_vga_read_gr(s, 0x2a);
+        break;
     case (CIRRUS_MMIO_BLTSRCADDR + 0):
-	value = cirrus_vga_read_gr(s, 0x2c);
-	break;
+        value = cirrus_vga_read_gr(s, 0x2c);
+        break;
     case (CIRRUS_MMIO_BLTSRCADDR + 1):
-	value = cirrus_vga_read_gr(s, 0x2d);
-	break;
+        value = cirrus_vga_read_gr(s, 0x2d);
+        break;
     case (CIRRUS_MMIO_BLTSRCADDR + 2):
-	value = cirrus_vga_read_gr(s, 0x2e);
-	break;
+        value = cirrus_vga_read_gr(s, 0x2e);
+        break;
     case CIRRUS_MMIO_BLTWRITEMASK:
-	value = cirrus_vga_read_gr(s, 0x2f);
-	break;
+        value = cirrus_vga_read_gr(s, 0x2f);
+        break;
     case CIRRUS_MMIO_BLTMODE:
-	value = cirrus_vga_read_gr(s, 0x30);
-	break;
+        value = cirrus_vga_read_gr(s, 0x30);
+        break;
     case CIRRUS_MMIO_BLTROP:
-	value = cirrus_vga_read_gr(s, 0x32);
-	break;
+        value = cirrus_vga_read_gr(s, 0x32);
+        break;
     case CIRRUS_MMIO_BLTMODEEXT:
-	value = cirrus_vga_read_gr(s, 0x33);
-	break;
+        value = cirrus_vga_read_gr(s, 0x33);
+        break;
     case (CIRRUS_MMIO_BLTTRANSPARENTCOLOR + 0):
-	value = cirrus_vga_read_gr(s, 0x34);
-	break;
+        value = cirrus_vga_read_gr(s, 0x34);
+        break;
     case (CIRRUS_MMIO_BLTTRANSPARENTCOLOR + 1):
-	value = cirrus_vga_read_gr(s, 0x35);
-	break;
+        value = cirrus_vga_read_gr(s, 0x35);
+        break;
     case (CIRRUS_MMIO_BLTTRANSPARENTCOLORMASK + 0):
-	value = cirrus_vga_read_gr(s, 0x38);
-	break;
+        value = cirrus_vga_read_gr(s, 0x38);
+        break;
     case (CIRRUS_MMIO_BLTTRANSPARENTCOLORMASK + 1):
-	value = cirrus_vga_read_gr(s, 0x39);
-	break;
+        value = cirrus_vga_read_gr(s, 0x39);
+        break;
     case CIRRUS_MMIO_BLTSTATUS:
-	value = cirrus_vga_read_gr(s, 0x31);
-	break;
+        value = cirrus_vga_read_gr(s, 0x31);
+        break;
     default:
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: mmio read - address 0x%04x\n", address);
+        printf("cirrus: mmio read - address 0x%04x\n", address);
 #endif
-	break;
+        break;
     }
 
     trace_vga_cirrus_write_blt(address, value);
@@ -1913,112 +1913,112 @@ static uint8_t cirrus_mmio_blt_read(CirrusVGAState * s, unsigned address)
 }
 
 static void cirrus_mmio_blt_write(CirrusVGAState * s, unsigned address,
-				  uint8_t value)
+                                  uint8_t value)
 {
     trace_vga_cirrus_write_blt(address, value);
     switch (address) {
     case (CIRRUS_MMIO_BLTBGCOLOR + 0):
-	cirrus_vga_write_gr(s, 0x00, value);
-	break;
+        cirrus_vga_write_gr(s, 0x00, value);
+        break;
     case (CIRRUS_MMIO_BLTBGCOLOR + 1):
-	cirrus_vga_write_gr(s, 0x10, value);
-	break;
+        cirrus_vga_write_gr(s, 0x10, value);
+        break;
     case (CIRRUS_MMIO_BLTBGCOLOR + 2):
-	cirrus_vga_write_gr(s, 0x12, value);
-	break;
+        cirrus_vga_write_gr(s, 0x12, value);
+        break;
     case (CIRRUS_MMIO_BLTBGCOLOR + 3):
-	cirrus_vga_write_gr(s, 0x14, value);
-	break;
+        cirrus_vga_write_gr(s, 0x14, value);
+        break;
     case (CIRRUS_MMIO_BLTFGCOLOR + 0):
-	cirrus_vga_write_gr(s, 0x01, value);
-	break;
+        cirrus_vga_write_gr(s, 0x01, value);
+        break;
     case (CIRRUS_MMIO_BLTFGCOLOR + 1):
-	cirrus_vga_write_gr(s, 0x11, value);
-	break;
+        cirrus_vga_write_gr(s, 0x11, value);
+        break;
     case (CIRRUS_MMIO_BLTFGCOLOR + 2):
-	cirrus_vga_write_gr(s, 0x13, value);
-	break;
+        cirrus_vga_write_gr(s, 0x13, value);
+        break;
     case (CIRRUS_MMIO_BLTFGCOLOR + 3):
-	cirrus_vga_write_gr(s, 0x15, value);
-	break;
+        cirrus_vga_write_gr(s, 0x15, value);
+        break;
     case (CIRRUS_MMIO_BLTWIDTH + 0):
-	cirrus_vga_write_gr(s, 0x20, value);
-	break;
+        cirrus_vga_write_gr(s, 0x20, value);
+        break;
     case (CIRRUS_MMIO_BLTWIDTH + 1):
-	cirrus_vga_write_gr(s, 0x21, value);
-	break;
+        cirrus_vga_write_gr(s, 0x21, value);
+        break;
     case (CIRRUS_MMIO_BLTHEIGHT + 0):
-	cirrus_vga_write_gr(s, 0x22, value);
-	break;
+        cirrus_vga_write_gr(s, 0x22, value);
+        break;
     case (CIRRUS_MMIO_BLTHEIGHT + 1):
-	cirrus_vga_write_gr(s, 0x23, value);
-	break;
+        cirrus_vga_write_gr(s, 0x23, value);
+        break;
     case (CIRRUS_MMIO_BLTDESTPITCH + 0):
-	cirrus_vga_write_gr(s, 0x24, value);
-	break;
+        cirrus_vga_write_gr(s, 0x24, value);
+        break;
     case (CIRRUS_MMIO_BLTDESTPITCH + 1):
-	cirrus_vga_write_gr(s, 0x25, value);
-	break;
+        cirrus_vga_write_gr(s, 0x25, value);
+        break;
     case (CIRRUS_MMIO_BLTSRCPITCH + 0):
-	cirrus_vga_write_gr(s, 0x26, value);
-	break;
+        cirrus_vga_write_gr(s, 0x26, value);
+        break;
     case (CIRRUS_MMIO_BLTSRCPITCH + 1):
-	cirrus_vga_write_gr(s, 0x27, value);
-	break;
+        cirrus_vga_write_gr(s, 0x27, value);
+        break;
     case (CIRRUS_MMIO_BLTDESTADDR + 0):
-	cirrus_vga_write_gr(s, 0x28, value);
-	break;
+        cirrus_vga_write_gr(s, 0x28, value);
+        break;
     case (CIRRUS_MMIO_BLTDESTADDR + 1):
-	cirrus_vga_write_gr(s, 0x29, value);
-	break;
+        cirrus_vga_write_gr(s, 0x29, value);
+        break;
     case (CIRRUS_MMIO_BLTDESTADDR + 2):
-	cirrus_vga_write_gr(s, 0x2a, value);
-	break;
+        cirrus_vga_write_gr(s, 0x2a, value);
+        break;
     case (CIRRUS_MMIO_BLTDESTADDR + 3):
-	/* ignored */
-	break;
+        /* ignored */
+        break;
     case (CIRRUS_MMIO_BLTSRCADDR + 0):
-	cirrus_vga_write_gr(s, 0x2c, value);
-	break;
+        cirrus_vga_write_gr(s, 0x2c, value);
+        break;
     case (CIRRUS_MMIO_BLTSRCADDR + 1):
-	cirrus_vga_write_gr(s, 0x2d, value);
-	break;
+        cirrus_vga_write_gr(s, 0x2d, value);
+        break;
     case (CIRRUS_MMIO_BLTSRCADDR + 2):
-	cirrus_vga_write_gr(s, 0x2e, value);
-	break;
+        cirrus_vga_write_gr(s, 0x2e, value);
+        break;
     case CIRRUS_MMIO_BLTWRITEMASK:
-	cirrus_vga_write_gr(s, 0x2f, value);
-	break;
+        cirrus_vga_write_gr(s, 0x2f, value);
+        break;
     case CIRRUS_MMIO_BLTMODE:
-	cirrus_vga_write_gr(s, 0x30, value);
-	break;
+        cirrus_vga_write_gr(s, 0x30, value);
+        break;
     case CIRRUS_MMIO_BLTROP:
-	cirrus_vga_write_gr(s, 0x32, value);
-	break;
+        cirrus_vga_write_gr(s, 0x32, value);
+        break;
     case CIRRUS_MMIO_BLTMODEEXT:
-	cirrus_vga_write_gr(s, 0x33, value);
-	break;
+        cirrus_vga_write_gr(s, 0x33, value);
+        break;
     case (CIRRUS_MMIO_BLTTRANSPARENTCOLOR + 0):
-	cirrus_vga_write_gr(s, 0x34, value);
-	break;
+        cirrus_vga_write_gr(s, 0x34, value);
+        break;
     case (CIRRUS_MMIO_BLTTRANSPARENTCOLOR + 1):
-	cirrus_vga_write_gr(s, 0x35, value);
-	break;
+        cirrus_vga_write_gr(s, 0x35, value);
+        break;
     case (CIRRUS_MMIO_BLTTRANSPARENTCOLORMASK + 0):
-	cirrus_vga_write_gr(s, 0x38, value);
-	break;
+        cirrus_vga_write_gr(s, 0x38, value);
+        break;
     case (CIRRUS_MMIO_BLTTRANSPARENTCOLORMASK + 1):
-	cirrus_vga_write_gr(s, 0x39, value);
-	break;
+        cirrus_vga_write_gr(s, 0x39, value);
+        break;
     case CIRRUS_MMIO_BLTSTATUS:
-	cirrus_vga_write_gr(s, 0x31, value);
-	break;
+        cirrus_vga_write_gr(s, 0x31, value);
+        break;
     default:
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: mmio write - addr 0x%04x val 0x%02x (ignored)\n",
-	       address, value);
+        printf("cirrus: mmio write - addr 0x%04x val 0x%02x (ignored)\n",
+               address, value);
 #endif
-	break;
+        break;
     }
 }
 
@@ -2029,9 +2029,9 @@ static void cirrus_mmio_blt_write(CirrusVGAState * s, unsigned address,
  ***************************************/
 
 static void cirrus_mem_writeb_mode4and5_8bpp(CirrusVGAState * s,
-					     unsigned mode,
-					     unsigned offset,
-					     uint32_t mem_value)
+                                             unsigned mode,
+                                             unsigned offset,
+                                             uint32_t mem_value)
 {
     int x;
     unsigned val = mem_value;
@@ -2039,20 +2039,20 @@ static void cirrus_mem_writeb_mode4and5_8bpp(CirrusVGAState * s,
 
     for (x = 0; x < 8; x++) {
         dst = s->vga.vram_ptr + ((offset + x) & s->cirrus_addr_mask);
-	if (val & 0x80) {
-	    *dst = s->cirrus_shadow_gr1;
-	} else if (mode == 5) {
-	    *dst = s->cirrus_shadow_gr0;
-	}
-	val <<= 1;
+        if (val & 0x80) {
+            *dst = s->cirrus_shadow_gr1;
+        } else if (mode == 5) {
+            *dst = s->cirrus_shadow_gr0;
+        }
+        val <<= 1;
     }
     memory_region_set_dirty(&s->vga.vram, offset, 8);
 }
 
 static void cirrus_mem_writeb_mode4and5_16bpp(CirrusVGAState * s,
-					      unsigned mode,
-					      unsigned offset,
-					      uint32_t mem_value)
+                                              unsigned mode,
+                                              unsigned offset,
+                                              uint32_t mem_value)
 {
     int x;
     unsigned val = mem_value;
@@ -2060,14 +2060,14 @@ static void cirrus_mem_writeb_mode4and5_16bpp(CirrusVGAState * s,
 
     for (x = 0; x < 8; x++) {
         dst = s->vga.vram_ptr + ((offset + 2 * x) & s->cirrus_addr_mask & ~1);
-	if (val & 0x80) {
-	    *dst = s->cirrus_shadow_gr1;
-	    *(dst + 1) = s->vga.gr[0x11];
-	} else if (mode == 5) {
-	    *dst = s->cirrus_shadow_gr0;
-	    *(dst + 1) = s->vga.gr[0x10];
-	}
-	val <<= 1;
+        if (val & 0x80) {
+            *dst = s->cirrus_shadow_gr1;
+            *(dst + 1) = s->vga.gr[0x11];
+        } else if (mode == 5) {
+            *dst = s->cirrus_shadow_gr0;
+            *(dst + 1) = s->vga.gr[0x10];
+        }
+        val <<= 1;
     }
     memory_region_set_dirty(&s->vga.vram, offset, 16);
 }
@@ -2092,31 +2092,31 @@ static uint64_t cirrus_vga_mem_read(void *opaque,
     }
 
     if (addr < 0x10000) {
-	/* XXX handle bitblt */
-	/* video memory */
-	bank_index = addr >> 15;
-	bank_offset = addr & 0x7fff;
-	if (bank_offset < s->cirrus_bank_limit[bank_index]) {
-	    bank_offset += s->cirrus_bank_base[bank_index];
-	    if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
-		bank_offset <<= 4;
-	    } else if (s->vga.gr[0x0B] & 0x02) {
-		bank_offset <<= 3;
-	    }
-	    bank_offset &= s->cirrus_addr_mask;
-	    val = *(s->vga.vram_ptr + bank_offset);
-	} else
-	    val = 0xff;
+        /* XXX handle bitblt */
+        /* video memory */
+        bank_index = addr >> 15;
+        bank_offset = addr & 0x7fff;
+        if (bank_offset < s->cirrus_bank_limit[bank_index]) {
+            bank_offset += s->cirrus_bank_base[bank_index];
+            if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
+                bank_offset <<= 4;
+            } else if (s->vga.gr[0x0B] & 0x02) {
+                bank_offset <<= 3;
+            }
+            bank_offset &= s->cirrus_addr_mask;
+            val = *(s->vga.vram_ptr + bank_offset);
+        } else
+            val = 0xff;
     } else if (addr >= 0x18000 && addr < 0x18100) {
-	/* memory-mapped I/O */
-	val = 0xff;
-	if ((s->vga.sr[0x17] & 0x44) == 0x04) {
-	    val = cirrus_mmio_blt_read(s, addr & 0xff);
-	}
+        /* memory-mapped I/O */
+        val = 0xff;
+        if ((s->vga.sr[0x17] & 0x44) == 0x04) {
+            val = cirrus_mmio_blt_read(s, addr & 0xff);
+        }
     } else {
-	val = 0xff;
+        val = 0xff;
 #ifdef DEBUG_CIRRUS
-	printf("cirrus: mem_readb " TARGET_FMT_plx "\n", addr);
+        printf("cirrus: mem_readb " TARGET_FMT_plx "\n", addr);
 #endif
     }
     return val;
@@ -2138,47 +2138,47 @@ static void cirrus_vga_mem_write(void *opaque,
     }
 
     if (addr < 0x10000) {
-	if (s->cirrus_srcptr != s->cirrus_srcptr_end) {
-	    /* bitblt */
-	    *s->cirrus_srcptr++ = (uint8_t) mem_value;
-	    if (s->cirrus_srcptr >= s->cirrus_srcptr_end) {
-		cirrus_bitblt_cputovideo_next(s);
-	    }
-	} else {
-	    /* video memory */
-	    bank_index = addr >> 15;
-	    bank_offset = addr & 0x7fff;
-	    if (bank_offset < s->cirrus_bank_limit[bank_index]) {
-		bank_offset += s->cirrus_bank_base[bank_index];
-		if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
-		    bank_offset <<= 4;
-		} else if (s->vga.gr[0x0B] & 0x02) {
-		    bank_offset <<= 3;
-		}
-		bank_offset &= s->cirrus_addr_mask;
-		mode = s->vga.gr[0x05] & 0x7;
-		if (mode < 4 || mode > 5 || ((s->vga.gr[0x0B] & 0x4) == 0)) {
-		    *(s->vga.vram_ptr + bank_offset) = mem_value;
+        if (s->cirrus_srcptr != s->cirrus_srcptr_end) {
+            /* bitblt */
+            *s->cirrus_srcptr++ = (uint8_t) mem_value;
+            if (s->cirrus_srcptr >= s->cirrus_srcptr_end) {
+                cirrus_bitblt_cputovideo_next(s);
+            }
+        } else {
+            /* video memory */
+            bank_index = addr >> 15;
+            bank_offset = addr & 0x7fff;
+            if (bank_offset < s->cirrus_bank_limit[bank_index]) {
+                bank_offset += s->cirrus_bank_base[bank_index];
+                if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
+                    bank_offset <<= 4;
+                } else if (s->vga.gr[0x0B] & 0x02) {
+                    bank_offset <<= 3;
+                }
+                bank_offset &= s->cirrus_addr_mask;
+                mode = s->vga.gr[0x05] & 0x7;
+                if (mode < 4 || mode > 5 || ((s->vga.gr[0x0B] & 0x4) == 0)) {
+                    *(s->vga.vram_ptr + bank_offset) = mem_value;
                     memory_region_set_dirty(&s->vga.vram, bank_offset,
                                             sizeof(mem_value));
-		} else {
-		    if ((s->vga.gr[0x0B] & 0x14) != 0x14) {
-			cirrus_mem_writeb_mode4and5_8bpp(s, mode,
-							 bank_offset,
-							 mem_value);
-		    } else {
-			cirrus_mem_writeb_mode4and5_16bpp(s, mode,
-							  bank_offset,
-							  mem_value);
-		    }
-		}
-	    }
-	}
+                } else {
+                    if ((s->vga.gr[0x0B] & 0x14) != 0x14) {
+                        cirrus_mem_writeb_mode4and5_8bpp(s, mode,
+                                                         bank_offset,
+                                                         mem_value);
+                    } else {
+                        cirrus_mem_writeb_mode4and5_16bpp(s, mode,
+                                                          bank_offset,
+                                                          mem_value);
+                    }
+                }
+            }
+        }
     } else if (addr >= 0x18000 && addr < 0x18100) {
-	/* memory-mapped I/O */
-	if ((s->vga.sr[0x17] & 0x44) == 0x04) {
-	    cirrus_mmio_blt_write(s, addr & 0xff, mem_value);
-	}
+        /* memory-mapped I/O */
+        if ((s->vga.sr[0x17] & 0x44) == 0x04) {
+            cirrus_mmio_blt_write(s, addr & 0xff, mem_value);
+        }
     } else {
 #ifdef DEBUG_CIRRUS
         printf("cirrus: mem_writeb " TARGET_FMT_plx " value 0x%02" PRIu64 "\n", addr,
@@ -2404,20 +2404,20 @@ static uint64_t cirrus_linear_read(void *opaque, hwaddr addr,
 
     if (((s->vga.sr[0x17] & 0x44) == 0x44) &&
         ((addr & s->linear_mmio_mask) == s->linear_mmio_mask)) {
-	/* memory-mapped I/O */
-	ret = cirrus_mmio_blt_read(s, addr & 0xff);
+        /* memory-mapped I/O */
+        ret = cirrus_mmio_blt_read(s, addr & 0xff);
     } else if (0) {
-	/* XXX handle bitblt */
-	ret = 0xff;
+        /* XXX handle bitblt */
+        ret = 0xff;
     } else {
-	/* video memory */
-	if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
-	    addr <<= 4;
-	} else if (s->vga.gr[0x0B] & 0x02) {
-	    addr <<= 3;
-	}
-	addr &= s->cirrus_addr_mask;
-	ret = *(s->vga.vram_ptr + addr);
+        /* video memory */
+        if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
+            addr <<= 4;
+        } else if (s->vga.gr[0x0B] & 0x02) {
+            addr <<= 3;
+        }
+        addr &= s->cirrus_addr_mask;
+        ret = *(s->vga.vram_ptr + addr);
     }
 
     return ret;
@@ -2433,34 +2433,34 @@ static void cirrus_linear_write(void *opaque, hwaddr addr,
 
     if (((s->vga.sr[0x17] & 0x44) == 0x44) &&
         ((addr & s->linear_mmio_mask) ==  s->linear_mmio_mask)) {
-	/* memory-mapped I/O */
-	cirrus_mmio_blt_write(s, addr & 0xff, val);
+        /* memory-mapped I/O */
+        cirrus_mmio_blt_write(s, addr & 0xff, val);
     } else if (s->cirrus_srcptr != s->cirrus_srcptr_end) {
-	/* bitblt */
-	*s->cirrus_srcptr++ = (uint8_t) val;
-	if (s->cirrus_srcptr >= s->cirrus_srcptr_end) {
-	    cirrus_bitblt_cputovideo_next(s);
-	}
+        /* bitblt */
+        *s->cirrus_srcptr++ = (uint8_t) val;
+        if (s->cirrus_srcptr >= s->cirrus_srcptr_end) {
+            cirrus_bitblt_cputovideo_next(s);
+        }
     } else {
-	/* video memory */
-	if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
-	    addr <<= 4;
-	} else if (s->vga.gr[0x0B] & 0x02) {
-	    addr <<= 3;
-	}
-	addr &= s->cirrus_addr_mask;
-
-	mode = s->vga.gr[0x05] & 0x7;
-	if (mode < 4 || mode > 5 || ((s->vga.gr[0x0B] & 0x4) == 0)) {
-	    *(s->vga.vram_ptr + addr) = (uint8_t) val;
+        /* video memory */
+        if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
+            addr <<= 4;
+        } else if (s->vga.gr[0x0B] & 0x02) {
+            addr <<= 3;
+        }
+        addr &= s->cirrus_addr_mask;
+
+        mode = s->vga.gr[0x05] & 0x7;
+        if (mode < 4 || mode > 5 || ((s->vga.gr[0x0B] & 0x4) == 0)) {
+            *(s->vga.vram_ptr + addr) = (uint8_t) val;
             memory_region_set_dirty(&s->vga.vram, addr, 1);
-	} else {
-	    if ((s->vga.gr[0x0B] & 0x14) != 0x14) {
-		cirrus_mem_writeb_mode4and5_8bpp(s, mode, addr, val);
-	    } else {
-		cirrus_mem_writeb_mode4and5_16bpp(s, mode, addr, val);
-	    }
-	}
+        } else {
+            if ((s->vga.gr[0x0B] & 0x14) != 0x14) {
+                cirrus_mem_writeb_mode4and5_8bpp(s, mode, addr, val);
+            } else {
+                cirrus_mem_writeb_mode4and5_16bpp(s, mode, addr, val);
+            }
+        }
     }
 }
 
@@ -2492,11 +2492,11 @@ static void cirrus_linear_bitblt_write(void *opaque,
     CirrusVGAState *s = opaque;
 
     if (s->cirrus_srcptr != s->cirrus_srcptr_end) {
-	/* bitblt */
-	*s->cirrus_srcptr++ = (uint8_t) val;
-	if (s->cirrus_srcptr >= s->cirrus_srcptr_end) {
-	    cirrus_bitblt_cputovideo_next(s);
-	}
+        /* bitblt */
+        *s->cirrus_srcptr++ = (uint8_t) val;
+        if (s->cirrus_srcptr >= s->cirrus_srcptr_end) {
+            cirrus_bitblt_cputovideo_next(s);
+        }
     }
 }
 
@@ -2553,14 +2553,14 @@ static void cirrus_update_memory_access(CirrusVGAState *s)
     } else if (s->cirrus_srcptr != s->cirrus_srcptr_end) {
         goto generic_io;
     } else {
-	if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
+        if ((s->vga.gr[0x0B] & 0x14) == 0x14) {
             goto generic_io;
-	} else if (s->vga.gr[0x0B] & 0x02) {
+        } else if (s->vga.gr[0x0B] & 0x02) {
             goto generic_io;
         }
 
-	mode = s->vga.gr[0x05] & 0x7;
-	if (mode < 4 || mode > 5 || ((s->vga.gr[0x0B] & 0x4) == 0)) {
+        mode = s->vga.gr[0x05] & 0x7;
+        if (mode < 4 || mode > 5 || ((s->vga.gr[0x0B] & 0x4) == 0)) {
             map_linear_vram(s);
         } else {
         generic_io:
@@ -2583,85 +2583,85 @@ static uint64_t cirrus_vga_ioport_read(void *opaque, hwaddr addr,
     addr += 0x3b0;
 
     if (vga_ioport_invalid(s, addr)) {
-	val = 0xff;
+        val = 0xff;
     } else {
-	switch (addr) {
-	case 0x3c0:
-	    if (s->ar_flip_flop == 0) {
-		val = s->ar_index;
-	    } else {
-		val = 0;
-	    }
-	    break;
-	case 0x3c1:
-	    index = s->ar_index & 0x1f;
-	    if (index < 21)
-		val = s->ar[index];
-	    else
-		val = 0;
-	    break;
-	case 0x3c2:
-	    val = s->st00;
-	    break;
-	case 0x3c4:
-	    val = s->sr_index;
-	    break;
-	case 0x3c5:
-	    val = cirrus_vga_read_sr(c);
+        switch (addr) {
+        case 0x3c0:
+            if (s->ar_flip_flop == 0) {
+                val = s->ar_index;
+            } else {
+                val = 0;
+            }
+            break;
+        case 0x3c1:
+            index = s->ar_index & 0x1f;
+            if (index < 21)
+                val = s->ar[index];
+            else
+                val = 0;
+            break;
+        case 0x3c2:
+            val = s->st00;
+            break;
+        case 0x3c4:
+            val = s->sr_index;
+            break;
+        case 0x3c5:
+            val = cirrus_vga_read_sr(c);
             break;
 #ifdef DEBUG_VGA_REG
-	    printf("vga: read SR%x = 0x%02x\n", s->sr_index, val);
+            printf("vga: read SR%x = 0x%02x\n", s->sr_index, val);
 #endif
-	    break;
-	case 0x3c6:
-	    val = cirrus_read_hidden_dac(c);
-	    break;
-	case 0x3c7:
-	    val = s->dac_state;
-	    break;
-	case 0x3c8:
-	    val = s->dac_write_index;
-	    c->cirrus_hidden_dac_lockindex = 0;
-	    break;
+            break;
+        case 0x3c6:
+            val = cirrus_read_hidden_dac(c);
+            break;
+        case 0x3c7:
+            val = s->dac_state;
+            break;
+        case 0x3c8:
+            val = s->dac_write_index;
+            c->cirrus_hidden_dac_lockindex = 0;
+            break;
         case 0x3c9:
             val = cirrus_vga_read_palette(c);
             break;
-	case 0x3ca:
-	    val = s->fcr;
-	    break;
-	case 0x3cc:
-	    val = s->msr;
-	    break;
-	case 0x3ce:
-	    val = s->gr_index;
-	    break;
-	case 0x3cf:
-	    val = cirrus_vga_read_gr(c, s->gr_index);
+        case 0x3ca:
+            val = s->fcr;
+            break;
+        case 0x3cc:
+            val = s->msr;
+            break;
+        case 0x3ce:
+            val = s->gr_index;
+            break;
+        case 0x3cf:
+            val = cirrus_vga_read_gr(c, s->gr_index);
 #ifdef DEBUG_VGA_REG
-	    printf("vga: read GR%x = 0x%02x\n", s->gr_index, val);
+            printf("vga: read GR%x = 0x%02x\n", s->gr_index, val);
 #endif
-	    break;
-	case 0x3b4:
-	case 0x3d4:
-	    val = s->cr_index;
-	    break;
-	case 0x3b5:
-	case 0x3d5:
+            break;
+        case 0x3b4:
+        case 0x3d4:
+            val = s->cr_index;
+            break;
+        case 0x3b5:
+        case 0x3d5:
             val = cirrus_vga_read_cr(c, s->cr_index);
 #ifdef DEBUG_VGA_REG
-	    printf("vga: read CR%x = 0x%02x\n", s->cr_index, val);
+            printf("vga: read CR%x = 0x%02x\n", s->cr_index, val);
 #endif
-	    break;
-	case 0x3ba:
-	case 0x3da:
-	    /* just toggle to fool polling */
-	    val = s->st01 = s->retrace(s);
-	    s->ar_flip_flop = 0;
-	    break;
-	default:
-	    val = 0x00;
-	    break;
-	}
+            break;
+        case 0x3ba:
+        case 0x3da:
+            /* just toggle to fool polling */
+            val = s->st01 = s->retrace(s);
+            s->ar_flip_flop = 0;
+            break;
+        default:
+            val = 0x00;
+            break;
+        }
     }
     trace_vga_cirrus_read_io(addr, val);
     return val;
@@ -2678,95 +2678,95 @@ static void cirrus_vga_ioport_write(void *opaque, hwaddr addr, uint64_t val,
 
     /* check port range access depending on color/monochrome mode */
     if (vga_ioport_invalid(s, addr)) {
-	return;
+        return;
     }
     trace_vga_cirrus_write_io(addr, val);
 
     switch (addr) {
     case 0x3c0:
-	if (s->ar_flip_flop == 0) {
-	    val &= 0x3f;
-	    s->ar_index = val;
-	} else {
-	    index = s->ar_index & 0x1f;
-	    switch (index) {
-	    case 0x00 ... 0x0f:
-		s->ar[index] = val & 0x3f;
-		break;
-	    case 0x10:
-		s->ar[index] = val & ~0x10;
-		break;
-	    case 0x11:
-		s->ar[index] = val;
-		break;
-	    case 0x12:
-		s->ar[index] = val & ~0xc0;
-		break;
-	    case 0x13:
-		s->ar[index] = val & ~0xf0;
-		break;
-	    case 0x14:
-		s->ar[index] = val & ~0xf0;
-		break;
-	    default:
-		break;
-	    }
-	}
-	s->ar_flip_flop ^= 1;
-	break;
+        if (s->ar_flip_flop == 0) {
+            val &= 0x3f;
+            s->ar_index = val;
+        } else {
+            index = s->ar_index & 0x1f;
+            switch (index) {
+            case 0x00 ... 0x0f:
+                s->ar[index] = val & 0x3f;
+                break;
+            case 0x10:
+                s->ar[index] = val & ~0x10;
+                break;
+            case 0x11:
+                s->ar[index] = val;
+                break;
+            case 0x12:
+                s->ar[index] = val & ~0xc0;
+                break;
+            case 0x13:
+                s->ar[index] = val & ~0xf0;
+                break;
+            case 0x14:
+                s->ar[index] = val & ~0xf0;
+                break;
+            default:
+                break;
+            }
+        }
+        s->ar_flip_flop ^= 1;
+        break;
     case 0x3c2:
-	s->msr = val & ~0x10;
-	s->update_retrace_info(s);
-	break;
+        s->msr = val & ~0x10;
+        s->update_retrace_info(s);
+        break;
     case 0x3c4:
-	s->sr_index = val;
-	break;
+        s->sr_index = val;
+        break;
     case 0x3c5:
 #ifdef DEBUG_VGA_REG
-	printf("vga: write SR%x = 0x%02" PRIu64 "\n", s->sr_index, val);
+        printf("vga: write SR%x = 0x%02" PRIu64 "\n", s->sr_index, val);
 #endif
-	cirrus_vga_write_sr(c, val);
+        cirrus_vga_write_sr(c, val);
         break;
     case 0x3c6:
-	cirrus_write_hidden_dac(c, val);
-	break;
+        cirrus_write_hidden_dac(c, val);
+        break;
     case 0x3c7:
-	s->dac_read_index = val;
-	s->dac_sub_index = 0;
-	s->dac_state = 3;
-	break;
+        s->dac_read_index = val;
+        s->dac_sub_index = 0;
+        s->dac_state = 3;
+        break;
     case 0x3c8:
-	s->dac_write_index = val;
-	s->dac_sub_index = 0;
-	s->dac_state = 0;
-	break;
+        s->dac_write_index = val;
+        s->dac_sub_index = 0;
+        s->dac_state = 0;
+        break;
     case 0x3c9:
         cirrus_vga_write_palette(c, val);
         break;
     case 0x3ce:
-	s->gr_index = val;
-	break;
+        s->gr_index = val;
+        break;
     case 0x3cf:
 #ifdef DEBUG_VGA_REG
-	printf("vga: write GR%x = 0x%02" PRIu64 "\n", s->gr_index, val);
+        printf("vga: write GR%x = 0x%02" PRIu64 "\n", s->gr_index, val);
 #endif
-	cirrus_vga_write_gr(c, s->gr_index, val);
-	break;
+        cirrus_vga_write_gr(c, s->gr_index, val);
+        break;
     case 0x3b4:
     case 0x3d4:
-	s->cr_index = val;
-	break;
+        s->cr_index = val;
+        break;
     case 0x3b5:
     case 0x3d5:
 #ifdef DEBUG_VGA_REG
-	printf("vga: write CR%x = 0x%02"PRIu64"\n", s->cr_index, val);
+        printf("vga: write CR%x = 0x%02"PRIu64"\n", s->cr_index, val);
 #endif
-	cirrus_vga_write_cr(c, val);
-	break;
+        cirrus_vga_write_cr(c, val);
+        break;
     case 0x3ba:
     case 0x3da:
-	s->fcr = val & 0x10;
-	break;
+        s->fcr = val & 0x10;
+        break;
     }
 }
 
@@ -2794,7 +2794,7 @@ static void cirrus_mmio_write(void *opaque, hwaddr addr,
     CirrusVGAState *s = opaque;
 
     if (addr >= 0x100) {
-	cirrus_mmio_blt_write(s, addr - 0x100, val);
+        cirrus_mmio_blt_write(s, addr - 0x100, val);
     } else {
         cirrus_vga_ioport_write(s, addr + 0x10, val, size);
     }
@@ -2893,13 +2893,13 @@ static void cirrus_reset(void *opaque)
     s->vga.sr[0x06] = 0x0f;
     if (s->device_id == CIRRUS_ID_CLGD5446) {
         /* 4MB 64 bit memory config, always PCI */
-        s->vga.sr[0x1F] = 0x2d;		// MemClock
+        s->vga.sr[0x1F] = 0x2d;                // MemClock
         s->vga.gr[0x18] = 0x0f;             // fastest memory configuration
         s->vga.sr[0x0f] = 0x98;
         s->vga.sr[0x17] = 0x20;
         s->vga.sr[0x15] = 0x04; /* memory size, 3=2MB, 4=4MB */
     } else {
-        s->vga.sr[0x1F] = 0x22;		// MemClock
+        s->vga.sr[0x1F] = 0x22;                // MemClock
         s->vga.sr[0x0F] = CIRRUS_MEMSIZE_2M;
         s->vga.sr[0x17] = s->bustype;
         s->vga.sr[0x15] = 0x03; /* memory size, 3=2MB, 4=4MB */
-- 
2.7.4
