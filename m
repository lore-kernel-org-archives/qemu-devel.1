Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D28C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8342077B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8342077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsOS-00068q-IV
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs6B-0005xT-6Y
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs69-0004lP-Af
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs69-0004l3-1O
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:21 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 324074E908
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 22:00:20 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id y189so10660914qkb.14
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 15:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=px8e8nM6b5YcIbPMcTNrv5Hy31hK9o3VKORPFaPlxDc=;
 b=qk/I4knwf5hnZlqJ9aw7MdiJk3/pyyXnVBcnbklVHnu7PCthEjBgJ9Km0VfgQx3f0r
 p3kemRhASt0D8HZvWAjHsQO+MoEV3zq6gq3CwpWq8iONCutSJwjhHqxHVJTqfxxG1A2h
 rDfkr1KNKDIzIoZqaM6hjZf7TuT33RzSBcVDjtPFkWg39L7C2Uk0+cunjVtC5gWRcmJd
 VZjSK8tUfovxwP2ZKQ/pWbdUidXplPL98ahW9wgdXT1AVto+SR3Z8HjKf6V3+l0ZcWur
 NAZiRNZDNy/lR0hlFydjmF2qEcMVE4QSu6Bs8F6DAIReYK0MBqr4Y6Qa1ZX1eSaIuTPz
 hbQg==
X-Gm-Message-State: APjAAAXFaqEcGlnSzzmqf2XdJ9fKVbAlRSv8vFkOi6ErZXFzCl8FI7Ql
 IS/nx/sCAA8D9ou7FRaM5H5t7xJHPxMR5i9CidxIcA4Ggkk5LOpHTZmIw+wuO2oL+0Nn+FQqKwo
 MHWqMvTije/VQvwA=
X-Received: by 2002:a37:4809:: with SMTP id v9mr17242783qka.228.1570312818781; 
 Sat, 05 Oct 2019 15:00:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwh4YWteldwsVb3haIsBki8d/H/1AUXFpROOGZbuRFAUFUHcvmy3CDB9GgcJBjXdM+jLLVfOA==
X-Received: by 2002:a37:4809:: with SMTP id v9mr17242760qka.228.1570312818522; 
 Sat, 05 Oct 2019 15:00:18 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 b4sm5635574qkd.121.2019.10.05.15.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 15:00:17 -0700 (PDT)
Date: Sat, 5 Oct 2019 18:00:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/19] virtio: add vhost-user-fs-pci device
Message-ID: <20190930105135.27244-4-dgilbert@redhat.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005220014.UppPut9YP5Q1OatKAvpBhuqRlDgsJlw1CtuIyCIKC3c@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the PCI version of vhost-user-fs.

Launch QEMU like this:

  qemu -chardev socket,path=/tmp/vhost-fs.sock,id=chr0
       -device vhost-user-fs-pci,tag=myfs,chardev=chr0

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190930105135.27244-4-dgilbert@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/Makefile.objs       |  1 +
 hw/virtio/vhost-user-fs-pci.c | 85 +++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 hw/virtio/vhost-user-fs-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 47ffbf22c4..e2f70fbb89 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -15,6 +15,7 @@ obj-$(CONFIG_VHOST_USER_FS) += vhost-user-fs.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
 obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
 common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
+obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) += vhost-user-fs-pci.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 
 ifeq ($(CONFIG_VIRTIO_PCI),y)
diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
new file mode 100644
index 0000000000..933a3f265b
--- /dev/null
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -0,0 +1,85 @@
+/*
+ * Vhost-user filesystem virtio device PCI glue
+ *
+ * Copyright 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  Dr. David Alan Gilbert <dgilbert@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-fs.h"
+#include "virtio-pci.h"
+
+struct VHostUserFSPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserFS vdev;
+};
+
+typedef struct VHostUserFSPCI VHostUserFSPCI;
+
+#define TYPE_VHOST_USER_FS_PCI "vhost-user-fs-pci-base"
+
+#define VHOST_USER_FS_PCI(obj) \
+        OBJECT_CHECK(VHostUserFSPCI, (obj), TYPE_VHOST_USER_FS_PCI)
+
+static Property vhost_user_fs_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserFSPCI *dev = VHOST_USER_FS_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.conf.num_request_queues + 1;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_user_fs_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_fs_pci_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = vhost_user_fs_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_OTHER;
+}
+
+static void vhost_user_fs_pci_instance_init(Object *obj)
+{
+    VHostUserFSPCI *dev = VHOST_USER_FS_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_FS);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_fs_pci_info = {
+    .base_name             = TYPE_VHOST_USER_FS_PCI,
+    .non_transitional_name = "vhost-user-fs-pci",
+    .instance_size = sizeof(VHostUserFSPCI),
+    .instance_init = vhost_user_fs_pci_instance_init,
+    .class_init    = vhost_user_fs_pci_class_init,
+};
+
+static void vhost_user_fs_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_fs_pci_info);
+}
+
+type_init(vhost_user_fs_pci_register);
-- 
MST


