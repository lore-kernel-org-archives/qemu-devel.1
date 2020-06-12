Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B19AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB473206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpI8MEbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB473206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlYI-0000fl-0O
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl6E-0006lx-5Q
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:56:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl6B-0002LN-Ou
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HeK33S58Y66BX2cfotuRkiKIabnRwY34GRnce15Fyy8=;
 b=UpI8MEbcnzEITUDSABuEh2YOJ+VyQVZ/SXzNHEWjsLd6XqzyXdpAV/z80UlcUlduwRsUEC
 +esWEoc3kwdy1WD/kH8oafAtw4kJdLzML76lhSda8jTV1udxh8NYxuZxiOmk1WE5En2Gyq
 LOSUBTcl6L5ie7+/sL3NjtmzyegyYME=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-wzrIZpVNMHyEiXCh7AmfAQ-1; Fri, 12 Jun 2020 10:52:55 -0400
X-MC-Unique: wzrIZpVNMHyEiXCh7AmfAQ-1
Received: by mail-wr1-f71.google.com with SMTP id e7so4005582wrp.14
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HeK33S58Y66BX2cfotuRkiKIabnRwY34GRnce15Fyy8=;
 b=Z+pNXXi44MwTqPzgKKhX3D91AizFcP3e/qHykb8J7M0C74cMN+HaM/ZsUMGG/noEhV
 xZnvhQTF17NM0XF14iov2oDr2qI+93GKvmkodXm3UXg3IFix/IUTGQ3Vw7SB+x7IUBOs
 kGZZSL6UJsdCB4/QkNJNnJxpY4LLqnJFNbpoeFoS4/fc+jdPCA9100Gb545pUme4BHng
 SY5E23mZf5kiAVSagfzzQTmtxxwjMpLgUEXIUBHhtZ3WQEZ2iw4qJItaejSGc8kXndSj
 yr1/RDBT6IJtJ6fmiJWEZ2or3oh3M4Cbk7SxazcwPCpkTIx3sP3bwcbUC5Qwi9PjRgoC
 zVKw==
X-Gm-Message-State: AOAM532e2o8v3fB4bJxgIqjK/B/UchKnVp4W1zZwmdrJ+qAOiymyIlG7
 tQad8YLLF8+A1PKufQqecGsKrdsPEeYZIrNhXTMoDRiUMOvyn3tze1o0eSOQqu27zeOkJDg/8m2
 B0PsA5noociNSPrI=
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr13952350wml.188.1591973573940; 
 Fri, 12 Jun 2020 07:52:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4p8E7Ou7m1zN3PEp3hK6VU8oRUBJzyyZANXQ5Q+k4mxvIk81uGgzdu+lfuXtf6lQYVflZXg==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr13952331wml.188.1591973573747; 
 Fri, 12 Jun 2020 07:52:53 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id c6sm9630033wma.15.2020.06.12.07.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:53 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 50/58] virtio: add vhost-user-vsock-pci device
Message-ID: <20200612141917.9446-51-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

Add the PCI version of vhost-user-vsock

Launch QEMU like this:

  qemu -chardev socket,path=/tmp/vm.vsock,id=chr0 \
       -device vhost-user-vsock-pci,chardev=chr0

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200522122512.87413-4-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-vsock-pci.c | 84 ++++++++++++++++++++++++++++++++
 hw/virtio/Makefile.objs          |  1 +
 2 files changed, 85 insertions(+)
 create mode 100644 hw/virtio/vhost-user-vsock-pci.c

diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
new file mode 100644
index 0000000000..0a6847e6fc
--- /dev/null
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -0,0 +1,84 @@
+/*
+ * Vhost-user vsock PCI Bindings
+ *
+ * Copyright 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-vsock.h"
+
+typedef struct VHostUserVSockPCI VHostUserVSockPCI;
+
+/*
+ * vhost-user-vsock-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_USER_VSOCK_PCI "vhost-user-vsock-pci-base"
+#define VHOST_USER_VSOCK_PCI(obj) \
+        OBJECT_CHECK(VHostUserVSockPCI, (obj), TYPE_VHOST_USER_VSOCK_PCI)
+
+struct VHostUserVSockPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserVSock vdev;
+};
+
+/* vhost-user-vsock-pci */
+
+static Property vhost_user_vsock_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_vsock_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_vsock_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, vhost_user_vsock_pci_properties);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_VSOCK;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_COMMUNICATION_OTHER;
+}
+
+static void vhost_user_vsock_pci_instance_init(Object *obj)
+{
+    VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_VSOCK);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_vsock_pci_info = {
+    .base_name             = TYPE_VHOST_USER_VSOCK_PCI,
+    .generic_name          = "vhost-user-vsock-pci",
+    .transitional_name     = "vhost-user-vsock-pci-transitional",
+    .non_transitional_name = "vhost-user-vsock-pci-non-transitional",
+    .instance_size = sizeof(VHostUserVSockPCI),
+    .instance_init = vhost_user_vsock_pci_instance_init,
+    .class_init    = vhost_user_vsock_pci_class_init,
+};
+
+static void virtio_pci_vhost_register(void)
+{
+    virtio_pci_types_register(&vhost_user_vsock_pci_info);
+}
+
+type_init(virtio_pci_vhost_register)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index dd42daedb1..13e75f171f 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -22,6 +22,7 @@ obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-vsock-common.o vhost-user-vsock.o
 
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
+obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-user-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
 obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input-pci.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
-- 
MST


