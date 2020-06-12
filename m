Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AE4C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D93206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeFnbHjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D93206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlVZ-0004kY-2o
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl6E-0006mT-Cx
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:56:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl6B-0002LI-Jp
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sJAZsJmFlqScQwmM7L/XMteb8M4v1LBCTCabVI67rS0=;
 b=GeFnbHjCaoxVLhNvxAmAW7rECXxhtMwedw2h6YWM2Nb+NJGA3RudLPWA6ZmnrwQHR/pljh
 FmAWiT549W3Y2ni58HAMyppXS6C0ShLRYMAbLo1NW80ZOZ7sEoqY22nTGpcz/A3GxPl20X
 AWzRbJbHpXL/cvonNZrDZ+9G1epohto=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-DrV05vOgNByA33wIetmv_g-1; Fri, 12 Jun 2020 10:52:53 -0400
X-MC-Unique: DrV05vOgNByA33wIetmv_g-1
Received: by mail-wm1-f72.google.com with SMTP id j128so2547342wmj.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sJAZsJmFlqScQwmM7L/XMteb8M4v1LBCTCabVI67rS0=;
 b=RmQqSK6EJAQyT/jh+mZnYYt+Y3RPVmpeFggyPDfshju7JwZkbwMtsdV3xKN+P4yEqp
 /I4gx6Q+Ou3e4KVXwAc3MlclcpQ3MyoQY1+Z4rP3bOhGUuZur1rIdXh2Eu2FgsaB/uNT
 v3ZjHD2bhvYLYinFFxcFVTzrK/6NBsZcfIpxMWJboAM4DQ0+5xkC3/stw7A8z6zbzVSQ
 B8ALXCAjFplEp8FN/6yvrhiMcRjuR0pixYEWxb43zRpl0WbM3s848Mhv9UwHTjHaW4yI
 jFXXWr/OvjqfrL2RmRevbc2+jy+JiFlXMm1npKh28T28zNT6RCDnPV/DCIKRFEizXdZb
 8CgA==
X-Gm-Message-State: AOAM5304IiLmfP9ZBJNr7cN0WB9zWha99NXruBts5GaYLii7to4YWFJZ
 oCidk7Vnk7LvahJgda+Rx1FBA6vgJZQb8SV2p2aR/5YhoWRIDPhshDCnUBEIg+/xeD9RW+DNguE
 gFOir6N8GQvcBjV0=
X-Received: by 2002:a05:6000:114e:: with SMTP id
 d14mr15052839wrx.110.1591973572268; 
 Fri, 12 Jun 2020 07:52:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfmVSlqLtH9a35l8xvWyO9GQ+0ll1uOB5n/o0d4uA6qp43l8aDa8gM8CxbGuiAT/MAoL/Ctw==
X-Received: by 2002:a05:6000:114e:: with SMTP id
 d14mr15052817wrx.110.1591973571903; 
 Fri, 12 Jun 2020 07:52:51 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id 30sm11033821wrd.47.2020.06.12.07.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:51 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 49/58] virtio: add vhost-user-vsock base device
Message-ID: <20200612141917.9446-50-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This patch introduces a vhost-user device for vsock, using the
vhost-vsock-common parent class.

The vhost-user-vsock device can be used to implement the virtio-vsock
device emulation in user-space.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200522122512.87413-3-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 configure                            |   3 +
 include/hw/virtio/vhost-user-vsock.h |  36 ++++++
 hw/virtio/vhost-user-vsock.c         | 181 +++++++++++++++++++++++++++
 hw/virtio/Makefile.objs              |   1 +
 4 files changed, 221 insertions(+)
 create mode 100644 include/hw/virtio/vhost-user-vsock.h
 create mode 100644 hw/virtio/vhost-user-vsock.c

diff --git a/configure b/configure
index 597e909b53..7c2adf36e5 100755
--- a/configure
+++ b/configure
@@ -7196,6 +7196,9 @@ if test "$vhost_crypto" = "yes" ; then
 fi
 if test "$vhost_vsock" = "yes" ; then
   echo "CONFIG_VHOST_VSOCK=y" >> $config_host_mak
+  if test "$vhost_user" = "yes" ; then
+    echo "CONFIG_VHOST_USER_VSOCK=y" >> $config_host_mak
+  fi
 fi
 if test "$vhost_kernel" = "yes" ; then
   echo "CONFIG_VHOST_KERNEL=y" >> $config_host_mak
diff --git a/include/hw/virtio/vhost-user-vsock.h b/include/hw/virtio/vhost-user-vsock.h
new file mode 100644
index 0000000000..4e128a4b9f
--- /dev/null
+++ b/include/hw/virtio/vhost-user-vsock.h
@@ -0,0 +1,36 @@
+/*
+ * Vhost-user vsock virtio device
+ *
+ * Copyright 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef _QEMU_VHOST_USER_VSOCK_H
+#define _QEMU_VHOST_USER_VSOCK_H
+
+#include "hw/virtio/vhost-vsock-common.h"
+#include "hw/virtio/vhost-user.h"
+#include "standard-headers/linux/virtio_vsock.h"
+
+#define TYPE_VHOST_USER_VSOCK "vhost-user-vsock-device"
+#define VHOST_USER_VSOCK(obj) \
+        OBJECT_CHECK(VHostUserVSock, (obj), TYPE_VHOST_USER_VSOCK)
+
+typedef struct {
+    CharBackend chardev;
+} VHostUserVSockConf;
+
+typedef struct {
+    /*< private >*/
+    VHostVSockCommon parent;
+    VhostUserState vhost_user;
+    VHostUserVSockConf conf;
+    struct virtio_vsock_config vsockcfg;
+
+    /*< public >*/
+} VHostUserVSock;
+
+#endif /* _QEMU_VHOST_USER_VSOCK_H */
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
new file mode 100644
index 0000000000..3534a39d62
--- /dev/null
+++ b/hw/virtio/vhost-user-vsock.c
@@ -0,0 +1,181 @@
+/*
+ * Vhost-user vsock virtio device
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
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost-user-vsock.h"
+
+static const int user_feature_bits[] = {
+    VIRTIO_F_VERSION_1,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VHOST_INVALID_FEATURE_BIT
+};
+
+static void vuv_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VHostUserVSock *vsock = VHOST_USER_VSOCK(vdev);
+
+    memcpy(config, &vsock->vsockcfg, sizeof(struct virtio_vsock_config));
+}
+
+static int vuv_handle_config_change(struct vhost_dev *dev)
+{
+    VHostUserVSock *vsock = VHOST_USER_VSOCK(dev->vdev);
+    int ret = vhost_dev_get_config(dev, (uint8_t *)&vsock->vsockcfg,
+                                   sizeof(struct virtio_vsock_config));
+    if (ret < 0) {
+        error_report("get config space failed");
+        return -1;
+    }
+
+    virtio_notify_config(dev->vdev);
+
+    return 0;
+}
+
+const VhostDevConfigOps vsock_ops = {
+    .vhost_dev_config_notifier = vuv_handle_config_change,
+};
+
+static void vuv_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
+
+    if (!vdev->vm_running) {
+        should_start = false;
+    }
+
+    if (vvc->vhost_dev.started == should_start) {
+        return;
+    }
+
+    if (should_start) {
+        int ret = vhost_vsock_common_start(vdev);
+        if (ret < 0) {
+            return;
+        }
+    } else {
+        vhost_vsock_common_stop(vdev);
+    }
+}
+
+static uint64_t vuv_get_features(VirtIODevice *vdev,
+                                 uint64_t features,
+                                 Error **errp)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+
+    return vhost_get_features(&vvc->vhost_dev, user_feature_bits, features);
+}
+
+static const VMStateDescription vuv_vmstate = {
+    .name = "vhost-user-vsock",
+    .unmigratable = 1,
+};
+
+static void vuv_device_realize(DeviceState *dev, Error **errp)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserVSock *vsock = VHOST_USER_VSOCK(dev);
+    int ret;
+
+    if (!vsock->conf.chardev.chr) {
+        error_setg(errp, "missing chardev");
+        return;
+    }
+
+    if (!vhost_user_init(&vsock->vhost_user, &vsock->conf.chardev, errp)) {
+        return;
+    }
+
+    vhost_vsock_common_realize(vdev, "vhost-user-vsock");
+
+    vhost_dev_set_config_notifier(&vvc->vhost_dev, &vsock_ops);
+
+    ret = vhost_dev_init(&vvc->vhost_dev, &vsock->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vhost_dev_init failed");
+        goto err_virtio;
+    }
+
+    ret = vhost_dev_get_config(&vvc->vhost_dev, (uint8_t *)&vsock->vsockcfg,
+                               sizeof(struct virtio_vsock_config));
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "get config space failed");
+        goto err_vhost_dev;
+    }
+
+    return;
+
+err_vhost_dev:
+    vhost_dev_cleanup(&vvc->vhost_dev);
+err_virtio:
+    vhost_vsock_common_unrealize(vdev);
+    vhost_user_cleanup(&vsock->vhost_user);
+    return;
+}
+
+static void vuv_device_unrealize(DeviceState *dev)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserVSock *vsock = VHOST_USER_VSOCK(dev);
+
+    /* This will stop vhost backend if appropriate. */
+    vuv_set_status(vdev, 0);
+
+    vhost_dev_cleanup(&vvc->vhost_dev);
+
+    vhost_vsock_common_unrealize(vdev);
+
+    vhost_user_cleanup(&vsock->vhost_user);
+
+}
+
+static Property vuv_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vuv_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vuv_properties);
+    dc->vmsd = &vuv_vmstate;
+    vdc->realize = vuv_device_realize;
+    vdc->unrealize = vuv_device_unrealize;
+    vdc->get_features = vuv_get_features;
+    vdc->get_config = vuv_get_config;
+    vdc->set_status = vuv_set_status;
+}
+
+static const TypeInfo vuv_info = {
+    .name = TYPE_VHOST_USER_VSOCK,
+    .parent = TYPE_VHOST_VSOCK_COMMON,
+    .instance_size = sizeof(VHostUserVSock),
+    .class_init = vuv_class_init,
+};
+
+static void vuv_register_types(void)
+{
+    type_register_static(&vuv_info);
+}
+
+type_init(vuv_register_types)
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index b1eeb44eac..dd42daedb1 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -18,6 +18,7 @@ common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pme
 obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) += vhost-user-fs-pci.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-common.o vhost-vsock.o
+obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-vsock-common.o vhost-user-vsock.o
 
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
-- 
MST


