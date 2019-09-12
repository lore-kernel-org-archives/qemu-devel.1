Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA07C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2100D20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2100D20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58541 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Icp-0001g6-4x
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 02:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i8IUe-0001Uf-Cx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i8IUc-0005KZ-An
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:22:11 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:33340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i8IUc-0005Jl-2k
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:22:10 -0400
Received: from player799.ha.ovh.net (unknown [10.108.57.50])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id F20A718EC35
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 08:22:07 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 2637A9B1B61C;
 Thu, 12 Sep 2019 06:22:01 +0000 (UTC)
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20190912032531.32546-1-andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a9fdcc8b-3a92-587f-28e8-5a997991532e@kaod.org>
Date: Thu, 12 Sep 2019 08:22:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912032531.32546-1-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16433353566867852243
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdeggddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.253.128
Subject: Re: [Qemu-devel] [PATCH v4] target-arm: Make the counter tick
 relative to cntfrq
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/2019 05:25, Andrew Jeffery wrote:
> Allow machines to configure CNTFRQ via a property if the ARM core
> supports the generic timer. This is necessary on e.g. the ASPEED AST2600
> SoC where the generic timer clock is run at 800MHz or above. The default
> value for CNTFRQ remains at 62.50MHz (based on GTIMER_SCALE).
> 
> CNTFRQ is a read-as-written co-processor register; the property sets the
> register's initial value which is used during realize() to configure the
> QEMUTimers that back the generic timers. Beyond that the firmware can to
> do whatever it sees fit with the CNTFRQ register though changes to the
> value will not be reflected in the timers' rate.
> 
> I've tested this using an out-of-tree AST2600 SoC model (Cortex-A7) with
> the SDK u-boot that sets CNTFRQ as appropriate, and by starting/running
> machines with assorted ARM CPUs (palmetto-bmc with the ARM926EJ-S,
> romulus-bmc with the ARM1176 and raspi2 with the Cortex-A53).
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> v4: Fix configuration for cores without a generic timer
> 
> v3: https://patchwork.ozlabs.org/patch/1160634/
> Peter - I think this addresses most of your feedback. I still reach into
> the QEMUTimer to fetch out scale when adjusting the nexttick
> calculation, but we no longer need to update the scale member and force
> a recalculation of the period.
> 
> v2: https://patchwork.ozlabs.org/patch/1144389/
> ---
>  roms/SLOF           |  2 +-
>  roms/skiboot        |  2 +-
>  target/arm/cpu.c    | 43 +++++++++++++++++++++++++++++++++++--------
>  target/arm/cpu.h    |  3 +++
>  target/arm/helper.c | 30 ++++++++++++++++++++++++++----
>  5 files changed, 66 insertions(+), 14 deletions(-)
> 
> diff --git a/roms/SLOF b/roms/SLOF
> index 7bfe584e3219..ea221600a116 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 7bfe584e321946771692711ff83ad2b5850daca7
> +Subproject commit ea221600a116883137ef90b2b7ab7d2472bc4f10
> diff --git a/roms/skiboot b/roms/skiboot
> index 261ca8e779e5..3a6fdede6ce1 160000
> --- a/roms/skiboot
> +++ b/roms/skiboot
> @@ -1 +1 @@
> -Subproject commit 261ca8e779e5138869a45f174caa49be6a274501
> +Subproject commit 3a6fdede6ce117facec0108afe716cf5d0472c3f


The changes above seem not related.

C. 


> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2399c144718d..8b63a27761bb 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -40,6 +40,8 @@
>  #include "disas/capstone.h"
>  #include "fpu/softfloat.h"
>  
> +#include <inttypes.h>
> +
>  static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>  {
>      ARMCPU *cpu = ARM_CPU(cs);
> @@ -976,6 +978,10 @@ static void arm_cpu_initfn(Object *obj)
>      }
>  }
>  
> +static Property arm_cpu_gt_cntfrq_property =
> +            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq,
> +                               (1000 * 1000 * 1000) / GTIMER_SCALE);
> +
>  static Property arm_cpu_reset_cbar_property =
>              DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
>  
> @@ -1172,6 +1178,11 @@ void arm_cpu_post_init(Object *obj)
>  
>      qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
>                               &error_abort);
> +
> +    if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
> +        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property,
> +                                 &error_abort);
> +    }
>  }
>  
>  static void arm_cpu_finalizefn(Object *obj)
> @@ -1238,14 +1249,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -    cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
> -                                           arm_gt_ptimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
> -                                           arm_gt_vtimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_HYP] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
> -                                          arm_gt_htimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
> -                                          arm_gt_stimer_cb, cpu);
> +
> +    {
> +        uint64_t scale;
> +
> +        if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
> +            if (!cpu->gt_cntfrq) {
> +                error_setg(errp, "Invalid CNTFRQ: %"PRId64"Hz",
> +                           cpu->gt_cntfrq);
> +                return;
> +            }
> +            scale = MAX(1, NANOSECONDS_PER_SECOND / cpu->gt_cntfrq);
> +        } else {
> +            scale = GTIMER_SCALE;
> +        }
> +
> +        cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
> +                                               arm_gt_ptimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
> +                                               arm_gt_vtimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_HYP] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
> +                                              arm_gt_htimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
> +                                              arm_gt_stimer_cb, cpu);
> +    }
>  #endif
>  
>      cpu_exec_realizefn(cs, &local_err);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 297ad5e47ad8..8bd576f834ba 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -915,6 +915,9 @@ struct ARMCPU {
>  
>      /* Used to set the maximum vector length the cpu will support.  */
>      uint32_t sve_max_vq;
> +
> +    /* Used to configure the generic timer input clock */
> +    uint64_t gt_cntfrq;
>  };
>  
>  void arm_cpu_post_init(Object *obj);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 507026c9154b..09975704d47f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2409,7 +2409,21 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
>  
>  static uint64_t gt_get_countervalue(CPUARMState *env)
>  {
> -    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
> +    uint64_t effective;
> +
> +    /*
> +     * Deal with quantized clock scaling by calculating the effective frequency
> +     * in terms of the timer scale.
> +     */
> +    if (env->cp15.c14_cntfrq <= NANOSECONDS_PER_SECOND) {
> +        uint32_t scale = NANOSECONDS_PER_SECOND / env->cp15.c14_cntfrq;
> +        effective = NANOSECONDS_PER_SECOND / scale;
> +    } else {
> +        effective = NANOSECONDS_PER_SECOND;
> +    }
> +
> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), effective,
> +                    NANOSECONDS_PER_SECOND);
>  }
>  
>  static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
> @@ -2445,8 +2459,8 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
>           * set the timer for as far in the future as possible. When the
>           * timer expires we will reset the timer for any remaining period.
>           */
> -        if (nexttick > INT64_MAX / GTIMER_SCALE) {
> -            nexttick = INT64_MAX / GTIMER_SCALE;
> +        if (nexttick > INT64_MAX / cpu->gt_timer[timeridx]->scale) {
> +            nexttick = INT64_MAX / cpu->gt_timer[timeridx]->scale;
>          }
>          timer_mod(cpu->gt_timer[timeridx], nexttick);
>          trace_arm_gt_recalc(timeridx, irqstate, nexttick);
> @@ -2680,6 +2694,14 @@ void arm_gt_stimer_cb(void *opaque)
>      gt_recalc_timer(cpu, GTIMER_SEC);
>  }
>  
> +static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +
> +    cpu->env.cp15.c14_cntfrq =
> +        cpu->gt_cntfrq ?: (1000 * 1000 * 1000) / GTIMER_SCALE;
> +}
> +
>  static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>      /* Note that CNTFRQ is purely reads-as-written for the benefit
>       * of software; writing it doesn't actually change the timer frequency.
> @@ -2694,7 +2716,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
>        .access = PL1_RW | PL0_R, .accessfn = gt_cntfrq_access,
>        .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
> -      .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
> +      .resetfn = arm_gt_cntfrq_reset,
>      },
>      /* overall control: mostly access permissions */
>      { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
> 


