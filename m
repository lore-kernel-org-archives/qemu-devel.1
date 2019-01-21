Received: from eggs.gnu.org ([209.51.188.92]:52117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyy-0005Ae-LN
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyr-0004so-4q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:33 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldye-0004eV-Kp
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id q18so24435217wrx.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:07:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.07.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:07:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:15 +0100
Message-Id: <1548093980-43088-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/49] ui: vnc: finish removing TABs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/vnc-enc-hextile-template.h | 268 ++++++++++++++--------------
 ui/vnc-enc-zywrle.h           | 394 +++++++++++++++++++++---------------------
 2 files changed, 331 insertions(+), 331 deletions(-)

diff --git a/ui/vnc-enc-hextile-template.h b/ui/vnc-enc-hextile-template.h
index d868d75..0c56262 100644
--- a/ui/vnc-enc-hextile-template.h
+++ b/ui/vnc-enc-hextile-template.h
@@ -30,127 +30,127 @@ static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
     int n_subtiles = 0;
 
     for (j = 0; j < h; j++) {
-	for (i = 0; i < w; i++) {
-	    switch (n_colors) {
-	    case 0:
-		bg = irow[i];
-		n_colors = 1;
-		break;
-	    case 1:
-		if (irow[i] != bg) {
-		    fg = irow[i];
-		    n_colors = 2;
-		}
-		break;
-	    case 2:
-		if (irow[i] != bg && irow[i] != fg) {
-		    n_colors = 3;
-		} else {
-		    if (irow[i] == bg)
-			bg_count++;
-		    else if (irow[i] == fg)
-			fg_count++;
-		}
-		break;
-	    default:
-		break;
-	    }
-	}
-	if (n_colors > 2)
-	    break;
-	irow += vnc_server_fb_stride(vd) / sizeof(pixel_t);
+        for (i = 0; i < w; i++) {
+            switch (n_colors) {
+            case 0:
+                bg = irow[i];
+                n_colors = 1;
+                break;
+            case 1:
+                if (irow[i] != bg) {
+                    fg = irow[i];
+                    n_colors = 2;
+                }
+                break;
+            case 2:
+                if (irow[i] != bg && irow[i] != fg) {
+                    n_colors = 3;
+                } else {
+                    if (irow[i] == bg)
+                        bg_count++;
+                    else if (irow[i] == fg)
+                        fg_count++;
+                }
+                break;
+            default:
+                break;
+            }
+        }
+        if (n_colors > 2)
+            break;
+        irow += vnc_server_fb_stride(vd) / sizeof(pixel_t);
     }
 
     if (n_colors > 1 && fg_count > bg_count) {
-	pixel_t tmp = fg;
-	fg = bg;
-	bg = tmp;
+        pixel_t tmp = fg;
+        fg = bg;
+        bg = tmp;
     }
 
     if (!*has_bg || *last_bg != bg) {
-	flags |= 0x02;
-	*has_bg = 1;
-	*last_bg = bg;
+        flags |= 0x02;
+        *has_bg = 1;
+        *last_bg = bg;
     }
 
     if (n_colors < 3 && (!*has_fg || *last_fg != fg)) {
-	flags |= 0x04;
-	*has_fg = 1;
-	*last_fg = fg;
+        flags |= 0x04;
+        *has_fg = 1;
+        *last_fg = fg;
     }
 
     switch (n_colors) {
     case 1:
-	n_data = 0;
-	break;
+        n_data = 0;
+        break;
     case 2:
-	flags |= 0x08;
-
-	irow = (pixel_t *)row;
-
-	for (j = 0; j < h; j++) {
-	    int min_x = -1;
-	    for (i = 0; i < w; i++) {
-		if (irow[i] == fg) {
-		    if (min_x == -1)
-			min_x = i;
-		} else if (min_x != -1) {
-		    hextile_enc_cord(data + n_data, min_x, j, i - min_x, 1);
-		    n_data += 2;
-		    n_subtiles++;
-		    min_x = -1;
-		}
-	    }
-	    if (min_x != -1) {
-		hextile_enc_cord(data + n_data, min_x, j, i - min_x, 1);
-		n_data += 2;
-		n_subtiles++;
-	    }
-	    irow += vnc_server_fb_stride(vd) / sizeof(pixel_t);
-	}
-	break;
+        flags |= 0x08;
+
+        irow = (pixel_t *)row;
+
+        for (j = 0; j < h; j++) {
+            int min_x = -1;
+            for (i = 0; i < w; i++) {
+                if (irow[i] == fg) {
+                    if (min_x == -1)
+                        min_x = i;
+                } else if (min_x != -1) {
+                    hextile_enc_cord(data + n_data, min_x, j, i - min_x, 1);
+                    n_data += 2;
+                    n_subtiles++;
+                    min_x = -1;
+                }
+            }
+            if (min_x != -1) {
+                hextile_enc_cord(data + n_data, min_x, j, i - min_x, 1);
+                n_data += 2;
+                n_subtiles++;
+            }
+            irow += vnc_server_fb_stride(vd) / sizeof(pixel_t);
+        }
+        break;
     case 3:
-	flags |= 0x18;
-
-	irow = (pixel_t *)row;
-
-	if (!*has_bg || *last_bg != bg)
-	    flags |= 0x02;
-
-	for (j = 0; j < h; j++) {
-	    int has_color = 0;
-	    int min_x = -1;
-	    pixel_t color = 0; /* shut up gcc */
-
-	    for (i = 0; i < w; i++) {
-		if (!has_color) {
-		    if (irow[i] == bg)
-			continue;
-		    color = irow[i];
-		    min_x = i;
-		    has_color = 1;
-		} else if (irow[i] != color) {
-		    has_color = 0;
+        flags |= 0x18;
+
+        irow = (pixel_t *)row;
+
+        if (!*has_bg || *last_bg != bg)
+            flags |= 0x02;
+
+        for (j = 0; j < h; j++) {
+            int has_color = 0;
+            int min_x = -1;
+            pixel_t color = 0; /* shut up gcc */
+
+            for (i = 0; i < w; i++) {
+                if (!has_color) {
+                    if (irow[i] == bg)
+                        continue;
+                    color = irow[i];
+                    min_x = i;
+                    has_color = 1;
+                } else if (irow[i] != color) {
+                    has_color = 0;
 #ifdef GENERIC
                     vnc_convert_pixel(vs, data + n_data, color);
                     n_data += vs->client_pf.bytes_per_pixel;
 #else
-		    memcpy(data + n_data, &color, sizeof(color));
+                    memcpy(data + n_data, &color, sizeof(color));
                     n_data += sizeof(pixel_t);
 #endif
-		    hextile_enc_cord(data + n_data, min_x, j, i - min_x, 1);
-		    n_data += 2;
-		    n_subtiles++;
-
-		    min_x = -1;
-		    if (irow[i] != bg) {
-			color = irow[i];
-			min_x = i;
-			has_color = 1;
-		    }
-		}
-	    }
-	    if (has_color) {
+                    hextile_enc_cord(data + n_data, min_x, j, i - min_x, 1);
+                    n_data += 2;
+                    n_subtiles++;
+
+                    min_x = -1;
+                    if (irow[i] != bg) {
+                        color = irow[i];
+                        min_x = i;
+                        has_color = 1;
+                    }
+                }
+            }
+            if (has_color) {
 #ifdef GENERIC
                 vnc_convert_pixel(vs, data + n_data, color);
                 n_data += vs->client_pf.bytes_per_pixel;
@@ -158,50 +158,50 @@ static void CONCAT(send_hextile_tile_, NAME)(VncState *vs,
                 memcpy(data + n_data, &color, sizeof(color));
                 n_data += sizeof(pixel_t);
 #endif
-		hextile_enc_cord(data + n_data, min_x, j, i - min_x, 1);
-		n_data += 2;
-		n_subtiles++;
-	    }
-	    irow += vnc_server_fb_stride(vd) / sizeof(pixel_t);
-	}
-
-	/* A SubrectsColoured subtile invalidates the foreground color */
-	*has_fg = 0;
-	if (n_data > (w * h * sizeof(pixel_t))) {
-	    n_colors = 4;
-	    flags = 0x01;
-	    *has_bg = 0;
-
-	    /* we really don't have to invalidate either the bg or fg
-	       but we've lost the old values.  oh well. */
-	}
+                hextile_enc_cord(data + n_data, min_x, j, i - min_x, 1);
+                n_data += 2;
+                n_subtiles++;
+            }
+            irow += vnc_server_fb_stride(vd) / sizeof(pixel_t);
+        }
+
+        /* A SubrectsColoured subtile invalidates the foreground color */
+        *has_fg = 0;
+        if (n_data > (w * h * sizeof(pixel_t))) {
+            n_colors = 4;
+            flags = 0x01;
+            *has_bg = 0;
+
+            /* we really don't have to invalidate either the bg or fg
+               but we've lost the old values.  oh well. */
+        }
         break;
     default:
-	break;
+        break;
     }
 
     if (n_colors > 3) {
-	flags = 0x01;
-	*has_fg = 0;
-	*has_bg = 0;
-	n_colors = 4;
+        flags = 0x01;
+        *has_fg = 0;
+        *has_bg = 0;
+        n_colors = 4;
     }
 
     vnc_write_u8(vs, flags);
     if (n_colors < 4) {
-	if (flags & 0x02)
-	    vs->write_pixels(vs, last_bg, sizeof(pixel_t));
-	if (flags & 0x04)
-	    vs->write_pixels(vs, last_fg, sizeof(pixel_t));
-	if (n_subtiles) {
-	    vnc_write_u8(vs, n_subtiles);
-	    vnc_write(vs, data, n_data);
-	}
+        if (flags & 0x02)
+            vs->write_pixels(vs, last_bg, sizeof(pixel_t));
+        if (flags & 0x04)
+            vs->write_pixels(vs, last_fg, sizeof(pixel_t));
+        if (n_subtiles) {
+            vnc_write_u8(vs, n_subtiles);
+            vnc_write(vs, data, n_data);
+        }
     } else {
-	for (j = 0; j < h; j++) {
-	    vs->write_pixels(vs, row, w * 4);
-	    row += vnc_server_fb_stride(vd);
-	}
+        for (j = 0; j < h; j++) {
+            vs->write_pixels(vs, row, w * 4);
+            row += vnc_server_fb_stride(vd);
+        }
     }
 }
 
diff --git a/ui/vnc-enc-zywrle.h b/ui/vnc-enc-zywrle.h
index 610bd79..9b7f698 100644
--- a/ui/vnc-enc-zywrle.h
+++ b/ui/vnc-enc-zywrle.h
@@ -48,162 +48,162 @@ OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #ifndef ZYWRLE_QUANTIZE
 /* Type A:lower bit omitting of EZW style. */
 static const unsigned int zywrle_param[3][3]={
-	{0x0000F000, 0x00000000, 0x00000000},
-	{0x0000C000, 0x00F0F0F0, 0x00000000},
-	{0x0000C000, 0x00C0C0C0, 0x00F0F0F0},
+        {0x0000F000, 0x00000000, 0x00000000},
+        {0x0000C000, 0x00F0F0F0, 0x00000000},
+        {0x0000C000, 0x00C0C0C0, 0x00F0F0F0},
 /*	{0x0000FF00, 0x00000000, 0x00000000},
-	{0x0000FF00, 0x00FFFFFF, 0x00000000},
-	{0x0000FF00, 0x00FFFFFF, 0x00FFFFFF}, */
+        {0x0000FF00, 0x00FFFFFF, 0x00000000},
+        {0x0000FF00, 0x00FFFFFF, 0x00FFFFFF}, */
 };
 #else
 /* Type B:Non liner quantization filter. */
 static const int8_t zywrle_conv[4][256]={
 {	/* bi=5, bo=5 r=0.0:PSNR=24.849 */
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
 },
 {	/* bi=5, bo=5 r=2.0:PSNR=74.031 */
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 32,
-	32, 32, 32, 32, 32, 32, 32, 32,
-	32, 32, 32, 32, 32, 32, 32, 32,
-	48, 48, 48, 48, 48, 48, 48, 48,
-	48, 48, 48, 56, 56, 56, 56, 56,
-	56, 56, 56, 56, 64, 64, 64, 64,
-	64, 64, 64, 64, 72, 72, 72, 72,
-	72, 72, 72, 72, 80, 80, 80, 80,
-	80, 80, 88, 88, 88, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 96, 96,
-	96, 96, 96, 104, 104, 104, 104, 104,
-	104, 104, 104, 104, 104, 112, 112, 112,
-	112, 112, 112, 112, 112, 112, 120, 120,
-	120, 120, 120, 120, 120, 120, 120, 120,
-	0, -120, -120, -120, -120, -120, -120, -120,
-	-120, -120, -120, -112, -112, -112, -112, -112,
-	-112, -112, -112, -112, -104, -104, -104, -104,
-	-104, -104, -104, -104, -104, -104, -96, -96,
-	-96, -96, -96, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -88, -88, -88, -80,
-	-80, -80, -80, -80, -80, -72, -72, -72,
-	-72, -72, -72, -72, -72, -64, -64, -64,
-	-64, -64, -64, -64, -64, -56, -56, -56,
-	-56, -56, -56, -56, -56, -56, -48, -48,
-	-48, -48, -48, -48, -48, -48, -48, -48,
-	-48, -32, -32, -32, -32, -32, -32, -32,
-	-32, -32, -32, -32, -32, -32, -32, -32,
-	-32, -32, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 32,
+        32, 32, 32, 32, 32, 32, 32, 32,
+        32, 32, 32, 32, 32, 32, 32, 32,
+        48, 48, 48, 48, 48, 48, 48, 48,
+        48, 48, 48, 56, 56, 56, 56, 56,
+        56, 56, 56, 56, 64, 64, 64, 64,
+        64, 64, 64, 64, 72, 72, 72, 72,
+        72, 72, 72, 72, 80, 80, 80, 80,
+        80, 80, 88, 88, 88, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 96, 96,
+        96, 96, 96, 104, 104, 104, 104, 104,
+        104, 104, 104, 104, 104, 112, 112, 112,
+        112, 112, 112, 112, 112, 112, 120, 120,
+        120, 120, 120, 120, 120, 120, 120, 120,
+        0, -120, -120, -120, -120, -120, -120, -120,
+        -120, -120, -120, -112, -112, -112, -112, -112,
+        -112, -112, -112, -112, -104, -104, -104, -104,
+        -104, -104, -104, -104, -104, -104, -96, -96,
+        -96, -96, -96, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -88, -88, -88, -80,
+        -80, -80, -80, -80, -80, -72, -72, -72,
+        -72, -72, -72, -72, -72, -64, -64, -64,
+        -64, -64, -64, -64, -64, -56, -56, -56,
+        -56, -56, -56, -56, -56, -56, -48, -48,
+        -48, -48, -48, -48, -48, -48, -48, -48,
+        -48, -32, -32, -32, -32, -32, -32, -32,
+        -32, -32, -32, -32, -32, -32, -32, -32,
+        -32, -32, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
 },
 {	/* bi=5, bo=4 r=2.0:PSNR=64.441 */
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	48, 48, 48, 48, 48, 48, 48, 48,
-	48, 48, 48, 48, 48, 48, 48, 48,
-	48, 48, 48, 48, 48, 48, 48, 48,
-	64, 64, 64, 64, 64, 64, 64, 64,
-	64, 64, 64, 64, 64, 64, 64, 64,
-	80, 80, 80, 80, 80, 80, 80, 80,
-	80, 80, 80, 80, 80, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	104, 104, 104, 104, 104, 104, 104, 104,
-	104, 104, 104, 112, 112, 112, 112, 112,
-	112, 112, 112, 112, 120, 120, 120, 120,
-	120, 120, 120, 120, 120, 120, 120, 120,
-	0, -120, -120, -120, -120, -120, -120, -120,
-	-120, -120, -120, -120, -120, -112, -112, -112,
-	-112, -112, -112, -112, -112, -112, -104, -104,
-	-104, -104, -104, -104, -104, -104, -104, -104,
-	-104, -88, -88, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -80, -80, -80, -80,
-	-80, -80, -80, -80, -80, -80, -80, -80,
-	-80, -64, -64, -64, -64, -64, -64, -64,
-	-64, -64, -64, -64, -64, -64, -64, -64,
-	-64, -48, -48, -48, -48, -48, -48, -48,
-	-48, -48, -48, -48, -48, -48, -48, -48,
-	-48, -48, -48, -48, -48, -48, -48, -48,
-	-48, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        48, 48, 48, 48, 48, 48, 48, 48,
+        48, 48, 48, 48, 48, 48, 48, 48,
+        48, 48, 48, 48, 48, 48, 48, 48,
+        64, 64, 64, 64, 64, 64, 64, 64,
+        64, 64, 64, 64, 64, 64, 64, 64,
+        80, 80, 80, 80, 80, 80, 80, 80,
+        80, 80, 80, 80, 80, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        104, 104, 104, 104, 104, 104, 104, 104,
+        104, 104, 104, 112, 112, 112, 112, 112,
+        112, 112, 112, 112, 120, 120, 120, 120,
+        120, 120, 120, 120, 120, 120, 120, 120,
+        0, -120, -120, -120, -120, -120, -120, -120,
+        -120, -120, -120, -120, -120, -112, -112, -112,
+        -112, -112, -112, -112, -112, -112, -104, -104,
+        -104, -104, -104, -104, -104, -104, -104, -104,
+        -104, -88, -88, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -80, -80, -80, -80,
+        -80, -80, -80, -80, -80, -80, -80, -80,
+        -80, -64, -64, -64, -64, -64, -64, -64,
+        -64, -64, -64, -64, -64, -64, -64, -64,
+        -64, -48, -48, -48, -48, -48, -48, -48,
+        -48, -48, -48, -48, -48, -48, -48, -48,
+        -48, -48, -48, -48, -48, -48, -48, -48,
+        -48, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
 },
 {	/* bi=5, bo=2 r=2.0:PSNR=43.175 */
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	88, 88, 88, 88, 88, 88, 88, 88,
-	0, -88, -88, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -88, -88, -88, -88,
-	-88, -88, -88, -88, -88, -88, -88, -88,
-	-88, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        88, 88, 88, 88, 88, 88, 88, 88,
+        0, -88, -88, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -88, -88, -88, -88,
+        -88, -88, -88, -88, -88, -88, -88, -88,
+        -88, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
+        0, 0, 0, 0, 0, 0, 0, 0,
 }
 };
 
 static const int8_t *zywrle_param[3][3][3]={
-	{{zywrle_conv[0], zywrle_conv[2], zywrle_conv[0]},
+        {{zywrle_conv[0], zywrle_conv[2], zywrle_conv[0]},
          {zywrle_conv[0], zywrle_conv[0], zywrle_conv[0]},
          {zywrle_conv[0], zywrle_conv[0], zywrle_conv[0]}},
-	{{zywrle_conv[0], zywrle_conv[3], zywrle_conv[0]},
+        {{zywrle_conv[0], zywrle_conv[3], zywrle_conv[0]},
          {zywrle_conv[1], zywrle_conv[1], zywrle_conv[1]},
          {zywrle_conv[0], zywrle_conv[0], zywrle_conv[0]}},
-	{{zywrle_conv[0], zywrle_conv[3], zywrle_conv[0]},
+        {{zywrle_conv[0], zywrle_conv[3], zywrle_conv[0]},
          {zywrle_conv[2], zywrle_conv[2], zywrle_conv[2]},
          {zywrle_conv[1], zywrle_conv[1], zywrle_conv[1]}},
 };
@@ -214,53 +214,53 @@ static const int8_t *zywrle_param[3][3][3]={
 #define ZYWRLE_UVMASK15 0xFFFFFFF8
 #define ZYWRLE_LOAD_PIXEL15(src, r, g, b)                               \
     do {                                                                \
-	r = (((uint8_t*)src)[S_1]<< 1)& 0xF8;                           \
-	g = (((uint8_t*)src)[S_1]<< 6) | (((uint8_t*)src)[S_0]>> 2);    \
+        r = (((uint8_t*)src)[S_1]<< 1)& 0xF8;                           \
+        g = (((uint8_t*)src)[S_1]<< 6) | (((uint8_t*)src)[S_0]>> 2);    \
         g &= 0xF8;                                                      \
-	b =  (((uint8_t*)src)[S_0]<< 3)& 0xF8;                          \
+        b =  (((uint8_t*)src)[S_0]<< 3)& 0xF8;                          \
     } while (0)
 
 #define ZYWRLE_SAVE_PIXEL15(dst, r, g, b)                               \
     do {                                                                \
-	r &= 0xF8;                                                      \
-	g &= 0xF8;                                                      \
-	b &= 0xF8;                                                      \
-	((uint8_t*)dst)[S_1] = (uint8_t)((r >> 1)|(g >> 6));            \
-	((uint8_t*)dst)[S_0] = (uint8_t)(((b >> 3)|(g << 2))& 0xFF);    \
+        r &= 0xF8;                                                      \
+        g &= 0xF8;                                                      \
+        b &= 0xF8;                                                      \
+        ((uint8_t*)dst)[S_1] = (uint8_t)((r >> 1)|(g >> 6));            \
+        ((uint8_t*)dst)[S_0] = (uint8_t)(((b >> 3)|(g << 2))& 0xFF);    \
     } while (0)
 
 #define ZYWRLE_YMASK16  0xFFFFFFFC
 #define ZYWRLE_UVMASK16 0xFFFFFFF8
 #define ZYWRLE_LOAD_PIXEL16(src, r, g, b)                               \
     do {                                                                \
-	r = ((uint8_t*)src)[S_1] & 0xF8;                                \
-	g = (((uint8_t*)src)[S_1]<< 5) | (((uint8_t*)src)[S_0] >> 3);   \
+        r = ((uint8_t*)src)[S_1] & 0xF8;                                \
+        g = (((uint8_t*)src)[S_1]<< 5) | (((uint8_t*)src)[S_0] >> 3);   \
         g &= 0xFC;                                                      \
-	b = (((uint8_t*)src)[S_0]<< 3) & 0xF8;                          \
+        b = (((uint8_t*)src)[S_0]<< 3) & 0xF8;                          \
     } while (0)
 
 #define ZYWRLE_SAVE_PIXEL16(dst, r, g,b)                                \
     do {                                                                \
-	r &= 0xF8;                                                      \
-	g &= 0xFC;                                                      \
-	b &= 0xF8;                                                      \
-	((uint8_t*)dst)[S_1] = (uint8_t)(r | (g >> 5));                 \
-	((uint8_t*)dst)[S_0] = (uint8_t)(((b >> 3)|(g << 3)) & 0xFF);   \
+        r &= 0xF8;                                                      \
+        g &= 0xFC;                                                      \
+        b &= 0xF8;                                                      \
+        ((uint8_t*)dst)[S_1] = (uint8_t)(r | (g >> 5));                 \
+        ((uint8_t*)dst)[S_0] = (uint8_t)(((b >> 3)|(g << 3)) & 0xFF);   \
     } while (0)
 
 #define ZYWRLE_YMASK32  0xFFFFFFFF
 #define ZYWRLE_UVMASK32 0xFFFFFFFF
 #define ZYWRLE_LOAD_PIXEL32(src, r, g, b)     \
     do {                                      \
-	r = ((uint8_t*)src)[L_2];             \
-	g = ((uint8_t*)src)[L_1];             \
-	b = ((uint8_t*)src)[L_0];             \
+        r = ((uint8_t*)src)[L_2];             \
+        g = ((uint8_t*)src)[L_1];             \
+        b = ((uint8_t*)src)[L_0];             \
     } while (0)
 #define ZYWRLE_SAVE_PIXEL32(dst, r, g, b)             \
     do {                                              \
-	((uint8_t*)dst)[L_2] = (uint8_t)r;            \
-	((uint8_t*)dst)[L_1] = (uint8_t)g;            \
-	((uint8_t*)dst)[L_0] = (uint8_t)b;            \
+        ((uint8_t*)dst)[L_2] = (uint8_t)r;            \
+        ((uint8_t*)dst)[L_1] = (uint8_t)g;            \
+        ((uint8_t*)dst)[L_0] = (uint8_t)b;            \
     } while (0)
 
 static inline void harr(int8_t *px0, int8_t *px1)
@@ -443,27 +443,27 @@ static inline void filter_wavelet_square(int *buf, int width, int height,
 
 static inline void wavelet(int *buf, int width, int height, int level)
 {
-	int l, s;
-	int *top;
-	int *end;
-
-	for (l = 0; l < level; l++) {
-		top = buf;
-		end = buf + height * width;
-		s = width << l;
-		while (top < end) {
-			wavelet_level(top, width, l, 1);
-			top += s;
-		}
-		top = buf;
-		end = buf + width;
-		s = 1<<l;
-		while (top < end) {
-			wavelet_level(top, height, l, width);
-			top += s;
-		}
-		filter_wavelet_square(buf, width, height, level, l);
-	}
+        int l, s;
+        int *top;
+        int *end;
+
+        for (l = 0; l < level; l++) {
+                top = buf;
+                end = buf + height * width;
+                s = width << l;
+                while (top < end) {
+                        wavelet_level(top, width, l, 1);
+                        top += s;
+                }
+                top = buf;
+                end = buf + width;
+                s = 1<<l;
+                while (top < end) {
+                        wavelet_level(top, height, l, width);
+                        top += s;
+                }
+                filter_wavelet_square(buf, width, height, level, l);
+        }
 }
 
 
@@ -471,16 +471,16 @@ static inline void wavelet(int *buf, int width, int height, int level)
  Coefficients manages as 24 bits little-endian pixel. */
 #define ZYWRLE_LOAD_COEFF(src, r, g, b)         \
     do {                                        \
-	r = ((int8_t*)src)[2];                  \
-	g = ((int8_t*)src)[1];                  \
-	b = ((int8_t*)src)[0];                  \
+        r = ((int8_t*)src)[2];                  \
+        g = ((int8_t*)src)[1];                  \
+        b = ((int8_t*)src)[0];                  \
     } while (0)
 
 #define ZYWRLE_SAVE_COEFF(dst, r, g, b)       \
     do {                                      \
-	((int8_t*)dst)[2] = (int8_t)r;        \
-	((int8_t*)dst)[1] = (int8_t)g;        \
-	((int8_t*)dst)[0] = (int8_t)b;        \
+        ((int8_t*)dst)[2] = (int8_t)r;        \
+        ((int8_t*)dst)[1] = (int8_t)g;        \
+        ((int8_t*)dst)[0] = (int8_t)b;        \
     } while (0)
 
 /*
@@ -502,22 +502,22 @@ static inline void wavelet(int *buf, int width, int height, int level)
    More exact PLHarr, we reduce to odd range(-127<=x<=127). */
 #define ZYWRLE_RGBYUV_(r, g, b, y, u, v, ymask, uvmask)          \
     do {                                                         \
-	y = (r + (g << 1) + b) >> 2;                             \
-	u =  b - g;                                              \
-	v =  r - g;                                              \
-	y -= 128;                                                \
-	u >>= 1;                                                 \
-	v >>= 1;                                                 \
-	y &= ymask;                                              \
-	u &= uvmask;                                             \
-	v &= uvmask;                                             \
-	if (y == -128) {                                         \
+        y = (r + (g << 1) + b) >> 2;                             \
+        u =  b - g;                                              \
+        v =  r - g;                                              \
+        y -= 128;                                                \
+        u >>= 1;                                                 \
+        v >>= 1;                                                 \
+        y &= ymask;                                              \
+        u &= uvmask;                                             \
+        v &= uvmask;                                             \
+        if (y == -128) {                                         \
             y += (0xFFFFFFFF - ymask + 1);                       \
         }                                                        \
-	if (u == -128) {                                         \
+        if (u == -128) {                                         \
             u += (0xFFFFFFFF - uvmask + 1);                      \
         }                                                        \
-	if (v == -128) {                                         \
+        if (v == -128) {                                         \
             v += (0xFFFFFFFF - uvmask + 1);                      \
         }                                                        \
     } while (0)
-- 
1.8.3.1
