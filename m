Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967A8C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631802238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ly/1utwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631802238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnDE-0002m7-46
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39688)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCd-0000s5-Q5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCc-0003mp-9D
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:07 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58935)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpnCb-0003gG-31; Tue, 23 Jul 2019 01:19:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t6G75VYGz9sBF; Tue, 23 Jul 2019 15:18:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563859135;
 bh=yhlQJSdsQoYETUzYPrSRKmeCiJbiYRgGawttAEAeBIE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ly/1utwGOx5Bh+i4xgjsfkVY+s4AXprmrXCGJvPX6SlP5UOCcCk69M4kH1Y+1as6C
 ddIYrKF4/ncUsA/YezRmFUlAfzEze8QdxomDVAJq8unHP7JZCI9mHLYfPmLHmbgCB+
 Bgmlh4yWH2bSdOuMrABfNxOAALC770YTlWtKcYws=
Date: Tue, 23 Jul 2019 11:38:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190723013808.GJ25073@umbus.fritz.box>
References: <20190722182347.25075-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline
In-Reply-To: <20190722182347.25075-1-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Introduce PowerNV machines with
 fixed CPU models
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


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 08:23:47PM +0200, C=E9dric Le Goater wrote:
> Make the current "powernv" machine an abstract type and derive from it
> new machines with specific CPU models: power8, power8e, power8nvl,
> power9.
>=20
> The "powernv" machine is now an alias on the "powernv9" machine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Ah, sorry, I wasn't clear here.  I don't think we need a different
machine type for every cpu model, I just think we should have powernv8
and powernv9.  POWER8E and POWER8NVL don't significantly change the
system design (IIUC) so they can still be done with "-machine powernv8
-cpu POWER8E" or whatever.  I expect the same will be true for POWER9'
when that comes along

> ---
>  hw/ppc/pnv.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 85 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 8cef6d17f111..36f57479a1f5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -600,6 +600,7 @@ static void pnv_chip_power9_pic_print_info(PnvChip *c=
hip, Monitor *mon)
>  static void pnv_init(MachineState *machine)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      MemoryRegion *ram;
>      char *fw_filename;
>      long fw_size;
> @@ -659,16 +660,25 @@ static void pnv_init(MachineState *machine)
>          }
>      }
> =20
> -    /* Create the processor chips */
> -    i =3D strlen(machine->cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
> -    chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
> -                                    i, machine->cpu_type);
> -    if (!object_class_by_name(chip_typename)) {
> -        error_report("invalid CPU model '%.*s' for %s machine",
> -                     i, machine->cpu_type, MACHINE_GET_CLASS(machine)->n=
ame);
> +    /*
> +     * Do a sanity check on the specified CPU to check compatibility
> +     * with the machine default. In the future, we might want to
> +     * create the PnvChip with a compatible CPU model but for now, we
> +     * use the machine default.
> +     */
> +    if (object_class_by_name(mc->default_cpu_type) !=3D
> +        object_class_by_name(machine->cpu_type)) {
> +        error_report("invalid CPU model '%s' for %s machine",
> +                     machine->cpu_type, mc->name);
>          exit(1);
>      }
> =20
> +    /* Create the processor chips */
> +    i =3D strlen(mc->default_cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
> +    chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
> +                                    i, mc->default_cpu_type);
> +    assert(object_class_by_name(chip_typename));
> +
>      pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
>      for (i =3D 0; i < pnv->num_chips; i++) {
>          char chip_name[32];
> @@ -1343,25 +1353,69 @@ static void pnv_machine_class_props_init(ObjectCl=
ass *oc)
>                                NULL);
>  }
> =20
> -static void pnv_machine_class_init(ObjectClass *oc, void *data)
> +static void pnv_machine_power8e_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> +
> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8E";
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8e_v2.1");
> +
> +    xic->icp_get =3D pnv_icp_get;
> +    xic->ics_get =3D pnv_ics_get;
> +    xic->ics_resend =3D pnv_ics_resend;
> +}
> +
> +static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> +
> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8";
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
> +
> +    xic->icp_get =3D pnv_icp_get;
> +    xic->ics_get =3D pnv_ics_get;
> +    xic->ics_resend =3D pnv_ics_resend;
> +}
> +
> +static void pnv_machine_power8nvl_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> +
> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8NVL";
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8nvl_v1.0");
> +
> +    xic->icp_get =3D pnv_icp_get;
> +    xic->ics_get =3D pnv_ics_get;
> +    xic->ics_resend =3D pnv_ics_resend;
> +}
> +
> +static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
> +
> +    mc->alias =3D "powernv";
> +}
> +
> +static void pnv_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>      mc->init =3D pnv_init;
>      mc->reset =3D pnv_reset;
>      mc->max_cpus =3D MAX_CPUS;
> -    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device for
>                                        * storage */
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
>      mc->default_ram_size =3D 2 * GiB;
> -    xic->icp_get =3D pnv_icp_get;
> -    xic->ics_get =3D pnv_ics_get;
> -    xic->ics_resend =3D pnv_ics_resend;
>      ispc->print_info =3D pnv_pic_print_info;
> =20
>      pnv_machine_class_props_init(oc);
> @@ -1381,10 +1435,29 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
>          .parent        =3D TYPE_PNV9_CHIP,          \
>      }
> =20
> +#define DEFINE_PNV_MACHINE_TYPE(cpu, class_initfn)      \
> +    {                                                   \
> +        .name          =3D MACHINE_TYPE_NAME(cpu),        \
> +        .parent        =3D TYPE_PNV_MACHINE,              \
> +        .instance_size =3D sizeof(PnvMachineState),       \
> +        .instance_init =3D pnv_machine_instance_init,     \
> +        .class_init    =3D class_initfn,                  \
> +        .interfaces =3D (InterfaceInfo[]) {               \
> +            { TYPE_XICS_FABRIC },                       \
> +            { TYPE_INTERRUPT_STATS_PROVIDER },          \
> +            { },                                        \
> +        },                                              \
> +    }
> +
>  static const TypeInfo types[] =3D {
> +    DEFINE_PNV_MACHINE_TYPE("powernv8e", pnv_machine_power8e_class_init),
> +    DEFINE_PNV_MACHINE_TYPE("powernv8", pnv_machine_power8_class_init),
> +    DEFINE_PNV_MACHINE_TYPE("powernv8nvl", pnv_machine_power8nvl_class_i=
nit),
> +    DEFINE_PNV_MACHINE_TYPE("powernv9", pnv_machine_power9_class_init),
>      {
>          .name          =3D TYPE_PNV_MACHINE,
>          .parent        =3D TYPE_MACHINE,
> +        .abstract       =3D true,
>          .instance_size =3D sizeof(PnvMachineState),
>          .instance_init =3D pnv_machine_instance_init,
>          .class_init    =3D pnv_machine_class_init,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02ZP4ACgkQbDjKyiDZ
s5KKERAAizXjeEGj2jRtJrlNn/E1kROLDx50ces00IaQQMyYcWrqlB5yYas7V8rN
sxwOmzryXKmda5r26gQiSGmJSLl2Y4L6fo7rxWEk8aHQukFMAevYA52e0MmnKUad
vEMZvypo4vNLh6nKZrgmT+VlBSRit3weZ/RC24r8Gn7vAcCk4ACvsE14hDlWhwXS
1U562JpKQqv/+zKmJuzblycWkET89Xo0RFMLIVzhGdJpSYWM9MvmH5XAnn2x8CSe
FbgweHvgY516DY/fTf9adXKJmOZN5Mg9yuRc8FASpmeCu6IuSyJ0Jh5N7ZHTsaAq
9N6SttMk96CPcm9Tg4tNj6nkdsAsh15+ZMoT2bSDzd3ZbeEQj8kdT5PWZrI8KNos
Rr7z7xG8v3cwlL+gW7dhicMipivPMtslu4n8e8pu0YNt8SeNO0VWyd4Tn+a5pgQY
UkaRrH09Z5NN+1paTEVQv3rtlVp9siuY5oEm0utaLeYZzg7WxD3vsYY9WeG2daN6
YaSMCAJvvJlabrM4M8Tlf0//chlsXdb2XTcmuYl3h4fbagnV3QG3WkHharigZKmF
96W6nhrHMVeL53wgpgnrnqYrq7WRw/l/XIlUvhALZxr/TMeYSUX20N3dqpGHQWiY
3sFRS+TwfeXSu9UQSMeZdVI/Lrj+XKU+FYVIPMq8OVhoa4zVtOw=
=pYxM
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--

