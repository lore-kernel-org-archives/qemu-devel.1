Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E73EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DB821744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQi8LrMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DB821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOplO-0000kv-H9
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:35:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpkS-0000LK-Lr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpkQ-000493-PS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:34:36 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:42775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOpkQ-00047v-EF
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:34:34 -0400
Received: by mail-lf1-x142.google.com with SMTP id w23so2511990lfc.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XxAmdjRUOsVZk+HMyo3IPS4THu1eDVK77Nu5V5EUZYs=;
	b=iQi8LrMGN12nEeHcQGBYftMRXPFnbLJTkaQCSBXq7FT+CMmUj9ie/80ZQFP1hUVJUS
	q26PPqRZuJF3r6zAUQ8TECUa1RimoUQk+F5XRR3ho9sccgu4AtBv0wCJwVXZJ/1oz732
	8pLA6Ntmnpn12ekXAhamXr1GvHuEKOPpvzwGl+d/OHAbFxdJHoontMcBUTc6xIpYhX8k
	yunPzLY7Gz87/gqJjFjy8xdatUi6f6Dg5Ar1jN/SoFlbCo34j9owywLzEY0lHg0byMPp
	Vy1Ab9P6OAHJnNx1a4LD+BjdpoVkESKPh4GecWPQHImgS7x4fOXMxiaHWSROUiSmvjnJ
	CB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XxAmdjRUOsVZk+HMyo3IPS4THu1eDVK77Nu5V5EUZYs=;
	b=HDWPlclAtIDwL091Jvuuw7HpQnEeG9mulCsrfA3r5M8oJ5OPMaZhgb6i+Zf3zqfpxd
	HngQqX6YZiz2N8sIO9rLe65RFJ/rp7zN8Uv1es0fqRRLGrs1pCKssK4Vg2VERYxLLb/v
	t/jtIRlEO10rbrPEf0eAbi6gxnIJ3RLh81JiamYdsuvxqhdArVQNE88c7G4e+ikjW317
	KfHRfPPmeWvehr7ZjkBx5hxaT23z6qlqda3DtrH6R9dFpN1+mGmsCg/VGhNEJ5sUp1f6
	sgUqQWgQodZJNsWzsNt4fhrUMkNEp9lyKM1XmPh3vaDl6GIdRR//sGNk7mkp1/rpNzqb
	cdXA==
X-Gm-Message-State: APjAAAXljY1Z+XUy/XpJcrf1O7wtZcr8VYmIVI1xcqCHLfrrq42rWFRn
	29Uun1AiIeQWQ0RRJwLEVNx3muF+BJIgx5IR7cE=
X-Google-Smtp-Source: APXvYqx2Roz7nAnmH8VIGgGYjUsOPEPrCLRNSyrvJzZNkBfGneS/eiS/JlGkw/o8JWcei37Jz8WH/9IlwHHPPzutNHk=
X-Received: by 2002:a19:189:: with SMTP id 131mr3571288lfb.74.1557434072719;
	Thu, 09 May 2019 13:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-33-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-33-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:32:25 -0700
Message-ID: <CAKmqyKPCdEvGy_QPwA_jsEUakAJ1QOm_HoHRcD9ukUmROD=KtQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v3 32/39] cpu: Introduce
 cpu_set_cpustate_pointers
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:37 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Consolidate some boilerplate from foo_cpu_initfn.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/cpu-all.h          | 11 +++++++++++
>  target/alpha/cpu.c              |  3 +--
>  target/arm/cpu.c                |  3 +--
>  target/cris/cpu.c               |  3 +--
>  target/hppa/cpu.c               |  2 +-
>  target/i386/cpu.c               |  3 +--
>  target/lm32/cpu.c               |  3 +--
>  target/m68k/cpu.c               |  4 +---
>  target/microblaze/cpu.c         |  3 +--
>  target/mips/cpu.c               |  3 +--
>  target/moxie/cpu.c              |  3 +--
>  target/nios2/cpu.c              |  6 ++----
>  target/openrisc/cpu.c           |  3 +--
>  target/ppc/translate_init.inc.c |  3 +--
>  target/riscv/cpu.c              |  3 +--
>  target/s390x/cpu.c              |  9 +++++----
>  target/sh4/cpu.c                |  3 +--
>  target/sparc/cpu.c              |  3 +--
>  target/tilegx/cpu.c             |  4 +---
>  target/tricore/cpu.c            |  4 +---
>  target/unicore32/cpu.c          |  3 +--
>  target/xtensa/cpu.c             |  3 +--
>  22 files changed, 37 insertions(+), 48 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index c62f07b354..71154070a7 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -371,6 +371,17 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
>
>  int cpu_exec(CPUState *cpu);
>
> +/**
> + * cpu_set_cpustate_pointers(cpu)
> + * @cpu: The cpu object
> + *
> + * Set the generic pointers in CPUState into the outer object.
> + */
> +static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
> +{
> +    cpu->parent_obj.env_ptr = &cpu->env;
> +}
> +
>  /**
>   * env_archcpu(env)
>   * @env: The architecture environment
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index ad3588a44a..b771b9f3fe 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -191,11 +191,10 @@ static void ev67_cpu_initfn(Object *obj)
>
>  static void alpha_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      AlphaCPU *cpu = ALPHA_CPU(obj);
>      CPUAlphaState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>      env->lock_addr = -1;
>  #if defined(CONFIG_USER_ONLY)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a181fa8dc1..79d5096270 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -698,10 +698,9 @@ static void cpreg_hashtable_data_destroy(gpointer data)
>
>  static void arm_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      ARMCPU *cpu = ARM_CPU(obj);
>
> -    cs->env_ptr = &cpu->env;
> +    cpu_set_cpustate_pointers(cpu);
>      cpu->cp_regs = g_hash_table_new_full(g_int_hash, g_int_equal,
>                                           g_free, cpreg_hashtable_data_destroy);
>
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index 75729bfdd5..070f8be363 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -172,12 +172,11 @@ static void cris_disas_set_info(CPUState *cpu, disassemble_info *info)
>
>  static void cris_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      CRISCPU *cpu = CRIS_CPU(obj);
>      CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
>      CPUCRISState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>      env->pregs[PR_VR] = ccc->vr;
>
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index e64f48581e..fdff057793 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -134,7 +134,7 @@ static void hppa_cpu_initfn(Object *obj)
>      HPPACPU *cpu = HPPA_CPU(obj);
>      CPUHPPAState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>      cs->exception_index = -1;
>      cpu_hppa_loaded_fr0(env);
>      cpu_hppa_put_psw(env, PSW_W);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5b84629f91..7eff4c4dea 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5588,13 +5588,12 @@ static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
>
>  static void x86_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      X86CPU *cpu = X86_CPU(obj);
>      X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
>      CPUX86State *env = &cpu->env;
>      FeatureWord w;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>      object_property_add(obj, "family", "int",
>                          x86_cpuid_version_get_family,
> diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
> index 282da19994..ebcbd2faa8 100644
> --- a/target/lm32/cpu.c
> +++ b/target/lm32/cpu.c
> @@ -142,11 +142,10 @@ static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void lm32_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      LM32CPU *cpu = LM32_CPU(obj);
>      CPULM32State *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>      env->flags = 0;
>  }
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 582e3a73b3..930e1be59f 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -238,11 +238,9 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void m68k_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      M68kCPU *cpu = M68K_CPU(obj);
> -    CPUM68KState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>  }
>
>  static const VMStateDescription vmstate_m68k_cpu = {
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 5596cd5485..db4dcdb4ad 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -221,11 +221,10 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void mb_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      MicroBlazeCPU *cpu = MICROBLAZE_CPU(obj);
>      CPUMBState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>      set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
>
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index e217fb3e36..3d1b693eef 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -152,12 +152,11 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void mips_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      MIPSCPU *cpu = MIPS_CPU(obj);
>      CPUMIPSState *env = &cpu->env;
>      MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>      env->cpu_model = mcc->cpu_def;
>  }
>
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index 46434e65ba..316ee9c534 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -74,10 +74,9 @@ static void moxie_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void moxie_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      MoxieCPU *cpu = MOXIE_CPU(obj);
>
> -    cs->env_ptr = &cpu->env;
> +    cpu_set_cpustate_pointers(cpu);
>  }
>
>  static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
> diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
> index fbfaa2ce26..43677fa802 100644
> --- a/target/nios2/cpu.c
> +++ b/target/nios2/cpu.c
> @@ -66,14 +66,12 @@ static void nios2_cpu_reset(CPUState *cs)
>
>  static void nios2_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      Nios2CPU *cpu = NIOS2_CPU(obj);
> -    CPUNios2State *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>  #if !defined(CONFIG_USER_ONLY)
> -    mmu_init(env);
> +    mmu_init(&cpu->env);
>  #endif
>  }
>
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index d125236977..5177575821 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -92,10 +92,9 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void openrisc_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      OpenRISCCPU *cpu = OPENRISC_CPU(obj);
>
> -    cs->env_ptr = &cpu->env;
> +    cpu_set_cpustate_pointers(cpu);
>  }
>
>  /* CPU models */
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 6343e25624..739c14fd26 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10473,12 +10473,11 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
>
>  static void ppc_cpu_instance_init(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      PowerPCCPU *cpu = POWERPC_CPU(obj);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>      cpu->vcpu_id = UNASSIGNED_CPU_INDEX;
>
>      env->msr_mask = pcc->msr_mask;
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1bcf4eaeb8..35e69a9e12 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -315,10 +315,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>
>  static void riscv_cpu_init(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      RISCVCPU *cpu = RISCV_CPU(obj);
>
> -    cs->env_ptr = &cpu->env;
> +    cpu_set_cpustate_pointers(cpu);
>  }
>
>  static const VMStateDescription vmstate_riscv_cpu = {
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index b58ef0a8ef..16bcb933ec 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -282,17 +282,18 @@ static void s390_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
>      S390CPU *cpu = S390_CPU(obj);
> -    CPUS390XState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>      cs->halted = 1;
>      cs->exception_index = EXCP_HLT;
>      object_property_add(obj, "crash-information", "GuestPanicInformation",
>                          s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
>      s390_cpu_model_register_props(obj);
>  #if !defined(CONFIG_USER_ONLY)
> -    env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> -    env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
> +    cpu->env.tod_timer =
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> +    cpu->env.cpu_timer =
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>  #endif
>  }
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index da2799082e..62a9123173 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -194,11 +194,10 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void superh_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      SuperHCPU *cpu = SUPERH_CPU(obj);
>      CPUSH4State *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>      env->movcal_backup_tail = &(env->movcal_backup);
>  }
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 4654c2a6a0..90109754eb 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -774,12 +774,11 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void sparc_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      SPARCCPU *cpu = SPARC_CPU(obj);
>      SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(obj);
>      CPUSPARCState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>      if (scc->cpu_def) {
>          env->def = *scc->cpu_def;
> diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
> index b9d37105fa..0bfd4187b8 100644
> --- a/target/tilegx/cpu.c
> +++ b/target/tilegx/cpu.c
> @@ -99,11 +99,9 @@ static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void tilegx_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      TileGXCPU *cpu = TILEGX_CPU(obj);
> -    CPUTLGState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>  }
>
>  static void tilegx_cpu_do_interrupt(CPUState *cs)
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index e8d37e4040..fc3c3075b3 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -104,11 +104,9 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void tricore_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      TriCoreCPU *cpu = TRICORE_CPU(obj);
> -    CPUTriCoreState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>  }
>
>  static ObjectClass *tricore_cpu_class_by_name(const char *cpu_model)
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index 2b49d1ca40..700c5c5585 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -103,11 +103,10 @@ static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void uc32_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      UniCore32CPU *cpu = UNICORE32_CPU(obj);
>      CPUUniCore32State *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>
>  #ifdef CONFIG_USER_ONLY
>      env->uncached_asr = ASR_MODE_USER;
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index a54dbe4260..9461ebad02 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -138,12 +138,11 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void xtensa_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
>      XtensaCPU *cpu = XTENSA_CPU(obj);
>      XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
>      CPUXtensaState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>      env->config = xcc->config;
>
>  #ifndef CONFIG_USER_ONLY
> --
> 2.17.1
>
>

