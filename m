Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F0C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2C021D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aA1JE4lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2C021D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiALL-0007Fc-1I
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 23:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iiAKd-0006jb-Jo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iiAKa-0006xD-QI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:56:07 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51297 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iiAKZ-0006IT-Bf; Thu, 19 Dec 2019 23:56:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47fGfL4THmz9sPc; Fri, 20 Dec 2019 15:55:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576817754;
 bh=zsKDar/OJkq/KrYwV9rd+kLHwnqJQa06ksaHVtXvhz0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aA1JE4lul9LiCuG2ZnweZwbflXNJr4XHVp8LR1MyHPe1y9DchCeCVhjvamHby8cI8
 rI8+vam6bH+3qcmL26YQoNVdtmj894QCcpidx16lSTgVv6fX87MRcK0FmdWWCI9B3H
 opm89umAZNNVgqwgXDRYUWk324sFgSKTUF1x+ulo=
Date: Fri, 20 Dec 2019 11:31:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 02/13] ppc/pnv: Introduce a "system-memory" property
Message-ID: <20191220003106.GL2321@umbus.fritz.box>
References: <20191219181155.32530-1-clg@kaod.org>
 <20191219181155.32530-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OGLMwEELQbPC02lM"
Content-Disposition: inline
In-Reply-To: <20191219181155.32530-3-clg@kaod.org>
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


--OGLMwEELQbPC02lM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 07:11:44PM +0100, C=E9dric Le Goater wrote:
> and use a link to pass the system memory to the device models that
> require it to map/unmap BARs. This replace the use of get_system_memory()
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I don't really see the rationale for this.  The system memory really
is global, not per-chip in any way, and just using get_system_memory()
appears to be idiomatic throughout qemu.

> ---
>  include/hw/ppc/pnv.h      |  2 ++
>  include/hw/ppc/pnv_psi.h  |  1 +
>  include/hw/ppc/pnv_xive.h |  2 ++
>  hw/intc/pnv_xive.c        |  5 ++++-
>  hw/ppc/pnv.c              | 33 ++++++++++++++++++++++++++-------
>  hw/ppc/pnv_psi.c          | 13 ++++++++++---
>  6 files changed, 45 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index f78fd0dd967c..f31180618672 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -56,6 +56,8 @@ typedef struct PnvChip {
>      AddressSpace xscom_as;
> =20
>      gchar        *dt_isa_nodename;
> +
> +    MemoryRegion *system_memory;
>  } PnvChip;
> =20
>  #define TYPE_PNV8_CHIP "pnv8-chip"
> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
> index f0f5b5519767..f85babaff0be 100644
> --- a/include/hw/ppc/pnv_psi.h
> +++ b/include/hw/ppc/pnv_psi.h
> @@ -35,6 +35,7 @@ typedef struct PnvPsi {
> =20
>      MemoryRegion regs_mr;
>      uint64_t bar;
> +    MemoryRegion *system_memory;
> =20
>      /* FSP region not supported */
>      /* MemoryRegion fsp_mr; */
> diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
> index f4c7caad40ee..4d641db691c8 100644
> --- a/include/hw/ppc/pnv_xive.h
> +++ b/include/hw/ppc/pnv_xive.h
> @@ -30,6 +30,8 @@ typedef struct PnvXive {
>      /* Owning chip */
>      struct PnvChip *chip;
> =20
> +    MemoryRegion *system_memory;
> +
>      /* XSCOM addresses giving access to the controller registers */
>      MemoryRegion  xscom_regs;
> =20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index a0a69b98a713..66970a60733b 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -853,7 +853,7 @@ static void pnv_xive_ic_reg_write(void *opaque, hwadd=
r offset,
>                                    uint64_t val, unsigned size)
>  {
>      PnvXive *xive =3D PNV_XIVE(opaque);
> -    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *sysmem =3D xive->system_memory;
>      uint32_t reg =3D offset >> 3;
>      bool is_chip0 =3D xive->chip->chip_id =3D=3D 0;
> =20
> @@ -1821,6 +1821,7 @@ static void pnv_xive_realize(DeviceState *dev, Erro=
r **errp)
>      Error *local_err =3D NULL;
> =20
>      assert(xive->chip);
> +    assert(xive->system_memory);
> =20
>      /*
>       * The XiveSource and XiveENDSource objects are realized with the
> @@ -1937,6 +1938,8 @@ static Property pnv_xive_properties[] =3D {
>      DEFINE_PROP_UINT64("tm-bar", PnvXive, tm_base, 0),
>      /* The PnvChip id identifies the XIVE interrupt controller. */
>      DEFINE_PROP_LINK("chip", PnvXive, chip, TYPE_PNV_CHIP, PnvChip *),
> +    DEFINE_PROP_LINK("system-memory", PnvXive, system_memory,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 855254f28263..1d8bfb164a32 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -674,6 +674,7 @@ static void pnv_chip_power10_pic_print_info(PnvChip *=
chip, Monitor *mon)
> =20
>  static void pnv_init(MachineState *machine)
>  {
> +    MemoryRegion *sysmem =3D get_system_memory();
>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      MemoryRegion *ram;
> @@ -692,7 +693,7 @@ static void pnv_init(MachineState *machine)
>      ram =3D g_new(MemoryRegion, 1);
>      memory_region_allocate_system_memory(ram, NULL, "pnv.ram",
>                                           machine->ram_size);
> -    memory_region_add_subregion(get_system_memory(), 0, ram);
> +    memory_region_add_subregion(sysmem, 0, ram);
> =20
>      /*
>       * Create our simple PNOR device
> @@ -790,6 +791,12 @@ static void pnv_init(MachineState *machine)
>                                  &error_fatal);
>          object_property_set_int(chip, machine->smp.cores,
>                                  "nr-cores", &error_fatal);
> +        /*
> +         * TODO: Only the MMIO range should be of interest for the
> +         * controllers
> +         */
> +        object_property_set_link(chip, OBJECT(sysmem), "system-memory",
> +                                 &error_abort);
>          object_property_set_bool(chip, true, "realized", &error_fatal);
>      }
>      g_free(chip_typename);
> @@ -1060,6 +1067,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
>      /* Processor Service Interface (PSI) Host Bridge */
>      object_property_set_int(OBJECT(&chip8->psi), PNV_PSIHB_BASE(chip),
>                              "bar", &error_fatal);
> +    object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip->system_me=
mory),
> +                             "system-memory", &error_abort);
>      object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -1100,7 +1109,7 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
>      pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_=
regs);
> =20
>      /* OCC SRAM model */
> -    memory_region_add_subregion(get_system_memory(), PNV_OCC_SENSOR_BASE=
(chip),
> +    memory_region_add_subregion(chip->system_memory, PNV_OCC_SENSOR_BASE=
(chip),
>                                  &chip8->occ.sram_regs);
> =20
>      /* HOMER */
> @@ -1116,7 +1125,7 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
>      pnv_xscom_add_subregion(chip, PNV_XSCOM_PBA_BASE, &chip8->homer.pba_=
regs);
> =20
>      /* Homer mmio region */
> -    memory_region_add_subregion(get_system_memory(), PNV_HOMER_BASE(chip=
),
> +    memory_region_add_subregion(chip->system_memory, PNV_HOMER_BASE(chip=
),
>                                  &chip8->homer.regs);
>  }
> =20
> @@ -1280,6 +1289,8 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
>                              "tm-bar", &error_fatal);
>      object_property_set_link(OBJECT(&chip9->xive), OBJECT(chip), "chip",
>                               &error_abort);
> +    object_property_set_link(OBJECT(&chip9->xive), OBJECT(chip->system_m=
emory),
> +                             "system-memory", &error_abort);
>      object_property_set_bool(OBJECT(&chip9->xive), true, "realized",
>                               &local_err);
>      if (local_err) {
> @@ -1292,6 +1303,8 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
>      /* Processor Service Interface (PSI) Host Bridge */
>      object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(chip),
>                              "bar", &error_fatal);
> +    object_property_set_link(OBJECT(&chip9->psi), OBJECT(chip->system_me=
mory),
> +                             "system-memory", &error_abort);
>      object_property_set_bool(OBJECT(&chip9->psi), true, "realized", &loc=
al_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -1308,7 +1321,7 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip=
),
> +    memory_region_add_subregion(chip->system_memory, PNV9_LPCM_BASE(chip=
),
>                                  &chip9->lpc.xscom_regs);
> =20
>      chip->dt_isa_nodename =3D g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc=
@0",
> @@ -1325,7 +1338,7 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
>      pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom=
_regs);
> =20
>      /* OCC SRAM model */
> -    memory_region_add_subregion(get_system_memory(), PNV9_OCC_SENSOR_BAS=
E(chip),
> +    memory_region_add_subregion(chip->system_memory, PNV9_OCC_SENSOR_BAS=
E(chip),
>                                  &chip9->occ.sram_regs);
> =20
>      /* HOMER */
> @@ -1341,7 +1354,7 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
>      pnv_xscom_add_subregion(chip, PNV9_XSCOM_PBA_BASE, &chip9->homer.pba=
_regs);
> =20
>      /* Homer mmio region */
> -    memory_region_add_subregion(get_system_memory(), PNV9_HOMER_BASE(chi=
p),
> +    memory_region_add_subregion(chip->system_memory, PNV9_HOMER_BASE(chi=
p),
>                                  &chip9->homer.regs);
>  }
> =20
> @@ -1408,6 +1421,8 @@ static void pnv_chip_power10_realize(DeviceState *d=
ev, Error **errp)
>      /* Processor Service Interface (PSI) Host Bridge */
>      object_property_set_int(OBJECT(&chip10->psi), PNV10_PSIHB_BASE(chip),
>                              "bar", &error_fatal);
> +    object_property_set_link(OBJECT(&chip10->psi), OBJECT(chip->system_m=
emory),
> +                             "system-memory", &error_abort);
>      object_property_set_bool(OBJECT(&chip10->psi), true, "realized",
>                               &local_err);
>      if (local_err) {
> @@ -1426,7 +1441,7 @@ static void pnv_chip_power10_realize(DeviceState *d=
ev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    memory_region_add_subregion(get_system_memory(), PNV10_LPCM_BASE(chi=
p),
> +    memory_region_add_subregion(chip->system_memory, PNV10_LPCM_BASE(chi=
p),
>                                  &chip10->lpc.xscom_regs);
> =20
>      chip->dt_isa_nodename =3D g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc=
@0",
> @@ -1556,6 +1571,8 @@ static void pnv_chip_realize(DeviceState *dev, Erro=
r **errp)
>      PnvChip *chip =3D PNV_CHIP(dev);
>      Error *error =3D NULL;
> =20
> +    assert(chip->system_memory);
> +
>      /* Cores */
>      pnv_chip_core_realize(chip, &error);
>      if (error) {
> @@ -1570,6 +1587,8 @@ static Property pnv_chip_properties[] =3D {
>      DEFINE_PROP_UINT64("ram-size", PnvChip, ram_size, 0),
>      DEFINE_PROP_UINT32("nr-cores", PnvChip, nr_cores, 1),
>      DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
> +    DEFINE_PROP_LINK("system-memory", PnvChip, system_memory,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 75e20d9da08b..28d34e5c193a 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -126,7 +126,7 @@
>  static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>  {
>      PnvPsiClass *ppc =3D PNV_PSI_GET_CLASS(psi);
> -    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *sysmem =3D psi->system_memory;
>      uint64_t old =3D psi->regs[PSIHB_XSCOM_BAR];
> =20
>      psi->regs[PSIHB_XSCOM_BAR] =3D bar & (ppc->bar_mask | PSIHB_BAR_EN);
> @@ -489,6 +489,8 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
>      Error *err =3D NULL;
>      unsigned int i;
> =20
> +    assert(psi->system_memory);
> +
>      obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
>      if (!obj) {
>          error_setg(errp, "%s: required link 'xics' not found: %s",
> @@ -562,6 +564,8 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev, v=
oid *fdt, int xscom_offset)
>  static Property pnv_psi_properties[] =3D {
>      DEFINE_PROP_UINT64("bar", PnvPsi, bar, 0),
>      DEFINE_PROP_UINT64("fsp-bar", PnvPsi, fsp_bar, 0),
> +    DEFINE_PROP_LINK("system-memory", PnvPsi, system_memory,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -701,7 +705,7 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwadd=
r addr,
>      PnvPsi *psi =3D PNV_PSI(opaque);
>      Pnv9Psi *psi9 =3D PNV9_PSI(psi);
>      uint32_t reg =3D PSIHB_REG(addr);
> -    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *sysmem =3D psi->system_memory;
> =20
>      switch (addr) {
>      case PSIHB9_CR:
> @@ -819,11 +823,12 @@ static void pnv_psi_power9_irq_set(PnvPsi *psi, int=
 irq, bool state)
>  static void pnv_psi_power9_reset(void *dev)
>  {
>      Pnv9Psi *psi =3D PNV9_PSI(dev);
> +    MemoryRegion *sysmem =3D PNV_PSI(psi)->system_memory;
> =20
>      pnv_psi_reset(dev);
> =20
>      if (memory_region_is_mapped(&psi->source.esb_mmio)) {
> -        memory_region_del_subregion(get_system_memory(), &psi->source.es=
b_mmio);
> +        memory_region_del_subregion(sysmem, &psi->source.esb_mmio);
>      }
>  }
> =20
> @@ -842,6 +847,8 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
>      Error *local_err =3D NULL;
>      int i;
> =20
> +    assert(psi->system_memory);
> +
>      /* This is the only device with 4k ESB pages */
>      object_property_set_int(OBJECT(xsrc), XIVE_ESB_4K, "shift",
>                              &error_fatal);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OGLMwEELQbPC02lM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl38FkoACgkQbDjKyiDZ
s5LOzg/+I8/EAvZyd1NyjbyVPb9xvXP5+bdBDkxVZELj7iEdtKTgr+Zl34Ka4FXc
29caPiwMPDVphAMpOKqx2bjkqUozPdYFPLAv4lkJkz4+q1J+pwgI00koZc/wGeM2
Lz/beYru0iI2zS05tuSnlsUJaEURMOb/4WANO3Q/7oeiGRk7E/NjKqtVvlABuDF5
VrIB8uLAiC8KoTFbpY4rN9a3/eCtV8aPkI+BsMzehv4vm4CBbjCq1R/ntLsEnq5C
QiwmXybQevHsc/XxPQ6X3e6y6rSpwUGYMnF5N7qrUSm22TYLCGJRt/j7sy+1T4GS
odK/f7ndl+YTk2Y71voPZmoFZWMqQJtU8tJk8oa4JXThvvjGfNd8JtXFD1cS+6Vc
h6s9c6u1N7rbcl8h9E5aetGMses4F8tEPymcHNzHR6MsNLjZHOzA4yOrU1PVJk/r
dAzUWyEFem8oMS9exncqteenxdHHV2JRYjW+qfRkkVSFRNcYme+2/+/A8GWJMWEL
y0AmL5QV/76/UXdVDd3kxL+oGJQWPI3sbyVMmUdvYmfo8lCyxQ+02i68CEImo3xA
EQCi0NICDxzpk6v/W2VFPb/VV2D9OIkKKBTdv+4/tdBUpSFjRbI0RLWU0sjE8jFB
ubCFeEIc7BEMZlj5styYKrSZdE6C3Xe3YXHBUKisP9WxnjaF3Ac=
=f6ro
-----END PGP SIGNATURE-----

--OGLMwEELQbPC02lM--

