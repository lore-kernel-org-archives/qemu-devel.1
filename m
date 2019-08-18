Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F03C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 11:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9CC206C1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 11:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9CC206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzJ3u-0006y8-JR
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 07:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1hzJ3D-0006Y2-JV
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 07:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hzJ3A-000565-Lc
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 07:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hzJ3A-00054h-C6
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 07:08:40 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32D165945B
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 11:08:38 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id p56so745748qtb.10
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 04:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jRq0hEH2THBLWdKSSxk7tuIIHKZrpaOtQE56I4wsMmE=;
 b=MY1P8cU7Vac/p8lkijcnk2riYJWa8YnjI/U1KD1d4Fz8mbA6egt554d9LlUOTNofuO
 22atNLHYpHTHJsAy2FiudZPZUT5pB3FQZ8TS1jsLOFqZRrEu6lBNY7An207Zxf9UQHgu
 FPvnFRKqLzuvgCac5y3aAYuNTUI88jStV/bpr2av4EQZP5aVH+JLPaa5ZaTHFOVztiDJ
 FXRV4ZBsQ7ppHmDPjl1NvSs7NQJkKBVb3/KDSljS6fgr9hWeBYMq/v26bgmnuAp0srfd
 WZwbIf8YsMwC9ybRkCi4T4qxTZdJWaL0xRgo4ljoKbKb/eBYjBdlPPJyT+duisbaZjQ+
 lqyg==
X-Gm-Message-State: APjAAAU+pxhHOxnL8Q9Uj0lLOmke2eFjpacMM7RuinfI+CxWW+/NZ3+d
 EB3FZqXaFewo/oPu378kK2aOz8gp4IvdIBEMBQ/B2+aDGqehU/pEsOy7xtZm69djy9+zRshCKlf
 zgPZCjQe1VSe2TD4=
X-Received: by 2002:a05:620a:70f:: with SMTP id
 15mr16354454qkc.171.1566126517445; 
 Sun, 18 Aug 2019 04:08:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwthh6JMjEh/XG9BjQqkfSuUijLLRj0AVRa4FXZKR6ElDefL3gwisw+QhDEJFmp+sLOYGLGEA==
X-Received: by 2002:a05:620a:70f:: with SMTP id
 15mr16354441qkc.171.1566126517148; 
 Sun, 18 Aug 2019 04:08:37 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
 by smtp.gmail.com with ESMTPSA id d9sm5466950qke.136.2019.08.18.04.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2019 04:08:36 -0700 (PDT)
Date: Sun, 18 Aug 2019 07:08:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190818065944-mutt-send-email-mst@kernel.org>
References: <20190816143321.20903-1-dgilbert@redhat.com>
 <20190816143321.20903-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816143321.20903-2-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio: add vhost-user-fs base device
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 03:33:20PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The virtio-fs virtio device provides shared file system access using
> the FUSE protocol carried ovew virtio.
> The actual file server is implemented in an external vhost-user-fs device
> backend process.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  configure                                   |  13 +
>  hw/virtio/Makefile.objs                     |   1 +
>  hw/virtio/vhost-user-fs.c                   | 297 ++++++++++++++++++++
>  include/hw/virtio/vhost-user-fs.h           |  45 +++
>  include/standard-headers/linux/virtio_fs.h  |  41 +++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  6 files changed, 398 insertions(+)
>  create mode 100644 hw/virtio/vhost-user-fs.c
>  create mode 100644 include/hw/virtio/vhost-user-fs.h
>  create mode 100644 include/standard-headers/linux/virtio_fs.h
> 
> diff --git a/configure b/configure
> index 714e7fb6a1..e7e33ee783 100755
> --- a/configure
> +++ b/configure
> @@ -382,6 +382,7 @@ vhost_crypto=""
>  vhost_scsi=""
>  vhost_vsock=""
>  vhost_user=""
> +vhost_user_fs=""
>  kvm="no"
>  hax="no"
>  hvf="no"
> @@ -1316,6 +1317,10 @@ for opt do
>    ;;
>    --enable-vhost-vsock) vhost_vsock="yes"
>    ;;
> +  --disable-vhost-user-fs) vhost_user_fs="no"
> +  ;;
> +  --enable-vhost-user-fs) vhost_user_fs="yes"
> +  ;;
>    --disable-opengl) opengl="no"
>    ;;
>    --enable-opengl) opengl="yes"
> @@ -2269,6 +2274,10 @@ test "$vhost_crypto" = "" && vhost_crypto=$vhost_user
>  if test "$vhost_crypto" = "yes" && test "$vhost_user" = "no"; then
>    error_exit "--enable-vhost-crypto requires --enable-vhost-user"
>  fi
> +test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
> +if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
> +  error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
> +fi
>  
>  # OR the vhost-kernel and vhost-user values for simplicity
>  if test "$vhost_net" = ""; then
> @@ -6425,6 +6434,7 @@ echo "vhost-crypto support $vhost_crypto"
>  echo "vhost-scsi support $vhost_scsi"
>  echo "vhost-vsock support $vhost_vsock"
>  echo "vhost-user support $vhost_user"
> +echo "vhost-user-fs support $vhost_user_fs"
>  echo "Trace backends    $trace_backends"
>  if have_backend "simple"; then
>  echo "Trace output file $trace_file-<pid>"
> @@ -6921,6 +6931,9 @@ fi
>  if test "$vhost_user" = "yes" ; then
>    echo "CONFIG_VHOST_USER=y" >> $config_host_mak
>  fi
> +if test "$vhost_user_fs" = "yes" ; then
> +  echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
> +fi
>  if test "$blobs" = "yes" ; then
>    echo "INSTALL_BLOBS=yes" >> $config_host_mak
>  fi
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 964ce78607..47ffbf22c4 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
>  common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
>  obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
> +obj-$(CONFIG_VHOST_USER_FS) += vhost-user-fs.o
>  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
>  obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
>  common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> new file mode 100644
> index 0000000000..2753c2c07a
> --- /dev/null
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -0,0 +1,297 @@
> +/*
> + * Vhost-user filesystem virtio device
> + *
> + * Copyright 2018 Red Hat, Inc.
> + *
> + * Authors:
> + *  Stefan Hajnoczi <stefanha@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +#include "standard-headers/linux/virtio_fs.h"
> +#include "qapi/error.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/virtio-access.h"
> +#include "qemu/error-report.h"
> +#include "hw/virtio/vhost-user-fs.h"
> +#include "monitor/monitor.h"
> +
> +static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +    struct virtio_fs_config fscfg = {};
> +
> +    memcpy((char *)fscfg.tag, fs->conf.tag,
> +           MIN(strlen(fs->conf.tag) + 1, sizeof(fscfg.tag)));
> +
> +    virtio_stl_p(vdev, &fscfg.num_queues, fs->conf.num_queues);
> +
> +    memcpy(config, &fscfg, sizeof(fscfg));
> +}
> +
> +static void vuf_start(VirtIODevice *vdev)
> +{
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +    int ret;
> +    int i;
> +
> +    if (!k->set_guest_notifiers) {
> +        error_report("binding does not support guest notifiers");
> +        return;
> +    }
> +
> +    ret = vhost_dev_enable_notifiers(&fs->vhost_dev, vdev);
> +    if (ret < 0) {
> +        error_report("Error enabling host notifiers: %d", -ret);
> +        return;
> +    }
> +
> +    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, true);
> +    if (ret < 0) {
> +        error_report("Error binding guest notifier: %d", -ret);
> +        goto err_host_notifiers;
> +    }
> +
> +    fs->vhost_dev.acked_features = vdev->guest_features;
> +    ret = vhost_dev_start(&fs->vhost_dev, vdev);
> +    if (ret < 0) {
> +        error_report("Error starting vhost: %d", -ret);
> +        goto err_guest_notifiers;
> +    }
> +
> +    /*
> +     * guest_notifier_mask/pending not used yet, so just unmask
> +     * everything here.  virtio-pci will do the right thing by
> +     * enabling/disabling irqfd.
> +     */
> +    for (i = 0; i < fs->vhost_dev.nvqs; i++) {
> +        vhost_virtqueue_mask(&fs->vhost_dev, vdev, i, false);
> +    }
> +
> +    return;
> +
> +err_guest_notifiers:
> +    k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
> +err_host_notifiers:
> +    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
> +}
> +
> +static void vuf_stop(VirtIODevice *vdev)
> +{
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +    int ret;
> +
> +    if (!k->set_guest_notifiers) {
> +        return;
> +    }
> +
> +    vhost_dev_stop(&fs->vhost_dev, vdev);
> +
> +    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
> +    if (ret < 0) {
> +        error_report("vhost guest notifier cleanup failed: %d", ret);
> +        return;
> +    }
> +
> +    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
> +}
> +
> +static void vuf_set_status(VirtIODevice *vdev, uint8_t status)
> +{
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
> +
> +    if (!vdev->vm_running) {
> +        should_start = false;
> +    }
> +
> +    if (fs->vhost_dev.started == should_start) {
> +        return;
> +    }
> +
> +    if (should_start) {
> +        vuf_start(vdev);
> +    } else {
> +        vuf_stop(vdev);
> +    }
> +}
> +
> +static uint64_t vuf_get_features(VirtIODevice *vdev,
> +                                      uint64_t requested_features,
> +                                      Error **errp)
> +{
> +    /* No feature bits used yet */
> +    return requested_features;
> +}
> +
> +static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    /* Do nothing */

Why is this safe?  Is this because this never triggers?  assert(0) then?
If it triggers then backend won't be notified, which might
cause it to get stuck.

> +}
> +
> +static void vuf_guest_notifier_mask(VirtIODevice *vdev, int idx,
> +                                            bool mask)
> +{
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +
> +    vhost_virtqueue_mask(&fs->vhost_dev, vdev, idx, mask);
> +}
> +
> +static bool vuf_guest_notifier_pending(VirtIODevice *vdev, int idx)
> +{
> +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> +
> +    return vhost_virtqueue_pending(&fs->vhost_dev, idx);
> +}
> +
> +static void vuf_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserFS *fs = VHOST_USER_FS(dev);
> +    unsigned int i;
> +    size_t len;
> +    int ret;
> +
> +    if (!fs->conf.chardev.chr) {
> +        error_setg(errp, "missing chardev");
> +        return;
> +    }
> +
> +    if (!fs->conf.tag) {
> +        error_setg(errp, "missing tag property");
> +        return;
> +    }
> +    len = strlen(fs->conf.tag);
> +    if (len == 0) {
> +        error_setg(errp, "tag property cannot be empty");
> +        return;
> +    }
> +    if (len > sizeof_field(struct virtio_fs_config, tag)) {
> +        error_setg(errp, "tag property must be %zu bytes or less",
> +                   sizeof_field(struct virtio_fs_config, tag));
> +        return;
> +    }
> +
> +    if (fs->conf.num_queues == 0) {
> +        error_setg(errp, "num-queues property must be larger than 0");
> +        return;
> +    }

The strange thing is that actual # of queues is this number + 2.
And this affects an optimal number of vectors (see patch 2).
Not sure what a good solution is - include the
mandatory queues in the number?
Needs to be documented in some way.

> +
> +    if (!is_power_of_2(fs->conf.queue_size)) {
> +        error_setg(errp, "queue-size property must be a power of 2");
> +        return;
> +    }

Hmm packed ring allows non power of 2 ...
We need to look into a generic helper to support VQ
size checks.

> +
> +    if (fs->conf.queue_size > VIRTQUEUE_MAX_SIZE) {
> +        error_setg(errp, "queue-size property must be %u or smaller",
> +                   VIRTQUEUE_MAX_SIZE);
> +        return;
> +    }
> +
> +    if (!vhost_user_init(&fs->vhost_user, &fs->conf.chardev, errp)) {
> +        return;
> +    }
> +
> +    virtio_init(vdev, "vhost-user-fs", VIRTIO_ID_FS,
> +                sizeof(struct virtio_fs_config));
> +
> +    /* Notifications queue */
> +    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> +
> +    /* Hiprio queue */
> +    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
>

Weird, spec patch v6 says:

+\item[0] hiprio
+\item[1\ldots n] request queues

where's the Notifications queue coming from?

> +    /* Request queues */
> +    for (i = 0; i < fs->conf.num_queues; i++) {
> +        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> +    }
> +
> +    /* 1 high prio queue, plus the number configured */
> +    fs->vhost_dev.nvqs = 1 + fs->conf.num_queues;
> +    fs->vhost_dev.vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
> +    ret = vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
> +                         VHOST_BACKEND_TYPE_USER, 0);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "vhost_dev_init failed");
> +        goto err_virtio;
> +    }
> +
> +    return;
> +
> +err_virtio:
> +    vhost_user_cleanup(&fs->vhost_user);
> +    virtio_cleanup(vdev);
> +    g_free(fs->vhost_dev.vqs);
> +    return;
> +}
> +
> +static void vuf_device_unrealize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserFS *fs = VHOST_USER_FS(dev);
> +
> +    /* This will stop vhost backend if appropriate. */
> +    vuf_set_status(vdev, 0);
> +
> +    vhost_dev_cleanup(&fs->vhost_dev);
> +
> +    vhost_user_cleanup(&fs->vhost_user);
> +
> +    virtio_cleanup(vdev);
> +    g_free(fs->vhost_dev.vqs);
> +    fs->vhost_dev.vqs = NULL;
> +}
> +
> +static const VMStateDescription vuf_vmstate = {
> +    .name = "vhost-user-fs",
> +    .unmigratable = 1,
> +};
> +
> +static Property vuf_properties[] = {
> +    DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
> +    DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
> +    DEFINE_PROP_UINT16("num-queues", VHostUserFS, conf.num_queues, 1),
> +    DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 128),
> +    DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vuf_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +
> +    dc->props = vuf_properties;
> +    dc->vmsd = &vuf_vmstate;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    vdc->realize = vuf_device_realize;
> +    vdc->unrealize = vuf_device_unrealize;
> +    vdc->get_features = vuf_get_features;
> +    vdc->get_config = vuf_get_config;
> +    vdc->set_status = vuf_set_status;
> +    vdc->guest_notifier_mask = vuf_guest_notifier_mask;
> +    vdc->guest_notifier_pending = vuf_guest_notifier_pending;
> +}
> +
> +static const TypeInfo vuf_info = {
> +    .name = TYPE_VHOST_USER_FS,
> +    .parent = TYPE_VIRTIO_DEVICE,
> +    .instance_size = sizeof(VHostUserFS),
> +    .class_init = vuf_class_init,
> +};
> +
> +static void vuf_register_types(void)
> +{
> +    type_register_static(&vuf_info);
> +}
> +
> +type_init(vuf_register_types)
> diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
> new file mode 100644
> index 0000000000..d07ab134b9
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-fs.h
> @@ -0,0 +1,45 @@
> +/*
> + * Vhost-user filesystem virtio device
> + *
> + * Copyright 2018 Red Hat, Inc.
> + *
> + * Authors:
> + *  Stefan Hajnoczi <stefanha@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#ifndef _QEMU_VHOST_USER_FS_H
> +#define _QEMU_VHOST_USER_FS_H
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
> +#include "chardev/char-fe.h"
> +
> +#define TYPE_VHOST_USER_FS "x-vhost-user-fs-device"
> +#define VHOST_USER_FS(obj) \
> +        OBJECT_CHECK(VHostUserFS, (obj), TYPE_VHOST_USER_FS)
> +
> +typedef struct {
> +    CharBackend chardev;
> +    char *tag;
> +    uint16_t num_queues;
> +    uint16_t queue_size;
> +    char *vhostfd;
> +} VHostUserFSConf;
> +
> +typedef struct {
> +    /*< private >*/
> +    VirtIODevice parent;
> +    VHostUserFSConf conf;
> +    struct vhost_virtqueue *vhost_vqs;
> +    struct vhost_dev vhost_dev;
> +    VhostUserState vhost_user;
> +
> +    /*< public >*/
> +} VHostUserFS;
> +
> +#endif /* _QEMU_VHOST_USER_FS_H */
> diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standard-headers/linux/virtio_fs.h
> new file mode 100644
> index 0000000000..4f811a0b70
> --- /dev/null
> +++ b/include/standard-headers/linux/virtio_fs.h
> @@ -0,0 +1,41 @@
> +#ifndef _LINUX_VIRTIO_FS_H
> +#define _LINUX_VIRTIO_FS_H
> +/* This header is BSD licensed so anyone can use the definitions to implement
> + * compatible drivers/servers.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the name of IBM nor the names of its contributors
> + *    may be used to endorse or promote products derived from this software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE. */
> +#include "standard-headers/linux/types.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_config.h"
> +#include "standard-headers/linux/virtio_types.h"
> +
> +struct virtio_fs_config {
> +	/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
> +	uint8_t tag[36];
> +
> +	/* Number of request queues */
> +	uint32_t num_queues;
> +} QEMU_PACKED;
> +
> +#endif /* _LINUX_VIRTIO_FS_H */
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 32b2f94d1f..73fc004807 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -43,6 +43,7 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_FS           26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM         27 /* virtio pmem */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.21.0

