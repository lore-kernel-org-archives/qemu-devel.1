Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B175C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F4120725
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QagsUmHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F4120725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXVkK-0006tH-Ms
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 16:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXVj7-0005bR-EU; Tue, 27 Oct 2020 16:37:53 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXVj5-00061h-6n; Tue, 27 Oct 2020 16:37:53 -0400
Received: by mail-il1-x142.google.com with SMTP id f16so2758391ilr.0;
 Tue, 27 Oct 2020 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yeU8aEpdQODwjSCLruSF1TbIJ8MmjqUnHrIhXZD4fo4=;
 b=QagsUmHPIzJ5HVK4jMH6T2Ww0fv0rZRK9E5vLEiXowZ9ZzYP5jQIq3+o0svFgl8Rm4
 aZt+oBDbHyUaxwzhlJInwmSYTv/z7Vy1yVAyfu8NtbMWr6sk2a3i9GgALilqMAXDTGkz
 CfF1koCfxym7yHJDZgjHuOCBCEm0oYZtmdG5n6ryWrluaRxXRYIaICYjs1BYN4jq0Qe0
 6kKrIvz34yBX+SJL1+simF0LdeKfVxeT/VKJLnNFqVCOyvfQg/ucNdicc8w2OrgtnX8h
 26sCpeL3I07nApofUP42NUXK8H0/Pi4MBG+GHpLqGck9aumgbhmwFU0yVoISkTO53yOv
 kc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yeU8aEpdQODwjSCLruSF1TbIJ8MmjqUnHrIhXZD4fo4=;
 b=kxwpypDorUO3lk0Dj4sjD3Q+oEwJ7qHcTO5QRLggcoPda3y7ySBEaW4uQAzgJaV/zA
 hMmdFzv8LGOKqilwtTjcvr4nGGcsk00rOPsynZVn0f6R6M6vO4M84+7uV6wBQ9HNqJA4
 I8CuwvpaKuXvBa4QNT28KNYmy/7kjYNS0F+ddv3Kk4bePWgn6RuzLKxfgnyztExjwgp+
 8ZrB+NbANhi1xW+AZ6wolCfAYy9kQXgwcLw5QniM27I59qhLdslPVwCKZtLQz0GlqD+V
 U2W0I+8b0fivIOD8jc7KxrdtJqPzrdIrzl99pXl1Ak7TnNqmUa7VVoRoB5c1SKF5stio
 eZbQ==
X-Gm-Message-State: AOAM5326oVql+nrzSRf6BmEzJqfkB+lPnxzB6pkGY5NvohVvrPCaLw7q
 oem0AdFP3Eua9sp5em3/KFZtty78TK+2Y6Siu+U=
X-Google-Smtp-Source: ABdhPJwFAe5veY2aTK7X1qqWI6LEE1Xul2KwXGff4KDSNgrb39Wsuj8pbLkg/kRnEeFTanc9Joj7fD/GUAmkhzw78DI=
X-Received: by 2002:a92:d803:: with SMTP id y3mr2000416ilm.227.1603831069730; 
 Tue, 27 Oct 2020 13:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201026115530.304-1-jiangyifei@huawei.com>
 <20201026115530.304-2-jiangyifei@huawei.com>
In-Reply-To: <20201026115530.304-2-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Oct 2020 13:26:00 -0700
Message-ID: <CAKmqyKPxyoFNjWkdHM9UU6f8tNaW_MSUbXYokrh0CkxXWL84=w@mail.gmail.com>
Subject: Re: [PATCH V4 1/6] target/riscv: Merge m/vsstatus and m/vsstatush
 into one uint64_t unit
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 4:58 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> mstatus/mstatush and vsstatus/vsstatush are two halved for RISCV32.
> This patch expands mstatus and vsstatus to uint64_t instead of
> target_ulong so that it can be saved as one unit and reduce some
> ifdefs in the code.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c        |  8 +++++---
>  target/riscv/cpu.h        | 24 +++++++++++-------------
>  target/riscv/cpu_bits.h   | 19 ++++---------------
>  target/riscv/cpu_helper.c | 35 +++++++----------------------------
>  target/riscv/csr.c        | 18 ++++++++++--------
>  target/riscv/op_helper.c  | 11 ++++-------
>  6 files changed, 41 insertions(+), 74 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0bbfd7f457..dd05a220c7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -216,13 +216,15 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
>  #ifndef CONFIG_USER_ONLY
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
> -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", (target_ulong)env->mstatus);
>  #ifdef TARGET_RISCV32
> -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", env->mstatush);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ",
> +                 (target_ulong)(env->mstatus >> 32));
>  #endif
>      if (riscv_has_ext(env, RVH)) {
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
> -        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ",
> +                     (target_ulong)env->vsstatus);
>      }
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index de275782e6..e430670b60 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -140,14 +140,14 @@ struct CPURISCVState {
>      target_ulong resetvec;
>
>      target_ulong mhartid;
> -    target_ulong mstatus;
> +    /*
> +     * For RV32 this is 32-bit mstatus and 32-bit mstatush.
> +     * For RV64 this is a 64-bit mstatus.
> +     */
> +    uint64_t mstatus;
>
>      target_ulong mip;
>
> -#ifdef TARGET_RISCV32
> -    target_ulong mstatush;
> -#endif
> -
>      uint32_t miclaim;
>
>      target_ulong mie;
> @@ -179,16 +179,17 @@ struct CPURISCVState {
>      uint64_t htimedelta;
>
>      /* Virtual CSRs */
> -    target_ulong vsstatus;
> +    /*
> +     * For RV32 this is 32-bit vsstatus and 32-bit vsstatush.
> +     * For RV64 this is a 64-bit vsstatus.
> +     */
> +    uint64_t vsstatus;
>      target_ulong vstvec;
>      target_ulong vsscratch;
>      target_ulong vsepc;
>      target_ulong vscause;
>      target_ulong vstval;
>      target_ulong vsatp;
> -#ifdef TARGET_RISCV32
> -    target_ulong vsstatush;
> -#endif
>
>      target_ulong mtval2;
>      target_ulong mtinst;
> @@ -200,10 +201,7 @@ struct CPURISCVState {
>      target_ulong scause_hs;
>      target_ulong stval_hs;
>      target_ulong satp_hs;
> -    target_ulong mstatus_hs;
> -#ifdef TARGET_RISCV32
> -    target_ulong mstatush_hs;
> -#endif
> +    uint64_t mstatus_hs;
>
>      target_ulong scounteren;
>      target_ulong mcounteren;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index bd36062877..daedad8691 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -4,10 +4,10 @@
>  #define TARGET_RISCV_CPU_BITS_H
>
>  #define get_field(reg, mask) (((reg) & \
> -                 (target_ulong)(mask)) / ((mask) & ~((mask) << 1)))
> -#define set_field(reg, mask, val) (((reg) & ~(target_ulong)(mask)) | \
> -                 (((target_ulong)(val) * ((mask) & ~((mask) << 1))) & \
> -                 (target_ulong)(mask)))
> +                 (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
> +#define set_field(reg, mask, val) (((reg) & ~(uint64_t)(mask)) | \
> +                 (((uint64_t)(val) * ((mask) & ~((mask) << 1))) & \
> +                 (uint64_t)(mask)))
>
>  /* Floating point round mode */
>  #define FSR_RD_SHIFT        5
> @@ -381,19 +381,8 @@
>  #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
>  #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
>  #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
> -#if defined(TARGET_RISCV64)
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> -#elif defined(TARGET_RISCV32)
> -#define MSTATUS_GVA         0x00000040
> -#define MSTATUS_MPV         0x00000080
> -#endif
> -
> -#ifdef TARGET_RISCV32
> -# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatush, MSTATUS_MPV)
> -#else
> -# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatus, MSTATUS_MPV)
> -#endif
>
>  #define MSTATUS64_UXL       0x0000000300000000ULL
>  #define MSTATUS64_SXL       0x0000000C00000000ULL
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 904899054d..109ee4bad6 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -110,27 +110,19 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
>
>  void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>  {
> -    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
> -                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
> +    uint64_t mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
> +                            MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE |
> +                            MSTATUS64_UXL;
>      bool current_virt = riscv_cpu_virt_enabled(env);
>
>      g_assert(riscv_has_ext(env, RVH));
>
> -#if defined(TARGET_RISCV64)
> -    mstatus_mask |= MSTATUS64_UXL;
> -#endif
> -
>      if (current_virt) {
>          /* Current V=1 and we are about to change to V=0 */
>          env->vsstatus = env->mstatus & mstatus_mask;
>          env->mstatus &= ~mstatus_mask;
>          env->mstatus |= env->mstatus_hs;
>
> -#if defined(TARGET_RISCV32)
> -        env->vsstatush = env->mstatush;
> -        env->mstatush |= env->mstatush_hs;
> -#endif
> -
>          env->vstvec = env->stvec;
>          env->stvec = env->stvec_hs;
>
> @@ -154,11 +146,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>          env->mstatus &= ~mstatus_mask;
>          env->mstatus |= env->vsstatus;
>
> -#if defined(TARGET_RISCV32)
> -        env->mstatush_hs = env->mstatush;
> -        env->mstatush |= env->vsstatush;
> -#endif
> -
>          env->stvec_hs = env->stvec;
>          env->stvec = env->vstvec;
>
> @@ -720,7 +707,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
>          access_type != MMU_INST_FETCH &&
>          get_field(env->mstatus, MSTATUS_MPRV) &&
> -        MSTATUS_MPV_ISSET(env)) {
> +        get_field(env->mstatus, MSTATUS_MPV)) {
>          riscv_cpu_set_two_stage_lookup(env, true);
>      }
>
> @@ -781,7 +768,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
>          access_type != MMU_INST_FETCH &&
>          get_field(env->mstatus, MSTATUS_MPRV) &&
> -        MSTATUS_MPV_ISSET(env)) {
> +        get_field(env->mstatus, MSTATUS_MPV)) {
>          riscv_cpu_set_two_stage_lookup(env, false);
>      }
>
> @@ -844,7 +831,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
>      bool force_hs_execp = riscv_cpu_force_hs_excep_enabled(env);
> -    target_ulong s;
> +    uint64_t s;
>
>      /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
>       * so we mask off the MSB and separate into trap type and cause.
> @@ -969,19 +956,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              if (riscv_cpu_virt_enabled(env)) {
>                  riscv_cpu_swap_hypervisor_regs(env);
>              }
> -#ifdef TARGET_RISCV32
> -            env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
> -                                       riscv_cpu_virt_enabled(env));
> -            if (riscv_cpu_virt_enabled(env) && tval) {
> -                env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
> -            }
> -#else
>              env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
> -                                      riscv_cpu_virt_enabled(env));
> +                                     riscv_cpu_virt_enabled(env));
>              if (riscv_cpu_virt_enabled(env) && tval) {
>                  env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
>              }
> -#endif
>
>              mtval2 = env->guest_phys_fault_addr;
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index aaef6c6f20..e33f6cdc11 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -446,8 +446,8 @@ static int validate_vm(CPURISCVState *env, target_ulong vm)
>
>  static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>  {
> -    target_ulong mstatus = env->mstatus;
> -    target_ulong mask = 0;
> +    uint64_t mstatus = env->mstatus;
> +    uint64_t mask = 0;
>      int dirty;
>
>      /* flush tlb on mstatus fields that affect VM */
> @@ -480,19 +480,20 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>  #ifdef TARGET_RISCV32
>  static int read_mstatush(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> -    *val = env->mstatush;
> +    *val = env->mstatus >> 32;
>      return 0;
>  }
>
>  static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
>  {
> -    if ((val ^ env->mstatush) & (MSTATUS_MPV)) {
> +    uint64_t valh = (uint64_t)val << 32;
> +    uint64_t mask = MSTATUS_MPV | MSTATUS_GVA;
> +
> +    if ((valh ^ env->mstatus) & (MSTATUS_MPV)) {
>          tlb_flush(env_cpu(env));
>      }
>
> -    val &= MSTATUS_MPV | MSTATUS_GVA;
> -
> -    env->mstatush = val;
> +    env->mstatus = (env->mstatus & ~mask) | (valh & mask);
>
>      return 0;
>  }
> @@ -1105,7 +1106,8 @@ static int read_vsstatus(CPURISCVState *env, int csrno, target_ulong *val)
>
>  static int write_vsstatus(CPURISCVState *env, int csrno, target_ulong val)
>  {
> -    env->vsstatus = val;
> +    uint64_t mask = (target_ulong)-1;
> +    env->vsstatus = (env->vsstatus & ~mask) | (uint64_t)val;
>      return 0;
>  }
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 9b9ada45a9..e0b45e5eb7 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -79,7 +79,8 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
>
>  target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>  {
> -    target_ulong prev_priv, prev_virt, mstatus;
> +    uint64_t mstatus;
> +    target_ulong prev_priv, prev_virt;
>
>      if (!(env->priv >= PRV_S)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> @@ -148,18 +149,14 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> -    target_ulong mstatus = env->mstatus;
> +    uint64_t mstatus = env->mstatus;
>      target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> -    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
> +    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV);
>      mstatus = set_field(mstatus, MSTATUS_MIE,
>                          get_field(mstatus, MSTATUS_MPIE));
>      mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
>      mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
> -#ifdef TARGET_RISCV32
> -    env->mstatush = set_field(env->mstatush, MSTATUS_MPV, 0);
> -#else
>      mstatus = set_field(mstatus, MSTATUS_MPV, 0);
> -#endif
>      env->mstatus = mstatus;
>      riscv_cpu_set_mode(env, prev_priv);
>
> --
> 2.19.1
>
>

