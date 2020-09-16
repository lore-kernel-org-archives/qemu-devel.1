Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07641C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A282080C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtlIVfRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A282080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISA2-00037e-B2
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIS9M-0002gq-6A
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:46:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIS9J-0000fd-Nt
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:46:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so5798061wrx.7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 00:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZRyO5o/Rlo5AyHO47oul5gYfRXaoJy284ukI23Y/IKY=;
 b=QtlIVfRCzXk+++8V5b6kLP8i/mR9MVMF2rozxfFtXinfTMY7b2C1jTEozGnpTOwJ3z
 3MMJaPCBa+OMrQ04Q4zsnY+twXIzdYGTf9JC4gOfx3c15kAEM3dzfA5FWZbRLv079uGL
 dKnAAZcCZaJmFbEh4jZmYz0E/EbpHdumVYbg4c2hv3XKpCkPDMTokDUtVRZNAXaZBcaP
 lCLzJnHNLOvPRcu1RY2Aq34lR0XEfK1GTrJaWAF5JA+0CW5bA6l5RgHDvkQIXtXRD6j1
 BN+S7JO46EfpJjoSYAg/2awWkSw9ufqonKiz43mNsR5AYjLF1nl6YDm7xiS0MCGJCRiF
 59+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZRyO5o/Rlo5AyHO47oul5gYfRXaoJy284ukI23Y/IKY=;
 b=IJNky52j1klsyAsJ7W+mQyNrXL36kHtAoDX+R3fHsNGCj1WsZIHXVTCDWR2kisxhwt
 Nj4+nWirOJJ3RvNPSXHG9mvL1mf+aeBfaKrELTIspUFuwCDc1HBSeLBU9hPapxLZRqI7
 urTgv1d1rQ39pbnorJppgWW3XzaHam6PoYuk9rvaJBsIwA7i84jSQaezkIecaHihQChq
 z0IPElBu9OprZ1p1geKmkSliGTX+whsrU95wUG/ID9zTgP2NnvZC/3jI6xpV9a/KF+MT
 KsWo25a376oCi9E3PebZYOAwPwt/Fb9ea5K074CiN8wyAMGD1A8vAEaGak+5u/K6GeOp
 Ue9g==
X-Gm-Message-State: AOAM531Tr1yDeHIx8sB6DeR04ZjOw5cA7wPzhVsPbXypaGc917tnvGeC
 xLLzDCkREy1OPqHS23UkO/0=
X-Google-Smtp-Source: ABdhPJyQd53er9d49d1Ybl07rnnVQIYDEL7FKgWt40KPICVLqk2Yy5TWW8Ah7VZgc0ehxkyYJOpXIQ==
X-Received: by 2002:adf:e481:: with SMTP id i1mr25113584wrm.391.1600242399819; 
 Wed, 16 Sep 2020 00:46:39 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t188sm3966800wmf.41.2020.09.16.00.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 00:46:39 -0700 (PDT)
Subject: Re: [PATCH V9 3/6] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 1)
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-4-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c5f55594-5057-108c-2aa3-7da3ec20a5df@amsat.org>
Date: Wed, 16 Sep 2020 09:46:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600222344-16808-4-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 4:12 AM, Huacai Chen wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> LWC2 & SWC2 have been rewritten by Loongson EXT vendor ASE
> as "load/store quad word" and "shifted load/store" groups of
> instructions.
> 
> This patch add implementation of these instructions:
> gslq: load 16 bytes to GPR
> gssq: store 16 bytes from GPR
> gslqc1: load 16 bytes to FPR
> gssqc1: store 16 bytes from FPR
> 
> Details of Loongson-EXT is here:
> https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  target/mips/translate.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 398edf7..08d51e1 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -460,6 +460,17 @@ enum {
>      R6_OPC_SCD         = 0x27 | OPC_SPECIAL3,
>  };
>  
> +/* Loongson EXT load/store quad word opcodes */
> +#define MASK_LOONGSON_GSLSQ(op)           (MASK_OP_MAJOR(op) | (op & 0x8020))
> +enum {
> +    OPC_GSLQ        = 0x0020 | OPC_LWC2,
> +    OPC_GSLQC1      = 0x8020 | OPC_LWC2,
> +    OPC_GSSHFL      = OPC_LWC2,
> +    OPC_GSSQ        = 0x0020 | OPC_SWC2,
> +    OPC_GSSQC1      = 0x8020 | OPC_SWC2,
> +    OPC_GSSHFS      = OPC_SWC2,
> +};
> +
>  /* BSHFL opcodes */
>  #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
>  
> @@ -5910,6 +5921,74 @@ no_rd:
>      tcg_temp_free_i64(t1);
>  }
>  
> +static void gen_loongson_lswc2(DisasContext *ctx, int rt,
> +                                int rs, int rd)
> +{
> +    TCGv t0, t1, t2;
> +    TCGv_i32 fp0;
> +    int lsq_offset = ((int)((ctx->opcode >> 6) & 0x1ff) << 23) >> 19;
> +    int lsq_rt1 = ctx->opcode & 0x1f;
> +    int shf_offset = (int8_t)(ctx->opcode >> 6);
> +
> +    t0 = tcg_temp_new();
> +
> +    switch (MASK_LOONGSON_GSLSQ(ctx->opcode)) {
> +#if defined(TARGET_MIPS64)

Build failure (is this code tested?):

target/mips/translate.c: In function ‘gen_loongson_lswc2’:
target/mips/translate.c:5961:9: error: unused variable ‘lsq_rt1’
[-Werror=unused-variable]
     int lsq_rt1 = ctx->opcode & 0x1f;
         ^
target/mips/translate.c:5960:9: error: unused variable ‘lsq_offset’
[-Werror=unused-variable]
     int lsq_offset = ((int)((ctx->opcode >> 6) & 0x1ff) << 23) >> 19;
         ^
cc1: all warnings being treated as errors

> +    case OPC_GSLQ:
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, rt);
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, lsq_rt1);
> +        break;
> +    case OPC_GSLQC1:
> +        check_cp1_enabled(ctx);
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_fpr64(ctx, t0, rt);
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_fpr64(ctx, t0, lsq_rt1);
> +        break;
> +    case OPC_GSSQ:
> +        t1 = tcg_temp_new();
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> +        gen_load_gpr(t1, lsq_rt1);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +    case OPC_GSSQC1:
> +        check_cp1_enabled(ctx);
> +        t1 = tcg_temp_new();
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> +        gen_load_fpr64(ctx, t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> +        gen_load_fpr64(ctx, t1, lsq_rt1);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +#endif
> +    default:
> +        MIPS_INVAL("loongson_gslsq");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    }
> +    tcg_temp_free(t0);
> +}
> +
>  /* Traps */
>  static void gen_trap(DisasContext *ctx, uint32_t opc,
>                       int rs, int rt, int16_t imm)
> @@ -30774,6 +30853,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
>              /* OPC_BC, OPC_BALC */
>              gen_compute_compact_branch(ctx, op, 0, 0,
>                                         sextract32(ctx->opcode << 2, 0, 28));
> +        } else if (ctx->insn_flags & ASE_LEXT) {
> +            gen_loongson_lswc2(ctx, rt, rs, rd);
>          } else {
>              /* OPC_LWC2, OPC_SWC2 */
>              /* COP2: Not implemented. */
> 

