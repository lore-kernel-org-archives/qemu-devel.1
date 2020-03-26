Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310E9C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6702073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BcLbKrgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6702073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGaF-00011H-46
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXM-0003lg-Ts
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXL-0002JE-G4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:20 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:33443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXL-0002HK-3k; Wed, 25 Mar 2020 20:38:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL81r71z9sST; Thu, 26 Mar 2020 11:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=TMrAlnKj9Oaxen6UMKxVPQ+/Vc6J0mqR5EMx3kDLkLI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BcLbKrgp89V9hqZg3eC2jtOjPdwFfBhC74kb7X01JG7FTaNgwMziA9e8n0QGPTuXs
 defv/9DoIpB0/BP5rr6uEkMQ/fD+dprcE9xqZE7fHpZYNNAZkY22TwZw5qGZOMyNMo
 by4t1YRnEgyFTuGU1oo++YhpxclQtFtxP/TY3JDA=
Date: Thu, 26 Mar 2020 11:15:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] ppc/pnv: Add support for NMI interface
Message-ID: <20200326001502.GL36889@umbus.fritz.box>
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Content-Disposition: inline
In-Reply-To: <20200325144147.221875-3-npiggin@gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 12:41:44AM +1000, Nicholas Piggin wrote:
> This implements the NMI interface for the PNV machine, similarly to
> commit 3431648272d ("spapr: Add support for new NMI interface") for
> SPAPR.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.1.

> ---
>  hw/ppc/pnv.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index b75ad06390..671535ebe6 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -27,6 +27,7 @@
>  #include "sysemu/runstate.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/device_tree.h"
> +#include "sysemu/hw_accel.h"
>  #include "target/ppc/cpu.h"
>  #include "qemu/log.h"
>  #include "hw/ppc/fdt.h"
> @@ -34,6 +35,7 @@
>  #include "hw/ppc/pnv.h"
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/loader.h"
> +#include "hw/nmi.h"
>  #include "exec/address-spaces.h"
>  #include "qapi/visitor.h"
>  #include "monitor/monitor.h"
> @@ -1955,10 +1957,35 @@ static void pnv_machine_set_hb(Object *obj, bool =
value, Error **errp)
>      }
>  }
> =20
> +static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    cpu_synchronize_state(cs);
> +    ppc_cpu_do_system_reset(cs);
> +    /*
> +     * SRR1[42:45] is set to 0100 which the ISA defines as implementation
> +     * dependent. POWER processors use this for xscom triggered interrup=
ts,
> +     * which come from the BMC or NMI IPIs.
> +     */
> +    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> +}
> +
> +static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
> +    }
> +}
> +
>  static void pnv_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
> +    NMIClass *nc =3D NMI_CLASS(oc);
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>      mc->init =3D pnv_init;
> @@ -1975,6 +2002,7 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
>      mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
>      mc->default_ram_id =3D "pnv.ram";
>      ispc->print_info =3D pnv_pic_print_info;
> +    nc->nmi_monitor_handler =3D pnv_nmi;
> =20
>      object_class_property_add_bool(oc, "hb-mode",
>                                     pnv_machine_get_hb, pnv_machine_set_h=
b,
> @@ -2038,7 +2066,7 @@ static const TypeInfo types[] =3D {
>          .class_size    =3D sizeof(PnvMachineClass),
>          .interfaces =3D (InterfaceInfo[]) {
>              { TYPE_INTERRUPT_STATS_PROVIDER },
> -            { },
> +            { TYPE_NMI },
>          },
>      },
>      {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl579AUACgkQbDjKyiDZ
s5IjsxAAtP88dcuaVIUz/lYSHthXuPtbuftuNx2umMOpuodtT+7bDP+tWVJzHbd6
Uu9ACU7bUVw4seR8vcCmdylLwCrHCdBemvBa9cxqw9DYqZnY1Rexv4o7TuVS2Bxb
yykqzu6TZZnoR3sLL7VTpMThzaXP8dyZIEI6iz0xGnqVCt6YdvVVFuspNZStwlpZ
MmwiTpJKUtP/JQ4ByJ0lLLiAJrL3O6cbdNaYCQG9KiTQJoMVKK+y1Cfzw8tK3RQK
Slj0VkDZsxFbW8C4t+zCbsuhUbsQ+pAvnuWyA5IYTbzBicjtM5U0Mnb0YblflY22
NqOq3cpkf402R++1EIc6VBb0eoRcL7BMXf7ZM+UR5b1qSaCn+abgoULI+vFscYBj
11e7ck0YVCOOKdsfAFJ1KNMjAa3OZFNJ92prX6Xpq0R9J/noq74mrtc9Fdqtrdhu
f3w2KGY5rKkWoPSfVbOxWkDiFO5jusWA9fyFtyOzMpiSl9fzDggN6AC10fsumbYy
auYqn60bEqj7TSI7sZJ0JXPzbIqh08WLfn3vJFcm2s7QKp/Gfp8PiM2N7dUEy6aj
D2DSUgatgSh0S3U84HZyno9DOn/8eBC7ke+rFuMiy8SJr6rlzd7nViwxGluI48Sk
A6Tbv0wYcMh4eLNvF5HP59dsYAh5XPbBdywW7FC5tH+w9yV4i3o=
=FXhw
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--

