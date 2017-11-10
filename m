Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9Kf-0004j6-H9
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9Kc-0001VO-Hx
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eD9Kc-0001Sq-AY
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:50 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Nov 2017 14:26:44 +0100
Message-Id: <20171110132644.8069-4-kraxel@redhat.com>
In-Reply-To: <20171110132644.8069-1-kraxel@redhat.com>
References: <20171110132644.8069-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] vmsvga: use ARRAY_SIZE macro
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
Message-Id: <20170718061005.29518-23-f4bug@amsat.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vmware_vga.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index cdc3fed6ca..0e6673a911 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -679,10 +679,9 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s=
)
             if (cursor.width > 256
                 || cursor.height > 256
                 || cursor.bpp > 32
-                || SVGA_BITMAP_SIZE(x, y)
-                    > sizeof(cursor.mask) / sizeof(cursor.mask[0])
+                || SVGA_BITMAP_SIZE(x, y) > ARRAY_SIZE(cursor.mask)
                 || SVGA_PIXMAP_SIZE(x, y, cursor.bpp)
-                    > sizeof(cursor.image) / sizeof(cursor.image[0])) {
+                    > ARRAY_SIZE(cursor.image)) {
                     goto badcmd;
             }
=20
--=20
2.9.3
