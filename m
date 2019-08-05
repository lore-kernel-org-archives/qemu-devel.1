Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F3C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC532086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ihwPu9Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC532086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubnf-0005XJ-Tr
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 08:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hubnH-00057N-CK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hubnF-00078W-SD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:08:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34195 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hubnE-00075N-JM; Mon, 05 Aug 2019 08:08:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 462Gl02LGzz9sN4; Mon,  5 Aug 2019 22:08:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565006924;
 bh=tyWOw+yVBFssrg8dQ0nZi2tg/LcAaoJe/+eV1JkgqoE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ihwPu9Gl8U8NiPlCWsWRydYttfsRKKaN7Kld++jJtD0t+pKfcLg/GAE9y2RrZ5flv
 a2tb1jHARBAtRgEPuFdYNwoPxPoNnRUW/vGFPcPC5Bikq7+OddQngsfCBIXnf33ya+
 W1nTKi/frPpTLpmIQdUMtEsyngTHlDXZqdxAlDKg=
Date: Mon, 5 Aug 2019 20:46:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190805104628.GA14494@umbus.fritz.box>
References: <20190731141233.1340-1-clg@kaod.org>
 <20190731141233.1340-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20190731141233.1340-2-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 01/18] ppc/pnv: Introduce PowerNV
 machines with fixed CPU models
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


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2019 at 04:12:16PM +0200, C=E9dric Le Goater wrote:
> Make the current "powernv" machine an abstract type and derive from it
> new machines with specific CPU models: power8 and power9.
>=20
> The "powernv" machine is now an alias on the "powernv9" machine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.2.

> ---
>  hw/ppc/pnv.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 4570ce8afe6a..18602b9e9bcd 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -602,9 +602,20 @@ static void pnv_chip_power9_pic_print_info(PnvChip *=
chip, Monitor *mon)
>      pnv_psi_pic_print_info(&chip9->psi, mon);
>  }
> =20
> +static bool pnv_match_cpu(const char *default_type, const char *cpu_type)
> +{
> +    PowerPCCPUClass *ppc_default =3D
> +        POWERPC_CPU_CLASS(object_class_by_name(default_type));
> +    PowerPCCPUClass *ppc =3D
> +        POWERPC_CPU_CLASS(object_class_by_name(cpu_type));
> +
> +    return ppc_default->pvr_match(ppc_default, ppc->pvr);
> +}
> +
>  static void pnv_init(MachineState *machine)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      MemoryRegion *ram;
>      char *fw_filename;
>      long fw_size;
> @@ -664,13 +675,23 @@ static void pnv_init(MachineState *machine)
>          }
>      }
> =20
> +    /*
> +     * Check compatibility of the specified CPU with the machine
> +     * default.
> +     */
> +    if (!pnv_match_cpu(mc->default_cpu_type, machine->cpu_type)) {
> +        error_report("invalid CPU model '%s' for %s machine",
> +                     machine->cpu_type, mc->name);
> +        exit(1);
> +    }
> +
>      /* Create the processor chips */
>      i =3D strlen(machine->cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
>      chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
>                                      i, machine->cpu_type);
>      if (!object_class_by_name(chip_typename)) {
> -        error_report("invalid CPU model '%.*s' for %s machine",
> -                     i, machine->cpu_type, MACHINE_GET_CLASS(machine)->n=
ame);
> +        error_report("invalid chip model '%.*s' for %s machine",
> +                     i, machine->cpu_type, mc->name);
>          exit(1);
>      }
> =20
> @@ -1348,25 +1369,43 @@ static void pnv_machine_class_props_init(ObjectCl=
ass *oc)
>                                NULL);
>  }
> =20
> -static void pnv_machine_class_init(ObjectClass *oc, void *data)
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
> @@ -1386,10 +1425,27 @@ static void pnv_machine_class_init(ObjectClass *o=
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
> +    DEFINE_PNV_MACHINE_TYPE("powernv8", pnv_machine_power8_class_init),
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

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1ICQIACgkQbDjKyiDZ
s5I91w/+Mqc9jfV8FmL8B19EupYrZf0v1MrmryjADsEQubDNtZA+9q8A7+a4tHNL
o0L+9r1tNnqqaguagzkBMUXWV+UlrgS1eWKt/njSZ90H78wCr7Pss5L0vm1DDZ3z
BQyXoZN26drnoa0tEUMO2Yjy3xfeumMY4D3BUYjzmoE0FoJypBr9PzcREVGQC7vl
uLcwZXz9xT9p/YurzzCpZ+cHCCZFYB8/dhJrj9QGwFzhcMSao79sc1+0abAq5BFT
hBmCNi2YxYVtqA8ynhiUWOi4WGLVaH72nibaFgJa/pARWgeh5WLQLNA9Rj0oSlt5
z4NrIFFbXkXGltL6e5dcWU3gMhJulKpQd6zW90uU6mkiIgaTr2FrJ6IJoJkVHzTs
WxT0AJnJG18mwMbvmNhBPlm3AYa/r4WDWWjCer7r8B1/Pqa8pSfuYWVnpOXewUQ+
IhK8cKG0nlteJux+N5VGYSL35p01RNjlf0dmb05Bd8WiSUTDSvlYThET3zGYr1zZ
/0drRYCwwHIt0Z5OQ6nfQlAWyZxvmQqt6uUeCZ3/mdTj2VwhqAME57xcFaLPC62J
LVCIucwLy1JheILosbm3/+4hSB9q3Ki9tXhcUPq17hiKhmvul+JomBzaKyI55UeY
Std1rqPiE01wFfeW3luUpBYuc/GVgrcgublpfrp96kS8kXFMCbw=
=nUF6
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

