Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D54C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE6220693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE6220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVsk-0006pI-0H
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60836)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hsVpg-0008SX-PG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hsVpe-0000kB-Oy
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:22:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hsVpZ-0000fN-Ts; Tue, 30 Jul 2019 13:22:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA0B530BD1D6;
 Tue, 30 Jul 2019 17:22:32 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8967D60C47;
 Tue, 30 Jul 2019 17:22:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, kevin.tian@intel.com
Date: Tue, 30 Jul 2019 19:21:25 +0200
Message-Id: <20190730172137.23114-4-eric.auger@redhat.com>
In-Reply-To: <20190730172137.23114-1-eric.auger@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 30 Jul 2019 17:22:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 v10 03/15] virtio-iommu: Add skeleton
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchs adds the skeleton for the virtio-iommu device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10:
- expose VIRTIO_IOMMU_F_MMIO feature
- s/domain_bits/domain_range struct
- change error codes
- enforce unmigratable
- Kconfig

v7 -> v8:
- expose VIRTIO_IOMMU_F_BYPASS and VIRTIO_F_VERSION_1
  features
- set_config dummy implementation + tracing
- add trace in get_features
- set the features on realize() and store the acked ones
- remove inclusion of linux/virtio_iommu.h

v6 -> v7:
- removed qapi-event.h include
- add primary_bus and associated property

v4 -> v5:
- use the new v0.5 terminology (domain, endpoint)
- add the event virtqueue

v3 -> v4:
- use page_size_mask instead of page_sizes
- added set_features()
- added some traces (reset, set_status, set_features)
- empty virtio_iommu_set_config() as the driver MUST NOT
  write to device configuration fields
- add get_config trace

v2 -> v3:
- rebase on 2.10-rc0, ie. use IOMMUMemoryRegion and remove
  iommu_ops.
- advertise VIRTIO_IOMMU_F_MAP_UNMAP feature
- page_sizes set to TARGET_PAGE_SIZE

Conflicts:
	hw/virtio/trace-events
---
 hw/virtio/Kconfig                |   5 +
 hw/virtio/Makefile.objs          |   1 +
 hw/virtio/trace-events           |   8 +
 hw/virtio/virtio-iommu.c         | 267 +++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-iommu.h |  62 +++++++
 5 files changed, 343 insertions(+)
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 3724ff8bac..a30107b439 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -6,6 +6,11 @@ config VIRTIO_RNG
     default y
     depends on VIRTIO
=20
+config VIRTIO_IOMMU
+    bool
+    default y
+    depends on VIRTIO
+
 config VIRTIO_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 964ce78607..f42e4dd94f 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=3D virti=
o-crypto-pci.o
 obj-$(CONFIG_VIRTIO_PMEM) +=3D virtio-pmem.o
 common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) +=3D =
virtio-pmem-pci.o
+obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
=20
 ifeq ($(CONFIG_VIRTIO_PCI),y)
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e28ba48da6..f7dac39213 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -53,3 +53,11 @@ virtio_mmio_write_offset(uint64_t offset, uint64_t val=
ue) "virtio_mmio_write off
 virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" P=
RIx64 " shift %d"
 virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write =
0x%" PRIx64 " max %d"
 virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
+
+# hw/virtio/virtio-iommu.c
+virtio_iommu_device_reset(void) "reset!"
+virtio_iommu_get_features(uint64_t features) "device supports features=3D=
0x%"PRIx64
+virtio_iommu_set_features(uint64_t features) "features accepted by the d=
river =3D0x%"PRIx64
+virtio_iommu_device_status(uint8_t status) "driver status =3D %d"
+virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_=
t end, uint32_t domain_range, uint32_t probe_size) "page_size_mask=3D0x%"=
PRIx64" start=3D0x%"PRIx64" end=3D0x%"PRIx64" domain_range=3D%d probe_siz=
e=3D0x%x"
+virtio_iommu_set_config(uint64_t page_size_mask, uint64_t start, uint64_=
t end, uint32_t domain_range, uint32_t probe_size) "page_size_mask=3D0x%"=
PRIx64" start=3D0x%"PRIx64" end=3D0x%"PRIx64" domain_bits=3D%d probe_size=
=3D0x%x"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
new file mode 100644
index 0000000000..f239954396
--- /dev/null
+++ b/hw/virtio/virtio-iommu.c
@@ -0,0 +1,267 @@
+/*
+ * virtio-iommu device
+ *
+ * Copyright (c) 2017 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qemu-common.h"
+#include "hw/virtio/virtio.h"
+#include "sysemu/kvm.h"
+#include "trace.h"
+
+#include "standard-headers/linux/virtio_ids.h"
+
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include "hw/virtio/virtio-iommu.h"
+
+/* Max size */
+#define VIOMMU_DEFAULT_QUEUE_SIZE 256
+
+static int virtio_iommu_handle_attach(VirtIOIOMMU *s,
+                                      struct iovec *iov,
+                                      unsigned int iov_cnt)
+{
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+static int virtio_iommu_handle_detach(VirtIOIOMMU *s,
+                                      struct iovec *iov,
+                                      unsigned int iov_cnt)
+{
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+static int virtio_iommu_handle_map(VirtIOIOMMU *s,
+                                   struct iovec *iov,
+                                   unsigned int iov_cnt)
+{
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+static int virtio_iommu_handle_unmap(VirtIOIOMMU *s,
+                                     struct iovec *iov,
+                                     unsigned int iov_cnt)
+{
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+
+static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *v=
q)
+{
+    VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
+    struct virtio_iommu_req_head head;
+    struct virtio_iommu_req_tail tail;
+    VirtQueueElement *elem;
+    unsigned int iov_cnt;
+    struct iovec *iov;
+    size_t sz;
+
+    for (;;) {
+        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            return;
+        }
+
+        if (iov_size(elem->in_sg, elem->in_num) < sizeof(tail) ||
+            iov_size(elem->out_sg, elem->out_num) < sizeof(head)) {
+            virtio_error(vdev, "virtio-iommu bad head/tail size");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            break;
+        }
+
+        iov_cnt =3D elem->out_num;
+        iov =3D g_memdup(elem->out_sg, sizeof(struct iovec) * elem->out_=
num);
+        sz =3D iov_to_buf(iov, iov_cnt, 0, &head, sizeof(head));
+        if (unlikely(sz !=3D sizeof(head))) {
+            tail.status =3D VIRTIO_IOMMU_S_DEVERR;
+            goto out;
+        }
+        qemu_mutex_lock(&s->mutex);
+        switch (head.type) {
+        case VIRTIO_IOMMU_T_ATTACH:
+            tail.status =3D virtio_iommu_handle_attach(s, iov, iov_cnt);
+            break;
+        case VIRTIO_IOMMU_T_DETACH:
+            tail.status =3D virtio_iommu_handle_detach(s, iov, iov_cnt);
+            break;
+        case VIRTIO_IOMMU_T_MAP:
+            tail.status =3D virtio_iommu_handle_map(s, iov, iov_cnt);
+            break;
+        case VIRTIO_IOMMU_T_UNMAP:
+            tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt);
+            break;
+        default:
+            tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
+        }
+        qemu_mutex_unlock(&s->mutex);
+
+out:
+        sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
+                          &tail, sizeof(tail));
+        assert(sz =3D=3D sizeof(tail));
+
+        virtqueue_push(vq, elem, sizeof(tail));
+        virtio_notify(vdev, vq);
+        g_free(elem);
+    }
+}
+
+static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_=
data)
+{
+    VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
+    struct virtio_iommu_config *config =3D &dev->config;
+
+    trace_virtio_iommu_get_config(config->page_size_mask,
+                                  config->input_range.start,
+                                  config->input_range.end,
+                                  config->domain_range.end,
+                                  config->probe_size);
+    memcpy(config_data, &dev->config, sizeof(struct virtio_iommu_config)=
);
+}
+
+static void virtio_iommu_set_config(VirtIODevice *vdev,
+                                      const uint8_t *config_data)
+{
+    struct virtio_iommu_config config;
+
+    memcpy(&config, config_data, sizeof(struct virtio_iommu_config));
+    trace_virtio_iommu_set_config(config.page_size_mask,
+                                  config.input_range.start,
+                                  config.input_range.end,
+                                  config.domain_range.end,
+                                  config.probe_size);
+}
+
+static uint64_t virtio_iommu_get_features(VirtIODevice *vdev, uint64_t f=
,
+                                          Error **errp)
+{
+    VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
+
+    f |=3D dev->features;
+    trace_virtio_iommu_get_features(f);
+    return f;
+}
+
+static void virtio_iommu_set_features(VirtIODevice *vdev, uint64_t val)
+{
+    VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
+
+    dev->acked_features =3D val;
+    trace_virtio_iommu_set_features(dev->acked_features);
+}
+
+static const VMStateDescription vmstate_virtio_iommu_device =3D {
+    .name =3D "virtio-iommu-device",
+    .unmigratable =3D 1,
+};
+
+static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
+
+    virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
+                sizeof(struct virtio_iommu_config));
+
+    s->req_vq =3D virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
+                             virtio_iommu_handle_command);
+    s->event_vq =3D virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NU=
LL);
+
+    s->config.page_size_mask =3D TARGET_PAGE_MASK;
+    s->config.input_range.end =3D -1UL;
+    s->config.domain_range.start =3D 0;
+    s->config.domain_range.end =3D 32;
+
+    virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
+    virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
+    virtio_add_feature(&s->features, VIRTIO_F_VERSION_1);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_INPUT_RANGE);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_DOMAIN_RANGE);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
+}
+
+static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp=
)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+
+    virtio_cleanup(vdev);
+}
+
+static void virtio_iommu_device_reset(VirtIODevice *vdev)
+{
+    trace_virtio_iommu_device_reset();
+}
+
+static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    trace_virtio_iommu_device_status(status);
+}
+
+static void virtio_iommu_instance_init(Object *obj)
+{
+}
+
+static const VMStateDescription vmstate_virtio_iommu =3D {
+    .name =3D "virtio-iommu",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static Property virtio_iommu_properties[] =3D {
+    DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus, "PCI", PCI=
Bus *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_iommu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+
+    dc->props =3D virtio_iommu_properties;
+    dc->vmsd =3D &vmstate_virtio_iommu;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize =3D virtio_iommu_device_realize;
+    vdc->unrealize =3D virtio_iommu_device_unrealize;
+    vdc->reset =3D virtio_iommu_device_reset;
+    vdc->get_config =3D virtio_iommu_get_config;
+    vdc->set_config =3D virtio_iommu_set_config;
+    vdc->get_features =3D virtio_iommu_get_features;
+    vdc->set_features =3D virtio_iommu_set_features;
+    vdc->set_status =3D virtio_iommu_set_status;
+    vdc->vmsd =3D &vmstate_virtio_iommu_device;
+}
+
+static const TypeInfo virtio_iommu_info =3D {
+    .name =3D TYPE_VIRTIO_IOMMU,
+    .parent =3D TYPE_VIRTIO_DEVICE,
+    .instance_size =3D sizeof(VirtIOIOMMU),
+    .instance_init =3D virtio_iommu_instance_init,
+    .class_init =3D virtio_iommu_class_init,
+};
+
+static void virtio_register_types(void)
+{
+    type_register_static(&virtio_iommu_info);
+}
+
+type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-=
iommu.h
new file mode 100644
index 0000000000..4d47b6abeb
--- /dev/null
+++ b/include/hw/virtio/virtio-iommu.h
@@ -0,0 +1,62 @@
+/*
+ * virtio-iommu device
+ *
+ * Copyright (c) 2017 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QEMU_VIRTIO_IOMMU_H
+#define QEMU_VIRTIO_IOMMU_H
+
+#include "standard-headers/linux/virtio_iommu.h"
+#include "hw/virtio/virtio.h"
+#include "hw/pci/pci.h"
+
+#define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
+#define VIRTIO_IOMMU(obj) \
+        OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
+
+#define IOMMU_PCI_BUS_MAX      256
+#define IOMMU_PCI_DEVFN_MAX    256
+
+typedef struct IOMMUDevice {
+    void         *viommu;
+    PCIBus       *bus;
+    int           devfn;
+    IOMMUMemoryRegion  iommu_mr;
+    AddressSpace  as;
+} IOMMUDevice;
+
+typedef struct IOMMUPciBus {
+    PCIBus       *bus;
+    IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically al=
loc */
+} IOMMUPciBus;
+
+typedef struct VirtIOIOMMU {
+    VirtIODevice parent_obj;
+    VirtQueue *req_vq;
+    VirtQueue *event_vq;
+    struct virtio_iommu_config config;
+    uint64_t features;
+    uint64_t acked_features;
+    GHashTable *as_by_busptr;
+    IOMMUPciBus *as_by_bus_num[IOMMU_PCI_BUS_MAX];
+    PCIBus *primary_bus;
+    GTree *domains;
+    QemuMutex mutex;
+    GTree *endpoints;
+} VirtIOIOMMU;
+
+#endif
--=20
2.20.1


