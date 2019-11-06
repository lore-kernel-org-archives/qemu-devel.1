Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BFAC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7A92075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7A92075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJuY-0002ss-2Z
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSJtG-0002Lg-J8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSJtF-0004tm-Ak
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:54:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSJtF-0004oy-1Z
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:54:21 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF1747F411
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 11:54:19 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id h15so15169957qtn.6
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=v8YIZ3KIz9hoHR9dCCRLasjr0pCOUre0Qi8R7rATaLQ=;
 b=FxZYfW2GGOimRvLUsZBiC/07l97V7zxJ8cgxVHecFZcj0XFTd2VYqJT8IZP8UTKYWO
 gWJg8akFXiace5+mP+HV3Eo8gwwyRTNv3jxH0GeHI2SJ2mZK3kMVrpnOxiAxWDq071aT
 QTA6OiKkoqg5f5OXJbpWg2ZSB/NAJnnxA4kZlO3HUnYq+irOEUQCHKuTBcCExmlCf1E2
 Np3JLVzKi1VrkmOq9EWklWXzDkdQLq7vmw4QOEhyhcvc46hONbUJVN48LHzDs4IJLqv1
 g4VNojKKIEwK+2Yi3m8wVsgG1IUCDyGpuC/yUrVjxH13raKfQIYpfvHuo3OLq4tKNnlq
 av1Q==
X-Gm-Message-State: APjAAAXVoO57cbvV1N8PiUFLehrfciqMvIwHgL8aAz4vnYL8jvwEB3T/
 5/7q3X7HM6bDbPorGuygMU4OqQU+QicTIUBN6IS5uuhmWAelOWHqBoZbH80EW2s81eyIzM2SoAY
 Wmwjgk1NFqE2fHmM=
X-Received: by 2002:a0c:c211:: with SMTP id l17mr882843qvh.55.1573041259250;
 Wed, 06 Nov 2019 03:54:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6LqEavD0BV20pVBPYRZP1YFypnnbZjcxLqWKgukekIPz9TH+W7tiryrMFK6txMw/srSAp2A==
X-Received: by 2002:a0c:c211:: with SMTP id l17mr882824qvh.55.1573041259024;
 Wed, 06 Nov 2019 03:54:19 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id o2sm12382236qkf.68.2019.11.06.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:54:18 -0800 (PST)
Date: Wed, 6 Nov 2019 06:54:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: make seg_max virtqueue size dependent
Message-ID: <20191106065142-mutt-send-email-mst@kernel.org>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-3-dplotnikov@virtuozzo.com>
 <20191105155033-mutt-send-email-mst@kernel.org>
 <c32d94d1-a216-dd9e-e0cf-dee2730169e4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c32d94d1-a216-dd9e-e0cf-dee2730169e4@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
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
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 10:07:02AM +0000, Denis Lunev wrote:
> On 11/5/19 9:51 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 05, 2019 at 07:11:03PM +0300, Denis Plotnikov wrote:
> >> seg_max has a restriction to be less or equal to virtqueue size
> >> according to Virtio 1.0 specification
> >>
> >> Although seg_max can't be set directly, it's worth to express this
> >> dependancy directly in the code for sanity purpose.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > This is guest visible so needs to be machine type dependent, right?
>=20
> we have discussed this verbally with Stefan and think that
> there is no need to add that to the machine type as:
>=20
> - original default was 126, which matches 128 as queue
> =A0 length in old machine types
> - queue length > 128 is not observed in the field as
> =A0 SeaBios has quirk that asserts

Well that's just the SeaBios virtio driver. Not everyone's using that to
drive their devices.

> - if queue length will be set to something < 128 - linux
> =A0 guest will crash

Again that's just one guest driver. Not everyone is using that either.


> If we really need to preserve original __buggy__ behavior -
> we can add boolean property, pls let us know.
>=20
> Den

Looks like some drivers are buggy but I'm not sure it's
the same as saying the behavior is buggy.
So yes, I'd say it's preferable to be compatible.


> >> ---
> >>  hw/block/virtio-blk.c | 2 +-
> >>  hw/scsi/virtio-scsi.c | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> >> index 06e57a4d39..21530304cf 100644
> >> --- a/hw/block/virtio-blk.c
> >> +++ b/hw/block/virtio-blk.c
> >> @@ -903,7 +903,7 @@ static void virtio_blk_update_config(VirtIODevic=
e *vdev, uint8_t *config)
> >>      blk_get_geometry(s->blk, &capacity);
> >>      memset(&blkcfg, 0, sizeof(blkcfg));
> >>      virtio_stq_p(vdev, &blkcfg.capacity, capacity);
> >> -    virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
> >> +    virtio_stl_p(vdev, &blkcfg.seg_max, s->conf.queue_size - 2);
> >>      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
> >>      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
> >>      virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk=
_size);
> >> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> >> index 839f120256..f7e5533cd5 100644
> >> --- a/hw/scsi/virtio-scsi.c
> >> +++ b/hw/scsi/virtio-scsi.c
> >> @@ -650,7 +650,7 @@ static void virtio_scsi_get_config(VirtIODevice =
*vdev,
> >>      VirtIOSCSICommon *s =3D VIRTIO_SCSI_COMMON(vdev);
> >> =20
> >>      virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
> >> -    virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
> >> +    virtio_stl_p(vdev, &scsiconf->seg_max, s->conf.virtqueue_size -=
 2);
> >>      virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors)=
;
> >>      virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun)=
;
> >>      virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCS=
IEvent));
> >> --=20
> >> 2.17.0
>=20

