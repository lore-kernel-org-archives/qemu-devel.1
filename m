Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9365C33CAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EDE22522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hTrBlOj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EDE22522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itkmp-00025O-FY
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 23:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itklT-0001D2-Cj
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itklS-0000Rh-5X
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:03:43 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60883 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itklR-0000Pn-2h; Mon, 20 Jan 2020 23:03:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481vzC71FKz9sNF; Tue, 21 Jan 2020 15:03:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579579415;
 bh=VGep+m0ErIxbWK9Ama3B5peUK0T0H8LpkBYfFv1Y5e4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hTrBlOj2dLR03o+cyTp8NgLgHhSnMQ7o47Z6QIQ7C2m1v0aFa7MSD5nwlRtzSHZaK
 FEl7RQ1GNc6o/khx4+xKv+6YVE4LM7YrWKEVtJjqek5gt+6dXRBn2jF12HxkzCCk+c
 HG6G1o/WQYQHkp9mk3r8bfum+TgpfWwa7kAehFBk=
Date: Tue, 21 Jan 2020 15:02:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v8 2/6] spapr: Implement get_dt_compatible() callback
Message-ID: <20200121040228.GE265522@umbus.fritz.box>
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
 <20200108161012.1821385-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20200108161012.1821385-3-stefanb@linux.ibm.com>
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 11:10:08AM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> For devices that cannot be statically initialized, implement a
> get_dt_compatible() callback that allows us to ask the device for
> the 'compatible' value.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_vio.c         | 11 +++++++++--
>  include/hw/ppc/spapr_vio.h |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 554de9930d..4b24b81797 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -87,6 +87,7 @@ static int vio_make_devnode(SpaprVioDevice *dev,
>      SpaprVioDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
>      int vdevice_off, node_off, ret;
>      char *dt_name;
> +    const char *dt_compatible;
> =20
>      vdevice_off =3D fdt_path_offset(fdt, "/vdevice");
>      if (vdevice_off < 0) {
> @@ -113,9 +114,15 @@ static int vio_make_devnode(SpaprVioDevice *dev,
>          }
>      }
> =20
> -    if (pc->dt_compatible) {
> +    if (pc->get_dt_compatible) {
> +        dt_compatible =3D pc->get_dt_compatible(dev);
> +    } else {
> +        dt_compatible =3D pc->dt_compatible;
> +    }
> +
> +    if (dt_compatible) {
>          ret =3D fdt_setprop_string(fdt, node_off, "compatible",
> -                                 pc->dt_compatible);
> +                                 dt_compatible);
>          if (ret < 0) {
>              return ret;
>          }
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index 72762ed16b..67f58b7f98 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -58,6 +58,7 @@ typedef struct SpaprVioDeviceClass {
>      void (*realize)(SpaprVioDevice *dev, Error **errp);
>      void (*reset)(SpaprVioDevice *dev);
>      int (*devnode)(SpaprVioDevice *dev, void *fdt, int node_off);
> +    const char *(*get_dt_compatible)(SpaprVioDevice *dev);
>  } SpaprVioDeviceClass;
> =20
>  struct SpaprVioDevice {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4md9QACgkQbDjKyiDZ
s5Ly1g//fqlBNfTo9OjpgbxO04Amxbjw10ti/JyUpThmIOBUdTvNejveD/D87rXE
vS3WRaQQZLreKMXfKUDYQa++Mh2qWkXZlsU+7vxDIXQ8x0whG6+Oz51ExPPAFhWu
wrBPW586S12ZffUo+kEbDBb7KNHoFxnQMgg+lE9wPX8LHQNe5xDQeaZaQbGmb+fa
nz6wW5e9ycDMK9sXb9mDp0yMNenQ92ERMRLES2/S1oSov0uU2lDqSNfg1I04QzwS
WoQufu/A7HDVgTlfRXcavJ8yrrf/sArgP0d0v/AqL3PduEQRcqtBbcP1UlgvhEan
mef+M4nsJEZgUss6V1xDItW9NljUmED/mGNjCXqoLk9+MEvX/UrOPciOCrTMdVrM
o+X7b9RB3ep+OjSvz1VNB46mFFsMBy5Cs6gglC5q5if9Ai/MF4PXltrMREUglGaa
Am1MeiwcQJho4MDbeA22LbK8GQ7ZOaqsbWd+ceVygnaaxVi7veKnJvCDoX6qdSQZ
ivBFC+H6dCH8XS76pRrKoxX9DFEmK9kvoa6Kl7R/0oZ8fL2heUti2IoJsciY5wgg
8HjJxhqhJxROHQUjzLvWoM8e2YsOXpAxhT8AH7LhxNr91wIEd7qQEh8qpzFDLCjE
x9Ems4uriIobaj+g8ncOO5H+WuDt7pN2Hrp/gY85jPT46kZOwSU=
=JK0g
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--

