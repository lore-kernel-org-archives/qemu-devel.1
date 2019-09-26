Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB0C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D109A206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EUn9MfQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D109A206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSej-0001xK-HM
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDSdF-0000Ir-2C
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDSdD-0001z4-Cu
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54325 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDSdD-0001wv-1H; Thu, 26 Sep 2019 08:12:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fDLY6Y6Jz9sNx; Thu, 26 Sep 2019 22:11:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569499909;
 bh=WGDBBCj7A1m4qix12oFtNQCmys/6SjyWLemjS56DPJU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EUn9MfQ4UfQzocClIGJAciFnd6sIBxxI2r6Hq1o/sMXni7lsMOYswifs83euOAV0n
 fS17fjsWxdOVcfWCiGT8UmpGrr4Uzyi9pTNWgjDYBOv9kQIfX7Y0byNlKwK0uMG1zn
 DwReedPbG+rSaldkZHzN2OZP20cwEoPPfXPASpZ8=
Date: Thu, 26 Sep 2019 21:32:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 11/20] spapr: Fix indexing of XICS irqs
Message-ID: <20190926113218.GZ17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-12-david@gibson.dropbear.id.au>
 <20190925221746.7b497c8c@bahia.lan> <20190926013148.GU17405@umbus>
 <20190926092141.66158590@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GOYT2+aw+EAigp19"
Content-Disposition: inline
In-Reply-To: <20190926092141.66158590@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GOYT2+aw+EAigp19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 09:21:41AM +0200, Greg Kurz wrote:
> On Thu, 26 Sep 2019 11:31:48 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Sep 25, 2019 at 10:17:46PM +0200, Greg Kurz wrote:
> > > On Wed, 25 Sep 2019 16:45:25 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > spapr global irq numbers are different from the source numbers on t=
he ICS
> > > > when using XICS - they're offset by XICS_IRQ_BASE (0x1000).  But
> > > > spapr_irq_set_irq_xics() was passing through the global irq number =
to
> > > > the ICS code unmodified.
> > > >=20
> > > > We only got away with this because of a counteracting bug - we were
> > > > incorrectly adjusting the qemu_irq we returned for a requested glob=
al irq
> > > > number.
> > > >=20
> > > > That approach mostly worked but is very confusing, incorrectly reli=
es on
> > > > the way the qemu_irq array is allocated, and undermines the intenti=
on of
> > > > having the global array of qemu_irqs for spapr have a consistent me=
aning
> > > > regardless of irq backend.
> > > >=20
> > > > So, fix both set_irq and qemu_irq indexing.  We rename some paramet=
ers at
> > > > the same time to make it clear that they are referring to spapr glo=
bal
> > > > irq numbers.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > ---
> > >=20
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > >=20
> > > Further cleanup could be to have the XICS backend to only take global
> > > irq numbers and to convert them to ICS source numbers internally. This
> > > would put an end to the confusion between srcno/irq in the frontend
> > > code.
> >=20
> > Yeah, maybe.  But the local srcnos do actually make sense from within
> > the perspective of ICS, so I'm not all that keen to do that.
> >=20
>=20
> Not sure to understand what you mean by "within the perspective of ICS".
>=20
> My concern is actually to get rid of ics->offset users in spapr_irq.c.
>=20
> eg,
>=20
> static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
> {
>     SpaprMachineState *spapr =3D opaque;
>     uint32_t srcno =3D irq - spapr->ics->offset;
>=20
>     ics_set_irq(spapr->ics, srcno, val);
> }
>=20
> It looks like we should do something like:
>=20
> static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
> {
>     SpaprMachineState *spapr =3D opaque;
>=20
>     ics_set_irq(spapr->ics, irq, val);
> }
>=20
> and have ics_set_irq() do:
>=20
>     uint32_t srcno =3D irq - spapr->ics->offset;
>=20
> Are you inferring that it is better to keep the irq to srcno conversions
> in spapr_irq.c ?

Ah, I see what you mean.  So, the reason srcno appears here is that
ics_set_irq() is arguably an internal xics function that we shouldn't
be calling directly from here, but do because of.. reasons.

As it happens, I have another patch in the works which will move this
function back into xics_spapr.c and bind it more tightly to the xics
code, so I think that will address your concern.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GOYT2+aw+EAigp19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2MocEACgkQbDjKyiDZ
s5KHBBAA4dWq/hZ5gRQF7sO65882WkbeJkGrLA2U7fyE2X3mFfxqwqckYrQcok+i
r93pr8paca54GCjYj4GqOT/7O76qmWlvGkEgeNxK05tMhNCsZcU5D5uvic6gtLyn
ry81wchDwQp3SutviUJTyHMjl+OHlriu2G4kjQB7WKwXU+MKQe6pbB9P1kIunaEw
SPI66ChTKWy/rl9Kx2a0sF1pE+Eyy0D1SnsZvhOskgIlJzHKAE9LDNOafs4SYWo8
9RYq5DbSa3SROh6JGhD/TyFp17PUFtXa6faIYEByCo2f5f+RQcbvYhcm4CVYGld/
+u9ZqtBtW2dI4gS4cyFH1q/yWhN/aXTaNxMFFW6auGz4+bFuZ6pgETK1OEBd482U
Jn+LCRwS0bDlI0pxR4kMuoIsVnJT9rCb+NJstX8BIhuDgau4kcs6J1x7K1SEw23T
Sglpk35AXE+0+O5Kj/sLN/BgRhWFiTVF3bQ0ApytHlo1bsTMXSq9pmhHpD6aYWCv
dFaJtFjW3CjbGO20iu/RnUmO3DKtGj/bq+tAkKZnSSKq+bd9NfTuq8h3ueruSuIG
RLgYJkzuqoZBvjyXD9HIzRSwUigpoJK1//sT9jvW+389xJVykmiLDlEPCnIxdyyH
bpXlq2/wlLj7AYnsOpbb6c0URutNbD5QfjYp3iyMPBcxH9ji1WI=
=NGkZ
-----END PGP SIGNATURE-----

--GOYT2+aw+EAigp19--

