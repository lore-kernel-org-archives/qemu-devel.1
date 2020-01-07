Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6E8C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6432072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6432072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopJZ-0001tl-Hr
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iop75-0003k9-AC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iop73-0002sz-J8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:41:39 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:38266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iop73-0002rj-Ak
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:41:37 -0500
Received: from player760.ha.ovh.net (unknown [10.108.54.72])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1C6961F7F61
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 14:41:34 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id 20A40DF2532F;
 Tue,  7 Jan 2020 13:41:25 +0000 (UTC)
Subject: Re: [PATCH v2 07/10] target/ppc: Use class fields to simplify LPCR
 masking
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 groug@kaod.org, philmd@redhat.com
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-8-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <821c4f90-fed0-cfbe-613f-34e6d57f3139@kaod.org>
Date: Tue, 7 Jan 2020 14:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107044827.471355-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9983917426513775398
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.157.236
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
Cc: aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-ppc@nongnu.org, lvivier@redhat.com, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 5:48 AM, David Gibson wrote:
> When we store the Logical Partitioning Control Register (LPCR) we have =
a
> big switch statement to work out which are valid bits for the cpu model
> we're emulating.
>=20
> As well as being ugly, this isn't really conceptually correct, since it=
 is
> based on the mmu_model variable, whereas the LPCR isn't (only) about th=
e
> MMU, so mmu_model is basically just acting as a proxy for the cpu model=
.
>=20
> Handle this in a simpler way, by adding a suitable lpcr_mask to the QOM
> class.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  target/ppc/cpu-qom.h            |  1 +
>  target/ppc/mmu-hash64.c         | 37 ++-------------------------------
>  target/ppc/translate_init.inc.c | 27 ++++++++++++++++++++----
>  3 files changed, 26 insertions(+), 39 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index e499575dc8..15d6b54a7d 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -177,6 +177,7 @@ typedef struct PowerPCCPUClass {
>      uint64_t insns_flags;
>      uint64_t insns_flags2;
>      uint64_t msr_mask;
> +    uint64_t lpcr_mask;         /* Available bits in the LPCR */
>      uint64_t lpcr_pm;           /* Power-saving mode Exit Cause Enable=
 bits */
>      powerpc_mmu_t   mmu_model;
>      powerpc_excp_t  excp_model;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index d7f9933e6d..127b7250ae 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1093,43 +1093,10 @@ static void ppc_hash64_update_vrma(PowerPCCPU *=
cpu)
> =20
>  void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>  {
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    uint64_t lpcr =3D 0;
> =20
> -    /* Filter out bits */
> -    switch (env->mmu_model) {
> -    case POWERPC_MMU_2_03: /* P5p */
> -        lpcr =3D val & (LPCR_RMLS | LPCR_ILE |
> -                      LPCR_LPES0 | LPCR_LPES1 |
> -                      LPCR_RMI | LPCR_HDICE);
> -        break;
> -    case POWERPC_MMU_2_06: /* P7 */
> -        lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
> -                      LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
> -                      LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
> -                      LPCR_MER | LPCR_TC |
> -                      LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE);
> -        break;
> -    case POWERPC_MMU_2_07: /* P8 */
> -        lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
> -                      LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
> -                      LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PE=
CE1 |
> -                      LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
> -                      LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE);
> -        break;
> -    case POWERPC_MMU_3_00: /* P9 */
> -        lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> -                      (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR=
_AIL |
> -                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LP=
CR_LD |
> -                      (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPC=
R_EEE |
> -                      LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | L=
PCR_TC |
> -                      LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE=
);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -        ;
> -    }
> -    env->spr[SPR_LPCR] =3D lpcr;
> +    env->spr[SPR_LPCR] =3D val & pcc->lpcr_mask;
>      ppc_hash64_update_rmls(cpu);
>      ppc_hash64_update_vrma(cpu);
>  }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> index 893fb12e90..240ac00506 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8463,6 +8463,8 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *da=
ta)
>                      (1ull << MSR_DR) |
>                      (1ull << MSR_PMM) |
>                      (1ull << MSR_RI);
> +    pcc->lpcr_mask =3D LPCR_RMLS | LPCR_ILE | LPCR_LPES0 | LPCR_LPES1 =
|
> +        LPCR_RMI | LPCR_HDICE;
>      pcc->mmu_model =3D POWERPC_MMU_2_03;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> @@ -8640,6 +8642,12 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *da=
ta)
>                      (1ull << MSR_PMM) |
>                      (1ull << MSR_RI) |
>                      (1ull << MSR_LE);
> +    pcc->lpcr_mask =3D LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
> +        LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
> +        LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
> +        LPCR_MER | LPCR_TC |
> +        LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE;
> +    pcc->lpcr_pm =3D LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2;
>      pcc->mmu_model =3D POWERPC_MMU_2_06;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> @@ -8656,7 +8664,6 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *dat=
a)
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>      pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
> -    pcc->lpcr_pm =3D LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2;
>  }
> =20
>  static void init_proc_POWER8(CPUPPCState *env)
> @@ -8812,6 +8819,13 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *da=
ta)
>                      (1ull << MSR_TS0) |
>                      (1ull << MSR_TS1) |
>                      (1ull << MSR_LE);
> +    pcc->lpcr_mask =3D LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
> +        LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
> +        LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE1 |
> +        LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
> +        LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE;
> +    pcc->lpcr_pm =3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
> +                   LPCR_P8_PECE3 | LPCR_P8_PECE4;
>      pcc->mmu_model =3D POWERPC_MMU_2_07;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> @@ -8829,8 +8843,6 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *dat=
a)
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>      pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
> -    pcc->lpcr_pm =3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
> -                   LPCR_P8_PECE3 | LPCR_P8_PECE4;
>  }
> =20
>  #ifdef CONFIG_SOFTMMU
> @@ -9023,6 +9035,14 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *da=
ta)
>                      (1ull << MSR_PMM) |
>                      (1ull << MSR_RI) |
>                      (1ull << MSR_LE);
> +    pcc->lpcr_mask =3D LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> +        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
> +        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
> +        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
> +                             LPCR_DEE | LPCR_OEE))
> +        | LPCR_MER | LPCR_GTSE | LPCR_TC |
> +        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
> +    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPC=
R_OEE;
>      pcc->mmu_model =3D POWERPC_MMU_3_00;
>  #if defined(CONFIG_SOFTMMU)
>      pcc->handle_mmu_fault =3D ppc64_v3_handle_mmu_fault;
> @@ -9042,7 +9062,6 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *dat=
a)
>      pcc->l1_dcache_size =3D 0x8000;
>      pcc->l1_icache_size =3D 0x8000;
>      pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
> -    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPC=
R_OEE;
>  }
> =20
>  #ifdef CONFIG_SOFTMMU
>=20


