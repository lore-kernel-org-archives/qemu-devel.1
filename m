Received: from eggs.gnu.org ([2001:4830:134:3::10]:51574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fdXyN-0000s4-Lm
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fdXyM-0000mN-SF
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:33:15 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 12 Jul 2018 11:33:01 +0200
Message-Id: <20180712093301.9343-3-cohuck@redhat.com>
In-Reply-To: <20180712093301.9343-1-cohuck@redhat.com>
References: <20180712093301.9343-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-3.0 2/2] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20180705155811.20366-3-f4bug@amsat.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b92a85d0b0..7ddb378d52 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1836,11 +1836,9 @@ static void vhost_vsock_ccw_realize(VirtioCcwDevic=
e *ccw_dev, Error **errp)
 {
     VHostVSockCCWState *dev =3D VHOST_VSOCK_CCW(ccw_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
-    Error *err =3D NULL;
=20
     qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    error_propagate(errp, err);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
=20
 static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
--=20
2.14.4
