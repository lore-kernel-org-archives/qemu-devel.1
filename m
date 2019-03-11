Received: from eggs.gnu.org ([209.51.188.92]:36591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdk-0004uI-Ee
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdj-0002AN-BS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3Gdi-00029W-Ut
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:31 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 11 Mar 2019 09:50:20 +0100
Message-Id: <20190311085024.13780-2-kraxel@redhat.com>
In-Reply-To: <20190311085024.13780-1-kraxel@redhat.com>
References: <20190311085024.13780-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] virtio: add class_size to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
