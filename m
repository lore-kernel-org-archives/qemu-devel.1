Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D3C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EED216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EED216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0W1n-0003m2-Vl
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 15:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i0W14-0003A8-DF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i0W12-0004pf-4Y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:11:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i0W11-0004pE-Rj
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:11:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 206EB300177F
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 19:11:27 +0000 (UTC)
Received: from work-vm (ovpn-117-245.ams2.redhat.com [10.36.117.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38F1E5D9D3;
 Wed, 21 Aug 2019 19:11:20 +0000 (UTC)
Date: Wed, 21 Aug 2019 20:11:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190821191118.GN3309@work-vm>
References: <20190816143321.20903-1-dgilbert@redhat.com>
 <20190816143321.20903-2-dgilbert@redhat.com>
 <20190818065944-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818065944-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 21 Aug 2019 19:11:27 +0000 (UTC)
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

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Fri, Aug 16, 2019 at 03:33:20PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > The virtio-fs virtio device provides shared file system access using
> > the FUSE protocol carried ovew virtio.
> > The actual file server is implemented in an external vhost-user-fs device
> > backend process.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  configure                                   |  13 +
> >  hw/virtio/Makefile.objs                     |   1 +
> >  hw/virtio/vhost-user-fs.c                   | 297 ++++++++++++++++++++
> >  include/hw/virtio/vhost-user-fs.h           |  45 +++
> >  include/standard-headers/linux/virtio_fs.h  |  41 +++
> >  include/standard-headers/linux/virtio_ids.h |   1 +
> >  6 files changed, 398 insertions(+)
> >  create mode 100644 hw/virtio/vhost-user-fs.c
> >  create mode 100644 include/hw/virtio/vhost-user-fs.h
> >  create mode 100644 include/standard-headers/linux/virtio_fs.h
> > 
> > diff --git a/configure b/configure
> > index 714e7fb6a1..e7e33ee783 100755
> > --- a/configure
> > +++ b/configure
> > @@ -382,6 +382,7 @@ vhost_crypto=""
> >  vhost_scsi=""
> >  vhost_vsock=""
> >  vhost_user=""
> > +vhost_user_fs=""
> >  kvm="no"
> >  hax="no"
> >  hvf="no"
> > @@ -1316,6 +1317,10 @@ for opt do
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
> > @@ -2269,6 +2274,10 @@ test "$vhost_crypto" = "" && vhost_crypto=$vhost_user
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
> > @@ -6425,6 +6434,7 @@ echo "vhost-crypto support $vhost_crypto"
> >  echo "vhost-scsi support $vhost_scsi"
> >  echo "vhost-vsock support $vhost_vsock"
> >  echo "vhost-user support $vhost_user"
> > +echo "vhost-user-fs support $vhost_user_fs"
> >  echo "Trace backends    $trace_backends"
> >  if have_backend "simple"; then
> >  echo "Trace output file $trace_file-<pid>"
> > @@ -6921,6 +6931,9 @@ fi
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
> > index 0000000000..2753c2c07a
> > --- /dev/null
> > +++ b/hw/virtio/vhost-user-fs.c
> > @@ -0,0 +1,297 @@
> > +/*
> > + * Vhost-user filesystem virtio device
> > + *
> > + * Copyright 2018 Red Hat, Inc.
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
> > +    virtio_stl_p(vdev, &fscfg.num_queues, fs->conf.num_queues);
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
> > +    /* Do nothing */
> 
> Why is this safe?  Is this because this never triggers?  assert(0) then?
> If it triggers then backend won't be notified, which might
> cause it to get stuck.

We never process these queues in qemu - always in the guest; so am I
correct in thinking those shouldn't be used?

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
> > +    if (fs->conf.num_queues == 0) {
> > +        error_setg(errp, "num-queues property must be larger than 0");
> > +        return;
> > +    }
> 
> The strange thing is that actual # of queues is this number + 2.
> And this affects an optimal number of vectors (see patch 2).
> Not sure what a good solution is - include the
> mandatory queues in the number?
> Needs to be documented in some way.

Should we be doing nvectors the same way virtio-scsi-pci does it;
with a magic 'unspecified' default where it sets the nvectors based on
the number of queues?

I think my preference is not to show the users the mandatory queues.

> > +
> > +    if (!is_power_of_2(fs->conf.queue_size)) {
> > +        error_setg(errp, "queue-size property must be a power of 2");
> > +        return;
> > +    }
> 
> Hmm packed ring allows non power of 2 ...
> We need to look into a generic helper to support VQ
> size checks.

Which would also have to include the negotiation of where it's doing
packaged ring?

<snip>

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

