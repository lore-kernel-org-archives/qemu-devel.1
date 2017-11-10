Received: from eggs.gnu.org ([2001:4830:134:3::10]:58572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9tL-00007o-Fm
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9tI-0007tl-Im
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:02:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eD9tI-0007rg-Cm
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:02:40 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Nov 2017 15:02:36 +0100
Message-Id: <20171110140236.26651-3-kraxel@redhat.com>
In-Reply-To: <20171110140236.26651-1-kraxel@redhat.com>
References: <20171110140236.26651-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] ui: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170718061005.29518-9-f4bug@amsat.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console-gl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console-gl.c b/ui/console-gl.c
index 5b77e7aa88..a56e1cd8eb 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -48,7 +48,7 @@ void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface)
 {
     assert(gls);
-    assert(surface_stride(surface) % surface_bytes_per_pixel(surface) =3D=
=3D 0);
+    assert(QEMU_IS_ALIGNED(surface_stride(surface), surface_bytes_per_pi=
xel(surface)));
=20
     switch (surface->format) {
     case PIXMAN_BE_b8g8r8x8:
--=20
2.9.3
