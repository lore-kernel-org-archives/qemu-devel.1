Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364ADC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F080A21655
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F080A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHNSE-0005tx-6Y
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 03:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iHNRN-0005Sw-AJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iHNRL-0003AV-9r
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iHNRL-0003A0-04
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:28:19 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5D014E83E
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 07:28:16 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id x62so14090947qkb.7
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 00:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XfYj01JLH1q2Xq2zuKkWYYDUvZbu7w+UW119DeBf/X4=;
 b=pFanDbwg1/ybjkXPCairwh1bo84/n5m/Q2js6F2fi3e0LoJI9EYqyb4jXEUOvlpzdM
 xDGb4dSEUBXdyEkUCiG34WEPHi9/mSeeDr/JmZaw9rkLSWHVTxWnYd9xFnf0bwQOiGrS
 Veu3A/1TY0BIYzsyYWziREIfbirPQ6UaND+N0KHx75QObFtZgc5QsZFogRWobF0oD7v6
 qRz32qFb8dwxoArpZAb7Y4doW3idkRyrbzpVrWG2sCPnETw8OJjlDUvfB49cTYF7ZLJ5
 yLENoFKrapztItCPgnhAx5uW8uB1ndOgLrENS9OzzCdk/8m/+zwxcwhqsKrlj5Upr1He
 y/XQ==
X-Gm-Message-State: APjAAAWqOK90FJy4wZJ5ss8ySDHylYSNk+PGyX43TG75aQevWSehdygE
 qBHCAYXjMwXu1zsoAF3XNnYQzqHi/LZtp6YRm7/wL1Sc8YXOglZw0NaW5cZSvqgHdcM8NpVrt5o
 7LJ/mTt6jifQeqmM=
X-Received: by 2002:aed:38c7:: with SMTP id k65mr29263489qte.251.1570433296093; 
 Mon, 07 Oct 2019 00:28:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy3MCTSorv8L/u+2rMjL+606pxeVqM+5uRwNFl59c2kaDMEnW4uIlRLeW2Rp+PhNW6Omd1UbA==
X-Received: by 2002:aed:38c7:: with SMTP id k65mr29263471qte.251.1570433295740; 
 Mon, 07 Oct 2019 00:28:15 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 p7sm7280565qkc.21.2019.10.07.00.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 00:28:14 -0700 (PDT)
Date: Mon, 7 Oct 2019 03:28:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PULL 18/19] virtio: add vhost-user-fs base device
Message-ID: <20191007032312-mutt-send-email-mst@kernel.org>
References: <20191005215508.28754-1-mst@redhat.com>
 <20190930105135.27244-3-dgilbert@redhat.com>
 <20191007075704.35e7d1c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007075704.35e7d1c1@redhat.com>
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
 Sebastien Boeuf <sebastien.boeuf@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 07:57:04AM +0200, Igor Mammedov wrote:
> On Sat, 5 Oct 2019 18:00:09 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > The virtio-fs virtio device provides shared file system access using
> > the FUSE protocol carried over virtio.
> > The actual file server is implemented in an external vhost-user-fs device
> > backend process.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Message-Id: <20190930105135.27244-3-dgilbert@redhat.com>
> > Acked-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Michael,
> 
> looks like your script for sending pull req is still broken,
> 
> this patch in pull req has the same
>     Message-ID: <20190930105135.27244-3-dgilbert@redhat.com>
> as the original email
>     [PATCH v4 2/3] virtio: add vhost-user-fs base device
> even though body differs from original,
> which breaks threading on email client side.
> 
> Could you fix it please?


Finally figured it out. It was picking up the last
Message-ID ignoring the mail header boundaries.

Fixed, thanks for the patience!

> 
> 
> > ---
> >  configure                         |  13 ++
> >  hw/virtio/Makefile.objs           |   1 +
> >  hw/virtio/vhost-user-fs.c         | 299 ++++++++++++++++++++++++++++++
> >  include/hw/virtio/vhost-user-fs.h |  45 +++++
> >  4 files changed, 358 insertions(+)
> >  create mode 100644 hw/virtio/vhost-user-fs.c
> >  create mode 100644 include/hw/virtio/vhost-user-fs.h
> > 
> > diff --git a/configure b/configure
> > index 8f8446f52b..7bd01b201c 100755
> > --- a/configure
> > +++ b/configure
> > @@ -381,6 +381,7 @@ vhost_crypto=""
> >  vhost_scsi=""
> >  vhost_vsock=""
> >  vhost_user=""
> > +vhost_user_fs=""
> >  kvm="no"
> >  hax="no"
> >  hvf="no"
> > @@ -1293,6 +1294,10 @@ for opt do
> >    ;;
> >    --enable-vhost-vsock) vhost_vsock="yes"
> >    ;;
> > +  --disable-vhost-user-fs) vhost_user_fs="no"
> > +  ;;
> > +  --enable-vhost-user-fs) vhost_user_fs="yes"
> > +  ;;
> >    --disable-opengl) opengl="no"
> >    ;;
> >    --enable-opengl) opengl="yes"
> > @@ -2236,6 +2241,10 @@ test "$vhost_crypto" = "" && vhost_crypto=$vhost_user
> >  if test "$vhost_crypto" = "yes" && test "$vhost_user" = "no"; then
> >    error_exit "--enable-vhost-crypto requires --enable-vhost-user"
> >  fi
> > +test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
> > +if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
> > +  error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
> > +fi
> >  
> >  # OR the vhost-kernel and vhost-user values for simplicity
> >  if test "$vhost_net" = ""; then
> > @@ -6377,6 +6386,7 @@ echo "vhost-crypto support $vhost_crypto"
> >  echo "vhost-scsi support $vhost_scsi"
> >  echo "vhost-vsock support $vhost_vsock"
> >  echo "vhost-user support $vhost_user"
> > +echo "vhost-user-fs support $vhost_user_fs"
> >  echo "Trace backends    $trace_backends"
> >  if have_backend "simple"; then
> >  echo "Trace output file $trace_file-<pid>"
> > @@ -6873,6 +6883,9 @@ fi
> >  if test "$vhost_user" = "yes" ; then
> >    echo "CONFIG_VHOST_USER=y" >> $config_host_mak
> >  fi
> > +if test "$vhost_user_fs" = "yes" ; then
> > +  echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
> > +fi
> >  if test "$blobs" = "yes" ; then
> >    echo "INSTALL_BLOBS=yes" >> $config_host_mak
> >  fi
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > index 964ce78607..47ffbf22c4 100644
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
> >  common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
> >  obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
> >  obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
> > +obj-$(CONFIG_VHOST_USER_FS) += vhost-user-fs.o
> >  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
> >  obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
> >  common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
> > diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> > new file mode 100644
> > index 0000000000..f0df7f4746
> > --- /dev/null
> > +++ b/hw/virtio/vhost-user-fs.c
> > @@ -0,0 +1,299 @@
> > +/*
> > + * Vhost-user filesystem virtio device
> > + *
> > + * Copyright 2018-2019 Red Hat, Inc.
> > + *
> > + * Authors:
> > + *  Stefan Hajnoczi <stefanha@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include <sys/ioctl.h>
> > +#include "standard-headers/linux/virtio_fs.h"
> > +#include "qapi/error.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/virtio/virtio-bus.h"
> > +#include "hw/virtio/virtio-access.h"
> > +#include "qemu/error-report.h"
> > +#include "hw/virtio/vhost-user-fs.h"
> > +#include "monitor/monitor.h"
> > +
> > +static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
> > +{
> > +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> > +    struct virtio_fs_config fscfg = {};
> > +
> > +    memcpy((char *)fscfg.tag, fs->conf.tag,
> > +           MIN(strlen(fs->conf.tag) + 1, sizeof(fscfg.tag)));
> > +
> > +    virtio_stl_p(vdev, &fscfg.num_request_queues, fs->conf.num_request_queues);
> > +
> > +    memcpy(config, &fscfg, sizeof(fscfg));
> > +}
> > +
> > +static void vuf_start(VirtIODevice *vdev)
> > +{
> > +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> > +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> > +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> > +    int ret;
> > +    int i;
> > +
> > +    if (!k->set_guest_notifiers) {
> > +        error_report("binding does not support guest notifiers");
> > +        return;
> > +    }
> > +
> > +    ret = vhost_dev_enable_notifiers(&fs->vhost_dev, vdev);
> > +    if (ret < 0) {
> > +        error_report("Error enabling host notifiers: %d", -ret);
> > +        return;
> > +    }
> > +
> > +    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, true);
> > +    if (ret < 0) {
> > +        error_report("Error binding guest notifier: %d", -ret);
> > +        goto err_host_notifiers;
> > +    }
> > +
> > +    fs->vhost_dev.acked_features = vdev->guest_features;
> > +    ret = vhost_dev_start(&fs->vhost_dev, vdev);
> > +    if (ret < 0) {
> > +        error_report("Error starting vhost: %d", -ret);
> > +        goto err_guest_notifiers;
> > +    }
> > +
> > +    /*
> > +     * guest_notifier_mask/pending not used yet, so just unmask
> > +     * everything here.  virtio-pci will do the right thing by
> > +     * enabling/disabling irqfd.
> > +     */
> > +    for (i = 0; i < fs->vhost_dev.nvqs; i++) {
> > +        vhost_virtqueue_mask(&fs->vhost_dev, vdev, i, false);
> > +    }
> > +
> > +    return;
> > +
> > +err_guest_notifiers:
> > +    k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
> > +err_host_notifiers:
> > +    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
> > +}
> > +
> > +static void vuf_stop(VirtIODevice *vdev)
> > +{
> > +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> > +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> > +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> > +    int ret;
> > +
> > +    if (!k->set_guest_notifiers) {
> > +        return;
> > +    }
> > +
> > +    vhost_dev_stop(&fs->vhost_dev, vdev);
> > +
> > +    ret = k->set_guest_notifiers(qbus->parent, fs->vhost_dev.nvqs, false);
> > +    if (ret < 0) {
> > +        error_report("vhost guest notifier cleanup failed: %d", ret);
> > +        return;
> > +    }
> > +
> > +    vhost_dev_disable_notifiers(&fs->vhost_dev, vdev);
> > +}
> > +
> > +static void vuf_set_status(VirtIODevice *vdev, uint8_t status)
> > +{
> > +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> > +    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
> > +
> > +    if (!vdev->vm_running) {
> > +        should_start = false;
> > +    }
> > +
> > +    if (fs->vhost_dev.started == should_start) {
> > +        return;
> > +    }
> > +
> > +    if (should_start) {
> > +        vuf_start(vdev);
> > +    } else {
> > +        vuf_stop(vdev);
> > +    }
> > +}
> > +
> > +static uint64_t vuf_get_features(VirtIODevice *vdev,
> > +                                      uint64_t requested_features,
> > +                                      Error **errp)
> > +{
> > +    /* No feature bits used yet */
> > +    return requested_features;
> > +}
> > +
> > +static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    /*
> > +     * Not normally called; it's the daemon that handles the queue;
> > +     * however virtio's cleanup path can call this.
> > +     */
> > +}
> > +
> > +static void vuf_guest_notifier_mask(VirtIODevice *vdev, int idx,
> > +                                            bool mask)
> > +{
> > +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> > +
> > +    vhost_virtqueue_mask(&fs->vhost_dev, vdev, idx, mask);
> > +}
> > +
> > +static bool vuf_guest_notifier_pending(VirtIODevice *vdev, int idx)
> > +{
> > +    VHostUserFS *fs = VHOST_USER_FS(vdev);
> > +
> > +    return vhost_virtqueue_pending(&fs->vhost_dev, idx);
> > +}
> > +
> > +static void vuf_device_realize(DeviceState *dev, Error **errp)
> > +{
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > +    VHostUserFS *fs = VHOST_USER_FS(dev);
> > +    unsigned int i;
> > +    size_t len;
> > +    int ret;
> > +
> > +    if (!fs->conf.chardev.chr) {
> > +        error_setg(errp, "missing chardev");
> > +        return;
> > +    }
> > +
> > +    if (!fs->conf.tag) {
> > +        error_setg(errp, "missing tag property");
> > +        return;
> > +    }
> > +    len = strlen(fs->conf.tag);
> > +    if (len == 0) {
> > +        error_setg(errp, "tag property cannot be empty");
> > +        return;
> > +    }
> > +    if (len > sizeof_field(struct virtio_fs_config, tag)) {
> > +        error_setg(errp, "tag property must be %zu bytes or less",
> > +                   sizeof_field(struct virtio_fs_config, tag));
> > +        return;
> > +    }
> > +
> > +    if (fs->conf.num_request_queues == 0) {
> > +        error_setg(errp, "num-request-queues property must be larger than 0");
> > +        return;
> > +    }
> > +
> > +    if (!is_power_of_2(fs->conf.queue_size)) {
> > +        error_setg(errp, "queue-size property must be a power of 2");
> > +        return;
> > +    }
> > +
> > +    if (fs->conf.queue_size > VIRTQUEUE_MAX_SIZE) {
> > +        error_setg(errp, "queue-size property must be %u or smaller",
> > +                   VIRTQUEUE_MAX_SIZE);
> > +        return;
> > +    }
> > +
> > +    if (!vhost_user_init(&fs->vhost_user, &fs->conf.chardev, errp)) {
> > +        return;
> > +    }
> > +
> > +    virtio_init(vdev, "vhost-user-fs", VIRTIO_ID_FS,
> > +                sizeof(struct virtio_fs_config));
> > +
> > +    /* Hiprio queue */
> > +    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> > +
> > +    /* Request queues */
> > +    for (i = 0; i < fs->conf.num_request_queues; i++) {
> > +        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> > +    }
> > +
> > +    /* 1 high prio queue, plus the number configured */
> > +    fs->vhost_dev.nvqs = 1 + fs->conf.num_request_queues;
> > +    fs->vhost_dev.vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
> > +    ret = vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
> > +                         VHOST_BACKEND_TYPE_USER, 0);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "vhost_dev_init failed");
> > +        goto err_virtio;
> > +    }
> > +
> > +    return;
> > +
> > +err_virtio:
> > +    vhost_user_cleanup(&fs->vhost_user);
> > +    virtio_cleanup(vdev);
> > +    g_free(fs->vhost_dev.vqs);
> > +    return;
> > +}
> > +
> > +static void vuf_device_unrealize(DeviceState *dev, Error **errp)
> > +{
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > +    VHostUserFS *fs = VHOST_USER_FS(dev);
> > +
> > +    /* This will stop vhost backend if appropriate. */
> > +    vuf_set_status(vdev, 0);
> > +
> > +    vhost_dev_cleanup(&fs->vhost_dev);
> > +
> > +    vhost_user_cleanup(&fs->vhost_user);
> > +
> > +    virtio_cleanup(vdev);
> > +    g_free(fs->vhost_dev.vqs);
> > +    fs->vhost_dev.vqs = NULL;
> > +}
> > +
> > +static const VMStateDescription vuf_vmstate = {
> > +    .name = "vhost-user-fs",
> > +    .unmigratable = 1,
> > +};
> > +
> > +static Property vuf_properties[] = {
> > +    DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
> > +    DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
> > +    DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
> > +                       conf.num_request_queues, 1),
> > +    DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 128),
> > +    DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void vuf_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> > +
> > +    dc->props = vuf_properties;
> > +    dc->vmsd = &vuf_vmstate;
> > +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > +    vdc->realize = vuf_device_realize;
> > +    vdc->unrealize = vuf_device_unrealize;
> > +    vdc->get_features = vuf_get_features;
> > +    vdc->get_config = vuf_get_config;
> > +    vdc->set_status = vuf_set_status;
> > +    vdc->guest_notifier_mask = vuf_guest_notifier_mask;
> > +    vdc->guest_notifier_pending = vuf_guest_notifier_pending;
> > +}
> > +
> > +static const TypeInfo vuf_info = {
> > +    .name = TYPE_VHOST_USER_FS,
> > +    .parent = TYPE_VIRTIO_DEVICE,
> > +    .instance_size = sizeof(VHostUserFS),
> > +    .class_init = vuf_class_init,
> > +};
> > +
> > +static void vuf_register_types(void)
> > +{
> > +    type_register_static(&vuf_info);
> > +}
> > +
> > +type_init(vuf_register_types)
> > diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
> > new file mode 100644
> > index 0000000000..539885b458
> > --- /dev/null
> > +++ b/include/hw/virtio/vhost-user-fs.h
> > @@ -0,0 +1,45 @@
> > +/*
> > + * Vhost-user filesystem virtio device
> > + *
> > + * Copyright 2018-2019 Red Hat, Inc.
> > + *
> > + * Authors:
> > + *  Stefan Hajnoczi <stefanha@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#ifndef _QEMU_VHOST_USER_FS_H
> > +#define _QEMU_VHOST_USER_FS_H
> > +
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/vhost.h"
> > +#include "hw/virtio/vhost-user.h"
> > +#include "chardev/char-fe.h"
> > +
> > +#define TYPE_VHOST_USER_FS "vhost-user-fs-device"
> > +#define VHOST_USER_FS(obj) \
> > +        OBJECT_CHECK(VHostUserFS, (obj), TYPE_VHOST_USER_FS)
> > +
> > +typedef struct {
> > +    CharBackend chardev;
> > +    char *tag;
> > +    uint16_t num_request_queues;
> > +    uint16_t queue_size;
> > +    char *vhostfd;
> > +} VHostUserFSConf;
> > +
> > +typedef struct {
> > +    /*< private >*/
> > +    VirtIODevice parent;
> > +    VHostUserFSConf conf;
> > +    struct vhost_virtqueue *vhost_vqs;
> > +    struct vhost_dev vhost_dev;
> > +    VhostUserState vhost_user;
> > +
> > +    /*< public >*/
> > +} VHostUserFS;
> > +
> > +#endif /* _QEMU_VHOST_USER_FS_H */

