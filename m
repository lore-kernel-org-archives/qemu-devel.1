Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AEEC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08247217D9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juKCIrEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08247217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59310 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnpR-0003vt-7a
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:31:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnoF-0002wX-Hq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnoB-00052f-0w
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:30:23 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnoA-0004w2-EA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:30:18 -0400
Received: by mail-lj1-x242.google.com with SMTP id e13so2853355ljl.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8QxLdWxWU0sOzThchoxFuRa2TLK8f8AnbwGloUsaF24=;
	b=juKCIrEqEfPWwY1tLVh8Kp1WQUQYhlMnS2HpE8mAGQd1ftCWahp0U83FOWve6WVhin
	upK1yo0knEgDllllv+7KxN47GJMl3EBcTtSWsLBpPqzNSw67LSE+izInKHbcOI1p5VcS
	42AWdLRpjKO7Y81l0dYX938XWIAGpX8KNqonLhXFqHOhdd7VMLEC0cjkmwm3WiZlBT57
	UK/K1WmpIzUc8mCV99hwcMtLrxWbwpE8IUhKar4kYAypEuqWNyr6ahj/ML7ZwO8VPw1X
	QjoYSW0DbzlUu1zYdDgOoBAdKhJyBwGcHdSFCQXxLnbSI1EDkfd/2FMoqfXLgxvkur/p
	ER8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8QxLdWxWU0sOzThchoxFuRa2TLK8f8AnbwGloUsaF24=;
	b=n5P7W/rDza5kqWkg7cAwL7ihCjHecwYbrJ6qK4xNG/5UvwojLPQdOL+m4Ntq5XVkaI
	vPrb2JPajkdIzied8JTnm36J3dvFmVyp5H8zvU0NvdLnQn4mEYz9HWqjLnyF7vR41A6i
	o9IZaXlfPIsMtM/7AuLTJYIvQ5F1Zxd8he6vJhV/3YyaJxbr/zb2C/m8AKhF5P2UwnDY
	YTCvMg0m8yqBqPqtnqQewE4ZN5v9sRFz6p4rLa8Rg7pVqf6c1hl1gI/sRMdtvrYZ/dp+
	iu+vPE15Ytz328883GmOPJkT/z/6jiJTg1tkxrKxFb5M4a3/oaPypdQQOFtAAzI2IgS1
	7oeQ==
X-Gm-Message-State: APjAAAVofm3/hPoJPmhYgm57AXt1Ng5VxN4LHeDcn96d/Q5z55EY1GIh
	c3kL5piwqZdc3DF9Hivq8OLBDrrEYj+C/ifbB2Q=
X-Google-Smtp-Source: APXvYqwZDgnngM5h3Mu0LW37AukL/YL7EfG/LgOK0DEEBAa3yRzKXauPirlfwDVzf4e9gCnLf1oFmPXVTszDXoPdgQ0=
X-Received: by 2002:a2e:8988:: with SMTP id c8mr2941983lji.99.1557426616082;
	Thu, 09 May 2019 11:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-23-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-23-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:28:09 -0700
Message-ID: <CAKmqyKNNO+6kcCFtaFo+aOPe4NpUvtOtGe51VfTZFfQt-WL9Zg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 22/39] target/ppc: Use env_cpu,
 env_archcpu
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

On Tue, May 7, 2019 at 5:27 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/ppc/cpu.h                |   7 +-
>  target/ppc/helper_regs.h        |   4 +-
>  hw/ppc/ppc.c                    |  18 ++---
>  hw/ppc/ppc405_uc.c              |   2 +-
>  hw/ppc/ppc_booke.c              |   4 +-
>  linux-user/ppc/cpu_loop.c       |   2 +-
>  target/ppc/excp_helper.c        |  14 ++--
>  target/ppc/fpu_helper.c         |  14 ++--
>  target/ppc/kvm.c                |   5 +-
>  target/ppc/misc_helper.c        |  22 ++----
>  target/ppc/mmu-hash64.c         |  14 ++--
>  target/ppc/mmu_helper.c         | 115 +++++++++++++-------------------
>  target/ppc/translate_init.inc.c |  85 ++++++++++++-----------
>  13 files changed, 134 insertions(+), 172 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 3449b0b085..ef00a3415d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1203,11 +1203,6 @@ struct PowerPCCPU {
>      int32_t mig_slb_nr;
>  };
>
> -static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
> -{
> -    return container_of(env, PowerPCCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(PowerPCCPU, env)
>
>  PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
> @@ -2451,7 +2446,7 @@ static inline int booke206_tlbm_to_tlbn(CPUPPCState *env, ppcmas_tlb_t *tlbm)
>          }
>      }
>
> -    cpu_abort(CPU(ppc_env_get_cpu(env)), "Unknown TLBe: %d\n", id);
> +    cpu_abort(env_cpu(env), "Unknown TLBe: %d\n", id);
>      return 0;
>  }
>
> diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
> index 922da76c6c..85dfe7687f 100644
> --- a/target/ppc/helper_regs.h
> +++ b/target/ppc/helper_regs.h
> @@ -116,7 +116,7 @@ static inline int hreg_store_msr(CPUPPCState *env, target_ulong value,
>  {
>      int excp;
>  #if !defined(CONFIG_USER_ONLY)
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  #endif
>
>      excp = 0;
> @@ -175,7 +175,7 @@ static inline int hreg_store_msr(CPUPPCState *env, target_ulong value,
>  #if !defined(CONFIG_USER_ONLY)
>  static inline void check_tlb_flush(CPUPPCState *env, bool global)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      /* Handle global flushes first */
>      if (global && (env->tlb_need_flush & TLB_NEED_GLOBAL_FLUSH)) {
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index ad20584f26..debcdab993 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -385,7 +385,7 @@ void ppc40x_system_reset(PowerPCCPU *cpu)
>
>  void store_40x_dbcr0(CPUPPCState *env, uint32_t val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>
>      switch ((val >> 28) & 0x3) {
>      case 0x0:
> @@ -785,7 +785,7 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
>
>  target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      ppc_tb_t *tb_env = env->tb_env;
>      uint64_t hdecr;
> @@ -923,7 +923,7 @@ static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
>
>  void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      int nr_bits = 32;
>
> @@ -955,7 +955,7 @@ static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hdecr,
>
>  void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>
>      _cpu_ppc_store_hdecr(cpu, cpu_ppc_load_hdecr(env), value,
> @@ -980,7 +980,7 @@ static void cpu_ppc_store_purr(PowerPCCPU *cpu, uint64_t value)
>  static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
>  {
>      CPUPPCState *env = opaque;
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      ppc_tb_t *tb_env = env->tb_env;
>
>      tb_env->tb_freq = freq;
> @@ -1095,7 +1095,7 @@ const VMStateDescription vmstate_ppc_timebase = {
>  /* Set up (once) timebase frequency (in Hz) */
>  clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      ppc_tb_t *tb_env;
>
>      tb_env = g_malloc0(sizeof(ppc_tb_t));
> @@ -1165,7 +1165,7 @@ static void cpu_4xx_fit_cb (void *opaque)
>      uint64_t now, next;
>
>      env = opaque;
> -    cpu = ppc_env_get_cpu(env);
> +    cpu = env_archcpu(env);
>      tb_env = env->tb_env;
>      ppc40x_timer = tb_env->opaque;
>      now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> @@ -1235,7 +1235,7 @@ static void cpu_4xx_pit_cb (void *opaque)
>      ppc40x_timer_t *ppc40x_timer;
>
>      env = opaque;
> -    cpu = ppc_env_get_cpu(env);
> +    cpu = env_archcpu(env);
>      tb_env = env->tb_env;
>      ppc40x_timer = tb_env->opaque;
>      env->spr[SPR_40x_TSR] |= 1 << 27;
> @@ -1261,7 +1261,7 @@ static void cpu_4xx_wdt_cb (void *opaque)
>      uint64_t now, next;
>
>      env = opaque;
> -    cpu = ppc_env_get_cpu(env);
> +    cpu = env_archcpu(env);
>      tb_env = env->tb_env;
>      ppc40x_timer = tb_env->opaque;
>      now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 3ae7f6d4df..018dcca888 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -49,7 +49,7 @@
>  ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
>                                  uint32_t flags)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      ram_addr_t bdloc;
>      int i, n;
>
> diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
> index 4f11e00a17..323413e074 100644
> --- a/hw/ppc/ppc_booke.c
> +++ b/hw/ppc/ppc_booke.c
> @@ -249,7 +249,7 @@ static void booke_wdt_cb(void *opaque)
>
>  void store_booke_tsr(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      ppc_tb_t *tb_env = env->tb_env;
>      booke_timer_t *booke_timer = tb_env->opaque;
>
> @@ -277,7 +277,7 @@ void store_booke_tsr(CPUPPCState *env, target_ulong val)
>
>  void store_booke_tcr(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      ppc_tb_t *tb_env = env->tb_env;
>      booke_timer_t *booke_timer = tb_env->opaque;
>
> diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
> index 801f5ace29..24dfdba854 100644
> --- a/linux-user/ppc/cpu_loop.c
> +++ b/linux-user/ppc/cpu_loop.c
> @@ -67,7 +67,7 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val)
>
>  void cpu_loop(CPUPPCState *env)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      target_siginfo_t info;
>      int trapnr;
>      target_ulong ret;
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index ec2c177091..50b004d00d 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -49,7 +49,7 @@ void ppc_cpu_do_interrupt(CPUState *cs)
>
>  static void ppc_hw_interrupt(CPUPPCState *env)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = POWERPC_EXCP_NONE;
>      env->error_code = 0;
> @@ -792,7 +792,7 @@ void ppc_cpu_do_interrupt(CPUState *cs)
>
>  static void ppc_hw_interrupt(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      bool async_deliver;
>
>      /* External reset */
> @@ -931,7 +931,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>           * It generally means a discrepancy between the wakup conditions in the
>           * processor has_work implementation and the logic in this function.
>           */
> -        cpu_abort(CPU(ppc_env_get_cpu(env)),
> +        cpu_abort(env_cpu(env),
>                    "Wakeup from PM state but interrupt Undelivered");
>      }
>  }
> @@ -974,7 +974,7 @@ static void cpu_dump_rfi(target_ulong RA, target_ulong msr)
>  void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
>                              uint32_t error_code, uintptr_t raddr)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = exception;
>      env->error_code = error_code;
> @@ -1015,7 +1015,7 @@ void helper_store_msr(CPUPPCState *env, target_ulong val)
>      uint32_t excp = hreg_store_msr(env, val, 0);
>
>      if (excp != 0) {
> -        CPUState *cs = CPU(ppc_env_get_cpu(env));
> +        CPUState *cs = env_cpu(env);
>          cpu_interrupt_exittb(cs);
>          raise_exception(env, excp);
>      }
> @@ -1026,7 +1026,7 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_t insn)
>  {
>      CPUState *cs;
>
> -    cs = CPU(ppc_env_get_cpu(env));
> +    cs = env_cpu(env);
>      cs->halted = 1;
>
>      /*
> @@ -1043,7 +1043,7 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_t insn)
>
>  static inline void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      /* MSR:POW cannot be set by any form of rfi */
>      msr &= ~(1ULL << MSR_POW);
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 0b7308f539..ffbd19afa1 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -271,7 +271,7 @@ static void float_invalid_op_vxvc(CPUPPCState *env, bool set_fpcc,
>      env->fpscr |= FP_FX;
>      /* We must update the target FPR before raising the exception */
>      if (fpscr_ve != 0) {
> -        CPUState *cs = CPU(ppc_env_get_cpu(env));
> +        CPUState *cs = env_cpu(env);
>
>          cs->exception_index = POWERPC_EXCP_PROGRAM;
>          env->error_code = POWERPC_EXCP_FP | POWERPC_EXCP_FP_VXVC;
> @@ -315,7 +315,7 @@ static inline void float_zero_divide_excp(CPUPPCState *env, uintptr_t raddr)
>
>  static inline void float_overflow_excp(CPUPPCState *env)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      env->fpscr |= 1 << FPSCR_OX;
>      /* Update the floating-point exception summary */
> @@ -335,7 +335,7 @@ static inline void float_overflow_excp(CPUPPCState *env)
>
>  static inline void float_underflow_excp(CPUPPCState *env)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      env->fpscr |= 1 << FPSCR_UX;
>      /* Update the floating-point exception summary */
> @@ -352,7 +352,7 @@ static inline void float_underflow_excp(CPUPPCState *env)
>
>  static inline void float_inexact_excp(CPUPPCState *env)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      env->fpscr |= 1 << FPSCR_FI;
>      env->fpscr |= 1 << FPSCR_XX;
> @@ -442,7 +442,7 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
>
>  void helper_fpscr_setbit(CPUPPCState *env, uint32_t bit)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int prev;
>
>      prev = (env->fpscr >> bit) & 1;
> @@ -574,7 +574,7 @@ void helper_fpscr_setbit(CPUPPCState *env, uint32_t bit)
>
>  void helper_store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      target_ulong prev, new;
>      int i;
>
> @@ -612,7 +612,7 @@ void store_fpscr(CPUPPCState *env, uint64_t arg, uint32_t mask)
>
>  static void do_float_check_status(CPUPPCState *env, uintptr_t raddr)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int status = get_float_exception_flags(&env->fp_status);
>      bool inexact_happened = false;
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 02e22e2017..4228cddcdc 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1989,9 +1989,8 @@ static int kvmppc_get_dec_bits(void)
>  }
>
>  static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pvinfo)
> - {
> -     PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -     CPUState *cs = CPU(cpu);
> +{
> +    CPUState *cs = env_cpu(env);
>
>      if (kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO) &&
>          !kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_PVINFO, pvinfo)) {
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 0a81e98ee9..49a8a02363 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -81,28 +81,24 @@ void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
>
>  void helper_store_sdr1(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      if (env->spr[SPR_SDR1] != val) {
>          ppc_store_sdr1(env, val);
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>      }
>  }
>
>  #if defined(TARGET_PPC64)
>  void helper_store_ptcr(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      if (env->spr[SPR_PTCR] != val) {
>          ppc_store_ptcr(env, val);
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>      }
>  }
>
>  void helper_store_pcr(CPUPPCState *env, target_ulong value)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>
>      env->spr[SPR_PCR] = value & pcc->pcr_mask;
> @@ -111,16 +107,12 @@ void helper_store_pcr(CPUPPCState *env, target_ulong value)
>
>  void helper_store_pidr(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      env->spr[SPR_BOOKS_PID] = val;
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>  }
>
>  void helper_store_lpidr(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      env->spr[SPR_LPIDR] = val;
>
>      /*
> @@ -129,7 +121,7 @@ void helper_store_lpidr(CPUPPCState *env, target_ulong val)
>       * potentially access and cache entries for the current LPID as
>       * well.
>       */
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>  }
>
>  void helper_store_hid0_601(CPUPPCState *env, target_ulong val)
> @@ -151,12 +143,10 @@ void helper_store_hid0_601(CPUPPCState *env, target_ulong val)
>
>  void helper_store_403_pbr(CPUPPCState *env, uint32_t num, target_ulong value)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      if (likely(env->pb[num] != value)) {
>          env->pb[num] = value;
>          /* Should be optimized */
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>      }
>  }
>
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 7899eb2918..da8966ccf5 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -96,7 +96,7 @@ void dump_slb(PowerPCCPU *cpu)
>
>  void helper_slbia(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      int n;
>
>      /* XXX: Warning: slbia never invalidates the first segment */
> @@ -118,7 +118,7 @@ void helper_slbia(CPUPPCState *env)
>  static void __helper_slbie(CPUPPCState *env, target_ulong addr,
>                             target_ulong global)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      ppc_slb_t *slb;
>
>      slb = slb_lookup(cpu, addr);
> @@ -251,7 +251,7 @@ static int ppc_find_slb_vsid(PowerPCCPU *cpu, target_ulong rb,
>
>  void helper_store_slb(CPUPPCState *env, target_ulong rb, target_ulong rs)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>
>      if (ppc_store_slb(cpu, rb & 0xfff, rb & ~0xfffULL, rs) < 0) {
>          raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> @@ -261,7 +261,7 @@ void helper_store_slb(CPUPPCState *env, target_ulong rb, target_ulong rs)
>
>  target_ulong helper_load_slb_esid(CPUPPCState *env, target_ulong rb)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      target_ulong rt = 0;
>
>      if (ppc_load_slb_esid(cpu, rb, &rt) < 0) {
> @@ -273,7 +273,7 @@ target_ulong helper_load_slb_esid(CPUPPCState *env, target_ulong rb)
>
>  target_ulong helper_find_slb_vsid(CPUPPCState *env, target_ulong rb)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      target_ulong rt = 0;
>
>      if (ppc_find_slb_vsid(cpu, rb, &rt) < 0) {
> @@ -285,7 +285,7 @@ target_ulong helper_find_slb_vsid(CPUPPCState *env, target_ulong rb)
>
>  target_ulong helper_load_slb_vsid(CPUPPCState *env, target_ulong rb)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      target_ulong rt = 0;
>
>      if (ppc_load_slb_vsid(cpu, rb, &rt) < 0) {
> @@ -1163,7 +1163,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>
>  void helper_store_lpcr(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>
>      ppc_store_lpcr(cpu, val);
>  }
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index b32693f24e..44afcee461 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -239,7 +239,6 @@ static inline int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>
>  static inline void ppc6xx_tlb_invalidate_all(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      ppc6xx_tlb_t *tlb;
>      int nr, max;
>
> @@ -253,7 +252,7 @@ static inline void ppc6xx_tlb_invalidate_all(CPUPPCState *env)
>          tlb = &env->tlb.tlb6[nr];
>          pte_invalidate(&tlb->pte0);
>      }
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>  }
>
>  static inline void ppc6xx_tlb_invalidate_virt2(CPUPPCState *env,
> @@ -261,7 +260,7 @@ static inline void ppc6xx_tlb_invalidate_virt2(CPUPPCState *env,
>                                                 int is_code, int match_epn)
>  {
>  #if !defined(FLUSH_ALL_TLBS)
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      ppc6xx_tlb_t *tlb;
>      int way, nr;
>
> @@ -474,7 +473,7 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
>  static inline int get_segment_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
>                                        target_ulong eaddr, int rw, int type)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      hwaddr hash;
>      target_ulong vsid;
>      int ds, pr, target_page_bits;
> @@ -670,7 +669,6 @@ static int ppcemb_tlb_search(CPUPPCState *env, target_ulong address,
>  /* Helpers specific to PowerPC 40x implementations */
>  static inline void ppc4xx_tlb_invalidate_all(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      ppcemb_tlb_t *tlb;
>      int i;
>
> @@ -678,7 +676,7 @@ static inline void ppc4xx_tlb_invalidate_all(CPUPPCState *env)
>          tlb = &env->tlb.tlbe[i];
>          tlb->prot &= ~PAGE_VALID;
>      }
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>  }
>
>  static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> @@ -749,11 +747,10 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>
>  void store_40x_sler(CPUPPCState *env, uint32_t val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      /* XXX: TO BE FIXED */
>      if (val != 0x00000000) {
> -        cpu_abort(CPU(cpu), "Little-endian regions are not supported by now\n");
> +        cpu_abort(env_cpu(env),
> +                  "Little-endian regions are not supported by now\n");
>      }
>      env->spr[SPR_405_SLER] = val;
>  }
> @@ -863,7 +860,6 @@ static int mmubooke_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
>  static void booke206_flush_tlb(CPUPPCState *env, int flags,
>                                 const int check_iprot)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      int tlb_size;
>      int i, j;
>      ppcmas_tlb_t *tlb = env->tlb.tlbm;
> @@ -880,7 +876,7 @@ static void booke206_flush_tlb(CPUPPCState *env, int flags,
>          tlb += booke206_tlb_size(env, i);
>      }
>
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>  }
>
>  static hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
> @@ -1275,7 +1271,7 @@ static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
>
>  static void mmu6xx_dump_mmu(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      ppc6xx_tlb_t *tlb;
>      target_ulong sr;
>      int type, way, entry, i;
> @@ -1347,13 +1343,13 @@ void dump_mmu(CPUPPCState *env)
>      case POWERPC_MMU_2_03:
>      case POWERPC_MMU_2_06:
>      case POWERPC_MMU_2_07:
> -        dump_slb(ppc_env_get_cpu(env));
> +        dump_slb(env_archcpu(env));
>          break;
>      case POWERPC_MMU_3_00:
> -        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
> +        if (ppc64_v3_radix(env_archcpu(env))) {
>              /* TODO - Unsupported */
>          } else {
> -            dump_slb(ppc_env_get_cpu(env));
> +            dump_slb(env_archcpu(env));
>              break;
>          }
>  #endif
> @@ -1419,7 +1415,6 @@ static int get_physical_address_wtlb(
>      target_ulong eaddr, int rw, int access_type,
>      int mmu_idx)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      int ret = -1;
>      bool real_mode = (access_type == ACCESS_CODE && msr_ir == 0)
>          || (access_type != ACCESS_CODE && msr_dr == 0);
> @@ -1460,18 +1455,18 @@ static int get_physical_address_wtlb(
>          break;
>      case POWERPC_MMU_MPC8xx:
>          /* XXX: TODO */
> -        cpu_abort(CPU(cpu), "MPC8xx MMU model is not implemented\n");
> +        cpu_abort(env_cpu(env), "MPC8xx MMU model is not implemented\n");
>          break;
>      case POWERPC_MMU_REAL:
>          if (real_mode) {
>              ret = check_physical(env, ctx, eaddr, rw);
>          } else {
> -            cpu_abort(CPU(cpu),
> +            cpu_abort(env_cpu(env),
>                        "PowerPC in real mode do not do any translation\n");
>          }
>          return -1;
>      default:
> -        cpu_abort(CPU(cpu), "Unknown or invalid MMU model\n");
> +        cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
>          return -1;
>      }
>
> @@ -1583,7 +1578,7 @@ static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
>  static int cpu_ppc_handle_mmu_fault(CPUPPCState *env, target_ulong address,
>                                      int rw, int mmu_idx)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>      mmu_ctx_t ctx;
>      int access_type;
> @@ -1815,7 +1810,7 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *env, target_ulong address,
>  static inline void do_invalidate_BAT(CPUPPCState *env, target_ulong BATu,
>                                       target_ulong mask)
>  {
> -    CPUState *cs = CPU(ppc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      target_ulong base, end, page;
>
>      base = BATu & ~0x0001FFFF;
> @@ -1847,7 +1842,7 @@ void helper_store_ibatu(CPUPPCState *env, uint32_t nr, target_ulong value)
>  {
>      target_ulong mask;
>  #if defined(FLUSH_ALL_TLBS)
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>  #endif
>
>      dump_store_bat(env, 'I', 0, nr, value);
> @@ -1868,7 +1863,7 @@ void helper_store_ibatu(CPUPPCState *env, uint32_t nr, target_ulong value)
>  #if !defined(FLUSH_ALL_TLBS)
>          do_invalidate_BAT(env, env->IBAT[0][nr], mask);
>  #else
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>  #endif
>      }
>  }
> @@ -1883,7 +1878,7 @@ void helper_store_dbatu(CPUPPCState *env, uint32_t nr, target_ulong value)
>  {
>      target_ulong mask;
>  #if defined(FLUSH_ALL_TLBS)
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>  #endif
>
>      dump_store_bat(env, 'D', 0, nr, value);
> @@ -1904,7 +1899,7 @@ void helper_store_dbatu(CPUPPCState *env, uint32_t nr, target_ulong value)
>  #if !defined(FLUSH_ALL_TLBS)
>          do_invalidate_BAT(env, env->DBAT[0][nr], mask);
>  #else
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>  #endif
>      }
>  }
> @@ -1919,7 +1914,7 @@ void helper_store_601_batu(CPUPPCState *env, uint32_t nr, target_ulong value)
>  {
>      target_ulong mask;
>  #if defined(FLUSH_ALL_TLBS)
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      int do_inval;
>  #endif
>
> @@ -1953,7 +1948,7 @@ void helper_store_601_batu(CPUPPCState *env, uint32_t nr, target_ulong value)
>          }
>  #if defined(FLUSH_ALL_TLBS)
>          if (do_inval) {
> -            tlb_flush(CPU(cpu));
> +            tlb_flush(env_cpu(env));
>          }
>  #endif
>      }
> @@ -1964,7 +1959,7 @@ void helper_store_601_batl(CPUPPCState *env, uint32_t nr, target_ulong value)
>  #if !defined(FLUSH_ALL_TLBS)
>      target_ulong mask;
>  #else
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      int do_inval;
>  #endif
>
> @@ -1993,7 +1988,7 @@ void helper_store_601_batl(CPUPPCState *env, uint32_t nr, target_ulong value)
>          env->DBAT[1][nr] = value;
>  #if defined(FLUSH_ALL_TLBS)
>          if (do_inval) {
> -            tlb_flush(CPU(cpu));
> +            tlb_flush(env_cpu(env));
>          }
>  #endif
>      }
> @@ -2003,12 +1998,10 @@ void helper_store_601_batl(CPUPPCState *env, uint32_t nr, target_ulong value)
>  /* TLB management */
>  void ppc_tlb_invalidate_all(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>  #if defined(TARGET_PPC64)
>      if (env->mmu_model & POWERPC_MMU_64) {
>          env->tlb_need_flush = 0;
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>      } else
>  #endif /* defined(TARGET_PPC64) */
>      switch (env->mmu_model) {
> @@ -2021,14 +2014,14 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
>          ppc4xx_tlb_invalidate_all(env);
>          break;
>      case POWERPC_MMU_REAL:
> -        cpu_abort(CPU(cpu), "No TLB for PowerPC 4xx in real mode\n");
> +        cpu_abort(env_cpu(env), "No TLB for PowerPC 4xx in real mode\n");
>          break;
>      case POWERPC_MMU_MPC8xx:
>          /* XXX: TODO */
> -        cpu_abort(CPU(cpu), "MPC8xx MMU model is not implemented\n");
> +        cpu_abort(env_cpu(env), "MPC8xx MMU model is not implemented\n");
>          break;
>      case POWERPC_MMU_BOOKE:
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>          break;
>      case POWERPC_MMU_BOOKE206:
>          booke206_flush_tlb(env, -1, 0);
> @@ -2036,11 +2029,11 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
>      case POWERPC_MMU_32B:
>      case POWERPC_MMU_601:
>          env->tlb_need_flush = 0;
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>          break;
>      default:
>          /* XXX: TODO */
> -        cpu_abort(CPU(cpu), "Unknown MMU model %x\n", env->mmu_model);
> +        cpu_abort(env_cpu(env), "Unknown MMU model %x\n", env->mmu_model);
>          break;
>      }
>  }
> @@ -2091,7 +2084,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
>  /* Special registers manipulation */
>  void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, value);
>      assert(!cpu->vhyp);
>  #if defined(TARGET_PPC64)
> @@ -2118,7 +2111,7 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>  #if defined(TARGET_PPC64)
>  void ppc_store_ptcr(CPUPPCState *env, target_ulong value)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    PowerPCCPU *cpu = env_archcpu(env);
>      target_ulong ptcr_mask = PTCR_PATB | PTCR_PATS;
>      target_ulong patbsize = value & PTCR_PATS;
>
> @@ -2163,7 +2156,7 @@ void helper_store_sr(CPUPPCState *env, target_ulong srnum, target_ulong value)
>              (int)srnum, value, env->sr[srnum]);
>  #if defined(TARGET_PPC64)
>      if (env->mmu_model & POWERPC_MMU_64) {
> -        PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +        PowerPCCPU *cpu = env_archcpu(env);
>          uint64_t esid, vsid;
>
>          /* ESID = srnum */
> @@ -2190,7 +2183,7 @@ void helper_store_sr(CPUPPCState *env, target_ulong srnum, target_ulong value)
>              page = (16 << 20) * srnum;
>              end = page + (16 << 20);
>              for (; page != end; page += TARGET_PAGE_SIZE) {
> -                tlb_flush_page(CPU(cpu), page);
> +                tlb_flush_page(env_cpu(env), page);
>              }
>          }
>  #else
> @@ -2212,12 +2205,10 @@ void helper_tlbie(CPUPPCState *env, target_ulong addr)
>
>  void helper_tlbiva(CPUPPCState *env, target_ulong addr)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      /* tlbiva instruction only exists on BookE */
>      assert(env->mmu_model == POWERPC_MMU_BOOKE);
>      /* XXX: TODO */
> -    cpu_abort(CPU(cpu), "BookE MMU model is not implemented\n");
> +    cpu_abort(env_cpu(env), "BookE MMU model is not implemented\n");
>  }
>
>  /* Software driven TLBs management */
> @@ -2433,8 +2424,7 @@ target_ulong helper_4xx_tlbre_lo(CPUPPCState *env, target_ulong entry)
>  void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
>                           target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>      ppcemb_tlb_t *tlb;
>      target_ulong page, end;
>
> @@ -2529,7 +2519,6 @@ target_ulong helper_4xx_tlbsx(CPUPPCState *env, target_ulong address)
>  void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
>                        target_ulong value)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      ppcemb_tlb_t *tlb;
>      target_ulong EPN, RPN, size;
>      int do_flush_tlbs;
> @@ -2565,13 +2554,13 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
>          }
>          tlb->PID = env->spr[SPR_440_MMUCR] & 0x000000FF;
>          if (do_flush_tlbs) {
> -            tlb_flush(CPU(cpu));
> +            tlb_flush(env_cpu(env));
>          }
>          break;
>      case 1:
>          RPN = value & 0xFFFFFC0F;
>          if ((tlb->prot & PAGE_VALID) && tlb->RPN != RPN) {
> -            tlb_flush(CPU(cpu));
> +            tlb_flush(env_cpu(env));
>          }
>          tlb->RPN = RPN;
>          break;
> @@ -2665,7 +2654,6 @@ target_ulong helper_440_tlbsx(CPUPPCState *env, target_ulong address)
>
>  static ppcmas_tlb_t *booke206_cur_tlb(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      uint32_t tlbncfg = 0;
>      int esel = (env->spr[SPR_BOOKE_MAS0] & MAS0_ESEL_MASK) >> MAS0_ESEL_SHIFT;
>      int ea = (env->spr[SPR_BOOKE_MAS2] & MAS2_EPN_MASK);
> @@ -2675,7 +2663,7 @@ static ppcmas_tlb_t *booke206_cur_tlb(CPUPPCState *env)
>      tlbncfg = env->spr[SPR_BOOKE_TLB0CFG + tlb];
>
>      if ((tlbncfg & TLBnCFG_HES) && (env->spr[SPR_BOOKE_MAS0] & MAS0_HES)) {
> -        cpu_abort(CPU(cpu), "we don't support HES yet\n");
> +        cpu_abort(env_cpu(env), "we don't support HES yet\n");
>      }
>
>      return booke206_get_tlbm(env, tlb, ea, esel);
> @@ -2683,40 +2671,33 @@ static ppcmas_tlb_t *booke206_cur_tlb(CPUPPCState *env)
>
>  void helper_booke_setpid(CPUPPCState *env, uint32_t pidn, target_ulong pid)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      env->spr[pidn] = pid;
>      /* changing PIDs mean we're in a different address space now */
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>  }
>
>  void helper_booke_set_eplc(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      env->spr[SPR_BOOKE_EPLC] = val & EPID_MASK;
> -    tlb_flush_by_mmuidx(CPU(cpu), 1 << PPC_TLB_EPID_LOAD);
> +    tlb_flush_by_mmuidx(env_cpu(env), 1 << PPC_TLB_EPID_LOAD);
>  }
>  void helper_booke_set_epsc(CPUPPCState *env, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      env->spr[SPR_BOOKE_EPSC] = val & EPID_MASK;
> -    tlb_flush_by_mmuidx(CPU(cpu), 1 << PPC_TLB_EPID_STORE);
> +    tlb_flush_by_mmuidx(env_cpu(env), 1 << PPC_TLB_EPID_STORE);
>  }
>
>  static inline void flush_page(CPUPPCState *env, ppcmas_tlb_t *tlb)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> -
>      if (booke206_tlb_to_page_size(env, tlb) == TARGET_PAGE_SIZE) {
> -        tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
> +        tlb_flush_page(env_cpu(env), tlb->mas2 & MAS2_EPN_MASK);
>      } else {
> -        tlb_flush(CPU(cpu));
> +        tlb_flush(env_cpu(env));
>      }
>  }
>
>  void helper_booke206_tlbwe(CPUPPCState *env)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      uint32_t tlbncfg, tlbn;
>      ppcmas_tlb_t *tlb;
>      uint32_t size_tlb, size_ps;
> @@ -2770,7 +2751,7 @@ void helper_booke206_tlbwe(CPUPPCState *env)
>      }
>
>      if (msr_gs) {
> -        cpu_abort(CPU(cpu), "missing HV implementation\n");
> +        cpu_abort(env_cpu(env), "missing HV implementation\n");
>      }
>
>      if (tlb->mas1 & MAS1_VALID) {
> @@ -2968,7 +2949,6 @@ void helper_booke206_tlbilx0(CPUPPCState *env, target_ulong address)
>
>  void helper_booke206_tlbilx1(CPUPPCState *env, target_ulong address)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      int i, j;
>      int tid = (env->spr[SPR_BOOKE_MAS6] & MAS6_SPID);
>      ppcmas_tlb_t *tlb = env->tlb.tlbm;
> @@ -2985,12 +2965,11 @@ void helper_booke206_tlbilx1(CPUPPCState *env, target_ulong address)
>          }
>          tlb += booke206_tlb_size(env, i);
>      }
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>  }
>
>  void helper_booke206_tlbilx3(CPUPPCState *env, target_ulong address)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      int i, j;
>      ppcmas_tlb_t *tlb;
>      int tid = (env->spr[SPR_BOOKE_MAS6] & MAS6_SPID);
> @@ -3026,7 +3005,7 @@ void helper_booke206_tlbilx3(CPUPPCState *env, target_ulong address)
>              tlb->mas1 &= ~MAS1_VALID;
>          }
>      }
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>  }
>
>  void helper_booke206_tlbflush(CPUPPCState *env, target_ulong type)
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 0394a9ddad..6343e25624 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -3432,7 +3432,7 @@ static void init_proc_401(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(12, 16, 20, 24);
>      SET_WDT_PERIOD(16, 20, 24, 28);
> @@ -3486,7 +3486,7 @@ static void init_proc_401x2(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(12, 16, 20, 24);
>      SET_WDT_PERIOD(16, 20, 24, 28);
> @@ -3538,7 +3538,7 @@ static void init_proc_401x3(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(12, 16, 20, 24);
>      SET_WDT_PERIOD(16, 20, 24, 28);
> @@ -3597,7 +3597,7 @@ static void init_proc_IOP480(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(8, 12, 16, 20);
>      SET_WDT_PERIOD(16, 20, 24, 28);
> @@ -3648,7 +3648,7 @@ static void init_proc_403(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(8, 12, 16, 20);
>      SET_WDT_PERIOD(16, 20, 24, 28);
> @@ -3714,7 +3714,7 @@ static void init_proc_403GCX(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(8, 12, 16, 20);
>      SET_WDT_PERIOD(16, 20, 24, 28);
> @@ -3780,7 +3780,7 @@ static void init_proc_405(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(8, 12, 16, 20);
>      SET_WDT_PERIOD(16, 20, 24, 28);
> @@ -3878,7 +3878,7 @@ static void init_proc_440EP(CPUPPCState *env)
>      init_excp_BookE(env);
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(12, 16, 20, 24);
>      SET_WDT_PERIOD(20, 24, 28, 32);
> @@ -4186,7 +4186,7 @@ static void init_proc_440x5(CPUPPCState *env)
>      init_excp_BookE(env);
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
> -    ppc40x_irq_init(ppc_env_get_cpu(env));
> +    ppc40x_irq_init(env_archcpu(env));
>
>      SET_FIT_PERIOD(12, 16, 20, 24);
>      SET_WDT_PERIOD(20, 24, 28, 32);
> @@ -4392,7 +4392,7 @@ static void init_proc_G2(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(G2)(ObjectClass *oc, void *data)
> @@ -4472,7 +4472,7 @@ static void init_proc_G2LE(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(G2LE)(ObjectClass *oc, void *data)
> @@ -4727,7 +4727,7 @@ static void init_proc_e300(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(e300)(ObjectClass *oc, void *data)
> @@ -4805,7 +4805,6 @@ enum fsl_e500_version {
>
>  static void init_proc_e500(CPUPPCState *env, int version)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
>      uint32_t tlbncfg[2];
>      uint64_t ivor_mask;
>      uint64_t ivpr_mask = 0xFFFF0000ULL;
> @@ -4877,7 +4876,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
>          tlbncfg[1] = 0x40028040;
>          break;
>      default:
> -        cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n",
> +        cpu_abort(env_cpu(env), "Unknown CPU: " TARGET_FMT_lx "\n",
>                    env->spr[SPR_PVR]);
>      }
>  #endif
> @@ -4902,7 +4901,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
>          l1cfg1 |= 0x0B83820;
>          break;
>      default:
> -        cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n",
> +        cpu_abort(env_cpu(env), "Unknown CPU: " TARGET_FMT_lx "\n",
>                    env->spr[SPR_PVR]);
>      }
>      gen_spr_BookE206(env, 0x000000DF, tlbncfg, mmucfg);
> @@ -5018,7 +5017,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
>
>      init_excp_e200(env, ivpr_mask);
>      /* Allocate hardware IRQ controller */
> -    ppce500_irq_init(ppc_env_get_cpu(env));
> +    ppce500_irq_init(env_archcpu(env));
>  }
>
>  static void init_proc_e500v1(CPUPPCState *env)
> @@ -5291,7 +5290,7 @@ static void init_proc_601(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 64;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(601)(ObjectClass *oc, void *data)
> @@ -5396,7 +5395,7 @@ static void init_proc_602(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(602)(ObjectClass *oc, void *data)
> @@ -5466,7 +5465,7 @@ static void init_proc_603(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(603)(ObjectClass *oc, void *data)
> @@ -5533,7 +5532,7 @@ static void init_proc_603E(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(603E)(ObjectClass *oc, void *data)
> @@ -5594,7 +5593,7 @@ static void init_proc_604(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(604)(ObjectClass *oc, void *data)
> @@ -5678,7 +5677,7 @@ static void init_proc_604E(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(604E)(ObjectClass *oc, void *data)
> @@ -5749,7 +5748,7 @@ static void init_proc_740(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(740)(ObjectClass *oc, void *data)
> @@ -5829,7 +5828,7 @@ static void init_proc_750(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(750)(ObjectClass *oc, void *data)
> @@ -5993,7 +5992,7 @@ static void init_proc_750cl(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(750cl)(ObjectClass *oc, void *data)
> @@ -6115,7 +6114,7 @@ static void init_proc_750cx(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(750cx)(ObjectClass *oc, void *data)
> @@ -6203,7 +6202,7 @@ static void init_proc_750fx(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(750fx)(ObjectClass *oc, void *data)
> @@ -6291,7 +6290,7 @@ static void init_proc_750gx(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(750gx)(ObjectClass *oc, void *data)
> @@ -6370,7 +6369,7 @@ static void init_proc_745(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(745)(ObjectClass *oc, void *data)
> @@ -6457,7 +6456,7 @@ static void init_proc_755(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(755)(ObjectClass *oc, void *data)
> @@ -6527,7 +6526,7 @@ static void init_proc_7400(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(7400)(ObjectClass *oc, void *data)
> @@ -6612,7 +6611,7 @@ static void init_proc_7410(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(7410)(ObjectClass *oc, void *data)
> @@ -6723,7 +6722,7 @@ static void init_proc_7440(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(7440)(ObjectClass *oc, void *data)
> @@ -6857,7 +6856,7 @@ static void init_proc_7450(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(7450)(ObjectClass *oc, void *data)
> @@ -6994,7 +6993,7 @@ static void init_proc_7445(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(7445)(ObjectClass *oc, void *data)
> @@ -7133,7 +7132,7 @@ static void init_proc_7455(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(7455)(ObjectClass *oc, void *data)
> @@ -7296,7 +7295,7 @@ static void init_proc_7457(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(7457)(ObjectClass *oc, void *data)
> @@ -7434,7 +7433,7 @@ static void init_proc_e600(CPUPPCState *env)
>      env->dcache_line_size = 32;
>      env->icache_line_size = 32;
>      /* Allocate hardware IRQ controller */
> -    ppc6xx_irq_init(ppc_env_get_cpu(env));
> +    ppc6xx_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
> @@ -8298,7 +8297,7 @@ static void init_proc_970(CPUPPCState *env)
>
>      /* Allocate hardware IRQ controller */
>      init_excp_970(env);
> -    ppc970_irq_init(ppc_env_get_cpu(env));
> +    ppc970_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
> @@ -8372,7 +8371,7 @@ static void init_proc_power5plus(CPUPPCState *env)
>
>      /* Allocate hardware IRQ controller */
>      init_excp_970(env);
> -    ppc970_irq_init(ppc_env_get_cpu(env));
> +    ppc970_irq_init(env_archcpu(env));
>  }
>
>  POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
> @@ -8487,7 +8486,7 @@ static void init_proc_POWER7(CPUPPCState *env)
>
>      /* Allocate hardware IRQ controller */
>      init_excp_POWER7(env);
> -    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
> +    ppcPOWER7_irq_init(env_archcpu(env));
>  }
>
>  static bool ppc_pvr_match_power7(PowerPCCPUClass *pcc, uint32_t pvr)
> @@ -8639,7 +8638,7 @@ static void init_proc_POWER8(CPUPPCState *env)
>
>      /* Allocate hardware IRQ controller */
>      init_excp_POWER8(env);
> -    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
> +    ppcPOWER7_irq_init(env_archcpu(env));
>  }
>
>  static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr)
> @@ -8838,7 +8837,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>
>      /* Allocate hardware IRQ controller */
>      init_excp_POWER9(env);
> -    ppcPOWER9_irq_init(ppc_env_get_cpu(env));
> +    ppcPOWER9_irq_init(env_archcpu(env));
>  }
>
>  static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
> --
> 2.17.1
>
>

