Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9932FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B33217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6cudsG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B33217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2CxF-00033b-Ib
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 06:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2CwK-0002HC-9G
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2CwH-000474-Hz
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:45:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43226
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2CwG-000464-F0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581594347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOhMJ4QiMf35qZW5F3e175SB8b0vfRSTJV3zgX1Lf7w=;
 b=c6cudsG+dRdAkc8E5/vrRV23o8JALfHrW2GgnohpetQBCy7sh3JmfGLsTms+GbZEsiUIJS
 X8+aeJrGy1j5lYk5TSbmcfmXLJ5jrXjPCFuqdlKc82ygClWTA4Ytij8W6GOYVaocNAMoGI
 +1HzDusEDQ54hyhK823PWsl1SVGfM6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-uVhIuzmtMP6zasQ7Fh1Xgg-1; Thu, 13 Feb 2020 06:45:41 -0500
X-MC-Unique: uVhIuzmtMP6zasQ7Fh1Xgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31FE0100550E;
 Thu, 13 Feb 2020 11:45:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8E8A5C101;
 Thu, 13 Feb 2020 11:45:36 +0000 (UTC)
Date: Thu, 13 Feb 2020 11:45:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
Message-ID: <20200213114535.GB544499@stefanha-x1.localdomain>
References: <20200211141414.12149-1-dplotnikov@virtuozzo.com>
 <20200212154337.GG432724@stefanha-x1.localdomain>
 <f4e65d26-3dac-fbd5-ad63-2d2955ad8d97@virtuozzo.com>
 <20200213090851.GA542404@stefanha-x1.localdomain>
 <859b35f2-b398-f744-36b4-eb604f46c8d9@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <859b35f2-b398-f744-36b4-eb604f46c8d9@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 12:28:25PM +0300, Denis Plotnikov wrote:
>=20
>=20
> On 13.02.2020 12:08, Stefan Hajnoczi wrote:
> > On Thu, Feb 13, 2020 at 11:08:35AM +0300, Denis Plotnikov wrote:
> > > On 12.02.2020 18:43, Stefan Hajnoczi wrote:
> > > > On Tue, Feb 11, 2020 at 05:14:14PM +0300, Denis Plotnikov wrote:
> > > > > The goal is to reduce the amount of requests issued by a guest on
> > > > > 1M reads/writes. This rises the performance up to 4% on that kind=
 of
> > > > > disk access pattern.
> > > > >=20
> > > > > The maximum chunk size to be used for the guest disk accessing is
> > > > > limited with seg_max parameter, which represents the max amount o=
f
> > > > > pices in the scatter-geather list in one guest disk request.
> > > > >=20
> > > > > Since seg_max is virqueue_size dependent, increasing the virtqueu=
e
> > > > > size increases seg_max, which, in turn, increases the maximum siz=
e
> > > > > of data to be read/write from a guest disk.
> > > > >=20
> > > > > More details in the original problem statment:
> > > > > https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.ht=
ml
> > > > >=20
> > > > > Suggested-by: Denis V. Lunev <den@openvz.org>
> > > > > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > > > ---
> > > > >    hw/block/virtio-blk.c | 4 ++--
> > > > >    hw/core/machine.c     | 2 ++
> > > > >    hw/scsi/virtio-scsi.c | 4 ++--
> > > > >    3 files changed, 6 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > > > index 09f46ed85f..6df3a7a6df 100644
> > > > > --- a/hw/block/virtio-blk.c
> > > > > +++ b/hw/block/virtio-blk.c
> > > > > @@ -914,7 +914,7 @@ static void virtio_blk_update_config(VirtIODe=
vice *vdev, uint8_t *config)
> > > > >        memset(&blkcfg, 0, sizeof(blkcfg));
> > > > >        virtio_stq_p(vdev, &blkcfg.capacity, capacity);
> > > > >        virtio_stl_p(vdev, &blkcfg.seg_max,
> > > > > -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2=
 : 128 - 2);
> > > > > +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2=
 : 256 - 2);
> > > > This value must not change on older machine types.
> > > Yes, that's true, but ..
> > > > So does this patch
> > > > need to turn seg-max-adjust *on* in hw_compat_4_2 so that old machi=
ne
> > > > types get 126 instead of 254?
> > > If we set seg-max-adjust "on" in older machine types, the setups usin=
g them
> > > and having queue_sizes set , for example, 1024 will also set seg_max =
to 1024
> > > - 2 which isn't the expected behavior: older mt didn't change seg_max=
 in
> > > that case and stuck with 128 - 2.
> > > So, should we, instead, leave the default 128 - 2, for seg_max?
> > Argh!  Good point :-).
> >=20
> > How about a seg_max_default property that is initialized to 254 for
> > modern machines and 126 to old machines?
> Hmm, but we'll achieve the same but with more code changes, don't we?
> 254 is because the queue-size is 256. We gonna leave 128-2 for older mach=
ine
> types
> just for not breaking anything. All other seg_max adjustment is provided =
by
> seg_max_adjust which is "on" by default in modern machine types.
>=20
> to summarize:
>=20
> modern mt defaults:
> seg_max_adjust =3D on
> queue_size =3D 256
>=20
> =3D> default seg_max =3D 254
> =3D> changing queue-size will change seg_max =3D queue_size - 2
>=20
> old mt defaults:
> seg_max_adjust =3D off
> queue_size =3D 128
>=20
> =3D> default seg_max =3D 126
> =3D> changing queue-size won't change seg_max, it's always =3D 126 like i=
t was
> before

You're right!  The only strange case is a modern machine type with
seg_max_adjust=3Doff, where queue_size will be 256 but seg_max will be
126.  But no user would want to disable seg_max_adjust, so it's okay.

I agree with you that the line of code can remain unchanged:

  /*
   * Only old machine types use seg_max_adjust=3Doff and there the default
   * value of queue_size is 128.
   */
  virtio_stl_p(vdev, &blkcfg.seg_max,
               s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);

Stefan

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5FNt8ACgkQnKSrs4Gr
c8iUvAgAnQ9T3TGEPHrH3hHmzwP8NrbnT5An/0WMwToRMQA+gNKEblMppa2+yhQI
St/zXeWARXuIwX3hZ4+bC7qROwv/5oy2ZXZHPNX82OyQLRTPESlN1C9ZsHDQSMRB
q8QpkcgPWbvCW2qfNkYgbVnvHwwxyOETKfoIZwJpht98pGBDuxB3kX02DfFmIugH
ZKFkqKJUQd7+/jCuQ1Us8dfHDe5YjyGYHu/Ow15e93vELLvn1a4Fg+ldXCZYRAER
EfdBhH39464HIAwlXh0kPqls9QZH+X6EGNXXzZ0klgV0oMuZJ/j7bkxU63N68ZoH
scmp0Fq4mxlFzVt16uHJTu58nV0LPw==
=9i85
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--


