Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EA4C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CBF21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CBF21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifka7-0003Q8-Mz
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 08:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkZ9-0002rV-GT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkZ4-0007A4-8O
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:01:07 -0500
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:34997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkZ4-00076J-0L
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 08:01:02 -0500
Received: from player711.ha.ovh.net (unknown [10.109.143.238])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id B9369262CDC
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 14:00:59 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id DC734D24FF47;
 Fri, 13 Dec 2019 13:00:53 +0000 (UTC)
Subject: Re: [PATCH 07/13] ppc/pnv: Introduce PnvChipClass::intc_print_info()
 method
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623840755.360005.5002022339473369934.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4039344f-eb1c-3ea3-1055-09aeffd28ce7@kaod.org>
Date: Fri, 13 Dec 2019 14:00:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623840755.360005.5002022339473369934.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10055130594999569235
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.116.78
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/2019 13:00, Greg Kurz wrote:
> The pnv_pic_print_info() callback checks the type of the chip in order
> to forward to the request appropriate interrupt controller. This can
> be achieved with QOM. Introduce a method for this in the base chip clas=
s
> and implement it in child classes.
>=20
> This also prepares ground for the upcoming interrupt controller of POWE=
R10
> chips.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

One comment below.

> ---
>  hw/ppc/pnv.c         |   30 +++++++++++++++++++++++++-----
>  include/hw/ppc/pnv.h |    1 +
>  2 files changed, 26 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index efc00f4cb67a..2a53e99bda2e 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -832,6 +832,12 @@ static void pnv_chip_power8_intc_destroy(PnvChip *=
chip, PowerPCCPU *cpu)
>      pnv_cpu->intc =3D NULL;
>  }
> =20
> +static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU =
*cpu,
> +                                            Monitor *mon)
> +{
> +    icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
> +}
> +
>  /*
>   *    0:48  Reserved - Read as zeroes
>   *   49:52  Node ID
> @@ -889,6 +895,12 @@ static void pnv_chip_power9_intc_destroy(PnvChip *=
chip, PowerPCCPU *cpu)
>      pnv_cpu->intc =3D NULL;
>  }
> =20
> +static void pnv_chip_power9_intc_print_info(PnvChip *chip, PowerPCCPU =
*cpu,
> +                                            Monitor *mon)
> +{
> +    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon)=
;
> +}
> +
>  static void pnv_chip_power10_intc_create(PnvChip *chip, PowerPCCPU *cp=
u,
>                                          Error **errp)
>  {
> @@ -910,6 +922,11 @@ static void pnv_chip_power10_intc_destroy(PnvChip =
*chip, PowerPCCPU *cpu)
>      pnv_cpu->intc =3D NULL;
>  }
> =20
> +static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU=
 *cpu,
> +                                             Monitor *mon)
> +{
> +}
> +
>  /*
>   * Allowed core identifiers on a POWER8 Processor Chip :
>   *
> @@ -1086,6 +1103,7 @@ static void pnv_chip_power8e_class_init(ObjectCla=
ss *klass, void *data)
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->intc_reset =3D pnv_chip_power8_intc_reset;
>      k->intc_destroy =3D pnv_chip_power8_intc_destroy;
> +    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
>      k->isa_create =3D pnv_chip_power8_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1107,6 +1125,7 @@ static void pnv_chip_power8_class_init(ObjectClas=
s *klass, void *data)
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->intc_reset =3D pnv_chip_power8_intc_reset;
>      k->intc_destroy =3D pnv_chip_power8_intc_destroy;
> +    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
>      k->isa_create =3D pnv_chip_power8_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1128,6 +1147,7 @@ static void pnv_chip_power8nvl_class_init(ObjectC=
lass *klass, void *data)
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->intc_reset =3D pnv_chip_power8_intc_reset;
>      k->intc_destroy =3D pnv_chip_power8_intc_destroy;
> +    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
>      k->isa_create =3D pnv_chip_power8nvl_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1299,6 +1319,7 @@ static void pnv_chip_power9_class_init(ObjectClas=
s *klass, void *data)
>      k->intc_create =3D pnv_chip_power9_intc_create;
>      k->intc_reset =3D pnv_chip_power9_intc_reset;
>      k->intc_destroy =3D pnv_chip_power9_intc_destroy;
> +    k->intc_print_info =3D pnv_chip_power9_intc_print_info;
>      k->isa_create =3D pnv_chip_power9_isa_create;
>      k->dt_populate =3D pnv_chip_power9_dt_populate;
>      k->pic_print_info =3D pnv_chip_power9_pic_print_info;
> @@ -1379,6 +1400,7 @@ static void pnv_chip_power10_class_init(ObjectCla=
ss *klass, void *data)
>      k->intc_create =3D pnv_chip_power10_intc_create;
>      k->intc_reset =3D pnv_chip_power10_intc_reset;
>      k->intc_destroy =3D pnv_chip_power10_intc_destroy;
> +    k->intc_print_info =3D pnv_chip_power10_intc_print_info;
>      k->isa_create =3D pnv_chip_power10_isa_create;
>      k->dt_populate =3D pnv_chip_power10_dt_populate;
>      k->pic_print_info =3D pnv_chip_power10_pic_print_info;
> @@ -1575,11 +1597,9 @@ static void pnv_pic_print_info(InterruptStatsPro=
vider *obj,
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -        if (pnv_chip_is_power9(pnv->chips[0])) {
> -            xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->int=
c), mon);
> -        } else {
> -            icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
> -        }
> +        /* XXX: loop on each chip/core/thread instead of CPU_FOREACH()=
 */

May be we should introduce a helper such as :=20

int pnv_chip_cpu_foreach(PnvChip *chip,
	  int (*doit)(PnvChip *chip, PowerPCCPU *cpu, void *opaque), void *opaqu=
e)
{
    int i, j;
    int ret =3D 0;

    for (i =3D 0; i < chip->nr_cores; i++) {
        PnvCore *pc =3D chip->cores[i];
        CPUCore *cc =3D CPU_CORE(pc);

        for (j =3D 0; j < cc->nr_threads; j++) {
            PowerPCCPU *cpu =3D pc->threads[j];
            ret =3D doit(chip, cpu, opaque);
            if (ret) {=20
                break;
            }
        }
    }
    return ret;
}

> +        PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[=
0], cpu,
> +                                                           mon);
>      }
> =20
>      for (i =3D 0; i < pnv->num_chips; i++) {
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index c213bdd5ecd3..7d2402784d4b 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -133,6 +133,7 @@ typedef struct PnvChipClass {
>      void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
>      void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
>      void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
> +    void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, Monitor *m=
on);
>      ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>      void (*dt_populate)(PnvChip *chip, void *fdt);
>      void (*pic_print_info)(PnvChip *chip, Monitor *mon);
>=20


