Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585CFC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 02:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B3B2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 02:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SDzCF4gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B3B2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDfw4-0004gD-Ji
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 22:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDfqP-00037B-Az
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 22:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDfqO-00043Y-2w
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 22:51:09 -0400
Received: from ozlabs.org ([203.11.71.1]:47751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDfqN-0003Wo-73; Sun, 15 Mar 2020 22:51:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48ggm53mHwz9sQx; Mon, 16 Mar 2020 13:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584327061;
 bh=QUiuKWsf+iHqX412R07IjOGicNpwSw9a7YbkzZjv/tA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SDzCF4ggI3XLqgSSRjI/W9dHGsoU0+496/dLIQ3p+hnVxf5r0y5sB3Q4VlVbvs12p
 xcFJ95TtC4ctfe3QGC1uMVqC9ci8QmEUrS3zhtYD6Uu4v0Asy5997+lPR0kBJlB4HY
 MVNo8Le/VDQyxEmtE+qn1+8Nl3fDzwE30NPZbp80=
Date: Mon, 16 Mar 2020 13:42:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/4] spapr: Move creation of ibm,architecture-vec-5
 property
Message-ID: <20200316024231.GD2013@umbus.fritz.box>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
 <20200313040539.819138-3-david@gibson.dropbear.id.au>
 <20200313124003.63b87232@bahia.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
In-Reply-To: <20200313124003.63b87232@bahia.home>
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 12:40:03PM +0100, Greg Kurz wrote:
> On Fri, 13 Mar 2020 15:05:37 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This is currently called from spapr_dt_cas_updates() which is a hang ov=
er
> > from when we created this only as a diff to the DT at CAS time.  Now th=
at
> > we fully rebuild the DT at CAS time, just create it alon with the rest
>=20
> s/alon/along

Corrected, thanks.

>=20
> > of the properties in /chosen.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 26 +++-----------------------
> >  1 file changed, 3 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 66289ffef5..fc28d9df25 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -889,22 +889,6 @@ static int spapr_rng_populate_dt(void *fdt)
> >      return ret ? -1 : 0;
> >  }
> > =20
> > -static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
> > -                                SpaprOptionVector *ov5_updates)
>=20
> Heh I should have looked at patch 2 before commenting on patch 1 :)
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > -{
> > -    int offset;
> > -
> > -    offset =3D fdt_path_offset(fdt, "/chosen");
> > -    if (offset < 0) {
> > -        offset =3D fdt_add_subnode(fdt, 0, "chosen");
> > -        if (offset < 0) {
> > -            return offset;
> > -        }
> > -    }
> > -    return spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
> > -                                  "ibm,architecture-vec-5");
> > -}
> > -
> >  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> >  {
> >      MachineState *ms =3D MACHINE(spapr);
> > @@ -1115,6 +1099,9 @@ static void spapr_dt_chosen(SpaprMachineState *sp=
apr, void *fdt)
> > =20
> >      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> > =20
> > +    _FDT(spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
> > +                                "ibm,architecture-vec-5"));
> > +
> >      g_free(stdout_path);
> >      g_free(bootlist);
> >  }
> > @@ -1263,13 +1250,6 @@ void *spapr_build_fdt(SpaprMachineState *spapr, =
bool reset, size_t space)
> >          }
> >      }
> > =20
> > -    /* ibm,client-architecture-support updates */
> > -    ret =3D spapr_dt_cas_updates(spapr, fdt, spapr->ov5_cas);
> > -    if (ret < 0) {
> > -        error_report("couldn't setup CAS properties fdt");
> > -        exit(1);
> > -    }
> > -
> >      if (smc->dr_phb_enabled) {
> >          ret =3D spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_PHB=
);
> >          if (ret < 0) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5u55YACgkQbDjKyiDZ
s5LaKA/9FfVb5uDxTqnj+AQlJKJbsQcK8pYLHy+Kh4IFg0zZKHRlCaslvGMquD2d
zeJI5xu60qcW9NZYIse2hv8SQIUwZr7jCeuIxxDsUuIgjm6ON6x9WhUhCQXHUYeZ
zJjkiCmJywsmjppccdAzLa7taaHS1zLKQfmjQUVwrp8xUaLu3nZWRg6lkyQIENIV
vewKduTmtY9mmriZh9bnIc93XSDCCSHGUZ6vRS77xfCyhYq1tZAPaCWizWRahNjK
J2YgUjjUJphcJREDKE0GeYVyTZaZ5xCEcWjdz3WidmvIG0zg4bumpBl1+EaUL7Rl
DuuwUbvD1UNUKw+z/WJE21cxSguKwhoGtP5cBzc55F9GALnwNxuxmZubOmNgs+J/
ZqBEJD2blk4tkF+MWL/g+/hkXvxcXggtzB83Y4TtkJaiiP8bTl3WgZr6IE8A8PIG
I5HFRza4BNO1bt037zW2yIhTNxtiAjTJQRMRfOX/wYgY1G+rc9Idj43JjBYlorp9
xaHtNyvfchTtZzG4u41vdhK9a7RYnUrmukLm0VG/WIC6ttcPFCyv8+fPEAPZ6SRY
9ZXDAuPNZAOG0ht5MqPhxv0+ip+EpG65J+31Dhcj0dFv49YimCDc2Bg0VxeZg2Ee
AnTDaPYImXQ+JLeui0iwp1zG/78tN7QWL39lvZVk89k5LRmAlUY=
=OwcO
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--

