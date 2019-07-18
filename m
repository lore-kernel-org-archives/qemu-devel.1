Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC92C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 16:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A07B21850
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 16:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A07B21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho96s-0006lH-Cw
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 12:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35460)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1ho96f-0006Fw-Kh
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 12:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ho96d-00014S-H8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 12:18:09 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:38386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ho96b-00010B-E3
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 12:18:05 -0400
Received: from player692.ha.ovh.net (unknown [10.108.42.75])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id A37FC13B935
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 18:18:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 585D57F6325A;
 Thu, 18 Jul 2019 16:17:57 +0000 (UTC)
Date: Thu, 18 Jul 2019 18:17:56 +0200
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190718181756.49b06085@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <156346318478.57409.13978029359288402904.stgit@lep8c.aus.stglabs.ibm.com>
References: <156346318478.57409.13978029359288402904.stgit@lep8c.aus.stglabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11220999946750105941
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.220
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] ppc: make idle_timer a
 per-cpu variable
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

On Thu, 18 Jul 2019 10:21:28 -0500
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> The current code is broken for more than vcpu as
> each thread would overwrite and there were memory leaks.
> 
> Make it part of PowerPCCPU so that every thread has a
> separate one. Avoid using the timer_new_ns which is
> not the preferred way to create timers.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  v2: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04023.html
>  Changes from v2:
>    v2 just looked at avoiding the memory leak.
>    This patch incorporates all of Greg's suggestions.
> 
>  target/ppc/cpu.h |    1 +
>  target/ppc/kvm.c |   31 ++++++++++++++++---------------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2a5c..521086d91a 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1190,6 +1190,7 @@ struct PowerPCCPU {
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
> +    QEMUTimer idle_timer;
>  
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..6e1b96bb0a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -87,18 +87,6 @@ static int cap_large_decr;
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
>  static void kvm_kick_cpu(void *opaque)
>  {
>      PowerPCCPU *cpu = opaque;
> @@ -491,7 +479,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
>  
> -    idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> +    timer_init_ns(&cpu->idle_timer, QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
>  
>      switch (cenv->mmu_model) {
>      case POWERPC_MMU_BOOKE206:
> @@ -523,6 +511,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>  int kvm_arch_destroy_vcpu(CPUState *cs)
>  {
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +    timer_deinit(&cpu->idle_timer);

As stated in the timer.h header file, timer_del() should always be called
before timer_deinit().

With that fixed:

Reviewed-by: Greg Kurz <groug@kaod.org>

> +
>      return 0;
>  }
>  
> @@ -1379,8 +1371,17 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
>              printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
>          }
>  
> -        /* Always wake up soon in case the interrupt was level based */
> -        timer_mod(idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +        /*
> +         * XXX We have a race condition where we actually have a level
> +         *     triggered interrupt, but the infrastructure can't expose that
> +         *     yet, so the guest takes but ignores it, goes to sleep and
> +         *     never gets notified that there's still an interrupt pending.
> +         *
> +         *     As a quick workaround, let's just wake up again 20 ms after
> +         *     we injected an interrupt. That way we can assure that we're
> +         *     always reinjecting interrupts in case the guest swallowed them.
> +         */
> +        timer_mod(&cpu->idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                         (NANOSECONDS_PER_SECOND / 50));
>      }
>  
> 
> 


