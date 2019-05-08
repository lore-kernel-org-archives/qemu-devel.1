Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E49C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2EC21530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tix/6MYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2EC21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33037 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOHnf-0003vI-Ds
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 04:19:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hOHk9-0002Ok-Br
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hOHk6-0004nl-Nb
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:16:01 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hOHk6-0004mf-Dr
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:15:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id f23so17557018otl.9
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=MmqIFlzY725L0wK6uXb4ff5YY7Ng8GuVfansCXipJO0=;
	b=tix/6MYwCP75ZhTOEi8l0JtJzIPSTUe/BPGiDoP4dtdHvHNVS9HdNgLjpmhMvER8bM
	JBrQdfbElBtFFzMTwDlZp0jy+WEcpumdPGQrhzWl+FYBsCKVEOGmsNB1H+jO/lzTX1IR
	K81zRfEO7Xu3EGqv3yDOOHF6rkyfq/3F49dKrpeqAX58GZ9HX5IPPcE7oIhk4LiJpagw
	zQgq2GX59kTwMUGIuC632DelWr6eRaeJJGP4HPmxv9kIgMMokDX6Tz4+61oXM+3a+0FG
	0VeliloN1+U6tXhymsdnUBh+fAYHlQ2/gOSkCpF0GmF5Ds1ITju6N+U83VGwroS70/ih
	7Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=MmqIFlzY725L0wK6uXb4ff5YY7Ng8GuVfansCXipJO0=;
	b=mkCu/sE09RFdHprcsNMLkMuXLUSx6THbcAh0ZErPnV3NhvLNUKWhWpO1enkfrko7/D
	0Xx5701WQ7z28z0jfCvslrXLmnc8BjeDmv7tXJ35g7YIhnUD7wm1ph3ba3UMlFnt0iUY
	Lij67l7GBkKh9hK5Y7uLC7E4PMgIqmRhqeAuNzztbUSJLejqdmndtJ3fcTR2QB63a+zx
	du8msc21Y/BRHMAHsYvo83N7giKIgwO0bz0cfy/rq3DvLTnsOcLoN6/+EQ7xra33LB+8
	ajYP0gXEi8F3L3oaZrTbcKRJgcacRZ5vxGoVyPf+LBr1iVaFxe7jdxYg0zXMo8OBtzqQ
	gEWg==
X-Gm-Message-State: APjAAAW3WyyZm9HVz3IR5uq8vX+TWeKos/tNa44yhoxtE2YBy0MfK8Uq
	XFArkcnhauJ9HlXB3khjvu1JzrcAmxQrvNXwVkM=
X-Google-Smtp-Source: APXvYqyNoMI10+R2gonANNMiUeEqOoelJdTw6zLly5rx8LqSpTiv2DxRMwXwHtsYQ242OWM3BePm1mlBVZbJ/yaNFa8=
X-Received: by 2002:a9d:6c51:: with SMTP id g17mr16258253otq.171.1557303356523;
	Wed, 08 May 2019 01:15:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP;
	Wed, 8 May 2019 01:15:55 -0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP;
	Wed, 8 May 2019 01:15:55 -0700 (PDT)
In-Reply-To: <20190508000641.19090-19-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-19-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 8 May 2019 10:15:55 +0200
Message-ID: <CAL1e-=iRwS-1LvP2m5oS2PAKigiDr0g8jRNP6xPV2b_9AYU08Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 18/39] target/mips: Use env_cpu,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 8, 2019 2:19 AM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
>
>

This commit message doesn=CB=8At explain the reason for the change, and why=
 is
this an improvement. The underlyng reason for distingishing between
env_cpu and env_archcpu cases is not explained too.

Thanks,
Aleksandar

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/cpu.h                |  5 -----
>  hw/intc/mips_gic.c               |  2 +-
>  hw/mips/mips_int.c               |  2 +-
>  linux-user/mips/cpu_loop.c       |  2 +-
>  target/mips/helper.c             | 15 +++++----------
>  target/mips/op_helper.c          | 25 +++++++++++--------------
>  target/mips/translate.c          |  3 +--
>  target/mips/translate_init.inc.c |  4 +---
>  8 files changed, 21 insertions(+), 37 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 31e15834ca..e0645eb1d1 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1051,11 +1051,6 @@ struct MIPSCPU {
>      CPUMIPSState env;
>  };
>
> -static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
> -{
> -    return container_of(env, MIPSCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(MIPSCPU, env)
>
>  void mips_cpu_list(void);
> diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
> index 15e6e40f9f..8f509493ea 100644
> --- a/hw/intc/mips_gic.c
> +++ b/hw/intc/mips_gic.c
> @@ -44,7 +44,7 @@ static void mips_gic_set_vp_irq(MIPSGICState *gic, int
vp, int pin)
>                        GIC_VP_MASK_CMP_SHF;
>      }
>      if (kvm_enabled())  {
> -        kvm_mips_set_ipi_interrupt(mips_env_get_cpu(gic->vps[vp].env),
> +        kvm_mips_set_ipi_interrupt(env_archcpu(gic->vps[vp].env),
>                                     pin + GIC_CPU_PIN_OFFSET,
>                                     ored_level);
>      } else {
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 5ddeb15848..f899f6ceb3 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -76,7 +76,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
>      qemu_irq *qi;
>      int i;
>
> -    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, mips_env_get_cpu(env=
),
8);
> +    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, env_archcpu(env), 8)=
;
>      for (i =3D 0; i < 8; i++) {
>          env->irq[i] =3D qi[i];
>      }
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 828137cd84..ac6c6d1504 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -425,7 +425,7 @@ static int do_break(CPUMIPSState *env,
target_siginfo_t *info,
>
>  void cpu_loop(CPUMIPSState *env)
>  {
> -    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      target_siginfo_t info;
>      int trapnr;
>      abi_long ret;
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index c44cdca3b5..1fc0a4ce4b 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -336,10 +336,8 @@ static int get_physical_address (CPUMIPSState *env,
hwaddr *physical,
>
>  void cpu_mips_tlb_flush(CPUMIPSState *env)
>  {
> -    MIPSCPU *cpu =3D mips_env_get_cpu(env);
> -
>      /* Flush qemu's TLB and discard all shadowed entries.  */
> -    tlb_flush(CPU(cpu));
> +    tlb_flush(env_cpu(env));
>      env->tlb->tlb_in_use =3D env->tlb->nb_tlb;
>  }
>
> @@ -401,7 +399,7 @@ void cpu_mips_store_status(CPUMIPSState *env,
target_ulong val)
>  #if defined(TARGET_MIPS64)
>      if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
>          /* Access to at least one of the 64-bit segments has been
disabled */
> -        tlb_flush(CPU(mips_env_get_cpu(env)));
> +        tlb_flush(env_cpu(env));
>      }
>  #endif
>      if (env->CP0_Config3 & (1 << CP0C3_MT)) {
> @@ -446,7 +444,7 @@ void cpu_mips_store_cause(CPUMIPSState *env,
target_ulong val)
>  static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
>                                  int rw, int tlb_error)
>  {
> -    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      int exception =3D 0, error_code =3D 0;
>
>      if (rw =3D=3D MMU_INST_FETCH) {
> @@ -1400,8 +1398,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int
interrupt_request)
>  #if !defined(CONFIG_USER_ONLY)
>  void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
>  {
> -    MIPSCPU *cpu =3D mips_env_get_cpu(env);
> -    CPUState *cs;
> +    CPUState *cs =3D env_cpu(env);
>      r4k_tlb_t *tlb;
>      target_ulong addr;
>      target_ulong end;
> @@ -1427,7 +1424,6 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int
idx, int use_extra)
>      /* 1k pages are not supported. */
>      mask =3D tlb->PageMask | ~(TARGET_PAGE_MASK << 1);
>      if (tlb->V0) {
> -        cs =3D CPU(cpu);
>          addr =3D tlb->VPN & ~mask;
>  #if defined(TARGET_MIPS64)
>          if (addr >=3D (0xFFFFFFFF80000000ULL & env->SEGMask)) {
> @@ -1441,7 +1437,6 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int
idx, int use_extra)
>          }
>      }
>      if (tlb->V1) {
> -        cs =3D CPU(cpu);
>          addr =3D (tlb->VPN & ~mask) | ((mask >> 1) + 1);
>  #if defined(TARGET_MIPS64)
>          if (addr >=3D (0xFFFFFFFF80000000ULL & env->SEGMask)) {
> @@ -1462,7 +1457,7 @@ void QEMU_NORETURN
do_raise_exception_err(CPUMIPSState *env,
>                                            int error_code,
>                                            uintptr_t pc)
>  {
> -    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      qemu_log_mask(CPU_LOG_INT, "%s: %d %d\n",
>                    __func__, exception, error_code);
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 0f272a5b93..0705e8c686 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -350,7 +350,7 @@ static inline hwaddr
do_translate_address(CPUMIPSState *env,
>                                                        int rw, uintptr_t
retaddr)
>  {
>      hwaddr paddr;
> -    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      paddr =3D cpu_mips_translate_address(env, address, rw);
>
> @@ -699,7 +699,7 @@ static CPUMIPSState *mips_cpu_map_tc(CPUMIPSState
*env, int *tc)
>          return env;
>      }
>
> -    cs =3D CPU(mips_env_get_cpu(env));
> +    cs =3D env_cpu(env);
>      vpe_idx =3D tc_idx / cs->nr_threads;
>      *tc =3D tc_idx % cs->nr_threads;
>      other_cs =3D qemu_get_cpu(vpe_idx);
> @@ -1298,7 +1298,7 @@ void helper_mttc0_tcrestart(CPUMIPSState *env,
target_ulong arg1)
>
>  void helper_mtc0_tchalt(CPUMIPSState *env, target_ulong arg1)
>  {
> -    MIPSCPU *cpu =3D mips_env_get_cpu(env);
> +    MIPSCPU *cpu =3D env_archcpu(env);
>
>      env->active_tc.CP0_TCHalt =3D arg1 & 0x1;
>
> @@ -1314,7 +1314,7 @@ void helper_mttc0_tchalt(CPUMIPSState *env,
target_ulong arg1)
>  {
>      int other_tc =3D env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
>      CPUMIPSState *other =3D mips_cpu_map_tc(env, &other_tc);
> -    MIPSCPU *other_cpu =3D mips_env_get_cpu(other);
> +    MIPSCPU *other_cpu =3D env_archcpu(other);
>
>      // TODO: Halt TC / Restart (if allocated+active) TC.
>
> @@ -1427,7 +1427,7 @@ void helper_mtc0_pagegrain(CPUMIPSState *env,
target_ulong arg1)
>
>  void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
>  {
> -    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      env->CP0_SegCtl0 =3D arg1 & CP0SC0_MASK;
>      tlb_flush(cs);
> @@ -1435,7 +1435,7 @@ void helper_mtc0_segctl0(CPUMIPSState *env,
target_ulong arg1)
>
>  void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
>  {
> -    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      env->CP0_SegCtl1 =3D arg1 & CP0SC1_MASK;
>      tlb_flush(cs);
> @@ -1443,7 +1443,7 @@ void helper_mtc0_segctl1(CPUMIPSState *env,
target_ulong arg1)
>
>  void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
>  {
> -    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      env->CP0_SegCtl2 =3D arg1 & CP0SC2_MASK;
>      tlb_flush(cs);
> @@ -1666,7 +1666,7 @@ void helper_mtc0_entryhi(CPUMIPSState *env,
target_ulong arg1)
>      /* If the ASID changes, flush qemu's TLB.  */
>      if ((old & env->CP0_EntryHi_ASID_mask) !=3D
>          (val & env->CP0_EntryHi_ASID_mask)) {
> -        tlb_flush(CPU(mips_env_get_cpu(env)));
> +        tlb_flush(env_cpu(env));
>      }
>  }
>
> @@ -1686,7 +1686,6 @@ void helper_mtc0_compare(CPUMIPSState *env,
target_ulong arg1)
>
>  void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
>  {
> -    MIPSCPU *cpu =3D mips_env_get_cpu(env);
>      uint32_t val, old;
>
>      old =3D env->CP0_Status;
> @@ -1706,7 +1705,7 @@ void helper_mtc0_status(CPUMIPSState *env,
target_ulong arg1)
>          case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
>          case MIPS_HFLAG_KM: qemu_log("\n"); break;
>          default:
> -            cpu_abort(CPU(cpu), "Invalid MMU mode!\n");
> +            cpu_abort(env_cpu(env), "Invalid MMU mode!\n");
>              break;
>          }
>      }
> @@ -2485,8 +2484,6 @@ static void debug_pre_eret(CPUMIPSState *env)
>
>  static void debug_post_eret(CPUMIPSState *env)
>  {
> -    MIPSCPU *cpu =3D mips_env_get_cpu(env);
> -
>      if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
>          qemu_log("  =3D>  PC " TARGET_FMT_lx " EPC " TARGET_FMT_lx,
>                  env->active_tc.PC, env->CP0_EPC);
> @@ -2502,7 +2499,7 @@ static void debug_post_eret(CPUMIPSState *env)
>          case MIPS_HFLAG_SM: qemu_log(", SM\n"); break;
>          case MIPS_HFLAG_KM: qemu_log("\n"); break;
>          default:
> -            cpu_abort(CPU(cpu), "Invalid MMU mode!\n");
> +            cpu_abort(env_cpu(env), "Invalid MMU mode!\n");
>              break;
>          }
>      }
> @@ -2633,7 +2630,7 @@ void helper_pmon(CPUMIPSState *env, int function)
>
>  void helper_wait(CPUMIPSState *env)
>  {
> -    CPUState *cs =3D CPU(mips_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      cs->halted =3D 1;
>      cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f96c0d01ef..8043e8d398 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -29912,8 +29912,7 @@ void cpu_set_exception_base(int vp_index,
target_ulong address)
>
>  void cpu_state_reset(CPUMIPSState *env)
>  {
> -    MIPSCPU *cpu =3D mips_env_get_cpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
>
>      /* Reset registers to their default values */
>      env->CP0_PRid =3D env->cpu_model->CP0_PRid;
> diff --git a/target/mips/translate_init.inc.c
b/target/mips/translate_init.inc.c
> index 1c2d017d36..6d145a905a 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -871,8 +871,6 @@ static void r4k_mmu_init (CPUMIPSState *env, const
mips_def_t *def)
>
>  static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
>  {
> -    MIPSCPU *cpu =3D mips_env_get_cpu(env);
> -
>      env->tlb =3D g_malloc0(sizeof(CPUMIPSTLBContext));
>
>      switch (def->mmu_type) {
> @@ -889,7 +887,7 @@ static void mmu_init (CPUMIPSState *env, const
mips_def_t *def)
>          case MMU_TYPE_R6000:
>          case MMU_TYPE_R8000:
>          default:
> -            cpu_abort(CPU(cpu), "MMU type not supported\n");
> +            cpu_abort(env_cpu(env), "MMU type not supported\n");
>      }
>  }
>  #endif /* CONFIG_USER_ONLY */
> --
> 2.17.1
>
>
