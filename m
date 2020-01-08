Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25326C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AF9207E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WsUGCy7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AF9207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iozlN-0002Ea-GM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 20:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjU-0000WM-S0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iozjT-000159-18
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:02:00 -0500
Received: from ozlabs.org ([203.11.71.1]:43989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iozjS-00012M-Kt; Tue, 07 Jan 2020 20:01:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47srYZ0VVfz9sRs; Wed,  8 Jan 2020 12:01:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578445314;
 bh=EeskhNRzt/tB41m7B8v4lE9XNS8rdLCTw+UebaC3iD0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WsUGCy7NSp04/X3C2w6KAYZg16B7HL0zVqfa8BVoFNdO4+i0sJg7IKrs/hDTb/CBH
 etCPIgXCyQcf3uWuEJG5wCYXWhK9suVaawzbGJIehelAgSB0CyygFv9esLWNVhzVCC
 hrCsJVBfyuBQX3b91I0hjhpaGmZJa1YPRyqwbkj4=
Date: Wed, 8 Jan 2020 11:07:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/2] pnv/psi: Add device reset hook
Message-ID: <20200108000746.GB2137@umbus.fritz.box>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
 <157841476035.66386.17838417527621752518.stgit@bahia.tlslab.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <157841476035.66386.17838417527621752518.stgit@bahia.tlslab.ibm.com>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 05:32:40PM +0100, Greg Kurz wrote:
> And call it from a QEMU reset handler. This allows each PNV child class to
> override the reset hook if needed, eg. POWER8 doesn't but POWER9 does.
> The proper way to do that would be to use device_class_set_parent_reset(),
> but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_reset
> pointer adds a fair amount of code. Calling pnv_psi_reset() explicitely is
> fine for now.
>=20
> A subsequent patch will consolidate the call to qemu_register_reset() in
> a single place.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/pnv_psi.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 75e20d9da08b..6c94781e377d 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -455,7 +455,7 @@ static const MemoryRegionOps pnv_psi_xscom_ops =3D {
>      }
>  };
> =20
> -static void pnv_psi_reset(void *dev)
> +static void pnv_psi_reset(DeviceState *dev)
>  {
>      PnvPsi *psi =3D PNV_PSI(dev);
> =20
> @@ -464,6 +464,11 @@ static void pnv_psi_reset(void *dev)
>      psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
>  }
> =20
> +static void pnv_psi_reset_handler(void *dev)
> +{
> +    device_reset(DEVICE(dev));
> +}
> +
>  static void pnv_psi_power8_instance_init(Object *obj)
>  {
>      Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> @@ -533,7 +538,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
>              ((uint64_t) i << PSIHB_XIVR_SRC_SH);
>      }
> =20
> -    qemu_register_reset(pnv_psi_reset, dev);
> +    qemu_register_reset(pnv_psi_reset_handler, dev);
>  }
> =20
>  static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
> @@ -816,7 +821,7 @@ static void pnv_psi_power9_irq_set(PnvPsi *psi, int i=
rq, bool state)
>      qemu_set_irq(psi->qirqs[irq], state);
>  }
> =20
> -static void pnv_psi_power9_reset(void *dev)
> +static void pnv_psi_power9_reset(DeviceState *dev)
>  {
>      Pnv9Psi *psi =3D PNV9_PSI(dev);
> =20
> @@ -870,7 +875,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
> =20
>      pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> =20
> -    qemu_register_reset(pnv_psi_power9_reset, dev);
> +    qemu_register_reset(pnv_psi_reset_handler, dev);
>  }
> =20
>  static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
> @@ -882,6 +887,7 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
> =20
>      dc->desc    =3D "PowerNV PSI Controller POWER9";
>      dc->realize =3D pnv_psi_power9_realize;
> +    dc->reset   =3D pnv_psi_power9_reset;
> =20
>      ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
>      ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
> @@ -934,6 +940,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
> =20
>      dc->desc =3D "PowerNV PSI Controller";
>      dc->props =3D pnv_psi_properties;
> +    dc->reset =3D pnv_psi_reset;
>  }
> =20
>  static const TypeInfo pnv_psi_info =3D {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VHVAACgkQbDjKyiDZ
s5LLOA//Ux80AFr2bO6bgC6U7AnYJUCZ0Cv2FnQ4t43aG31I4kjdzBMXb/e2lGtT
fYv2EAPge7lr9huJyhs7ASklshp2NMTHgatsYk+M419TlwtPQhAi3mXRSLJt3lUW
8XNjhJ088tIhjq9m2IyCx16V6gBcyJD2dgqtzdTkSjgfLSHXd9eYIuvjrKyglUc4
K8vEYzBGeWd6irs4GCiSSRac7F4ICsYjyWLvKJiaMMLa8Bye90InWhwJtLjdhlqD
Wyep6pnuvI4p4gjzpzj6F6Rd5AzOsqGmnWBxAcxZ6U9sWLWWj/0Obwcm9524xoaH
Uggfme2Z0e98OFyrTs+o/BXj/wYwAug4AgkB0CR6OHEtomrKEblnAIp2YcNaTkk3
HaM9ODCch58jbVmDZ9jaXnL7KDeO5dAjNa4UD3hGgA0TRIrWLIxQAam4niQIPzeI
bc4F8A84MkIKKom6xlroJrl4zQz5kip4SOglAGodqHeZy1ASIK3JJ2ONx50RChRR
oJUIhYHJstfR2meo6mpL333mPo0G7v3eKc55blsVnDs2a8xeoFhzDSdXmYg00omq
+5JTVA3GxyAlvh9bEj2z8azH53XKxUgwf0CENoGGdkn16pSMcCJx8Eug9Q8Tf08I
UeW1c2dW4XMgxlLhVZTlTBaa2itxKcn/5OusuKjyQKry8AjWHII=
=iU0H
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

