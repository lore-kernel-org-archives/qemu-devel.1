Received: from eggs.gnu.org ([2001:4830:134:3::10]:39947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Lr-0001eG-CC
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Lo-0002ih-R2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1Lo-0002iE-Jr
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:16 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 09:45:07 +0200
Message-Id: <20180821074509.22688-11-kraxel@redhat.com>
In-Reply-To: <20180821074509.22688-1-kraxel@redhat.com>
References: <20180821074509.22688-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/12] ui/vnc: Remove useless parenthesis around
 DIV_ROUND_UP macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/round.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180704153919.12432-7-f4bug@amsat.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
=20
-    bytes =3D (DIV_ROUND_UP(w, 8)) * h;
+    bytes =3D DIV_ROUND_UP(w, 8) * h;
=20
     vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) << 4);
     vnc_write_u8(vs, VNC_TIGHT_FILTER_PALETTE);
diff --git a/ui/vnc.c b/ui/vnc.c
index fd929b0957..ccb1335d86 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2967,7 +2967,8 @@ static int vnc_refresh_server_surface(VncDisplay *v=
d)
             PIXMAN_FORMAT_BPP(pixman_image_get_format(vd->guest.fb));
         guest_row0 =3D (uint8_t *)pixman_image_get_data(vd->guest.fb);
         guest_stride =3D pixman_image_get_stride(vd->guest.fb);
-        guest_ll =3D pixman_image_get_width(vd->guest.fb) * (DIV_ROUND_U=
P(guest_bpp, 8));
+        guest_ll =3D pixman_image_get_width(vd->guest.fb)
+                   * DIV_ROUND_UP(guest_bpp, 8);
     }
     line_bytes =3D MIN(server_stride, guest_ll);
=20
--=20
2.9.3
