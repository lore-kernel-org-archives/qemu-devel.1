Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C2DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C9020848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ64KWIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C9020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2AVg-000621-OB
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2AUd-0005GZ-CC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2AUc-00078S-4f
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:09:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2AUb-00076g-VT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581584945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IH9YEePaC6lCXKpSIsTBVyXPceRZF2bu/KhGiHKOVcY=;
 b=iZ64KWIBdzZtwUD0Vb9tAutMjQVnSOAmKP57/n/jsSwGVpYXs6nma1fcmxdiuAsQOT08BB
 dRCJBXpI3wCCPSypucInKTFQsotaz3ToZDPl6AG3Uv77SydnkQAvOrx63XGbKnmP65GSQy
 hWOcGTROM3/mgocZMJozqa2Su5Zew+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-wPHL0AihMKStcs8IjTJlZg-1; Thu, 13 Feb 2020 04:08:57 -0500
X-MC-Unique: wPHL0AihMKStcs8IjTJlZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B537A18A5508;
 Thu, 13 Feb 2020 09:08:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 970FA8EA1A;
 Thu, 13 Feb 2020 09:08:52 +0000 (UTC)
Date: Thu, 13 Feb 2020 09:08:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
Message-ID: <20200213090851.GA542404@stefanha-x1.localdomain>
References: <20200211141414.12149-1-dplotnikov@virtuozzo.com>
 <20200212154337.GG432724@stefanha-x1.localdomain>
 <f4e65d26-3dac-fbd5-ad63-2d2955ad8d97@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f4e65d26-3dac-fbd5-ad63-2d2955ad8d97@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 11:08:35AM +0300, Denis Plotnikov wrote:
> On 12.02.2020 18:43, Stefan Hajnoczi wrote:
> > On Tue, Feb 11, 2020 at 05:14:14PM +0300, Denis Plotnikov wrote:
> > > The goal is to reduce the amount of requests issued by a guest on
> > > 1M reads/writes. This rises the performance up to 4% on that kind of
> > > disk access pattern.
> > >=20
> > > The maximum chunk size to be used for the guest disk accessing is
> > > limited with seg_max parameter, which represents the max amount of
> > > pices in the scatter-geather list in one guest disk request.
> > >=20
> > > Since seg_max is virqueue_size dependent, increasing the virtqueue
> > > size increases seg_max, which, in turn, increases the maximum size
> > > of data to be read/write from a guest disk.
> > >=20
> > > More details in the original problem statment:
> > > https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
> > >=20
> > > Suggested-by: Denis V. Lunev <den@openvz.org>
> > > Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> > > ---
> > >   hw/block/virtio-blk.c | 4 ++--
> > >   hw/core/machine.c     | 2 ++
> > >   hw/scsi/virtio-scsi.c | 4 ++--
> > >   3 files changed, 6 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index 09f46ed85f..6df3a7a6df 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -914,7 +914,7 @@ static void virtio_blk_update_config(VirtIODevice=
 *vdev, uint8_t *config)
> > >       memset(&blkcfg, 0, sizeof(blkcfg));
> > >       virtio_stq_p(vdev, &blkcfg.capacity, capacity);
> > >       virtio_stl_p(vdev, &blkcfg.seg_max,
> > > -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 1=
28 - 2);
> > > +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 2=
56 - 2);
> > This value must not change on older machine types.
> Yes, that's true, but ..
> > So does this patch
> > need to turn seg-max-adjust *on* in hw_compat_4_2 so that old machine
> > types get 126 instead of 254?
> If we set seg-max-adjust "on" in older machine types, the setups using th=
em
> and having queue_sizes set , for example, 1024 will also set seg_max to 1=
024
> - 2 which isn't the expected behavior: older mt didn't change seg_max in
> that case and stuck with 128 - 2.
> So, should we, instead, leave the default 128 - 2, for seg_max?

Argh!  Good point :-).

How about a seg_max_default property that is initialized to 254 for
modern machines and 126 to old machines?

Stefan

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5FEiMACgkQnKSrs4Gr
c8ieJwf/ZPRW9eVHhF/VQWvfp80m7q+0PZZnOg3tzObEJjYU6eYc5HL3NWUBYMrj
8C0c6zVcZyooELHZhSUdpAC6uKJqC0Ry6yNYdL4rOOhYNjY+bZ/bJxsFnW6sN0vB
dIjevsKCnQUZT63gosP6b+fU6H9kvdoV23EMWVyPAmAaucF2/FqeHcjk0ezHxaBS
nndt2sp9BMC1WzcdkMHu2xrS1b1wnSYXrqt0PlgYVSgpJpS9qhokoFp80Vg0FVJt
Nm2O4a8WqgEdXPyZkTZd2XtvDgSpu1HJpXiSrbLtAmi00zhZ/2J1mjr6WUVVyuFA
LwMBo3arSJcLoWGtXy9eUajlgEe80A==
=bQEK
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--


