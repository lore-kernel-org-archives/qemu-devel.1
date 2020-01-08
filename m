Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D1DC33C9B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31FB207E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lYtdIFZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31FB207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iozlO-0002HE-D0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 20:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjV-0000WZ-LD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjU-000175-Gt
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:01 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:57785)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iozjU-00012F-6a; Tue, 07 Jan 2020 20:02:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47srYY6myTz9sQp; Wed,  8 Jan 2020 12:01:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578445313;
 bh=jwxRxnTyjZQUw4M86cOrhsDAuGKvD2V4rxg5jHnmWdY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lYtdIFZlUMUA/a9wtfg8jayzJoccZ0zeDBZSTayn6+R6XiSSs9f2Fxh2MJ2EmMYTJ
 fMdbs92lYqyCvj+zC/3x9WfX+SW1gv7m+cdsOpamFSzkKTgvJQXRmiENbTZMA/UHFg
 0DC4UWbMLkh8BdF4hce0wDaLsmUaDUj4LlJKA1ac=
Date: Wed, 8 Jan 2020 11:54:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/2] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
Message-ID: <20200108005432.GC2137@umbus.fritz.box>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
 <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
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


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 05:32:46PM +0100, Greg Kurz wrote:
> The proper way to do that would be to use device_class_set_parent_realize=
(),
> but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_realize
> pointer adds a fair amount of code. Calling pnv_psi_realize() explicitely
> is fine for now.
>=20
> This should probably be achieved with a device realize hook in the
> PSI base class and device_class_set_parent_realize() in the children
> classes.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/pnv_psi.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 6c94781e377d..546232106756 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -469,6 +469,16 @@ static void pnv_psi_reset_handler(void *dev)
>      device_reset(DEVICE(dev));
>  }
> =20
> +static void pnv_psi_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvPsi *psi =3D PNV_PSI(dev);
> +
> +    /* Default BAR for MMIO region */
> +    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> +
> +    qemu_register_reset(pnv_psi_reset_handler, dev);
> +}
> +
>  static void pnv_psi_power8_instance_init(Object *obj)
>  {
>      Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> @@ -528,9 +538,6 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
>      memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, psi,
>                            "psihb", PNV_PSIHB_SIZE);
> =20
> -    /* Default BAR for MMIO region */
> -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> -
>      /* Default sources in XIVR */
>      for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
>          uint8_t xivr =3D irq_to_xivr[i];
> @@ -538,7 +545,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
>              ((uint64_t) i << PSIHB_XIVR_SRC_SH);
>      }
> =20
> -    qemu_register_reset(pnv_psi_reset_handler, dev);
> +    pnv_psi_realize(dev, errp);
>  }
> =20
>  static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
> @@ -873,9 +880,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
>      memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mmio_o=
ps, psi,
>                            "psihb", PNV9_PSIHB_SIZE);
> =20
> -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> -
> -    qemu_register_reset(pnv_psi_reset_handler, dev);
> +    pnv_psi_realize(dev, errp);
>  }
> =20
>  static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VKEUACgkQbDjKyiDZ
s5Ih9w/+PGvMm+/Kbrd4n3X0RZrN8Sd4WQ5nHTt7zlyP+uU4DLzWq9X/jOujTY4v
Jj0a9fYV+mnY3AsQtvRngVS6YzEX5psPpMiQW2/tyS/le7b+Tn43iO9wmL7fMpbT
YTch9bugQyahXBGv4oSigfcJPDoniY6N122Kwp44rEAA2lQVepG0a5FIBSFtI+ha
QELRqB9BFD/W3sKe5PNjc3ObBd2aasXJ1QDWLdqPJtWsSzit/rvGKhF85vtNBe0z
GH4wVn5rjA6XwneoGdd8RdfW31BpyMNsDYR+j+12KpdmbKFe7ORNE7k7xpJ7btu2
f1IvYbou6qGggjmxOMksy04dT1JVzdpC5YwYujXIZahZc6V5frQIgtkR+O5+dGYv
mAnDhYi6GPIGLTzsP7tZiY2cWCbVIgV5+P3u/11yBwV5/EmjieZcpzsZDm71q4RG
dkRa0r6HZFRkro3u+uHCbCVPnPWL1v6NleGtd+BZjlr0c6WBLOSRYNuUfhVMMcOO
D8y9MyCIJ1OTl9pgiVuTXjUKYX/AnWDJ67IambaPuMwzvLnInkPBUoDMcXivBSSp
hHrKVqApsMzFRwiNpLRFd1/MJox+bFc29niG6bekMrcg7AvBS4S1uNCAmAao1WpB
NGsAU+zoC6mY5UCt1R+pj1jbw/XwOPYHqWbQkfJ2zPmLTg/G4go=
=TJEs
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

