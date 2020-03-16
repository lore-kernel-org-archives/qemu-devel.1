Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B34C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3A520674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3A520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuWV-0006tH-R2
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jDtLd-0007VQ-Bu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jDtLb-00073A-6I
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:16:17 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:59528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jDtLa-0006pn-SD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:16:15 -0400
Received: from player772.ha.ovh.net (unknown [10.110.115.164])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7B0D11CDF63
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 18:16:12 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 9E98010895B91;
 Mon, 16 Mar 2020 17:15:58 +0000 (UTC)
Date: Mon, 16 Mar 2020 18:15:57 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/8] ppc/spapr: Change FWNMI names
Message-ID: <20200316181557.53ab930f@bahia.lan>
In-Reply-To: <20200316142613.121089-3-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-3-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12996262624738712003
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.165.38
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
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 00:26:07 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> The option is called "FWNMI", and it involves more than just machine
> checks, also machine checks can be delivered without the FWNMI option,
> so re-name various things to reflect that.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c                    | 28 ++++++++++++++--------------
>  hw/ppc/spapr_caps.c               | 14 +++++++-------
>  hw/ppc/spapr_events.c             | 14 +++++++-------
>  hw/ppc/spapr_rtas.c               | 17 +++++++++--------
>  include/hw/ppc/spapr.h            | 27 +++++++++++++++++----------
>  tests/qtest/libqos/libqos-spapr.h |  2 +-
>  6 files changed, 55 insertions(+), 47 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d3db3ec56e..b03b26370d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1704,11 +1704,11 @@ static void spapr_machine_reset(MachineState *machine)
>  
>      spapr->cas_reboot = false;
>  
> -    spapr->mc_status = -1;
> -    spapr->guest_machine_check_addr = -1;
> +    spapr->fwnmi_machine_check_addr = -1;
> +    spapr->fwnmi_machine_check_interlock = -1;
>  
>      /* Signal all vCPUs waiting on this condition */
> -    qemu_cond_broadcast(&spapr->mc_delivery_cond);
> +    qemu_cond_broadcast(&spapr->fwnmi_machine_check_interlock_cond);
>  
>      migrate_del_blocker(spapr->fwnmi_migration_blocker);
>  }
> @@ -1997,7 +1997,7 @@ static bool spapr_fwnmi_needed(void *opaque)
>  {
>      SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>  
> -    return spapr->guest_machine_check_addr != -1;
> +    return spapr->fwnmi_machine_check_addr != -1;
>  }
>  
>  static int spapr_fwnmi_pre_save(void *opaque)
> @@ -2008,7 +2008,7 @@ static int spapr_fwnmi_pre_save(void *opaque)
>       * Check if machine check handling is in progress and print a
>       * warning message.
>       */
> -    if (spapr->mc_status != -1) {
> +    if (spapr->fwnmi_machine_check_interlock != -1) {
>          warn_report("A machine check is being handled during migration. The"
>                  "handler may run and log hardware error on the destination");
>      }
> @@ -2016,15 +2016,15 @@ static int spapr_fwnmi_pre_save(void *opaque)
>      return 0;
>  }
>  
> -static const VMStateDescription vmstate_spapr_machine_check = {
> -    .name = "spapr_machine_check",
> +static const VMStateDescription vmstate_spapr_fwnmi = {
> +    .name = "spapr_fwnmi",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = spapr_fwnmi_needed,
>      .pre_save = spapr_fwnmi_pre_save,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
> -        VMSTATE_INT32(mc_status, SpaprMachineState),
> +        VMSTATE_UINT64(fwnmi_machine_check_addr, SpaprMachineState),
> +        VMSTATE_INT32(fwnmi_machine_check_interlock, SpaprMachineState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -2063,7 +2063,7 @@ static const VMStateDescription vmstate_spapr = {
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
>          &vmstate_spapr_cap_fwnmi,
> -        &vmstate_spapr_machine_check,
> +        &vmstate_spapr_fwnmi,
>          NULL
>      }
>  };
> @@ -2884,7 +2884,7 @@ static void spapr_machine_init(MachineState *machine)
>          spapr_create_lmb_dr_connectors(spapr);
>      }
>  
> -    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_ON) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_ON) {
>          /* Create the error string for live migration blocker */
>          error_setg(&spapr->fwnmi_migration_blocker,
>              "A machine check is being handled during migration. The handler"
> @@ -3053,7 +3053,7 @@ static void spapr_machine_init(MachineState *machine)
>          kvmppc_spapr_enable_inkernel_multitce();
>      }
>  
> -    qemu_cond_init(&spapr->mc_delivery_cond);
> +    qemu_cond_init(&spapr->fwnmi_machine_check_interlock_cond);
>  }
>  
>  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
> @@ -4534,7 +4534,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
> @@ -4612,7 +4612,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
>      spapr_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_OFF;
>      smc->rma_limit = 16 * GiB;
>      mc->nvdimm_supported = false;
>  }
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 8b27d3ac09..f626d769a0 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -509,7 +509,7 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>      }
>  }
>  
> -static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
> +static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>                                  Error **errp)
>  {
>      if (!val) {
> @@ -626,14 +626,14 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .type = "bool",
>          .apply = cap_ccf_assist_apply,
>      },
> -    [SPAPR_CAP_FWNMI_MCE] = {
> -        .name = "fwnmi-mce",
> -        .description = "Handle fwnmi machine check exceptions",
> -        .index = SPAPR_CAP_FWNMI_MCE,
> +    [SPAPR_CAP_FWNMI] = {
> +        .name = "fwnmi",
> +        .description = "Implements PAPR FWNMI option",
> +        .index = SPAPR_CAP_FWNMI,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
>          .type = "bool",
> -        .apply = cap_fwnmi_mce_apply,
> +        .apply = cap_fwnmi_apply,
>      },
>  };
>  
> @@ -774,7 +774,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> -SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>  
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 11303258d4..27ba8a2c19 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -837,7 +837,7 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>  
>      env->gpr[3] = rtas_addr + RTAS_ERROR_LOG_OFFSET;
>      env->msr = msr;
> -    env->nip = spapr->guest_machine_check_addr;
> +    env->nip = spapr->fwnmi_machine_check_addr;
>  
>      g_free(ext_elog);
>  }
> @@ -849,7 +849,7 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>      int ret;
>      Error *local_err = NULL;
>  
> -    if (spapr->guest_machine_check_addr == -1) {
> +    if (spapr->fwnmi_machine_check_addr == -1) {
>          /*
>           * This implies that we have hit a machine check either when the
>           * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
> @@ -861,19 +861,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>          return;
>      }
>  
> -    while (spapr->mc_status != -1) {
> +    while (spapr->fwnmi_machine_check_interlock != -1) {
>          /*
>           * Check whether the same CPU got machine check error
>           * while still handling the mc error (i.e., before
>           * that CPU called "ibm,nmi-interlock")
>           */
> -        if (spapr->mc_status == cpu->vcpu_id) {
> +        if (spapr->fwnmi_machine_check_interlock == cpu->vcpu_id) {
>              qemu_system_guest_panicked(NULL);
>              return;
>          }
> -        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
> +        qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_cond);
>          /* Meanwhile if the system is reset, then just return */
> -        if (spapr->guest_machine_check_addr == -1) {
> +        if (spapr->fwnmi_machine_check_addr == -1) {
>              return;
>          }
>      }
> @@ -889,7 +889,7 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>          warn_report("Received a fwnmi while migration was in progress");
>      }
>  
> -    spapr->mc_status = cpu->vcpu_id;
> +    spapr->fwnmi_machine_check_interlock = cpu->vcpu_id;
>      spapr_mce_dispatch_elog(cpu, recovered);
>  }
>  
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index fe83b50c66..0b8c481593 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -415,7 +415,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>  {
>      hwaddr rtas_addr;
>  
> -    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
>          rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>          return;
>      }
> @@ -426,7 +426,8 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>          return;
>      }
>  
> -    spapr->guest_machine_check_addr = rtas_ld(args, 1);
> +    spapr->fwnmi_machine_check_addr = rtas_ld(args, 1);
> +
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
>  
> @@ -436,18 +437,18 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>                                     target_ulong args,
>                                     uint32_t nret, target_ulong rets)
>  {
> -    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
>          rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>          return;
>      }
>  
> -    if (spapr->guest_machine_check_addr == -1) {
> +    if (spapr->fwnmi_machine_check_addr == -1) {
>          /* NMI register not called */
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
>      }
>  
> -    if (spapr->mc_status != cpu->vcpu_id) {
> +    if (spapr->fwnmi_machine_check_interlock != cpu->vcpu_id) {
>          /* The vCPU that hit the NMI should invoke "ibm,nmi-interlock" */
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
> @@ -455,10 +456,10 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>  
>      /*
>       * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> -     * hence unset mc_status.
> +     * hence unset fwnmi_machine_check_interlock.
>       */
> -    spapr->mc_status = -1;
> -    qemu_cond_signal(&spapr->mc_delivery_cond);
> +    spapr->fwnmi_machine_check_interlock = -1;
> +    qemu_cond_signal(&spapr->fwnmi_machine_check_interlock_cond);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>      migrate_del_blocker(spapr->fwnmi_migration_blocker);
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 35b489a549..64b83402cb 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -79,10 +79,10 @@ typedef enum {
>  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
>  /* Count Cache Flush Assist HW Instruction */
>  #define SPAPR_CAP_CCF_ASSIST            0x09
> -/* FWNMI machine check handling */
> -#define SPAPR_CAP_FWNMI_MCE             0x0A
> +/* Implements PAPR FWNMI option */
> +#define SPAPR_CAP_FWNMI                 0x0A
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
>  
>  /*
>   * Capability Values
> @@ -192,14 +192,21 @@ struct SpaprMachineState {
>       * occurs during the unplug process. */
>      QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
>  
> -    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
> -    target_ulong guest_machine_check_addr;
> -    /*
> -     * mc_status is set to -1 if mc is not in progress, else is set to the CPU
> -     * handling the mc.
> +    /* State related to FWNMI option */
> +
> +    /* Machine Check Notification Routine address
> +     * registered by "ibm,nmi-register" RTAS call.
> +     */
> +    target_ulong fwnmi_machine_check_addr;
> +
> +    /* Machine Check FWNMI synchronization, fwnmi_machine_check_interlock is
> +     * set to -1 if a FWNMI machine check is not in progress, else is set to
> +     * the CPU that was delivered the machine check, and is set back to -1
> +     * when that CPU makes an "ibm,nmi-interlock" RTAS call. The cond is used
> +     * to synchronize other CPUs.
>       */
> -    int mc_status;
> -    QemuCond mc_delivery_cond;
> +    int fwnmi_machine_check_interlock;
> +    QemuCond fwnmi_machine_check_interlock_cond;
>  
>      /*< public >*/
>      char *kvm_type;
> diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqos-spapr.h
> index d9c4c22343..16174dbada 100644
> --- a/tests/qtest/libqos/libqos-spapr.h
> +++ b/tests/qtest/libqos/libqos-spapr.h
> @@ -13,6 +13,6 @@ void qtest_spapr_shutdown(QOSState *qs);
>      "cap-sbbc=broken,"                           \
>      "cap-ibs=broken,"                            \
>      "cap-ccf-assist=off,"                        \
> -    "cap-fwnmi-mce=off"
> +    "cap-fwnmi=off"
>  
>  #endif


