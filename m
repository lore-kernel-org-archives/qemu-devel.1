Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C62C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B882A2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuVEB4X8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B882A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISM4-0003ir-SS
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kISKp-0002Cs-74
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:58:35 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:40644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kISKn-00025U-42
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:58:34 -0400
Received: by mail-il1-x144.google.com with SMTP id y2so5596426ilp.7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NRTh8FC11lO6PxBqJCNAuBJy47+BbW3lz9ccL6PlFds=;
 b=fuVEB4X8wvQMNXlux9yHJTiWss1w1WGf4aJcMV/pSt6J5ODt0QN0I3q/AiPVE2l0om
 lUIJaG3lZO4b7urMsQbHmyBebPbQWe52wIfv7q5NQG5hrDc50bv9ZOO9nkPg2JbiY71z
 GSUqLugyiv2lXO0j5xtjwLYOwBohlGyNJHaMPrplVFoFPZfnsml7Xcy8avQ7DtAXvNJy
 untFxuR3Vc+ldunM5K5PLl10Ur+TMs7T44h89BztX5E54AkLMDLqf/lL1mkvYqmLejP2
 096hNGEqPeELDricp+sNs0hPoVItjfpAPqts4ZU7oY13EupQWfwDZm6hwezqErEiGKYO
 Jf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NRTh8FC11lO6PxBqJCNAuBJy47+BbW3lz9ccL6PlFds=;
 b=JsMb98tYMbRXYa+h0ytnFqCZ+XbIDYbaR69eTX570iYpQzJo1U9yKEgcPRMbsy6VHA
 j/dJWyAkIZ4hBfH4mlEfM8j0hL67Zthui9hWKSPOOcFq5lLCPAahJ4DeXpf34SW6jRQ1
 hJxibH4IEUr/KK6nyKnxL72fqyZP/8fifJ7DsqBCl/Gk1I+b16ULfB998i1STT5eYG2h
 HFfa7WOMRaM5KHMTaeRygouZyc39bD2bw2oZp8oiRV0IYpBr6NpeCllPlHN1SSgivVPC
 6ZTxrKYxBTkEzrOab/iIqq+7gfCILCRjO9D3Zs7gjPdZd19d1ChcJ5rdtXPnejkqbpHR
 RwTA==
X-Gm-Message-State: AOAM532iivoqcKtaoEebr+ox+wCXbx0cTD+xuw/kStqITtXs3n4LPOwA
 u+DBfPMb+P47CRHtIRktf0Mt4SV1JHhxc17V7SU=
X-Google-Smtp-Source: ABdhPJw+4AcQV7ZwsENPQkKGxnJXLuCbTCktFHpFPTdmAm4q04Vbe0ClQ+Xf/s6khoaP/8TEoUJYGHopPKUu9PzWX14=
X-Received: by 2002:a92:c7a2:: with SMTP id f2mr735980ilk.171.1600243111419;
 Wed, 16 Sep 2020 00:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-4-git-send-email-chenhc@lemote.com>
 <c5f55594-5057-108c-2aa3-7da3ec20a5df@amsat.org>
In-Reply-To: <c5f55594-5057-108c-2aa3-7da3ec20a5df@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 16 Sep 2020 03:58:18 -0400
Message-ID: <CAAhV-H7kHLm7CHF-XcVk_gbS2tJvKapfC4muyoqnMzZCGi6rHw@mail.gmail.com>
Subject: Re: [PATCH V9 3/6] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 1)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x144.google.com
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
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Wed, Sep 16, 2020 at 3:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 9/16/20 4:12 AM, Huacai Chen wrote:
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > LWC2 & SWC2 have been rewritten by Loongson EXT vendor ASE
> > as "load/store quad word" and "shifted load/store" groups of
> > instructions.
> >
> > This patch add implementation of these instructions:
> > gslq: load 16 bytes to GPR
> > gssq: store 16 bytes from GPR
> > gslqc1: load 16 bytes to FPR
> > gssqc1: store 16 bytes from FPR
> >
> > Details of Loongson-EXT is here:
> > https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  target/mips/translate.c | 81 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 81 insertions(+)
> >
> > diff --git a/target/mips/translate.c b/target/mips/translate.c
> > index 398edf7..08d51e1 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -460,6 +460,17 @@ enum {
> >      R6_OPC_SCD         =3D 0x27 | OPC_SPECIAL3,
> >  };
> >
> > +/* Loongson EXT load/store quad word opcodes */
> > +#define MASK_LOONGSON_GSLSQ(op)           (MASK_OP_MAJOR(op) | (op & 0=
x8020))
> > +enum {
> > +    OPC_GSLQ        =3D 0x0020 | OPC_LWC2,
> > +    OPC_GSLQC1      =3D 0x8020 | OPC_LWC2,
> > +    OPC_GSSHFL      =3D OPC_LWC2,
> > +    OPC_GSSQ        =3D 0x0020 | OPC_SWC2,
> > +    OPC_GSSQC1      =3D 0x8020 | OPC_SWC2,
> > +    OPC_GSSHFS      =3D OPC_SWC2,
> > +};
> > +
> >  /* BSHFL opcodes */
> >  #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F <=
< 6)))
> >
> > @@ -5910,6 +5921,74 @@ no_rd:
> >      tcg_temp_free_i64(t1);
> >  }
> >
> > +static void gen_loongson_lswc2(DisasContext *ctx, int rt,
> > +                                int rs, int rd)
> > +{
> > +    TCGv t0, t1, t2;
> > +    TCGv_i32 fp0;
> > +    int lsq_offset =3D ((int)((ctx->opcode >> 6) & 0x1ff) << 23) >> 19=
;
> > +    int lsq_rt1 =3D ctx->opcode & 0x1f;
> > +    int shf_offset =3D (int8_t)(ctx->opcode >> 6);
> > +
> > +    t0 =3D tcg_temp_new();
> > +
> > +    switch (MASK_LOONGSON_GSLSQ(ctx->opcode)) {
> > +#if defined(TARGET_MIPS64)
>
> Build failure (is this code tested?):
>
> target/mips/translate.c: In function =E2=80=98gen_loongson_lswc2=E2=80=99=
:
> target/mips/translate.c:5961:9: error: unused variable =E2=80=98lsq_rt1=
=E2=80=99
> [-Werror=3Dunused-variable]
>      int lsq_rt1 =3D ctx->opcode & 0x1f;
>          ^
> target/mips/translate.c:5960:9: error: unused variable =E2=80=98lsq_offse=
t=E2=80=99
> [-Werror=3Dunused-variable]
>      int lsq_offset =3D ((int)((ctx->opcode >> 6) & 0x1ff) << 23) >> 19;
>          ^
> cc1: all warnings being treated as errors
Thank you very much, lsq_rt1 and lsq_offset should be guarded by TARGET_MIP=
S64.

Huacai
>
> > +    case OPC_GSLQ:
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_gpr(t0, rt);
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_gpr(t0, lsq_rt1);
> > +        break;
> > +    case OPC_GSLQC1:
> > +        check_cp1_enabled(ctx);
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_fpr64(ctx, t0, rt);
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_fpr64(ctx, t0, lsq_rt1);
> > +        break;
> > +    case OPC_GSSQ:
> > +        t1 =3D tcg_temp_new();
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> > +        gen_load_gpr(t1, rt);
> > +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> > +        gen_load_gpr(t1, lsq_rt1);
> > +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        tcg_temp_free(t1);
> > +        break;
> > +    case OPC_GSSQC1:
> > +        check_cp1_enabled(ctx);
> > +        t1 =3D tcg_temp_new();
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> > +        gen_load_fpr64(ctx, t1, rt);
> > +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> > +        gen_load_fpr64(ctx, t1, lsq_rt1);
> > +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        tcg_temp_free(t1);
> > +        break;
> > +#endif
> > +    default:
> > +        MIPS_INVAL("loongson_gslsq");
> > +        generate_exception_end(ctx, EXCP_RI);
> > +        break;
> > +    }
> > +    tcg_temp_free(t0);
> > +}
> > +
> >  /* Traps */
> >  static void gen_trap(DisasContext *ctx, uint32_t opc,
> >                       int rs, int rt, int16_t imm)
> > @@ -30774,6 +30853,8 @@ static void decode_opc(CPUMIPSState *env, Disas=
Context *ctx)
> >              /* OPC_BC, OPC_BALC */
> >              gen_compute_compact_branch(ctx, op, 0, 0,
> >                                         sextract32(ctx->opcode << 2, 0,=
 28));
> > +        } else if (ctx->insn_flags & ASE_LEXT) {
> > +            gen_loongson_lswc2(ctx, rt, rs, rd);
> >          } else {
> >              /* OPC_LWC2, OPC_SWC2 */
> >              /* COP2: Not implemented. */
> >

