Received: from eggs.gnu.org ([2001:4830:134:3::10]:57640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajt5-000788-Ah
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajt4-0003fL-GN
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:11 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:37389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajt4-0003fA-Bt
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:10 -0400
Received: by mail-qk0-x22e.google.com with SMTP id t79-v6so3050196qke.4
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 08:40:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Jul 2018 12:39:17 -0300
Message-Id: <20180704153919.12432-7-f4bug@amsat.org>
In-Reply-To: <20180704153919.12432-1-f4bug@amsat.org>
References: <20180704153919.12432-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/8] ui/vnc: Remove useless parenthesis around
 DIV_ROUND_UP macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/round.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ui/vnc-enc-tight.c | 2 +-
 ui/vnc.c           | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index f38aceb4da..0b4a5ac71f 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -979,7 +979,7 @@ static int send_mono_rect(VncState *vs, int x, int y,
     }
 #endif
 
-    bytes = (DIV_ROUND_UP(w, 8)) * h;
+    bytes = DIV_ROUND_UP(w, 8) * h;
 
     vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) << 4);
     vnc_write_u8(vs, VNC_TIGHT_FILTER_PALETTE);
diff --git a/ui/vnc.c b/ui/vnc.c
index 359693238b..3361432a51 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2967,7 +2967,8 @@ static int vnc_refresh_server_surface(VncDisplay *vd)
             PIXMAN_FORMAT_BPP(pixman_image_get_format(vd->guest.fb));
         guest_row0 = (uint8_t *)pixman_image_get_data(vd->guest.fb);
         guest_stride = pixman_image_get_stride(vd->guest.fb);
-        guest_ll = pixman_image_get_width(vd->guest.fb) * (DIV_ROUND_UP(guest_bpp, 8));
+        guest_ll = pixman_image_get_width(vd->guest.fb)
+                   * DIV_ROUND_UP(guest_bpp, 8);
     }
     line_bytes = MIN(server_stride, guest_ll);
 
-- 
2.18.0
