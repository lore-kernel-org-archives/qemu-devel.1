Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED140205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED140205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j940I-0000YQ-6B
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 04:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j93zf-0008Oy-2D
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j93zd-0008S0-H7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:37:38 -0500
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:37286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j93zd-0008R3-AQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:37:37 -0500
Received: from player760.ha.ovh.net (unknown [10.110.171.96])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 690E62459A8
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 10:37:34 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id 3A86BFFEA66C;
 Tue,  3 Mar 2020 09:37:12 +0000 (UTC)
Date: Tue, 3 Mar 2020 10:37:07 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v7 11/17] target/ppc: Don't store VRMA SLBE persistently
Message-ID: <20200303103707.2856b74e@bahia.home>
In-Reply-To: <20200303034351.333043-12-david@gibson.dropbear.id.au>
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-12-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2692026679813315046
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, clg@kaod.org, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  3 Mar 2020 14:43:45 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently, we construct the SLBE used for VRMA translations when the LPCR
> is written (which controls some bits in the SLBE), then use it later for
> translations.
> 
> This is a bit complex and confusing - simplify it by simply constructing
> the SLBE directly from the LPCR when we need it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu.h        |  3 --
>  target/ppc/mmu-hash64.c | 92 ++++++++++++++++-------------------------
>  2 files changed, 35 insertions(+), 60 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f9871b1233..5a55fb02bd 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1044,9 +1044,6 @@ struct CPUPPCState {
>      uint32_t flags;
>      uint64_t insns_flags;
>      uint64_t insns_flags2;
> -#if defined(TARGET_PPC64)
> -    ppc_slb_t vrma_slb;
> -#endif
>  
>      int error_code;
>      uint32_t pending_interrupts;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 4fd7b7ee74..34f6009b1e 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -784,11 +784,41 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
>      return rma_sizes[rmls];
>  }
>  
> +static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
> +{
> +    CPUPPCState *env = &cpu->env;
> +    target_ulong lpcr = env->spr[SPR_LPCR];
> +    uint32_t vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> +    target_ulong vsid = SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LLP_MASK);
> +    int i;
> +
> +    for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> +        const PPCHash64SegmentPageSizes *sps = &cpu->hash64_opts->sps[i];
> +
> +        if (!sps->page_shift) {
> +            break;
> +        }
> +
> +        if ((vsid & SLB_VSID_LLP_MASK) == sps->slb_enc) {
> +            slb->esid = SLB_ESID_V;
> +            slb->vsid = vsid;
> +            slb->sps = sps;
> +            return 0;
> +        }
> +    }
> +
> +    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=0x"
> +                 TARGET_FMT_lx"\n", lpcr);
> +
> +    return -1;
> +}
> +
>  int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>                                  int rwx, int mmu_idx)
>  {
>      CPUState *cs = CPU(cpu);
>      CPUPPCState *env = &cpu->env;
> +    ppc_slb_t vrma_slbe;
>      ppc_slb_t *slb;
>      unsigned apshift;
>      hwaddr ptex;
> @@ -827,8 +857,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>              }
>          } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
> -            slb = &env->vrma_slb;
> -            if (!slb->sps) {
> +            slb = &vrma_slbe;
> +            if (build_vrma_slbe(cpu, slb) != 0) {
>                  /* Invalid VRMA setup, machine check */
>                  cs->exception_index = POWERPC_EXCP_MCHECK;
>                  env->error_code = 0;
> @@ -976,6 +1006,7 @@ skip_slb_search:
>  hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
>  {
>      CPUPPCState *env = &cpu->env;
> +    ppc_slb_t vrma_slbe;
>      ppc_slb_t *slb;
>      hwaddr ptex, raddr;
>      ppc_hash_pte64_t pte;
> @@ -997,8 +1028,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
>              return raddr | env->spr[SPR_HRMOR];
>          } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
> -            slb = &env->vrma_slb;
> -            if (!slb->sps) {
> +            slb = &vrma_slbe;
> +            if (build_vrma_slbe(cpu, slb) != 0) {
>                  return -1;
>              }
>          } else {
> @@ -1037,65 +1068,12 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
>      cpu->env.tlb_need_flush = TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_FLUSH;
>  }
>  
> -static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env = &cpu->env;
> -    const PPCHash64SegmentPageSizes *sps = NULL;
> -    target_ulong esid, vsid, lpcr;
> -    ppc_slb_t *slb = &env->vrma_slb;
> -    uint32_t vrmasd;
> -    int i;
> -
> -    /* First clear it */
> -    slb->esid = slb->vsid = 0;
> -    slb->sps = NULL;
> -
> -    /* Is VRMA enabled ? */
> -    if (!ppc_hash64_use_vrma(env)) {
> -        return;
> -    }
> -
> -    /*
> -     * Make one up. Mostly ignore the ESID which will not be needed
> -     * for translation
> -     */
> -    lpcr = env->spr[SPR_LPCR];
> -    vsid = SLB_VSID_VRMA;
> -    vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
> -    vsid |= (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
> -    esid = SLB_ESID_V;
> -
> -    for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> -        const PPCHash64SegmentPageSizes *sps1 = &cpu->hash64_opts->sps[i];
> -
> -        if (!sps1->page_shift) {
> -            break;
> -        }
> -
> -        if ((vsid & SLB_VSID_LLP_MASK) == sps1->slb_enc) {
> -            sps = sps1;
> -            break;
> -        }
> -    }
> -
> -    if (!sps) {
> -        error_report("Bad page size encoding esid 0x"TARGET_FMT_lx
> -                     " vsid 0x"TARGET_FMT_lx, esid, vsid);
> -        return;
> -    }
> -
> -    slb->vsid = vsid;
> -    slb->esid = esid;
> -    slb->sps = sps;
> -}
> -
>  void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>  {
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env = &cpu->env;
>  
>      env->spr[SPR_LPCR] = val & pcc->lpcr_mask;
> -    ppc_hash64_update_vrma(cpu);
>  }
>  
>  void helper_store_lpcr(CPUPPCState *env, target_ulong val)


