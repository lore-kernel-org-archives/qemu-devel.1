Received: from eggs.gnu.org ([2001:4830:134:3::10]:42209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2r-0002WJ-D2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2q-00047g-Gy
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:53 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:31:54 +0200
Message-Id: <20170713163219.9024-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/29] vhost: use QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6eddb099b0..0049a2c0b3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -70,7 +70,7 @@ static void vhost_dev_sync_region(struct vhost_dev *dev=
,
     uint64_t end =3D MIN(mlast, rlast);
     vhost_log_chunk_t *from =3D log + start / VHOST_LOG_CHUNK;
     vhost_log_chunk_t *to =3D log + end / VHOST_LOG_CHUNK + 1;
-    uint64_t addr =3D (start / VHOST_LOG_CHUNK) * VHOST_LOG_CHUNK;
+    uint64_t addr =3D QEMU_ALIGN_DOWN(start, VHOST_LOG_CHUNK);
=20
     if (end < start) {
         return;
--=20
2.13.1.395.gf7b71de06
