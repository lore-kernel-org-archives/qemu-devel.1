Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F093C4BA14
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4957B24685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4957B24685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6wlo-0005ee-Ft
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6wl2-0004wK-Vf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6wl1-00046A-PQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:29:48 -0500
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:34090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6wl1-00040Z-Ig
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:29:47 -0500
Received: from player714.ha.ovh.net (unknown [10.108.57.49])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6A1C4155DD0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:29:45 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 51524FB8D532;
 Wed, 26 Feb 2020 13:29:29 +0000 (UTC)
Date: Wed, 26 Feb 2020 14:29:27 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 12/18] target/ppc: Don't store VRMA SLBE persistently
Message-ID: <20200226142927.32500832@bahia.home>
In-Reply-To: <20200224233724.46415-13-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-13-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8271142191219710438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeeftdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedugedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.120.239
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
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:18 +1100
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

>  target/ppc/cpu.h        |  3 ---
>  target/ppc/mmu-hash64.c | 28 ++++++----------------------
>  2 files changed, 6 insertions(+), 25 deletions(-)
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
> index ac21c14f68..f8bf92aa2e 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -825,6 +825,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>  {
>      CPUState *cs = CPU(cpu);
>      CPUPPCState *env = &cpu->env;
> +    ppc_slb_t vrma_slbe;
>      ppc_slb_t *slb;
>      unsigned apshift;
>      hwaddr ptex;
> @@ -863,8 +864,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
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
> @@ -1012,6 +1013,7 @@ skip_slb_search:
>  hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
>  {
>      CPUPPCState *env = &cpu->env;
> +    ppc_slb_t vrma_slbe;
>      ppc_slb_t *slb;
>      hwaddr ptex, raddr;
>      ppc_hash_pte64_t pte;
> @@ -1033,8 +1035,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
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
> @@ -1072,30 +1074,12 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
>      cpu->env.tlb_need_flush = TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_FLUSH;
>  }
>  
> -static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env = &cpu->env;
> -    ppc_slb_t *slb = &env->vrma_slb;
> -
> -    /* Is VRMA enabled ? */
> -    if (ppc_hash64_use_vrma(env)) {
> -        if (build_vrma_slbe(cpu, slb) == 0) {
> -            return;
> -        }
> -    }
> -
> -    /* Otherwise, clear it to indicate error */
> -    slb->esid = slb->vsid = 0;
> -    slb->sps = NULL;
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


