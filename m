Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D08C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2FB20679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2FB20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspVD-00039I-5d
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38113)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hspUL-0001kx-H5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hspUK-00081v-Cm
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:21:57 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:56678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hspUK-00081D-6K
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:21:56 -0400
Received: from player714.ha.ovh.net (unknown [10.108.54.36])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id D2017128FAC
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:21:53 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 4923886D5359;
 Wed, 31 Jul 2019 14:21:48 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190731141233.1340-1-clg@kaod.org>
 <20190731141233.1340-5-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d5757c91-99f2-7ae6-da49-fcc7b476583f@kaod.org>
Date: Wed, 31 Jul 2019 16:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731141233.1340-5-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11817726899548883729
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.19
Subject: Re: [Qemu-devel] [PATCH v3 04/18] ppc/pnv: Implement the XiveFabric
 and XivePresenter interfaces
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/2019 16:12, C=C3=A9dric Le Goater wrote:
> The CAM line matching on the PowerNV machine now scans all chips of
> the system and all CPUs of a chip to find a dispatched NVT in the
> thread contexts.
>=20
> As there is now easy way to loop on the CPUs belonging to a chip, the
> PowerNV handler loops on all CPUs and filter out the external CPUs.
>=20
> Fixes: af53dbf6227a ("ppc/xive: introduce a simplified XIVE presenter")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/pnv_xive.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/pnv.c       | 32 +++++++++++++++++++
>  2 files changed, 108 insertions(+)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index ff1226485983..183798b81496 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -390,6 +390,80 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint=
8_t blk, uint32_t idx,
>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>  }
> =20
> +static int cpu_pir(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    return env->spr_cb[SPR_PIR].default_value;
> +}
> +
> +static int cpu_chip_id(PowerPCCPU *cpu)
> +{
> +    int pir =3D cpu_pir(cpu);
> +    return (pir >> 8) & 0x7f;
> +}
> +
> +static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
> +{
> +    int pir =3D cpu_pir(cpu);
> +    int thrd_id =3D pir & 0x7f;
> +
> +    return xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(thrd_id);
> +}
> +
> +static bool pnv_xive_is_ignored(PnvChip *chip, CPUState *cs)
> +{
> +    return chip->chip_id !=3D cpu_chip_id(POWERPC_CPU(cs));
> +}
> +
> +#define PNV_CHIP_CPU_FOREACH(chip, cs)                                =
  \
> +    CPU_FOREACH(cs)                                                   =
  \
> +        if (pnv_xive_is_ignored(chip, cs)) {} else

patchew will complain here but I think we can consider it as an exception
since it is inspired from the macros in migration/ram.c ?

Thanks,=20

C.=20



