Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41261C32771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DF82075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XmaEdgVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DF82075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iochw-00060t-LX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 19:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iocfT-0003g4-64
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iocfR-0001Zw-Iz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:24:18 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55791 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iocfQ-0001Ti-OQ; Mon, 06 Jan 2020 19:24:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sCmX4b6Gz9sPn; Tue,  7 Jan 2020 11:24:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578356652;
 bh=7FL2mKYT12vc/4ydTTLO8ZgjBSwwQQOlQFPMUogsLzQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XmaEdgVCQkEhhCYr0hGrF789SW8/PcJGd5NoWdr6lzcBm9g2Sd440LZzogdH4c4sb
 wSN9I0BAFq4Zrd+0mtlo7fZ/TQ5/bC2qzZxmr4cJWKAh/scAvfzwzdiHs/C0mpuFA2
 uH1d1MqMVz7HAyawDY6hutSQCqytWvCljShnjD18=
Date: Tue, 7 Jan 2020 11:23:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 11/12] pnv/psi: Add device reset hook
Message-ID: <20200107002344.GG2098@umbus>
References: <20200106145645.4539-1-clg@kaod.org>
 <20200106145645.4539-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="169fIVB/g4KxrKrw"
Content-Disposition: inline
In-Reply-To: <20200106145645.4539-12-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--169fIVB/g4KxrKrw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 03:56:44PM +0100, C=E9dric Le Goater wrote:
> From: Greg Kurz <groug@kaod.org>
>=20
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
> ---
>  hw/ppc/pnv_psi.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 4da3d2568624..cf21e42d93b7 100644
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
> @@ -464,6 +464,13 @@ static void pnv_psi_reset(void *dev)
>      psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
>  }
> =20
> +static void pnv_psi_reset_handler(void *dev)
> +{
> +    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
> +
> +    dc->reset(DEVICE(dev));

I think it would be better to use device_reset() here rather than
explicitly accessing the dc->reset pointer yourself.

> +}
> +
>  static void pnv_psi_power8_instance_init(Object *obj)
>  {
>      Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> @@ -526,7 +533,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
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
> @@ -809,7 +816,7 @@ static void pnv_psi_power9_irq_set(PnvPsi *psi, int i=
rq, bool state)
>      qemu_set_irq(psi->qirqs[irq], state);
>  }
> =20
> -static void pnv_psi_power9_reset(void *dev)
> +static void pnv_psi_power9_reset(DeviceState *dev)
>  {
>      Pnv9Psi *psi =3D PNV9_PSI(dev);
> =20
> @@ -863,7 +870,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
> =20
>      pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> =20
> -    qemu_register_reset(pnv_psi_power9_reset, dev);
> +    qemu_register_reset(pnv_psi_reset_handler, dev);
>  }
> =20
>  static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
> @@ -875,6 +882,7 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
> =20
>      dc->desc    =3D "PowerNV PSI Controller POWER9";
>      dc->realize =3D pnv_psi_power9_realize;
> +    dc->reset   =3D pnv_psi_power9_reset;
> =20
>      ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
>      ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
> @@ -927,6 +935,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
> =20
>      dc->desc =3D "PowerNV PSI Controller";
>      dc->props =3D pnv_psi_properties;
> +    dc->reset =3D pnv_psi_reset;
>  }
> =20
>  static const TypeInfo pnv_psi_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--169fIVB/g4KxrKrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4Tz5AACgkQbDjKyiDZ
s5LLHRAAtCoKVYa4OEMyuZwTa8BtZkpjtbxgLjC8HvRdpg8pAo5H/qgjGyd+HeNZ
d0ZUJ5hms8a6uPT3gZHak1HlqRTH+YEM8vw+QD9jvhz5b0L8q2e/udOJq+HGtZ6Y
hTuvR2GzpUspRbepe11hQ9eUt1UX7V4y2Bpj0GEt7W0mLW2B9pp+Smab9BHNSHhE
RjppqpwDKMwpWRDvQyEIdQc7CHhdhmHzaDuYnkLAnarSlG49wnXvRHBh3cFB8S5W
DxwJZR8Zh1yisPgdRyOnTzzVRNqCgHn+hkBnyKP6+OMhBxp4957M0Q264bAkjEWM
oekifUhE/TCdecfHxGUueznDo3sCDKiq7HPoOBrxMZkaV/dHbSIRxmoIw+Fdg2p+
3vsSLoRQyEz9OAkWUGaV1AjvVkxNufMn8bj38swOfezzKZ3EAaClMbUrpe6kF+ik
qKNCL6X1BAzn1RKXShca9F0eBHpPhY+szK9CvdTs4CDdGaTYjs2RXHfGPsyRf3Eo
nF3tWFmO7eUVtx2l0Kg+fWvjBJtl22pjBEKAM5qI21+kzgw6Ed9VR/CLweDFIP6K
64ad4mXQvmda8C2MRdOEuwVUTvjpyB/bVqi+CuJK8YFZxIHjUSuRunBSpf6TxHVE
wh6QH8lr0xMTVF1XDI1pk73VaNtPJQcyCmjOOW8FIlNK/8g/Bgo=
=q0cY
-----END PGP SIGNATURE-----

--169fIVB/g4KxrKrw--

