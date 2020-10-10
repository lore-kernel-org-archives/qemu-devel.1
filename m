Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB6FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E62221E9
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCg+uiGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E62221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kREcI-0002zd-1C
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kREbM-0002ZH-8b
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 09:07:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kREbK-00077c-3D
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 09:07:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id i1so6955963wro.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ojw3jnrel0MTzqZ0CI+5WgbdJGKvh/ZGWOOOnA36nQ4=;
 b=BCg+uiGNok7Dq/D6N5Helw1qFN8cKEjQya7nDDVzroZbgeg/mfLIVeTG86k1Nkp76k
 XR6YAjmIo6OWFcwjUu/XSu+zW0xpuPOwfR62WYVOtpvtKGWmAEUbb7YUJsdNJDytZRyA
 Ku/CsSaPnS3VYaN8EfHlrJ0PWgqmj6fevA3evBUo1xdzpdjUh27FDavcJ2UTa7tFwbzw
 lXY2c5CaPbnbqgi3m5/1191WFoF2WXJX9bz0SVXGOnF8yni6RV1oxQK4jT/wxC2aRScg
 oXRC7a/G9HRiqiLJrV8hPEB7omYCcdsYYm8dtfmPrFC7zhVkkdQHY7FnxSvJQo/sRPn8
 D9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ojw3jnrel0MTzqZ0CI+5WgbdJGKvh/ZGWOOOnA36nQ4=;
 b=sylIHNznL6j/RBOeBURleVvIo3XooVMBQznm9IKH/SxdTA7s0THNEFYPeRfGDgU8h5
 dR0W8Ccob3jnzzilkN8XxpIrc0dxQgLi/Yan5eraUqHNPXc6qpk2pH+l2I37tvClFs2Q
 nRD9/wIKViVrydsEwckUM2OUbNQAVze8/+MhxTzP7D+3qsyDVI3pw9c2OosKwfrIPDU1
 nskt/DooCAzdAfadDZzziSEBFnjLht7/skLdN6AigB3AuwdiwNBWY178N9lyEIEaUux+
 uZ96nWIT2D1yFtqFs7iWQMSZTsa6trUA2IVGoE/yXyInZGN4Q4GZ+nI1QjH8J+oAPc6S
 eEcg==
X-Gm-Message-State: AOAM533S1nLZydqndz9aAuEsTd4muliOqzLt5R/2MyeXUVpa96WNUax+
 jKymq8r09ULoDdmcAEQ1oPk=
X-Google-Smtp-Source: ABdhPJzJ8OPQI3AHW33xm7zsEhS6g0OKhP1BzfT/zjVfUsakeKTDBO8OiN52t4zoH+TFV1Gw6wEdAQ==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr19974154wrv.222.1602335272443; 
 Sat, 10 Oct 2020 06:07:52 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t4sm11836460wra.75.2020.10.10.06.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 06:07:51 -0700 (PDT)
Subject: Re: [PATCH V13 6/9] target/mips: Add loongson-ext lsdc2 group of
 instructions
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-7-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae0f1019-91a5-f31e-4337-3be1d021a50e@amsat.org>
Date: Sat, 10 Oct 2020 15:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602059975-10115-7-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.207,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 10:39 AM, Huacai Chen wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> LDC2/SDC2 opcodes have been rewritten as "load & store with offset"
> group of instructions by loongson-ext ASE.
> 
> This patch add implementation of these instructions:
> gslbx: load 1 bytes to GPR
> gslhx: load 2 bytes to GPR
> gslwx: load 4 bytes to GPR
> gsldx: load 8 bytes to GPR
> gslwxc1: load 4 bytes to FPR
> gsldxc1: load 8 bytes to FPR
> gssbx: store 1 bytes from GPR
> gsshx: store 2 bytes from GPR
> gsswx: store 4 bytes from GPR
> gssdx: store 8 bytes from GPR
> gsswxc1: store 4 bytes from FPR
> gssdxc1: store 8 bytes from FPR
> 
> Details of Loongson-EXT is here:
> https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

If this patch is from Jiaxun, Huacai's S-o-b should come *after*.

> ---
>   target/mips/translate.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 179 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 916b57f..4d42cfc 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -484,6 +484,24 @@ enum {
>       OPC_GSSDRC1     = 0x7 | OPC_GSSHFS,
>   };
>   
> +/* Loongson EXT LDC2/SDC2 opcodes */
> +#define MASK_LOONGSON_LSDC2(op)           (MASK_OP_MAJOR(op) | (op & 0x7))
> +
> +enum {
> +    OPC_GSLBX      = 0x0 | OPC_LDC2,
> +    OPC_GSLHX      = 0x1 | OPC_LDC2,
> +    OPC_GSLWX      = 0x2 | OPC_LDC2,
> +    OPC_GSLDX      = 0x3 | OPC_LDC2,
> +    OPC_GSLWXC1    = 0x6 | OPC_LDC2,
> +    OPC_GSLDXC1    = 0x7 | OPC_LDC2,
> +    OPC_GSSBX      = 0x0 | OPC_SDC2,
> +    OPC_GSSHX      = 0x1 | OPC_SDC2,
> +    OPC_GSSWX      = 0x2 | OPC_SDC2,
> +    OPC_GSSDX      = 0x3 | OPC_SDC2,
> +    OPC_GSSWXC1    = 0x6 | OPC_SDC2,
> +    OPC_GSSDXC1    = 0x7 | OPC_SDC2,
> +};
> +
>   /* BSHFL opcodes */
>   #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
>   
> @@ -6172,6 +6190,165 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
>       tcg_temp_free(t0);
>   }
>   
> +/* Loongson EXT LDC2/SDC2 */
> +static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
> +                                int rs, int rd)

Alignment off (various occurences in this series).

> +{
> +    int offset = (int8_t)(ctx->opcode >> 3);

Please use sextract32() which is easier to read:

        int32_t offset = sextract32(ctx->opcode, 3, 8);

> +    uint32_t opc = MASK_LOONGSON_LSDC2(ctx->opcode);
> +    TCGv t0, t1;
> +    TCGv_i32 fp0;
> +
> +    /* Pre-conditions */
> +    switch (opc) {
> +    case OPC_GSLBX:
> +    case OPC_GSLHX:
> +    case OPC_GSLWX:
> +    case OPC_GSLDX:
> +        /* prefetch, implement as NOP */
> +        if (rt == 0) {
> +            return;
> +        }
> +        break;
> +    case OPC_GSSBX:
> +    case OPC_GSSHX:
> +    case OPC_GSSWX:
> +    case OPC_GSSDX:
> +        break;
> +    case OPC_GSLWXC1:
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSLDXC1:
> +#endif
> +        check_cp1_enabled(ctx);
> +        /* prefetch, implement as NOP */
> +        if (rt == 0) {
> +            return;
> +        }
> +        break;
> +    case OPC_GSSWXC1:
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSSDXC1:
> +#endif
> +        check_cp1_enabled(ctx);
> +        break;
> +    default:
> +        MIPS_INVAL("loongson_lsdc2");
> +        generate_exception_end(ctx, EXCP_RI);
> +        return;
> +        break;
> +    }
> +
> +    t0 = tcg_temp_new();
> +
> +    gen_base_offset_addr(ctx, t0, rs, offset);
> +    gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +
> +    switch (opc) {
> +    case OPC_GSLBX:
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
> +        gen_store_gpr(t0, rt);
> +        break;
> +    case OPC_GSLHX:
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
> +                            ctx->default_tcg_memop_mask);

Do Loongson EXT plan to support unaligned accesses?

> +        gen_store_gpr(t0, rt);
> +        break;
> +    case OPC_GSLWX:
> +        gen_base_offset_addr(ctx, t0, rs, offset);
> +        if (rd) {
> +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +        }
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, rt);
> +        break;
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSLDX:
> +        gen_base_offset_addr(ctx, t0, rs, offset);
> +        if (rd) {
> +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +        }
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, rt);
> +        break;
> +#endif
> +    case OPC_GSLWXC1:
> +        check_cp1_enabled(ctx);
> +        gen_base_offset_addr(ctx, t0, rs, offset);
> +        if (rd) {
> +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +        }
> +        fp0 = tcg_temp_new_i32();
> +        tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TESL |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_fpr32(ctx, fp0, rt);
> +        tcg_temp_free_i32(fp0);
> +        break;
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSLDXC1:
> +        check_cp1_enabled(ctx);
> +        gen_base_offset_addr(ctx, t0, rs, offset);
> +        if (rd) {
> +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +        }
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_fpr64(ctx, t0, rt);
> +        break;
> +#endif
> +    case OPC_GSSBX:
> +        t1 = tcg_temp_new();
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_SB);
> +        tcg_temp_free(t1);
> +        break;
> +    case OPC_GSSHX:
> +        t1 = tcg_temp_new();
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +    case OPC_GSSWX:
> +        t1 = tcg_temp_new();
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSSDX:
> +        t1 = tcg_temp_new();
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +#endif
> +    case OPC_GSSWXC1:
> +        fp0 = tcg_temp_new_i32();
> +        gen_load_fpr32(ctx, fp0, rt);
> +        tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TEUL |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free_i32(fp0);
> +        break;
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSSDXC1:
> +        t1 = tcg_temp_new();
> +        gen_load_fpr64(ctx, t1, rt);
> +        tcg_gen_qemu_st_i64(t1, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +#endif
> +    default:
> +        break;
> +    }
> +
> +    tcg_temp_free(t0);
> +}
> +
>   /* Traps */
>   static void gen_trap(DisasContext *ctx, uint32_t opc,
>                        int rs, int rt, int16_t imm)
> @@ -31055,6 +31232,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
>                   /* OPC_JIC, OPC_JIALC */
>                   gen_compute_compact_branch(ctx, op, 0, rt, imm);
>               }
> +        } else if (ctx->insn_flags & ASE_LEXT) {
> +            gen_loongson_lsdc2(ctx, rt, rs, rd);
>           } else {
>               /* OPC_LWC2, OPC_SWC2 */
>               /* COP2: Not implemented. */
> 

