Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B07C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB922074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGvGkzYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB922074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisve-0005As-Rb
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisPF-0005e0-TZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:32:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisPE-0000kJ-JW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sJAZsJmFlqScQwmM7L/XMteb8M4v1LBCTCabVI67rS0=;
 b=GGvGkzYmNB2nyOiqPtIMxo8r8H4/kAC9rPX+18PcdSTQpO25PCxaaLoC7j8vV/+zoZ5D22
 ukh8cOU3Jcr7JOyh8P8AY9wG/HamNKJwNqN2OP4FaXEu2stwjHRbrDNYpuTKKwcZnukU7b
 C7hjgNvLrr0xIyKUcVwFPXupZ65NBF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-fN5LOapdOGaN37M-Pzzqag-1; Wed, 10 Jun 2020 00:28:27 -0400
X-MC-Unique: fN5LOapdOGaN37M-Pzzqag-1
Received: by mail-wr1-f69.google.com with SMTP id i6so495871wrr.23
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sJAZsJmFlqScQwmM7L/XMteb8M4v1LBCTCabVI67rS0=;
 b=gzWMZ+BYxPDP6r9krhxye7xidNbE8AQdo+CavoQi/CTmb+iaA93j3pBUDuJ6qMmFC0
 NESrfjdmmWzR0SzlwMIf86A6VyZKMpeJ+EM2qIJyuOFypIcoWMBldYh6QVBJTfmhOdhv
 1cR9N7G2OnNhuj33NNqS3J/i7tEINnZi6XpAMXLjuU7iISH+rz3gb3z6GotNudSj+Upa
 RT8Ged1zVe0RCLUOWSeHZGBeyoNSbGVTOpz1fyzGunhvi5IwDaJsC/XkfycqT95eQsMl
 wTOS+2N5Zg9SCE3RJhbcoSrFlvilvvdnWvb3p6S3I8Gt5ghtqCb2O/l/+Ct0StwkvFzH
 1QAg==
X-Gm-Message-State: AOAM532hodnlKe9QgfRAjo4wKAMFC5IwDQo617dXhiXJ7/iEN8bPXonm
 Fw/AWc3pl4pB059fFmbeRFKakf8SzpY4YEFW7FugMBzTZa6Ab7gSesd5yYB3umExRdxFrIQ9LtU
 18kVBFNfLAuOFVKE=
X-Received: by 2002:adf:f30d:: with SMTP id i13mr1265527wro.146.1591763305741; 
 Tue, 09 Jun 2020 21:28:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9LhWUnx242ss+UZmSa/++ydH/2tTfJuLXr42WFvpGxfus+pXy+V0MN6pimOZ+lKway3z6Jw==
X-Received: by 2002:adf:f30d:: with SMTP id i13mr1265510wro.146.1591763305475; 
 Tue, 09 Jun 2020 21:28:25 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id d191sm5142299wmd.44.2020.06.09.21.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:25 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 49/56] virtio: add vhost-user-vsock base device
Message-ID: <20200610042613.1459309-50-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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


