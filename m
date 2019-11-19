Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F47C33C9D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 00:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0D522303
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 00:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QpV690RW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0D522303
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWrmE-0003Lv-GP
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 19:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWrlA-0002B2-K5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 19:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWrl8-0005rG-BU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 19:52:48 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53685 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWrl5-0005mE-P1; Mon, 18 Nov 2019 19:52:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47H6jz4M3Nz9sPW; Tue, 19 Nov 2019 11:52:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574124759;
 bh=kezO9pO44swx7qELErF8jMfL0M3/Dw9zWvpWdVJ0Dzk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QpV690RWVLpF/EpPLvyJzlYJ/R3tMt2flLeqfTBTVFBBXabM1UfzjbrdXhWGvdeYs
 iRcr6dOzhogczj/OmYX6ZUYnQIN0kVMZNZ2b0ogCe15x2Xb0CkEIjMXINgUu52PoUa
 rNzuxTFEqusr9L645x1JCWfgOBjF0vJxuknI4AqI=
Date: Tue, 19 Nov 2019 11:52:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Create BMC devices at machine init
Message-ID: <20191119005232.GH5582@umbus.fritz.box>
References: <20191118092222.15691-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline
In-Reply-To: <20191118092222.15691-1-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, Corey Minyard <cminyard@mvista.com>,
 Oliver O'Halloran <oohall@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 10:22:22AM +0100, C=E9dric Le Goater wrote:
> The BMC of the OpenPOWER systems monitors the machine state using
> sensors, controls the power and controls the access to the PNOR flash
> device containing the firmware image required to boot the host.
>=20
> QEMU models the power cycle process, access to the sensors and access
> to the PNOR device. But, for these features to be available, the QEMU
> PowerNV machine needs two extras devices on the command line, an IPMI
> BT device for communication and a BMC backend device:
>=20
>   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10
>=20
> The BMC properties are then defined accordingly in the device tree and
> OPAL self adapts. If a BMC device and an IPMI BT device are not
> available, OPAL does not try to communicate with the BMC in any
> manner. This is not how real systems behave.
>=20
> To be closer to the default behavior, create an IPMI BMC simulator
> device and an IPMI BT device at machine initialization time. We loose
> the ability to define an external BMC device but there are benefits:
>=20
>   - a better match with real systems,
>   - a better test coverage of the OPAL code,
>   - system powerdown and reset commands that work,
>   - a QEMU device tree compliant with the specifications (*).
>=20
> (*) Still needs a MBOX device.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This doesn't apply to ppc-for-5.0 for me.  I'm not sure which change
in there it's conflicting with, but there seems to be something.

> ---
>  include/hw/ppc/pnv.h |  2 +-
>  hw/ppc/pnv.c         | 33 ++++++++++++++++-----------------
>  hw/ppc/pnv_bmc.c     | 20 +++++++++++++++++---
>  3 files changed, 34 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 07c56c05ad30..90f1343ed07c 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -198,7 +198,7 @@ static inline bool pnv_is_power9(PnvMachineState *pnv)
>   */
>  void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
>  void pnv_bmc_powerdown(IPMIBmc *bmc);
> -int pnv_bmc_hiomap(IPMIBmc *bmc);
> +IPMIBmc *pnv_bmc_create(void);
> =20
>  /*
>   * POWER8 MMIO base addresses
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c3ac0d6d5b4a..2117d879895c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -551,27 +551,10 @@ static void pnv_powerdown_notify(Notifier *n, void =
*opaque)
> =20
>  static void pnv_reset(MachineState *machine)
>  {
> -    PnvMachineState *pnv =3D PNV_MACHINE(machine);
>      void *fdt;
> -    Object *obj;
> =20
>      qemu_devices_reset();
> =20
> -    /*
> -     * OpenPOWER systems have a BMC, which can be defined on the
> -     * command line with:
> -     *
> -     *   -device ipmi-bmc-sim,id=3Dbmc0
> -     *
> -     * This is the internal simulator but it could also be an external
> -     * BMC.
> -     */
> -    obj =3D object_resolve_path_type("", "ipmi-bmc-sim", NULL);
> -    if (obj) {
> -        pnv->bmc =3D IPMI_BMC(obj);
> -        pnv_bmc_hiomap(pnv->bmc);
> -    }
> -
>      fdt =3D pnv_dt_create(machine);
> =20
>      /* Pack resulting tree */
> @@ -629,6 +612,16 @@ static bool pnv_match_cpu(const char *default_type, =
const char *cpu_type)
>      return ppc_default->pvr_match(ppc_default, ppc->pvr);
>  }
> =20
> +static void ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
> +{
> +    Object *obj;
> +
> +    obj =3D OBJECT(isa_create(bus, "isa-ipmi-bt"));
> +    object_property_set_link(obj, OBJECT(bmc), "bmc", &error_fatal);
> +    object_property_set_int(obj, irq, "irq", &error_fatal);
> +    object_property_set_bool(obj, true, "realized", &error_fatal);
> +}
> +
>  static void pnv_init(MachineState *machine)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
> @@ -751,6 +744,9 @@ static void pnv_init(MachineState *machine)
>      }
>      g_free(chip_typename);
> =20
> +    /* Create the machine BMC simulator */
> +    pnv->bmc =3D pnv_bmc_create();
> +
>      /* Instantiate ISA bus on chip 0 */
>      pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
> =20
> @@ -760,6 +756,9 @@ static void pnv_init(MachineState *machine)
>      /* Create an RTC ISA device too */
>      mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
> =20
> +    /* Create the IPMI BT device for communication with the BMC */
> +    ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
> +
>      /*
>       * OpenPOWER systems use a IPMI SEL Event message to notify the
>       * host to powerdown
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index aa5c89586c63..07fa1e1c7e45 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -17,6 +17,8 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
>  #include "target/ppc/cpu.h"
>  #include "qemu/log.h"
>  #include "hw/ipmi/ipmi.h"
> @@ -211,8 +213,20 @@ static const IPMINetfn hiomap_netfn =3D {
>      .cmd_handlers =3D hiomap_cmds
>  };
> =20
> -int pnv_bmc_hiomap(IPMIBmc *bmc)
> +/*
> + * Instantiate the machine BMC. PowerNV uses the QEMU internal
> + * simulator but it could also be external.
> + */
> +IPMIBmc *pnv_bmc_create(void)
>  {
> -    return ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc),
> -                                   IPMI_NETFN_OEM, &hiomap_netfn);
> +    Object *obj;
> +
> +    obj =3D object_new(TYPE_IPMI_BMC_SIMULATOR);
> +    object_property_set_bool(obj, true, "realized", &error_fatal);
> +
> +    /* Install the HIOMAP protocol handlers to access the PNOR */
> +    ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(obj), IPMI_NETFN_OEM,
> +                            &hiomap_netfn);
> +
> +    return IPMI_BMC(obj);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TPNAACgkQbDjKyiDZ
s5Ir8A//fEGQUJEn4vIbVV0Bp0UNdclaDvpQ/GMxfRTySHh97xjB5ZO4AamPx4sX
YvenEenwWUd6ZsomOQmr2GXkmKwPyxZpsLF8+zKr6AoCLTGhTbczBgCxHZzCKYBP
+J82CgRwAu158P9cvzRssX9bqL634mg+QSGdJ+DOBmt5suaIjOZEYUpQaIY6Zkil
NdxyEEXUxOAFQM7srpkrF6cCs8R1yNOcFBQpauU1PsQSU5D5n/0KXctIdQIKA2NR
NRHfXCViMfthIGT7Z7cRLbBYExkk0Nm0Ztm5OjEAoRTvX+MVFQsamEw3Sk3z3RqA
HEE/Hd0U/+36GOvDQK7/R2lWAOLyibOf7HxmpHAaN5wkcEuxKl1SgxZ4DYAxjLZQ
AmWrTMFJgrIx44JioA9e6DYsioV8+dkzNKRV/bcRwuT6YMVDPhmHChJLhxEF9h+q
f2wXu8J4SfSRaRwHhe+N39EpBFpX5PYXGqeqY0S9/PQZ/6WJC9Ioz7Bz4YHtBlHe
IkOGQ1ka2zYuwXWZxFigtN+vLPyrZ8LVSCWfDbttXWJkqPY5GP6CoMGLJwhpuj32
vSbuZGqLa/l4uZLVABxp8nO5sk3IAdvKdLt60dycR483IEVSK6R3sfNt/oEatSzv
uJA+G8OEu8ID0nNtd4vBk1DkM76AUqbMXQ+qCuMdOQ80aWxAGCI=
=FTuV
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--

