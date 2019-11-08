Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447B7FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FBF21D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FBF21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0wv-0005fA-Aw
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iT0wI-00058i-Dt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iT0wH-0006aq-3E
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:52:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iT0wG-0006ZR-QE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:52:21 -0500
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B7BEC04BD40
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 09:52:19 +0000 (UTC)
Received: by mail-qv1-f72.google.com with SMTP id i32so801591qvi.21
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 01:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oLkXLM+3KWngZaJfSQ2mp1/Tv9r/2uk7HotmY3pL3EI=;
 b=jcNu7FteqsUCRst5t6bcVgQHB6emZDYg0v/ICAVb4cyesAiwl5/NrO9VawKL4cmV9/
 jGKH9qB+kTlTCCyaiv8YNaLCLr3y1fQkGzM63EoXqgly0O5aa0qeGgZkPbdl0P1EYBxm
 0cw8xdLk7iEDmIQOSToJIOPmVxRDw403uNC6C647ruVJNm6YYaumsCtynfMCQh5PLgoq
 nknDLoytCEq/LNAkFWYVPAykGd39y4GA02riX1HqN4mAj/Uj6NHJ6F2uvmjHwtHQkw3T
 Z0mQAx8fNxkFhvOA+a4A6jwZ2GOazS0E8gUL2mz6RSoWlNKqgYd6yWkphr+cjAJvbtvg
 yIAA==
X-Gm-Message-State: APjAAAWD7dlB3hPslA7xy3k+q5M/DUDBKPK5mdQo55zSpqBoX2XMZUkx
 Ml20Yv+fumc7m1iPTA1Vg8D4WrhTCrzAgMRLAhNL4U7rG/ElFK2t1X5DGoIaDFQx8sI3Lkn2KFO
 k5zgkSx/Y0qJXSEM=
X-Received: by 2002:ac8:545:: with SMTP id c5mr9558995qth.375.1573206738908;
 Fri, 08 Nov 2019 01:52:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrSKylZA6oO68hsbDleFwBrSJSIxBGxhmew7jC2BNdoqN7wmwfdKprhtw78vy1YGonat+29A==
X-Received: by 2002:ac8:545:: with SMTP id c5mr9558978qth.375.1573206738684;
 Fri, 08 Nov 2019 01:52:18 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id x133sm2647322qka.44.2019.11.08.01.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 01:52:17 -0800 (PST)
Date: Fri, 8 Nov 2019 04:52:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: make seg_max virtqueue size dependent
Message-ID: <20191108045151-mutt-send-email-mst@kernel.org>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-3-dplotnikov@virtuozzo.com>
 <20191105155033-mutt-send-email-mst@kernel.org>
 <c32d94d1-a216-dd9e-e0cf-dee2730169e4@virtuozzo.com>
 <20191106065142-mutt-send-email-mst@kernel.org>
 <6204623b-2448-8362-0434-d96372d30b65@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6204623b-2448-8362-0434-d96372d30b65@virtuozzo.com>
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
 "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 07:43:22AM +0000, Denis Plotnikov wrote:
> The 1st patch from the series seems to be useless. The patch extending=20
> queue length by adding machine type may break vm-s which use seabios=20
> with max queue size =3D 128.
>=20
> Looks like only this patch doesn't break anything and helps to express=20
> queue size and seg max dependency (the specification constraint)=20
> explicitly. So, I would like to re-send this patch as a standalone one=20
> and send other patches including the test later, when we all agree on=20
> how exactly to deal with issues posted in the thread.

OK, and I think we should make it machine type dependent.

> Any objections are welcome.
>=20
> Denis
>=20
> On 06.11.2019 14:54, Michael S. Tsirkin wrote:
> > On Wed, Nov 06, 2019 at 10:07:02AM +0000, Denis Lunev wrote:
> >> On 11/5/19 9:51 PM, Michael S. Tsirkin wrote:
> >>> On Tue, Nov 05, 2019 at 07:11:03PM +0300, Denis Plotnikov wrote:
> >>>> seg_max has a restriction to be less or equal to virtqueue size
> >>>> according to Virtio 1.0 specification
> >>>>
> >>>> Although seg_max can't be set directly, it's worth to express this
> >>>> dependancy directly in the code for sanity purpose.
> >>>>
> >>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >>> This is guest visible so needs to be machine type dependent, right?
> >> we have discussed this verbally with Stefan and think that
> >> there is no need to add that to the machine type as:
> >>
> >> - original default was 126, which matches 128 as queue
> >>  =A0 length in old machine types
> >> - queue length > 128 is not observed in the field as
> >>  =A0 SeaBios has quirk that asserts
> > Well that's just the SeaBios virtio driver. Not everyone's using that=
 to
> > drive their devices.
> >
> >> - if queue length will be set to something < 128 - linux
> >>  =A0 guest will crash
> > Again that's just one guest driver. Not everyone is using that either=
.
> >
> >
> >> If we really need to preserve original __buggy__ behavior -
> >> we can add boolean property, pls let us know.
> >>
> >> Den
> > Looks like some drivers are buggy but I'm not sure it's
> > the same as saying the behavior is buggy.
> > So yes, I'd say it's preferable to be compatible.
> >
> >
> >>>> ---
> >>>>   hw/block/virtio-blk.c | 2 +-
> >>>>   hw/scsi/virtio-scsi.c | 2 +-
> >>>>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> >>>> index 06e57a4d39..21530304cf 100644
> >>>> --- a/hw/block/virtio-blk.c
> >>>> +++ b/hw/block/virtio-blk.c
> >>>> @@ -903,7 +903,7 @@ static void virtio_blk_update_config(VirtIODev=
ice *vdev, uint8_t *config)
> >>>>       blk_get_geometry(s->blk, &capacity);
> >>>>       memset(&blkcfg, 0, sizeof(blkcfg));
> >>>>       virtio_stq_p(vdev, &blkcfg.capacity, capacity);
> >>>> -    virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
> >>>> +    virtio_stl_p(vdev, &blkcfg.seg_max, s->conf.queue_size - 2);
> >>>>       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
> >>>>       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
> >>>>       virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / =
blk_size);
> >>>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> >>>> index 839f120256..f7e5533cd5 100644
> >>>> --- a/hw/scsi/virtio-scsi.c
> >>>> +++ b/hw/scsi/virtio-scsi.c
> >>>> @@ -650,7 +650,7 @@ static void virtio_scsi_get_config(VirtIODevic=
e *vdev,
> >>>>       VirtIOSCSICommon *s =3D VIRTIO_SCSI_COMMON(vdev);
> >>>>  =20
> >>>>       virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues=
);
> >>>> -    virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
> >>>> +    virtio_stl_p(vdev, &scsiconf->seg_max, s->conf.virtqueue_size=
 - 2);
> >>>>       virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_secto=
rs);
> >>>>       virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_l=
un);
> >>>>       virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIO=
SCSIEvent));
> >>>> --=20
> >>>> 2.17.0

