Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6281C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD47D2098B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJAxQdsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD47D2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW71m-0001YL-HX
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW70r-00013q-AZ; Fri, 23 Oct 2020 20:02:25 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:35992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW70o-0006EQ-CA; Fri, 23 Oct 2020 20:02:25 -0400
Received: by mail-il1-x141.google.com with SMTP id p10so3054821ile.3;
 Fri, 23 Oct 2020 17:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ak61T3PoKuBELvN9gv+gPP5hEiSohwTZ7UzgfBTzXn0=;
 b=vJAxQdsHimF0Su58aza0uqQSaStD+YizoFU7qhI960YuvASKB5hlzqNDyzaFomqdcc
 EeQ87TeLve8DCzElkyd5LTXLkOowm5I2/kRq5He8VondcJYGJuDOOI+UTLNvitARSRip
 krkjoYLsg3OYfHJVoZoChpZcg3izAscbTknvrN29aKpIQAxaQ2zGJxcDI0gIxuYZqMjO
 OHh0F/E65A+/YJsN61J+SsWsSdNGYBFKDvqyNmn5BimwpAw78LJTxn1rd4TiGzOWdqCx
 aVAgCEsMFd1zLjmWFpwjU3Yvy7SeSspxB8Zf8nE0zVUL8kU5im4WjITJzUQ6E4hWodEg
 8t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ak61T3PoKuBELvN9gv+gPP5hEiSohwTZ7UzgfBTzXn0=;
 b=WNmJh1B4SNvKm+TT4Wn8vEZ45xQykr82lQESUxjL2woaloM2+9qXcdEQ7a3fkDRmO/
 bV8cMmQNVunRDR3VAMgzdW5KOpBjHPbLNmrJjKqj+oGVV50lnodW13aUiLoGpbQQjbK+
 A2YcUYPKu5M4yjSh7fpjyo29+EXzFgAQx6ayxf7QTzF2dOJgijBUGI/aloHa4tGnWBUx
 IHgDA/VtG5AeVIPt4BmJjOzjvgvJ9OiFt7Hk5MhPIh97uuV7kXUCp8Smr+7sZuJ/2Zso
 SJMpxBbKBl6tf8lTfrIyTRqQyNsIGqWAI+5LqH5k9y02J47QC4+OP/c3f7+OnxSnH0u6
 +3kg==
X-Gm-Message-State: AOAM533/IiuJjVu4Yi2IomRgRoZSmMMAOZMzjaWLkYSjy5u8pfcmRbWY
 RX3lkfSuUuBTcJq66kn1AbdAkQj8TH1IQ5OE+Ok=
X-Google-Smtp-Source: ABdhPJwMHcWWZXWucoCjy/h9VVcGXcxUIvVVwiHQZ0XL/Hx1mcgT1vDBGlhDzJhIA1u+hxy/8VPgaI6N9ShTNRVA3L8=
X-Received: by 2002:a05:6e02:c:: with SMTP id
 h12mr3861744ilr.177.1603497739792; 
 Fri, 23 Oct 2020 17:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201023091225.224-1-jiangyifei@huawei.com>
 <20201023091225.224-2-jiangyifei@huawei.com>
In-Reply-To: <20201023091225.224-2-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 16:50:32 -0700
Message-ID: <CAKmqyKMSRkzdcSMD+KdBsLmP62L0dPPVC71eb74irWfzKo+a8g@mail.gmail.com>
Subject: Re: [PATCH V3 1/6] target/riscv: Merge m/vsstatus and m/vsstatush
 into one uint64_t unit
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 2:17 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> mstatus/mstatush and vsstatus/vsstatush are two halved for RISCV32.
> This patch expands mstatus and vsstatus to uint64_t instead of
> target_ulong so that it can be saved as one unit and reduce some
> ifdefs in the code.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>

Argh. I just sent a similar patch. I was hoping to save you having to do this.

Sorry about that.

I'm happy to apply yours as it was first.

> ---
>  target/riscv/cpu.c        |  8 +++--
>  target/riscv/cpu.h        | 16 ++-------
>  target/riscv/cpu_bits.h   | 16 ++++-----
>  target/riscv/cpu_helper.c | 72 ++++++++++++++++-----------------------
>  target/riscv/csr.c        | 28 ++++++++-------
>  target/riscv/op_helper.c  | 49 +++++++++++++-------------
>  6 files changed, 82 insertions(+), 107 deletions(-)
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
> index de275782e6..57050f2268 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -140,14 +140,10 @@ struct CPURISCVState {
>      target_ulong resetvec;
>
>      target_ulong mhartid;
> -    target_ulong mstatus;
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
> @@ -179,16 +175,13 @@ struct CPURISCVState {
>      uint64_t htimedelta;
>
>      /* Virtual CSRs */
> -    target_ulong vsstatus;
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
> @@ -200,10 +193,7 @@ struct CPURISCVState {
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
> index bd36062877..62ca6b6f89 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -5,9 +5,14 @@
>
>  #define get_field(reg, mask) (((reg) & \
>                   (target_ulong)(mask)) / ((mask) & ~((mask) << 1)))
> +#define get_field64(reg, mask) (((reg) & \
> +                   (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
>  #define set_field(reg, mask, val) (((reg) & ~(target_ulong)(mask)) | \
>                   (((target_ulong)(val) * ((mask) & ~((mask) << 1))) & \
>                   (target_ulong)(mask)))
> +#define set_field64(reg, mask, val) (((reg) & ~(uint64_t)(mask)) | \
> +                   (((uint64_t)(val) * ((mask) & ~((mask) << 1))) & \
> +                   (uint64_t)(mask)))

We should just be able to change the existing ones to use uint64_t.

>
>  /* Floating point round mode */
>  #define FSR_RD_SHIFT        5
> @@ -381,19 +386,10 @@
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
>
> -#ifdef TARGET_RISCV32
> -# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatush, MSTATUS_MPV)
> -#else
> -# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatus, MSTATUS_MPV)
> -#endif
> +#define MSTATUS_MPV_ISSET(env)  get_field64(env->mstatus, MSTATUS_MPV)

I think also just remove this macro and replace it with
get_field64(env->mstatus, MSTATUS_MPV).

>
>  #define MSTATUS64_UXL       0x0000000300000000ULL
>  #define MSTATUS64_SXL       0x0000000C00000000ULL
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 904899054d..0430cbe4e3 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -39,9 +39,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>  {
>      target_ulong irqs;
>
> -    target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
> -    target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
> -    target_ulong hs_mstatus_sie = get_field(env->mstatus_hs, MSTATUS_SIE);
> +    target_ulong mstatus_mie = get_field64(env->mstatus, MSTATUS_MIE);
> +    target_ulong mstatus_sie = get_field64(env->mstatus, MSTATUS_SIE);
> +    target_ulong hs_mstatus_sie = get_field64(env->mstatus_hs, MSTATUS_SIE);
>
>      target_ulong pending = env->mip & env->mie &
>                                 ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
> @@ -110,14 +110,20 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
>
>  void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>  {
> -    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
> -                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
> +    uint64_t mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
> +                            MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
>      bool current_virt = riscv_cpu_virt_enabled(env);
>
>      g_assert(riscv_has_ext(env, RVH));
>
>  #if defined(TARGET_RISCV64)
>      mstatus_mask |= MSTATUS64_UXL;
> +#elif defined(TARGET_RISCV32)
> +    /*
> +     * The upper 32 bits of env->mstatus is mstatush
> +     * register in RISCV32. We need to backup it.
> +     */
> +    mstatus_mask |= (~0ULL << 32);

I don't think we need this. This should just follow the standard mstatus mask.

>  #endif
>
>      if (current_virt) {
> @@ -126,11 +132,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
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
> @@ -154,11 +155,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
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
> @@ -347,8 +343,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>      }
>
>      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> -            mode = get_field(env->mstatus, MSTATUS_MPP);
> +        if (get_field64(env->mstatus, MSTATUS_MPRV)) {
> +            mode = get_field64(env->mstatus, MSTATUS_MPP);
>          }
>      }
>
> @@ -370,9 +366,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>      int levels, ptidxbits, ptesize, vm, sum, mxr, widened;
>
>      if (first_stage == true) {
> -        mxr = get_field(env->mstatus, MSTATUS_MXR);
> +        mxr = get_field64(env->mstatus, MSTATUS_MXR);
>      } else {
> -        mxr = get_field(env->vsstatus, MSTATUS_MXR);
> +        mxr = get_field64(env->vsstatus, MSTATUS_MXR);
>      }
>
>      if (first_stage == true) {
> @@ -389,7 +385,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>          vm = get_field(env->hgatp, HGATP_MODE);
>          widened = 2;
>      }
> -    sum = get_field(env->mstatus, MSTATUS_SUM);
> +    sum = get_field64(env->mstatus, MSTATUS_SUM);
>      switch (vm) {
>      case VM_1_10_SV32:
>        levels = 2; ptidxbits = 10; ptesize = 4; break;
> @@ -712,14 +708,14 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                    __func__, address, access_type, mmu_idx);
>
>      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> -            mode = get_field(env->mstatus, MSTATUS_MPP);
> +        if (get_field64(env->mstatus, MSTATUS_MPRV)) {
> +            mode = get_field64(env->mstatus, MSTATUS_MPP);
>          }
>      }
>
>      if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
>          access_type != MMU_INST_FETCH &&
> -        get_field(env->mstatus, MSTATUS_MPRV) &&
> +        get_field64(env->mstatus, MSTATUS_MPRV) &&
>          MSTATUS_MPV_ISSET(env)) {
>          riscv_cpu_set_two_stage_lookup(env, true);
>      }
> @@ -780,7 +776,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      /* We did the two stage lookup based on MPRV, unset the lookup */
>      if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
>          access_type != MMU_INST_FETCH &&
> -        get_field(env->mstatus, MSTATUS_MPRV) &&
> +        get_field64(env->mstatus, MSTATUS_MPRV) &&
>          MSTATUS_MPV_ISSET(env)) {
>          riscv_cpu_set_two_stage_lookup(env, false);
>      }
> @@ -844,7 +840,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
>      bool force_hs_execp = riscv_cpu_force_hs_excep_enabled(env);
> -    target_ulong s;
> +    uint64_t s;
>
>      /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
>       * so we mask off the MSB and separate into trap type and cause.
> @@ -932,7 +928,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                  /* Trap into HS mode, from virt */
>                  riscv_cpu_swap_hypervisor_regs(env);
>                  env->hstatus = set_field(env->hstatus, HSTATUS_SPVP,
> -                                         get_field(env->mstatus, SSTATUS_SPP));
> +                                         get_field64(env->mstatus, SSTATUS_SPP));
>                  env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
>                                           riscv_cpu_virt_enabled(env));
>
> @@ -952,9 +948,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          }
>
>          s = env->mstatus;
> -        s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
> -        s = set_field(s, MSTATUS_SPP, env->priv);
> -        s = set_field(s, MSTATUS_SIE, 0);
> +        s = set_field64(s, MSTATUS_SPIE, get_field64(s, MSTATUS_SIE));
> +        s = set_field64(s, MSTATUS_SPP, env->priv);
> +        s = set_field64(s, MSTATUS_SIE, 0);
>          env->mstatus = s;
>          env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
>          env->sepc = env->pc;
> @@ -969,19 +965,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              if (riscv_cpu_virt_enabled(env)) {
>                  riscv_cpu_swap_hypervisor_regs(env);
>              }
> -#ifdef TARGET_RISCV32
> -            env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
> +            env->mstatus = set_field64(env->mstatus, MSTATUS_MPV,
>                                         riscv_cpu_virt_enabled(env));
>              if (riscv_cpu_virt_enabled(env) && tval) {
> -                env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
> -            }
> -#else
> -            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
> -                                      riscv_cpu_virt_enabled(env));
> -            if (riscv_cpu_virt_enabled(env) && tval) {
> -                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
> +                env->mstatus = set_field64(env->mstatus, MSTATUS_GVA, 1);
>              }
> -#endif
>
>              mtval2 = env->guest_phys_fault_addr;
>
> @@ -991,9 +979,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          }
>
>          s = env->mstatus;
> -        s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
> -        s = set_field(s, MSTATUS_MPP, env->priv);
> -        s = set_field(s, MSTATUS_MIE, 0);
> +        s = set_field64(s, MSTATUS_MPIE, get_field64(s, MSTATUS_MIE));
> +        s = set_field64(s, MSTATUS_MPP, env->priv);
> +        s = set_field64(s, MSTATUS_MIE, 0);
>          env->mstatus = s;
>          env->mcause = cause | ~(((target_ulong)-1) >> async);
>          env->mepc = env->pc;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index aaef6c6f20..d4b6371719 100644
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
> @@ -471,7 +471,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>
>      dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
>              ((mstatus & MSTATUS_XS) == MSTATUS_XS);
> -    mstatus = set_field(mstatus, MSTATUS_SD, dirty);
> +    mstatus = set_field64(mstatus, MSTATUS_SD, dirty);
>      env->mstatus = mstatus;
>
>      return 0;
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

Looks good!

>
>      return 0;
>  }
> @@ -718,14 +719,14 @@ static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
>  static int read_sstatus(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>      target_ulong mask = (sstatus_v1_10_mask);
> -    *val = env->mstatus & mask;
> +    *val = (target_ulong)env->mstatus & mask;

I don't think you need all of these casts.

Alistair

>      return 0;
>  }
>
>  static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
>  {
>      target_ulong mask = (sstatus_v1_10_mask);
> -    target_ulong newval = (env->mstatus & ~mask) | (val & mask);
> +    target_ulong newval = ((target_ulong)env->mstatus & ~mask) | (val & mask);
>      return write_mstatus(env, CSR_MSTATUS, newval);
>  }
>
> @@ -861,7 +862,7 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
>          return 0;
>      }
>
> -    if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> +    if (env->priv == PRV_S && get_field64(env->mstatus, MSTATUS_TVM)) {
>          return -RISCV_EXCP_ILLEGAL_INST;
>      } else {
>          *val = env->satp;
> @@ -878,7 +879,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>      if (validate_vm(env, get_field(val, SATP_MODE)) &&
>          ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
>      {
> -        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> +        if (env->priv == PRV_S && get_field64(env->mstatus, MSTATUS_TVM)) {
>              return -RISCV_EXCP_ILLEGAL_INST;
>          } else {
>              if((val ^ env->satp) & SATP_ASID) {
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
> index 9b9ada45a9..18cdffc738 100644
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
> @@ -90,7 +91,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> -    if (get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >= PRV_M)) {
> +    if (get_field64(env->mstatus, MSTATUS_TSR) && !(env->priv >= PRV_M)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> @@ -105,14 +106,14 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          /* We support Hypervisor extensions and virtulisation is disabled */
>          target_ulong hstatus = env->hstatus;
>
> -        prev_priv = get_field(mstatus, MSTATUS_SPP);
> +        prev_priv = get_field64(mstatus, MSTATUS_SPP);
>          prev_virt = get_field(hstatus, HSTATUS_SPV);
>
>          hstatus = set_field(hstatus, HSTATUS_SPV, 0);
> -        mstatus = set_field(mstatus, MSTATUS_SPP, 0);
> -        mstatus = set_field(mstatus, SSTATUS_SIE,
> -                            get_field(mstatus, SSTATUS_SPIE));
> -        mstatus = set_field(mstatus, SSTATUS_SPIE, 1);
> +        mstatus = set_field64(mstatus, MSTATUS_SPP, 0);
> +        mstatus = set_field64(mstatus, SSTATUS_SIE,
> +                              get_field64(mstatus, SSTATUS_SPIE));
> +        mstatus = set_field64(mstatus, SSTATUS_SPIE, 1);
>
>          env->mstatus = mstatus;
>          env->hstatus = hstatus;
> @@ -123,12 +124,12 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>
>          riscv_cpu_set_virt_enabled(env, prev_virt);
>      } else {
> -        prev_priv = get_field(mstatus, MSTATUS_SPP);
> +        prev_priv = get_field64(mstatus, MSTATUS_SPP);
>
> -        mstatus = set_field(mstatus, MSTATUS_SIE,
> -                            get_field(mstatus, MSTATUS_SPIE));
> -        mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
> -        mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
> +        mstatus = set_field64(mstatus, MSTATUS_SIE,
> +                              get_field64(mstatus, MSTATUS_SPIE));
> +        mstatus = set_field64(mstatus, MSTATUS_SPIE, 1);
> +        mstatus = set_field64(mstatus, MSTATUS_SPP, PRV_U);
>          env->mstatus = mstatus;
>      }
>
> @@ -148,18 +149,14 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> -    target_ulong mstatus = env->mstatus;
> -    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> +    uint64_t mstatus = env->mstatus;
> +    target_ulong prev_priv = get_field64(mstatus, MSTATUS_MPP);
>      target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
> -    mstatus = set_field(mstatus, MSTATUS_MIE,
> -                        get_field(mstatus, MSTATUS_MPIE));
> -    mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
> -    mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
> -#ifdef TARGET_RISCV32
> -    env->mstatush = set_field(env->mstatush, MSTATUS_MPV, 0);
> -#else
> -    mstatus = set_field(mstatus, MSTATUS_MPV, 0);
> -#endif
> +    mstatus = set_field64(mstatus, MSTATUS_MIE,
> +                          get_field64(mstatus, MSTATUS_MPIE));
> +    mstatus = set_field64(mstatus, MSTATUS_MPIE, 1);
> +    mstatus = set_field64(mstatus, MSTATUS_MPP, PRV_U);
> +    mstatus = set_field64(mstatus, MSTATUS_MPV, 0);
>      env->mstatus = mstatus;
>      riscv_cpu_set_mode(env, prev_priv);
>
> @@ -179,7 +176,7 @@ void helper_wfi(CPURISCVState *env)
>      CPUState *cs = env_cpu(env);
>
>      if ((env->priv == PRV_S &&
> -        get_field(env->mstatus, MSTATUS_TW)) ||
> +        get_field64(env->mstatus, MSTATUS_TW)) ||
>          riscv_cpu_virt_enabled(env)) {
>          riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
>      } else {
> @@ -194,7 +191,7 @@ void helper_tlb_flush(CPURISCVState *env)
>      CPUState *cs = env_cpu(env);
>      if (!(env->priv >= PRV_S) ||
>          (env->priv == PRV_S &&
> -         get_field(env->mstatus, MSTATUS_TVM))) {
> +         get_field64(env->mstatus, MSTATUS_TVM))) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else if (riscv_has_ext(env, RVH) && riscv_cpu_virt_enabled(env) &&
>                 get_field(env->hstatus, HSTATUS_VTVM)) {
> @@ -224,7 +221,7 @@ void helper_hyp_tlb_flush(CPURISCVState *env)
>  void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
>  {
>      if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env) &&
> -        get_field(env->mstatus, MSTATUS_TVM)) {
> +        get_field64(env->mstatus, MSTATUS_TVM)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> --
> 2.19.1
>
>

