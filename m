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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67B6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2EA20897
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4CE0kjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2EA20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jem5J-0004HL-MC
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jelzF-0001rG-GH; Fri, 29 May 2020 16:52:17 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jelzD-0002iX-9N; Fri, 29 May 2020 16:52:17 -0400
Received: by mail-io1-xd44.google.com with SMTP id j8so755179iog.13;
 Fri, 29 May 2020 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mK2qimd07WbhLD6Bp2VmIhc4MBsYYAJTCjTMofqB4do=;
 b=U4CE0kjz+RhA6AFBqNAnmgiE93ZxIcpmJyOyMloR3eDEhLity/ckhfFfWLckEfbrOd
 MHcQGenbI9OKQvSW/Pz06/Wn2yX9ki6IaWbSIvz5PkgTRBMpC6TpEk1hw4rAnS+Ofhfv
 GT/Q7MuxPtZ0N8HpCO2Yi0ilgDVC99p01TDAbdWNTxjKnbPiYIfqekfsA61Op7j8uMDo
 dzYU7ybCK7fWMTwKmn4f9kvml1rz5AiAmsY/es+bmGof8Gt7Lpmq4Z5p0tLwqk11EVDg
 g7TaoDaTWw//tGMJdJ937TStO70IzVu3O3tQpwLm5J91yh30LbP7bCTUtsmBrfqe5jhL
 IpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mK2qimd07WbhLD6Bp2VmIhc4MBsYYAJTCjTMofqB4do=;
 b=QKFKTIV9Ue1VWTeysSErgkgatEtjuIWYSLA7nRfwQ/RhjhLqx3f4TFnk6HNsQgyYV3
 03Z4Z0dCytdbLCJB4ctR3hIf2Z/wCTWj5jUPL8YM6a6Vc/zdpDXwrIBgMx5MnifGG/P+
 o1CC3KM0TdkYq8j6fnyDLSm9c48d/O9J/vQ2nVZErOBtRnJ07GIJcwsDRLm0h7DzSjEp
 2CIuTtJhNEm05yobYWB2YDF88EnF3NBwXvJY0Y/v7huIkFhlGtMOEEbfXjWDphW6wEdb
 ySZvW/WR9Zr4//tWL4fE3E8LJ1aRRXDwsCsMO/joknUdw7Sxq4Jd+LovAWm9idDjalv1
 EJ8A==
X-Gm-Message-State: AOAM531Df+jQc+HvreWfroQP6Xe77+goRm/Hz30Cq1Uahfg950UgNY9D
 LQB6E/2qoz7YSopTh0LEDbUSKEL7ScJJl8ZI1Ww=
X-Google-Smtp-Source: ABdhPJygQTkKkwRWigetL5gKI13WobECxfhUEuh58y0q/a0fW1mp0Ng16zoQ86yv3YlPdrgUVX1xAsePskCgcdj1BCw=
X-Received: by 2002:a02:6543:: with SMTP id u64mr9311861jab.26.1590785533326; 
 Fri, 29 May 2020 13:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-45-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-45-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 13:43:04 -0700
Message-ID: <CAKmqyKP7nCvMjMAuvkOjycyKw5j0X1-2BW=8enHO07zar1MOrA@mail.gmail.com>
Subject: Re: [PATCH v8 44/62] target/riscv: widening floating-point/integer
 type-convert instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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

On Thu, May 21, 2020 at 4:13 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 11 ++++++
>  target/riscv/insn32.decode              |  5 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 47 +++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 42 ++++++++++++++++++++++
>  4 files changed, 105 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 05f8fb5ffc..e59dcc5a7c 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1011,3 +1011,14 @@ DEF_HELPER_5(vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
> +
> +DEF_HELPER_5(vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 53562c6663..e0efc63ec2 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -519,6 +519,11 @@ vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
>  vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
>  vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
>  vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
> +vfwcvt_xu_f_v   100010 . ..... 01000 001 ..... 1010111 @r2_vm
> +vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
> +vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
> +vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
> +vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 6db460177d..44505027c1 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2221,3 +2221,50 @@ GEN_OPFV_TRANS(vfcvt_xu_f_v, opfv_check)
>  GEN_OPFV_TRANS(vfcvt_x_f_v, opfv_check)
>  GEN_OPFV_TRANS(vfcvt_f_xu_v, opfv_check)
>  GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
> +
> +/* Widening Floating-Point/Integer Type-Convert Instructions */
> +
> +/*
> + * If the current SEW does not correspond to a supported IEEE floating-point
> + * type, an illegal instruction exception is raised
> + */
> +static bool opfv_widen_check(DisasContext *s, arg_rmr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, true) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
> +                                     1 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
> +}
> +
> +#define GEN_OPFV_WIDEN_TRANS(NAME)                                 \
> +static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
> +{                                                                  \
> +    if (opfv_widen_check(s, a)) {                                  \
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
> +GEN_OPFV_WIDEN_TRANS(vfwcvt_xu_f_v)
> +GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v)
> +GEN_OPFV_WIDEN_TRANS(vfwcvt_f_xu_v)
> +GEN_OPFV_WIDEN_TRANS(vfwcvt_f_x_v)
> +GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 34b21c8deb..ea6a5853f3 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4250,3 +4250,45 @@ RVVCALL(OPFVV1, vfcvt_f_x_v_d, OP_UU_D, H8, H8, int64_to_float64)
>  GEN_VEXT_V_ENV(vfcvt_f_x_v_h, 2, 2, clearh)
>  GEN_VEXT_V_ENV(vfcvt_f_x_v_w, 4, 4, clearl)
>  GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8, 8, clearq)
> +
> +/* Widening Floating-Point/Integer Type-Convert Instructions */
> +/* (TD, T2, TX2) */
> +#define WOP_UU_H uint32_t, uint16_t, uint16_t
> +#define WOP_UU_W uint64_t, uint32_t, uint32_t
> +/* vfwcvt.xu.f.v vd, vs2, vm # Convert float to double-width unsigned integer.*/
> +RVVCALL(OPFVV1, vfwcvt_xu_f_v_h, WOP_UU_H, H4, H2, float16_to_uint32)
> +RVVCALL(OPFVV1, vfwcvt_xu_f_v_w, WOP_UU_W, H8, H4, float32_to_uint64)
> +GEN_VEXT_V_ENV(vfwcvt_xu_f_v_h, 2, 4, clearl)
> +GEN_VEXT_V_ENV(vfwcvt_xu_f_v_w, 4, 8, clearq)
> +
> +/* vfwcvt.x.f.v vd, vs2, vm # Convert float to double-width signed integer. */
> +RVVCALL(OPFVV1, vfwcvt_x_f_v_h, WOP_UU_H, H4, H2, float16_to_int32)
> +RVVCALL(OPFVV1, vfwcvt_x_f_v_w, WOP_UU_W, H8, H4, float32_to_int64)
> +GEN_VEXT_V_ENV(vfwcvt_x_f_v_h, 2, 4, clearl)
> +GEN_VEXT_V_ENV(vfwcvt_x_f_v_w, 4, 8, clearq)
> +
> +/* vfwcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to double-width float */
> +RVVCALL(OPFVV1, vfwcvt_f_xu_v_h, WOP_UU_H, H4, H2, uint16_to_float32)
> +RVVCALL(OPFVV1, vfwcvt_f_xu_v_w, WOP_UU_W, H8, H4, uint32_to_float64)
> +GEN_VEXT_V_ENV(vfwcvt_f_xu_v_h, 2, 4, clearl)
> +GEN_VEXT_V_ENV(vfwcvt_f_xu_v_w, 4, 8, clearq)
> +
> +/* vfwcvt.f.x.v vd, vs2, vm # Convert integer to double-width float. */
> +RVVCALL(OPFVV1, vfwcvt_f_x_v_h, WOP_UU_H, H4, H2, int16_to_float32)
> +RVVCALL(OPFVV1, vfwcvt_f_x_v_w, WOP_UU_W, H8, H4, int32_to_float64)
> +GEN_VEXT_V_ENV(vfwcvt_f_x_v_h, 2, 4, clearl)
> +GEN_VEXT_V_ENV(vfwcvt_f_x_v_w, 4, 8, clearq)
> +
> +/*
> + * vfwcvt.f.f.v vd, vs2, vm #
> + * Convert single-width float to double-width float.
> + */
> +static uint32_t vfwcvtffv16(uint16_t a, float_status *s)
> +{
> +    return float16_to_float32(a, true, s);
> +}
> +
> +RVVCALL(OPFVV1, vfwcvt_f_f_v_h, WOP_UU_H, H4, H2, vfwcvtffv16)
> +RVVCALL(OPFVV1, vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, float32_to_float64)
> +GEN_VEXT_V_ENV(vfwcvt_f_f_v_h, 2, 4, clearl)
> +GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8, clearq)
> --
> 2.23.0
>
>

