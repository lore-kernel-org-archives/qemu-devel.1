Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A29C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FA020771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8kStcDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FA020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zZC-0000Wi-Ik
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5zXJ-0005YL-Ly; Wed, 12 Aug 2020 18:47:57 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:32796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5zXH-0006XX-Kc; Wed, 12 Aug 2020 18:47:57 -0400
Received: by mail-io1-xd41.google.com with SMTP id g14so4936876iom.0;
 Wed, 12 Aug 2020 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Jfo10by6vLJkKTgo0CG0I2kxEsku2VxYeFJyvTMWvc=;
 b=f8kStcDpzJ4gIuv49bvC7mVydWVxphVJBKoeMDRLETbCaiAozY4RkFoZBGxrO1kgIa
 Gu+87JR/K3wqRGirouDlQsB6y9QlrJnVUgrDPt5uBUN6fnzvQnLof3rhTD4D0hqBoDuU
 YMxnSPoi4LF7b1ZvwgStPw0XWFhuCHFi3GAqKrPMmWva1KuNipwtSRlbv0oOTmqmp/u7
 HpXIlgUeW/TZN4Wiu9WyXXbCj7alP/PO/JhpppzQVvX3Yl5SKWFTqqXEtNHBxvF/2RCW
 a/TKuT4I64mLRArqmudfiK2Ha8PzQNxf8rFQIUbayQ1hLQ42EWLZKjflo1U7Cp3aHO8N
 cQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Jfo10by6vLJkKTgo0CG0I2kxEsku2VxYeFJyvTMWvc=;
 b=aRTh0bWoFH1cYqi7BU7SyU2Te5n1b23XyTyrvlAaspT8IVM6/SkavsSdsJj/7YHlLm
 zcF6uy2pLnHnUPkmv0j3vPOAtkGO59xdBIRUWIHVOj4VV40D+YYeniPIQqAX/Cay7mT2
 XMpVQZT1hAKEtEh4FrxETPymcfD7Jvj1sA6byoUoeSlEVRcu6Lbp/bLlGkyafa6tDiRh
 rgiV0YbRWaCZo0u6Z72RevGr0/uDGPL3MVimvX/LfQ87TDsa5cmsoWXt1tIafIZa1JOC
 3wvBYb4+RgMw1hHO31bEvIJ1heXvoWYmcIhu+dNNNvw9Y/WWhNlfpRQX7Dd89rlfosEh
 D/cw==
X-Gm-Message-State: AOAM5329bzagA65AS04+bq4nEhLk6jbOFxA0pMaE17yznzHpZmHXrf6L
 cvtxkYeRV784GSmyiSwLBsK0FtrJ5aP/susAwaY=
X-Google-Smtp-Source: ABdhPJzUl6WNvt7Kbk4mAUNazbx06sjXR8lXfRFaWq4xtfT9B1f5hgmhVU/zTEnVTwzVKkjMv0jQflPFzGzWAM7PXDA=
X-Received: by 2002:a6b:400e:: with SMTP id k14mr1970776ioa.175.1597272473800; 
 Wed, 12 Aug 2020 15:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200729112801.108985-1-anup.patel@wdc.com>
 <20200729112801.108985-2-anup.patel@wdc.com>
In-Reply-To: <20200729112801.108985-2-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Aug 2020 15:37:27 -0700
Message-ID: <CAKmqyKOhbRDdf6eHuiytftzj5KHFYcrgwp2zkTPfkRcNn=MsYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv: Optional feature to provide trapped
 instruction in CSRs
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 4:29 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The RISC-V spec allows implementations to provide trapped instruction
> opcode in MTVAL/STVAL CSR for illegal/virtual instruction traps. This
> is totally optional and most RISC-V implementations always set zero
> in the MTVAL/STVAL CSR for illegal/virtual instruction traps.
>
> When trapped instruction opcode is available in MTVAL/STVAL CSR, the
> M-mode runtime firmware (and Hypervisors) can skip unprivlege access
> for reading trapped instruction opcode which in-turn will speed-up
> the illegal/virtual instruction trap handling.
>
> This patch implements RISCV_FEATURE_TINST feature which when enabled
> provides original trapped instruction opcode in MTVAL/STVAL CSRs for
> illegal/virtual instruction trap.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c        |  7 +++++++
>  target/riscv/cpu.h        | 11 ++++++++++-
>  target/riscv/cpu_helper.c |  6 ++++++
>  target/riscv/translate.c  | 14 +++++++++++++-
>  4 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eeb91f8513..ec098e445e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -317,6 +317,7 @@ void restore_state_to_opc(CPURISCVState *env, TranslationBlock *tb,
>                            target_ulong *data)
>  {
>      env->pc = data[0];
> +    env->trap_insn = data[1];
>  }
>
>  static void riscv_cpu_reset(DeviceState *dev)
> @@ -332,6 +333,7 @@ static void riscv_cpu_reset(DeviceState *dev)
>      env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>      env->mcause = 0;
>      env->pc = env->resetvec;
> +    env->trap_insn = 0;
>  #endif
>      cs->exception_index = EXCP_NONE;
>      env->load_res = -1;
> @@ -387,6 +389,10 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          set_feature(env, RISCV_FEATURE_PMP);
>      }
>
> +    if (cpu->cfg.tinst) {
> +        set_feature(env, RISCV_FEATURE_TINST);
> +    }
> +
>      /* If misa isn't set (rv32 and rv64 machines) set it here */
>      if (!env->misa) {
>          /* Do some ISA extension error checking */
> @@ -487,6 +493,7 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
>      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>      DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
> +    DEFINE_PROP_BOOL("tinst", RISCVCPU, cfg.tinst, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1bb5271511..33984539d7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -26,6 +26,12 @@
>
>  #define TCG_GUEST_DEFAULT_MO 0
>
> +/*
> + * RISC-V-specific extra insn start words:
> + * 1: Original instruction opcode
> + */
> +#define TARGET_INSN_START_EXTRA_WORDS 1
> +
>  #define TYPE_RISCV_CPU "riscv-cpu"
>
>  #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
> @@ -70,7 +76,8 @@
>  enum {
>      RISCV_FEATURE_MMU,
>      RISCV_FEATURE_PMP,
> -    RISCV_FEATURE_MISA
> +    RISCV_FEATURE_MISA,
> +    RISCV_FEATURE_TINST
>  };
>
>  #define PRIV_VERSION_1_10_0 0x00011000
> @@ -97,6 +104,7 @@ struct CPURISCVState {
>      target_ulong frm;
>
>      target_ulong badaddr;
> +    target_ulong trap_insn;
>      target_ulong guest_phys_fault_addr;
>
>      target_ulong priv_ver;
> @@ -264,6 +272,7 @@ typedef struct RISCVCPU {
>          char *user_spec;
>          bool mmu;
>          bool pmp;
> +        bool tinst;
>      } cfg;
>  } RISCVCPU;
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index eccd80cfef..e4bd45d66a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -864,6 +864,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          case RISCV_EXCP_STORE_PAGE_FAULT:
>              tval = env->badaddr;
>              break;
> +        case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
> +        case RISCV_EXCP_ILLEGAL_INST:
> +            if (riscv_feature(env, RISCV_FEATURE_TINST)) {
> +                tval = env->trap_insn;
> +            }
> +            break;
>          default:
>              break;
>          }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 1d973b62e9..03954bff62 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -56,6 +56,8 @@ typedef struct DisasContext {
>         to reset this known value.  */
>      int frm;
>      bool ext_ifencei;
> +    /* TCG op of the current insn_start.  */
> +    TCGOp *insn_start;
>  } DisasContext;
>
>  #ifdef TARGET_RISCV64
> @@ -717,6 +719,13 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode_insn16.inc.c"
>
> +static inline void decode_save_opc(DisasContext *ctx, target_ulong opc)
> +{
> +    assert(ctx->insn_start != NULL);
> +    tcg_set_insn_start_param(ctx->insn_start, 1, opc);
> +    ctx->insn_start = NULL;
> +}
> +
>  static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>  {
>      /* check for compressed insn */
> @@ -724,6 +733,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>          if (!has_ext(ctx, RVC)) {
>              gen_exception_illegal(ctx);
>          } else {
> +            decode_save_opc(ctx, opcode);
>              ctx->pc_succ_insn = ctx->base.pc_next + 2;
>              if (!decode_insn16(ctx, opcode)) {
>                  /* fall back to old decoder */
> @@ -734,6 +744,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>          uint32_t opcode32 = opcode;
>          opcode32 = deposit32(opcode32, 16, 16,
>                               translator_lduw(env, ctx->base.pc_next + 2));
> +        decode_save_opc(ctx, opcode32);
>          ctx->pc_succ_insn = ctx->base.pc_next + 4;
>          if (!decode_insn32(ctx, opcode32)) {
>              gen_exception_illegal(ctx);
> @@ -773,7 +784,8 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>  {
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>
> -    tcg_gen_insn_start(ctx->base.pc_next);
> +    tcg_gen_insn_start(ctx->base.pc_next, 0);
> +    ctx->insn_start = tcg_last_op();
>  }
>
>  static bool riscv_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
> --
> 2.25.1
>
>

