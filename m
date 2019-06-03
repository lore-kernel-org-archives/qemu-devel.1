Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81407C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4771527800
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4771527800
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXowU-0006VE-Ht
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:32:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXoqV-00029Y-AF
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXoqS-00009V-8I
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:25:59 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:51563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hXoqS-00005w-1m
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:25:56 -0400
Received: from player794.ha.ovh.net (unknown [10.108.42.196])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 354A01F05F9
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 17:25:52 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player794.ha.ovh.net (Postfix) with ESMTPSA id AD64466B4F32;
	Mon,  3 Jun 2019 15:25:45 +0000 (UTC)
Date: Mon, 3 Jun 2019 17:25:44 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190603172544.277d0183@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <155910844950.13149.6460514692958589700.stgit@aravinda>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910844950.13149.6460514692958589700.stgit@aravinda>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4323455645378582932
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefjedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.109
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 5/6] ppc: spapr: Enable FWNMI
 capability
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 11:10:49 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
> the KVM causes guest exit with NMI as exit reason
> when it encounters a machine check exception on the
> address belonging to a guest. Without this capability
> enabled, KVM redirects machine check exceptions to
> guest's 0x200 vector.
> 
> This patch also deals with the case when a guest with
> the KVM_CAP_PPC_FWNMI capability enabled is attempted
> to migrate to a host that does not support this
> capability.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---

As suggested in another mail, it may be worth introducing the sPAPR cap
in its own patch, earlier in the series.

Anyway, I have some comments below.

>  hw/ppc/spapr.c         |    1 +
>  hw/ppc/spapr_caps.c    |   24 ++++++++++++++++++++++++
>  hw/ppc/spapr_rtas.c    |   18 ++++++++++++++++++
>  include/hw/ppc/spapr.h |    4 +++-
>  target/ppc/kvm.c       |   19 +++++++++++++++++++
>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
>  6 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c97f6a6..e8a77636 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4364,6 +4364,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 31b4661..ef9e612 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -479,6 +479,20 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
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
> +            error_setg(errp, "No fwnmi support in TCG, try cap-fwnmi-mce=off");

Maybe expand "fwnmi" to "Firmware Assisted Non-Maskable Interrupts" ?

> +    } else if (kvm_enabled() && !kvmppc_has_cap_ppc_fwnmi()) {
> +            error_setg(errp, "Requested fwnmi capability not support by KVM");

Maybe reword and add a hint:

"KVM implementation does not support Firmware Assisted Non-Maskable Interrupts, try cap-fwnmi-mce=off"


> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>      [SPAPR_CAP_HTM] = {
>          .name = "htm",
> @@ -578,6 +592,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
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
> @@ -717,6 +740,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
>  
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index e0bdfc8..91a7ab9 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -49,6 +49,7 @@
>  #include "hw/ppc/fdt.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "target/ppc/mmu-book3s-v3.h"
> +#include "kvm_ppc.h"
>  
>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                                     uint32_t token, uint32_t nargs,
> @@ -358,6 +359,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>                                    target_ulong args,
>                                    uint32_t nret, target_ulong rets)
>  {
> +    int ret;
>      hwaddr rtas_addr = spapr_get_rtas_addr();
>  
>      if (!rtas_addr) {
> @@ -365,6 +367,22 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>          return;
>      }
>  
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == 0) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    ret = kvmppc_fwnmi_enable(cpu);
> +    if (ret == 1) {

I have the impression that this should really not happen,
otherwise something has gone terribly wrong in QEMU or
in KVM... this maybe deserves an error message as well ?
No big deal.

> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    if (ret < 0) {
> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        return;
> +    }
> +
>      spapr->guest_machine_check_addr = rtas_ld(args, 1);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c717ab2..bd75d4b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -78,8 +78,10 @@ typedef enum {
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
> index 39f1a73..368ec6e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -84,6 +84,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_ppc_fwnmi;
>  
>  static uint32_t debug_inst_opcode;
>  
> @@ -152,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
>      cap_large_decr = kvmppc_get_dec_bits();
> +    cap_ppc_fwnmi = kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2119,6 +2121,18 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>      }
>  }
>  
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> +{
> +    CPUState *cs = CPU(cpu);
> +
> +    if (!cap_ppc_fwnmi) {
> +        return 1;
> +    }
> +
> +    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> +}
> +
> +
>  int kvmppc_smt_threads(void)
>  {
>      return cap_ppc_smt ? cap_ppc_smt : 1;
> @@ -2419,6 +2433,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
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
> index 18693f1..3d9f0b4 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,8 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
> +bool kvmppc_has_cap_ppc_fwnmi(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_hint_smt_possible(Error **errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -160,6 +162,16 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>  {
>  }
>  
> +static inline int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> +{
> +    return 1;
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
> 


