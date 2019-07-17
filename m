Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2BCC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 15:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824952173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 15:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824952173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnlsA-0008KF-Cf
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 11:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59280)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hnlrw-0007n4-Oa
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hnlru-0006zG-I9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:29:24 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:53964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hnlru-0006ww-4G
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:29:22 -0400
Received: from player696.ha.ovh.net (unknown [10.109.143.220])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 45C0413C84F
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 17:29:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id 2F26F81E25A4;
 Wed, 17 Jul 2019 15:29:12 +0000 (UTC)
Date: Wed, 17 Jul 2019 17:29:10 +0200
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190717172910.426f3d22@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190717053952.13729-2-npiggin@gmail.com>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-2-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4525273202813671875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieefgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.41.146
Subject: Re: [Qemu-devel] [PATCH v5 1/4] spapr: Implement VPA dispatch
 counter and prod bit on tcg
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
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jul 2019 15:39:49 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Implement cpu_exec_enter/exit on ppc which calls into new methods of
> the same name in PPCVirtualHypervisorClass. These are used by spapr
> to implement these splpar elements, used in subsequent changes.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Changes since v4:
> - Store to VPA on the way out as well.
> - Increment the dispatch counter directly in the VPA, which means it will
>   migrate with guest memory the same as KVM.
> - Prod need not be migrated, add a comment.
> 
>  hw/ppc/spapr.c                  | 41 +++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c         |  4 +++-
>  hw/ppc/spapr_hcall.c            |  5 ----
>  include/hw/ppc/spapr.h          |  7 ++++++
>  include/hw/ppc/spapr_cpu_core.h |  1 +
>  target/ppc/cpu.h                |  2 ++
>  target/ppc/translate_init.inc.c | 25 ++++++++++++++++++++
>  7 files changed, 79 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 821f0d4a49..13c423347e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4302,6 +4302,45 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
>      return NULL;
>  }
>  
> +static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
> +{
> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    /* These are only called by TCG, KVM maintains dispatch state */
> +
> +    spapr_cpu->prod = false;
> +    if (spapr_cpu->vpa_addr) {
> +        CPUState *cs = CPU(cpu);
> +        unsigned int dispatch;
> +
> +        dispatch = ldl_be_phys(cs->as,
> +                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
> +        dispatch++;
> +        if ((dispatch & 1) != 0) /* guest set the "wrong" value */
> +            dispatch++;
> +        stl_be_phys(cs->as,
> +                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
> +    }
> +}
> +
> +static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
> +{
> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    if (spapr_cpu->vpa_addr) {
> +        CPUState *cs = CPU(cpu);
> +        unsigned int dispatch;
> +
> +        dispatch = ldl_be_phys(cs->as,
> +                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
> +        dispatch++;
> +        if ((dispatch & 1) != 1) /* guest set the "wrong" value */
> +            dispatch++;
> +        stl_be_phys(cs->as,
> +                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
> +    }
> +}
> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -4358,6 +4397,8 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      vhc->hpte_set_r = spapr_hpte_set_r;
>      vhc->get_pate = spapr_get_pate;
>      vhc->encode_hpt_for_kvm_pr = spapr_encode_hpt_for_kvm_pr;
> +    vhc->cpu_exec_enter = spapr_cpu_exec_enter;
> +    vhc->cpu_exec_exit = spapr_cpu_exec_exit;
>      xic->ics_get = spapr_ics_get;
>      xic->ics_resend = spapr_ics_resend;
>      xic->icp_get = spapr_icp_get;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 5621fb9a3d..54abf5308c 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -261,6 +261,7 @@ error:
>  static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
>  {
>      SpaprCpuCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(sc);
> +    SpaprCpuState *spapr_cpu;
>      CPUCore *cc = CPU_CORE(sc);
>      Object *obj;
>      char *id;
> @@ -287,7 +288,8 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
>          goto err;
>      }
>  
> -    cpu->machine_data = g_new0(SpaprCpuState, 1);
> +    spapr_cpu = g_new0(SpaprCpuState, 1);
> +    cpu->machine_data = spapr_cpu;

What's the purpose of this change since there's no other
user of spapr_cpu in this function ?

>  
>      object_unref(obj);
>      return cpu;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6808d4cda8..e615881ac4 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -874,11 +874,6 @@ unmap_out:
>  #define FLAGS_DEREGISTER_DTL       0x0000c00000000000ULL
>  #define FLAGS_DEREGISTER_SLBSHADOW 0x0000e00000000000ULL
>  
> -#define VPA_MIN_SIZE           640
> -#define VPA_SIZE_OFFSET        0x4
> -#define VPA_SHARED_PROC_OFFSET 0x9
> -#define VPA_SHARED_PROC_VAL    0x2
> -
>  static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
>  {
>      CPUState *cs = CPU(cpu);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 60553d32c4..5d36eec9d0 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -525,6 +525,13 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
>  target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>                               target_ulong *args);
>  
> +/* Virtual Processor Area structure constants */
> +#define VPA_MIN_SIZE           640
> +#define VPA_SIZE_OFFSET        0x4
> +#define VPA_SHARED_PROC_OFFSET 0x9
> +#define VPA_SHARED_PROC_VAL    0x2
> +#define VPA_DISPATCH_COUNTER   0x100
> +
>  /* ibm,set-eeh-option */
>  #define RTAS_EEH_DISABLE                 0
>  #define RTAS_EEH_ENABLE                  1
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index f9645a7290..a40cd08ea0 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -46,6 +46,7 @@ typedef struct SpaprCpuState {
>      uint64_t vpa_addr;
>      uint64_t slb_shadow_addr, slb_shadow_size;
>      uint64_t dtl_addr, dtl_size;
> +    bool prod; /* not migrated, only used to improve dispatch latencies */
>      struct ICPState *icp;
>      struct XiveTCTX *tctx;
>  } SpaprCpuState;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2a5c..78d6504acb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1224,6 +1224,8 @@ struct PPCVirtualHypervisorClass {
>      void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t pte1);
>      void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
>      target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
> +    void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> +    void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
>  };
>  
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 86fc8f2e31..58d4a93b23 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10473,6 +10473,28 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
>  }
>  #endif
>  
> +static void ppc_cpu_exec_enter(CPUState *cs)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->cpu_exec_enter(cpu->vhyp, cpu);
> +    }
> +}
> +
> +static void ppc_cpu_exec_exit(CPUState *cs)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        vhc->cpu_exec_exit(cpu->vhyp, cpu);
> +    }
> +}
> +
>  static void ppc_cpu_instance_init(Object *obj)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(obj);
> @@ -10624,6 +10646,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>      cc->tcg_initialize = ppc_translate_init;
>      cc->tlb_fill = ppc_cpu_tlb_fill;
>  #endif
> +    cc->cpu_exec_enter = ppc_cpu_exec_enter;
> +    cc->cpu_exec_exit = ppc_cpu_exec_exit;
> +

This code only makes sense with system emulation. I guess it
should be guarded with !defined(CONFIG_USER_ONLY).

>      cc->disas_set_info = ppc_disas_set_info;
>  
>      dc->fw_name = "PowerPC,UNKNOWN";


