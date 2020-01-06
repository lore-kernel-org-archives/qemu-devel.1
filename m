Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F65C32771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DE9206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S7OnxRCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DE9206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iocMh-0002H1-3Y
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 19:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iocJk-0007qn-IB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iocJi-0005Wf-W5
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:01:52 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59295 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iocJh-0005Pf-V6; Mon, 06 Jan 2020 19:01:50 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sCGf1CZ0z9sR4; Tue,  7 Jan 2020 11:01:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578355306;
 bh=Elu1bG8fkh+Mkm/ZFNkrkRJ6NChkxlokegsR1CzbTxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S7OnxRCxLQK5eiSHGT2Cppc5D5wHJRy6w3Zlfsho9UXjSf0jTKqsAfp/2JW6uHL+g
 4YzRcbQmAiZvhnzwNYPeCI6M7Fkv1howlfGe7/HawGIZ0kizGweuxUfNuIat+mMqyz
 zBx7EDnMpbI2nOh+HPL7Mh5CUIFtlM0CdDP/SlXU=
Date: Tue, 7 Jan 2020 10:56:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200106235604.GA2098@umbus>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <d8ad377b-3ac1-d190-af5e-342b0e0ba47d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0FWGRsEUTYx4i2U9"
Content-Disposition: inline
In-Reply-To: <d8ad377b-3ac1-d190-af5e-342b0e0ba47d@ozlabs.ru>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0FWGRsEUTYx4i2U9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 12:39:42AM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 06/01/2020 15:19, David Gibson wrote:
>=20
> > > +    const struct fdt_property *prop;
> > > +    const char *tmp;
> > > +
> > > +    readstr(prevaddr, prev);
> > > +    for (offset =3D fdt_first_property_offset(fdt, offset);
> > > +         (offset >=3D 0);
> > > +         (offset =3D fdt_next_property_offset(fdt, offset))) {
> > > +
> > > +        prop =3D fdt_get_property_by_offset(fdt, offset, &namelen);
> >=20
> > fdt_getprop_by_offset() also returns the property's name without
> > having to dick around with fdt_get_string() manually.
>=20
>=20
> btw I looked quickly:
>=20
> const void *fdt_getprop_by_offset(const void *fdt, int offset,
>                   const char **namep, int *lenp)
> {
>     const struct fdt_property *prop;
>=20
>     prop =3D fdt_get_property_by_offset_(fdt, offset, lenp);
>     if (!prop)
>         return NULL;
>     if (namep) {
>         const char *name;
>         int namelen;
>         name =3D fdt_get_string(fdt, fdt32_ld(&prop->nameoff),
>                       &namelen);
>         if (!name) {
>             if (lenp)
>                 *lenp =3D namelen;
>             return NULL;
>         }
>         *namep =3D name;
>     }
>=20
>     /* Handle realignment */
>     if (fdt_version(fdt) < 0x10 && (offset + sizeof(*prop)) % 8 &&
>         fdt32_ld(&prop->len) >=3D 8)
>         return prop->data + 4;
>     return prop->data;
> }
>=20
>=20
> and incorrectly assumed *lenp is the name length because of "*lenp =3D
> namelen". Huh :)

Ah, yeah, that is a bit confusing, but I don't see a way to improve
it.  That's the error case, in which case both *lenp and namelen are
carrying an error code, not their usual value.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0FWGRsEUTYx4i2U9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4TyRQACgkQbDjKyiDZ
s5JapQ/+My7C8MCbmRY1kYkcW+a3Zs3CigTEwlgePzvokKFbO5LNl7bjQ7QL3R3+
yj4VvhxBDaZswp4xaqUaxt9JhmmSAL34+Xp9CbaC00wT8Jc/kPMHn0gfLEcu1vUT
MrVqV0HkM5u3YxaIsm7hPkmt7GfynwSPGQoJljPKZXBfp/Y9/y2dGQiDogBtDHY8
eSCSFreOEGrZIExp523EQjU0lquDXlzm/YauDHiE1h5iOoYgFzbcgBIoBxDUuTaC
DOoZuNDRgAovap7CTrDhJ3pFCmYy0RExzyslDZE3z5MzNT0UXCAREc8AfLgXIpcs
aTiWaJyqMBZ1KEQxyVbbqb937d/L4vtUXUKmYVzy7RtWWI1GfrLkf4Mao4+6k9j6
w36aFvsvcKOVtYdMTU+LRhn5FuyxNNO8lN5O8oZD0makleThNFNjzzN+zm7wka+D
FFGzTrr105qwCUIApI3ZT4Lhe9xdgLdUCWBEp1HvyTgUWT7GzYC8eAz5QTruOae3
NqZGmQU7CfqXD9rYiKkBD/EuOfwkKCWSLmDvCyHazWTChovKSpbca4/zkHZwWpBm
MBavu9E2+PTvdX0FHnxeZiwes+R+B8bMxdFG7W1cxeyNKEsdrTWkSfj0PyxR8EwE
2Ba8sGiH1uxSpd009zrBHxdiYrjuuYk9QGbBj/wOjL+Eno5w39E=
=Z1ni
-----END PGP SIGNATURE-----

--0FWGRsEUTYx4i2U9--

