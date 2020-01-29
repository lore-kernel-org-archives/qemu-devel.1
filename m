Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062EDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8CA206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HOpBM+Gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8CA206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwvos-00033b-Qs
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 17:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iwvns-0001xu-PW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iwvnq-0002sG-Vr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:27:20 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:40039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iwvnp-0002mp-Ez; Wed, 29 Jan 2020 17:27:18 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 487J4w0QnNz9s29; Thu, 30 Jan 2020 09:27:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580336832;
 bh=H8hNJ4pueXgJHRiUILE3VK+/K3OHA3kvsqRRHSQM2BE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HOpBM+GiyT2l5FDbjXAG5bYk3XCfS7Hofkp5n1EqR+MA2HOy4LajOz5HRg08isOl6
 dKgtc0MZKSY4dXKP+4sGrioHcjyUbLKsQBH4eOI9nGczTGNGWrlelHI6g9Rl1JmI4c
 N1s3dqAgVjFKe9CxQe36XiLO5q92eDxmpUxtc8hw=
Date: Thu, 30 Jan 2020 09:17:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: change the PowerNV machine devices to be non
 user creatable
Message-ID: <20200129221723.GB2640@umbus.fritz.box>
References: <20200129113720.7404-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20200129113720.7404-1-clg@kaod.org>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 12:37:20PM +0100, C=E9dric Le Goater wrote:
> The PowerNV machine emulates an OpenPOWER system and the PowerNV chip
> devices are models of the internal logic of the POWER processor. They
> can not be instantiated by the user on the QEMU command line.
>=20
> The PHB3/PHB4 devices could be an exception in the future after some
> rework on how the device tree is built. For the moment, exclude them
> also.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/pci-host/pnv_phb3.c      | 2 ++
>  hw/pci-host/pnv_phb3_pbcq.c | 1 +
>  hw/pci-host/pnv_phb4.c      | 3 ++-
>  hw/pci-host/pnv_phb4_pec.c  | 2 ++
>  hw/ppc/pnv_core.c           | 2 ++
>  hw/ppc/pnv_homer.c          | 1 +
>  hw/ppc/pnv_lpc.c            | 1 +
>  hw/ppc/pnv_occ.c            | 1 +
>  8 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> index f03399c40615..74618fadf085 100644
> --- a/hw/pci-host/pnv_phb3.c
> +++ b/hw/pci-host/pnv_phb3.c
> @@ -1115,6 +1115,7 @@ static void pnv_phb3_class_init(ObjectClass *klass,=
 void *data)
>      dc->realize =3D pnv_phb3_realize;
>      device_class_set_props(dc, pnv_phb3_properties);
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo pnv_phb3_type_info =3D {
> @@ -1168,6 +1169,7 @@ static void pnv_phb3_root_port_class_init(ObjectCla=
ss *klass, void *data)
> =20
>      device_class_set_parent_realize(dc, pnv_phb3_root_port_realize,
>                                      &rpc->parent_realize);
> +    dc->user_creatable =3D false;
> =20
>      k->vendor_id =3D PCI_VENDOR_ID_IBM;
>      k->device_id =3D 0x03dc;
> diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
> index 6f0c05be682a..f232228b0e28 100644
> --- a/hw/pci-host/pnv_phb3_pbcq.c
> +++ b/hw/pci-host/pnv_phb3_pbcq.c
> @@ -335,6 +335,7 @@ static void pnv_pbcq_class_init(ObjectClass *klass, v=
oid *data)
>      xdc->dt_xscom =3D pnv_pbcq_dt_xscom;
> =20
>      dc->realize =3D pnv_pbcq_realize;
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo pnv_pbcq_type_info =3D {
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 61235d13a696..23cf093928ed 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1290,7 +1290,7 @@ static void pnv_phb4_class_init(ObjectClass *klass,=
 void *data)
>      dc->realize         =3D pnv_phb4_realize;
>      device_class_set_props(dc, pnv_phb4_properties);
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    dc->user_creatable  =3D true;
> +    dc->user_creatable  =3D false;
>      dc->reset           =3D pnv_phb4_reset;
> =20
>      xfc->notify         =3D pnv_phb4_xive_notify;
> @@ -1368,6 +1368,7 @@ static void pnv_phb4_root_port_class_init(ObjectCla=
ss *klass, void *data)
>      PCIERootPortClass *rpc =3D PCIE_ROOT_PORT_CLASS(klass);
> =20
>      dc->desc     =3D "IBM PHB4 PCIE Root Port";
> +    dc->user_creatable =3D false;
> =20
>      device_class_set_parent_realize(dc, pnv_phb4_root_port_realize,
>                                      &rpc->parent_realize);
> diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
> index fd92041d69dc..68e1db3eac4f 100644
> --- a/hw/pci-host/pnv_phb4_pec.c
> +++ b/hw/pci-host/pnv_phb4_pec.c
> @@ -490,6 +490,7 @@ static void pnv_pec_class_init(ObjectClass *klass, vo=
id *data)
> =20
>      dc->realize =3D pnv_pec_realize;
>      device_class_set_props(dc, pnv_pec_properties);
> +    dc->user_creatable =3D false;
> =20
>      pecc->xscom_nest_base =3D pnv_pec_xscom_nest_base;
>      pecc->xscom_pci_base  =3D pnv_pec_xscom_pci_base;
> @@ -568,6 +569,7 @@ static void pnv_pec_stk_class_init(ObjectClass *klass=
, void *data)
> =20
>      device_class_set_props(dc, pnv_pec_stk_properties);
>      dc->realize =3D pnv_pec_stk_realize;
> +    dc->user_creatable =3D false;
> =20
>      /* TODO: reset regs ? */
>  }
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index f7247222bceb..234562040de3 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -325,6 +325,7 @@ static void pnv_core_class_init(ObjectClass *oc, void=
 *data)
>      dc->realize =3D pnv_core_realize;
>      dc->unrealize =3D pnv_core_unrealize;
>      device_class_set_props(dc, pnv_core_properties);
> +    dc->user_creatable =3D false;
>  }
> =20
>  #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
> @@ -423,6 +424,7 @@ static void pnv_quad_class_init(ObjectClass *oc, void=
 *data)
> =20
>      dc->realize =3D pnv_quad_realize;
>      device_class_set_props(dc, pnv_quad_properties);
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo pnv_quad_info =3D {
> diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
> index 93ae42f7e4d1..9a262629b73a 100644
> --- a/hw/ppc/pnv_homer.c
> +++ b/hw/ppc/pnv_homer.c
> @@ -360,6 +360,7 @@ static void pnv_homer_class_init(ObjectClass *klass, =
void *data)
>      dc->realize =3D pnv_homer_realize;
>      dc->desc =3D "PowerNV HOMER Memory";
>      device_class_set_props(dc, pnv_homer_properties);
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo pnv_homer_type_info =3D {
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index d1de98f04c08..5989d723c50c 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -762,6 +762,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, vo=
id *data)
>      dc->realize =3D pnv_lpc_realize;
>      dc->desc =3D "PowerNV LPC Controller";
>      device_class_set_props(dc, pnv_lpc_properties);
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo pnv_lpc_info =3D {
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index 2173fac0e798..5a716c256edc 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -280,6 +280,7 @@ static void pnv_occ_class_init(ObjectClass *klass, vo=
id *data)
>      dc->realize =3D pnv_occ_realize;
>      dc->desc =3D "PowerNV OCC Controller";
>      device_class_set_props(dc, pnv_occ_properties);
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo pnv_occ_type_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4yBHIACgkQbDjKyiDZ
s5KvgA//cI4Xdhhd0jVs/pwTeG5BgOAoecLmswAzRvHacheNIxLboIrB/W4ygzqb
5Sj8Vs2XT+e+4exyiF7ukdwty7Fak/nB2GsDA6xBBBb7bulhn27/zDIZ82+qTq5g
pCTwhE3QLZEPNVH/kGe8VMXcuqjsXEBQxmunuGdDrmK8zNn7ev6CbkHMaaA2Ep1j
SyfCQKdg3gS8RRZbvU6b3JelXk2A0eIUkSayLRXE1EiOwDqhL5hBVWnF0ZGVSDwi
KOLG2WzT3NJ5IKzr1902QoVdil0FRTS6GX6cg0Qo6/TR3ZPL2jV3uz1JdwK8MBhh
1CQQ+/3PVUJ1ZP71m1p14IKsXPQyfihB90rZWPx6yuv4kBoQJ6k7rKQK1igu1OLy
nlnBDBmg56tNLr8pSrhBxMeVBNSbr4zmpdYd6MCy9dRbzn2TTjmPngIcIWK4xDiJ
e2DayPrMZEpmYinyTccmVXHCmAJ+I12zD8xNwJR+9ATw2ejFAnrGTvEPNHlMJVoe
QXrb2PQ/aDZTEvXvdoH9fihA7b6v8mOX12L3SR5G1ZXqSZS3b9NEbQ7Xu5emJ0lT
cb/WiBgD+26LospgOqcJUomj4AvK9j9NFAVM1rwU63zA+5SlUKB1QZ1qpD9BS3nN
z4gjPfAFHE02VgeREvOfdJOoIMcWCfKnDsbYio1w8eD+zxV2bLo=
=1rqb
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

