Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08DC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B742522B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbm5U6Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B742522B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j45kS-0001SR-Td
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1j45jV-0000ba-CC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1j45jT-0003Rk-MW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1j45jP-0003Oh-1C; Tue, 18 Feb 2020 11:28:19 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1665422B48;
 Tue, 18 Feb 2020 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582043297;
 bh=VLCjvnKowPCVAcUb7cvxbmA0tvLKffyYYef2QgFOenQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Sbm5U6NwUXj9/taMMT3p6jsYnEkboKa8ctoCCKdYBkAKgmWTobf4SOi8IKYlmZJMK
 b35fhP/ky1Ln0cnScyU6R0mURDU4eG1mxmNjoqy5vMWxNuep17/S3PSevc882GbiJR
 ZL1rXja1S+lLcJCJI1l84w+RUkRC7VZGIsKQ8tzo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j45jL-006FyV-9e; Tue, 18 Feb 2020 16:28:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Feb 2020 16:28:15 +0000
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 1/3] target/arm: Support SError injection
In-Reply-To: <20200218020416.50244-2-gshan@redhat.com>
References: <20200218020416.50244-1-gshan@redhat.com>
 <20200218020416.50244-2-gshan@redhat.com>
Message-ID: <60f0303b0c8d3f9a124c2e5c25814de3@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 aik@ozlabs.ru, drjones@redhat.com, eric.auger@redhat.com, jthierry@redhat.com,
 shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-02-18 02:04, Gavin Shan wrote:
> This supports SError injection, which will be used by "virt" board to
> simulating the behavior of NMI injection in next patch. As Peter 
> Maydell
> suggested, this adds a new interrupt (ARM_CPU_SERROR), which is 
> parallel
> to CPU_INTERRUPT_HARD. The backend depends on if kvm is enabled or not.
> kvm_vcpu_ioctl(cpu, KVM_SET_VCPU_EVENTS) is leveraged to inject SError
> or data abort to guest. When TCG is enabled, the behavior is simulated
> by injecting SError and data abort to guest.

s/and/or/ (you can't inject both at the same time).

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  target/arm/cpu.c      | 69 +++++++++++++++++++++++++++++++++++--------
>  target/arm/cpu.h      | 20 ++++++++-----
>  target/arm/helper.c   | 12 ++++++++
>  target/arm/m_helper.c |  8 +++++
>  target/arm/machine.c  |  3 +-
>  5 files changed, 91 insertions(+), 21 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index de733aceeb..e5750080bc 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -78,7 +78,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>          && cs->interrupt_request &
>          (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
>           | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
> -         | CPU_INTERRUPT_EXITTB);
> +         | CPU_INTERRUPT_SERROR | CPU_INTERRUPT_EXITTB);
>  }
> 
>  void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn 
> *hook,
> @@ -449,6 +449,9 @@ static inline bool arm_excp_unmasked(CPUState *cs,
> unsigned int excp_idx,
>              return false;
>          }
>          return !(env->daif & PSTATE_I);
> +    case EXCP_SERROR:
> +       pstate_unmasked = !(env->daif & PSTATE_A);
> +       break;

nit: Consider keeping the physical interrupts together, as they are 
closely
related.

>      default:
>          g_assert_not_reached();
>      }
> @@ -538,6 +541,15 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int
> interrupt_request)
> 
>      /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
> 
> +    if (interrupt_request & CPU_INTERRUPT_SERROR) {
> +        excp_idx = EXCP_SERROR;
> +        target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, 
> secure);
> +        if (arm_excp_unmasked(cs, excp_idx, target_el,
> +                              cur_el, secure, hcr_el2)) {
> +            goto found;
> +        }
> +    }
> +
>      if (interrupt_request & CPU_INTERRUPT_FIQ) {
>          excp_idx = EXCP_FIQ;
>          target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, 
> secure);
> @@ -570,6 +582,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int
> interrupt_request)
>              goto found;
>          }
>      }
> +
>      return false;
> 
>   found:
> @@ -585,7 +598,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState
> *cs, int interrupt_request)
>      CPUClass *cc = CPU_GET_CLASS(cs);
>      ARMCPU *cpu = ARM_CPU(cs);
>      CPUARMState *env = &cpu->env;
> -    bool ret = false;
> +    uint32_t excp_idx;
> 
>      /* ARMv7-M interrupt masking works differently than -A or -R.
>       * There is no FIQ/IRQ distinction. Instead of I and F bits
> @@ -594,13 +607,26 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState
> *cs, int interrupt_request)
>       * (which depends on state like BASEPRI, FAULTMASK and the
>       * currently active exception).
>       */
> -    if (interrupt_request & CPU_INTERRUPT_HARD
> -        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
> -        cs->exception_index = EXCP_IRQ;
> -        cc->do_interrupt(cs);
> -        ret = true;
> +    if (!armv7m_nvic_can_take_pending_exception(env->nvic)) {
> +        return false;
> +    }
> +
> +    if (interrupt_request & CPU_INTERRUPT_SERROR) {
> +        excp_idx = EXCP_SERROR;
> +        goto found;
> +    }
> +
> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
> +        excp_idx = EXCP_IRQ;
> +        goto found;
>      }
> -    return ret;
> +
> +    return false;
> +
> +found:
> +    cs->exception_index = excp_idx;
> +    cc->do_interrupt(cs);
> +    return true;
>  }
>  #endif
> 
> @@ -656,7 +682,8 @@ static void arm_cpu_set_irq(void *opaque, int irq,
> int level)
>          [ARM_CPU_IRQ] = CPU_INTERRUPT_HARD,
>          [ARM_CPU_FIQ] = CPU_INTERRUPT_FIQ,
>          [ARM_CPU_VIRQ] = CPU_INTERRUPT_VIRQ,
> -        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ
> +        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ,
> +        [ARM_CPU_SERROR] = CPU_INTERRUPT_SERROR,
>      };
> 
>      if (level) {
> @@ -676,6 +703,7 @@ static void arm_cpu_set_irq(void *opaque, int irq,
> int level)
>          break;
>      case ARM_CPU_IRQ:
>      case ARM_CPU_FIQ:
> +    case ARM_CPU_SERROR:
>          if (level) {
>              cpu_interrupt(cs, mask[irq]);
>          } else {
> @@ -693,8 +721,10 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
> irq, int level)
>      ARMCPU *cpu = opaque;
>      CPUARMState *env = &cpu->env;
>      CPUState *cs = CPU(cpu);
> +    struct kvm_vcpu_events events;
>      uint32_t linestate_bit;
>      int irq_id;
> +    bool inject_irq = true;
> 
>      switch (irq) {
>      case ARM_CPU_IRQ:
> @@ -705,6 +735,14 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
> irq, int level)
>          irq_id = KVM_ARM_IRQ_CPU_FIQ;
>          linestate_bit = CPU_INTERRUPT_FIQ;
>          break;
> +    case ARM_CPU_SERROR:
> +        if (!kvm_has_vcpu_events()) {
> +            return;
> +        }
> +
> +        inject_irq = false;
> +        linestate_bit = CPU_INTERRUPT_SERROR;
> +        break;
>      default:
>          g_assert_not_reached();
>      }
> @@ -714,7 +752,14 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
> irq, int level)
>      } else {
>          env->irq_line_state &= ~linestate_bit;
>      }
> -    kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, 
> !!level);
> +
> +    if (inject_irq) {

You could just have (linestate_bit != CPU_INTERRUPT_SERROR) here, and 
not have
inject_irq at all.

> +        kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, 
> !!level);
> +    } else if (level) {

Is there any case where you'd call this function with a SError and level 
== 0?
And even if it happens, you could exit early in the above switch 
statement.

> +        memset(&events, 0, sizeof(events));
> +        events.exception.serror_pending = 1;
> +        kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events);
> +    }
>  #endif
>  }
> 
> @@ -1064,9 +1109,9 @@ static void arm_cpu_initfn(Object *obj)
>          /* VIRQ and VFIQ are unused with KVM but we add them to 
> maintain
>           * the same interface as non-KVM CPUs.
>           */
> -        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 4);
> +        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 
> ARM_CPU_NUM_IRQ);
>      } else {
> -        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
> +        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 
> ARM_CPU_NUM_IRQ);
>      }
> 
>      qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e943ffe8a9..23e9f7ee2d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -49,6 +49,7 @@
>  #define EXCP_LAZYFP         20   /* v7M fault during lazy FP stacking 
> */
>  #define EXCP_LSERR          21   /* v8M LSERR SecureFault */
>  #define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault */
> +#define EXCP_SERROR         23   /* SError Interrupt */
>  /* NB: add new EXCP_ defines to the array in arm_log_exception() too 
> */
> 
>  #define ARMV7M_EXCP_RESET   1
> @@ -79,9 +80,10 @@ enum {
>  };
> 
>  /* ARM-specific interrupt pending bits.  */
> -#define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
> -#define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
> -#define CPU_INTERRUPT_VFIQ  CPU_INTERRUPT_TGT_EXT_3
> +#define CPU_INTERRUPT_FIQ     CPU_INTERRUPT_TGT_EXT_1
> +#define CPU_INTERRUPT_VIRQ    CPU_INTERRUPT_TGT_EXT_2
> +#define CPU_INTERRUPT_VFIQ    CPU_INTERRUPT_TGT_EXT_3
> +#define CPU_INTERRUPT_SERROR  CPU_INTERRUPT_TGT_EXT_4
> 
>  /* The usual mapping for an AArch64 system register to its AArch32
>   * counterpart is for the 32 bit world to have access to the lower
> @@ -97,11 +99,13 @@ enum {
>  #define offsetofhigh32(S, M) (offsetof(S, M) + sizeof(uint32_t))
>  #endif
> 
> -/* Meanings of the ARMCPU object's four inbound GPIO lines */
> -#define ARM_CPU_IRQ 0
> -#define ARM_CPU_FIQ 1
> -#define ARM_CPU_VIRQ 2
> -#define ARM_CPU_VFIQ 3
> +/* ARMCPU object's inbound GPIO lines */
> +#define ARM_CPU_IRQ     0
> +#define ARM_CPU_FIQ     1
> +#define ARM_CPU_VIRQ    2
> +#define ARM_CPU_VFIQ    3
> +#define ARM_CPU_SERROR  4
> +#define ARM_CPU_NUM_IRQ 5

This probably should be turned into an enum, given that it is going to
grow again on the following patch.

> 
>  /* ARM-specific extra insn start words:
>   * 1: Conditional execution bits
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 366dbcf460..3f00af4c41 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1969,6 +1969,12 @@ static uint64_t isr_read(CPUARMState *env,
> const ARMCPRegInfo *ri)
>          }
>      }
> 
> +    if (!allow_virt || !(hcr_el2 & HCR_AMO)) {

nit: It would be nicer to write this as

        if (!(allow_virt && (hcr_el2 & HCR_AMO)))

which fits the current code better, and makes a slightly less ugly
rewrite in the following patch.

> +        if (cs->interrupt_request & CPU_INTERRUPT_SERROR) {
> +            ret |= CPSR_A;
> +        }
> +    }
> +
>      /* External aborts are not possible in QEMU so A bit is always 
> clear */

nit: this comment seems obsolete now.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

