Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282BC2D0D2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB810207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 04:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gA4LEWij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB810207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijFAX-0000RV-5s
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 23:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijF9f-0008Lt-HQ
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijF9d-0000fv-LL
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 23:17:15 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45251 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijF9c-0000LU-98; Sun, 22 Dec 2019 23:17:13 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h5fC4kfXz9sPW; Mon, 23 Dec 2019 15:17:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577074627;
 bh=8NrbLnXG5aGQCy4ZVxIuvlFWByGthFCMAx49+PCYp0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gA4LEWijl0HLUFs2vq7pKRzQRGh/1r1xopD4FSGvEqveegwviG2WOcxJodi6URP/4
 KnqCZeH9xbFKqo1tI9Q27XWqS8JvA7JrfPE4timGgzjdESToDO5/dfO96nBqa74+1f
 QQ/Ijw4voDWcTT8B+kallS0AofmLqtUQo6rB2dQo=
Date: Mon, 23 Dec 2019 15:17:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 04/13] ppc/pnv: Introduce a "xics" property under the
 POWER8 chip
Message-ID: <20191223041700.GB21569@umbus.fritz.box>
References: <20191219181155.32530-1-clg@kaod.org>
 <20191219181155.32530-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-5-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:46PM +0100, C=E9dric Le Goater wrote:
> POWER8 is the only chip using the XICS interface. Add a "xics" link
> and a XICSFabric attribute under this chip to remove the use of
> qdev_get_machine()
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

but will need a rebase.

> ---
>  include/hw/ppc/pnv.h |  2 ++
>  hw/ppc/pnv.c         | 26 ++++++++++++++++++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index f31180618672..8b957dfb5736 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -74,6 +74,8 @@ typedef struct Pnv8Chip {
>      Pnv8Psi      psi;
>      PnvOCC       occ;
>      PnvHomer     homer;
> +
> +    XICSFabric    *xics;
>  } Pnv8Chip;
> =20
>  #define TYPE_PNV9_CHIP "pnv9-chip"
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 163a658806e2..2a1b15a69aed 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -797,6 +797,13 @@ static void pnv_init(MachineState *machine)
>           */
>          object_property_set_link(chip, OBJECT(sysmem), "system-memory",
>                                   &error_abort);
> +        /*
> +         * The POWER8 machine use the XICS interrupt interface.
> +         * Propagate the XICS fabric to the chip and its controllers.
> +         */
> +        if (object_dynamic_cast(OBJECT(pnv), TYPE_XICS_FABRIC)) {
> +            object_property_set_link(chip, OBJECT(pnv), "xics", &error_a=
bort);
> +        }
>          object_property_set_bool(chip, true, "realized", &error_fatal);
>      }
>      g_free(chip_typename);
> @@ -838,12 +845,12 @@ static uint32_t pnv_chip_core_pir_p8(PnvChip *chip,=
 uint32_t core_id)
>  static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
>                                          Error **errp)
>  {
> +    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
>      Error *local_err =3D NULL;
>      Object *obj;
>      PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> =20
> -    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get_m=
achine()),
> -                     &local_err);
> +    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, chip8->xics, &local_er=
r);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -997,6 +1004,12 @@ static void pnv_chip_power8_instance_init(Object *o=
bj)
>  {
>      Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
> =20
> +    object_property_add_link(obj, "xics", TYPE_XICS_FABRIC,
> +                             (Object **)&chip8->xics,
> +                             object_property_allow_set_link,
> +                             OBJ_PROP_LINK_STRONG,
> +                             &error_abort);
> +
>      object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
>                              TYPE_PNV8_PSI, &error_abort, NULL);
> =20
> @@ -1016,7 +1029,6 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, E=
rror **errp)
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>      int i, j;
>      char *name;
> -    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
> =20
>      name =3D g_strdup_printf("icp-%x", chip->chip_id);
>      memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZ=
E);
> @@ -1032,7 +1044,7 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, E=
rror **errp)
> =20
>          for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
>              uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
> -            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
> +            PnvICPState *icp =3D PNV_ICP(xics_icp_get(chip8->xics, pir));
> =20
>              memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
>                                          &icp->mmio);
> @@ -1048,6 +1060,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
>      Pnv8Psi *psi8 =3D &chip8->psi;
>      Error *local_err =3D NULL;
> =20
> +    assert(chip8->xics);
> +
>      /* XSCOM bridge is first */
>      pnv_xscom_realize(chip, PNV_XSCOM_SIZE, &local_err);
>      if (local_err) {
> @@ -1067,8 +1081,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
>                              "bar", &error_fatal);
>      object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip->system_me=
mory),
>                               "system-memory", &error_abort);
> -    object_property_set_link(OBJECT(&chip8->psi), OBJECT(qdev_get_machin=
e()),
> -                             ICS_PROP_XICS, &error_abort);
> +    object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip8->xics),
> +                              ICS_PROP_XICS, &error_abort);
>      object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
>      if (local_err) {
>          error_propagate(errp, local_err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AP7kACgkQbDjKyiDZ
s5J3bA//WgbtxYzDTY2h2CwD+4z9uT1DjQ1eu4H1rryMA5HNxs07UiJek82gmx2m
HTbSbHYcwxivYrhjg73bkuQabO9bEJjKTjQhqArz8n02+dzDJTmWStQ/s2Cxv4uz
c42hrSWk+FxcUCb1NF1uvp1J4KabxhCugRsXbAbTB/t8nQNYRTVtXzuR1oqt5sdd
rVh//gMF6Ok6d77eRsOdVBXmqkSi+GyxMjFQ8rdkn+uz3v+fnQ/sFfLXFBVkdqeW
fYnpKgKBBpU8Mlga67hzxyeMk5csdj2mbm9awbpmDcKdtYvW5czr1dpZ61Rol6nV
tL1LiJ31/bRvqWv2S0ReNVQMjYr0rqKax2/5cHygOJF4qTZkNmfWdz1u59N/mysm
HduvQOJ1uBI4ux8IIgvCTTBO+hlKvABxAkw5kaxs0QzCRVW+IAswOSHv6Pl7X1oS
zvHEhZRfTwmTWZyXfgdWusJ+dZM3/1yoZrxxXCLn3dONwjHRwLTDd9Ikua+lCDQm
WEd9Bt2cWRACXkxXgK+Nah7fmnthRJMg8ftBhYAfsLVLwMTJxASkG/WRQ7zzR303
vIJSHN8DHSShszIHaXhMFsLDfkBxuvZWtsjxWGhAm9umEny5dMNwQGI6HSEenX9B
yrZ7bSmnMZuczSW2lVQotaA1pz7fOTVMPJQ0TnG5OqPJ5KvfvOE=
=n4hh
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

