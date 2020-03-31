Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BA0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA572072A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SPxrYnCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA572072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ7ZX-00075R-CQ
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ7Yc-0005xT-5N
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ7Yb-0000Pk-32
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:27:18 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42849)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJ7Ya-0000Nb-Ng; Mon, 30 Mar 2020 23:27:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48rvry4jcdz9sSJ; Tue, 31 Mar 2020 14:27:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585625234;
 bh=mRgLVolW5cZgdLeNL+vxFUJFVUQEcvmd2mxQB2nsYks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SPxrYnCylJf+Oz4lhpQUfPoIGGuDk36T6my6r5AbuzkVAdxndqZeOpyJfDbHc6LUJ
 ub2vDMpknk3KZn+Z2N3J0xIhTu2VH8wVJjMZ/5eQpoHX+S8jqjn1keKZteBc+Ibbyq
 Kz3C/g2f2zvJZMwt1QvarXgugiuMG+pjbm/YRXDQ=
Date: Tue, 31 Mar 2020 14:25:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [RFC for-5.1 4/4] spapr: Don't allow unplug of NVLink2 devices
Message-ID: <20200331032517.GI47772@umbus.fritz.box>
References: <20200326054009.454477-1-david@gibson.dropbear.id.au>
 <20200326054009.454477-5-david@gibson.dropbear.id.au>
 <ae8590db-161a-fd06-bd87-06d4fffc1718@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DwoPkXS38qd3dnhB"
Content-Disposition: inline
In-Reply-To: <ae8590db-161a-fd06-bd87-06d4fffc1718@ozlabs.ru>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DwoPkXS38qd3dnhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2020 at 11:32:18PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 26/03/2020 16:40, David Gibson wrote:
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
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
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
>=20
>=20
> Just this would do as well:
>=20
> Object *po =3D OBJECT(pdev);
> uint64_t tgt =3D object_property_get_uint(po, "nvlink2-tgt", NULL);
>=20
> if (tgt) {
>      error_setg(errp, "PCI: Cannot unplug NVLink2 devices");
>      return;
> }
>=20
> honestly, I admin what 1/4 fixes is cryptic but since there is not going
> to be any more new nvlinkX, this does not deserve this many patches
> imho.

Good point, that is a simpler approach.

>=20
> =09
>=20
> > +
> >          /* ensure any other present functions are pending unplug */
> >          if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
> >              for (i =3D 1; i < 8; i++) {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DwoPkXS38qd3dnhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6CuBoACgkQbDjKyiDZ
s5L+bA/9GCu3Bee2NhZ8YcTQrBXQ3t1j6ieI0hhCJMwDjD7QduKOKdD640YyF3rX
yV09XDrvq5Khbuz0KlEM3O93eKqQx7ykKYHkkRcnvqaRVFGnVc0TTvrtO8QVVGwa
e2QD0YszIlMII6RXTz9/dmQdmC1nunytMSF+h97xHGKS/qErAMejYi7OWqfqx5+6
4YbU2WGd/J9p9mxiNVzvYeZNU6RiZ10piCtUknKTeqAMIObr1Sj7sCuaoBNE7sNf
bP7o6NiIO2BQJgQx40XpndmWx8/SDr4209KGVFnV4u5rZkjz23YQDb/wLDNbdHMs
CWSq7izBigh0i98TOW3ZZN36BWaDMPNQyuURpLdW8pUQHqOEm0ArkwKxw88DNxkW
0muE0/n4lZ0nLMrUwjeLKuNGMSQxTBP0Gvx7ck1IRQP4jB6ApeRFxyVyFNO3lhgt
KU4406tvIzjvcoX7rcftoypxWaXQphvVzZmtdHlz9nm0y7n9hxey81CUnFkEuiMP
NQ50LlcLisSf6kz2HN8kFWQbbHgt/YpO/XxdIWwAidtd9P/NVff8yBnRDJGLUPuw
Yki4qsUNmSmACSqmCWYs0r79gmWoCq2rCTnhfQxDjjYNqEvuudWgG9JuFYfTc/PQ
JE6F8IugNs2tphe+K/1dlw023plur/Pe6twNdtj5niS6OHukNno=
=/FYJ
-----END PGP SIGNATURE-----

--DwoPkXS38qd3dnhB--

