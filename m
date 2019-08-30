Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4774C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E60208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E60208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3hj2-0002xN-SA
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 10:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i3hQs-0002dY-7v
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i3hQo-0006s5-AE
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:59:16 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:54522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i3hQn-0006m6-5f
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:59:13 -0400
Received: from player761.ha.ovh.net (unknown [10.108.35.110])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id CC5E2249BFD
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 15:59:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id 0D6DA94A3560;
 Fri, 30 Aug 2019 13:58:59 +0000 (UTC)
Date: Fri, 30 Aug 2019 15:58:56 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190830155856.6b4ede14@bahia.lan>
In-Reply-To: <156715642090.27761.17328167484986424722.stgit@aravinda>
References: <156715632966.27761.8190459106519248668.stgit@aravinda>
 <156715642090.27761.17328167484986424722.stgit@aravinda>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3146327290464410004
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigedgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.116.78
Subject: Re: [Qemu-devel] [PATCH v12 2/6] ppc: spapr: Introduce FWNMI
 capability
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Aug 2019 14:43:40 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
> the KVM causes guest exit with NMI as exit reason
> when it encounters a machine check exception on the
> address belonging to a guest. Without this capability
> enabled, KVM redirects machine check exceptions to
> guest's 0x200 vector.
> 
> This patch also introduces fwnmi-mce capability to
> deal with the case when a guest with the
> KVM_CAP_PPC_FWNMI capability enabled is attempted
> to migrate to a host that does not support this
> capability.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |    1 +
>  hw/ppc/spapr_caps.c    |   29 +++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |    4 +++-
>  target/ppc/kvm.c       |   22 ++++++++++++++++++++++
>  target/ppc/kvm_ppc.h   |   11 +++++++++++
>  5 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ea56499..8288e8b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4487,6 +4487,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 481dfd2..c11ff87 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -496,6 +496,25 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>      }
>  }
>  
> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
> +                                Error **errp)
> +{
> +    if (!val) {
> +        return; /* Disabled by default */
> +    }
> +
> +    if (tcg_enabled()) {
> +        /*
> +         * TCG support may not be correct in some conditions (e.g., in case
> +         * of software injected faults like duplicate SLBs).
> +         */
> +        warn_report("Firmware Assisted Non-Maskable Interrupts not supported in TCG");
> +    } else if (kvm_enabled() && !kvmppc_has_cap_ppc_fwnmi()) {
> +        error_setg(errp,
> +"Firmware Assisted Non-Maskable Interrupts not supported by KVM, try cap-fwnmi-mce=off");
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>      [SPAPR_CAP_HTM] = {
>          .name = "htm",
> @@ -595,6 +614,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .type = "bool",
>          .apply = cap_ccf_assist_apply,
>      },
> +    [SPAPR_CAP_FWNMI_MCE] = {
> +        .name = "fwnmi-mce",
> +        .description = "Handle fwnmi machine check exceptions",
> +        .index = SPAPR_CAP_FWNMI_MCE,
> +        .get = spapr_cap_get_bool,
> +        .set = spapr_cap_set_bool,
> +        .type = "bool",
> +        .apply = cap_fwnmi_mce_apply,
> +    },
>  };
>  
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
> @@ -734,6 +762,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
>  
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 03111fd..66049ac 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -79,8 +79,10 @@ typedef enum {
>  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
>  /* Count Cache Flush Assist HW Instruction */
>  #define SPAPR_CAP_CCF_ASSIST            0x09
> +/* FWNMI machine check handling */
> +#define SPAPR_CAP_FWNMI_MCE             0x0A
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
>  
>  /*
>   * Capability Values
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8c5b1f2..c055fc1 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -85,6 +85,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_ppc_fwnmi;
>  
>  static uint32_t debug_inst_opcode;
>  
> @@ -2055,6 +2056,22 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>      }
>  }
>  
> +int kvmppc_set_fwnmi(void)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> +    CPUState *cs = CPU(cpu);
> +    int ret;
> +
> +    ret = kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> +    if (ret) {
> +        error_report("This KVM version does not support FWNMI");
> +        return ret;
> +    }
> +
> +    cap_ppc_fwnmi = 1;

Hmm... AFAICT the meaning of cap_ppc_fwnmi should just be "KVM knows about
FWNMI", not "FWNMI was successfully enabled in KVM". Your v10 used to set
cap_ppc_fwnmi in kvm_arch_init() just like the other guys... why this change ?

> +    return ret;
> +}
> +
>  int kvmppc_smt_threads(void)
>  {
>      return cap_ppc_smt ? cap_ppc_smt : 1;
> @@ -2355,6 +2372,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
>      return cap_mmu_hash_v3;
>  }
>  
> +bool kvmppc_has_cap_ppc_fwnmi(void)
> +{
> +    return cap_ppc_fwnmi;
> +}
> +
>  static bool kvmppc_power8_host(void)
>  {
>      bool ret = false;
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5..2990898 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,8 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +int kvmppc_set_fwnmi(void);
> +bool kvmppc_has_cap_ppc_fwnmi(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_hint_smt_possible(Error **errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -159,6 +161,15 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>  {
>  }
>  
> +static inline int kvmppc_set_fwnmi(void)
> +{

Missing return -1;

> +}
> +
> +static inline bool kvmppc_has_cap_ppc_fwnmi(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_smt_threads(void)
>  {
>      return 1;
> 


