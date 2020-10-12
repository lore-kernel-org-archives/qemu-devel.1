Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF23206B2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jugCMihL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF23206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRsTS-0001BO-E0
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRsSX-0000E0-FK; Mon, 12 Oct 2020 03:41:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:44669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRsST-000209-T2; Mon, 12 Oct 2020 03:41:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C8rG6622Qz9sTr; Mon, 12 Oct 2020 18:41:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602488478;
 bh=d4GOCpslPD5j4JXhla1D+Q7gmXBSbbRBm6tveHxJm58=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jugCMihL03ZQtBrwkLeSaQrxWVwzG7pCiuIYnkfAbX64eSWpzsV8GaK+r6TE9MjJJ
 rWawQa094mPIxQns48Hr5WkEAC83NGUv6XwkkHsYk8mMbk2wK4OhhwQy7Fy9+h3RKZ
 gJ5hexVAhWxxsT7aTt4wkJvrJXK132jzJ7JBOnEk=
Date: Mon, 12 Oct 2020 17:54:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
Message-ID: <20201012065436.GB71119@yekko.fritz.box>
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <20201011223446.GA4787@yekko.fritz.box>
 <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 08:21:41AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 10/12/20 12:34 AM, David Gibson wrote:
> > On Sun, Oct 11, 2020 at 09:03:32PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> > > The Grackle PCI host model expects the interrupt controller
> > > being set, but does not verify it is present. Add a check to
> > > help developers using this model.
> >=20
> > I don't think thaqt's very likely, but, sure, applied to ppc-for-5.2
>=20
> Do you want I correct the description as:
> "The Grackle PCI host model expects the interrupt controller
> being set, but does not verify it is present.
> A developer basing its implementation on the Grackle model
> might hit this problem. Add a check to help future developers
> using this model as reference."?

No, it's fine.  All I was saying is that the chances of anyone using
Grackle in future seem very low to me.


>=20
> >=20
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > ---
> > >   hw/pci-host/grackle.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> > > index 57c29b20afb..20361d215ca 100644
> > > --- a/hw/pci-host/grackle.c
> > > +++ b/hw/pci-host/grackle.c
> > > @@ -76,6 +76,10 @@ static void grackle_realize(DeviceState *dev, Erro=
r **errp)
> > >       GrackleState *s =3D GRACKLE_PCI_HOST_BRIDGE(dev);
> > >       PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
> > > +    if (!s->pic) {
> > > +        error_setg(errp, TYPE_GRACKLE_PCI_HOST_BRIDGE ": 'pic' link =
not set");
> > > +        return;
> > > +    }
> > >       phb->bus =3D pci_register_root_bus(dev, NULL,
> > >                                        pci_grackle_set_irq,
> > >                                        pci_grackle_map_irq,
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+D/acACgkQbDjKyiDZ
s5JQ9w//ag/3Ch9d98i0BPpoZPDdwu7iAyp/6zJxslagtqJtyWGA1WkpWtEu+lm5
XbIztWXRfJdpHNkxpIJIoAmb7ex8fbsOm+OArAt8IOe9WilqUbyGWlV+JyYVn3oe
cWM8HSUyUM0Gk2rwAiCn/sI07jRiLkeipGbP/LgtuAWiEDG4meyEnUsI/lzvxj73
Q3x61NUwLpAyoCS5tzQ93kGWqV+oJNHMQjqUcr1KFq154/hvLyR8xvw7YQUDlxqT
My3/iWxkglJ+2RE6ZzL3Ft0I+LxNWxM8/LCzIOtE/2zltWBdzsb9IsXpnpLzOGyI
fJCMYnD77wrIgz1HqoIZzKgZgxLFX05R26HJ8+g6JcEog4iZjxjEidabNlG68I+6
GRjRUm71H3/qvuymTc65Na9u1aM52TdV4ILD4iwVDQszBqOThO3mBoSisBAdSlWg
XN8Ug9iqz3jSJaP+/ONFjB8Rpn/OvX4jo79xXdjDCQHkCDY5xb2w7FpnTRD+mVPg
rRJjkcVXBwMFuyXJiKbVtjANjAvTwg+iYYiccb8eMvOadjQFABhOsS06+sW/TiVA
rFNwLgc9AZ8ppxe2tWNPJ6NsfKBaV01ODsxtTdbvdFHQayPlLt5PMlpiYAwV7Rxw
6orBnLQ9T82i9tAcxOdnOwVFacb8lg7CFl455DwTamTU6xHbCnc=
=QS3+
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--

