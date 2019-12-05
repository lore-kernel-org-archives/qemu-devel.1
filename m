Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0144C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 04:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E2F2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 04:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dcxx0tKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E2F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icj8f-0000et-Pr
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 23:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pagupta@redhat.com>) id 1icj74-0008I4-U0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 23:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1icj71-0008Gp-L3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 23:51:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21374
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1icj71-0008CU-7i
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 23:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575521493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2TGSxXfagF9PFoCPDMKr6eUnTS+dRMKAXKrKn5s4m0=;
 b=Dcxx0tKEYJe+PGRMUUPGQr6IhXAltZOeWrS5cT6KDQYXHTudzxbn4Upz6D9rlu0HYnhzGG
 vjiA+nyAGhSPHD+YuTzTDz3R5sETR9cwNpotF5HuYtYtG1qTmisUk1Wz/pDfobLmFlY2JK
 gKmPgix/5Md8E0k4swAdF/hTDcJI96U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-0NRkW1yaMoWJMMVbgIKPkQ-1; Wed, 04 Dec 2019 23:51:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22D37DB61;
 Thu,  5 Dec 2019 04:51:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0094F5D6AE;
 Thu,  5 Dec 2019 04:51:30 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 968FC4EBC0;
 Thu,  5 Dec 2019 04:51:30 +0000 (UTC)
Date: Wed, 4 Dec 2019 23:51:30 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <1984104376.39119240.1575521490101.JavaMail.zimbra@redhat.com>
In-Reply-To: <1e063551-a1bd-f64d-fbac-548ec0dd905a@huawei.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
 <606337023.38890965.1575448387620.JavaMail.zimbra@redhat.com>
 <1e063551-a1bd-f64d-fbac-548ec0dd905a@huawei.com>
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
MIME-Version: 1.0
X-Originating-IP: [10.67.116.147, 10.4.195.28]
Thread-Topic: virtio: add ability to delete vq through a pointer
Thread-Index: 7gkNVoO4EQjahQMg+mQNTYBZ1ceCLg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0NRkW1yaMoWJMMVbgIKPkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: liyiting@huawei.com, kuhn chenqun <kuhn.chenqun@huawei.com>, mst@redhat.com,
 zhang zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>=20
> On 2019/12/4 16:33, Pankaj Gupta wrote:
> >=20
> >> From: Pan Nengyuan <pannengyuan@huawei.com>
> >>
> >> Devices tend to maintain vq pointers, allow deleting them trough a vq
> >> pointer.
> >>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> >> ---
> >> Changes v2 to v1:
> >> - add a new function virtio_delete_queue to cleanup vq through a vq
> >> pointer
> >> ---
> >>  hw/virtio/virtio.c         | 16 +++++++++++-----
> >>  include/hw/virtio/virtio.h |  2 ++
> >>  2 files changed, 13 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 04716b5..6de3cfd 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -2330,17 +2330,23 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev=
,
> >> int
> >> queue_size,
> >>      return &vdev->vq[i];
> >>  }
> >> =20
> >> +void virtio_delete_queue(VirtQueue *vq)
> >> +{
> >> +    vq->vring.num =3D 0;
> >> +    vq->vring.num_default =3D 0;
> >> +    vq->handle_output =3D NULL;
> >> +    vq->handle_aio_output =3D NULL;
> >> +    g_free(vq->used_elems);
> >> +    vq->used_elems =3D NULL;
> >> +}
> >> +
> >>  void virtio_del_queue(VirtIODevice *vdev, int n)
> >>  {
> >>      if (n < 0 || n >=3D VIRTIO_QUEUE_MAX) {
> >>          abort();
> >>      }
> >> =20
> >> -    vdev->vq[n].vring.num =3D 0;
> >> -    vdev->vq[n].vring.num_default =3D 0;
> >> -    vdev->vq[n].handle_output =3D NULL;
> >> -    vdev->vq[n].handle_aio_output =3D NULL;
> >> -    g_free(vdev->vq[n].used_elems);
> >> +    virtio_delete_queue(&vdev->vq[n]);
> >>  }
> >> =20
> >>  static void virtio_set_isr(VirtIODevice *vdev, int value)
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index c32a815..e18756d 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, in=
t
> >> queue_size,
> >> =20
> >>  void virtio_del_queue(VirtIODevice *vdev, int n);
> >> =20
> >> +void virtio_delete_queue(VirtQueue *vq);
> >> +
> >>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >>                      unsigned int len);
> >>  void virtqueue_flush(VirtQueue *vq, unsigned int count);
> >> --
> >> 2.7.2.windows.1
> >>
> >>
> > Overall it ooks good to me.
> >=20
> > Just one point: e.g in virtio_rng: "virtio_rng_device_unrealize" functi=
on
> > We are doing :     virtio_del_queue(vdev, 0);
> >=20
> > One can directly call "virtio_delete_queue". It can become confusing
> > to call multiple functions for same purpose. Instead, Can we make
> > "virtio_delete_queue" static inline?
> >=20
> yes, It will be a little confused, but I think it will have the same
> problem if we make "virtio_delete_queue" static inline. We can directly
> call it aslo. =EF=BC=88e.g virtio-serial-bus.c virtio-balloon.c).
>=20
> How about replacing the function name to make it more clear (e.g
> virtio_delete_queue -> virtio_queue_cleanup) ? It's too similar between
> "virtio_del_queue" and "virtio_delete_queue".

I am just thinking if we need these two separate functions.

Yes, changing name of virtio_delete_queue -> virtio_queue_cleanup
should be good enough.

Thanks,
Pankaj

>=20
> > Other than that:
> > Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
> >=20
> >>
> >>
> >=20
> >=20
> > .
> >=20
>=20
>=20
>=20


