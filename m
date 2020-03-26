Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8202C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 01:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC2B2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 01:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kj8eoEFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC2B2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHdNO-0004el-NG
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 21:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHdKp-00025D-PF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHdKn-000149-90
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 20:58:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57149 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHdKm-0000sQ-CD; Thu, 26 Mar 2020 20:58:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48pNlR1FGpz9sSQ; Fri, 27 Mar 2020 11:58:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585270723;
 bh=4cpx6LBopq0bJuaftlDSLeoqb03HUOSZiH6hzd6BclY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kj8eoEFAhl3Zd7CpSPu9vhZ0R3XWfTi8Yrwip3/zJ3lhPY1ugYs57B/udz4h4WJPe
 oaLQGSFRvVfXxWuKLvP36A59aOaFUov67dwMdlIM/ZMc3jthWI2RkwVLSe5YFCzm8m
 9aHZFBI31mIlizK0SH303/GohfLIpn+GOyPtGVk0=
Date: Fri, 27 Mar 2020 10:56:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [RFC for-5.1 4/4] spapr: Don't allow unplug of NVLink2 devices
Message-ID: <20200326235615.GD456060@umbus.fritz.box>
References: <20200326054009.454477-1-david@gibson.dropbear.id.au>
 <20200326054009.454477-5-david@gibson.dropbear.id.au>
 <20200326132740.6f305012@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <20200326132740.6f305012@bahia.lan>
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 01:27:40PM +0100, Greg Kurz wrote:
> On Thu, 26 Mar 2020 16:40:09 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Currently, we can't properly handle unplug of NVLink2 devices, because =
we
> > don't have code to tear down their special memory resources.  There's n=
ot
> > a lot of impetus to implement that. Since hardware NVLink2 devices can't
> > be hot unplugged, the guest side drivers don't usually support unplug
> > anyway.
> >=20
> > Therefore, simply prevent unplug of NVLink2 devices.
> >=20
>=20
> This could maybe considered as a valid fix for 5.0 since this prevents
> guest crashes IIUC. But since this requires the two preliminary cleanup
> patches, I understand you may prefer to postpone that to 5.1.

Yeah, it's arguably a bug, but not a regression, so I'm inclined to
leave it to 5.1.

>=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  hw/ppc/spapr_pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 55ca9dee1e..5c8262413a 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1666,6 +1666,11 @@ static void spapr_pci_unplug_request(HotplugHand=
ler *plug_handler,
> >              return;
> >          }
> > =20
> > +        if (spapr_phb_is_nvlink_dev(pdev, phb)) {
> > +            error_setg(errp, "PCI: Cannot unplug NVLink2 devices");
> > +            return;
> > +        }
> > +
> >          /* ensure any other present functions are pending unplug */
> >          if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
> >              for (i =3D 1; i < 8; i++) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl59QR4ACgkQbDjKyiDZ
s5KUuw//eHYjG7hhTbEnJuzIe5Czo005LgCumC0/x9IFuv0unI3QzS398vy8NfCJ
Z5TO2SvcLndKCbFmGu/c3oO6kPbk+Nf0GYWUf6Y596SS3jOaoz7GygXzpysO/npD
2y9sp4o8mdF+wNDg/136cIIbnyj9344H9j6+pXB3wXZfbY73+3Ari2pePrwNziyc
zYMphCZD+PGK7LL2SC9WqN+o8MNPawqhtWRillxNPgpESfh2xgTE+LmixZR55I1o
3ogMgjtG7GBcj8uMX263W6ibvL1Go8Sh6ZkLX+ErSKscrJgabzuvpP2QL27/297Z
nqUBzSHoIm0eRjTWBkfrMTr8TJaUh2uQhCaYNbdh53yjItdYxM9vm9hcq0abvAJE
n2X+MLCVtAPsUNzJOBNmGsnaqVUmK+oeMwXNA8X/5w3ploJlav15BmnEi/BC3QHs
5t6wbh/5jqgRtQ0g8TYRK0We/5W57u5cdEpc3f2zzOR8O6UrWrP2KPD1ItJkxfUb
dCiy9wZ1reJBQ7Bw+3qu4fZx1fNC0exSxUZ6F09CqvDY+MSSugEgK2MQjzXEeWdK
Lqoaq7drBUDDBMIsQ/BOg4Vmk77f5qNn3SXZayWUETNQiVvELpy5+lI+tzL980pO
UJKcR6YHKbYlf2oC3x2cUeJ5RKacPJ1yGC3bXdsPsggX9YjW29Y=
=nnje
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--

