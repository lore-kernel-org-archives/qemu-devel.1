Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FF7C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF46207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF46207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPQU-0007XZ-4y
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iCPNh-0005Ji-El
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iCPNf-0000KA-8p
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iCPNa-0000G8-NH; Mon, 23 Sep 2019 10:31:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0BEA18C4279;
 Mon, 23 Sep 2019 14:31:53 +0000 (UTC)
Received: from [10.36.116.30] (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A6F01001B20;
 Mon, 23 Sep 2019 14:31:48 +0000 (UTC)
Subject: Re: [PATCH 2/4] target/arm: Move cortex-m related functions to new
 file v7m.c
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-3-thuth@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bd6efd14-9200-98e2-4f76-dda101f85274@redhat.com>
Date: Mon, 23 Sep 2019 16:31:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190921150420.30743-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 23 Sep 2019 14:31:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 9/21/19 5:04 PM, Thomas Huth wrote:
> We are going to make CONFIG_ARM_V7M optional, so the related cortex-m
> CPUs should only be created if the switch is enabled. This can best
> be done if the code resides in a separate file, thus move the related
> functions to a new file v7m.c which only gets compiled if CONFIG_ARM_V7M
> is enabled.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/Makefile.objs |   1 +
>  target/arm/cpu.c         | 146 -----------------------------
>  target/arm/v7m.c         | 193 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 194 insertions(+), 146 deletions(-)
>  create mode 100644 target/arm/v7m.c
> 
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index cf26c16f5f..16b9417a8b 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -61,6 +61,7 @@ obj-y += translate.o op_helper.o
>  obj-y += crypto_helper.o
>  obj-y += iwmmxt_helper.o vec_helper.o neon_helper.o
>  obj-y += m_helper.o
> +obj-$(CONFIG_ARM_V7M) += v7m.o
>  
>  obj-$(CONFIG_SOFTMMU) += psci.o
>  
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f1f9eecdc8..d5f0d4af61 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -462,31 +462,6 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>      return ret;
>  }
>  
> -#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
> -static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> -{
> -    CPUClass *cc = CPU_GET_CLASS(cs);
> -    ARMCPU *cpu = ARM_CPU(cs);
> -    CPUARMState *env = &cpu->env;
> -    bool ret = false;
> -
> -    /* ARMv7-M interrupt masking works differently than -A or -R.
> -     * There is no FIQ/IRQ distinction. Instead of I and F bits
> -     * masking FIQ and IRQ interrupts, an exception is taken only
> -     * if it is higher priority than the current execution priority
> -     * (which depends on state like BASEPRI, FAULTMASK and the
> -     * currently active exception).
> -     */
> -    if (interrupt_request & CPU_INTERRUPT_HARD
> -        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
> -        cs->exception_index = EXCP_IRQ;
> -        cc->do_interrupt(cs);
> -        ret = true;
> -    }
> -    return ret;
> -}
> -#endif
> -
>  void arm_cpu_update_virq(ARMCPU *cpu)
>  {
>      /*
> @@ -1881,119 +1856,6 @@ static void arm11mpcore_initfn(Object *obj)
>      cpu->reset_auxcr = 1;
>  }
>  
> -static void cortex_m0_initfn(Object *obj)
> -{
> -    ARMCPU *cpu = ARM_CPU(obj);
> -    set_feature(&cpu->env, ARM_FEATURE_V6);
> -    set_feature(&cpu->env, ARM_FEATURE_M);
> -
> -    cpu->midr = 0x410cc200;
> -}
> -
> -static void cortex_m3_initfn(Object *obj)
> -{
> -    ARMCPU *cpu = ARM_CPU(obj);
> -    set_feature(&cpu->env, ARM_FEATURE_V7);
> -    set_feature(&cpu->env, ARM_FEATURE_M);
> -    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> -    cpu->midr = 0x410fc231;
> -    cpu->pmsav7_dregion = 8;
> -    cpu->id_pfr0 = 0x00000030;
> -    cpu->id_pfr1 = 0x00000200;
> -    cpu->id_dfr0 = 0x00100000;
> -    cpu->id_afr0 = 0x00000000;
> -    cpu->id_mmfr0 = 0x00000030;
> -    cpu->id_mmfr1 = 0x00000000;
> -    cpu->id_mmfr2 = 0x00000000;
> -    cpu->id_mmfr3 = 0x00000000;
> -    cpu->isar.id_isar0 = 0x01141110;
> -    cpu->isar.id_isar1 = 0x02111000;
> -    cpu->isar.id_isar2 = 0x21112231;
> -    cpu->isar.id_isar3 = 0x01111110;
> -    cpu->isar.id_isar4 = 0x01310102;
> -    cpu->isar.id_isar5 = 0x00000000;
> -    cpu->isar.id_isar6 = 0x00000000;
> -}
> -
> -static void cortex_m4_initfn(Object *obj)
> -{
> -    ARMCPU *cpu = ARM_CPU(obj);
> -
> -    set_feature(&cpu->env, ARM_FEATURE_V7);
> -    set_feature(&cpu->env, ARM_FEATURE_M);
> -    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> -    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> -    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> -    cpu->midr = 0x410fc240; /* r0p0 */
> -    cpu->pmsav7_dregion = 8;
> -    cpu->isar.mvfr0 = 0x10110021;
> -    cpu->isar.mvfr1 = 0x11000011;
> -    cpu->isar.mvfr2 = 0x00000000;
> -    cpu->id_pfr0 = 0x00000030;
> -    cpu->id_pfr1 = 0x00000200;
> -    cpu->id_dfr0 = 0x00100000;
> -    cpu->id_afr0 = 0x00000000;
> -    cpu->id_mmfr0 = 0x00000030;
> -    cpu->id_mmfr1 = 0x00000000;
> -    cpu->id_mmfr2 = 0x00000000;
> -    cpu->id_mmfr3 = 0x00000000;
> -    cpu->isar.id_isar0 = 0x01141110;
> -    cpu->isar.id_isar1 = 0x02111000;
> -    cpu->isar.id_isar2 = 0x21112231;
> -    cpu->isar.id_isar3 = 0x01111110;
> -    cpu->isar.id_isar4 = 0x01310102;
> -    cpu->isar.id_isar5 = 0x00000000;
> -    cpu->isar.id_isar6 = 0x00000000;
> -}
> -
> -static void cortex_m33_initfn(Object *obj)
> -{
> -    ARMCPU *cpu = ARM_CPU(obj);
> -
> -    set_feature(&cpu->env, ARM_FEATURE_V8);
> -    set_feature(&cpu->env, ARM_FEATURE_M);
> -    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> -    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
> -    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> -    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> -    cpu->midr = 0x410fd213; /* r0p3 */
> -    cpu->pmsav7_dregion = 16;
> -    cpu->sau_sregion = 8;
> -    cpu->isar.mvfr0 = 0x10110021;
> -    cpu->isar.mvfr1 = 0x11000011;
> -    cpu->isar.mvfr2 = 0x00000040;
> -    cpu->id_pfr0 = 0x00000030;
> -    cpu->id_pfr1 = 0x00000210;
> -    cpu->id_dfr0 = 0x00200000;
> -    cpu->id_afr0 = 0x00000000;
> -    cpu->id_mmfr0 = 0x00101F40;
> -    cpu->id_mmfr1 = 0x00000000;
> -    cpu->id_mmfr2 = 0x01000000;
> -    cpu->id_mmfr3 = 0x00000000;
> -    cpu->isar.id_isar0 = 0x01101110;
> -    cpu->isar.id_isar1 = 0x02212000;
> -    cpu->isar.id_isar2 = 0x20232232;
> -    cpu->isar.id_isar3 = 0x01111131;
> -    cpu->isar.id_isar4 = 0x01310132;
> -    cpu->isar.id_isar5 = 0x00000000;
> -    cpu->isar.id_isar6 = 0x00000000;
> -    cpu->clidr = 0x00000000;
> -    cpu->ctr = 0x8000c000;
> -}
> -
> -static void arm_v7m_class_init(ObjectClass *oc, void *data)
> -{
> -    ARMCPUClass *acc = ARM_CPU_CLASS(oc);
> -    CPUClass *cc = CPU_CLASS(oc);
> -
> -    acc->info = data;
> -#ifndef CONFIG_USER_ONLY
> -    cc->do_interrupt = arm_v7m_cpu_do_interrupt;
> -#endif
> -
> -    cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
> -}
> -
>  static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
>      /* Dummy the TCM region regs for the moment */
>      { .name = "ATCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
> @@ -2518,14 +2380,6 @@ static const ARMCPUInfo arm_cpus[] = {
>      { .name = "arm1136",     .initfn = arm1136_initfn },
>      { .name = "arm1176",     .initfn = arm1176_initfn },
>      { .name = "arm11mpcore", .initfn = arm11mpcore_initfn },
> -    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
> -                             .class_init = arm_v7m_class_init },
> -    { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
> -                             .class_init = arm_v7m_class_init },
> -    { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
> -                             .class_init = arm_v7m_class_init },
> -    { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
> -                             .class_init = arm_v7m_class_init },
>      { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
>      { .name = "cortex-r5f",  .initfn = cortex_r5f_initfn },
>      { .name = "cortex-a7",   .initfn = cortex_a7_initfn },
> diff --git a/target/arm/v7m.c b/target/arm/v7m.c
> new file mode 100644
> index 0000000000..505043febe
> --- /dev/null
> +++ b/target/arm/v7m.c
> @@ -0,0 +1,193 @@
> +/*
> + * ARM v7m helpers.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/qemu-print.h"
> +#include "qemu-common.h"
> +#include "target/arm/idau.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "cpu.h"
> +#include "internals.h"
> +#include "exec/exec-all.h"
> +#include "hw/qdev-properties.h"
> +#if !defined(CONFIG_USER_ONLY)
> +#include "hw/loader.h"
> +#include "hw/boards.h"
> +#endif
> +#include "sysemu/sysemu.h"
> +#include "sysemu/tcg.h"
> +#include "sysemu/hw_accel.h"
> +#include "disas/capstone.h"
> +#include "fpu/softfloat.h"
I guess some of those headers are not needed.
> +
> +#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
> +
> +static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    bool ret = false;
> +
> +    /*
> +     * ARMv7-M interrupt masking works differently than -A or -R.
> +     * There is no FIQ/IRQ distinction. Instead of I and F bits
> +     * masking FIQ and IRQ interrupts, an exception is taken only
> +     * if it is higher priority than the current execution priority
> +     * (which depends on state like BASEPRI, FAULTMASK and the
> +     * currently active exception).
> +     */
> +    if (interrupt_request & CPU_INTERRUPT_HARD
> +        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
so what is the status wrt m_helper.c which stays unconditionally
compiled. m_helper functions seem to called from target/arm/translate.c
mostly. Have you abandoned the stub idea. It may be confusing to have 2
different helper files. At least a comment explaining where a new helper
shall go may be useful.

Thanks

Eric


> +        cs->exception_index = EXCP_IRQ;
> +        cc->do_interrupt(cs);
> +        ret = true;
> +    }
> +    return ret;
> +}
> +
> +static void cortex_m0_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_V6);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +
> +    cpu->midr = 0x410cc200;
> +}
> +
> +static void cortex_m3_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    cpu->midr = 0x410fc231;
> +    cpu->pmsav7_dregion = 8;
> +    cpu->id_pfr0 = 0x00000030;
> +    cpu->id_pfr1 = 0x00000200;
> +    cpu->id_dfr0 = 0x00100000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->id_mmfr0 = 0x00000030;
> +    cpu->id_mmfr1 = 0x00000000;
> +    cpu->id_mmfr2 = 0x00000000;
> +    cpu->id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01141110;
> +    cpu->isar.id_isar1 = 0x02111000;
> +    cpu->isar.id_isar2 = 0x21112231;
> +    cpu->isar.id_isar3 = 0x01111110;
> +    cpu->isar.id_isar4 = 0x01310102;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +}
> +
> +static void cortex_m4_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> +    cpu->midr = 0x410fc240; /* r0p0 */
> +    cpu->pmsav7_dregion = 8;
> +    cpu->isar.mvfr0 = 0x10110021;
> +    cpu->isar.mvfr1 = 0x11000011;
> +    cpu->isar.mvfr2 = 0x00000000;
> +    cpu->id_pfr0 = 0x00000030;
> +    cpu->id_pfr1 = 0x00000200;
> +    cpu->id_dfr0 = 0x00100000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->id_mmfr0 = 0x00000030;
> +    cpu->id_mmfr1 = 0x00000000;
> +    cpu->id_mmfr2 = 0x00000000;
> +    cpu->id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01141110;
> +    cpu->isar.id_isar1 = 0x02111000;
> +    cpu->isar.id_isar2 = 0x21112231;
> +    cpu->isar.id_isar3 = 0x01111110;
> +    cpu->isar.id_isar4 = 0x01310102;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +}
> +
> +static void cortex_m33_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
> +    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
> +    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
> +    set_feature(&cpu->env, ARM_FEATURE_VFP4);
> +    cpu->midr = 0x410fd213; /* r0p3 */
> +    cpu->pmsav7_dregion = 16;
> +    cpu->sau_sregion = 8;
> +    cpu->isar.mvfr0 = 0x10110021;
> +    cpu->isar.mvfr1 = 0x11000011;
> +    cpu->isar.mvfr2 = 0x00000040;
> +    cpu->id_pfr0 = 0x00000030;
> +    cpu->id_pfr1 = 0x00000210;
> +    cpu->id_dfr0 = 0x00200000;
> +    cpu->id_afr0 = 0x00000000;
> +    cpu->id_mmfr0 = 0x00101F40;
> +    cpu->id_mmfr1 = 0x00000000;
> +    cpu->id_mmfr2 = 0x01000000;
> +    cpu->id_mmfr3 = 0x00000000;
> +    cpu->isar.id_isar0 = 0x01101110;
> +    cpu->isar.id_isar1 = 0x02212000;
> +    cpu->isar.id_isar2 = 0x20232232;
> +    cpu->isar.id_isar3 = 0x01111131;
> +    cpu->isar.id_isar4 = 0x01310132;
> +    cpu->isar.id_isar5 = 0x00000000;
> +    cpu->isar.id_isar6 = 0x00000000;
> +    cpu->clidr = 0x00000000;
> +    cpu->ctr = 0x8000c000;
> +}
> +
> +static void arm_v7m_class_init(ObjectClass *oc, void *data)
> +{
> +    ARMCPUClass *acc = ARM_CPU_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
> +
> +    acc->info = data;
> +#ifndef CONFIG_USER_ONLY
> +    cc->do_interrupt = arm_v7m_cpu_do_interrupt;
> +#endif
> +
> +    cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
> +}
> +
> +static const ARMCPUInfo arm_v7m_cpus[] = {
> +    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
> +                             .class_init = arm_v7m_class_init },
> +    { .name = NULL }
> +};
> +
> +static void arm_v7m_cpu_register_types(void)
> +{
> +    const ARMCPUInfo *info = arm_v7m_cpus;
> +
> +    while (info->name) {
> +        arm_cpu_register(info);
> +        info++;
> +    }
> +}
> +
> +type_init(arm_v7m_cpu_register_types)
> +
> +#endif
> 
Thanks

Eric

