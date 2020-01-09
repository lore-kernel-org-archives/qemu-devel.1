Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17102C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 01:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FCA206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 01:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p5E3sPoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FCA206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipN0U-0005Zn-0a
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 20:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ipMzD-0004b9-8J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 20:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ipMzA-0000nS-7X
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 20:51:46 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52461 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ipMz9-0000ar-4z; Wed, 08 Jan 2020 20:51:44 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47tTcT451dz9sRf; Thu,  9 Jan 2020 12:51:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578534697;
 bh=5z+73++uW+K09ix6A262zZJiXGmBjuSc6+80Yg5XvfY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p5E3sPoOzRH7gtdLXAFsBlCw2SKN88kn3D8ki2/nD2PhO+aTIycK0QmrdollhZ6jM
 hi0obE9mB6qDeNZqTQ0Dogbq2AxFZHD/OVB7fqIQju22NSYya6FEI1KrcW6NtJeFIg
 mmZq1I6kTKRUzPH3IQoB1pvzW8gCwzR8Wh+Gatso=
Date: Thu, 9 Jan 2020 12:33:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/2] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
Message-ID: <20200109013346.GC8586@umbus.fritz.box>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
 <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
 <56272b35-c0ed-65de-310d-f97090e2b8c1@redhat.com>
 <20200108005453.GD2137@umbus.fritz.box>
 <20200108115845.07f10453@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <20200108115845.07f10453@bahia.lan>
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 11:58:45AM +0100, Greg Kurz wrote:
> On Wed, 8 Jan 2020 11:54:53 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jan 07, 2020 at 07:32:03PM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> > > Hi Greg,
> > >=20
> > > On 1/7/20 5:32 PM, Greg Kurz wrote:
> > > > The proper way to do that would be to use device_class_set_parent_r=
ealize(),
> > > > but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_=
realize
> > > > pointer adds a fair amount of code. Calling pnv_psi_realize() expli=
citely
> > > > is fine for now.
> > > >=20
> > > > This should probably be achieved with a device realize hook in the
> > > > PSI base class and device_class_set_parent_realize() in the children
> > > > classes.
> > >=20
>=20
> I realize that this last paragraph is a leftover. First paragraph already
> mentions device_class_set_parent_realize() as being the "proper way".
>=20
> David,
>=20
> Can you remove it in your tree ? No big deal if you can't.

Sorry, not any more - I've already sent the PR.

>=20
> > > Can you add a note explaining why the POWER10 PSI doesn't need it?
> >=20
> > For now, POWER10 uses the Pnv9PsiClass, I believe, so the question
> > doesn't arise.
> >=20
>=20
> This is correct and also a bit confusing, as proves Philippe's remark.
> Maybe we should come up with a PnvXivePsiClass and specialize it for
> POWER9 and POWER10.
>=20
> > >=20
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > > ---
> > > >   hw/ppc/pnv_psi.c |   19 ++++++++++++-------
> > > >   1 file changed, 12 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > > > index 6c94781e377d..546232106756 100644
> > > > --- a/hw/ppc/pnv_psi.c
> > > > +++ b/hw/ppc/pnv_psi.c
> > > > @@ -469,6 +469,16 @@ static void pnv_psi_reset_handler(void *dev)
> > > >       device_reset(DEVICE(dev));
> > > >   }
> > > > +static void pnv_psi_realize(DeviceState *dev, Error **errp)
> > > > +{
> > > > +    PnvPsi *psi =3D PNV_PSI(dev);
> > > > +
> > > > +    /* Default BAR for MMIO region */
> > > > +    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > > > +
> > > > +    qemu_register_reset(pnv_psi_reset_handler, dev);
> > > > +}
> > > > +
> > > >   static void pnv_psi_power8_instance_init(Object *obj)
> > > >   {
> > > >       Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> > > > @@ -528,9 +538,6 @@ static void pnv_psi_power8_realize(DeviceState =
*dev, Error **errp)
> > > >       memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_o=
ps, psi,
> > > >                             "psihb", PNV_PSIHB_SIZE);
> > > > -    /* Default BAR for MMIO region */
> > > > -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > > > -
> > > >       /* Default sources in XIVR */
> > > >       for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
> > > >           uint8_t xivr =3D irq_to_xivr[i];
> > > > @@ -538,7 +545,7 @@ static void pnv_psi_power8_realize(DeviceState =
*dev, Error **errp)
> > > >               ((uint64_t) i << PSIHB_XIVR_SRC_SH);
> > > >       }
> > > > -    qemu_register_reset(pnv_psi_reset_handler, dev);
> > > > +    pnv_psi_realize(dev, errp);
> > > >   }
> > > >   static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, in=
t xscom_offset)
> > > > @@ -873,9 +880,7 @@ static void pnv_psi_power9_realize(DeviceState =
*dev, Error **errp)
> > > >       memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9=
_mmio_ops, psi,
> > > >                             "psihb", PNV9_PSIHB_SIZE);
> > > > -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > > > -
> > > > -    qemu_register_reset(pnv_psi_reset_handler, dev);
> > > > +    pnv_psi_realize(dev, errp);
> > > >   }
> > > >   static void pnv_psi_power9_class_init(ObjectClass *klass, void *d=
ata)
> > > >=20
> > > >=20
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4WgvgACgkQbDjKyiDZ
s5Lk5g/9HKY4cTbGRE7Ie4bDSHTdXQuCyFkUMRXy4IW1IQscExMFWf4RbYmU2fBu
htq7GchnqdzdvSllaqPxXJcQ6OZYtvPmo7O8aG7hHwNuozcIlNCWNDFynJa4UuWr
DZdNSqmKM6w2M3lCuU33OjMCp7hTI8Sx34EaRrc8W3+J8sQPQcMXOIB6X19Wgnlr
2hbJHicIlC7Ri1N7vFCWMqmPWA5ES5QifSpjGbYwLKO7GyGOgOA4M/vsBFF1q9un
edMA5vXuN54w/jmIjk0H1w45DCIfljrIqMSC4zmkpdpS+OldM9Wv+2Ond66J2uar
olfFd/COJ+vI33i0EoGiY0UceOIByOdhGFlBJAvl34b8H5jGVNqF0N+b67ammjPw
x1yZhhxyvZq+zYcdDVBEfXhaMY/Z7uSUxgkrLPiTkDK5alY9YaRY5A+dpL87620t
hPPgR6FujkGFn249g1EJj7WSsWLvPoPxgerghX8PywS77zakRHk5gTdj14BBWRDw
30hE/Lb4uVwQ6VpdaRv7XK7skXFdN/XeH3aYuOCMg9Yz1h/ETVVwrFR1vKdD38f5
SJUJ7/vdV+iUXcK2iLYmh5GMRxyJucFknSiN61BOJizuHfeN4t9uqLpmZRhv6U70
rhDGUa/ztsNnW8yUhoYvC8P5lwevYH9cHNMdmd3dAoW4yvAmvHM=
=kOs6
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--

