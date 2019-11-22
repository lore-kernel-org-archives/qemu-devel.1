Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C65C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5622071C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5622071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9Pj-0006yQ-TY
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iY9Ow-0006GB-6j
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iY9Or-0002Tj-5U
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:55:10 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:58099)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iY9Oq-0002TJ-V9
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:55:05 -0500
Received: from player792.ha.ovh.net (unknown [10.109.160.226])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5A57D1151DE
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 14:55:02 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 99B54C68E2D8;
 Fri, 22 Nov 2019 13:54:57 +0000 (UTC)
Date: Fri, 22 Nov 2019 14:54:55 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 17/23] ppc/pnv: Clarify how the TIMA is
 accessed on a multichip system
Message-ID: <20191122145455.682a0b6d@bahia.lan>
In-Reply-To: <20191115162436.30548-18-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-18-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16768308787793271179
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehgedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.149
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 17:24:30 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The TIMA region gives access to the thread interrupt context registers
> of a CPU. It is mapped at the same address on all chips and can be
> accessed by any CPU of the system. To identify the chip from which the
> access is being done, the PowerBUS uses a 'chip' field in the
> load/store messages. QEMU does not model these messages, instead, we
> extract the chip id from the CPU PIR and do a lookup at the machine
> level to fetch the targeted interrupt controller.
>=20
> Introduce pnv_get_chip() and pnv_xive_tm_get_xive() helpers to clarify
> this process in pnv_xive_get_tctx(). The latter will be removed in the
> subsequent patches but the same principle will be kept.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/pnv.h | 13 +++++++++++++
>  hw/intc/pnv_xive.c   | 46 ++++++++++++++++++++++++++++----------------
>  2 files changed, 42 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 58f4dcc0b71d..9b98b6afa31b 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -192,6 +192,19 @@ static inline bool pnv_is_power9(PnvMachineState *pn=
v)
>      return pnv_chip_is_power9(pnv->chips[0]);
>  }
> =20
> +static inline PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_=
id)

I understand this has global scope because it may be used by
some other code, eg. PHB4 in your private branch, but I'm not
sure it is small enough to deserve the inline qualifier.

> +{
> +    int i;
> +
> +    for (i =3D 0; i < pnv->num_chips; i++) {
> +        PnvChip *chip =3D pnv->chips[i];
> +        if (chip->chip_id =3D=3D chip_id) {
> +            return chip;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  #define PNV_FDT_ADDR          0x01000000
>  #define PNV_TIMEBASE_FREQ     512000000ULL
> =20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 3ee28f00694a..d75053d0baad 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -378,6 +378,12 @@ static int cpu_pir(PowerPCCPU *cpu)
>      return env->spr_cb[SPR_PIR].default_value;
>  }
> =20
> +static int cpu_chip_id(PowerPCCPU *cpu)
> +{
> +    int pir =3D cpu_pir(cpu);
> +    return (pir >> 8) & 0x7f;
> +}

Just a thought: it would be nice to have all pir<->ids conversion
functions grouped by CPU type in pnv.h (inline makes sense in this
case) along with the layout comment.

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

> +
>  static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
>  {
>      int pir =3D cpu_pir(cpu);
> @@ -440,31 +446,37 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, =
uint8_t format,
>      return count;
>  }
> =20
> +/*
> + * The TIMA MMIO space is shared among the chips and to identify the
> + * chip from which the access is being done, we extract the chip id
> + * from the PIR.
> + */
> +static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
> +{
> +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> +    PnvChip *chip;
> +    PnvXive *xive;
> +
> +    chip =3D pnv_get_chip(pnv, cpu_chip_id(cpu));
> +    assert(chip);
> +    xive =3D &PNV9_CHIP(chip)->xive;
> +
> +    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
> +        xive_error(xive, "IC: CPU %x is not enabled", cpu_pir(cpu));
> +    }
> +    return xive;
> +}
> +
>  static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> -    PnvXive *xive =3D NULL;
> -    CPUPPCState *env =3D &cpu->env;
> -    int pir =3D env->spr_cb[SPR_PIR].default_value;
> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
> =20
> -    /*
> -     * Perform an extra check on the HW thread enablement.
> -     *
> -     * The TIMA is shared among the chips and to identify the chip
> -     * from which the access is being done, we extract the chip id
> -     * from the PIR.
> -     */
> -    xive =3D pnv_xive_get_ic((pir >> 8) & 0xf);
>      if (!xive) {
>          return NULL;
>      }
> =20
> -    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
> -        xive_error(PNV_XIVE(xrtr), "IC: CPU %x is not enabled", pir);
> -    }
> -
> -    return tctx;
> +    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>  }
> =20
>  /*


