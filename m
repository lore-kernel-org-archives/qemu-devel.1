Received: from eggs.gnu.org ([2001:4830:134:3::10]:49041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAwif-0006uT-W3
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAwiZ-0007cQ-0L
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAwiY-0007am-NH
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:38:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 14:38:49 +0200
Message-Id: <20181012123851.30856-4-kraxel@redhat.com>
In-Reply-To: <20181012123851.30856-1-kraxel@redhat.com>
References: <20181012123851.30856-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] qxl: check qxl_phys2virt return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Fixes: CID 1395986
Fixes: 979f7ef8966bc4495a710ed9e4af42098f92ee79
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181005134608.1251-1-kraxel@redhat.com
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index e628cf1286..f608abc769 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -290,7 +290,7 @@ static void qxl_spice_monitors_config_async(PCIQXLDev=
ice *qxl, int replay)
     }
=20
     cfg =3D qxl_phys2virt(qxl, qxl->guest_monitors_config, MEMSLOT_GROUP=
_GUEST);
-    if (cfg->count =3D=3D 1) {
+    if (cfg !=3D NULL && cfg->count =3D=3D 1) {
         qxl->guest_primary.resized =3D 1;
         qxl->guest_head0_width  =3D cfg->heads[0].width;
         qxl->guest_head0_height =3D cfg->heads[0].height;
--=20
2.9.3
