Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D933C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 01:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A42E206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 01:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AGVTkev0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A42E206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLGbP-0007Vj-Fp
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 21:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLGai-0006vZ-Au
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 21:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLGag-00058K-FR
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 21:30:19 -0400
Received: from ozlabs.org ([203.11.71.1]:33925)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLGae-000532-I3; Sun, 05 Apr 2020 21:30:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48wXz04zmjz9sRf; Mon,  6 Apr 2020 11:30:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586136604;
 bh=oE1fCQjROzwh4aW6IS38BzIYdaOfJOtl3GvDGKkjGCE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AGVTkev0ATeAEf5ENuSHnGpPkmTvbY40mAGdgbBDmta3styyhfMDgGsZXMh6QsPOR
 37Jz+Vvsj70s3kRQMAM0OQuoORYJEs03VrSprp05KX1dyPhgkxV56PTWssHDp5EEMX
 D/7YPQ9ftw0Aor5uHkS0hLJhs+FaKyHAUw75qEns=
Date: Mon, 6 Apr 2020 11:00:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Create BMC devices only when defaults are enabled
Message-ID: <20200406010053.GA2945@umbus.fritz.box>
References: <20200404153655.166834-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20200404153655.166834-1-clg@kaod.org>
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
Cc: Corey Minyard <cminyard@mvista.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Oliver O'Halloran <oohall@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2020 at 05:36:55PM +0200, C=E9dric Le Goater wrote:
> Commit e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
> introduced default BMC devices which can be a problem when the same
> devices are defined on the command line with :
>=20
>   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10
>=20
> QEMU fails with :
>=20
>   qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS
>=20
> Use defaults_enabled() when creating the default BMC devices to let
> the user provide its own BMC devices using '-nodefaults'. If no BMC
> device are provided, output a warning but let QEMU run as this is a
> supported configuration. However, when multiple BMC devices are
> defined, stop QEMU with a clear error as the results are unexpected.
>=20
> Fixes: e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

As a regression fix, applied to ppc-for-5.0.

> ---
>  include/hw/ppc/pnv.h |  2 ++
>  hw/ppc/pnv.c         | 32 ++++++++++++++++++++++++++-----
>  hw/ppc/pnv_bmc.c     | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 74 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index fb4d0c0234b3..d4b0b0e2ff71 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -241,6 +241,8 @@ struct PnvMachineState {
>  void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
>  void pnv_bmc_powerdown(IPMIBmc *bmc);
>  IPMIBmc *pnv_bmc_create(PnvPnor *pnor);
> +IPMIBmc *pnv_bmc_find(Error **errp);
> +void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
> =20
>  /*
>   * POWER8 MMIO base addresses
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index ac83b8698b8e..a3b7a8d0ff32 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -573,10 +573,29 @@ static void pnv_powerdown_notify(Notifier *n, void =
*opaque)
> =20
>  static void pnv_reset(MachineState *machine)
>  {
> +    PnvMachineState *pnv =3D PNV_MACHINE(machine);
> +    IPMIBmc *bmc;
>      void *fdt;
> =20
>      qemu_devices_reset();
> =20
> +    /*
> +     * The machine should provide by default an internal BMC simulator.
> +     * If not, try to use the BMC device that was provided on the command
> +     * line.
> +     */
> +    bmc =3D pnv_bmc_find(&error_fatal);
> +    if (!pnv->bmc) {
> +        if (!bmc) {
> +            warn_report("machine has no BMC device. Use '-device "
> +                        "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=
=3Dbmc0,irq=3D10' "
> +                        "to define one");
> +        } else {
> +            pnv_bmc_set_pnor(bmc, pnv->pnor);
> +            pnv->bmc =3D bmc;
> +        }
> +    }
> +
>      fdt =3D pnv_dt_create(machine);
> =20
>      /* Pack resulting tree */
> @@ -835,9 +854,6 @@ static void pnv_init(MachineState *machine)
>      }
>      g_free(chip_typename);
> =20
> -    /* Create the machine BMC simulator */
> -    pnv->bmc =3D pnv_bmc_create(pnv->pnor);
> -
>      /* Instantiate ISA bus on chip 0 */
>      pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
> =20
> @@ -847,8 +863,14 @@ static void pnv_init(MachineState *machine)
>      /* Create an RTC ISA device too */
>      mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
> =20
> -    /* Create the IPMI BT device for communication with the BMC */
> -    pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
> +    /*
> +     * Create the machine BMC simulator and the IPMI BT device for
> +     * communication with the BMC
> +     */
> +    if (defaults_enabled()) {
> +        pnv->bmc =3D pnv_bmc_create(pnv->pnor);
> +        pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
> +    }
> =20
>      /*
>       * OpenPOWER systems use a IPMI SEL Event message to notify the
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 8863354c1c08..4e018b8b70e4 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -213,6 +213,18 @@ static const IPMINetfn hiomap_netfn =3D {
>      .cmd_handlers =3D hiomap_cmds
>  };
> =20
> +
> +void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
> +{
> +    object_ref(OBJECT(pnor));
> +    object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor),
> +                                   &error_abort);
> +
> +    /* Install the HIOMAP protocol handlers to access the PNOR */
> +    ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc), IPMI_NETFN_OEM,
> +                            &hiomap_netfn);
> +}
> +
>  /*
>   * Instantiate the machine BMC. PowerNV uses the QEMU internal
>   * simulator but it could also be external.
> @@ -232,3 +244,36 @@ IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
> =20
>      return IPMI_BMC(obj);
>  }
> +
> +typedef struct ForeachArgs {
> +    const char *name;
> +    Object *obj;
> +} ForeachArgs;
> +
> +static int bmc_find(Object *child, void *opaque)
> +{
> +    ForeachArgs *args =3D opaque;
> +
> +    if (object_dynamic_cast(child, args->name)) {
> +        if (args->obj) {
> +            return 1;
> +        }
> +        args->obj =3D child;
> +    }
> +    return 0;
> +}
> +
> +IPMIBmc *pnv_bmc_find(Error **errp)
> +{
> +    ForeachArgs args =3D { TYPE_IPMI_BMC_SIMULATOR, NULL };
> +    int ret;
> +
> +    ret =3D object_child_foreach_recursive(object_get_root(), bmc_find, =
&args);
> +    if (ret) {
> +        error_setg(errp, "machine should have only one BMC device. "
> +                   "Use '-nodefaults'");
> +        return NULL;
> +    }
> +
> +    return args.obj ? IPMI_BMC(args.obj) : NULL;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6Kf0UACgkQbDjKyiDZ
s5KdLBAAnVsnXxAwCMdJ/6Amm31F6P/B5bTFfCYOkb6RszKeLeJ4xZ/XU1HRYBUE
QSKTesSn0wFpKuu414qQtNn/mi6JOeyFUoTZ40Kl8b/JQ1xWVatFb4oefLdCXsSk
GlG/sSpKtaq5zpUyZ0RiGf8iMjC2RyLWepm3D+DhWEGJBRvPSTfs7VRlh59dMzSa
D3g5fBWJjZJa1vnFAasYDaiZaWCV/COqEgZeOHaoEycFMtHHVN8AXjilwWnRcvjy
t/m3HJqVJLViUd4yLC14h3OaJGXxoOvq5vRjYaWR329DQKU3otabiFV2cz3bJ/ME
ZnGZYRdPXk/Pfth3fvWhuYTydQmGFNr4TC0v7BslUBbLT1TFnADvJA8teyRgE+Un
dx15c0ZLtIcou2Ru+jghxDC9Eas5xGQMDUCByZzWZ7VX1P5YyZBWui/NSzeZkChz
WVvuTZoIrHeDY019M5r9R0Q6nqqgYclHvualqc/rgp/Zry1J2gRFK8xGYMmF8+cm
W9NCqgwvydRsy9dcLHStpglNMpn9GA3SEn3oPj25dHr0cFwehIgvwqM50BfxN7tZ
7Z8FykR2vIFaPOTvNNastUf/qnAxWrJGesmTkS0+9ND1GpTeDv3vHAN9DOwnZB6g
X2LQe3ipPZK7MBJrfd8FkYke5bFPpUraS/zyMpw8EdYr/2qXUl0=
=JdjF
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

