Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF2C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647CB206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 10:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647CB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJy7U-0003xf-OI
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 06:30:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJy3W-0000nn-Ls
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJy3T-0004XS-UO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hJy3R-00045c-5M
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 06:26:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5751A3086202
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:25:27 +0000 (UTC)
Received: from localhost (ovpn-112-33.ams2.redhat.com [10.36.112.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D012E5C1A1;
	Fri, 26 Apr 2019 10:25:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 12:24:35 +0200
Message-Id: <20190426102437.16189-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190426102437.16189-1-marcandre.lureau@redhat.com>
References: <20190426102437.16189-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 26 Apr 2019 10:25:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/6] Add vhost-user-input-pci
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	kraxel@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426102435.zvJQuh17ZiyqTU2yF9PnvSFKCrlieykXSBBgh4bWkz4@z>

Add a new virtio-input device, which connects to a vhost-user
backend.

Instead of reading configuration directly from an input device /
evdev (like virtio-input-host), it reads it over vhost-user protocol
with {SET,GET}_CONFIG messages. The vhost-user-backend handles the
queues & events setup.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-input.h |  14 ++++
 hw/input/vhost-user-input.c      | 129 +++++++++++++++++++++++++++++++
 hw/virtio/vhost-user-input-pci.c |  53 +++++++++++++
 MAINTAINERS                      |   1 +
 hw/input/Kconfig                 |   5 ++
 hw/input/Makefile.objs           |   1 +
 hw/virtio/Makefile.objs          |   1 +
 7 files changed, 204 insertions(+)
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input-pci.c

diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-=
input.h
index 054c38836f..4fca03e796 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -2,6 +2,7 @@
 #define QEMU_VIRTIO_INPUT_H
=20
 #include "ui/input.h"
+#include "sysemu/vhost-user-backend.h"
=20
 /* ----------------------------------------------------------------- */
 /* virtio input protocol                                             */
@@ -42,11 +43,18 @@ typedef struct virtio_input_event virtio_input_event;
 #define VIRTIO_INPUT_HOST_GET_PARENT_CLASS(obj) \
         OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_INPUT_HOST)
=20
+#define TYPE_VHOST_USER_INPUT   "vhost-user-input"
+#define VHOST_USER_INPUT(obj)                              \
+    OBJECT_CHECK(VHostUserInput, (obj), TYPE_VHOST_USER_INPUT)
+#define VHOST_USER_INPUT_GET_PARENT_CLASS(obj)             \
+    OBJECT_GET_PARENT_CLASS(obj, TYPE_VHOST_USER_INPUT)
+
 typedef struct VirtIOInput VirtIOInput;
 typedef struct VirtIOInputClass VirtIOInputClass;
 typedef struct VirtIOInputConfig VirtIOInputConfig;
 typedef struct VirtIOInputHID VirtIOInputHID;
 typedef struct VirtIOInputHost VirtIOInputHost;
+typedef struct VHostUserInput VHostUserInput;
=20
 struct VirtIOInputConfig {
     virtio_input_config               config;
@@ -98,6 +106,12 @@ struct VirtIOInputHost {
     int                               fd;
 };
=20
+struct VHostUserInput {
+    VirtIOInput                       parent_obj;
+
+    VhostUserBackend                  *vhost;
+};
+
 void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event);
 void virtio_input_init_config(VirtIOInput *vinput,
                               virtio_input_config *config);
diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
new file mode 100644
index 0000000000..6da497b1a8
--- /dev/null
+++ b/hw/input/vhost-user-input.c
@@ -0,0 +1,129 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+
+#include "hw/qdev.h"
+#include "hw/virtio/virtio-input.h"
+
+static int vhost_input_config_change(struct vhost_dev *dev)
+{
+    error_report("vhost-user-input: unhandled backend config change");
+    return -1;
+}
+
+static const VhostDevConfigOps config_ops =3D {
+    .vhost_dev_config_notifier =3D vhost_input_config_change,
+};
+
+static void vhost_input_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(dev);
+    VirtIOInput *vinput =3D VIRTIO_INPUT(dev);
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+
+    vhost_dev_set_config_notifier(&vhi->vhost->dev, &config_ops);
+    vinput->cfg_size =3D sizeof_field(virtio_input_config, u);
+    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, errp) =3D=3D -1=
) {
+        return;
+    }
+}
+
+static void vhost_input_change_active(VirtIOInput *vinput)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(vinput);
+
+    if (vinput->active) {
+        vhost_user_backend_start(vhi->vhost);
+    } else {
+        vhost_user_backend_stop(vhi->vhost);
+    }
+}
+
+static void vhost_input_get_config(VirtIODevice *vdev, uint8_t *config_d=
ata)
+{
+    VirtIOInput *vinput =3D VIRTIO_INPUT(vdev);
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(vdev);
+    int ret;
+
+    memset(config_data, 0, vinput->cfg_size);
+
+    ret =3D vhost_dev_get_config(&vhi->vhost->dev, config_data, vinput->=
cfg_size);
+    if (ret) {
+        error_report("vhost-user-input: get device config space failed")=
;
+        return;
+    }
+}
+
+static void vhost_input_set_config(VirtIODevice *vdev,
+                                   const uint8_t *config_data)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(vdev);
+    int ret;
+
+    ret =3D vhost_dev_set_config(&vhi->vhost->dev, config_data,
+                               0, sizeof(virtio_input_config),
+                               VHOST_SET_CONFIG_TYPE_MASTER);
+    if (ret) {
+        error_report("vhost-user-input: set device config space failed")=
;
+        return;
+    }
+
+    virtio_notify_config(vdev);
+}
+
+static const VMStateDescription vmstate_vhost_input =3D {
+    .name =3D "vhost-user-input",
+    .unmigratable =3D 1,
+};
+
+static void vhost_input_class_init(ObjectClass *klass, void *data)
+{
+    VirtIOInputClass *vic =3D VIRTIO_INPUT_CLASS(klass);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_vhost_input;
+    vdc->get_config =3D vhost_input_get_config;
+    vdc->set_config =3D vhost_input_set_config;
+    vic->realize =3D vhost_input_realize;
+    vic->change_active =3D vhost_input_change_active;
+}
+
+static void vhost_input_init(Object *obj)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(obj);
+
+    vhi->vhost =3D VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND=
));
+    object_property_add_alias(obj, "chardev",
+                              OBJECT(vhi->vhost), "chardev", &error_abor=
t);
+}
+
+static void vhost_input_finalize(Object *obj)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(obj);
+
+    object_unref(OBJECT(vhi->vhost));
+}
+
+static const TypeInfo vhost_input_info =3D {
+    .name          =3D TYPE_VHOST_USER_INPUT,
+    .parent        =3D TYPE_VIRTIO_INPUT,
+    .instance_size =3D sizeof(VHostUserInput),
+    .instance_init =3D vhost_input_init,
+    .instance_finalize =3D vhost_input_finalize,
+    .class_init    =3D vhost_input_class_init,
+};
+
+static void vhost_input_register_types(void)
+{
+    type_register_static(&vhost_input_info);
+}
+
+type_init(vhost_input_register_types)
diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-inpu=
t-pci.c
new file mode 100644
index 0000000000..3d1b7a85fd
--- /dev/null
+++ b/hw/virtio/vhost-user-input-pci.c
@@ -0,0 +1,53 @@
+/*
+ * This work is licensed under the terms of the GNU LGPL, version 2 or
+ * later.  See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-input.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "virtio-pci.h"
+
+typedef struct VHostUserInputPCI VHostUserInputPCI;
+
+#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci-base"
+
+#define VHOST_USER_INPUT_PCI(obj) \
+    OBJECT_CHECK(VHostUserInputPCI, (obj), TYPE_VHOST_USER_INPUT_PCI)
+
+struct VHostUserInputPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserInput vhi;
+};
+
+static void vhost_user_input_pci_instance_init(Object *obj)
+{
+    VHostUserInputPCI *dev =3D VHOST_USER_INPUT_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vhi, sizeof(dev->vhi),
+                                TYPE_VHOST_USER_INPUT);
+
+    object_property_add_alias(obj, "chardev",
+                              OBJECT(&dev->vhi), "chardev",
+                              &error_abort);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info =3D {
+    .base_name =3D TYPE_VHOST_USER_INPUT_PCI,
+    .generic_name =3D "vhost-user-input-pci",
+    .transitional_name =3D "vhost-user-input-pci-transitional",
+    .non_transitional_name =3D "vhost-user-input-pci-non-transitional",
+    .parent =3D TYPE_VIRTIO_INPUT_PCI,
+    .instance_size =3D sizeof(VHostUserInputPCI),
+    .instance_init =3D vhost_user_input_pci_instance_init,
+};
+
+static void vhost_user_input_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_input_pci_info);
+}
+
+type_init(vhost_user_input_pci_register)
diff --git a/MAINTAINERS b/MAINTAINERS
index c48f13f877..075858968c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1512,6 +1512,7 @@ L: qemu-s390x@nongnu.org
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
=20
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index e2e66f0858..50e55e3538 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -29,5 +29,10 @@ config VIRTIO_INPUT_HOST
     default y
     depends on VIRTIO && LINUX
=20
+config VHOST_USER_INPUT
+    bool
+    default y
+    depends on VIRTIO_INPUT && VHOST_USER
+
 config TSC210X
     bool
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index c8b00f71ec..9511e3102f 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input.o
 common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-hid.o
 ifeq ($(CONFIG_LINUX),y)
 common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-host.o
+common-obj-$(CONFIG_VHOST_USER_INPUT) +=3D vhost-user-input.o
 endif
=20
 obj-$(CONFIG_MILKYMIST) +=3D milkymist-softusb.o
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index f2ab667a21..5570ea8df8 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -17,6 +17,7 @@ obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk-pci.o
+obj-$(CONFIG_VHOST_USER_INPUT) +=3D vhost-user-input-pci.o
 obj-$(CONFIG_VHOST_USER_SCSI) +=3D vhost-user-scsi-pci.o
 obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-pci.o
--=20
2.21.0.313.ge35b8cb8e2


