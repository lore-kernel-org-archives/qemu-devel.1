Received: from eggs.gnu.org ([2001:4830:134:3::10]:48952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyx-0001rx-FW
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyw-0000pU-PY
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyw-0000pO-KS
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:14 -0400
Date: Wed, 23 May 2018 17:43:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-18-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/28] hw/virtio: Fix brace Werror with clang
 6.0.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>

From: Richard Henderson <richard.henderson@linaro.org>

The warning is

hw/virtio/vhost-user.c:1319:26: error: suggest braces
      around initialization of subobject [-Werror,-Wmissing-braces]
    VhostUserMsg msg =3D { 0 };
                         ^
                         {}

While the original code is correct, and technically exactly correct
as per ISO C89, both GCC and Clang support plain empty set of braces
as an extension.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 41cbd8a..ca554d4 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1355,7 +1355,7 @@ static bool vhost_user_requires_shm_log(struct vhos=
t_dev *dev)
=20
 static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_ad=
dr)
 {
-    VhostUserMsg msg =3D { 0 };
+    VhostUserMsg msg =3D { };
=20
     assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
=20
--=20
MST
