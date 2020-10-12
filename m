Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5381EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D5220790
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UveHk34w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D5220790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRvAI-0006Pe-U9
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kRv98-0005Na-5B
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:33:38 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kRv95-0007bx-Qw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:33:37 -0400
Received: by mail-il1-x141.google.com with SMTP id j13so11598243ilc.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=llygXVZvJytermkXK0B1HisnIxCYY+8wmsnh1sx4CNU=;
 b=UveHk34w47XKCEsRdqaPkMfEeiNbimhZfulbgFLriNjZr+SpWEesX9VdEsREGdy7uR
 6ezEV0/UR/ITleDdFqameej+R4/3iJepg0ZC5bVesaP+ycp5D7UDo5md1G7aRo29P9rv
 Fn/Mi8HyeoAT3uvzt4LztzqYMdbmPmFVtssUVp4InqLhELgLEucWINh7OsdP2TkrHXoW
 jvzB9prpyb8bH8Cv140/stDsOmQkzQtKA5MSqzfyAjHsotE43teE3xU5WCFfa1LebGZt
 ICzPEE+Gzc5L/TdAyL1EY2zgf4zEGjGNgEY4n1bOymhp4XYKvu1MoBdjE0+CX1JEuySm
 8bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=llygXVZvJytermkXK0B1HisnIxCYY+8wmsnh1sx4CNU=;
 b=Q8BZqTbM6UhPpksGuIXUMEaLVGfylqm0YXjn0GHG6xomlsaeiRDVq40VXhIojAwjin
 JL01RuUuXu7zN4wsHqRLJHLo8al7FkX02li0+KrHdMlYnEmiiHgD0qO6r7eZvRwAk7si
 jiKyB05IZJ//UbJ5Eu7SlnxjQ27tNn9HcaLF5LtvLMuxipepva1OxpbxFWKVYT7LC4qH
 JBboQP+7Vko+hbd+l5zMM5u+7ykyHru7dAsptsZ1wILPrR5ABFW2N+34PDaRJzsNBnpT
 KBNIBQE60bLlcohNOAEhtLqMInDMAa23MJJuEQ8vHjVktAde10aWCqtMWQYRKp2d3Ows
 zIHA==
X-Gm-Message-State: AOAM532C1LUO1QebF4dKLYzKUEelG/CRYgxKhdkyrnKS0oD1umW4gKgP
 qYYY5/VLzOV4dKyvgYjmMuyWFLvZQHuidcurQwE=
X-Google-Smtp-Source: ABdhPJziCMRuv75I0EO+mSmgDjwpZsJ0qYVpc/UPB1/ZGmwateMOPb7jsUncvzrziWdB14efarvgp8gefjUUm28YkmI=
X-Received: by 2002:a92:9ec7:: with SMTP id s68mr17926785ilk.143.1602498813887; 
 Mon, 12 Oct 2020 03:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-7-git-send-email-chenhc@lemote.com>
 <ae0f1019-91a5-f31e-4337-3be1d021a50e@amsat.org>
 <CAAhV-H4xAqfE2zLOOMKdzTtaQvUsjaXv1SM2iq7LbTWXcSQ35A@mail.gmail.com>
 <9148cfd9-7dbb-3038-5d02-0f7896ebfc70@amsat.org>
In-Reply-To: <9148cfd9-7dbb-3038-5d02-0f7896ebfc70@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Mon, 12 Oct 2020 18:33:21 +0800
Message-ID: <CAAhV-H5dKGX4dOtmeUqEJtYEKg2_Jo91P=kjTaUjyCZxYYhSAg@mail.gmail.com>
Subject: Re: [PATCH V13 6/9] target/mips: Add loongson-ext lsdc2 group of
 instructions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x141.google.com
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
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Sun, Oct 11, 2020 at 7:13 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 10/11/20 5:02 AM, Huacai Chen wrote:
> > Hi, Philippe,
> >
> > On Sat, Oct 10, 2020 at 9:07 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>
> >> On 10/7/20 10:39 AM, Huacai Chen wrote:
> >>> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>>
> >>> LDC2/SDC2 opcodes have been rewritten as "load & store with offset"
> >>> group of instructions by loongson-ext ASE.
> >>>
> >>> This patch add implementation of these instructions:
> >>> gslbx: load 1 bytes to GPR
> >>> gslhx: load 2 bytes to GPR
> >>> gslwx: load 4 bytes to GPR
> >>> gsldx: load 8 bytes to GPR
> >>> gslwxc1: load 4 bytes to FPR
> >>> gsldxc1: load 8 bytes to FPR
> >>> gssbx: store 1 bytes from GPR
> >>> gsshx: store 2 bytes from GPR
> >>> gsswx: store 4 bytes from GPR
> >>> gssdx: store 8 bytes from GPR
> >>> gsswxc1: store 4 bytes from FPR
> >>> gssdxc1: store 8 bytes from FPR
> >>>
> >>> Details of Loongson-EXT is here:
> >>> https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
> >>>
> >>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>
> >> If this patch is from Jiaxun, Huacai's S-o-b should come *after*.
> > OK, I will do that.
> >
> >>
> >>> ---
> >>>    target/mips/translate.c | 179 ++++++++++++++++++++++++++++++++++++=
++++++++++++
> >>>    1 file changed, 179 insertions(+)
> >>>
> >>> diff --git a/target/mips/translate.c b/target/mips/translate.c
> >>> index 916b57f..4d42cfc 100644
> >>> --- a/target/mips/translate.c
> >>> +++ b/target/mips/translate.c
> >>> @@ -484,6 +484,24 @@ enum {
> >>>        OPC_GSSDRC1     =3D 0x7 | OPC_GSSHFS,
> >>>    };
> >>>
> >>> +/* Loongson EXT LDC2/SDC2 opcodes */
> >>> +#define MASK_LOONGSON_LSDC2(op)           (MASK_OP_MAJOR(op) | (op &=
 0x7))
> >>> +
> >>> +enum {
> >>> +    OPC_GSLBX      =3D 0x0 | OPC_LDC2,
> >>> +    OPC_GSLHX      =3D 0x1 | OPC_LDC2,
> >>> +    OPC_GSLWX      =3D 0x2 | OPC_LDC2,
> >>> +    OPC_GSLDX      =3D 0x3 | OPC_LDC2,
> >>> +    OPC_GSLWXC1    =3D 0x6 | OPC_LDC2,
> >>> +    OPC_GSLDXC1    =3D 0x7 | OPC_LDC2,
> >>> +    OPC_GSSBX      =3D 0x0 | OPC_SDC2,
> >>> +    OPC_GSSHX      =3D 0x1 | OPC_SDC2,
> >>> +    OPC_GSSWX      =3D 0x2 | OPC_SDC2,
> >>> +    OPC_GSSDX      =3D 0x3 | OPC_SDC2,
> >>> +    OPC_GSSWXC1    =3D 0x6 | OPC_SDC2,
> >>> +    OPC_GSSDXC1    =3D 0x7 | OPC_SDC2,
> >>> +};
> >>> +
> >>>    /* BSHFL opcodes */
> >>>    #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x=
1F << 6)))
> >>>
> >>> @@ -6172,6 +6190,165 @@ static void gen_loongson_lswc2(DisasContext *=
ctx, int rt,
> >>>        tcg_temp_free(t0);
> >>>    }
> >>>
> >>> +/* Loongson EXT LDC2/SDC2 */
> >>> +static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
> >>> +                                int rs, int rd)
> >>
> >> Alignment off (various occurences in this series).
> > OK, thanks.
> >
> >>
> >>> +{
> >>> +    int offset =3D (int8_t)(ctx->opcode >> 3);
> >>
> >> Please use sextract32() which is easier to read:
> >>
> >>          int32_t offset =3D sextract32(ctx->opcode, 3, 8);
> > OK, thanks.
> >
> >>
> >>> +    uint32_t opc =3D MASK_LOONGSON_LSDC2(ctx->opcode);
> >>> +    TCGv t0, t1;
> >>> +    TCGv_i32 fp0;
> >>> +
> >>> +    /* Pre-conditions */
> >>> +    switch (opc) {
> >>> +    case OPC_GSLBX:
> >>> +    case OPC_GSLHX:
> >>> +    case OPC_GSLWX:
> >>> +    case OPC_GSLDX:
> >>> +        /* prefetch, implement as NOP */
> >>> +        if (rt =3D=3D 0) {
> >>> +            return;
> >>> +        }
> >>> +        break;
> >>> +    case OPC_GSSBX:
> >>> +    case OPC_GSSHX:
> >>> +    case OPC_GSSWX:
> >>> +    case OPC_GSSDX:
> >>> +        break;
> >>> +    case OPC_GSLWXC1:
> >>> +#if defined(TARGET_MIPS64)
> >>> +    case OPC_GSLDXC1:
> >>> +#endif
> >>> +        check_cp1_enabled(ctx);
> >>> +        /* prefetch, implement as NOP */
> >>> +        if (rt =3D=3D 0) {
> >>> +            return;
> >>> +        }
> >>> +        break;
> >>> +    case OPC_GSSWXC1:
> >>> +#if defined(TARGET_MIPS64)
> >>> +    case OPC_GSSDXC1:
> >>> +#endif
> >>> +        check_cp1_enabled(ctx);
> >>> +        break;
> >>> +    default:
> >>> +        MIPS_INVAL("loongson_lsdc2");
> >>> +        generate_exception_end(ctx, EXCP_RI);
> >>> +        return;
> >>> +        break;
> >>> +    }
> >>> +
> >>> +    t0 =3D tcg_temp_new();
> >>> +
> >>> +    gen_base_offset_addr(ctx, t0, rs, offset);
> >>> +    gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> >>> +
> >>> +    switch (opc) {
> >>> +    case OPC_GSLBX:
> >>> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
> >>> +        gen_store_gpr(t0, rt);
> >>> +        break;
> >>> +    case OPC_GSLHX:
> >>> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
> >>> +                            ctx->default_tcg_memop_mask);
> >>
> >> Do Loongson EXT plan to support unaligned accesses?
> > Not support in hardware, and Linux kernel emulate the unaligned cases.
>
> OK, that was my understanding. So we don't need to use
> default_tcg_memop_mask, we can directly use MO_ALIGN in
> place instead.
I read the code again, and found that MIPSR6 uses MO_UNALN while
others use MO_ALIGN. And I also realized that Loongson-3A4000 supports
unaligned access in hardware (the same as R6). So, I think I should
keep default_tcg_memop_mask here. And if possible, I want to set
MO_UNALN for all Loongson-3 processors.

Huacai
>
> Regards,
>
> Phil.

