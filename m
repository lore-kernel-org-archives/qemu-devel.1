Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCACC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3595020781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a53lP0lN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3595020781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Efl-0000Ko-Eu
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 10:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6Eex-0008A8-WF
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 10:56:52 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:34930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6Eev-00069R-SV
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 10:56:51 -0400
Received: by mail-io1-xd33.google.com with SMTP id s189so7637651iod.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i4mJN6yClNasIbae9JjhQ8m24J/+6KNPtZGVBbi7HJs=;
 b=a53lP0lNmvDf75M5PxHmiY5UOtnGkumzOJ04/kYOkVj1089exIziprgtM1Ucp0x4+k
 6zJJ7QAagcTW5acxMIifhSK7y4w3IAmHMV7P5wy3IOK84fikJb60pEKnloROZRHCRnfK
 gxu3T5j2L5UlA+xmH5FbWXSlqOUvuWX42Av3idygZcaciYKkK7i5o4ymHxK0XX3LBO6B
 bptf/gfMwgKkc5DBuwvml8VOfbfwjp6syEEZOrjDZOW9JfUid6pmihRuAOJHs66UNgTg
 kS+rVg/2Dh+RFo4QhuRrI2Sb8TksClWTH5rMyCiL55sANittMfg3CO1JHEYwiNNDBTQ5
 Qz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i4mJN6yClNasIbae9JjhQ8m24J/+6KNPtZGVBbi7HJs=;
 b=Cjzhd6fcwpV87/ihm+W2wtONIPKYP2LvG3Yom7ko9vY6yZAkM4OG+aKT00lW4BxZHz
 a7PxZ4A6qk50pjliL+wqXBuOiwU+aYGMf2l+mvU1hMT946fJ/xRC32s0iKgSnQ8dmRnR
 ZeL58pEbo4XYU7eFt49yaLMeXovT2a6JqPxuw9dxP8d+inQcv1Djqaw3uQRfdGADrIr/
 DK+zQOcZIbuSwuqMPkhyzoqRM5l7XrbVNrXWfg3VwgbDWM5EFCWLO1mVouE36cnEyJOp
 erEQO31HfRIJg9ADJeLH1HO8cyPLVbGaDbjNmfiTscLTRNP6rqfxKrZiEiaon9Fvy3Dm
 JulQ==
X-Gm-Message-State: AOAM531Yphmv8sJx+CH8x7WtFR+p4nzbfvYCtTMJswv6hzBxKM169vWX
 qnG+cHwSCUFI4rdLXsBLdtpe0ikP1aVggw+d/c8=
X-Google-Smtp-Source: ABdhPJyB0A4f2UiBNN8WGf3fkoCe+rpSzHJ1tMURoTXR6Zdn6N21tVeGWVgIrHzeWLhgWez8YIzXCQxy3DxXT/GDS28=
X-Received: by 2002:a6b:b345:: with SMTP id c66mr5276103iof.42.1597330606560; 
 Thu, 13 Aug 2020 07:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200812223045.96803-1-alistair.francis@wdc.com>
 <20200812223045.96803-6-alistair.francis@wdc.com>
 <39d42765-01de-2439-093d-c0246d81a7ce@c-sky.com>
In-Reply-To: <39d42765-01de-2439-093d-c0246d81a7ce@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Aug 2020 07:46:19 -0700
Message-ID: <CAKmqyKMBpR0R4C+81GVjjcq39rHDJ9YHUTekopogxnsh1UYWhQ@mail.gmail.com>
Subject: Re: [PULL 05/20] target/riscv: Check nanboxed inputs in
 trans_rvf.inc.c
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 7:14 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/8/13 6:30, Alistair Francis wrote:
> > From: Richard Henderson <richard.henderson@linaro.org>
> >
> > If a 32-bit input is not properly nanboxed, then the input is replaced
> > with the default qnan.  The only inline expansion is for the sign-changing
> > set of instructions: FSGNJ.S, FSGNJX.S, FSGNJN.S.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> > Message-Id: <20200724002807.441147-6-richard.henderson@linaro.org>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   target/riscv/insn_trans/trans_rvf.inc.c | 71 +++++++++++++++++++------
> >   target/riscv/translate.c                | 18 +++++++
> >   2 files changed, 73 insertions(+), 16 deletions(-)
> >
> > diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> > index 264d3139f1..f9a9e0643a 100644
> > --- a/target/riscv/insn_trans/trans_rvf.inc.c
> > +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> > @@ -161,47 +161,86 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
> >   {
> >       REQUIRE_FPU;
> >       REQUIRE_EXT(ctx, RVF);
> > +
> >       if (a->rs1 == a->rs2) { /* FMOV */
> > -        tcg_gen_mov_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
> > +        gen_check_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
> >       } else { /* FSGNJ */
> > -        tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
> > -                            0, 31);
> > +        TCGv_i64 rs1 = tcg_temp_new_i64();
> > +        TCGv_i64 rs2 = tcg_temp_new_i64();
> > +
> > +        gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
> > +        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
> > +
> > +        /* This formulation retains the nanboxing of rs2. */
> > +        tcg_gen_deposit_i64(cpu_fpr[a->rd], rs2, rs1, 0, 31);
> > +        tcg_temp_free_i64(rs1);
> > +        tcg_temp_free_i64(rs2);
> >       }
> > -    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
> >       mark_fs_dirty(ctx);
> >       return true;
> >   }
> >
> >   static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
> >   {
> > +    TCGv_i64 rs1, rs2, mask;
> > +
> >       REQUIRE_FPU;
> >       REQUIRE_EXT(ctx, RVF);
> > +
> > +    rs1 = tcg_temp_new_i64();
> > +    gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
> > +
> >       if (a->rs1 == a->rs2) { /* FNEG */
> > -        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
> > +        tcg_gen_xori_i64(cpu_fpr[a->rd], rs1, MAKE_64BIT_MASK(31, 1));
> >       } else {
> > -        TCGv_i64 t0 = tcg_temp_new_i64();
> > -        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
> > -        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
> > -        tcg_temp_free_i64(t0);
> > +        rs2 = tcg_temp_new_i64();
> > +        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
> > +
> > +        /*
> > +         * Replace bit 31 in rs1 with inverse in rs2.
> > +         * This formulation retains the nanboxing of rs1.
> > +         */
> > +        mask = tcg_const_i64(~MAKE_64BIT_MASK(31, 1));
> > +        tcg_gen_andc_i64(rs2, mask, rs2);
> Hi Alistair,
>
> As Chih-Min said, it's wrong here.  He has given the correct patch code
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg728540.html
>
> We can either  squash the code to this patch or add an separate patch
> later. I prefer the former.
> Thanks very much.

Richard are you ok if I squash this diff into the patch and send a PR v2?

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
b/target/riscv/insn_trans/trans_rvf.inc.c
index f9a9e0643a..76f281d275 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -201,7 +201,8 @@ static bool trans_fsgnjn_s(DisasContext *ctx,
arg_fsgnjn_s *a)
          * This formulation retains the nanboxing of rs1.
          */
         mask = tcg_const_i64(~MAKE_64BIT_MASK(31, 1));
-        tcg_gen_andc_i64(rs2, mask, rs2);
+        tcg_gen_not_i64(rs2, rs2);         // forget to inverse rs2
+        tcg_gen_andc_i64(rs2, rs2, mask);  //mask needs to be
         tcg_gen_and_i64(rs1, mask, rs1);
         tcg_gen_or_i64(cpu_fpr[a->rd], rs1, rs2);


Alistair

>
> Zhiwei
> > +        tcg_gen_and_i64(rs1, mask, rs1);
> > +        tcg_gen_or_i64(cpu_fpr[a->rd], rs1, rs2);
> > +
> > +        tcg_temp_free_i64(mask);
> > +        tcg_temp_free_i64(rs2);
> >       }
> > -    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
> > +    tcg_temp_free_i64(rs1);
> > +
> >       mark_fs_dirty(ctx);
> >       return true;
> >   }
> >
> >   static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
> >   {
> > +    TCGv_i64 rs1, rs2;
> > +
> >       REQUIRE_FPU;
> >       REQUIRE_EXT(ctx, RVF);
> > +
> > +    rs1 = tcg_temp_new_i64();
> > +    gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
> > +
> >       if (a->rs1 == a->rs2) { /* FABS */
> > -        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], ~INT32_MIN);
> > +        tcg_gen_andi_i64(cpu_fpr[a->rd], rs1, ~MAKE_64BIT_MASK(31, 1));
> >       } else {
> > -        TCGv_i64 t0 = tcg_temp_new_i64();
> > -        tcg_gen_andi_i64(t0, cpu_fpr[a->rs2], INT32_MIN);
> > -        tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
> > -        tcg_temp_free_i64(t0);
> > +        rs2 = tcg_temp_new_i64();
> > +        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
> > +
> > +        /*
> > +         * Xor bit 31 in rs1 with that in rs2.
> > +         * This formulation retains the nanboxing of rs1.
> > +         */
> > +        tcg_gen_andi_i64(rs2, rs2, MAKE_64BIT_MASK(31, 1));
> > +        tcg_gen_xor_i64(cpu_fpr[a->rd], rs1, rs2);
> > +
> > +        tcg_temp_free_i64(rs2);
> >       }
> > -    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
> > +    tcg_temp_free_i64(rs1);
> > +
> >       mark_fs_dirty(ctx);
> >       return true;
> >   }
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index 12a746da97..bf35182776 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -101,6 +101,24 @@ static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
> >       tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(32, 32));
> >   }
> >
> > +/*
> > + * A narrow n-bit operation, where n < FLEN, checks that input operands
> > + * are correctly Nan-boxed, i.e., all upper FLEN - n bits are 1.
> > + * If so, the least-significant bits of the input are used, otherwise the
> > + * input value is treated as an n-bit canonical NaN (v2.2 section 9.2).
> > + *
> > + * Here, the result is always nan-boxed, even the canonical nan.
> > + */
> > +static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
> > +{
> > +    TCGv_i64 t_max = tcg_const_i64(0xffffffff00000000ull);
> > +    TCGv_i64 t_nan = tcg_const_i64(0xffffffff7fc00000ull);
> > +
> > +    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
> > +    tcg_temp_free_i64(t_max);
> > +    tcg_temp_free_i64(t_nan);
> > +}
> > +
> >   static void generate_exception(DisasContext *ctx, int excp)
> >   {
> >       tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
>
>

