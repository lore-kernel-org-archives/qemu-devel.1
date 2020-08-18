Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B298EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFDA20706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CENlk2ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFDA20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k819p-00024F-EQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 08:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k818o-0001F8-HC
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:55:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57303
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k818m-00064S-Kf
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597755299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hysYxjFPrgvbcb+fe7+xeegNUFsaGkXkr4U+kSxgveo=;
 b=CENlk2tsKaqHVCxVdOBgpGCt4bFhu+PxHgp6SdxCrpl1QmmgLBn7DtAVPDZGihBEtzS+zp
 KDvXXrkRHLy/uKuXwGWG3D/LFaiFBska89Mq2co9gqndVrSVJs7rC6P5OAb8Uq+xrenZFy
 tEB4ZoozvILckmJW0AEUQVBsqIEuWb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-xmqFy55PM3ms9EwdFfszlQ-1; Tue, 18 Aug 2020 08:54:55 -0400
X-MC-Unique: xmqFy55PM3ms9EwdFfszlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5555118686C9;
 Tue, 18 Aug 2020 12:54:54 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C98B85D757;
 Tue, 18 Aug 2020 12:54:47 +0000 (UTC)
Date: Tue, 18 Aug 2020 13:54:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 07/11] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
Message-ID: <20200818125446.GC36102@stefanha-x1.localdomain>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-8-kuhn.chenqun@huawei.com>
 <20200813105911.2312adb5@x1.home>
 <681519bf-92ca-6247-490a-e9193b0bd385@redhat.com>
 <20200813131530.09ad0a4c@x1.home>
 <8e096d15-1700-f399-045d-1ba73eb6c1c1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8e096d15-1700-f399-045d-1ba73eb6c1c1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
Received-SPF: none client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 pannengyuan@huawei.com, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2020 at 09:18:59PM +0200, Auger Eric wrote:
> Hi Alex,
>=20
> On 8/13/20 9:15 PM, Alex Williamson wrote:
> > On Thu, 13 Aug 2020 20:02:45 +0200
> > Auger Eric <eric.auger@redhat.com> wrote:
> >=20
> >> Hi Alex,
> >>
> >> On 8/13/20 6:59 PM, Alex Williamson wrote:
> >>> On Thu, 13 Aug 2020 15:37:08 +0800
> >>> Chen Qun <kuhn.chenqun@huawei.com> wrote:
> >>>  =20
> >>>> Clang static code analyzer show warning:
> >>>> hw/vfio/platform.c:239:9: warning: Value stored to 'ret' is never re=
ad
> >>>>         ret =3D event_notifier_test_and_clear(intp->interrupt);
> >>>>         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>
> >>>> Reported-by: Euler Robot <euler.robot@huawei.com>
> >>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> >>>> ---
> >>>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>>> Cc: Eric Auger <eric.auger@redhat.com>
> >>>> ---
> >>>>  hw/vfio/platform.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> >>>> index ac2cefc9b1..869ed2c39d 100644
> >>>> --- a/hw/vfio/platform.c
> >>>> +++ b/hw/vfio/platform.c
> >>>> @@ -236,7 +236,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
> >>>>          trace_vfio_intp_interrupt_set_pending(intp->pin);
> >>>>          QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
> >>>>                               intp, pqnext);
> >>>> -        ret =3D event_notifier_test_and_clear(intp->interrupt);
> >>>> +        event_notifier_test_and_clear(intp->interrupt);
> >>>>          return;
> >>>>      } =20
> >>>
> >>> Testing that an event is pending in our notifier is generally a
> >>> prerequisite to doing anything in the interrupt handler, I don't
> >>> understand why we're just consuming it and ignoring the return value.
> >>> The above is in the delayed handling branch of the function, but the
> >>> normal non-delayed path would only go on to error_report() if the
> >>> notifier is not pending and then inject an interrupt anyway.  This al=
l
> >>> seems rather suspicious and it's a unique pattern among the vfio
> >>> callers of this function.  Is there a more fundamental bug that this
> >>> function should perform this test once and return without doing
> >>> anything if it's called spuriously, ie. without a notifier pending?
> >>> Thanks, =20
> >>
> >> Hum that's correct that other VFIO call sites do the check. My
> >> understanding was that this could not fail in this case as, if we
> >> entered the handler there was something to be cleared. In which
> >> situation can this fail?
> >=20
> > I'm not sure what the right answer is, I see examples either way
> > looking outside of vfio code.  On one hand, maybe we never get called
> > spuriously, on the other if it's the callee's responsibility to drain
> > events from the fd and we have it readily accessible whether there were
> > any events pending, why would we inject an interrupt if the result that
> > we have in hand shows no pending events?  The overhead of returning
> > based on that result is minuscule.
>=20
> I agree
> >=20
> > qemu_set_fd_handler() is a wrapper for aio_set_fd_handler().  Stefan is
> > a possible defacto maintainer of some of the aio code.  Stefan, do you
> > have thoughts on whether callbacks from event notifier fds should
> > consider spurious events?  Thanks,
>=20
> Indeed I saw that for instance block/nvme.c nvme_handle_event is not
> checking the result.
>=20
> Let's wait for Stefan's answer ...

vfio_intp_interrupt() will always read a non-zero eventfd value, based
on these assumptions:

intp->interrupt is "readable" since vfio_intp_interrupt() is called by
the AioContext (event loop). "readable" does not guarantee that data can
actually be read because it also includes error events:

  new_node->pfd.events =3D (io_read ? G_IO_IN | G_IO_HUP | G_IO_ERR : 0);

However, I think we can exclude the error case for the VFIO interrupt
eventfds because there are no error cases for eventfds (unlike socket
disconnection, for example).

The other important assumption is that only one thread on the host is
monitoring the eventfd for activity.

Stefan

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl87z5YACgkQnKSrs4Gr
c8jU3wgAnBv6cYtdSQgtUw0hOiA0ZRFpVp10FUPwkZTlQY5tNTq33eOkCjmySOV9
iVmoDYDWzi+VHXeWhYGKL2nU8YuVkcd++URup4Op4cn30iMnR0x07Xyp/dAPmq5D
tDHS+nRMf9OoszqSy/vbR+0dN9Go/DD5wXvLsXjArRFB9W4HOTDn9VtNyI0nyMbL
MU3fQJdsffSl5pCkOfDe7Ozm1BbZSy56B1qRVaU6qtfkP1rM71Tn6AR2aTzqN5+k
XistUBmyxPCSxxi+K0UVWbEvFYZBUX5y5tOQwkGPdLTZZjPD3wgz3+1Xrvcz2a0I
Gl5SyKNj2tAzkMZQEUJtxUNDeutaNw==
=778W
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--


