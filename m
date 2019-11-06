Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EA4C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CA62077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CA62077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJdY-00015q-O0
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSJZC-0003mR-L0
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSJZA-0007J1-U6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSJZA-0007Dr-0s
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:36 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66C74C04BD40
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 11:33:33 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id k53so25866459qtk.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bnaUZOXCNQiWPBTZOYLozohTVbSufEppzbiw1ATciy4=;
 b=D0nHhYqFSX4QvCVma6kdBGPNiz3z6k4DEXQ8fMtpf0+0qb8W14tmSL3RkBaUzKRg/z
 1UBm4418LBxF2JQ/yewT0fPNfJxpKdwUofi5p2CYrn/lf/KTY5CwKd1skuiYo5bw5eX0
 LtXZliXD+KBYACEdUBMAVG535BefMFqzTIHCSsEvS6x1vs9KEV6rsdZj8aRPKTdgZRuA
 M3aAFkgYnNG7FkbdJDpb+M4JqNuqcHK41aW3pS/aN51aHV/4waglMApn7pKYk9zmjRrB
 GSOvWlD0ukd/cw7hSH3TNzJ+YsBJgMwdu+olctmk0jevQrse23RG2C4yt98UHAwU3TkA
 e1zA==
X-Gm-Message-State: APjAAAUm7GA7G5hq0LEFBFw82JEKq5PxwL2TYCgq89AWZqTyuKq2e9Wa
 KRKlPvEdv6XzXdtJ6/pZqAfG1oisJensxCKUE2QSsg43ikLbssER2o7yxnmtxg1BSEqQqtycIPU
 vpFf1sJ9gjZ0JxOQ=
X-Received: by 2002:a37:8b03:: with SMTP id n3mr1498710qkd.493.1573040012602; 
 Wed, 06 Nov 2019 03:33:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyL6Ax/wkMys/liQJiBYaiQXy4tsUNTt/e1EowH36SChvYQMrb0Qmbnu7VdL46+y2QD9SOXCQ==
X-Received: by 2002:a37:8b03:: with SMTP id n3mr1498693qkd.493.1573040012264; 
 Wed, 06 Nov 2019 03:33:32 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id k3sm11451876qkj.119.2019.11.06.03.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:31 -0800 (PST)
Date: Wed, 6 Nov 2019 06:33:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 1/4] virtio: protect non-modern devices from too big
 virtqueue size setting
Message-ID: <20191106061919-mutt-send-email-mst@kernel.org>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-2-dplotnikov@virtuozzo.com>
 <20191105155357-mutt-send-email-mst@kernel.org>
 <c14296e6-0557-d643-722a-531e3c2f01de@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14296e6-0557-d643-722a-531e3c2f01de@virtuozzo.com>
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 07:46:31AM +0000, Denis Plotnikov wrote:
> 
> On 05.11.2019 23:56, Michael S. Tsirkin wrote:
> > On Tue, Nov 05, 2019 at 07:11:02PM +0300, Denis Plotnikov wrote:
> >> The patch protects from creating illegal virtio device configuration
> >> via direct virtqueue size property setting.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> ---
> >>   hw/virtio/virtio-blk-pci.c  |  9 +++++++++
> >>   hw/virtio/virtio-scsi-pci.c | 10 ++++++++++
> >>   2 files changed, 19 insertions(+)
> >>
> >> diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
> >> index 60c9185c39..6177ff1df8 100644
> >> --- a/hw/virtio/virtio-blk-pci.c
> >> +++ b/hw/virtio/virtio-blk-pci.c
> >> @@ -48,6 +48,15 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >>   {
> >>       VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
> >>       DeviceState *vdev = DEVICE(&dev->vdev);
> >> +    bool modern = virtio_pci_modern(vpci_dev);
> >> +    uint32_t queue_size = dev->vdev.conf.queue_size;
> >> +
> >> +    if (!modern && queue_size > 128) {
> >> +        error_setg(errp,
> >> +                   "too big queue size (%u, max: 128) "
> >> +                   "for non-modern virtio device", queue_size);
> >> +        return;
> >> +    }
> >
> > this enables for transitional so still visible to legacy
> > interface. I am guessing you want to check whether
> > device is accessed through the modern interface instead.
> 
> My goal is to not break something when I'm setting the queue size > 128 
> (taking into account the current seabios queue size restriction to 128). 
> I'm not quite sure what to check. Could I ask why one want to the check 
> whether accessing through the modern interface

Well now that you say that I don't really know why did you put this test
in here.  I was guessing you wanted modern because with modern queue
size is not forced by the host, guest can always use a smaller queue.
So it's safe to have a large queue.  But if not maybe you can comment on
why this is limited like this, and add a code comment here.

> and how it could be checked?


As Stefan said, you can look at the features.
But you can't do it from realize, you need to do it after guest
from the set features or validate features or set status callback.
I think validate features is the easiest to use of the three.

This calls for an API to resize queues which we
do not have now, but it's not hard to add.


> Thanks!
> 
> Denis
> 
> >>       if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> >>           vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;
> >> diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
> >> index 2830849729..6e6790fda5 100644
> >> --- a/hw/virtio/virtio-scsi-pci.c
> >> +++ b/hw/virtio/virtio-scsi-pci.c
> >> @@ -17,6 +17,7 @@
> >>   
> >>   #include "hw/virtio/virtio-scsi.h"
> >>   #include "virtio-pci.h"
> >> +#include "qapi/error.h"
> >>   
> >>   typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
> >>   
> >> @@ -47,6 +48,15 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >>       VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
> >>       DeviceState *proxy = DEVICE(vpci_dev);
> >>       char *bus_name;
> >> +    bool modern = virtio_pci_modern(vpci_dev);
> >> +    uint32_t virtqueue_size = vs->conf.virtqueue_size;
> >> +
> >> +    if (!modern && virtqueue_size > 128) {
> >> +        error_setg(errp,
> >> +                   "too big virtqueue size (%u, max: 128) "
> >> +                   "for non-modern virtio device", virtqueue_size);
> >> +        return;
> >> +    }
> > why? what is illegal about 256 for legacy?
> >
> >>   
> >>       if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> >>           vpci_dev->nvectors = vs->conf.num_queues + 3;
> >> -- 
> >> 2.17.0

