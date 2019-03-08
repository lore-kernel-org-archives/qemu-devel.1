Received: from eggs.gnu.org ([209.51.188.92]:53351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h2En9-0001LW-Ct
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h2En5-0004f5-Ti
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:39:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h2En5-0003XM-Ix
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:39:55 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  8 Mar 2019 13:39:35 +0100
Message-Id: <20190308123937.2346-4-kraxel@redhat.com>
In-Reply-To: <20190308123937.2346-1-kraxel@redhat.com>
References: <20190308123937.2346-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] virtio: add class_size to
 VirtioPCIDeviceTypeInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Needed when VirtioPCIClass subclasses have their own
class struct with some extra fields.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20190307080244.9011-2-kraxel@redhat.com
---
 hw/virtio/virtio-pci.h | 1 +
 hw/virtio/virtio-pci.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index bd223a6e3b0b..18581854cae1 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -230,6 +230,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
=20
     /* Same as TypeInfo fields: */
     size_t instance_size;
+    size_t class_size;
     void (*instance_init)(Object *obj);
     void (*class_init)(ObjectClass *klass, void *data);
 } VirtioPCIDeviceTypeInfo;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e978bfe76048..cb44e19b6789 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1935,6 +1935,7 @@ void virtio_pci_types_register(const VirtioPCIDevic=
eTypeInfo *t)
         .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size =3D t->instance_size,
         .instance_init =3D t->instance_init,
+        .class_size    =3D t->class_size,
         .class_init    =3D virtio_pci_base_class_init,
         .class_data    =3D (void *)t,
         .abstract      =3D true,
--=20
2.18.1
