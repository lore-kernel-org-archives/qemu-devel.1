Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B77C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136F7207E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nMLGyZOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136F7207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57623 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iozmG-0003c5-Ku
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 20:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjU-0000WL-M8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjT-000155-1B
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:00 -0500
Received: from ozlabs.org ([203.11.71.1]:59587)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iozjS-00012L-68; Tue, 07 Jan 2020 20:01:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47srYZ1Gdbz9sRp; Wed,  8 Jan 2020 12:01:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578445314;
 bh=HVgQyNOFPS1MJ4hd15vljSLShz2lxyJu01cy+sOJkGs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nMLGyZOFCaiX5LXK6VhM3y+CbLB+AhvN7nhodvuuGi4v9/gjXG8Fccvfm5SDupUK7
 Bo/85wG5qUQC5Osobj2PoPMPx4K1dTzrZ7Dply+JAy3gEFhTnWaMk6j+kAxc6Enzvd
 W7Pf2sQaNrO1f4FEH5xzGRS5x4auqjy1S6FGwmNM=
Date: Wed, 8 Jan 2020 11:54:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/2] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
Message-ID: <20200108005453.GD2137@umbus.fritz.box>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
 <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
 <56272b35-c0ed-65de-310d-f97090e2b8c1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <56272b35-c0ed-65de-310d-f97090e2b8c1@redhat.com>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 07:32:03PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Greg,
>=20
> On 1/7/20 5:32 PM, Greg Kurz wrote:
> > The proper way to do that would be to use device_class_set_parent_reali=
ze(),
> > but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_real=
ize
> > pointer adds a fair amount of code. Calling pnv_psi_realize() explicite=
ly
> > is fine for now.
> >=20
> > This should probably be achieved with a device realize hook in the
> > PSI base class and device_class_set_parent_realize() in the children
> > classes.
>=20
> Can you add a note explaining why the POWER10 PSI doesn't need it?

For now, POWER10 uses the Pnv9PsiClass, I believe, so the question
doesn't arise.

>=20
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >   hw/ppc/pnv_psi.c |   19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > index 6c94781e377d..546232106756 100644
> > --- a/hw/ppc/pnv_psi.c
> > +++ b/hw/ppc/pnv_psi.c
> > @@ -469,6 +469,16 @@ static void pnv_psi_reset_handler(void *dev)
> >       device_reset(DEVICE(dev));
> >   }
> > +static void pnv_psi_realize(DeviceState *dev, Error **errp)
> > +{
> > +    PnvPsi *psi =3D PNV_PSI(dev);
> > +
> > +    /* Default BAR for MMIO region */
> > +    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > +
> > +    qemu_register_reset(pnv_psi_reset_handler, dev);
> > +}
> > +
> >   static void pnv_psi_power8_instance_init(Object *obj)
> >   {
> >       Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> > @@ -528,9 +538,6 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
> >       memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, =
psi,
> >                             "psihb", PNV_PSIHB_SIZE);
> > -    /* Default BAR for MMIO region */
> > -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > -
> >       /* Default sources in XIVR */
> >       for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
> >           uint8_t xivr =3D irq_to_xivr[i];
> > @@ -538,7 +545,7 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
> >               ((uint64_t) i << PSIHB_XIVR_SRC_SH);
> >       }
> > -    qemu_register_reset(pnv_psi_reset_handler, dev);
> > +    pnv_psi_realize(dev, errp);
> >   }
> >   static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xs=
com_offset)
> > @@ -873,9 +880,7 @@ static void pnv_psi_power9_realize(DeviceState *dev=
, Error **errp)
> >       memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mmi=
o_ops, psi,
> >                             "psihb", PNV9_PSIHB_SIZE);
> > -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > -
> > -    qemu_register_reset(pnv_psi_reset_handler, dev);
> > +    pnv_psi_realize(dev, errp);
> >   }
> >   static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VKF0ACgkQbDjKyiDZ
s5LR8RAAmwZyGeirIhzaxjpqnaVbV5bVjFGhADlERhrB4Q4AHlYe39rN1veDahG9
npOJGxMRGkZAnRu7Z5xYvRMZPZxD8Zg1Gp7YQ1IcIFdAw12pzotsq/9fg9WImaeJ
SqJXnqs8ZCCkQPCoWYI69b5Bhyaf4z4uLaM05oIwWUmCxyH+cDsbDNeOynd1Fsg+
ICf9O4XUzB8D+VNO9eQgdW54Jamf4PiDfHSDIEQiYPv2BbWQlNaDztoXtRarSbPl
m8f6MhpmGgflbY/aHAOVokNLk19SS+C96RW6u+t4FUl95bMN9LPubWs9+K+AAq0X
Vaa3x06WGhLHc4O/YFrYZfczn4Dv1KPYH9aWv1fX8kO1Fc+rxwq3nZYVbgX6JPQS
Zz67GhDVqO44qtQjyjn91ItPmGQhE1x+53QSNkU0rj+lJJm/ZfAfTYYRSkRfYrKn
XGCPNfbr+58sZA5EDHDqwErbxhqPm+l4+JX9INLsZN9PMVGdozLke579TK6q+97u
rzgxp1jVkm0PT4C5RyOPNyJ5fL6xCvwD1elrrgPTYARaj08kIexYiTPalnCI3NsC
/E+r10Y1j/2Pm8F2eRo/uu1rjyj2qkfWKzI2sH3lyyDsKhMrcnRA/Yn8zMkjpxNl
nwtk7z794Sp1/XpfvvTwOUQVAOcf8z0pvTgkAYjwfV+curoCTeo=
=pQEH
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--

