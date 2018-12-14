Received: from eggs.gnu.org ([2001:4830:134:3::10]:59396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm7-0005hQ-OS
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm4-0002MS-Tw
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:19 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com
	([40.107.8.118]:22409
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gXqm4-0001B5-IR
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:16 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:57:08 +0000
Message-ID: <20181214165657.749-5-rkagan@virtuozzo.com>
References: <20181214165657.749-1-rkagan@virtuozzo.com>
In-Reply-To: <20181214165657.749-1-rkagan@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH 4/5] virtio: drop
 DEFINE_VIRTIO_COMMON_FEATURES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>

This macro is only used in one place so seems to be unnecessary.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/virtio/virtio.h | 12 ------------
 hw/virtio/virtio.c         | 11 ++++++++++-
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9c1fa07d6d..cea356efed 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -254,18 +254,6 @@ typedef struct virtio_input_conf virtio_input_conf;
 typedef struct VirtIOSCSIConf VirtIOSCSIConf;
 typedef struct VirtIORNGConf VirtIORNGConf;
=20
-#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
-    DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
-                      VIRTIO_RING_F_INDIRECT_DESC, true), \
-    DEFINE_PROP_BIT64("event_idx", _state, _field,        \
-                      VIRTIO_RING_F_EVENT_IDX, true),     \
-    DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
-                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
-    DEFINE_PROP_BIT64("any_layout", _state, _field, \
-                      VIRTIO_F_ANY_LAYOUT, true), \
-    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
-                      VIRTIO_F_IOMMU_PLATFORM, false)
-
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 22bd1ac34e..99d396c516 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2601,7 +2601,16 @@ static void virtio_device_instance_finalize(Object *=
obj)
 }
=20
 static Property virtio_properties[] =3D {
-    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
+    DEFINE_PROP_BIT64("indirect_desc", VirtIODevice, host_features,
+                      VIRTIO_RING_F_INDIRECT_DESC, true),
+    DEFINE_PROP_BIT64("event_idx", VirtIODevice, host_features,
+                      VIRTIO_RING_F_EVENT_IDX, true),
+    DEFINE_PROP_BIT64("notify_on_empty", VirtIODevice, host_features,
+                      VIRTIO_F_NOTIFY_ON_EMPTY, true),
+    DEFINE_PROP_BIT64("any_layout", VirtIODevice, host_features,
+                      VIRTIO_F_ANY_LAYOUT, true),
+    DEFINE_PROP_BIT64("iommu_platform", VirtIODevice, host_features,
+                      VIRTIO_F_IOMMU_PLATFORM, false),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.19.2
