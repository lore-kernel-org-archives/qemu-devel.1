Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A81C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D172073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D172073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH93X-0000Ir-RK
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jH92q-0007qp-Jj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jH92p-0005ZV-20
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:38:20 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:45320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jH92o-0005Z5-S4
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:38:19 -0400
Received: from player795.ha.ovh.net (unknown [10.108.42.184])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id E1807245F8C
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:38:16 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id B2A4010A819FE;
 Wed, 25 Mar 2020 16:38:08 +0000 (UTC)
Subject: Re: [PATCH 2/5] ppc/pnv: Add support for NMI interface
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-3-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c1cdf2a2-afe9-8771-2c00-7e6a79d5e532@kaod.org>
Date: Wed, 25 Mar 2020 17:38:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325144147.221875-3-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9869638584927882148
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.47.94
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
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[ Please use clg@kaod.org ! ]

On 3/25/20 3:41 PM, Nicholas Piggin wrote:
> This implements the NMI interface for the PNV machine, similarly to
> commit 3431648272d ("spapr: Add support for new NMI interface") for
> SPAPR.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

one minor comment,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

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
> @@ -1955,10 +1957,35 @@ static void pnv_machine_set_hb(Object *obj, boo=
l value, Error **errp)
>      }
>  }
>=20
> +static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    cpu_synchronize_state(cs);
> +    ppc_cpu_do_system_reset(cs);
> +    /*
> +     * SRR1[42:45] is set to 0100 which the ISA defines as implementat=
ion

I see 'System Reset' in ISA 3.0

> +     * dependent. POWER processors use this for xscom triggered interr=
upts,
> +     * which come from the BMC or NMI IPIs.
> +     */
> +    env->spr[SPR_SRR1] |=3D PPC_BIT(43);

So we could have used the skiboot SPR_SRR1_PM_WAKE_SRESET define ?=20

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
>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLA=
SS(oc);
> +    NMIClass *nc =3D NMI_CLASS(oc);
>=20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>      mc->init =3D pnv_init;
> @@ -1975,6 +2002,7 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
>      mc->default_ram_id =3D "pnv.ram";
>      ispc->print_info =3D pnv_pic_print_info;
> +    nc->nmi_monitor_handler =3D pnv_nmi;
>=20
>      object_class_property_add_bool(oc, "hb-mode",
>                                     pnv_machine_get_hb, pnv_machine_set=
_hb,
> @@ -2038,7 +2066,7 @@ static const TypeInfo types[] =3D {
>          .class_size    =3D sizeof(PnvMachineClass),
>          .interfaces =3D (InterfaceInfo[]) {
>              { TYPE_INTERRUPT_STATS_PROVIDER },
> -            { },
> +            { TYPE_NMI },
>          },
>      },
>      {
>=20


