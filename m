Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A5CC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDCC20B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZc/YQdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDCC20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZCV-0002GQ-3M
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZB0-0001gw-Fn
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZAy-0007QB-IO
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:09:34 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:40967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZAy-0007ON-BQ; Fri, 17 Apr 2020 18:09:32 -0400
Received: by mail-il1-x142.google.com with SMTP id f82so3685517ilh.8;
 Fri, 17 Apr 2020 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0FXDPGiNdHkEkTErB/nqN8AxbDbQ1pWY+qKu1bM5us0=;
 b=YZc/YQdlfunMGXdqeZN51adNLQjlIyUZPdO9Hr7Oag/s1cvrSRjOG3sc3LwxiAsMVR
 E1eFrZ1Rz/v3PB8eBEUyylrYcymsvXmgkusuTpPX3UfeQBXcuN9n2kqm6+nGHqiWl4V/
 DUBELErxojVzAiIJiOMS4iID3KCyaQYmoG7wfn42givVnIpNudxD8ZAWgJAIv//xTzVt
 hm9t9SjBVSWugN6T7Ul7772ZpWmNtn81agu0g6y2Vwe2/y0YNnfCh2NH902jLMBXacjm
 esO7isydu7zw/UlNFm/3BzGljsw3d8MwDkzbA3PGHs5/Sc3ox/NhW3SlgnNDyQKEj3W+
 MqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0FXDPGiNdHkEkTErB/nqN8AxbDbQ1pWY+qKu1bM5us0=;
 b=gBiTuLiqsyLpfZzwgVRMsiOljTuBy7KY3U7oQw9tM1k+7NrRCJtbGumrDGxN2T/fw5
 RrdbwlLAu7M8sgZt1JNmZhawcXi3wsJk3EnrjQQ0Fz9W6tijVHkjiuop1uNVWt4RIaFt
 XJWUV1dTBsjxlDf4xRZYTmbGGP0ShecKuP9Rc0883wCKW2mWaUq0VeQdILI2O4bBnNzT
 UjB1wPLCVvtOJsGorR39n9dqdz/xBCRG7mKooLpFCMxQUykxfDFyBOdMjln1FcHCtFrn
 ffH0lZmw6o8Dr7CspdLRl83JwpItsvZcOP9sBUpcyMyxdUKZespLQsMHgTUq9OikQ8vY
 0LZw==
X-Gm-Message-State: AGi0PuZ3F/ag9XJ+Y+5pEf1Pa5tRVY8IFAL+q+0asBT6TNayxoC+Ov5q
 lrxFZFE3+fYPthY+ON26OW7589dB4IJpMG0yaOk=
X-Google-Smtp-Source: APiQypLz32bxVs3KzHVwoqKzVLyh3G8ucJDejbQ6OE/2uqmRT40a/qWcdJfyLXPvDB7kjFc95O5o5H28oktdyaOqRb0=
X-Received: by 2002:a92:79cc:: with SMTP id u195mr5385035ilc.131.1587161371659; 
 Fri, 17 Apr 2020 15:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-32-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-32-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 15:01:08 -0700
Message-ID: <CAKmqyKMQHrtXkZHGHQ7fLvarXevDv_XX9AGaJ9vnUCuvjnV+6g@mail.gmail.com>
Subject: Re: [PATCH v7 31/61] target/riscv: vector widening floating-point
 add/subtract instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 9:39 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  17 +++
>  target/riscv/insn32.decode              |   8 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 145 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            |  83 ++++++++++++++
>  4 files changed, 253 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 3031a941c2..73fc7a5a00 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -813,3 +813,20 @@ DEF_HELPER_6(vfsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfrsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfrsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfrsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_6(vfwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwadd_wf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwadd_wf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwsub_wf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwsub_wf_w, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index c8e3f10162..68e9448842 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -448,6 +448,14 @@ vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
>  vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
>  vfsub_vf        000010 . ..... ..... 101 ..... 1010111 @r_vm
>  vfrsub_vf       100111 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwadd_vv       110000 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwadd_vf       110000 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwadd_wv       110100 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwadd_wf       110100 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwsub_vv       110010 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwsub_vf       110010 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwsub_wv       110110 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwsub_wf       110110 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 9a8fb18adc..a539849fab 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1923,3 +1923,148 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
>  GEN_OPFVF_TRANS(vfadd_vf,  opfvf_check)
>  GEN_OPFVF_TRANS(vfsub_vf,  opfvf_check)
>  GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
> +
> +/* Vector Widening Floating-Point Add/Subtract Instructions */
> +static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, true) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs2,
> +                                     1 << s->lmul) &&
> +            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
> +                                     1 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
> +}
> +
> +/* OPFVV with WIDEN */
> +#define GEN_OPFVV_WIDEN_TRANS(NAME, CHECK)                       \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
> +{                                                                \
> +    if (CHECK(s, a)) {                                           \
> +        uint32_t data = 0;                                       \
> +        static gen_helper_gvec_4_ptr * const fns[2] = {          \
> +            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
> +        };                                                       \
> +        TCGLabel *over = gen_new_label();                        \
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);        \
> +                                                                 \
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
> +        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
> +                           vreg_ofs(s, a->rs1),                  \
> +                           vreg_ofs(s, a->rs2), cpu_env, 0,      \
> +                           s->vlen / 8, data, fns[s->sew - 1]);  \
> +        gen_set_label(over);                                     \
> +        return true;                                             \
> +    }                                                            \
> +    return false;                                                \
> +}
> +
> +GEN_OPFVV_WIDEN_TRANS(vfwadd_vv, opfvv_widen_check)
> +GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
> +
> +static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
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
> +/* OPFVF with WIDEN */
> +#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
> +{                                                                \
> +    if (opfvf_widen_check(s, a)) {                               \
> +        uint32_t data = 0;                                       \
> +        static gen_helper_opfvf *const fns[2] = {                \
> +            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
> +        };                                                       \
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
> +        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
> +                           fns[s->sew - 1], s);                  \
> +    }                                                            \
> +    return false;                                                \
> +}
> +
> +GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
> +
> +static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, true) &&
> +            vext_check_reg(s, a->rs2, true) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            vext_check_overlap_group(a->rd, 2 << s->lmul, a->rs1,
> +                                     1 << s->lmul) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
> +}
> +
> +/* WIDEN OPFVV with WIDEN */
> +#define GEN_OPFWV_WIDEN_TRANS(NAME)                                \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
> +{                                                                  \
> +    if (opfwv_widen_check(s, a)) {                                 \
> +        uint32_t data = 0;                                         \
> +        static gen_helper_gvec_4_ptr * const fns[2] = {            \
> +            gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
> +        };                                                         \
> +        TCGLabel *over = gen_new_label();                          \
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
> +                                                                   \
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> +        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
> +                           vreg_ofs(s, a->rs1),                    \
> +                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
> +                           s->vlen / 8, data, fns[s->sew - 1]);    \
> +        gen_set_label(over);                                       \
> +        return true;                                               \
> +    }                                                              \
> +    return false;                                                  \
> +}
> +
> +GEN_OPFWV_WIDEN_TRANS(vfwadd_wv)
> +GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
> +
> +static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, true) &&
> +            vext_check_reg(s, a->rd, true) &&
> +            vext_check_reg(s, a->rs2, true) &&
> +            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
> +}
> +
> +/* WIDEN OPFVF with WIDEN */
> +#define GEN_OPFWF_WIDEN_TRANS(NAME)                              \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
> +{                                                                \
> +    if (opfwf_widen_check(s, a)) {                               \
> +        uint32_t data = 0;                                       \
> +        static gen_helper_opfvf *const fns[2] = {                \
> +            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
> +        };                                                       \
> +        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
> +        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
> +                           fns[s->sew - 1], s);                  \
> +    }                                                            \
> +    return false;                                                \
> +}
> +
> +GEN_OPFWF_WIDEN_TRANS(vfwadd_wf)
> +GEN_OPFWF_WIDEN_TRANS(vfwsub_wf)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index af343e9bf9..08e59b0e29 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3277,3 +3277,86 @@ RVVCALL(OPFVF2, vfrsub_vf_d, OP_UUU_D, H8, H8, float64_rsub)
>  GEN_VEXT_VF(vfrsub_vf_h, 2, 2, clearh)
>  GEN_VEXT_VF(vfrsub_vf_w, 4, 4, clearl)
>  GEN_VEXT_VF(vfrsub_vf_d, 8, 8, clearq)
> +
> +/* Vector Widening Floating-Point Add/Subtract Instructions */
> +static uint32_t vfwadd16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    return float32_add(float16_to_float32(a, true, s),
> +            float16_to_float32(b, true, s), s);
> +}
> +
> +static uint64_t vfwadd32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    return float64_add(float32_to_float64(a, s),
> +            float32_to_float64(b, s), s);
> +
> +}
> +
> +RVVCALL(OPFVV2, vfwadd_vv_h, WOP_UUU_H, H4, H2, H2, vfwadd16)
> +RVVCALL(OPFVV2, vfwadd_vv_w, WOP_UUU_W, H8, H4, H4, vfwadd32)
> +GEN_VEXT_VV_ENV(vfwadd_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwadd_vv_w, 4, 8, clearq)
> +RVVCALL(OPFVF2, vfwadd_vf_h, WOP_UUU_H, H4, H2, vfwadd16)
> +RVVCALL(OPFVF2, vfwadd_vf_w, WOP_UUU_W, H8, H4, vfwadd32)
> +GEN_VEXT_VF(vfwadd_vf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwadd_vf_w, 4, 8, clearq)
> +
> +static uint32_t vfwsub16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    return float32_sub(float16_to_float32(a, true, s),
> +            float16_to_float32(b, true, s), s);
> +}
> +
> +static uint64_t vfwsub32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    return float64_sub(float32_to_float64(a, s),
> +            float32_to_float64(b, s), s);
> +
> +}
> +
> +RVVCALL(OPFVV2, vfwsub_vv_h, WOP_UUU_H, H4, H2, H2, vfwsub16)
> +RVVCALL(OPFVV2, vfwsub_vv_w, WOP_UUU_W, H8, H4, H4, vfwsub32)
> +GEN_VEXT_VV_ENV(vfwsub_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwsub_vv_w, 4, 8, clearq)
> +RVVCALL(OPFVF2, vfwsub_vf_h, WOP_UUU_H, H4, H2, vfwsub16)
> +RVVCALL(OPFVF2, vfwsub_vf_w, WOP_UUU_W, H8, H4, vfwsub32)
> +GEN_VEXT_VF(vfwsub_vf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwsub_vf_w, 4, 8, clearq)
> +
> +static uint32_t vfwaddw16(uint32_t a, uint16_t b, float_status *s)
> +{
> +    return float32_add(a, float16_to_float32(b, true, s), s);
> +}
> +
> +static uint64_t vfwaddw32(uint64_t a, uint32_t b, float_status *s)
> +{
> +    return float64_add(a, float32_to_float64(b, s), s);
> +}
> +
> +RVVCALL(OPFVV2, vfwadd_wv_h, WOP_WUUU_H, H4, H2, H2, vfwaddw16)
> +RVVCALL(OPFVV2, vfwadd_wv_w, WOP_WUUU_W, H8, H4, H4, vfwaddw32)
> +GEN_VEXT_VV_ENV(vfwadd_wv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwadd_wv_w, 4, 8, clearq)
> +RVVCALL(OPFVF2, vfwadd_wf_h, WOP_WUUU_H, H4, H2, vfwaddw16)
> +RVVCALL(OPFVF2, vfwadd_wf_w, WOP_WUUU_W, H8, H4, vfwaddw32)
> +GEN_VEXT_VF(vfwadd_wf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwadd_wf_w, 4, 8, clearq)
> +
> +static uint32_t vfwsubw16(uint32_t a, uint16_t b, float_status *s)
> +{
> +    return float32_sub(a, float16_to_float32(b, true, s), s);
> +}
> +
> +static uint64_t vfwsubw32(uint64_t a, uint32_t b, float_status *s)
> +{
> +    return float64_sub(a, float32_to_float64(b, s), s);
> +}
> +
> +RVVCALL(OPFVV2, vfwsub_wv_h, WOP_WUUU_H, H4, H2, H2, vfwsubw16)
> +RVVCALL(OPFVV2, vfwsub_wv_w, WOP_WUUU_W, H8, H4, H4, vfwsubw32)
> +GEN_VEXT_VV_ENV(vfwsub_wv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwsub_wv_w, 4, 8, clearq)
> +RVVCALL(OPFVF2, vfwsub_wf_h, WOP_WUUU_H, H4, H2, vfwsubw16)
> +RVVCALL(OPFVF2, vfwsub_wf_w, WOP_WUUU_W, H8, H4, vfwsubw32)
> +GEN_VEXT_VF(vfwsub_wf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwsub_wf_w, 4, 8, clearq)
> --
> 2.23.0
>

