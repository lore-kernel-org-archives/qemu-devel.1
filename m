Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA081C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 00:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A099420857
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 00:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VPqNoj7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A099420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51247 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE1FY-0007JL-Ke
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 20:38:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hE1El-00070g-8A
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hE1Ek-0004Wh-0r
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:37:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49981 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hE1Ei-0004Mk-BI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:37:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44f4ws4wlwz9sTk; Wed, 10 Apr 2019 10:37:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554856621;
	bh=kXuoDgF2/8ZMEQb1KsoXXGNZqCP+GESXCG/qIqqtB2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPqNoj7SziA+fI3CjkiHdOu+rUvmlFk07186BlQlbQfqMHJGeORj/XGGe9ZVy1NJm
	KDXd5cChylmYoj/KA4x6UHnqpipuG4uG58PkgHYJ5MWpSf86GPXFHIMDuXIZjUGTjh
	luyqJMqLTLS7mQGmQdyxTDrtjUPPvnAzrhtpiydg=
Date: Wed, 10 Apr 2019 10:29:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190410002930.GM16627@umbus.fritz.box>
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Content-Disposition: inline
In-Reply-To: <f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com,
	Markus Armbruster <armbru@redhat.com>, slp@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410002930.JBLBqazrES_V3ZEuygGhyVZZzmXvH4-5qdrFsYpL1SY@z>


--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 08:59:55PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 4/9/19 7:40 PM, Markus Armbruster wrote:
> > If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> > computation of @dt_size overflows to a negative number, which then
> > gets converted to a very large size_t for g_malloc0() and
> > load_image_size().  In the (fortunately improbable) case g_malloc0()
> > succeeds and load_image_size() survives, we'd assign the negative
> > number to *sizep.  What that would do to the callers I can't say, but
> > it's unlikely to be good.
> >=20
> > Fix by rejecting images whose size would overflow.
> >=20
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  device_tree.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/device_tree.c b/device_tree.c
> > index 296278e12a..f8b46b3c73 100644
> > --- a/device_tree.c
> > +++ b/device_tree.c
> > @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, in=
t *sizep)
> >                       filename_path);
> >          goto fail;
> >      }
> > +    if (dt_size > INT_MAX / 2 - 10000) {
>=20
> We should avoid magic number duplication.
> That said, this patch looks safe.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

As Philippe says, the test condition is kinda ugly and I hope we can
refine it in future.  But since it fixes a real problem for now,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlytOOcACgkQbDjKyiDZ
s5I+eA/+KBsDfN495s/Zc2DWFdJVJOfFu6IpSLE+uXW/h0cNdfKXY92xtbbrja/D
QgB8NTxx24jZEVqyHvdcHGCT+EB130iqXukKNKAsg7ERBlXHw+8ve7DXFmC3xmiQ
N5y/haQV6FinDB9piMvAxxHzNsN4ycLxIy3sOX1yGFu3sdUpigjO3BVWSa9oFHIZ
YPLvUNn5ravQvZHC4MwHfkYSovmGFeSkSPMKvcbgzSxKv43u5pACu/Zb/kD4f76g
5ld0e2onlMH+N5HwMHuKXt9eclwkolbIPEwWpEvND7M1z6XxbSEgwSr38yT1vzYk
S53ESmmUyGaMLuvovAxHIQ2C1YcTjHLaUMOeeB6smw/J+gEKjfHoZZaSVHPHqjt1
FZiSoirDKiXwlgXwItCSEeNqfU+sKbYv3DINon24VjPxfVdJ0AmVv+4Z+XM2Pv19
oXfoRv54If8q2D5eQ3hp/sLRJ+4h0AU2n/QyRjoYw9SO0BeruxZLRyKRhEr1cFkq
H4mSMVnXD9xPea7wBiyrjAHMpItVCeLUefEJ9PNbG36K1ClVu1qWJslchRKJrXtz
EpuMRip1ByjA9nA5srQ91Fdy9wP3NuGE5jnvcma/3nEB3zHjRaY/nRHMwI/jXbAX
VA6pElKKkV21YTkhvJagTZS4qwPIoF/yV+0PE+KnbA6vcXz3ZY8=
=eS2N
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--

