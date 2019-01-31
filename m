Received: from eggs.gnu.org ([209.51.188.92]:37730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0ie-000069-SF
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0iW-0008TK-CR
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:00:35 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:40 +0100
Message-Id: <20190131005945.20149-9-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
References: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/13] nvme: use TYPE_NVME instead of constant
 string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

From: Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190120055558.32984-2-liq3ea@163.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7c8c63e8f5..f206391e8e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1381,7 +1381,7 @@ static void nvme_instance_init(Object *obj)
 }
=20
 static const TypeInfo nvme_info =3D {
-    .name          =3D "nvme",
+    .name          =3D TYPE_NVME,
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(NvmeCtrl),
     .class_init    =3D nvme_class_init,
--=20
2.20.1
