Received: from eggs.gnu.org ([2001:4830:134:3::10]:42895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh42-0004BI-6n
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh41-00051Z-8b
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:32:03 +0200
Message-Id: <20170713163219.9024-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/29] vga: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 80508b83f4..286295272c 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1621,7 +1621,7 @@ static void vga_draw_graphic(VGACommonState *s, int=
 full_update)
            s->line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
 #endif
     addr1 =3D (s->start_addr * 4);
-    bwidth =3D (width * bits + 7) / 8;
+    bwidth =3D DIV_ROUND_UP(width * bits, 8);
     y_start =3D -1;
     d =3D surface_data(surface);
     linesize =3D surface_stride(surface);
--=20
2.13.1.395.gf7b71de06
