Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EADC3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D188122DBF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D188122DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i53nL-0000Am-S8
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i53mM-00084E-3g
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i53mJ-0005rU-FU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:03:05 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:36879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i53mI-0005q5-DV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:03:02 -0400
Received: from player792.ha.ovh.net (unknown [10.109.146.20])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 65FCD140FD2
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 10:02:59 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id E01A3972A159;
 Tue,  3 Sep 2019 08:02:51 +0000 (UTC)
Date: Tue, 3 Sep 2019 10:02:50 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190903100250.2132e844@bahia.lan>
In-Reply-To: <156715643020.27761.6478380064885992450.stgit@aravinda>
References: <156715632966.27761.8190459106519248668.stgit@aravinda>
 <156715643020.27761.6478380064885992450.stgit@aravinda>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2176083047547771284
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejuddguddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.175
Subject: Re: [Qemu-devel] [PATCH v12 3/6] target/ppc: Handle NMI guest exit
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

On Fri, 30 Aug 2019 14:43:50 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> Memory error such as bit flips that cannot be corrected
> by hardware are passed on to the kernel for handling.
> If the memory address in error belongs to guest then
> the guest kernel is responsible for taking suitable action.
> Patch [1] enhances KVM to exit guest with exit reason
> set to KVM_EXIT_NMI in such cases. This patch handles
> KVM_EXIT_NMI exit.
> 
> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
>     (e20bbd3d and related commits)
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c          |    8 ++++++++
>  hw/ppc/spapr_events.c   |   24 ++++++++++++++++++++++++
>  include/hw/ppc/spapr.h  |   10 ++++++++++
>  target/ppc/kvm.c        |   14 ++++++++++++++
>  target/ppc/kvm_ppc.h    |    2 ++
>  target/ppc/trace-events |    1 +
>  6 files changed, 59 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8288e8b..76ed988 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1823,6 +1823,12 @@ static void spapr_machine_reset(MachineState *machine)
>      first_ppc_cpu->env.gpr[5] = 0;
>  
>      spapr->cas_reboot = false;
> +
> +    spapr->mc_status = -1;
> +    spapr->guest_machine_check_addr = -1;
> +
> +    /* Signal all vCPUs waiting on this condition */
> +    qemu_cond_broadcast(&spapr->mc_delivery_cond);
>  }
>  
>  static void spapr_create_nvram(SpaprMachineState *spapr)
> @@ -3099,6 +3105,8 @@ static void spapr_machine_init(MachineState *machine)
>  
>          kvmppc_spapr_enable_inkernel_multitce();
>      }
> +
> +    qemu_cond_init(&spapr->mc_delivery_cond);
>  }
>  
>  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 0e4c195..e76c1a7 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -40,6 +40,7 @@
>  #include "hw/ppc/spapr_drc.h"
>  #include "qemu/help_option.h"
>  #include "qemu/bcd.h"
> +#include "qemu/main-loop.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include <libfdt.h>
>  
> @@ -621,6 +622,29 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>  }
>  
> +void spapr_mce_req_event(PowerPCCPU *cpu)
> +{
> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +
> +    while (spapr->mc_status != -1) {
> +        /*
> +         * Check whether the same CPU got machine check error
> +         * while still handling the mc error (i.e., before
> +         * that CPU called "ibm,nmi-interlock")
> +         */
> +        if (spapr->mc_status == cpu->vcpu_id) {
> +            qemu_system_guest_panicked(NULL);
> +            return;
> +        }
> +        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
> +        /* Meanwhile if the system is reset, then just return */
> +        if (spapr->guest_machine_check_addr == -1) {
> +            return;
> +        }
> +    }
> +    spapr->mc_status = cpu->vcpu_id;
> +}
> +
>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                              uint32_t token, uint32_t nargs,
>                              target_ulong args,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 66049ac..99a2966 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -192,6 +192,15 @@ struct SpaprMachineState {
>       * occurs during the unplug process. */
>      QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
>  
> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
> +    target_ulong guest_machine_check_addr;
> +    /*
> +     * mc_status is set to -1 if mc is not in progress, else is set to the CPU
> +     * handling the mc.
> +     */
> +    int mc_status;
> +    QemuCond mc_delivery_cond;
> +
>      /*< public >*/
>      char *kvm_type;
>      char *host_model;
> @@ -805,6 +814,7 @@ void spapr_clear_pending_events(SpaprMachineState *spapr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
> +void spapr_mce_req_event(PowerPCCPU *cpu);
>  
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c055fc1..4e282f6 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1704,6 +1704,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>          ret = 0;
>          break;
>  
> +    case KVM_EXIT_NMI:
> +        trace_kvm_handle_nmi_exception();
> +        ret = kvm_handle_nmi(cpu, run);
> +        break;
> +
>      default:
>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
>          ret = -1;
> @@ -2807,6 +2812,15 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>      return data & 0xffff;
>  }
>  
> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
> +{
> +    cpu_synchronize_state(CPU(cpu));
> +
> +    spapr_mce_req_event(cpu);
> +
> +    return 0;
> +}
> +
>  int kvmppc_enable_hwrng(void)
>  {
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HWRNG)) {
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 2990898..173c000 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -84,6 +84,8 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
>  void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
>  
> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
> +
>  #else
>  
>  static inline uint32_t kvmppc_get_tbfreq(void)
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index 3dc6740..6d15aa9 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -28,3 +28,4 @@ kvm_handle_papr_hcall(void) "handle PAPR hypercall"
>  kvm_handle_epr(void) "handle epr"
>  kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
>  kvm_handle_debug_exception(void) "handle debug exception"
> +kvm_handle_nmi_exception(void) "handle NMI exception"
> 


