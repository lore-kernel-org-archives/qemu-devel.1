Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9684C2D0D4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76E3206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Uyfqu+jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76E3206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijFNF-0003Jr-45
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 23:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijFLX-0001pX-9K
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijFLV-0007NI-Rm
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:29:31 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37513 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijFLV-00075N-F1; Sun, 22 Dec 2019 23:29:29 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h5wN176rz9sPW; Mon, 23 Dec 2019 15:29:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577075364;
 bh=g2KDzkROhaybfsWmvXyxrw6BnR7UGVWiyEOfZYrWIoE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Uyfqu+jTW1dOprlrjzfJBsVgOj7QgVn352/8ufS/UB3/1jg0zpsRfHuiGk+TK1p+x
 H/13B9hhtXn0x/LP5VkAycfGyFj0DJpiiaFpYf9LqokTSCMa1c19ubybZ7JJxP2jKx
 famNZoT6XXFJZwFJYMxj3fHQxvS44OqESHvp4nrw=
Date: Mon, 23 Dec 2019 15:27:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 05/13] spapr/xive: Use device_class_set_parent_realize()
Message-ID: <20191223042750.GD21569@umbus.fritz.box>
References: <20191219181155.32530-1-clg@kaod.org>
 <20191219181155.32530-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-6-clg@kaod.org>
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


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:47PM +0100, C=E9dric Le Goater wrote:
> From: Greg Kurz <groug@kaod.org>
>=20
> The XIVE router base class currently inherits an empty realize hook
> from the sysbus device base class, but it will soon implement one
> of its own to perform some sanity checks. Do the preliminary plumbing
> to have it called.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  include/hw/ppc/spapr_xive.h | 10 ++++++++++
>  hw/intc/spapr_xive.c        | 12 +++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 3a103c224d44..93d09d68deb7 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -15,6 +15,10 @@
> =20
>  #define TYPE_SPAPR_XIVE "spapr-xive"
>  #define SPAPR_XIVE(obj) OBJECT_CHECK(SpaprXive, (obj), TYPE_SPAPR_XIVE)
> +#define SPAPR_XIVE_CLASS(klass)                                         \
> +    OBJECT_CLASS_CHECK(SpaprXiveClass, (klass), TYPE_SPAPR_XIVE)
> +#define SPAPR_XIVE_GET_CLASS(obj)                               \
> +    OBJECT_GET_CLASS(SpaprXiveClass, (obj), TYPE_SPAPR_XIVE)
> =20
>  typedef struct SpaprXive {
>      XiveRouter    parent;
> @@ -47,6 +51,12 @@ typedef struct SpaprXive {
>      VMChangeStateEntry *change;
>  } SpaprXive;
> =20
> +typedef struct SpaprXiveClass {
> +    XiveRouterClass parent;
> +
> +    DeviceRealize parent_realize;
> +} SpaprXiveClass;
> +
>  /*
>   * The sPAPR machine has a unique XIVE IC device. Assign a fixed value
>   * to the controller block id value. It can nevertheless be changed
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 57305c56d707..32322470a8b8 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -286,10 +286,17 @@ static void spapr_xive_instance_init(Object *obj)
>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(dev);
> +    SpaprXiveClass *sxc =3D SPAPR_XIVE_GET_CLASS(xive);
>      XiveSource *xsrc =3D &xive->source;
>      XiveENDSource *end_xsrc =3D &xive->end_source;
>      Error *local_err =3D NULL;
> =20
> +    sxc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      if (!xive->nr_irqs) {
>          error_setg(errp, "Number of interrupt needs to be greater 0");
>          return;
> @@ -760,10 +767,12 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
>      XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
>      SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_CLASS(klass);
>      XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
> +    SpaprXiveClass *sxc =3D SPAPR_XIVE_CLASS(klass);
> =20
>      dc->desc    =3D "sPAPR XIVE Interrupt Controller";
>      dc->props   =3D spapr_xive_properties;
> -    dc->realize =3D spapr_xive_realize;
> +    device_class_set_parent_realize(dc, spapr_xive_realize,
> +                                    &sxc->parent_realize);
>      dc->vmsd    =3D &vmstate_spapr_xive;
> =20
>      xrc->get_eas =3D spapr_xive_get_eas;
> @@ -794,6 +803,7 @@ static const TypeInfo spapr_xive_info =3D {
>      .instance_init =3D spapr_xive_instance_init,
>      .instance_size =3D sizeof(SpaprXive),
>      .class_init =3D spapr_xive_class_init,
> +    .class_size =3D sizeof(SpaprXiveClass),
>      .interfaces =3D (InterfaceInfo[]) {
>          { TYPE_SPAPR_INTC },
>          { }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AQkYACgkQbDjKyiDZ
s5J9UhAAt9KBo9evUrcmxmkzYThacn6ULapTdurFXs6+QJVVSRHoYq8pHuuH/wZa
/I+hg8HW2NQBawfl3iBn4cqdY8vne5nm5FpfsF8hUdK9JuvCk9pyhwZup0Bi/yim
64bmXaQSO9wHskUKGILrUcs6wVTp7785KbU9xw1lnAcdb3XRYMjOwKAAMCMpsZ/1
B7DKrKLAKIGzJCJY/+uQna+LhU6JD/Qt+zmc0+HxnkJh0FQv2WG3mgbUQwWZZuTU
//Zt1Yn5FvhwntoDUjMxwabd2VJ4lWcecupI6BSfj5eYpz7ofeYJz4FckrH7xEiT
JzU0oc6pw3csIutoSLw5eNiY7airJuadOFL0IZfcqu6HWCtq3P2qlt5BIwlc5Qxd
1qeCDLz4kP+o+14Skfk2+/Hd+tkz97Zs9a0q2ibXg5+QMJvv4hK+gVhCHlH48nYQ
OVnG3yWlI7ullkTSLQHrABkwWBmtg92GnXRBaRcpOh3hEgB8jBVriFBdxyMwP0Nj
jtlpr1sPdnzgo20P8upmm1LuSTJGqnRZLSPaAdMrRae4y3PC9MTvBrj2I4VD25tt
tTeQDW4WbvP4RTcEUf//Ux8bzWnqdTARNczUAmUTbkJ92xt8BjpvtaTAnjPI87Uv
WTGJ4HTNSld4tNE/0fVDPciH20qTM+o4FdFm968OB/VajBJBFQw=
=4kXe
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--

