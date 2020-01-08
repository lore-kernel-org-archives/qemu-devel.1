Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1B9C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487F1207E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R09iZ2yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487F1207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iozlN-0002HP-Mi
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 20:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjU-0000WK-Lz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjS-00014y-Vw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:00 -0500
Received: from ozlabs.org ([203.11.71.1]:60947)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iozjS-00012K-AH; Tue, 07 Jan 2020 20:01:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47srYZ5jxZz9sSH; Wed,  8 Jan 2020 12:01:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578445314;
 bh=cFopmRMxx9kLWbOuam2AbKOrnMqrSwXXEy3lldNJDe8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R09iZ2yxF1C4jWih8uqu2rAWElxSo+xv7aNKjAI/3LRfoy/EAsoEGR3OnqQE+Z2wq
 VJ0i1Llcru7bdS4LINVDWF6/c8hFomI7L3/zCm+Qh0FKFTEiNdu+UKkFWONe4VjTYS
 RRvZcf8GIy9HdA3d3p1l1qH3sZqOvIzCBRabS7cA=
Date: Wed, 8 Jan 2020 11:56:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/2] ppc/pnv: check return value of blk_pwrite()
Message-ID: <20200108005650.GE2137@umbus.fritz.box>
References: <20200107171809.15556-1-clg@kaod.org>
 <20200107171809.15556-2-clg@kaod.org>
 <49613a4e-aec8-8ae3-4443-ede9ed1fd39f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline
In-Reply-To: <49613a4e-aec8-8ae3-4443-ede9ed1fd39f@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 07:22:18PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 1/7/20 6:18 PM, C=E9dric Le Goater wrote:
> > When updating the PNOR file contents, we should check for a possible
> > failure of blk_pwrite().
> >=20
> > Fixes Coverity issue CID 1412228.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >   hw/ppc/pnv_pnor.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> > index bfb1e92b0392..0e86ae2feae6 100644
> > --- a/hw/ppc/pnv_pnor.c
> > +++ b/hw/ppc/pnv_pnor.c
> > @@ -33,6 +33,7 @@ static uint64_t pnv_pnor_read(void *opaque, hwaddr ad=
dr, unsigned size)
> >   static void pnv_pnor_update(PnvPnor *s, int offset, int size)
> >   {
> >       int offset_end;
> > +    int ret;
> >       if (s->blk) {
> >           return;
> > @@ -42,8 +43,11 @@ static void pnv_pnor_update(PnvPnor *s, int offset, =
int size)
> >       offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
> >       offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
> > -    blk_pwrite(s->blk, offset, s->storage + offset,
> > -               offset_end - offset, 0);
> > +    ret =3D blk_pwrite(s->blk, offset, s->storage + offset,
> > +                     offset_end - offset, 0);
> > +    if (ret < 0) {
> > +        error_report("Could not update PNOR: %s", strerror(-ret));
>=20
> Can you report the failed offset too please?

Since this fixes a coverity warning, I'm applying now, and extending
the error message can be a followup.

>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> > +    }
> >   }
> >   static void pnv_pnor_write(void *opaque, hwaddr addr, uint64_t data,
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VKNIACgkQbDjKyiDZ
s5Jb9hAAoATj6z/WTPOsS5j/z5M+e35fzw229QLHJ8g8iVqRpg0yquq6WFV1OWtz
AqGTG/HWjpdH/9wWy5n2ZFFapES6uXxvARsjIqujkU70YmRebYf8aRnC8GaoBMLE
lLHbamaIroCC5tfZ+2WBN4WSL3/9VrNVVCxujOaD36kfXbqmwzoBcfRokdXVrrEw
NqWuKew6sPUxWVjEK7w8kDvlGapsBm0jhEMnc/Sm657EvCbenV8EMQJcQ9PA29Gf
diaTHDpb2reU5jiaPewouyHtH4hLJCzquE4gWC8GMPw4v4qmjD7NAJnxUlByeEpD
K+T6LR0+3kVf0esQ8ep1NNMCnuw8nDmIu7/+l08H799SaCD2dAkdgalU4Fp2HUQu
NGB3ON2ujWrMgjK0bz+Hr+WxSzPnIaxvcwVacYb53QrQgXWiJvRnHkUYmfgjyfLZ
GS8HvHAgIFXYdFLRrARHx2WqOfJkX1Ha/IAP2c/RvRuFFGh3Zq/KLrRwXMKvBoV6
bKk814ew47j3NSz8wPmPK/WlKuXry2B14h6rN50fK6oeuackk6EoUe1jWLUMTd8C
nLLtKM+GnbrTeePk0rV9j4qnFE42AFVN5nvbnetwFOmejZVGdgH9FqGZPRnCDz0o
YS3jJibtHQ48iYnRa2POt5eY4XdB2CzpYN+SsomxQSH+PVK3Qgc=
=sRmm
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--

