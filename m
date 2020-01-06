Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C932FC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA1F20848
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA1F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioOy4-0002GI-Oy
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 04:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioOxK-0001fh-3x
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioOxI-000502-AE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:45:49 -0500
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:35583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioOxI-0004yb-3j
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:45:48 -0500
Received: from player799.ha.ovh.net (unknown [10.108.42.184])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id E43748AD81
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 10:45:44 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 84B8DDE65821;
 Mon,  6 Jan 2020 09:45:35 +0000 (UTC)
Date: Mon, 6 Jan 2020 10:45:33 +0100
From: Greg Kurz <groug@kaod.org>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v18 3/7] target/ppc: Handle NMI guest exit
Message-ID: <20200106104533.28569d42@bahia.lan>
In-Reply-To: <20200102075111.25308-4-ganeshgr@linux.ibm.com>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-4-ganeshgr@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 128352591561857298
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepshhpihhnihgtshdrnhgvthenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.91
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  2 Jan 2020 13:21:07 +0530
Ganesh Goudar <ganeshgr@linux.ibm.com> wrote:

> From: Aravinda Prasad <arawinda.p@gmail.com>
> 
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
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---

Missing S-o-b.

>  hw/ppc/spapr.c          |  8 ++++++++
>  hw/ppc/spapr_events.c   | 37 +++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h  | 10 ++++++++++
>  target/ppc/kvm.c        | 14 ++++++++++++++
>  target/ppc/kvm_ppc.h    |  2 ++
>  target/ppc/trace-events |  1 +
>  6 files changed, 72 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c91e64aad0..975d7da734 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1679,6 +1679,12 @@ static void spapr_machine_reset(MachineState *machine)
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
> @@ -2973,6 +2979,8 @@ static void spapr_machine_init(MachineState *machine)
>  
>          kvmppc_spapr_enable_inkernel_multitce();
>      }
> +
> +    qemu_cond_init(&spapr->mc_delivery_cond);
>  }
>  
>  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index e355e000d0..dfc0de840a 100644
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
> @@ -622,6 +623,42 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>  }
>  
> +void spapr_mce_req_event(PowerPCCPU *cpu)
> +{
> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +    CPUState *cs = CPU(cpu);
> +
> +    if (spapr->guest_machine_check_addr == -1) {
> +        /*
> +         * This implies that we have hit a machine check either when the
> +         * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
> +         * called) or between system reset and "ibm,nmi-register".
> +         * Fall back to the old machine check behavior in such cases.
> +         */
> +        cs->exception_index = POWERPC_EXCP_MCHECK;
> +        ppc_cpu_do_interrupt(cs);
> +        return;
> +    }
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
> index 7bc5fc3a9e..909d3976f9 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -191,6 +191,15 @@ struct SpaprMachineState {
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
> @@ -804,6 +813,7 @@ void spapr_clear_pending_events(SpaprMachineState *spapr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
> +void spapr_mce_req_event(PowerPCCPU *cpu);
>  
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 518de7e4b7..2aebb44e2f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1708,6 +1708,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
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
> @@ -2803,6 +2808,15 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
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
> index eedb15d48e..bd2a0edf43 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -83,6 +83,8 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
>  void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
>  
> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
> +
>  #else
>  
>  static inline uint32_t kvmppc_get_tbfreq(void)
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index 3dc6740706..6d15aa90b4 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -28,3 +28,4 @@ kvm_handle_papr_hcall(void) "handle PAPR hypercall"
>  kvm_handle_epr(void) "handle epr"
>  kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
>  kvm_handle_debug_exception(void) "handle debug exception"
> +kvm_handle_nmi_exception(void) "handle NMI exception"


