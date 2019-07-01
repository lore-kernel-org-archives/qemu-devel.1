Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B5C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08753208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08753208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhubk-0007q9-0I
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhuU2-00010t-WB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhuTy-0000Tm-MN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:28:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhuTy-0000Se-18
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:28:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so14380492wme.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 04:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZRnCJA48Zpygm5z/lBdxJHF4kt40t88VXnsLBlLLSX4=;
 b=fVLws0V1xD8LfWJWxigoJ7tKWv6q15RvfouMSzjObu325bCAkt36xHlX2kBk0735Dj
 297GD3XxQ7xnIldwYBKcWdwbVeeIDyLeOTIZmrlnNPK29ReZ2fN8z6y+2aXC0C+CJnQc
 vM8KHEre//N01GLdcL4jtVEC4jgeGIlGN/9/VCOObpVxPcG10em+KxLyUlYhJz82cKju
 FmTeSc2/84mRwCnweQ6Vt+zcm3LtDmVdn+Xm1C0cbOefrzekByWi03TN3Eum3Q8mH8xc
 YzwriUqYcRFIz+spr1ifhpC67+U89w2G17X5OvwyEvW5z85YDda2UPJp1a6BO0BKF/P6
 o5mA==
X-Gm-Message-State: APjAAAVujHPk76Rs8xTnLORsx5ukNuWn66TrV/Ga+xAeHtqf1ZWepuNO
 HV36RmImAjscXBPzNeOgW6Oqnw==
X-Google-Smtp-Source: APXvYqzRPEi4nC5H2MFZw9h05VZ9lRb16AuIh4DeubpTMA714KcMGhZKMwfNticNbJHLcDVRchgcQw==
X-Received: by 2002:a7b:c84c:: with SMTP id c12mr16474217wml.70.1561980504731; 
 Mon, 01 Jul 2019 04:28:24 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id f7sm12640893wrv.38.2019.07.01.04.28.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 04:28:24 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 qemu-devel@nongnu.org, arikalo@wavecomp.com
References: <1561979080-26195-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561979080-26195-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <be07a680-3d9a-59a3-08e5-401234742612@redhat.com>
Date: Mon, 1 Jul 2019 13:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561979080-26195-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 4/7] target/mips: Correct comments in
 translate.c
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 1:04 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fix some checkpatch comment-related warnings.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 347 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 225 insertions(+), 122 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index e3a0f08..f427f24 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -259,8 +259,10 @@ enum {
>      OPC_SPECIAL3D_RESERVED = 0x3D | OPC_SPECIAL,
>  };
>  
> -/* R6 Multiply and Divide instructions have the same Opcode
> -   and function field as legacy OPC_MULT[U]/OPC_DIV[U] */
> +/*
> + * R6 Multiply and Divide instructions have the same opcode
> + * and function field as legacy OPC_MULT[U]/OPC_DIV[U]
> + */
>  #define MASK_R6_MULDIV(op)   (MASK_SPECIAL(op) | (op & (0x7ff)))
>  
>  enum {
> @@ -2923,10 +2925,11 @@ static inline void check_cp1_enabled(DisasContext *ctx)
>      }
>  }
>  
> -/* Verify that the processor is running with COP1X instructions enabled.
> -   This is associated with the nabla symbol in the MIPS32 and MIPS64
> -   opcode tables.  */
> -
> +/*
> + * Verify that the processor is running with COP1X instructions enabled.
> + * This is associated with the nabla symbol in the MIPS32 and MIPS64
> + * opcode tables.
> + */
>  static inline void check_cop1x(DisasContext *ctx)
>  {
>      if (unlikely(!(ctx->hflags & MIPS_HFLAG_COP1X))) {
> @@ -2934,9 +2937,10 @@ static inline void check_cop1x(DisasContext *ctx)
>      }
>  }
>  
> -/* Verify that the processor is running with 64-bit floating-point
> -   operations enabled.  */
> -
> +/*
> + * Verify that the processor is running with 64-bit floating-point
> + * operations enabled.
> + */
>  static inline void check_cp1_64bitmode(DisasContext *ctx)
>  {
>      if (unlikely(~ctx->hflags & (MIPS_HFLAG_F64 | MIPS_HFLAG_COP1X))) {
> @@ -2962,10 +2966,10 @@ static inline void check_cp1_registers(DisasContext *ctx, int regs)
>      }
>  }
>  
> -/* Verify that the processor is running with DSP instructions enabled.
> -   This is enabled by CP0 Status register MX(24) bit.
> +/*
> + * Verify that the processor is running with DSP instructions enabled.
> + * This is enabled by CP0 Status register MX(24) bit.
>   */
> -
>  static inline void check_dsp(DisasContext *ctx)
>  {
>      if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSP))) {
> @@ -2999,8 +3003,10 @@ static inline void check_dsp_r3(DisasContext *ctx)
>      }
>  }
>  
> -/* This code generates a "reserved instruction" exception if the
> -   CPU does not support the instruction set corresponding to flags. */
> +/*
> + * This code generates a "reserved instruction" exception if the
> + * CPU does not support the instruction set corresponding to flags.
> + */
>  static inline void check_insn(DisasContext *ctx, uint64_t flags)
>  {
>      if (unlikely(!(ctx->insn_flags & flags))) {
> @@ -3008,9 +3014,11 @@ static inline void check_insn(DisasContext *ctx, uint64_t flags)
>      }
>  }
>  
> -/* This code generates a "reserved instruction" exception if the
> -   CPU has corresponding flag set which indicates that the instruction
> -   has been removed. */
> +/*
> + * This code generates a "reserved instruction" exception if the
> + * CPU has corresponding flag set which indicates that the instruction
> + * has been removed.
> + */
>  static inline void check_insn_opc_removed(DisasContext *ctx, uint64_t flags)
>  {
>      if (unlikely(ctx->insn_flags & flags)) {
> @@ -3033,8 +3041,10 @@ static inline void check_insn_opc_user_only(DisasContext *ctx, uint64_t flags)
>  #endif
>  }
>  
> -/* This code generates a "reserved instruction" exception if the
> -   CPU does not support 64-bit paired-single (PS) floating point data type */
> +/*
> + * This code generates a "reserved instruction" exception if the
> + * CPU does not support 64-bit paired-single (PS) floating point data type.
> + */
>  static inline void check_ps(DisasContext *ctx)
>  {
>      if (unlikely(!ctx->ps)) {
> @@ -3044,8 +3054,10 @@ static inline void check_ps(DisasContext *ctx)
>  }
>  
>  #ifdef TARGET_MIPS64
> -/* This code generates a "reserved instruction" exception if 64-bit
> -   instructions are not enabled. */
> +/*
> + * This code generates a "reserved instruction" exception if 64-bit
> + * instructions are not enabled.
> + */
>  static inline void check_mips_64(DisasContext *ctx)
>  {
>      if (unlikely(!(ctx->hflags & MIPS_HFLAG_64))) {
> @@ -3157,10 +3169,12 @@ static inline void check_eva(DisasContext *ctx)
>  }
>  
>  
> -/* Define small wrappers for gen_load_fpr* so that we have a uniform
> -   calling interface for 32 and 64-bit FPRs.  No sense in changing
> -   all callers for gen_load_fpr32 when we need the CTX parameter for
> -   this one use.  */
> +/*
> + * Define small wrappers for gen_load_fpr* so that we have a uniform
> + * calling interface for 32 and 64-bit FPRs.  No sense in changing
> + * all callers for gen_load_fpr32 when we need the CTX parameter for
> + * this one use.
> + */
>  #define gen_ldcmp_fpr32(ctx, x, y) gen_load_fpr32(ctx, x, y)
>  #define gen_ldcmp_fpr64(ctx, x, y) gen_load_fpr64(ctx, x, y)
>  #define FOP_CONDS(type, abs, fmt, ifmt, bits)                                 \
> @@ -3405,9 +3419,11 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
>      int mem_idx = ctx->mem_idx;
>  
>      if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F)) {
> -        /* Loongson CPU uses a load to zero register for prefetch.
> -           We emulate it as a NOP. On other CPU we must perform the
> -           actual memory access. */
> +        /*
> +         * Loongson CPU uses a load to zero register for prefetch.
> +         * We emulate it as a NOP. On other CPU we must perform the
> +         * actual memory access.
> +         */
>          return;
>      }
>  
> @@ -3433,8 +3449,10 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
>          break;
>      case OPC_LDL:
>          t1 = tcg_temp_new();
> -        /* Do a byte access to possibly trigger a page
> -           fault with the unaligned address.  */
> +        /*
> +         * Do a byte access to possibly trigger a page
> +         * fault with the unaligned address.
> +         */
>          tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
>          tcg_gen_andi_tl(t1, t0, 7);
>  #ifndef TARGET_WORDS_BIGENDIAN
> @@ -3455,8 +3473,10 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
>          break;
>      case OPC_LDR:
>          t1 = tcg_temp_new();
> -        /* Do a byte access to possibly trigger a page
> -           fault with the unaligned address.  */
> +        /*
> +         * Do a byte access to possibly trigger a page
> +         * fault with the unaligned address.
> +         */
>          tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
>          tcg_gen_andi_tl(t1, t0, 7);
>  #ifdef TARGET_WORDS_BIGENDIAN
> @@ -3534,8 +3554,10 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
>          /* fall through */
>      case OPC_LWL:
>          t1 = tcg_temp_new();
> -        /* Do a byte access to possibly trigger a page
> -           fault with the unaligned address.  */
> +        /*
> +         * Do a byte access to possibly trigger a page
> +         * fault with the unaligned address.
> +         */
>          tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
>          tcg_gen_andi_tl(t1, t0, 3);
>  #ifndef TARGET_WORDS_BIGENDIAN
> @@ -3560,8 +3582,10 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
>          /* fall through */
>      case OPC_LWR:
>          t1 = tcg_temp_new();
> -        /* Do a byte access to possibly trigger a page
> -           fault with the unaligned address.  */
> +        /*
> +         * Do a byte access to possibly trigger a page
> +         * fault with the unaligned address.
> +         */
>          tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
>          tcg_gen_andi_tl(t1, t0, 3);
>  #ifdef TARGET_WORDS_BIGENDIAN
> @@ -3762,8 +3786,10 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
>  static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
>                           TCGv t0)
>  {
> -    /* Don't do NOP if destination is zero: we must perform the actual
> -       memory access. */
> +    /*
> +     * Don't do NOP if destination is zero: we must perform the actual
> +     * memory access.
> +     */
>      switch (opc) {
>      case OPC_LWC1:
>          {
> @@ -3837,8 +3863,10 @@ static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
>      target_ulong uimm = (target_long)imm; /* Sign extend to 32/64 bits */
>  
>      if (rt == 0 && opc != OPC_ADDI && opc != OPC_DADDI) {
> -        /* If no destination, treat it as a NOP.
> -           For addi, we must generate the overflow exception when needed. */
> +        /*
> +         * If no destination, treat it as a NOP.
> +         * For addi, we must generate the overflow exception when needed.
> +         */
>          return;
>      }
>      switch (opc) {
> @@ -4064,8 +4092,10 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
>  {
>      if (rd == 0 && opc != OPC_ADD && opc != OPC_SUB
>         && opc != OPC_DADD && opc != OPC_DSUB) {
> -        /* If no destination, treat it as a NOP.
> -           For add & sub, we must generate the overflow exception when needed. */
> +        /*
> +         * If no destination, treat it as a NOP.
> +         * For add & sub, we must generate the overflow exception when needed.
> +         */
>          return;
>      }
>  
> @@ -4123,7 +4153,10 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
>              tcg_temp_free(t2);
>              tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
>              tcg_temp_free(t1);
> -            /* operands of different sign, first operand and result different sign */
> +            /*
> +             * operands of different sign, first operand and the result
> +             * of different sign
> +             */
>              generate_exception(ctx, EXCP_OVERFLOW);
>              gen_set_label(l1);
>              gen_store_gpr(t0, rd);
> @@ -4346,8 +4379,10 @@ static void gen_shift(DisasContext *ctx, uint32_t opc,
>      TCGv t0, t1;
>  
>      if (rd == 0) {
> -        /* If no destination, treat it as a NOP.
> -           For add & sub, we must generate the overflow exception when needed. */
> +        /*
> +         * If no destination, treat it as a NOP.
> +         * For add & sub, we must generate the overflow exception when needed.
> +         */
>          return;
>      }
>  
> @@ -5643,8 +5678,10 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>              break;
>          case OPC_SRA_CP2:
>          case OPC_DSRA_CP2:
> -            /* Since SRA is UndefinedResult without sign-extended inputs,
> -               we can treat SRA and DSRA the same.  */
> +            /*
> +             * Since SRA is UndefinedResult without sign-extended inputs,
> +             * we can treat SRA and DSRA the same.
> +             */
>              tcg_gen_sar_i64(t0, t0, t1);
>              break;
>          case OPC_SRL_CP2:
> @@ -5720,8 +5757,10 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>      case OPC_SLT_CP2:
>      case OPC_SLEU_CP2:
>      case OPC_SLE_CP2:
> -        /* ??? Document is unclear: Set FCC[CC].  Does that mean the
> -           FD field is the CC field?  */
> +        /*
> +         * ??? Document is unclear: Set FCC[CC].  Does that mean the
> +         * FD field is the CC field?
> +         */
>      default:
>          MIPS_INVAL("loongson_cp2");
>          generate_exception_end(ctx, EXCP_RI);
> @@ -5972,8 +6011,10 @@ static void gen_compute_branch (DisasContext *ctx, uint32_t opc,
>              /* Treat as NOP. */
>              goto out;
>          case OPC_BLTZAL:  /* 0 < 0           */
> -            /* Handle as an unconditional branch to get correct delay
> -               slot checking.  */
> +            /*
> +             * Handle as an unconditional branch to get correct delay
> +             * slot checking.
> +             */
>              blink = 31;
>              btgt = ctx->base.pc_next + insn_bytes + delayslot_size;
>              ctx->hflags |= MIPS_HFLAG_B;
> @@ -6151,8 +6192,10 @@ static void gen_compute_branch_nm(DisasContext *ctx, uint32_t opc,
>      case OPC_JALR:
>          /* Jump to register */
>          if (offset != 0 && offset != 16) {
> -            /* Hint = 0 is JR/JALR, hint 16 is JR.HB/JALR.HB, the
> -               others are reserved. */
> +            /*
> +             * Hint = 0 is JR/JALR, hint 16 is JR.HB/JALR.HB, the
> +             * others are reserved.
> +             */
>              MIPS_INVAL("jump hint");
>              generate_exception_end(ctx, EXCP_RI);
>              goto out;
> @@ -6249,8 +6292,10 @@ static void gen_bitops(DisasContext *ctx, uint32_t opc, int rt,
>          if (msb != 31) {
>              tcg_gen_extract_tl(t0, t1, lsb, msb + 1);
>          } else {
> -            /* The two checks together imply that lsb == 0,
> -               so this is a simple sign-extension.  */
> +            /*
> +             * The two checks together imply that lsb == 0,
> +             * so this is a simple sign-extension.
> +             */
>              tcg_gen_ext32s_tl(t0, t1);
>          }
>          break;
> @@ -6701,10 +6746,12 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>      case CP0_REGISTER_17:
>          switch (sel) {
>          case 0:
> -            /* LLAddr is read-only (the only exception is bit 0 if LLB is
> -               supported); the CP0_LLAddr_rw_bitmask does not seem to be
> -               relevant for modern MIPS cores supporting MTHC0, therefore
> -               treating MTHC0 to LLAddr as NOP. */
> +            /*
> +             * LLAddr is read-only (the only exception is bit 0 if LLB is
> +             * supported); the CP0_LLAddr_rw_bitmask does not seem to be
> +             * relevant for modern MIPS cores supporting MTHC0, therefore
> +             * treating MTHC0 to LLAddr as NOP.
> +             */
>              register_name = "LLAddr";
>              break;
>          case 1:
> @@ -6928,7 +6975,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              register_name = "Context";
>              break;
>          case 1:
> -//            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
> +            /* gen_helper_mfc0_contextconfig(arg); - SmartMIPS ASE */
>              register_name = "ContextConfig";
>              goto cp0_unimplemented;
>          case 2:
> @@ -12389,8 +12436,10 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
>      } else {
>          gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[index]);
>      }
> -    /* Don't do NOP if destination is zero: we must perform the actual
> -       memory access. */
> +    /*
> +     * Don't do NOP if destination is zero: we must perform the actual
> +     * memory access.
> +     */
>      switch (opc) {
>      case OPC_LWXC1:
>          check_cop1x(ctx);
> @@ -12718,8 +12767,10 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
>      TCGv t0;
>  
>  #if !defined(CONFIG_USER_ONLY)
> -    /* The Linux kernel will emulate rdhwr if it's not supported natively.
> -       Therefore only check the ISA in system mode.  */
> +    /*
> +     * The Linux kernel will emulate rdhwr if it's not supported natively.
> +     * Therefore only check the ISA in system mode.
> +     */
>      check_insn(ctx, ISA_MIPS32R2);
>  #endif
>      t0 = tcg_temp_new();
> @@ -12742,9 +12793,11 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
>              gen_io_end();
>          }
>          gen_store_gpr(t0, rt);
> -        /* Break the TB to be able to take timer interrupts immediately
> -           after reading count. DISAS_STOP isn't sufficient, we need to ensure
> -           we break completely out of translated code.  */
> +        /*
> +         * Break the TB to be able to take timer interrupts immediately
> +         * after reading count. DISAS_STOP isn't sufficient, we need to ensure
> +         * we break completely out of translated code.
> +         */
>          gen_save_pc(ctx->base.pc_next + 4);
>          ctx->base.is_jmp = DISAS_EXIT;
>          break;
> @@ -12755,7 +12808,8 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
>      case 4:
>          check_insn(ctx, ISA_MIPS32R6);
>          if (sel != 0) {
> -            /* Performance counter registers are not implemented other than
> +            /*
> +             * Performance counter registers are not implemented other than
>               * control register 0.
>               */
>              generate_exception(ctx, EXCP_RI);
> @@ -12799,8 +12853,10 @@ static inline void clear_branch_hflags(DisasContext *ctx)
>      if (ctx->base.is_jmp == DISAS_NEXT) {
>          save_cpu_state(ctx, 0);
>      } else {
> -        /* it is not safe to save ctx->hflags as hflags may be changed
> -           in execution time by the instruction in delay / forbidden slot. */
> +        /*
> +         * It is not safe to save ctx->hflags as hflags may be changed
> +         * in execution time by the instruction in delay / forbidden slot.
> +         */
>          tcg_gen_andi_i32(hflags, hflags, ~MIPS_HFLAG_BMASK);
>      }
>  }
> @@ -13599,8 +13655,10 @@ static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
>                                | ((ctx->opcode >> 21) & 0x3f) << 5
>                                | (ctx->opcode & 0x1f));
>  
> -    /* The extended opcodes cleverly reuse the opcodes from their 16-bit
> -       counterparts.  */
> +    /*
> +     * The extended opcodes cleverly reuse the opcodes from their 16-bit
> +     * counterparts.
> +     */
>      switch (op) {
>      case M16_OPC_ADDIUSP:
>          gen_arith_imm(ctx, OPC_ADDIU, rx, 29, imm);
> @@ -15056,8 +15114,10 @@ static void gen_pool16c_insn(DisasContext *ctx)
>          {
>              int reg = ctx->opcode & 0x1f;
>              gen_compute_branch(ctx, OPC_JR, 2, reg, 0, 0, 0);
> -            /* Let normal delay slot handling in our caller take us
> -               to the branch target.  */
> +            /*
> +             * Let normal delay slot handling in our caller take us
> +             * to the branch target.
> +             */
>          }
>          break;
>      case JALR16 + 0:
> @@ -15085,7 +15145,8 @@ static void gen_pool16c_insn(DisasContext *ctx)
>          if (is_uhi(extract32(ctx->opcode, 0, 4))) {
>              gen_helper_do_semihosting(cpu_env);
>          } else {
> -            /* XXX: not clear which exception should be raised
> +            /*
> +             * XXX: not clear which exception should be raised
>               *      when in debug mode...
>               */
>              check_insn(ctx, ISA_MIPS32);
> @@ -15098,8 +15159,10 @@ static void gen_pool16c_insn(DisasContext *ctx)
>              int imm = ZIMM(ctx->opcode, 0, 5);
>              gen_compute_branch(ctx, OPC_JR, 2, 31, 0, 0, 0);
>              gen_arith_imm(ctx, OPC_ADDIU, 29, 29, imm << 2);
> -            /* Let normal delay slot handling in our caller take us
> -               to the branch target.  */
> +            /*
> +             * Let normal delay slot handling in our caller take us
> +             * to the branch target.
> +             */
>          }
>          break;
>      default:
> @@ -17358,7 +17421,8 @@ static int decode_micromips_opc(CPUMIPSState *env, DisasContext *ctx)
>                  break;
>              }
>              if (ctx->insn_flags & ISA_MIPS32R6) {
> -                /* In the Release 6 the register number location in
> +                /*
> +                 * In the Release 6, the register number location in
>                   * the instruction encoding has changed.
>                   */
>                  gen_arith(ctx, opc, rs1, rd, rs2);
> @@ -21083,9 +21147,11 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>                  gen_p_lsx(ctx, rd, rs, rt);
>                  break;
>              case NM_LSA:
> -                /* In nanoMIPS, the shift field directly encodes the shift
> +                /*
> +                 * In nanoMIPS, the shift field directly encodes the shift
>                   * amount, meaning that the supported shift values are in
> -                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6). */
> +                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6).
> +                 */
>                  gen_lsa(ctx, OPC_LSA, rd, rs, rt,
>                          extract32(ctx->opcode, 9, 2) - 1);
>                  break;
> @@ -21440,8 +21506,10 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>              case NM_P_PREFU12:
>                  if (rt == 31) {
>                      /* SYNCI */
> -                    /* Break the TB to be able to sync copied instructions
> -                       immediately */
> +                    /*
> +                     * Break the TB to be able to sync copied instructions
> +                     * immediately.
> +                     */
>                      ctx->base.is_jmp = DISAS_STOP;
>                  } else {
>                      /* PREF */
> @@ -21537,8 +21605,10 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>                  case NM_P_PREFS9:
>                      if (rt == 31) {
>                          /* SYNCI */
> -                        /* Break the TB to be able to sync copied instructions
> -                           immediately */
> +                        /*
> +                         * Break the TB to be able to sync copied instructions
> +                         * immediately.
> +                         */
>                          ctx->base.is_jmp = DISAS_STOP;
>                      } else {
>                          /* PREF */
> @@ -21630,8 +21700,10 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>                          /* case NM_SYNCIE */
>                          check_eva(ctx);
>                          check_cp0_enabled(ctx);
> -                        /* Break the TB to be able to sync copied instructions
> -                           immediately */
> +                        /*
> +                         * Break the TB to be able to sync copied instructions
> +                         * immediately.
> +                         */
>                          ctx->base.is_jmp = DISAS_STOP;
>                      } else {
>                          /* case NM_PREFE */
> @@ -23026,8 +23098,10 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
>      gen_load_gpr(v2_t, v2);
>  
>      switch (op1) {
> -    /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
> -     * the same mask and op1. */
> +    /*
> +     * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
> +     * the same mask and op1.
> +     */
>      case OPC_MULT_G_2E:
>          check_dsp_r2(ctx);
>          switch (op2) {
> @@ -23996,8 +24070,10 @@ static void decode_opc_special_r6(CPUMIPSState *env, DisasContext *ctx)
>      case R6_OPC_CLO:
>      case R6_OPC_CLZ:
>          if (rt == 0 && sa == 1) {
> -            /* Major opcode and function field is shared with preR6 MFHI/MTHI.
> -               We need additionally to check other fields */
> +            /*
> +             * Major opcode and function field is shared with preR6 MFHI/MTHI.
> +             * We need additionally to check other fields.
> +             */
>              gen_cl(ctx, op1, rd, rs);
>          } else {
>              generate_exception_end(ctx, EXCP_RI);
> @@ -24022,8 +24098,10 @@ static void decode_opc_special_r6(CPUMIPSState *env, DisasContext *ctx)
>      case R6_OPC_DCLO:
>      case R6_OPC_DCLZ:
>          if (rt == 0 && sa == 1) {
> -            /* Major opcode and function field is shared with preR6 MFHI/MTHI.
> -               We need additionally to check other fields */
> +            /*
> +             * Major opcode and function field is shared with preR6 MFHI/MTHI.
> +             * We need additionally to check other fields.
> +             */
>              check_mips_64(ctx);
>              gen_cl(ctx, op1, rd, rs);
>          } else {
> @@ -25939,7 +26017,7 @@ static void decode_opc_mxu__pool07(CPUMIPSState *env, DisasContext *ctx)
>   *  |  SPECIAL2 |    rb   |x|        s12        |  XRa  |MXU__POOL08|
>   *  +-----------+---------+-+-------------------+-------+-----------+
>   *
> -*/
> + */
>  static void decode_opc_mxu__pool08(CPUMIPSState *env, DisasContext *ctx)
>  {
>      uint32_t opcode = extract32(ctx->opcode, 20, 1);
> @@ -26835,7 +26913,8 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
>          if (is_uhi(extract32(ctx->opcode, 6, 20))) {
>              gen_helper_do_semihosting(cpu_env);
>          } else {
> -            /* XXX: not clear which exception should be raised
> +            /*
> +             * XXX: not clear which exception should be raised
>               *      when in debug mode...
>               */
>              check_insn(ctx, ISA_MIPS32);
> @@ -26977,8 +27056,10 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
>      case OPC_MODU_G_2E:
>      case OPC_MULT_G_2E:
>      case OPC_MULTU_G_2E:
> -        /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
> -         * the same mask and op1. */
> +        /*
> +         * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
> +         * the same mask and op1.
> +         */
>          if ((ctx->insn_flags & ASE_DSP_R2) && (op1 == OPC_MULT_G_2E)) {
>              op2 = MASK_ADDUH_QB(ctx->opcode);
>              switch (op2) {
> @@ -29165,8 +29246,10 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
>              break;
>          case OPC_SYNCI:
>              check_insn(ctx, ISA_MIPS32R2);
> -            /* Break the TB to be able to sync copied instructions
> -               immediately */
> +            /*
> +             * Break the TB to be able to sync copied instructions
> +             * immediately.
> +             */
>              ctx->base.is_jmp = DISAS_STOP;
>              break;
>          case OPC_BPOSGE32:    /* MIPS DSP branch */
> @@ -29283,8 +29366,10 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
>                      save_cpu_state(ctx, 1);
>                      gen_helper_di(t0, cpu_env);
>                      gen_store_gpr(t0, rt);
> -                    /* Stop translation as we may have switched
> -                       the execution mode.  */
> +                    /*
> +                     * Stop translation as we may have switched
> +                     * the execution mode.
> +                     */
>                      ctx->base.is_jmp = DISAS_STOP;
>                      break;
>                  case OPC_EI:
> @@ -29292,8 +29377,10 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
>                      save_cpu_state(ctx, 1);
>                      gen_helper_ei(t0, cpu_env);
>                      gen_store_gpr(t0, rt);
> -                    /* DISAS_STOP isn't sufficient, we need to ensure we break
> -                       out of translated code to check for pending interrupts */
> +                    /*
> +                     * DISAS_STOP isn't sufficient, we need to ensure we break
> +                     * out of translated code to check for pending interrupts.
> +                     */
>                      gen_save_pc(ctx->base.pc_next + 4);
>                      ctx->base.is_jmp = DISAS_EXIT;
>                      break;
> @@ -29876,10 +29963,12 @@ static bool mips_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
>      save_cpu_state(ctx, 1);
>      ctx->base.is_jmp = DISAS_NORETURN;
>      gen_helper_raise_exception_debug(cpu_env);
> -    /* The address covered by the breakpoint must be included in
> -       [tb->pc, tb->pc + tb->size) in order to for it to be
> -       properly cleared -- thus we increment the PC here so that
> -       the logic setting tb->size below does the right thing.  */
> +    /*
> +     * The address covered by the breakpoint must be included in
> +     * [tb->pc, tb->pc + tb->size) in order to for it to be
> +     * properly cleared -- thus we increment the PC here so that
> +     * the logic setting tb->size below does the right thing.
> +     */
>      ctx->base.pc_next += 4;
>      return true;
>  }
> @@ -29914,14 +30003,18 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>      if (ctx->hflags & MIPS_HFLAG_BMASK) {
>          if (!(ctx->hflags & (MIPS_HFLAG_BDS16 | MIPS_HFLAG_BDS32 |
>                               MIPS_HFLAG_FBNSLOT))) {
> -            /* force to generate branch as there is neither delay nor
> -               forbidden slot */
> +            /*
> +             * Force to generate branch as there is neither delay nor
> +             * forbidden slot.
> +             */
>              is_slot = 1;
>          }
>          if ((ctx->hflags & MIPS_HFLAG_M16) &&
>              (ctx->hflags & MIPS_HFLAG_FBNSLOT)) {
> -            /* Force to generate branch as microMIPS R6 doesn't restrict
> -               branches in the forbidden slot. */
> +            /*
> +             * Force to generate branch as microMIPS R6 doesn't restrict
> +             * branches in the forbidden slot.
> +             */
>              is_slot = 1;
>          }
>      }
> @@ -29933,10 +30026,12 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>      if (ctx->base.is_jmp != DISAS_NEXT) {
>          return;
>      }
> -    /* Execute a branch and its delay slot as a single instruction.
> -       This is what GDB expects and is consistent with what the
> -       hardware does (e.g. if a delay slot instruction faults, the
> -       reported PC is the PC of the branch).  */
> +    /*
> +     * Execute a branch and its delay slot as a single instruction.
> +     * This is what GDB expects and is consistent with what the
> +     * hardware does (e.g. if a delay slot instruction faults, the
> +     * reported PC is the PC of the branch).
> +     */
>      if (ctx->base.singlestep_enabled &&
>          (ctx->hflags & MIPS_HFLAG_BMASK) == 0) {
>          ctx->base.is_jmp = DISAS_TOO_MANY;
> @@ -30088,8 +30183,10 @@ void mips_tcg_init(void)
>          int off = offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[0]);
>          msa_wr_d[i * 2] =
>                  tcg_global_mem_new_i64(cpu_env, off, msaregnames[i * 2]);
> -        /* The scalar floating-point unit (FPU) registers are mapped on
> -         * the MSA vector registers. */
> +        /*
> +         * The scalar floating-point unit (FPU) registers are mapped on
> +         * the MSA vector registers.
> +         */
>          fpu_f64[i] = msa_wr_d[i * 2];
>          off = offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[1]);
>          msa_wr_d[i * 2 + 1] =
> @@ -30247,8 +30344,10 @@ void cpu_state_reset(CPUMIPSState *env)
>      /* Enable 64-bit address mode.  */
>      env->CP0_Status |= (1 << CP0St_UX);
>  # endif
> -    /* Enable access to the CPUNum, SYNCI_Step, CC, and CCRes RDHWR
> -       hardware registers.  */
> +    /*
> +     * Enable access to the CPUNum, SYNCI_Step, CC, and CCRes RDHWR
> +     * hardware registers.
> +     */
>      env->CP0_HWREna |= 0x0000000F;
>      if (env->CP0_Config1 & (1 << CP0C1_FP)) {
>          env->CP0_Status |= (1 << CP0St_CU1);
> @@ -30265,8 +30364,10 @@ void cpu_state_reset(CPUMIPSState *env)
>  # endif
>  #else
>      if (env->hflags & MIPS_HFLAG_BMASK) {
> -        /* If the exception was raised from a delay slot,
> -           come back to the jump.  */
> +        /*
> +         * If the exception was raised from a delay slot,
> +         * come back to the jump.
> +         */
>          env->CP0_ErrorEPC = (env->active_tc.PC
>                               - (env->hflags & MIPS_HFLAG_B16 ? 2 : 4));
>      } else {
> @@ -30289,8 +30390,10 @@ void cpu_state_reset(CPUMIPSState *env)
>      env->CP0_EntryHi_ASID_mask = (env->CP0_Config4 & (1 << CP0C4_AE)) ?
>                                   0x3ff : 0xff;
>      env->CP0_Status = (1 << CP0St_BEV) | (1 << CP0St_ERL);
> -    /* vectored interrupts not implemented, timer on int 7,
> -       no performance counters. */
> +    /*
> +     * Vectored interrupts not implemented, timer on int 7,
> +     * no performance counters.
> +     */
>      env->CP0_IntCtl = 0xe0000000;
>      {
>          int i;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

