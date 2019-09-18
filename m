Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D9C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE58E20665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE58E20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAOqz-0008F8-1z
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 21:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <piaojun@huawei.com>) id 1iAOpT-0006yo-SK
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1iAOpR-0001d0-Vb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:32:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41726 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1iAOpR-0001as-BP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:32:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0BAC91074EBE71365BBD;
 Wed, 18 Sep 2019 09:32:18 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Sep 2019
 09:32:13 +0800
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 <qemu-devel@nongnu.org>, <cohuck@redhat.com>, <mst@redhat.com>
References: <20190917160057.11847-1-dgilbert@redhat.com>
 <20190917160057.11847-3-dgilbert@redhat.com>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D818908.4080508@huawei.com>
Date: Wed, 18 Sep 2019 09:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190917160057.11847-3-dgilbert@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: Re: [Qemu-devel] [PATCH v3 2/3] virtio: add vhost-user-fs base
 device
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
Cc: mszeredi@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/9/18 0:00, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The virtio-fs virtio device provides shared file system access using
> the FUSE protocol carried over virtio.
> The actual file server is implemented in an external vhost-user-fs device
> backend process.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  configure                         |  13 ++
>  hw/virtio/Makefile.objs           |   1 +
>  hw/virtio/vhost-user-fs.c         | 299 ++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-user-fs.h |  45 +++++
>  4 files changed, 358 insertions(+)
>  create mode 100644 hw/virtio/vhost-user-fs.c
>  create mode 100644 include/hw/virtio/vhost-user-fs.h
> 
> diff --git a/configure b/configure
> index 30aad233d1..1bd7b40d49 100755
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
> @@ -1294,6 +1295,10 @@ for opt do
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
> @@ -2232,6 +2237,10 @@ test "$vhost_crypto" = "" && vhost_crypto=$vhost_user
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
> @@ -6374,6 +6383,7 @@ echo "vhost-crypto support $vhost_crypto"
>  echo "vhost-scsi support $vhost_scsi"
>  echo "vhost-vsock support $vhost_vsock"
>  echo "vhost-user support $vhost_user"
> +echo "vhost-user-fs support $vhost_user_fs"
>  echo "Trace backends    $trace_backends"
>  if have_backend "simple"; then
>  echo "Trace output file $trace_file-<pid>"
> @@ -6873,6 +6883,9 @@ fi
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
> index 0000000000..f0df7f4746
> --- /dev/null
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -0,0 +1,299 @@
> +/*
> + * Vhost-user filesystem virtio device
> + *
> + * Copyright 2018-2019 Red Hat, Inc.
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
> +#include "hw/qdev-properties.h"
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
> +    virtio_stl_p(vdev, &fscfg.num_request_queues, fs->conf.num_request_queues);
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
> +    /*
> +     * Not normally called; it's the daemon that handles the queue;
> +     * however virtio's cleanup path can call this.
> +     */
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
> +    if (fs->conf.num_request_queues == 0) {
> +        error_setg(errp, "num-request-queues property must be larger than 0");
> +        return;
> +    }
> +
> +    if (!is_power_of_2(fs->conf.queue_size)) {
> +        error_setg(errp, "queue-size property must be a power of 2");
> +        return;
> +    }
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
> +    /* Hiprio queue */
> +    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> +
> +    /* Request queues */
> +    for (i = 0; i < fs->conf.num_request_queues; i++) {
> +        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> +    }
> +
> +    /* 1 high prio queue, plus the number configured */
> +    fs->vhost_dev.nvqs = 1 + fs->conf.num_request_queues;
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

Adding 'fs->vhost_dev.vqs = NULL;' looks better.

Jun

