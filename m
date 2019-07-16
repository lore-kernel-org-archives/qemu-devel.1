Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B8DC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E00220880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E00220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOmO-0000dO-9m
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnOmA-0008Sx-Kg
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnOm0-0006y9-8F
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnOlx-0006wa-Q6; Tue, 16 Jul 2019 10:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 126F730872FD;
 Tue, 16 Jul 2019 14:49:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-24.ams2.redhat.com [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FB925ED40;
 Tue, 16 Jul 2019 14:49:38 +0000 (UTC)
Date: Tue, 16 Jul 2019 16:49:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190716144937.GF7297@linux.fritz.box>
References: <20190716081516.27374-1-mlevitsk@redhat.com>
 <ace970e5-7f1a-d693-952e-3d16da1d0bfe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <ace970e5-7f1a-d693-952e-3d16da1d0bfe@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 16 Jul 2019 14:49:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] LUKS: support preallocation
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.07.2019 um 14:41 hat Max Reitz geschrieben:
> On 16.07.19 10:15, Maxim Levitsky wrote:
> > preallocation=3Doff and preallocation=3Dmetadata
> > both allocate luks header only, and preallocation=3Dfalloc/full
> > is passed to underlying file.
> >=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c       | 29 ++++++++++++++++++++++++++---
> >  qapi/block-core.json |  5 ++++-
> >  2 files changed, 30 insertions(+), 4 deletions(-)
> >=20
> >=20
> > Changes from V3: updated the blockdev-create description
>=20
> Looks good functionally, but there is a syntax problem:
>=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 8237424ae6..034a645652 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
>=20
> [...]
>=20
> > @@ -515,8 +523,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions =
*create_options, Error **errp)
> >          .u.luks =3D *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
> >      };
> > =20
> > +    if (luks_opts->has_preallocation)
> > +        preallocation =3D luks_opts->preallocation;
>=20
> This lacks curly brackets.
>=20
> > +
> >      ret =3D block_crypto_co_create_generic(bs, luks_opts->size, &creat=
e_opts,
> > -                                         errp);
> > +                                         preallocation, errp);
> >      if (ret < 0) {
> >          goto fail;
> >      }
>=20
> [...]
>=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 0d43d4f37c..9c04d83fa2 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4205,13 +4205,16 @@
> >  #
> >  # @file             Node to create the image format on
> >  # @size             Size of the virtual disk in bytes
> > +# @preallocation    Preallocation mode for the new image (default: off;
> > +#                   allowed values: off/metadata/falloc/full (since: 4=
=2E2)
>=20
> Also, this lacks a closing parenthesis somewhere.

You could also view it as having an opening parenthesis where there
should be another semicolon.

Kevin

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdLeQBAAoJEH8JsnLIjy/WTkIP/ipKHXnt1nwZCOOk1yKyNkM4
oixhPlOGq5PfewGcBx1Tpk4mNXJ0TrLB043mO5/OUxGseK4VdilY7xmgBOuYcdzl
bk27vswnsRJsPdGJgqNYsfzSE98ajcunQDcjXWLeH7scTWVn4WS8ZogqxUVOXa0R
r5kA7Nx9o9+xcDGaCQEZoLp+6Dx9iwhCH9jCm4/2s1LmBPCLKsH1qz2JdF6rWM8r
NA802jZmck2uJaZkNDFpIpi2Nor91MnAUcBxhmt4Zd8WAYNyfZLnbyIdCPhcsbYH
+5pwoHiecUeCYtdxVsKZe/2a+f6GgkK5Fp2U4LwDyFggM0zd9M554gu4wLmL0Kuj
tUN9dnpsUZtKX9VKLiysUh+8If+kYzcx9iP31++5Hbj/dVSUd73InxdMu6m4wYxW
CNrYYr756AaZttMI/SLaD5I9E1BoWcZsxWqHqwGCMg79cleEBh1k63qTxBwSYAYn
CdBckkmxe7aVbPHz51Nd7jvThAEVKW6pIr2ypQbfMdNW1N68LYySQrPcBv7IBqeS
0lXDOpEixys3qqnH9FGgk2kL+xxpNHlybd0FLGiPN6DD0E7BTX8YuF1/NyTObmVC
QW5pYH11GUpAAowFzJggwxl6G2EE73jkbHA7UsuDMO4AEDerE7W57XaPmijbyzeu
S91U/f4hwKlbYp8fnTcv
=5FHR
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

