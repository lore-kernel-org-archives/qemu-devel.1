Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB18C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B904422DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B904422DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03GA-0002PP-K2
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i03Bo-00081v-W3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i03Bm-0005jq-Us
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1i03Bm-0005iJ-Mj
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:24:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6771A10C0528
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 12:24:37 +0000 (UTC)
Received: from gondolin (ovpn-116-201.ams2.redhat.com [10.36.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D32081E4;
 Tue, 20 Aug 2019 12:24:31 +0000 (UTC)
Date: Tue, 20 Aug 2019 14:24:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190820142428.7995cd89.cohuck@redhat.com>
In-Reply-To: <20190818065944-mutt-send-email-mst@kernel.org>
References: <20190816143321.20903-1-dgilbert@redhat.com>
 <20190816143321.20903-2-dgilbert@redhat.com>
 <20190818065944-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 20 Aug 2019 12:24:37 +0000 (UTC)
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
Cc: vgoyal@redhat.com, "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>,
 stefanha@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Aug 2019 07:08:31 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

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

JFYI, this needs to include hw/qdev-properties.h as well on the latest
code level. (As does the pci part.)

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

Referring to 'virtio-pci' seems a bit suspicious :) Should that be 'the
transport'? (And 'the right thing' is not really self-explanatory...)

(I have wired it up for virtio-ccw, but have not actually tried it out.
Will send it out once I did.)

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

(...)

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

I think the spec states that num_queues in the config space is the
number of request queues only. Can we rename to num_request_queues? The
hiprio queue is not really configurable, anyway.

> 
> > +
> > +    if (!is_power_of_2(fs->conf.queue_size)) {
> > +        error_setg(errp, "queue-size property must be a power of 2");
> > +        return;
> > +    }  
> 
> Hmm packed ring allows non power of 2 ...
> We need to look into a generic helper to support VQ
> size checks.

Huh, I didn't notice before that there are several devices which
already allow to configure the queue size... looking, there seem to be
the following cases:

- bound checks and checks for power of 2 (blk, net)
- no checks (scsi) -- isn't that dangerous, as virtio_add_queue() will
  abort() for a too large value?

Anyway, if we have a non power of 2 size and the driver does not
negotiate packed, we can just fail setting FEATURES_OK, so dropping the
power of 2 check should be fine, at least when we add packed support.

> 
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
> > +    /* Notifications queue */
> > +    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> > +
> > +    /* Hiprio queue */
> > +    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> >  
> 
> Weird, spec patch v6 says:
> 
> +\item[0] hiprio
> +\item[1\ldots n] request queues
> 
> where's the Notifications queue coming from?

Maybe an old name of the hiprio queue?

> 
> > +    /* Request queues */
> > +    for (i = 0; i < fs->conf.num_queues; i++) {
> > +        virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
> > +    }
> > +
> > +    /* 1 high prio queue, plus the number configured */
> > +    fs->vhost_dev.nvqs = 1 + fs->conf.num_queues;

Anyway, the notifications queue needs to go, or this is wrong :)

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

(...)

