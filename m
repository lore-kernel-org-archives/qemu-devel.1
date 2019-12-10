Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD5CC2D0C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4E72073D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MB85jzUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4E72073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieqFF-0008MK-Ey
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 19:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC9-0004TM-U5
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC8-0002IC-5z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:37 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:46457)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieqC7-0002FL-5w; Tue, 10 Dec 2019 19:49:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47XdcC2g7tz9sRH; Wed, 11 Dec 2019 11:49:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576025371;
 bh=O3DBjh9tDJVwDzt4Pow0v3ntRJApn1aCpeEX8fDsdcs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MB85jzUpUfgk/1Cw+NSdoyJsOix6C0G13S2PYiegApH6qsZJMvZlR1dyOM4kNHK9t
 ib6Rql16rbH5h8EQM2/Eky4R7Y73dgzRQJbOV8NKDTZKRXSdnEWq9HCt8/AWzLKhQC
 xK4XWlZJGuZgwBVjvml1nd4KKYchn2JkJjWTJxc0=
Date: Wed, 11 Dec 2019 10:46:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/2] ppc/pnv: Loop on the whole hierarchy to populate the
 DT with the XSCOM nodes
Message-ID: <20191210234609.GN207300@umbus.fritz.box>
References: <20191210135845.19773-1-clg@kaod.org>
 <20191210135845.19773-2-clg@kaod.org>
 <20191210174901.6215ddd4@bahia.tlslab.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GEn4szYucjS2InE7"
Content-Disposition: inline
In-Reply-To: <20191210174901.6215ddd4@bahia.tlslab.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--GEn4szYucjS2InE7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 05:49:01PM +0100, Greg Kurz wrote:
> On Tue, 10 Dec 2019 14:58:44 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > Some PnvXScomInterface objects lie a bit deeper (PnvPBCQState) than
>=20
> I didn't find any trace of PnvPBCQState in the code... what is it ?
>=20
> > the first layer, so we need to loop on the whole object hierarchy to
> > catch them.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/ppc/pnv_xscom.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > index bed41840845e..006d87e970d9 100644
> > --- a/hw/ppc/pnv_xscom.c
> > +++ b/hw/ppc/pnv_xscom.c
> > @@ -326,7 +326,12 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int roo=
t_offset)
> >      args.fdt =3D fdt;
> >      args.xscom_offset =3D xscom_offset;
> > =20
> > -    object_child_foreach(OBJECT(chip), xscom_dt_child, &args);
> > +    /*
> > +     * Loop on the whole object hierarchy to catch all
> > +     * PnvXScomInterface objects which can lie a bit deeper the first
>=20
> s/deeper the first/deeper than the first/

Fixed during commit.

>=20
> > +     * layer.
> > +     */
> > +    object_child_foreach_recursive(OBJECT(chip), xscom_dt_child, &args=
);
> >      return 0;
> >  }
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GEn4szYucjS2InE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3wLkEACgkQbDjKyiDZ
s5JSdw//WF6/QoU3N4FmBY2N5YCdge1TUSHz1AwskR+A1nq/DkS2/IcwwQ6GBB/o
BoTzJVsSs4e1EBghcLqSwwN+Tf6XWq8xj9FAYiYbeLT+Nn+Vo4LsSOnFziZzD2MY
11ks+Eh9/k7kow4sNy7NjfCAYxNoEsMJCpQwPrBsr79MREhV9r8Nes/WtnL4U8Lh
b3Ny+QYl02sB7pLmMqxwh/M4TkLSdcJPSPT5Nky+jJCTBRzFBY4dado1Wr2WBOqC
5jNmlnfTP9Oglz3Nf97qkNrO4LFWo1jGViLYlXtePJIYWUNle46E12uvYbL74cgh
TZsr4wO8CpmVu+q1otsEYQPAel3YDkdstjOhjTmynnyIp+i5dsv+kDE57tB8RH6D
IrhDXPrQHglXQUDVW3nPuUASr3Y1Ukf4A8CQi6wflG9Z3BHD5ulk/EGxLmunjV8H
0oF8BmKqrKfKzTdbFmJEov3RtZ3cizApwKmes5vhoCCmPZeX1vSJdjQhaac6sUKz
XOrE7FVLkO5b4/xBkKBE8Y3ln9E3Z7ba2h7JBJ8YZ5aQKI98N78Ctq143a5uaJM3
aTdBxyrn95m6sC78eke9BvUhptykGBup1k/e9AftcWqv9z+IBipSqEL9kPhJ984m
NOtLIDxFZCXktuFgu6Y+/xTblKhuQUk8cxSmKL5dN8/vMzJOtr4=
=tUSR
-----END PGP SIGNATURE-----

--GEn4szYucjS2InE7--

