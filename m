Received: from eggs.gnu.org ([2001:4830:134:3::10]:45459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SH-0006v7-Fl
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1SF-0006fy-6E
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1SE-0006fq-W8
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9C4DA077A
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:43:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:47 +0200
Message-Id: <20170622124204.19407-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/31] vga: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index dcc95f88e2..c2d3e8f54b 100644
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
