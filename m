Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11EFC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4864020673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4864020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heMP4-0007SL-1u
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 12:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1heMNv-0006oT-7O
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1heMNu-0003r8-6Z
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:27:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1heMNt-0003pH-Vu
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:27:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A79330BC100;
 Fri, 21 Jun 2019 16:27:24 +0000 (UTC)
Received: from localhost (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08C18604CC;
 Fri, 21 Jun 2019 16:27:13 +0000 (UTC)
Date: Fri, 21 Jun 2019 17:27:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190621162712.GA10947@stefanha-x1.localdomain>
References: <20190621094005.4134-1-stefanha@redhat.com>
 <20190621094005.4134-3-stefanha@redhat.com>
 <CAMxuvaz64dd00mhoZ4QjOZ_eGPMw_WBJQN1tWS0ueUhpSsN1SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <CAMxuvaz64dd00mhoZ4QjOZ_eGPMw_WBJQN1tWS0ueUhpSsN1SQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 21 Jun 2019 16:27:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] libvhost-user: support many virtqueues
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
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2019 at 03:48:36PM +0200, Marc-Andr=E9 Lureau wrote:
> On Fri, Jun 21, 2019 at 11:40 AM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> > diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-us=
er-blk/vhost-user-blk.c
> > index 86a3987744..ae61034656 100644
> > --- a/contrib/vhost-user-blk/vhost-user-blk.c
> > +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> > @@ -25,6 +25,10 @@
> >  #include <sys/ioctl.h>
> >  #endif
> >
> > +enum {
> > +    VHOST_USER_BLK_MAX_QUEUES =3D 8,
> > +};
>=20
> why do you use enum,(and not const int) ? (similarly for other devices)
>=20
> other than than
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

This is how I was taught when I was a little boy.

With an actual variable there's a risk that the compiler reserves space
for a variable when you actually just need a constant.  Whether modern
compilers do that or not, I don't know.

The type is clearer when a variable is used instead of an enum.

Pros and cons...

Stefan

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0NBWAACgkQnKSrs4Gr
c8i6NggAp0i1+C51JiDFfBU8g1BCCR3UFaA8K7Q5pv/5IAB7Vm/Zh1oB7X/RqoVc
WFFUqEg0z42LeGMyGExxkwkUfnq5saVbFLmP7AE4wEenBRKqQ4dRj6msxJhyYcM6
BM9wegfyN15gDDFvbVt489aRpIe9+y/O3NdNuKtpvz3cPTY8RQ2r/WzCEMFJo4zi
h8y4TfXdYCjLJjL83a8Clrk1x0F1PPBorVZG4CoaiOeEnjloJxm8f4tMcfB475hj
iJ0Ci8ymqXpKnYLC+gvDYE79ZQZoKz4jkAxoUOGK4WbQlCmcu2wrfVi6AIEv4iNk
tGgbBnCQ8TJs+TcONTOogMuZMm8RDw==
=iDYn
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

