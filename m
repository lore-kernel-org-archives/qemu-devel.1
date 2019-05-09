Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E17C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8AF2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVUHSrKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8AF2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnOT-0003nl-0y
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:03:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnKr-0000Ju-PO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnKo-0001SS-D4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:00:01 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnKn-0001Ru-UX
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:59:58 -0400
Received: by mail-lj1-x243.google.com with SMTP id d15so2803147ljc.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=TE1fyANc88YsworH2mYOEJeDH9YfdqGylXvShT00RAA=;
	b=VVUHSrKWzfC1cLH7GIC1nHuU1OV5qIjqLQl/CVfPfW1xtqKWj5XdZ4TtidyJUf6MIb
	vUswNpU2xy5wmQnE5qcPgOpJJ8CsveSmpe2UKmam2VWIDkxSzpfgN2PWGUAkWn66iUOg
	mf8TG38LrLczKUQjbC4qCgXYUslWZbo04ubNJoM+yj9blnTd7zx14A7k3HuZuf/EWbjW
	dJzuBnDEU/eeT7tMxesL7skq00ag9SdVCADeWTp0UUwsrN8Y2W0t79+F1KaiKJJ8zN0M
	9XnJ1XOMC733qsimaz9XEQXjQIv+j8IP1Ikk2SI9pzj+Qy3i0DkdajLyXSFLuioE5yIj
	ilBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=TE1fyANc88YsworH2mYOEJeDH9YfdqGylXvShT00RAA=;
	b=MMgDkPkOtu51hqzv1oEkOGoUT7n6EQazJVheen04BTBebaFlhe0PAPwfRaQSwD1rPn
	YoPOkN3jRAVcAV6INTVYi3OE66q/LXjEAN1+48uGIBxVM4/PFbghSBh5qGk3ooVZZ4pG
	OdaqUJA+wVAqDwspY1H2LraPxMXRu+72LPKTrwP/dhTvJk+nxnT+Rk1Nb03Z23+QLctK
	yNR4e7D1N5U2U1qik9a1bqxoHNDdJ68YOhKxOVY6nREjgtVyg0jfulaQhLPbbV5OE7Oc
	X4+tUMSkZTDGDrnaf34t1JC8uZ+4FnIJSadnqReQZGvnayo2sjdP04ARNujkFFQ+n6Bt
	LqkA==
X-Gm-Message-State: APjAAAVWQzwDApZQ9MTibTj7Um2BR0jPJLrU+CgrNcAQ4AGLq36GIZoi
	sjaOvBV2fx6e6F4oTJJ6kO9flDr7TpuANwf9xaw=
X-Google-Smtp-Source: APXvYqxqoddCzTTNbRLy3BzdSSn/nSjVWHakJ6AwYSwsgfQ38lY1uSeizOpRPtk/Fwr9qHo5fW/XiXaOMvfEARx3reM=
X-Received: by 2002:a2e:824b:: with SMTP id j11mr3046053ljh.197.1557424796375; 
	Thu, 09 May 2019 10:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-10-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-10-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 10:57:49 -0700
Message-ID: <CAKmqyKOk0YPwtkGftddHtDkyR90D8ds2wtdW5zxf9+Hv+k08EA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v3 09/39] target/arm: Use env_cpu,
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

On Tue, May 7, 2019 at 5:16 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Combined uses of CPU(arm_env_get_cpu()) were failures to use
> the more proper, ENV_GET_CPU macro, now replaced by env_cpu.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/arm/cpu.h              |   5 --
>  linux-user/aarch64/cpu_loop.c |   6 +-
>  linux-user/aarch64/signal.c   |   4 +-
>  linux-user/arm/cpu_loop.c     |   2 +-
>  linux-user/syscall.c          |   8 +--
>  target/arm/arm-semi.c         |   4 +-
>  target/arm/cpu64.c            |   2 +-
>  target/arm/helper-a64.c       |   4 +-
>  target/arm/helper.c           | 120 +++++++++++++++++-----------------
>  target/arm/op_helper.c        |  21 +++---
>  target/arm/translate-a64.c    |   2 +-
>  target/arm/translate.c        |   2 +-
>  target/arm/vfp_helper.c       |   2 +-
>  13 files changed, 88 insertions(+), 94 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a633a233cc..c54c67fde4 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -911,11 +911,6 @@ struct ARMCPU {
>      uint32_t sve_max_vq;
>  };
>
> -static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
> -{
> -    return container_of(env, ARMCPU, env);
> -}
> -
>  void arm_cpu_post_init(Object *obj);
>
>  uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index d75fd9d3e2..97f355ee23 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -72,7 +72,7 @@
>  /* AArch64 main loop */
>  void cpu_loop(CPUARMState *env)
>  {
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr;
>      abi_long ret;
>      target_siginfo_t info;
> @@ -167,8 +167,8 @@ void arm_init_pauth_key(ARMPACKey *key)
>
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    ARMCPU *cpu = env_archcpu(env);
> +    CPUState *cs = env_cpu(env);
>      TaskState *ts = cs->opaque;
>      struct image_info *info = ts->info;
>      int i;
> diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
> index f84a9cf28a..cd521ee42d 100644
> --- a/linux-user/aarch64/signal.c
> +++ b/linux-user/aarch64/signal.c
> @@ -314,7 +314,7 @@ static int target_restore_sigframe(CPUARMState *env,
>              break;
>
>          case TARGET_SVE_MAGIC:
> -            if (cpu_isar_feature(aa64_sve, arm_env_get_cpu(env))) {
> +            if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
>                  vq = (env->vfp.zcr_el[1] & 0xf) + 1;
>                  sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
>                  if (!sve && size == sve_size) {
> @@ -433,7 +433,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
>                                        &layout);
>
>      /* SVE state needs saving only if it exists.  */
> -    if (cpu_isar_feature(aa64_sve, arm_env_get_cpu(env))) {
> +    if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
>          vq = (env->vfp.zcr_el[1] & 0xf) + 1;
>          sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
>          sve_ofs = alloc_sigframe_space(sve_size, &layout);
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index b7e7a6323c..ece4cf335e 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -206,7 +206,7 @@ do_kernel_trap(CPUARMState *env)
>
>  void cpu_loop(CPUARMState *env)
>  {
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr;
>      unsigned int n, insn;
>      target_siginfo_t info;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9f110a7581..eb7fd9a1bf 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9683,10 +9683,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>               * even though the current architectural maximum is VQ=16.
>               */
>              ret = -TARGET_EINVAL;
> -            if (cpu_isar_feature(aa64_sve, arm_env_get_cpu(cpu_env))
> +            if (cpu_isar_feature(aa64_sve, env_archcpu(cpu_env))
>                  && arg2 >= 0 && arg2 <= 512 * 16 && !(arg2 & 15)) {
>                  CPUARMState *env = cpu_env;
> -                ARMCPU *cpu = arm_env_get_cpu(env);
> +                ARMCPU *cpu = env_archcpu(env);
>                  uint32_t vq, old_vq;
>
>                  old_vq = (env->vfp.zcr_el[1] & 0xf) + 1;
> @@ -9703,7 +9703,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          case TARGET_PR_SVE_GET_VL:
>              ret = -TARGET_EINVAL;
>              {
> -                ARMCPU *cpu = arm_env_get_cpu(cpu_env);
> +                ARMCPU *cpu = env_archcpu(cpu_env);
>                  if (cpu_isar_feature(aa64_sve, cpu)) {
>                      ret = ((cpu->env.vfp.zcr_el[1] & 0xf) + 1) * 16;
>                  }
> @@ -9712,7 +9712,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          case TARGET_PR_PAC_RESET_KEYS:
>              {
>                  CPUARMState *env = cpu_env;
> -                ARMCPU *cpu = arm_env_get_cpu(env);
> +                ARMCPU *cpu = env_archcpu(env);
>
>                  if (arg3 || arg4 || arg5) {
>                      return -TARGET_EINVAL;
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 8b5fd7bc6e..e998b014be 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -242,8 +242,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
>
>  target_ulong do_arm_semihosting(CPUARMState *env)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    ARMCPU *cpu = env_archcpu(env);
> +    CPUState *cs = env_cpu(env);
>      target_ulong args;
>      target_ulong arg0, arg1, arg2, arg3;
>      char * s;
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 228906f267..1150cec22d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -44,7 +44,7 @@ static inline void unset_feature(CPUARMState *env, int feature)
>  #ifndef CONFIG_USER_ONLY
>  static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      /* Number of cores is in [25:24]; otherwise we RAZ */
>      return (cpu->core_count - 1) << 24;
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 796ef34b55..44e45a8037 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -1005,7 +1005,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
>      }
>
>      qemu_mutex_lock_iothread();
> -    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
> +    arm_call_pre_el_change_hook(env_archcpu(env));
>      qemu_mutex_unlock_iothread();
>
>      if (!return_to_aa64) {
> @@ -1047,7 +1047,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
>      aarch64_sve_change_el(env, cur_el, new_el, return_to_aa64);
>
>      qemu_mutex_lock_iothread();
> -    arm_call_el_change_hook(arm_env_get_cpu(env));
> +    arm_call_el_change_hook(env_archcpu(env));
>      qemu_mutex_unlock_iothread();
>
>      return;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4c57c0ddd4..082ce89dcf 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -224,7 +224,7 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
>
>  static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      const ARMCPRegInfo *ri;
>      uint32_t key;
>
> @@ -522,7 +522,7 @@ static CPAccessResult access_tpm(CPUARMState *env, const ARMCPRegInfo *ri,
>
>  static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      raw_write(env, ri, value);
>      tlb_flush(CPU(cpu)); /* Flush TLB as domain not tracked in TLB */
> @@ -530,7 +530,7 @@ static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>
>  static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (raw_read(env, ri) != value) {
>          /* Unlike real hardware the qemu TLB uses virtual addresses,
> @@ -544,7 +544,7 @@ static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>  static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
>          && !extended_addresses_enabled(env)) {
> @@ -605,7 +605,7 @@ static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                            uint64_t value)
>  {
>      /* Invalidate all (TLBIALL) */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (tlb_force_broadcast(env)) {
>          tlbiall_is_write(env, NULL, value);
> @@ -619,7 +619,7 @@ static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                            uint64_t value)
>  {
>      /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (tlb_force_broadcast(env)) {
>          tlbimva_is_write(env, NULL, value);
> @@ -633,7 +633,7 @@ static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                             uint64_t value)
>  {
>      /* Invalidate by ASID (TLBIASID) */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (tlb_force_broadcast(env)) {
>          tlbiasid_is_write(env, NULL, value);
> @@ -647,7 +647,7 @@ static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                             uint64_t value)
>  {
>      /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (tlb_force_broadcast(env)) {
>          tlbimvaa_is_write(env, NULL, value);
> @@ -1327,7 +1327,7 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
>
>  static void pmu_update_irq(CPUARMState *env)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      qemu_set_irq(cpu->pmu_interrupt, (env->cp15.c9_pmcr & PMCRE) &&
>              (env->cp15.c9_pminten & env->cp15.c9_pmovsr));
>  }
> @@ -1382,7 +1382,7 @@ static void pmccntr_op_finish(CPUARMState *env)
>          if (overflow_in > 0) {
>              int64_t overflow_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                  overflow_in;
> -            ARMCPU *cpu = arm_env_get_cpu(env);
> +            ARMCPU *cpu = env_archcpu(env);
>              timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
>          }
>  #endif
> @@ -1431,7 +1431,7 @@ static void pmevcntr_op_finish(CPUARMState *env, uint8_t counter)
>          if (overflow_in > 0) {
>              int64_t overflow_at = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                  overflow_in;
> -            ARMCPU *cpu = arm_env_get_cpu(env);
> +            ARMCPU *cpu = env_archcpu(env);
>              timer_mod_anticipate_ns(cpu->pmu_timer, overflow_at);
>          }
>  #endif
> @@ -1839,7 +1839,7 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>  {
>      /* Begin with base v8.0 state.  */
>      uint32_t valid_mask = 0x3fff;
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (arm_el_is_aa64(env, 3)) {
>          value |= SCR_FW | SCR_AW;   /* these two bits are RES1.  */
> @@ -1876,7 +1876,7 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>
>  static uint64_t ccsidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      /* Acquire the CSSELR index from the bank corresponding to the CCSIDR
>       * bank
> @@ -2426,7 +2426,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
>  static void gt_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri,
>                             int timeridx)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      timer_del(cpu->gt_timer[timeridx]);
>  }
> @@ -2447,7 +2447,7 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      trace_arm_gt_cval_write(timeridx, value);
>      env->cp15.c14_timer[timeridx].cval = value;
> -    gt_recalc_timer(arm_env_get_cpu(env), timeridx);
> +    gt_recalc_timer(env_archcpu(env), timeridx);
>  }
>
>  static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -2468,14 +2468,14 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      trace_arm_gt_tval_write(timeridx, value);
>      env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
>                                           sextract64(value, 0, 32);
> -    gt_recalc_timer(arm_env_get_cpu(env), timeridx);
> +    gt_recalc_timer(env_archcpu(env), timeridx);
>  }
>
>  static void gt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           int timeridx,
>                           uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint32_t oldval = env->cp15.c14_timer[timeridx].ctl;
>
>      trace_arm_gt_ctl_write(timeridx, value);
> @@ -2553,7 +2553,7 @@ static void gt_virt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      trace_arm_gt_cntvoff_write(value);
>      raw_write(env, ri, value);
> @@ -3186,7 +3186,7 @@ static uint64_t pmsav7_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  static void pmsav7_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint32_t *u32p = *(uint32_t **)raw_ptr(env, ri);
>
>      if (!u32p) {
> @@ -3201,7 +3201,7 @@ static void pmsav7_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void pmsav7_rgnr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint32_t nrgs = cpu->pmsav7_dregion;
>
>      if (value >= nrgs) {
> @@ -3329,7 +3329,7 @@ static void vmsa_ttbcr_raw_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      TCR *tcr = raw_ptr(env, ri);
>
>      if (arm_feature(env, ARM_FEATURE_LPAE)) {
> @@ -3358,7 +3358,7 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>  static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                 uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      TCR *tcr = raw_ptr(env, ri);
>
>      /* For AArch64 the A1 bit could result in a change of ASID, so TLB flush. */
> @@ -3372,7 +3372,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
>      if (cpreg_field_is_64bit(ri) &&
>          extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
> -        ARMCPU *cpu = arm_env_get_cpu(env);
> +        ARMCPU *cpu = env_archcpu(env);
>          tlb_flush(CPU(cpu));
>      }
>      raw_write(env, ri, value);
> @@ -3381,7 +3381,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                          uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>
>      /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
> @@ -3471,7 +3471,7 @@ static void omap_wfi_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                             uint64_t value)
>  {
>      /* Wait-for-interrupt (deprecated) */
> -    cpu_interrupt(CPU(arm_env_get_cpu(env)), CPU_INTERRUPT_HALT);
> +    cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HALT);
>  }
>
>  static void omap_cachemaint_write(CPUARMState *env, const ARMCPRegInfo *ri,
> @@ -3624,7 +3624,7 @@ static const ARMCPRegInfo strongarm_cp_reginfo[] = {
>
>  static uint64_t midr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      unsigned int cur_el = arm_current_el(env);
>      bool secure = arm_is_secure(env);
>
> @@ -3636,7 +3636,7 @@ static uint64_t midr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>
>  static uint64_t mpidr_read_val(CPUARMState *env)
>  {
> -    ARMCPU *cpu = ARM_CPU(arm_env_get_cpu(env));
> +    ARMCPU *cpu = env_archcpu(env);
>      uint64_t mpidr = cpu->mp_affinity;
>
>      if (arm_feature(env, ARM_FEATURE_V7MP)) {
> @@ -3789,7 +3789,7 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       * stage 2 translations, whereas most other scopes only invalidate
>       * stage 1 translations.
>       */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>
>      if (arm_is_secure_below_el3(env)) {
> @@ -3813,7 +3813,7 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                    uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>
>      tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E2);
> @@ -3822,7 +3822,7 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                    uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>
>      tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_S1E3);
> @@ -3878,7 +3878,7 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       * Currently handles both VAE2 and VALE2, since we don't support
>       * flush-last-level-only.
>       */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>
> @@ -3892,7 +3892,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       * Currently handles both VAE3 and VALE3, since we don't support
>       * flush-last-level-only.
>       */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>
> @@ -3902,7 +3902,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                     uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>      bool sec = arm_is_secure_below_el3(env);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
> @@ -3926,7 +3926,7 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       * since we don't support flush-for-specific-ASID-only or
>       * flush-last-level-only.
>       */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>      uint64_t pageaddr = sextract64(value << 12, 0, 56);
>
> @@ -3975,7 +3975,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       * translation information.
>       * This must NOP if EL2 isn't implemented or SCR_EL3.NS is zero.
>       */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>      uint64_t pageaddr;
>
> @@ -4018,7 +4018,7 @@ static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
>
>  static uint64_t aa64_dczid_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int dzp_bit = 1 << 4;
>
>      /* DZP indicates whether DC ZVA access is allowed */
> @@ -4053,7 +4053,7 @@ static void spsel_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t val)
>  static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                          uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (raw_read(env, ri) == value) {
>          /* Skip the TLB flush if nothing actually changed; Linux likes
> @@ -4545,7 +4545,7 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
>
>  static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint64_t valid_mask = HCR_MASK;
>
>      if (arm_feature(env, ARM_FEATURE_EL3)) {
> @@ -5212,7 +5212,7 @@ int sve_exception_el(CPUARMState *env, int el)
>   */
>  uint32_t sve_zcr_len_for_el(CPUARMState *env, int el)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint32_t zcr_len = cpu->sve_max_vq - 1;
>
>      if (el <= 1) {
> @@ -5380,7 +5380,7 @@ void hw_watchpoint_update_all(ARMCPU *cpu)
>  static void dbgwvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int i = ri->crm;
>
>      /* Bits [63:49] are hardwired to the value of bit [48]; that is, the
> @@ -5396,7 +5396,7 @@ static void dbgwvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void dbgwcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int i = ri->crm;
>
>      raw_write(env, ri, value);
> @@ -5498,7 +5498,7 @@ void hw_breakpoint_update_all(ARMCPU *cpu)
>  static void dbgbvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int i = ri->crm;
>
>      raw_write(env, ri, value);
> @@ -5508,7 +5508,7 @@ static void dbgbvr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void dbgbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                           uint64_t value)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int i = ri->crm;
>
>      /* BAS[3] is a read-only copy of BAS[2], and BAS[1] a read-only
> @@ -5604,7 +5604,7 @@ static void define_debug_regs(ARMCPU *cpu)
>   */
>  static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint64_t pfr1 = cpu->id_pfr1;
>
>      if (env->gicv3state) {
> @@ -5615,7 +5615,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>
>  static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint64_t pfr0 = cpu->isar.id_aa64pfr0;
>
>      if (env->gicv3state) {
> @@ -7353,14 +7353,14 @@ uint32_t HELPER(rbit)(uint32_t x)
>  /* These should probably raise undefined insn exceptions.  */
>  void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      cpu_abort(CPU(cpu), "v7m_msr %d\n", reg);
>  }
>
>  uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      cpu_abort(CPU(cpu), "v7m_mrs %d\n", reg);
>      return 0;
> @@ -7420,7 +7420,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
>
>  static void switch_mode(CPUARMState *env, int mode)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (mode != ARM_CPU_MODE_USR) {
>          cpu_abort(CPU(cpu), "Tried to switch out of user mode\n");
> @@ -7763,7 +7763,7 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
>       * PreserveFPState() pseudocode.
>       * We may throw an exception if the stacking fails.
>       */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
>      bool negpri = !(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_HFRDY_MASK);
>      bool is_priv = !(env->v7m.fpccr[is_secure] & R_V7M_FPCCR_USER_MASK);
> @@ -10865,7 +10865,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
>                               target_ulong *page_size,
>                               ARMMMUFaultInfo *fi)
>  {
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int level = 1;
>      uint32_t table;
>      uint32_t desc;
> @@ -10986,7 +10986,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
>                               hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
>                               target_ulong *page_size, ARMMMUFaultInfo *fi)
>  {
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int level = 1;
>      uint32_t table;
>      uint32_t desc;
> @@ -11371,7 +11371,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>                                 target_ulong *page_size_ptr,
>                                 ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      CPUState *cs = CPU(cpu);
>      /* Read an LPAE long-descriptor translation table. */
>      ARMFaultType fault_type = ARMFault_Translation;
> @@ -11729,7 +11729,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>                                   target_ulong *page_size,
>                                   ARMMMUFaultInfo *fi)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int n;
>      bool is_user = regime_is_user(env, mmu_idx);
>
> @@ -11933,7 +11933,7 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
>       * pseudocode SecurityCheck() function.
>       * We assume the caller has zero-initialized *sattrs.
>       */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int r;
>      bool idau_exempt = false, idau_ns = true, idau_nsc = true;
>      int idau_region = IREGION_NOTVALID;
> @@ -12046,7 +12046,7 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
>       * We set is_subpage to true if the region hit doesn't cover the
>       * entire TARGET_PAGE the address is within.
>       */
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      bool is_user = regime_is_user(env, mmu_idx);
>      uint32_t secure = regime_is_secure(env, mmu_idx);
>      int n;
> @@ -12860,7 +12860,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>              limit = is_psp ? env->v7m.psplim[false] : env->v7m.msplim[false];
>
>              if (val < limit) {
> -                CPUState *cs = CPU(arm_env_get_cpu(env));
> +                CPUState *cs = env_cpu(env);
>
>                  cpu_restore_state(cs, GETPC(), true);
>                  raise_exception(env, EXCP_STKOF, 0, 1);
> @@ -13088,7 +13088,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
>       * alignment faults or any memory attribute handling).
>       */
>
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint64_t blocklen = 4 << cpu->dcz_blocksize;
>      uint64_t vaddr = vaddr_in & ~(blocklen - 1);
>
> @@ -13585,7 +13585,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>      uint32_t flags = 0;
>
>      if (is_a64(env)) {
> -        ARMCPU *cpu = arm_env_get_cpu(env);
> +        ARMCPU *cpu = env_archcpu(env);
>          uint64_t sctlr;
>
>          *pc = env->pc;
> @@ -13758,7 +13758,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
>      uint64_t pmask;
>
>      assert(vq >= 1 && vq <= ARM_MAX_VQ);
> -    assert(vq <= arm_env_get_cpu(env)->sve_max_vq);
> +    assert(vq <= env_archcpu(env)->sve_max_vq);
>
>      /* Zap the high bits of the zregs.  */
>      for (i = 0; i < 32; i++) {
> @@ -13784,7 +13784,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq)
>  void aarch64_sve_change_el(CPUARMState *env, int old_el,
>                             int new_el, bool el0_a64)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int old_len, new_len;
>      bool old_a64, new_a64;
>
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 8698b4dc83..5af8a1f408 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -31,7 +31,7 @@
>  static CPUState *do_raise_exception(CPUARMState *env, uint32_t excp,
>                                      uint32_t syndrome, uint32_t target_el)
>  {
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      if (target_el == 1 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
>          /*
> @@ -245,7 +245,7 @@ void HELPER(v8m_stackcheck)(CPUARMState *env, uint32_t newvalue)
>       * raising an exception if the limit is breached.
>       */
>      if (newvalue < v7m_sp_limit(env)) {
> -        CPUState *cs = CPU(arm_env_get_cpu(env));
> +        CPUState *cs = env_cpu(env);
>
>          /*
>           * Stack limit exceptions are a rare case, so rather than syncing
> @@ -448,7 +448,7 @@ static inline int check_wfx_trap(CPUARMState *env, bool is_wfe)
>
>  void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
>  {
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int target_el = check_wfx_trap(env, false);
>
>      if (cpu_has_work(cs)) {
> @@ -483,8 +483,7 @@ void HELPER(wfe)(CPUARMState *env)
>
>  void HELPER(yield)(CPUARMState *env)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>
>      /* This is a non-trappable hint instruction that generally indicates
>       * that the guest is currently busy-looping. Yield control back to the
> @@ -502,7 +501,7 @@ void HELPER(yield)(CPUARMState *env)
>   */
>  void HELPER(exception_internal)(CPUARMState *env, uint32_t excp)
>  {
> -    CPUState *cs = CPU(arm_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      assert(excp_is_internal(excp));
>      cs->exception_index = excp;
> @@ -545,7 +544,7 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
>  void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
>  {
>      qemu_mutex_lock_iothread();
> -    arm_call_pre_el_change_hook(arm_env_get_cpu(env));
> +    arm_call_pre_el_change_hook(env_archcpu(env));
>      qemu_mutex_unlock_iothread();
>
>      cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
> @@ -558,7 +557,7 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
>      env->regs[15] &= (env->thumb ? ~1 : ~3);
>
>      qemu_mutex_lock_iothread();
> -    arm_call_el_change_hook(arm_env_get_cpu(env));
> +    arm_call_el_change_hook(env_archcpu(env));
>      qemu_mutex_unlock_iothread();
>  }
>
> @@ -863,7 +862,7 @@ uint64_t HELPER(get_cp_reg64)(CPUARMState *env, void *rip)
>
>  void HELPER(pre_hvc)(CPUARMState *env)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int cur_el = arm_current_el(env);
>      /* FIXME: Use actual secure state.  */
>      bool secure = false;
> @@ -903,7 +902,7 @@ void HELPER(pre_hvc)(CPUARMState *env)
>
>  void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      int cur_el = arm_current_el(env);
>      bool secure = arm_is_secure(env);
>      bool smd_flag = env->cp15.scr_el3 & SCR_SMD;
> @@ -1177,7 +1176,7 @@ static bool check_breakpoints(ARMCPU *cpu)
>
>  void HELPER(check_breakpoints)(CPUARMState *env)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>
>      if (check_breakpoints(cpu)) {
>          HELPER(exception_internal(env, EXCP_DEBUG));
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index d0fefa798e..f998f1c629 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -14318,7 +14318,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
>  {
>      DisasContext *dc = container_of(dcbase, DisasContext, base);
>      CPUARMState *env = cpu->env_ptr;
> -    ARMCPU *arm_cpu = arm_env_get_cpu(env);
> +    ARMCPU *arm_cpu = env_archcpu(env);
>      uint32_t tb_flags = dc->base.tb->flags;
>      int bound, core_mmu_idx;
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 10bc53f91c..2170f0f3cc 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -13380,7 +13380,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *dc = container_of(dcbase, DisasContext, base);
>      CPUARMState *env = cs->env_ptr;
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    ARMCPU *cpu = env_archcpu(env);
>      uint32_t tb_flags = dc->base.tb->flags;
>      uint32_t condexec, core_mmu_idx;
>
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 7a46d99148..d3e83b627b 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -101,7 +101,7 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>      uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
>
>      /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
> -    if (!cpu_isar_feature(aa64_fp16, arm_env_get_cpu(env))) {
> +    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
>          val &= ~FPCR_FZ16;
>      }
>
> --
> 2.17.1
>
>

