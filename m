Received: from eggs.gnu.org ([2001:4830:134:3::10]:45304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVNh-0007hg-4t
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVNe-0002JC-Pg
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:50:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVNe-0002Ia-9z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:50:38 -0500
Date: Tue, 16 Jan 2018 19:50:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-17-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 16/34] vhost-user-test: fix features mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

VIRTIO_NET_F_MAC is a bit position, not a bit mask.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index e2c89ed..43c6528 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -177,7 +177,7 @@ static void init_virtio_dev(TestServer *s)
     qvirtio_set_driver(&dev->vdev);
=20
     features =3D qvirtio_get_features(&dev->vdev);
-    features =3D features & VIRTIO_NET_F_MAC;
+    features =3D features & (1u << VIRTIO_NET_F_MAC);
     qvirtio_set_features(&dev->vdev, features);
=20
     qvirtio_set_driver_ok(&dev->vdev);
--=20
MST
