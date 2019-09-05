Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782A9C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFD020640
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFD020640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tPl-0001FA-Fs
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5tKT-0005RO-E9
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5tKQ-0000bx-9c
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:05:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5tKP-0000bl-Vv
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:05:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A6023D965
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 15:05:41 +0000 (UTC)
Received: from work-vm (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0B3D19C69;
 Thu,  5 Sep 2019 15:05:31 +0000 (UTC)
Date: Thu, 5 Sep 2019 16:05:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>, mst@redhat.com
Message-ID: <20190905150529.GL2700@work-vm>
References: <20190823175657.12085-1-dgilbert@redhat.com>
 <20190823175657.12085-2-dgilbert@redhat.com>
 <20190826173242.4d9f1f70.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826173242.4d9f1f70.cohuck@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 05 Sep 2019 15:05:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] virtio: add vhost-user-fs base
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Cornelia Huck (cohuck@redhat.com) wrote:
> On Fri, 23 Aug 2019 18:56:56 +0100
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
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
> 
> > diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> > new file mode 100644
> > index 0000000000..72e270d869
> > --- /dev/null
> > +++ b/hw/virtio/vhost-user-fs.c
> > @@ -0,0 +1,297 @@
> > +/*
> > + * Vhost-user filesystem virtio device
> > + *
> > + * Copyright 2018 Red Hat, Inc.
> 
> Should that be 2018, 2019? (Also for vhost-user-fs.h.)

Will fix.

> > + *
> > + * Authors:
> > + *  Stefan Hajnoczi <stefanha@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> 
> (...)

??

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
> 
> I still think referring to virtio-pci doing the right thing is not the
> right thing here :) Can you spell out _what_ the right thing actually
> is?

mst: Can you look at this?

This appears to be a chunk of code that's copied into many vhost files;
it's in at least vhost-user.c, vhost-user-blk.c, vhost-scsi-common.c and
vhost-vsock.c - it seemns to go back until at least 2013.

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
> 
> (...)
> 
> > diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standard-headers/linux/virtio_fs.h
> > new file mode 100644
> > index 0000000000..00bd7a6fa7
> > --- /dev/null
> > +++ b/include/standard-headers/linux/virtio_fs.h
> 
> This will probably be imported from the Linux source code, right? If
> yes, this should go into a separate patch (and the headers update patch
> probably needs an update.)

OK, will do.

> > @@ -0,0 +1,41 @@
> > +#ifndef _LINUX_VIRTIO_FS_H
> > +#define _LINUX_VIRTIO_FS_H
> > +/* This header is BSD licensed so anyone can use the definitions to implement
> > + * compatible drivers/servers.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions
> > + * are met:
> > + * 1. Redistributions of source code must retain the above copyright
> > + *    notice, this list of conditions and the following disclaimer.
> > + * 2. Redistributions in binary form must reproduce the above copyright
> > + *    notice, this list of conditions and the following disclaimer in the
> > + *    documentation and/or other materials provided with the distribution.
> > + * 3. Neither the name of IBM nor the names of its contributors
> > + *    may be used to endorse or promote products derived from this software
> > + *    without specific prior written permission.
> > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
> > + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> > + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> > + * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
> > + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> > + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> > + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> > + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> > + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> > + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> > + * SUCH DAMAGE. */
> > +#include "standard-headers/linux/types.h"
> > +#include "standard-headers/linux/virtio_ids.h"
> > +#include "standard-headers/linux/virtio_config.h"
> > +#include "standard-headers/linux/virtio_types.h"
> > +
> > +struct virtio_fs_config {
> > +	/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
> > +	uint8_t tag[36];
> > +
> > +	/* Number of request queues */
> > +	uint32_t num_request_queues;
> > +} QEMU_PACKED;
> > +
> > +#endif /* _LINUX_VIRTIO_FS_H */
> > diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> > index 32b2f94d1f..73fc004807 100644
> > --- a/include/standard-headers/linux/virtio_ids.h
> > +++ b/include/standard-headers/linux/virtio_ids.h
> 
> This should also go into that separate patch.

OK.

Dave

> > @@ -43,6 +43,7 @@
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > +#define VIRTIO_ID_FS           26 /* virtio filesystem */
> >  #define VIRTIO_ID_PMEM         27 /* virtio pmem */
> >  
> >  #endif /* _LINUX_VIRTIO_IDS_H */
> 
> Otherwise, looks good to me.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

