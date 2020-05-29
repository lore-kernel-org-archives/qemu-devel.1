Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1FEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657A120776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1e1+A/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657A120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jem8e-00072W-Jw
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 17:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jem7M-0006Q0-Bm; Fri, 29 May 2020 17:00:40 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:40947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jem7K-0003tL-Bx; Fri, 29 May 2020 17:00:39 -0400
Received: by mail-il1-x141.google.com with SMTP id t8so3321900ilm.7;
 Fri, 29 May 2020 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t+0flSDyEuMMZRsW92vPS2V1F9iTfeF3IfBDWwhl5Io=;
 b=B1e1+A/Q6UJDCLeMutNNIvg1izLD/43v5TUHT+U64+5xOEIIc9VQrMGuQqakke9dW8
 JZEPGTEB3hMS0N33ZUWcOyveNqQgunByoX9jTHQptUFTFgpzwDePxB1BfXTKwtc2ZgAS
 C+4kUo9iI31xs4DXW4Kt2yPsgxYCzsPMTBx1QQxBPbbymFJneNx3fud4gYSMKdLBBrtl
 gJD0sNz8PDoH7lXL5cGSzOfb5yn7s9c6CLxRNxL5ANWY59+a/vnRt6ALyrGJEC06f9aI
 S/yJNWazezwHhKb8C0gdkoDRCKUHpsdAJxstIMQW0A6sSN0cGOFkC6cbKFg1dROaEOnW
 aTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t+0flSDyEuMMZRsW92vPS2V1F9iTfeF3IfBDWwhl5Io=;
 b=uSqqUmtPnyv8li0ntJnhpW7A1ASQo/cUeclq63UlV7TDlGpyWSeeVcr0PBjsTkmvUA
 nBXpiQVx1Nv2iAvIxvNvrsyxd6YsA3Uv5Ei9HapN+6hh1lh8+r8steXFl2nToc/pAWVW
 aENiZk962sZL6Fy+oZmj4Qxt4sLb13sQ00/mr8yINbHyFScKLHTeOFxieWYSI4+vIpST
 WDnBuYUN9S4f3wlm533HWWxk9UNIj+4FbAqzxXjBJRfA2H392tzu8UTVErIqBhX4vLUq
 YhWcOapMI4NHn4VTKnEZolvVZJ1IG3fup0YzXUQfrvxEs0W5njP5TeAEBbzMM6KfC6Aj
 pudQ==
X-Gm-Message-State: AOAM531IZPq+9GXxv+u7YgWcaPM1nVZ//bqlvys8SNSa/AycX/7a8Zaz
 0WiBmDcvyfExltFrp9i8X0qczhAjNZ8BpJDsAQA=
X-Google-Smtp-Source: ABdhPJxepGeedOFRr0FVR9Cv80ipvJCdIVXUS7vBQd7zttmPxP6HXcsu1XqyzW/bs4+SzK0GFh2EZGUI/yZ4dYB5qN8=
X-Received: by 2002:a92:bb45:: with SMTP id w66mr9620401ili.131.1590786036108; 
 Fri, 29 May 2020 14:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-46-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-46-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 13:51:27 -0700
Message-ID: <CAKmqyKNPSUwya=Gb4mszAhiRDp=HMoPs43WSv3CADSGEw1h1zg@mail.gmail.com>
Subject: Re: [PATCH v8 45/62] target/riscv: narrowing floating-point/integer
 type-convert instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 4:15 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 11 ++++++
>  target/riscv/insn32.decode              |  5 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 47 +++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 39 ++++++++++++++++++++
>  4 files changed, 102 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index e59dcc5a7c..82c5d1129e 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1022,3 +1022,14 @@ DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
> +
> +DEF_HELPER_5(vfncvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index e0efc63ec2..57ac4de1c2 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -524,6 +524,11 @@ vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
>  vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
>  vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
>  vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
> +vfncvt_xu_f_v   100010 . ..... 10000 001 ..... 1010111 @r2_vm
> +vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
> +vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
> +vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
> +vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 44505027c1..e63b88a4cc 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2268,3 +2268,50 @@ GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v)
>  GEN_OPFV_WIDEN_TRANS(vfwcvt_f_xu_v)
>  GEN_OPFV_WIDEN_TRANS(vfwcvt_f_x_v)
>  GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
> +
> +/* Narrowing Floating-Point/Integer Type-Convert Instructions */
> +
> +/*
> + * If the current SEW does not correspond to a supported IEEE floating-point
> + * type, an illegal instruction exception is raised
> + */
> +static bool opfv_narrow_check(DisasContext *s, arg_rmr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, true) &&
> +            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
> +                                     2 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
> +}
> +
> +#define GEN_OPFV_NARROW_TRANS(NAME)                                \
> +static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
> +{                                                                  \
> +    if (opfv_narrow_check(s, a)) {                                 \
> +        uint32_t data = 0;                                         \
> +        static gen_helper_gvec_3_ptr * const fns[2] = {            \
> +            gen_helper_##NAME##_h,                                 \
> +            gen_helper_##NAME##_w,                                 \
> +        };                                                         \
> +        TCGLabel *over = gen_new_label();                          \
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
> +                                                                   \
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> +        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
> +                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
> +                           s->vlen / 8, data, fns[s->sew - 1]);    \
> +        gen_set_label(over);                                       \
> +        return true;                                               \
> +    }                                                              \
> +    return false;                                                  \
> +}
> +
> +GEN_OPFV_NARROW_TRANS(vfncvt_xu_f_v)
> +GEN_OPFV_NARROW_TRANS(vfncvt_x_f_v)
> +GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_v)
> +GEN_OPFV_NARROW_TRANS(vfncvt_f_x_v)
> +GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index ea6a5853f3..8e525720d1 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4292,3 +4292,42 @@ RVVCALL(OPFVV1, vfwcvt_f_f_v_h, WOP_UU_H, H4, H2, vfwcvtffv16)
>  RVVCALL(OPFVV1, vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, float32_to_float64)
>  GEN_VEXT_V_ENV(vfwcvt_f_f_v_h, 2, 4, clearl)
>  GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8, clearq)
> +
> +/* Narrowing Floating-Point/Integer Type-Convert Instructions */
> +/* (TD, T2, TX2) */
> +#define NOP_UU_H uint16_t, uint32_t, uint32_t
> +#define NOP_UU_W uint32_t, uint64_t, uint64_t
> +/* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
> +RVVCALL(OPFVV1, vfncvt_xu_f_v_h, NOP_UU_H, H2, H4, float32_to_uint16)
> +RVVCALL(OPFVV1, vfncvt_xu_f_v_w, NOP_UU_W, H4, H8, float64_to_uint32)
> +GEN_VEXT_V_ENV(vfncvt_xu_f_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfncvt_xu_f_v_w, 4, 4, clearl)
> +
> +/* vfncvt.x.f.v vd, vs2, vm # Convert double-width float to signed integer. */
> +RVVCALL(OPFVV1, vfncvt_x_f_v_h, NOP_UU_H, H2, H4, float32_to_int16)
> +RVVCALL(OPFVV1, vfncvt_x_f_v_w, NOP_UU_W, H4, H8, float64_to_int32)
> +GEN_VEXT_V_ENV(vfncvt_x_f_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfncvt_x_f_v_w, 4, 4, clearl)
> +
> +/* vfncvt.f.xu.v vd, vs2, vm # Convert double-width unsigned integer to float */
> +RVVCALL(OPFVV1, vfncvt_f_xu_v_h, NOP_UU_H, H2, H4, uint32_to_float16)
> +RVVCALL(OPFVV1, vfncvt_f_xu_v_w, NOP_UU_W, H4, H8, uint64_to_float32)
> +GEN_VEXT_V_ENV(vfncvt_f_xu_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfncvt_f_xu_v_w, 4, 4, clearl)
> +
> +/* vfncvt.f.x.v vd, vs2, vm # Convert double-width integer to float. */
> +RVVCALL(OPFVV1, vfncvt_f_x_v_h, NOP_UU_H, H2, H4, int32_to_float16)
> +RVVCALL(OPFVV1, vfncvt_f_x_v_w, NOP_UU_W, H4, H8, int64_to_float32)
> +GEN_VEXT_V_ENV(vfncvt_f_x_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfncvt_f_x_v_w, 4, 4, clearl)
> +
> +/* vfncvt.f.f.v vd, vs2, vm # Convert double float to single-width float. */
> +static uint16_t vfncvtffv16(uint32_t a, float_status *s)
> +{
> +    return float32_to_float16(a, true, s);
> +}
> +
> +RVVCALL(OPFVV1, vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
> +RVVCALL(OPFVV1, vfncvt_f_f_v_w, NOP_UU_W, H4, H8, float64_to_float32)
> +GEN_VEXT_V_ENV(vfncvt_f_f_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)
> --
> 2.23.0
>
>

