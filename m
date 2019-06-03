Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7178C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 11:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05C828165
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 11:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05C828165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33655 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXlXq-0002VA-No
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 07:54:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXlWy-0002Ac-14
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hXlWw-0000f8-CH
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:53:35 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:53429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hXlWw-0000Zz-5v
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 07:53:34 -0400
Received: from player774.ha.ovh.net (unknown [10.108.42.168])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 709EF1F4D40
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 13:53:31 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player774.ha.ovh.net (Postfix) with ESMTPSA id AAEAA668CEDA;
	Mon,  3 Jun 2019 11:53:23 +0000 (UTC)
Date: Mon, 3 Jun 2019 13:53:22 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190603135322.1c69f310@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <155910843201.13149.14968680567084380259.stgit@aravinda>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910843201.13149.14968680567084380259.stgit@aravinda>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 736901491476502932
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefjedggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.41.16
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 3/6] target/ppc: Handle NMI
 guest exit
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

On Wed, 29 May 2019 11:10:32 +0530
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
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c          |    1 +
>  hw/ppc/spapr_events.c   |   23 +++++++++++++++++++++++
>  hw/ppc/spapr_rtas.c     |    5 +++++
>  include/hw/ppc/spapr.h  |    6 ++++++
>  target/ppc/kvm.c        |   16 ++++++++++++++++
>  target/ppc/kvm_ppc.h    |    2 ++
>  target/ppc/trace-events |    1 +
>  7 files changed, 54 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fae28a9..6b6c962 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1809,6 +1809,7 @@ static void spapr_machine_reset(void)
>  
>      spapr->cas_reboot = false;
>  
> +    spapr->mc_status = -1;
>      spapr->guest_machine_check_addr = -1;
>  
>      /* Signal all vCPUs waiting on this condition */
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index ae0f093..a18446b 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -620,6 +620,29 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>  }
>  
> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
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
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index e7509cf..e0bdfc8 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -379,6 +379,11 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>          /* NMI register not called */
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>      } else {
> +        /*
> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> +         * hence unset mc_status.
> +         */
> +        spapr->mc_status = -1;
>          qemu_cond_signal(&spapr->mc_delivery_cond);
>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9dc5e30..fc3a776 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -190,6 +190,11 @@ struct SpaprMachineState {
>  
>      /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
>      target_ulong guest_machine_check_addr;
> +    /*
> +     * mc_status is set to -1 if mc is not in progress, else is set to the CPU
> +     * handling the mc.
> +     */
> +    int mc_status;
>      QemuCond mc_delivery_cond;
>  
>      /*< public >*/
> @@ -793,6 +798,7 @@ void spapr_clear_pending_events(SpaprMachineState *spapr);
>  int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
>  
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 3bf0a46..39f1a73 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1761,6 +1761,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
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
> @@ -2844,6 +2849,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>      return data & 0xffff;
>  }
>  
> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
> +{
> +    bool recovered = run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
> +
> +    cpu_synchronize_state(CPU(cpu));
> +
> +    spapr_mce_req_event(cpu, recovered);
> +
> +    return 0;
> +}
> +
>  int kvmppc_enable_hwrng(void)
>  {
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HWRNG)) {
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 45776ca..18693f1 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -81,6 +81,8 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
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
> 


