Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FDBC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B29214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pnihszFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B29214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvwt5-0002sy-Oz
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 00:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwqP-00079J-4U
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvwqN-0008R9-NK
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:33177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hvwqM-0008PH-HV
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:49:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464XpL6R04z9sNF; Fri,  9 Aug 2019 14:49:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565326170;
 bh=Dtz5KawBEAgx1Pz9ZToQAf2TCj278tu4WlSEOOUUG2U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pnihszFnuR+DqpZoS29uYqbOpboeGF4HFIXw9LF4UMnY6tkqSFng5Ir/1poQ1M0xa
 YU9/NhEH7oaKAKvjjv8L5TN2z9sN2G2zD5fDx38fb+4Llw0NgRQlsDmQnLaUCVQb0E
 oVM17NC7loHYCOEYLSE8E+MePWkXFHodgVxo3Hdc=
Date: Fri, 9 Aug 2019 14:45:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190809044523.GL5465@umbus.fritz.box>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-5-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Content-Disposition: inline
In-Reply-To: <20190807071445.4109-5-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] hw/ppc/pnv: initialize and realize
 homer/occ common area
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 hari@linux.vnet.ibm.com, clg@kaod.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 12:44:43PM +0530, Balamuruhan S wrote:
> homer and occ common area region base address are initialized
> to create device tree and realized to map the address with
> mmio callbacks during `pnv_chip_realize()`.
>=20
> `SysBusNum` enum is introduced to set sysbus for XSCOM, ICP,
> HOMER and OCC appropriately and chip_num to initialize and
> retrieve base address + size contiguously on a PowerNV with
> multichip boot.

Same comments here as on the previous patch - I don't think this
belongs in the series with the scripting extensions.

>=20
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv.c         | 49 +++++++++++++++++++++++++++++++++++++++++++++-=
---
>  include/hw/ppc/pnv.h |  1 +
>  2 files changed, 46 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index bd4531c822..f6e56e915d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -675,6 +675,7 @@ static void pnv_init(MachineState *machine)
>          Object *chip =3D object_new(chip_typename);
> =20
>          pnv->chips[i] =3D PNV_CHIP(chip);
> +        PNV_CHIP(chip)->chip_num =3D i;
> =20
>          /* TODO: put all the memory in one node on chip 0 until we find a
>           * way to specify different ranges for each chip
> @@ -824,18 +825,20 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, E=
rror **errp)
>   {
>      PnvChip *chip =3D PNV_CHIP(chip8);
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(chip);
>      const char *typename =3D pnv_chip_core_typename(chip);
>      size_t typesize =3D object_type_get_instance_size(typename);
>      int i, j;
>      char *name;
>      XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
> =20
> +    sbd->num_mmio =3D PNV_ICP_SYSBUS;
>      name =3D g_strdup_printf("icp-%x", chip->chip_id);
>      memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZ=
E);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
> +    sysbus_init_mmio(sbd, &chip8->icp_mmio);
>      g_free(name);
> =20
> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
> +    sysbus_mmio_map(sbd, PNV_ICP_SYSBUS, PNV_ICP_BASE(chip));
> =20
>      /* Map the ICP registers for each thread */
>      for (i =3D 0; i < chip->nr_cores; i++) {
> @@ -866,7 +869,26 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_XSCOM_SYSBUS,
> +                                   PNV_XSCOM_BASE(chip));
> +
> +    /* homer */
> +    pnv_homer_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_HOMER_SYSBUS,
> +                    PNV_HOMER_BASE(chip));
> +
> +    /* occ common area */
> +    pnv_occ_common_area_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_OCC_COMMON_AREA_SYSBUS,
> +                    PNV_OCC_COMMON_AREA(chip));
> =20
>      pcc->parent_realize(dev, &local_err);
>      if (local_err) {
> @@ -1035,7 +1057,26 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV9_XSCOM_BASE(chip));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_XSCOM_SYSBUS,
> +                    PNV9_XSCOM_BASE(chip));
> +
> +    /* homer */
> +    pnv_homer_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_HOMER_SYSBUS,
> +                    PNV9_HOMER_BASE(chip));
> +
> +    /* occ common area */
> +    pnv_occ_common_area_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_OCC_COMMON_AREA_SYSBUS,
> +                    PNV9_OCC_COMMON_AREA(chip));
> =20
>      pcc->parent_realize(dev, &local_err);
>      if (local_err) {
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 6464e32892..dea6772988 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -57,6 +57,7 @@ typedef struct PnvChip {
> =20
>      /*< public >*/
>      uint32_t     chip_id;
> +    uint32_t     chip_num;
>      uint64_t     ram_start;
>      uint64_t     ram_size;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1M+mMACgkQbDjKyiDZ
s5KNjhAAv1CpsYwCRhTh3WxvslQYTDhlKx/1PgOOXJsNYkfsv+Ek+zKewKo4pql9
VTIsqYiFoXjhYreJV8TzaYSEDWT9oL4hdIyJg/sj0HSAvYU5PZfjokuuH3vee1Hc
f4wExN+kCyx8ONnQLzkur7Iu1CQxvWogXe/Kc4qCT6JO2waZxaLwhcrrPjVS7UNc
mp9QKQmNRelz66wbNrz+LWzT/4Uk3Qd0xescaPtRPAgpgSZE52KdTCXnJWMFuxuv
mrjjTz63o4rkurazRqq0mjizQEY1YOzYTRmd9TbZ7sIgkoC+VCRStlmRSoFKBAV4
nffWLGUwtygV3Kwtc49qgWhyZvkX3cHiYhQP42/k/loSpbiWKNpnFLaV4OcDZ82T
6haIG6ig22CwAQh3jwAQBdw6HmCxJ5P5PZO2APZAUXNXhHCX54+JMjvy+RyCFOsk
Y59v5zSfsjv2GYKEvMA6XbLPrNyy9u/luXuRRDKp9Ln1ybbHNbbWwl9Qi2FoyGiY
yDJk1jZ1hbrmwJ+rCMXwW4N4FN2Y7pyuz51LG3oChYZvuhJYNc6Q3DgF9nB/2sKS
hV3dVCP1ljOaYIA0iidJAvecFSHQIuT3SwRu3gfpYTpH/9guwMHPzoto8UkV5MH6
buoVCjxxsFgfTPHrr8P8CkxPvPN4f+Ke4f7YQm/qLTUyP+YXpb0=
=TJ3j
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--

