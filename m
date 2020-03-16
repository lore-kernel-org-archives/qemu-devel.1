Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46568C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABE5206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABE5206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuwy-0006fE-5q
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jDu23-0003C1-Ny
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jDu21-0002Jf-Gi
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:00:07 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:56152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jDu21-00024R-8h
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:00:05 -0400
Received: from player730.ha.ovh.net (unknown [10.108.54.217])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id F0E03157014
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 19:00:02 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id C48C810553AF1;
 Mon, 16 Mar 2020 17:59:55 +0000 (UTC)
Subject: Re: [PATCH v2 4/8] ppc/spapr: Fix FWNMI machine check interrupt
 delivery
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-5-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2ff9bfbf-5a6a-2a79-e14e-4b7c76aff062@kaod.org>
Date: Mon, 16 Mar 2020 18:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316142613.121089-5-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13736541813535575014
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 3:26 PM, Nicholas Piggin wrote:
> FWNMI machine check delivery misses a few things that will make it fail
> with TCG at least (which we would like to allow in future to improve
> testing).

I don't understand which issues are addressed in the patch.

> It's not nice to scatter interrupt delivery logic around the tree, so
> move it to excp_helper.c and share code where possible.

It looks correct but this is touching the ugliest routine in the QEMU 
PPC universe. I would split the patch in two to introduce the helper
powerpc_set_excp_state().

It does not seem to need to be an inline also.

C. 

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr_events.c    | 24 +++----------
>  target/ppc/cpu.h         |  1 +
>  target/ppc/excp_helper.c | 74 ++++++++++++++++++++++++++++------------
>  3 files changed, 57 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 27ba8a2c19..323fcef4aa 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -785,28 +785,13 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
>  static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> -    uint64_t rtas_addr;
> +    CPUState *cs = CPU(cpu);
>      CPUPPCState *env = &cpu->env;
> -    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> -    target_ulong msr = 0;
> +    uint64_t rtas_addr;
>      struct rtas_error_log log;
>      struct mc_extended_log *ext_elog;
>      uint32_t summary;
>  
> -    /*
> -     * Properly set bits in MSR before we invoke the handler.
> -     * SRR0/1, DAR and DSISR are properly set by KVM
> -     */
> -    if (!(*pcc->interrupts_big_endian)(cpu)) {
> -        msr |= (1ULL << MSR_LE);
> -    }
> -
> -    if (env->msr & (1ULL << MSR_SF)) {
> -        msr |= (1ULL << MSR_SF);
> -    }
> -
> -    msr |= (1ULL << MSR_ME);
> -
>      ext_elog = g_malloc0(sizeof(*ext_elog));
>      summary = spapr_mce_get_elog_type(cpu, recovered, ext_elog);
>  
> @@ -834,12 +819,11 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>      cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
>                                sizeof(env->gpr[3]) + sizeof(log), ext_elog,
>                                sizeof(*ext_elog));
> +    g_free(ext_elog);
>  
>      env->gpr[3] = rtas_addr + RTAS_ERROR_LOG_OFFSET;
> -    env->msr = msr;
> -    env->nip = spapr->fwnmi_machine_check_addr;
>  
> -    g_free(ext_elog);
> +    ppc_cpu_do_fwnmi_machine_check(cs, spapr->fwnmi_machine_check_addr);
>  }
>  
>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 5a55fb02bd..3953680534 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1221,6 +1221,7 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  #ifndef CONFIG_USER_ONLY
>  void ppc_cpu_do_system_reset(CPUState *cs);
> +void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
>  extern const VMStateDescription vmstate_ppc_cpu;
>  #endif
>  
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 027f54c0ed..7f2b5899d3 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -128,6 +128,37 @@ static uint64_t ppc_excp_vector_offset(CPUState *cs, int ail)
>      return offset;
>  }
>  
> +static inline void powerpc_set_excp_state(PowerPCCPU *cpu,
> +                                          target_ulong vector, target_ulong msr)
> +{
> +    CPUState *cs = CPU(cpu);
> +    CPUPPCState *env = &cpu->env;
> +
> +    /*
> +     * We don't use hreg_store_msr here as already have treated any
> +     * special case that could occur. Just store MSR and update hflags
> +     *
> +     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
> +     * will prevent setting of the HV bit which some exceptions might need
> +     * to do.
> +     */
> +    env->msr = msr & env->msr_mask;
> +    hreg_compute_hflags(env);
> +    env->nip = vector;
> +    /* Reset exception state */
> +    cs->exception_index = POWERPC_EXCP_NONE;
> +    env->error_code = 0;
> +
> +    /* Reset the reservation */
> +    env->reserve_addr = -1;
> +
> +    /*
> +     * Any interrupt is context synchronizing, check if TCG TLB needs
> +     * a delayed flush on ppc64
> +     */
> +    check_tlb_flush(env, false);
> +}
> +
>  /*
>   * Note that this function should be greatly optimized when called
>   * with a constant excp, from ppc_hw_interrupt
> @@ -768,29 +799,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
>          }
>      }
>  #endif
> -    /*
> -     * We don't use hreg_store_msr here as already have treated any
> -     * special case that could occur. Just store MSR and update hflags
> -     *
> -     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
> -     * will prevent setting of the HV bit which some exceptions might need
> -     * to do.
> -     */
> -    env->msr = new_msr & env->msr_mask;
> -    hreg_compute_hflags(env);
> -    env->nip = vector;
> -    /* Reset exception state */
> -    cs->exception_index = POWERPC_EXCP_NONE;
> -    env->error_code = 0;
>  
> -    /* Reset the reservation */
> -    env->reserve_addr = -1;
> -
> -    /*
> -     * Any interrupt is context synchronizing, check if TCG TLB needs
> -     * a delayed flush on ppc64
> -     */
> -    check_tlb_flush(env, false);
> +    powerpc_set_excp_state(cpu, vector, new_msr);
>  }
>  
>  void ppc_cpu_do_interrupt(CPUState *cs)
> @@ -958,6 +968,26 @@ void ppc_cpu_do_system_reset(CPUState *cs)
>  
>      powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
>  }
> +
> +void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +    target_ulong msr = 0;
> +
> +    /*
> +     * Set MSR and NIP for the handler, SRR0/1, DAR and DSISR have already
> +     * been set by KVM.
> +     */
> +    msr = (1ULL << MSR_ME);
> +    msr |= env->msr & (1ULL << MSR_SF);
> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
> +        msr |= (1ULL << MSR_LE);
> +    }
> +
> +    powerpc_set_excp_state(cpu, vector, msr);
> +}
>  #endif /* !CONFIG_USER_ONLY */
>  
>  bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> 


