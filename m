Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F434C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 03:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15B921734
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 03:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA7v/x46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15B921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRRf0-0008NS-SZ
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 23:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kRRdV-0007rP-Sa
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 23:03:01 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kRRdT-0000fM-Ho
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 23:03:01 -0400
Received: by mail-io1-xd41.google.com with SMTP id u19so14291539ion.3
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 20:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+KfkYemlFW8sth8ugVGEdoGIIdC8KiMxyYro8S0c9Dw=;
 b=YA7v/x46sKhYL2rM9syC2Mb4XNstN0bQC55XGWFueCgrgck2ebNhINcB8iBnxh1Jmx
 L/mte+mPaCgeZ7UKwUSu6UjwvgCfK0ERn9pghoUTYYXWD0utVVxDFgsy9StMLLtSJMHH
 V9BsR398ph241RufG4dZF6GLCrT97G4Ock/vtE1N959TzXUt1fnbF6aVsK0ziOCjIJYa
 dMFvM7aEo2bxHIbqxNdO5mP1BR9CzWQeDa0QQf27GXIsMZQISzCpUtk1m0o+FqG87vP4
 F15Fsh6nytLj2ZMhGJV+xsLiYS8cfrkyVwd8lqXwMPAwJkrh8sq6frEAyPuQfJ3OrPfy
 m4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+KfkYemlFW8sth8ugVGEdoGIIdC8KiMxyYro8S0c9Dw=;
 b=pq3nDTzIe8Yz1peyV1eOxExyNr+DuXLT8pNNredl2f4CGHiHa8sKP+v3v7ZBE8dWEk
 xKGIZ3Ix+BCbr0Mb8u0TLraaI19vfvYghNY9yLSWtiCwq2B6UfC4h+4U3lGbJM2JwcCB
 MDFK/2lEI0MhUzbuA8wLRZ0eEh2/0itIpJVMYusx/gAMJBhcFHW/S7ycTbhZx99Vjcsm
 iV0xxXFPaMl+rZ2p5FQ9fXTJ54Os3JBToAwiCmvk3u14IBb+lNAO87uKBn/56HWhgf4m
 R8aiZumNLvyoZ85pO1skp1m4Rma+8URtzXAPVfHmus3541zgrM7hWKPNOq/4ai3zVgbz
 W5vg==
X-Gm-Message-State: AOAM532IMeKtJWwsKUW+W12R2DrSjbHd/qrg5nHUosCXf4ckSesNBVvG
 4FoVq2OQFaAZ13B7rJGpIGmVh6sNzGdRvo0s+nY=
X-Google-Smtp-Source: ABdhPJw4WfDgJ+hS2Mhy7p92iZHFEwCIFSdrAbTJ3aqIkfrV4t2qQ1XK47F8GFR17rMRglUVDvLQyCRN1SA6M6NRF0E=
X-Received: by 2002:a05:6602:1352:: with SMTP id
 i18mr13658471iov.148.1602385378091; 
 Sat, 10 Oct 2020 20:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-7-git-send-email-chenhc@lemote.com>
 <ae0f1019-91a5-f31e-4337-3be1d021a50e@amsat.org>
In-Reply-To: <ae0f1019-91a5-f31e-4337-3be1d021a50e@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sun, 11 Oct 2020 11:02:46 +0800
Message-ID: <CAAhV-H4xAqfE2zLOOMKdzTtaQvUsjaXv1SM2iq7LbTWXcSQ35A@mail.gmail.com>
Subject: Re: [PATCH V13 6/9] target/mips: Add loongson-ext lsdc2 group of
 instructions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Sat, Oct 10, 2020 at 9:07 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 10/7/20 10:39 AM, Huacai Chen wrote:
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > LDC2/SDC2 opcodes have been rewritten as "load & store with offset"
> > group of instructions by loongson-ext ASE.
> >
> > This patch add implementation of these instructions:
> > gslbx: load 1 bytes to GPR
> > gslhx: load 2 bytes to GPR
> > gslwx: load 4 bytes to GPR
> > gsldx: load 8 bytes to GPR
> > gslwxc1: load 4 bytes to FPR
> > gsldxc1: load 8 bytes to FPR
> > gssbx: store 1 bytes from GPR
> > gsshx: store 2 bytes from GPR
> > gsswx: store 4 bytes from GPR
> > gssdx: store 8 bytes from GPR
> > gsswxc1: store 4 bytes from FPR
> > gssdxc1: store 8 bytes from FPR
> >
> > Details of Loongson-EXT is here:
> > https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> If this patch is from Jiaxun, Huacai's S-o-b should come *after*.
OK, I will do that.

>
> > ---
> >   target/mips/translate.c | 179 +++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 179 insertions(+)
> >
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 916b57f..4d42cfc 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -484,6 +484,24 @@ enum {
> >       OPC_GSSDRC1     =3D 0x7 | OPC_GSSHFS,
> >   };
> >
> > +/* Loongson EXT LDC2/SDC2 opcodes */
> > +#define MASK_LOONGSON_LSDC2(op)           (MASK_OP_MAJOR(op) | (op & 0=
x7))
> > +
> > +enum {
> > +    OPC_GSLBX      =3D 0x0 | OPC_LDC2,
> > +    OPC_GSLHX      =3D 0x1 | OPC_LDC2,
> > +    OPC_GSLWX      =3D 0x2 | OPC_LDC2,
> > +    OPC_GSLDX      =3D 0x3 | OPC_LDC2,
> > +    OPC_GSLWXC1    =3D 0x6 | OPC_LDC2,
> > +    OPC_GSLDXC1    =3D 0x7 | OPC_LDC2,
> > +    OPC_GSSBX      =3D 0x0 | OPC_SDC2,
> > +    OPC_GSSHX      =3D 0x1 | OPC_SDC2,
> > +    OPC_GSSWX      =3D 0x2 | OPC_SDC2,
> > +    OPC_GSSDX      =3D 0x3 | OPC_SDC2,
> > +    OPC_GSSWXC1    =3D 0x6 | OPC_SDC2,
> > +    OPC_GSSDXC1    =3D 0x7 | OPC_SDC2,
> > +};
> > +
> >   /* BSHFL opcodes */
> >   #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F =
<< 6)))
> >
> > @@ -6172,6 +6190,165 @@ static void gen_loongson_lswc2(DisasContext *ct=
x, int rt,
> >       tcg_temp_free(t0);
> >   }
> >
> > +/* Loongson EXT LDC2/SDC2 */
> > +static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
> > +                                int rs, int rd)
>
> Alignment off (various occurences in this series).
OK, thanks.

>
> > +{
> > +    int offset =3D (int8_t)(ctx->opcode >> 3);
>
> Please use sextract32() which is easier to read:
>
>         int32_t offset =3D sextract32(ctx->opcode, 3, 8);
OK, thanks.

>
> > +    uint32_t opc =3D MASK_LOONGSON_LSDC2(ctx->opcode);
> > +    TCGv t0, t1;
> > +    TCGv_i32 fp0;
> > +
> > +    /* Pre-conditions */
> > +    switch (opc) {
> > +    case OPC_GSLBX:
> > +    case OPC_GSLHX:
> > +    case OPC_GSLWX:
> > +    case OPC_GSLDX:
> > +        /* prefetch, implement as NOP */
> > +        if (rt =3D=3D 0) {
> > +            return;
> > +        }
> > +        break;
> > +    case OPC_GSSBX:
> > +    case OPC_GSSHX:
> > +    case OPC_GSSWX:
> > +    case OPC_GSSDX:
> > +        break;
> > +    case OPC_GSLWXC1:
> > +#if defined(TARGET_MIPS64)
> > +    case OPC_GSLDXC1:
> > +#endif
> > +        check_cp1_enabled(ctx);
> > +        /* prefetch, implement as NOP */
> > +        if (rt =3D=3D 0) {
> > +            return;
> > +        }
> > +        break;
> > +    case OPC_GSSWXC1:
> > +#if defined(TARGET_MIPS64)
> > +    case OPC_GSSDXC1:
> > +#endif
> > +        check_cp1_enabled(ctx);
> > +        break;
> > +    default:
> > +        MIPS_INVAL("loongson_lsdc2");
> > +        generate_exception_end(ctx, EXCP_RI);
> > +        return;
> > +        break;
> > +    }
> > +
> > +    t0 =3D tcg_temp_new();
> > +
> > +    gen_base_offset_addr(ctx, t0, rs, offset);
> > +    gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> > +
> > +    switch (opc) {
> > +    case OPC_GSLBX:
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
> > +        gen_store_gpr(t0, rt);
> > +        break;
> > +    case OPC_GSLHX:
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
> > +                            ctx->default_tcg_memop_mask);
>
> Do Loongson EXT plan to support unaligned accesses?
Not support in hardware, and Linux kernel emulate the unaligned cases.

>
> > +        gen_store_gpr(t0, rt);
> > +        break;
> > +    case OPC_GSLWX:
> > +        gen_base_offset_addr(ctx, t0, rs, offset);
> > +        if (rd) {
> > +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> > +        }
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_gpr(t0, rt);
> > +        break;
> > +#if defined(TARGET_MIPS64)
> > +    case OPC_GSLDX:
> > +        gen_base_offset_addr(ctx, t0, rs, offset);
> > +        if (rd) {
> > +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> > +        }
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_gpr(t0, rt);
> > +        break;
> > +#endif
> > +    case OPC_GSLWXC1:
> > +        check_cp1_enabled(ctx);
> > +        gen_base_offset_addr(ctx, t0, rs, offset);
> > +        if (rd) {
> > +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> > +        }
> > +        fp0 =3D tcg_temp_new_i32();
> > +        tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TESL |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_fpr32(ctx, fp0, rt);
> > +        tcg_temp_free_i32(fp0);
> > +        break;
> > +#if defined(TARGET_MIPS64)
> > +    case OPC_GSLDXC1:
> > +        check_cp1_enabled(ctx);
> > +        gen_base_offset_addr(ctx, t0, rs, offset);
> > +        if (rd) {
> > +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> > +        }
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_fpr64(ctx, t0, rt);
> > +        break;
> > +#endif
> > +    case OPC_GSSBX:
> > +        t1 =3D tcg_temp_new();
> > +        gen_load_gpr(t1, rt);
> > +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_SB);
> > +        tcg_temp_free(t1);
> > +        break;
> > +    case OPC_GSSHX:
> > +        t1 =3D tcg_temp_new();
> > +        gen_load_gpr(t1, rt);
> > +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
> > +                            ctx->default_tcg_memop_mask);
> > +        tcg_temp_free(t1);
> > +        break;
> > +    case OPC_GSSWX:
> > +        t1 =3D tcg_temp_new();
> > +        gen_load_gpr(t1, rt);
> > +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
> > +                            ctx->default_tcg_memop_mask);
> > +        tcg_temp_free(t1);
> > +        break;
> > +#if defined(TARGET_MIPS64)
> > +    case OPC_GSSDX:
> > +        t1 =3D tcg_temp_new();
> > +        gen_load_gpr(t1, rt);
> > +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        tcg_temp_free(t1);
> > +        break;
> > +#endif
> > +    case OPC_GSSWXC1:
> > +        fp0 =3D tcg_temp_new_i32();
> > +        gen_load_fpr32(ctx, fp0, rt);
> > +        tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TEUL |
> > +                            ctx->default_tcg_memop_mask);
> > +        tcg_temp_free_i32(fp0);
> > +        break;
> > +#if defined(TARGET_MIPS64)
> > +    case OPC_GSSDXC1:
> > +        t1 =3D tcg_temp_new();
> > +        gen_load_fpr64(ctx, t1, rt);
> > +        tcg_gen_qemu_st_i64(t1, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        tcg_temp_free(t1);
> > +        break;
> > +#endif
> > +    default:
> > +        break;
> > +    }
> > +
> > +    tcg_temp_free(t0);
> > +}
> > +
> >   /* Traps */
> >   static void gen_trap(DisasContext *ctx, uint32_t opc,
> >                        int rs, int rt, int16_t imm)
> > @@ -31055,6 +31232,8 @@ static void decode_opc(CPUMIPSState *env, Disas=
Context *ctx)
> >                   /* OPC_JIC, OPC_JIALC */
> >                   gen_compute_compact_branch(ctx, op, 0, rt, imm);
> >               }
> > +        } else if (ctx->insn_flags & ASE_LEXT) {
> > +            gen_loongson_lsdc2(ctx, rt, rs, rd);
> >           } else {
> >               /* OPC_LWC2, OPC_SWC2 */
> >               /* COP2: Not implemented. */
> >
Huacai

