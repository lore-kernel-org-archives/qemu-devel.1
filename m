Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A5EC2D0D2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4979206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dsR6ZPuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4979206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijFND-0003JN-4B
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 23:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijFLX-0001pW-6L
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijFLV-0007NC-RM
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:29:31 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:45483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijFLV-000765-Ei; Sun, 22 Dec 2019 23:29:29 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h5wN24csz9sPV; Mon, 23 Dec 2019 15:29:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577075364;
 bh=fmb0DE2CBeWWI1ALJRBmpy/QeOgzr+ncJKIpBZlGuRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dsR6ZPuOurbPd6H/QvEPYQT9XuJwDgL4mIxh2DxDBtuig869latVK+GXM7/NJpaq0
 DGA7YrtHSOeAGIHJMil9obVKEN0pnq4+wQQdhX0vAuApRZERypdq6EKdUtFIrysbTS
 DVdSPoPxMc6+azfSGAtvZAKwXB+Gpbc9JffD4DG8=
Date: Mon, 23 Dec 2019 15:29:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 06/13] pnv/xive: Use device_class_set_parent_realize()
Message-ID: <20191223042911.GE21569@umbus.fritz.box>
References: <20191219181155.32530-1-clg@kaod.org>
 <20191219181155.32530-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-7-clg@kaod.org>
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


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:48PM +0100, C=E9dric Le Goater wrote:
> From: Greg Kurz <groug@kaod.org>
>=20
> The XIVE router base class currently inherits an empty realize hook
> from the sysbus device base class, but it will soon implement one
> of its own to perform some sanity checks. Do the preliminary plumbing
> to have it called.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

But will need a rebase due to changes earlier in the series.

> ---
>  include/hw/ppc/pnv_xive.h | 10 ++++++++++
>  hw/intc/pnv_xive.c        | 10 ++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
> index 4d641db691c8..ba9bbeab88c3 100644
> --- a/include/hw/ppc/pnv_xive.h
> +++ b/include/hw/ppc/pnv_xive.h
> @@ -16,6 +16,10 @@ struct PnvChip;
> =20
>  #define TYPE_PNV_XIVE "pnv-xive"
>  #define PNV_XIVE(obj) OBJECT_CHECK(PnvXive, (obj), TYPE_PNV_XIVE)
> +#define PNV_XIVE_CLASS(klass)                                   \
> +    OBJECT_CLASS_CHECK(PnvXiveClass, (klass), TYPE_PNV_XIVE)
> +#define PNV_XIVE_GET_CLASS(obj)                                 \
> +    OBJECT_GET_CLASS(PnvXiveClass, (obj), TYPE_PNV_XIVE)
> =20
>  #define XIVE_BLOCK_MAX      16
> =20
> @@ -87,6 +91,12 @@ typedef struct PnvXive {
>      uint64_t      edt[XIVE_TABLE_EDT_MAX];
>  } PnvXive;
> =20
> +typedef struct PnvXiveClass {
> +    XiveRouterClass parent_class;
> +
> +    DeviceRealize parent_realize;
> +} PnvXiveClass;
> +
>  void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
> =20
>  #endif /* PPC_PNV_XIVE_H */
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 66970a60733b..1962f884d6de 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -1816,10 +1816,17 @@ static void pnv_xive_init(Object *obj)
>  static void pnv_xive_realize(DeviceState *dev, Error **errp)
>  {
>      PnvXive *xive =3D PNV_XIVE(dev);
> +    PnvXiveClass *pxc =3D PNV_XIVE_GET_CLASS(dev);
>      XiveSource *xsrc =3D &xive->ipi_source;
>      XiveENDSource *end_xsrc =3D &xive->end_source;
>      Error *local_err =3D NULL;
> =20
> +    pxc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      assert(xive->chip);
>      assert(xive->system_memory);
> =20
> @@ -1950,10 +1957,12 @@ static void pnv_xive_class_init(ObjectClass *klas=
s, void *data)
>      XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
>      XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
>      XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
> +    PnvXiveClass *pxc =3D PNV_XIVE_CLASS(klass);
> =20
>      xdc->dt_xscom =3D pnv_xive_dt_xscom;
> =20
>      dc->desc =3D "PowerNV XIVE Interrupt Controller";
> +    device_class_set_parent_realize(dc, pnv_xive_realize, &pxc->parent_r=
ealize);
>      dc->realize =3D pnv_xive_realize;
>      dc->props =3D pnv_xive_properties;
> =20
> @@ -1974,6 +1983,7 @@ static const TypeInfo pnv_xive_info =3D {
>      .instance_init =3D pnv_xive_init,
>      .instance_size =3D sizeof(PnvXive),
>      .class_init    =3D pnv_xive_class_init,
> +    .class_size    =3D sizeof(PnvXiveClass),
>      .interfaces    =3D (InterfaceInfo[]) {
>          { TYPE_PNV_XSCOM_INTERFACE },
>          { }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AQpYACgkQbDjKyiDZ
s5JDkQ//dH14bgohbgk9r6rnqMZJBHzZ1DKoo1cnVmCopmmFtRVP4pHT7Cb9UpUX
tQ3nuWQITvQt6yMN0hIvgEX2MnUc99qsByD+mVYYv7jDqy90/w1pb/HYEYa8Y0It
71Jmfi7n0jh94YVt9oRKZ6CnL7S7D3Xb5RQD8dXsXfu5BsO4q3zsF9wGLgShP09S
N8DCOhcxbKxfaYi0cGxNHHoNqypfhUK+eiOCuqGQQe5OVdz4JDD2Ic1+wtdd5FZ9
Wr4txRPhjWzXzMZs2K2I8N/hx5s+tHHbE6hOkxWqwmp9mh8FTrLn8WrdHZ6GA7nr
GRCpZAE7yHh/7Q+SETDXwAXuuBGXpFRPnSDuVwDffFrFki7M2jZvm5OtM+jg9hxZ
JdFzpEit/k/kmjyXzwpEuUUfI+7MuAXXKFPunrug0SJPGJZme36BLvNaheh2xNJR
wX6SgZRjYV1DEocFiAsgBsk40+P6POcDvX93uwPOzI/1+Mr4kScyiJGOeOUbOw9B
4rGMdTsXBDZYGfXLrJ4sq3sS5dQtPbEBtPLohi0ags7hNb0jO8CAvqqpq80V7mOJ
oemSgHzYqxoZ4Ih4rPew/ia/HG3l6xVBasORgFea7C/IGaLYZFunpGsnlv5NMOo/
S+6aQ4OsfkQS9xyGavNH/KytPT0FddtF2vU4HrhCHdEmA7yCFJQ=
=dL72
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--

