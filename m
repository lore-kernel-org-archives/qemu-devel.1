Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50397C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1042D20862
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1042D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsU4-0004AJ-Nn
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs67-0005wX-PC
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs64-0004k4-Lf
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs64-0004ju-CP
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:16 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EAF179704
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 22:00:15 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id q80so10626478qke.22
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 15:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ENjDPDkTQfM+R64b71OiLTS95XT1+vdcZmIB6AueRdI=;
 b=MyNNZw1BofmUG4RbbfgzMztRAoWG4sUpuG/ysAzaLcDsHOn7k7jlWZF1oQ2StkXv2E
 at2V3ta6UlXJYE7IaXpRNugvn/saMRUMeenIs79vmoti+X50FxIF2h1i5GnNFwHkjVET
 Ec18kvaKkE5K9IFNAEFKGl6WYvL34T6UL9KT7h4Xv7mQklyUVgxSd5+4Dj0NjE7b85Gu
 TinQw1EpS3f9DptRXm646w9GPjoT2sJdqrC6teStwIlLLh+wTQ1OZThWx0bhTZ2+q8MZ
 7zL+dlYUMvlcLLt7yezwJUoyQMVunmz2nuSZ1M8CIYtSsCm8cOQRClUYoTjfhd5vPLMb
 4Q3A==
X-Gm-Message-State: APjAAAXQYs+HzDVGzGgap72cGC7RDrLuub3gzTBeujdCK3re5+2ww9Uq
 6hZmPF3HcNCO3cLf4bk2tm95hd+ZMVg6bbKofFA1rFd1tr+y6oslBKFI2Kd524DnRDxxOS7YP4Q
 SB809TxXsk2gT5tQ=
X-Received: by 2002:a37:6250:: with SMTP id w77mr16465067qkb.153.1570312814018; 
 Sat, 05 Oct 2019 15:00:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwjgSIF6wuOJAu8SU08XX2u+cKQOQ2GlMS7sU+Ftk791dBEszYDWrAtHD1JXViBhcoaEQOISQ==
X-Received: by 2002:a37:6250:: with SMTP id w77mr16465019qkb.153.1570312813583; 
 Sat, 05 Oct 2019 15:00:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 b130sm5570941qkc.100.2019.10.05.15.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 15:00:12 -0700 (PDT)
Date: Sat, 5 Oct 2019 18:00:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] virtio: add vhost-user-fs base device
Message-ID: <20190930105135.27244-3-dgilbert@redhat.com>
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005220009.ob8iAJrAC1IuJp7AePa90D6HP9cmUnted8DTmABiLUY@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The virtio-fs virtio device provides shared file system access using
the FUSE protocol carried over virtio.
The actual file server is implemented in an external vhost-user-fs device
backend process.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190930105135.27244-3-dgilbert@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 configure                         |  13 ++
 hw/virtio/Makefile.objs           |   1 +
 hw/virtio/vhost-user-fs.c         | 299 ++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-fs.h |  45 +++++
 4 files changed, 358 insertions(+)
 create mode 100644 hw/virtio/vhost-user-fs.c
 create mode 100644 include/hw/virtio/vhost-user-fs.h

diff --git a/configure b/configure
index 8f8446f52b..7bd01b201c 100755
--- a/configure
+++ b/configure
@@ -381,6 +381,7 @@ vhost_crypto=""
 vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
+vhost_user_fs=""
 kvm="no"
 hax="no"
 hvf="no"
@@ -1293,6 +1294,10 @@ for opt do
   ;;
   --enable-vhost-vsock) vhost_vsock="yes"
   ;;
+  --disable-vhost-user-fs) vhost_user_fs="no"
+  ;;
+  --enable-vhost-user-fs) vhost_user_fs="yes"
+  ;;
   --disable-opengl) opengl="no"
   ;;
   --enable-opengl) opengl="yes"
@@ -2236,6 +2241,10 @@ test "$vhost_crypto" = "" && vhost_crypto=$vhost_user
 if test "$vhost_crypto" = "yes" && test "$vhost_user" = "no"; then
   error_exit "--enable-vhost-crypto requires --enable-vhost-user"
 fi
+test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
+if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
+  error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
+fi
 
 # OR the vhost-kernel and vhost-user values for simplicity
 if test "$vhost_net" = ""; then
@@ -6377,6 +6386,7 @@ echo "vhost-crypto support $vhost_crypto"
 echo "vhost-scsi support $vhost_scsi"
 echo "vhost-vsock support $vhost_vsock"
 echo "vhost-user support $vhost_user"
+echo "vhost-user-fs support $vhost_user_fs"
 echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
@@ -6873,6 +6883,9 @@ fi
 if test "$vhost_user" = "yes" ; then
   echo "CONFIG_VHOST_USER=y" >> $config_host_mak
 fi
+if test "$vhost_user_fs" = "yes" ; then
+  echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
+fi
 if test "$blobs" = "yes" ; then
   echo "INSTALL_BLOBS=yes" >> $config_host_mak
 fi
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 964ce78607..47ffbf22c4 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
+obj-$(CONFIG_VHOST_USER_FS) += vhost-user-fs.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
 obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
 common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
new file mode 100644
index 0000000000..f0df7f4746
--- /dev/null
+++ b/hw/virtio/vhost-user-fs.c
@@ -0,0 +1,299 @@
+/*
+ * Vhost-user filesystem virtio device
+ *
+ * Copyright 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  Stefan Hajnoczi <stefanha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include "standard-headers/linux/virtio_fs.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include "qemu/error-report.h"
+#include "hw/virtio/vhost-user-fs.h"
+#include "monitor/monitor.h"
+
+static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+    struct virtio_fs_config fscfg = {};
+
+    memcpy((char *)fscfg.tag, fs->conf.tag,
+           MIN(strlen(fs->conf.tag) + 1, sizeof(fscfg.tag)));
+
+    virtio_stl_p(vdev, &fscfg.num_request_queues, fs->conf.num_request_queues);
+
+    memcpy(config, &fscfg, sizeof(fscfg));
+}
+
+static void vuf_start(VirtIODevice *vdev)
+{
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+    int i;
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return;
+    }
+
+    ret = vhost_dev_enable_notifiers(&fs->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error enabling host notifiers: %d", -ret);
+        return;
+    }
+
+    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier: %d", -ret);
+        goto err_host_notifiers;
+    }
+
+    fs->vhost_dev.acked_features = vdev->guest_features;
+    ret = vhost_dev_start(&fs->vhost_dev, vdev);
+    if (ret < 0) {
+        error_report("Error starting vhost: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
+    /*
+     * guest_notifier_mask/pending not used yet, so just unmask
+     * everything here.  virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i = 0; i < fs->vhost_dev.nvqs; i++) {
+        vhost_virtqueue_mask(&fs->vhost_dev, vdev, i, false);
+    }
+
+    return;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
+}
+
+static void vuf_stop(VirtIODevice *vdev)
+{
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    int ret;
+
+    if (!k->set_guest_notifiers) {
+        return;
+    }
+
+    vhost_dev_stop(&fs->vhost_dev, vdev);
+
+    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
+    if (ret < 0) {
+        error_report("vhost guest notifier cleanup failed: %d", ret);
+        return;
+    }
+
+    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
+}
+
+static void vuf_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
+
+    if (!vdev->vm_running) {
+        should_start = false;
+    }
+
+    if (fs->vhost_dev.started == should_start) {
+        return;
+    }
+
+    if (should_start) {
+        vuf_start(vdev);
+    } else {
+        vuf_stop(vdev);
+    }
+}
+
+static uint64_t vuf_get_features(VirtIODevice *vdev,
+                                      uint64_t requested_features,
+                                      Error **errp)
+{
+    /* No feature bits used yet */
+    return requested_features;
+}
+
+static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    /*
+     * Not normally called; it's the daemon that handles the queue;
+     * however virtio's cleanup path can call this.
+     */
+}
+
+static void vuf_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                            bool mask)
+{
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+
+    vhost_virtqueue_mask(&fs->vhost_dev, vdev, idx, mask);
+}
+
+static bool vuf_guest_notifier_pending(VirtIODevice *vdev, int idx)
+{
+    VHostUserFS *fs = VHOST_USER_FS(vdev);
+
+    return vhost_virtqueue_pending(&fs->vhost_dev, idx);
+}
+
+static void vuf_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserFS *fs = VHOST_USER_FS(dev);
+    unsigned int i;
+    size_t len;
+    int ret;
+
+    if (!fs->conf.chardev.chr) {
+        error_setg(errp, "missing chardev");
+        return;
+    }
+
+    if (!fs->conf.tag) {
+        error_setg(errp, "missing tag property");
+        return;
+    }
+    len = strlen(fs->conf.tag);
+    if (len == 0) {
+        error_setg(errp, "tag property cannot be empty");
+        return;
+    }
+    if (len > sizeof_field(struct virtio_fs_config, tag)) {
+        error_setg(errp, "tag property must be %zu bytes or less",
+                   sizeof_field(struct virtio_fs_config, tag));
+        return;
+    }
+
+    if (fs->conf.num_request_queues == 0) {
+        error_setg(errp, "num-request-queues property must be larger than 0");
+        return;
+    }
+
+    if (!is_power_of_2(fs->conf.queue_size)) {
+        error_setg(errp, "queue-size property must be a power of 2");
+        return;
+    }
+
+    if (fs->conf.queue_size > VIRTQUEUE_MAX_SIZE) {
+        error_setg(errp, "queue-size property must be %u or smaller",
+                   VIRTQUEUE_MAX_SIZE);
+        return;
+    }
+
+    if (!vhost_user_init(&fs->vhost_user, &fs->conf.chardev, errp)) {
+        return;
+    }
+
+    virtio_init(vdev, "vhost-user-fs", VIRTIO_ID_FS,
+                sizeof(struct virtio_fs_config));
+
+    /* Hiprio queue */
+    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+
+    /* Request queues */
+    for (i = 0; i < fs->conf.num_request_queues; i++) {
+        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+    }
+
+    /* 1 high prio queue, plus the number configured */
+    fs->vhost_dev.nvqs = 1 + fs->conf.num_request_queues;
+    fs->vhost_dev.vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
+    ret = vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
+                         VHOST_BACKEND_TYPE_USER, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vhost_dev_init failed");
+        goto err_virtio;
+    }
+
+    return;
+
+err_virtio:
+    vhost_user_cleanup(&fs->vhost_user);
+    virtio_cleanup(vdev);
+    g_free(fs->vhost_dev.vqs);
+    return;
+}
+
+static void vuf_device_unrealize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserFS *fs = VHOST_USER_FS(dev);
+
+    /* This will stop vhost backend if appropriate. */
+    vuf_set_status(vdev, 0);
+
+    vhost_dev_cleanup(&fs->vhost_dev);
+
+    vhost_user_cleanup(&fs->vhost_user);
+
+    virtio_cleanup(vdev);
+    g_free(fs->vhost_dev.vqs);
+    fs->vhost_dev.vqs = NULL;
+}
+
+static const VMStateDescription vuf_vmstate = {
+    .name = "vhost-user-fs",
+    .unmigratable = 1,
+};
+
+static Property vuf_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
+    DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
+    DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
+                       conf.num_request_queues, 1),
+    DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 128),
+    DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vuf_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    dc->props = vuf_properties;
+    dc->vmsd = &vuf_vmstate;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    vdc->realize = vuf_device_realize;
+    vdc->unrealize = vuf_device_unrealize;
+    vdc->get_features = vuf_get_features;
+    vdc->get_config = vuf_get_config;
+    vdc->set_status = vuf_set_status;
+    vdc->guest_notifier_mask = vuf_guest_notifier_mask;
+    vdc->guest_notifier_pending = vuf_guest_notifier_pending;
+}
+
+static const TypeInfo vuf_info = {
+    .name = TYPE_VHOST_USER_FS,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VHostUserFS),
+    .class_init = vuf_class_init,
+};
+
+static void vuf_register_types(void)
+{
+    type_register_static(&vuf_info);
+}
+
+type_init(vuf_register_types)
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
new file mode 100644
index 0000000000..539885b458
--- /dev/null
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -0,0 +1,45 @@
+/*
+ * Vhost-user filesystem virtio device
+ *
+ * Copyright 2018-2019 Red Hat, Inc.
+ *
+ * Authors:
+ *  Stefan Hajnoczi <stefanha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#ifndef _QEMU_VHOST_USER_FS_H
+#define _QEMU_VHOST_USER_FS_H
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "chardev/char-fe.h"
+
+#define TYPE_VHOST_USER_FS "vhost-user-fs-device"
+#define VHOST_USER_FS(obj) \
+        OBJECT_CHECK(VHostUserFS, (obj), TYPE_VHOST_USER_FS)
+
+typedef struct {
+    CharBackend chardev;
+    char *tag;
+    uint16_t num_request_queues;
+    uint16_t queue_size;
+    char *vhostfd;
+} VHostUserFSConf;
+
+typedef struct {
+    /*< private >*/
+    VirtIODevice parent;
+    VHostUserFSConf conf;
+    struct vhost_virtqueue *vhost_vqs;
+    struct vhost_dev vhost_dev;
+    VhostUserState vhost_user;
+
+    /*< public >*/
+} VHostUserFS;
+
+#endif /* _QEMU_VHOST_USER_FS_H */
-- 
MST


