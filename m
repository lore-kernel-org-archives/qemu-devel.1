Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D85C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC8122BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC8122BF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZKk-0004Mz-CE
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hqZKY-0003so-ML
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hqZKX-0007Y3-8S
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:42:30 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:34516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hqZKX-0007X5-1Z
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:42:29 -0400
Received: from player158.ha.ovh.net (unknown [10.109.160.143])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id EA62513BDEC
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:42:26 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player158.ha.ovh.net (Postfix) with ESMTPSA id 3EF1F830B32D;
 Thu, 25 Jul 2019 08:42:22 +0000 (UTC)
Date: Thu, 25 Jul 2019 10:42:20 +0200
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190725104220.7efdf9e3@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <156397239821.79647.2790800099666109879.stgit@lep8c.aus.stglabs.ibm.com>
References: <156397239821.79647.2790800099666109879.stgit@lep8c.aus.stglabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7742250712304752981
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkedvgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.26
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v6] ppc: remove idle_timer logic
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jul 2019 07:47:45 -0500
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

You could mention that this code was completely broken and leaking memory on
setups with multiple vCPUs. Not worth fixing since the KVM_CAP_PPC_IRQ_LEVEL
is part... etc...

> The KVM_CAP_PPC_IRQ_LEVEL is part of the kernel now since 2.6.37.
> Drop the redundant logic which is not excercised on new the kernels anymore.
> Exit with error on older kernels.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  v5: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05301.html
>  Changes from v5:
>    - exit with error if KVM_CAP_PPC_IRQ_LEVEL is not there.
> 
>  target/ppc/kvm.c |   75 ++++--------------------------------------------------
>  1 file changed, 5 insertions(+), 70 deletions(-)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..4a3f36f0d5 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -56,7 +56,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>  };
>  
>  static int cap_interrupt_unset;
> -static int cap_interrupt_level;
>  static int cap_segstate;
>  static int cap_booke_sregs;
>  static int cap_ppc_smt;
> @@ -87,25 +86,6 @@ static int cap_large_decr;
>  
>  static uint32_t debug_inst_opcode;
>  
> -/*
> - * XXX We have a race condition where we actually have a level triggered
> - *     interrupt, but the infrastructure can't expose that yet, so the guest
> - *     takes but ignores it, goes to sleep and never gets notified that there's
> - *     still an interrupt pending.
> - *
> - *     As a quick workaround, let's just wake up again 20 ms after we injected
> - *     an interrupt. That way we can assure that we're always reinjecting
> - *     interrupts in case the guest swallowed them.
> - */
> -static QEMUTimer *idle_timer;
> -
> -static void kvm_kick_cpu(void *opaque)
> -{
> -    PowerPCCPU *cpu = opaque;
> -
> -    qemu_cpu_kick(CPU(cpu));
> -}
> -
>  /*
>   * Check whether we are running with KVM-PR (instead of KVM-HV).  This
>   * should only be used for fallback tests - generally we should use
> @@ -125,7 +105,6 @@ static int kvmppc_get_dec_bits(void);
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      cap_interrupt_unset = kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ);
> -    cap_interrupt_level = kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL);
>      cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
>      cap_booke_sregs = kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
>      cap_ppc_smt_possible = kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBLE);
> @@ -161,9 +140,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       */
>      cap_ppc_pvr_compat = false;
>  
> -    if (!cap_interrupt_level) {
> -        fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
> -                        "VM to stall at times!\n");
> +    if (!kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL)) {
> +        fprintf(stderr, "KVM: Host kernel doesn't have level irq capability\n");

error_report() is preferred over fprintf() for logging errors, and don't forget
to drop the trailing "\n" when you convert to error_report().

> +        exit(1);
>      }
>  
>      kvm_ppc_register_host_cpu_type(ms);
> @@ -491,8 +470,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
>  
> -    idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> -
>      switch (cenv->mmu_model) {
>      case POWERPC_MMU_BOOKE206:
>          /* This target supports access to KVM's guest TLB */
> @@ -1332,7 +1309,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
>          return 0;
>      }
>  
> -    if (!kvm_enabled() || !cap_interrupt_unset || !cap_interrupt_level) {
> +    if (!kvm_enabled() || !cap_interrupt_unset) {

It looks like cap_interrupt_unset which is even older (2.6.35) is a good
candidate for cleanup as well. Maybe add a patch for that also when you
repost.

>          return 0;
>      }
>  
> @@ -1349,49 +1326,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
>  
>  void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
>  {
> -    PowerPCCPU *cpu = POWERPC_CPU(cs);
> -    CPUPPCState *env = &cpu->env;
> -    int r;
> -    unsigned irq;
> -
> -    qemu_mutex_lock_iothread();
> -
> -    /*
> -     * PowerPC QEMU tracks the various core input pins (interrupt,
> -     * critical interrupt, reset, etc) in PPC-specific
> -     * env->irq_input_state.
> -     */
> -    if (!cap_interrupt_level &&
> -        run->ready_for_interrupt_injection &&
> -        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> -        (env->irq_input_state & (1 << PPC_INPUT_INT)))
> -    {
> -        /*
> -         * For now KVM disregards the 'irq' argument. However, in the
> -         * future KVM could cache it in-kernel to avoid a heavyweight
> -         * exit when reading the UIC.
> -         */
> -        irq = KVM_INTERRUPT_SET;
> -
> -        trace_kvm_injected_interrupt(irq);
> -        r = kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &irq);
> -        if (r < 0) {
> -            printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
> -        }
> -
> -        /* Always wake up soon in case the interrupt was level based */
> -        timer_mod(idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                       (NANOSECONDS_PER_SECOND / 50));
> -    }
> -
> -    /*
> -     * We don't know if there are more interrupts pending after
> -     * this. However, the guest will return to userspace in the course
> -     * of handling this one anyways, so we will get a chance to
> -     * deliver the rest.
> -     */
> -
> -    qemu_mutex_unlock_iothread();
> +    return;
>  }
>  
>  MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
> 
> 


