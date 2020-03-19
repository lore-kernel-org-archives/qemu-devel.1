Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46075C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8512072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8512072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEy6B-0005l1-7G
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 12:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jEy5L-0005LF-CG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jEy5I-00083C-Ay
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:31:54 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:50106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jEy5H-0007yv-2K
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:31:51 -0400
Received: from player168.ha.ovh.net (unknown [10.108.57.150])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 158A81260A0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 17:31:47 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 9893B109379D2;
 Thu, 19 Mar 2020 16:31:41 +0000 (UTC)
Subject: Re: [EXTERNAL] [PATCH v2] target/ppc: Fix ISA v3.0 (POWER9) slbia
 implementation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200319064439.1020571-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c960f9d5-1019-38a4-4005-e3dc058e4648@kaod.org>
Date: Thu, 19 Mar 2020 17:31:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319064439.1020571-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11417469480740555673
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefledgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinheplhhishhtrdhtrghrghgvthenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduieekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.39.154
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
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 7:44 AM, Nicholas Piggin wrote:
> The new ISA v3.0 slbia variants have not been implemented for TCG,
> which can lead to crashing when a POWER9 machine boots Linux using
> the hash MMU, for example ("disable_radix" kernel command line).
>=20
> Add them.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
> Changes in v2:
> - Rewrite changelog.
> - Remove stray slbie hunk that crept in
>=20
> I don't think the slbie invalidation is necessary, as explained on the
> list.
>=20
>  target/ppc/helper.h     |  2 +-
>  target/ppc/mmu-hash64.c | 56 +++++++++++++++++++++++++++++++++++------
>  target/ppc/translate.c  |  5 +++-
>  3 files changed, 54 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index ee1498050d..2dfa1c6942 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -615,7 +615,7 @@ DEF_HELPER_FLAGS_3(store_slb, TCG_CALL_NO_RWG, void=
, env, tl, tl)
>  DEF_HELPER_2(load_slb_esid, tl, env, tl)
>  DEF_HELPER_2(load_slb_vsid, tl, env, tl)
>  DEF_HELPER_2(find_slb_vsid, tl, env, tl)
> -DEF_HELPER_FLAGS_1(slbia, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_2(slbia, TCG_CALL_NO_RWG, void, env, i32)
>  DEF_HELPER_FLAGS_2(slbie, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_FLAGS_2(slbieg, TCG_CALL_NO_RWG, void, env, tl)
>  #endif
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 373d44de74..e5baabf0e1 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -95,9 +95,10 @@ void dump_slb(PowerPCCPU *cpu)
>      }
>  }
>=20
> -void helper_slbia(CPUPPCState *env)
> +void helper_slbia(CPUPPCState *env, uint32_t ih)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
> +    int starting_entry;
>      int n;
>=20
>      /*
> @@ -111,18 +112,59 @@ void helper_slbia(CPUPPCState *env)
>       * expected that slbmte is more common than slbia, and slbia is us=
ually
>       * going to evict valid SLB entries, so that tradeoff is unlikely =
to be a
>       * good one.
> +     *
> +     * ISA v2.05 introduced IH field with values 0,1,2,6. These all in=
validate
> +     * the same SLB entries (everything but entry 0), but differ in wh=
at
> +     * "lookaside information" is invalidated. TCG can ignore this and=
 flush
> +     * everything.
> +     *
> +     * ISA v3.0 introduced additional values 3,4,7, which change what =
SLBs are
> +     * invalidated.
>       */
>=20
> -    /* XXX: Warning: slbia never invalidates the first segment */
> -    for (n =3D 1; n < cpu->hash64_opts->slb_size; n++) {
> -        ppc_slb_t *slb =3D &env->slb[n];
> +    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
> +
> +    starting_entry =3D 1; /* default for IH=3D0,1,2,6 */
> +
> +    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +        switch (ih) {
> +        case 0x7:
> +            /* invalidate no SLBs, but all lookaside information */
> +            return;
>=20
> -        if (slb->esid & SLB_ESID_V) {
> -            slb->esid &=3D ~SLB_ESID_V;
> +        case 0x3:
> +        case 0x4:
> +            /* also considers SLB entry 0 */
> +            starting_entry =3D 0;
> +            break;
> +
> +        case 0x5:
> +            /* treat undefined values as ih=3D=3D0, and warn */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "slbia undefined IH field %u.\n", ih);
> +            break;
> +
> +        default:
> +            /* 0,1,2,6 */
> +            break;
>          }
>      }
>=20
> -    env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
> +    for (n =3D starting_entry; n < cpu->hash64_opts->slb_size; n++) {
> +        ppc_slb_t *slb =3D &env->slb[n];
> +
> +        if (!(slb->esid & SLB_ESID_V)) {
> +            continue;
> +        }
> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +            if (ih =3D=3D 0x3 && (slb->vsid & SLB_VSID_C) =3D=3D 0) {
> +                /* preserves entries with a class value of 0 */
> +                continue;
> +            }
> +        }
> +
> +        slb->esid &=3D ~SLB_ESID_V;
> +    }
>  }
>=20
>  static void __helper_slbie(CPUPPCState *env, target_ulong addr,
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index eb0ddba850..e514732a09 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -5027,12 +5027,15 @@ static void gen_tlbsync(DisasContext *ctx)
>  /* slbia */
>  static void gen_slbia(DisasContext *ctx)
>  {
> +    uint32_t ih =3D (ctx->opcode >> 21) & 0x7;
> +    TCGv_i32 t0 =3D tcg_const_i32(ih);
> +
>  #if defined(CONFIG_USER_ONLY)
>      GEN_PRIV;
>  #else
>      CHK_SV;
>=20
> -    gen_helper_slbia(cpu_env);
> +    gen_helper_slbia(cpu_env, t0);
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
>=20


