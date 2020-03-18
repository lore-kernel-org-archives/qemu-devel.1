Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8F5C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EBE2071C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EBE2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEcCe-0004eY-12
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 13:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jEcBq-0003or-A3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jEcBo-0000kl-MN
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:09:10 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:52558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jEcBo-0000hW-F6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:09:08 -0400
Received: from player762.ha.ovh.net (unknown [10.110.208.147])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 516DB15913B
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 18:09:06 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 16A3E108FEA29;
 Wed, 18 Mar 2020 17:08:54 +0000 (UTC)
Subject: Re: [EXTERNAL] [PATCH 2/2] target/ppc: Fix ISA v3.0 (POWER9) slbia
 implementation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200318044135.851716-1-npiggin@gmail.com>
 <20200318044135.851716-2-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <47de57fe-189f-aef1-87f4-d9e2b5d31b22@kaod.org>
Date: Wed, 18 Mar 2020 18:08:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318044135.851716-2-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6174716567642803097
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefjedgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.167
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

On 3/18/20 5:41 AM, Nicholas Piggin wrote:
> Linux using the hash MMU ("disable_radix" command line) on a POWER9
> machine quickly hits translation bugs due to using v3.0 slbia
> features that are not implemented in TCG. Add them.

I checked the ISA books and this looks OK but you are also modifying
slbie.

Thanks,

C. 


> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/helper.h     |  2 +-
>  target/ppc/mmu-hash64.c | 57 ++++++++++++++++++++++++++++++++++++-----
>  target/ppc/translate.c  |  5 +++-
>  3 files changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index ee1498050d..2dfa1c6942 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -615,7 +615,7 @@ DEF_HELPER_FLAGS_3(store_slb, TCG_CALL_NO_RWG, void, env, tl, tl)
>  DEF_HELPER_2(load_slb_esid, tl, env, tl)
>  DEF_HELPER_2(load_slb_vsid, tl, env, tl)
>  DEF_HELPER_2(find_slb_vsid, tl, env, tl)
> -DEF_HELPER_FLAGS_1(slbia, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_2(slbia, TCG_CALL_NO_RWG, void, env, i32)
>  DEF_HELPER_FLAGS_2(slbie, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_FLAGS_2(slbieg, TCG_CALL_NO_RWG, void, env, tl)
>  #endif
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 373d44de74..deb1c13a66 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -95,9 +95,10 @@ void dump_slb(PowerPCCPU *cpu)
>      }
>  }
> 
> -void helper_slbia(CPUPPCState *env)
> +void helper_slbia(CPUPPCState *env, uint32_t ih)
>  {
>      PowerPCCPU *cpu = env_archcpu(env);
> +    int starting_entry;
>      int n;
> 
>      /*
> @@ -111,18 +112,59 @@ void helper_slbia(CPUPPCState *env)
>       * expected that slbmte is more common than slbia, and slbia is usually
>       * going to evict valid SLB entries, so that tradeoff is unlikely to be a
>       * good one.
> +     *
> +     * ISA v2.05 introduced IH field with values 0,1,2,6. These all invalidate
> +     * the same SLB entries (everything but entry 0), but differ in what
> +     * "lookaside information" is invalidated. TCG can ignore this and flush
> +     * everything.
> +     *
> +     * ISA v3.0 introduced additional values 3,4,7, which change what SLBs are
> +     * invalidated.
>       */
> 
> -    /* XXX: Warning: slbia never invalidates the first segment */
> -    for (n = 1; n < cpu->hash64_opts->slb_size; n++) {
> -        ppc_slb_t *slb = &env->slb[n];
> +    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
> +
> +    starting_entry = 1; /* default for IH=0,1,2,6 */
> +
> +    if (env->mmu_model == POWERPC_MMU_3_00) {
> +        switch (ih) {
> +        case 0x7:
> +            /* invalidate no SLBs, but all lookaside information */
> +            return;
> 
> -        if (slb->esid & SLB_ESID_V) {
> -            slb->esid &= ~SLB_ESID_V;
> +        case 0x3:
> +        case 0x4:
> +            /* also considers SLB entry 0 */
> +            starting_entry = 0;
> +            break;
> +
> +        case 0x5:
> +            /* treat undefined values as ih==0, and warn */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "slbia undefined IH field %u.\n", ih);
> +            break;
> +
> +        default:
> +            /* 0,1,2,6 */
> +            break;
>          }
>      }
> 
> -    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
> +    for (n = starting_entry; n < cpu->hash64_opts->slb_size; n++) {
> +        ppc_slb_t *slb = &env->slb[n];
> +
> +        if (!(slb->esid & SLB_ESID_V)) {
> +            continue;
> +        }
> +        if (env->mmu_model == POWERPC_MMU_3_00) {
> +            if (ih == 0x3 && (slb->vsid & SLB_VSID_C) == 0) {
> +                /* preserves entries with a class value of 0 */
> +                continue;
> +            }
> +        }
> +
> +        slb->esid &= ~SLB_ESID_V;
> +    }
>  }
> 
>  static void __helper_slbie(CPUPPCState *env, target_ulong addr,
> @@ -136,6 +178,7 @@ static void __helper_slbie(CPUPPCState *env, target_ulong addr,
>          return;
>      }
> 
> +    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
>      if (slb->esid & SLB_ESID_V) {
>          slb->esid &= ~SLB_ESID_V;
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index eb0ddba850..e514732a09 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -5027,12 +5027,15 @@ static void gen_tlbsync(DisasContext *ctx)
>  /* slbia */
>  static void gen_slbia(DisasContext *ctx)
>  {
> +    uint32_t ih = (ctx->opcode >> 21) & 0x7;
> +    TCGv_i32 t0 = tcg_const_i32(ih);
> +
>  #if defined(CONFIG_USER_ONLY)
>      GEN_PRIV;
>  #else
>      CHK_SV;
> 
> -    gen_helper_slbia(cpu_env);
> +    gen_helper_slbia(cpu_env, t0);
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> 


