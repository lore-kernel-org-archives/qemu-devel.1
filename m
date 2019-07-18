Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF5C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7132173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7132173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3Q3-0000k0-Kp
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55070)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1ho3Pr-0000E3-Is
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ho3Pq-0005Dz-3x
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:13:35 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:41438)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ho3Pp-0005Cg-Oc
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:13:34 -0400
Received: from player698.ha.ovh.net (unknown [10.109.160.62])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id AFA3C13CD65
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 12:13:30 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 041F980DAEF8;
 Thu, 18 Jul 2019 10:13:23 +0000 (UTC)
Date: Thu, 18 Jul 2019 12:13:22 +0200
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190718121322.663cb5ec@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190718034214.14948-2-npiggin@gmail.com>
References: <20190718034214.14948-1-npiggin@gmail.com>
 <20190718034214.14948-2-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5064860734042315203
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.219
Subject: Re: [Qemu-devel] [PATCH v6 1/4] spapr: Implement dispatch tracking
 for tcg
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

On Thu, 18 Jul 2019 13:42:11 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Implement cpu_exec_enter/exit on ppc which calls into new methods of
> the same name in PPCVirtualHypervisorClass. These are used by spapr
> to implement the splpar VPA dispatch counter initially.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Changes since v5:
> - Move 'prod' into next patch.
> - Use uint32_t type for dispatch counter.
> - Add guest error message for incorrect dispatch counter.
> - Conditionally compile away if CONFIG_USER_ONLY
> - Small cleanups
> 
> Changes since v4:
> - Store to VPA on the way out as well.
> - Increment the dispatch counter directly in the VPA, which means it will
>   migrate with guest memory the same as KVM.
> - Prod need not be migrated, add a comment.
> 
>  hw/ppc/spapr.c                  | 52 +++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_hcall.c            |  5 ----
>  include/hw/ppc/spapr.h          |  7 +++++
>  target/ppc/cpu.h                |  4 +++
>  target/ppc/translate_init.inc.c | 27 +++++++++++++++++
>  5 files changed, 90 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 821f0d4a49..3e5678d467 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4302,6 +4302,54 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
>      return NULL;
>  }
>  
> +#ifndef CONFIG_USER_ONLY

This file is for system emulation only, no need to guard here.

This is minor and rest looks good.

Reviewed-by: Greg Kurz <groug@kaod.org>

> +static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
> +{
> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    /* These are only called by TCG, KVM maintains dispatch state */
> +
> +    if (spapr_cpu->vpa_addr) {
> +        CPUState *cs = CPU(cpu);
> +        uint32_t dispatch;
> +
> +        dispatch = ldl_be_phys(cs->as,
> +                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
> +        dispatch++;
> +        if ((dispatch & 1) != 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "VPA: incorrect dispatch counter value for "
> +                          "dispatched partition %u, correcting.\n", dispatch);
> +            dispatch++;
> +        }
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
> +        uint32_t dispatch;
> +
> +        dispatch = ldl_be_phys(cs->as,
> +                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
> +        dispatch++;
> +        if ((dispatch & 1) != 1) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "VPA: incorrect dispatch counter value for "
> +                          "preempted partition %u, correcting.\n", dispatch);
> +            dispatch++;
> +        }
> +        stl_be_phys(cs->as,
> +                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
> +    }
> +}
> +#endif
> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -4358,6 +4406,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      vhc->hpte_set_r = spapr_hpte_set_r;
>      vhc->get_pate = spapr_get_pate;
>      vhc->encode_hpt_for_kvm_pr = spapr_encode_hpt_for_kvm_pr;
> +#ifndef CONFIG_USER_ONLY
> +    vhc->cpu_exec_enter = spapr_cpu_exec_enter;
> +    vhc->cpu_exec_exit = spapr_cpu_exec_exit;
> +#endif
>      xic->ics_get = spapr_ics_get;
>      xic->ics_resend = spapr_ics_resend;
>      xic->icp_get = spapr_icp_get;
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
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2a5c..9e8fd3c621 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1224,6 +1224,10 @@ struct PPCVirtualHypervisorClass {
>      void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t pte1);
>      void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
>      target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
> +#ifndef CONFIG_USER_ONLY
> +    void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> +    void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> +#endif
>  };
>  
>  #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 86fc8f2e31..bae4820503 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10471,6 +10471,28 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
>  
>      return !msr_le;
>  }
> +
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
>  #endif
>  
>  static void ppc_cpu_instance_init(Object *obj)
> @@ -10624,6 +10646,11 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>      cc->tcg_initialize = ppc_translate_init;
>      cc->tlb_fill = ppc_cpu_tlb_fill;
>  #endif
> +#ifndef CONFIG_USER_ONLY
> +    cc->cpu_exec_enter = ppc_cpu_exec_enter;
> +    cc->cpu_exec_exit = ppc_cpu_exec_exit;
> +#endif
> +
>      cc->disas_set_info = ppc_disas_set_info;
>  
>      dc->fw_name = "PowerPC,UNKNOWN";


