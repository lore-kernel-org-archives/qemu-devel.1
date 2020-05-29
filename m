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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F96C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D125207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQbajVE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D125207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jemEa-0003v3-Rh
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 17:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jemDp-0003Ux-JA; Fri, 29 May 2020 17:07:21 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jemDo-0007Gi-3E; Fri, 29 May 2020 17:07:21 -0400
Received: by mail-io1-xd43.google.com with SMTP id c8so836782iob.6;
 Fri, 29 May 2020 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SsLiszMllH5ifzjEQR/D3EK0lzl9ZidrZAaMUT9Jz94=;
 b=mQbajVE69ULyE5A40mkXfgPBiJainTGW4fd0svpl1ideS9hUCLgv3uTjtY1Giv/jWk
 SO/1UUbUCw0UQaKIgnfpS0qUkbEc22PFFWZppcGhTRFF4jiedNBJ47H2RPBkzm7quPq+
 QfxbQ2MeIApSqnBn9tKxANL23o0At9pI74kuECz77aOOCD4V1MRWDQHnO5GdOOjFYrn8
 ai/t2YKmi2WmvBIYGxD/kCXsn+YF89YkII/tHAfMZRSWKpGaG4oUllccTZsO/GHnJhpI
 FZpwpEnJY0okJ1lRA1M4iUexo+ulfBdFG0rIQGdDaY6gvOZtSVOusxll10EKxc/N2ZIa
 v9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SsLiszMllH5ifzjEQR/D3EK0lzl9ZidrZAaMUT9Jz94=;
 b=eLw6jYaC7zGDjU5Ey0xySnphbaZaazNpMeJxErfH1uFR9+rrfjcWDTgR7g1+TAe1yn
 +WtSm7vWOQdCAoQMv9WxREIWpNbbw9aQ2Y8nw/xPmGUphdMAX+tMwXGwC+/f1a0NBsti
 erwkBAF66l1PMDkSpv7QZoyHe27ohRfl+kHme3FZx+jiyNkKJ9y67u27+xeJwNENgXuB
 h7ysgfsV2M6oPCTWCWSKr+MCR2fF2OJFJ0isE/Hpv6ufy1iOhRK6dlID1M3w/Xb7gYPw
 7GItOwGlismfHqCRN3m2F64ZlRO4ViCQBALJ98TU9BMmv2dPGO1VSSp29t8CAjAHa8OA
 pfnw==
X-Gm-Message-State: AOAM531pPxg7vMsi7Hb+qV61+uZnzUuWN1Ia5HZK0qoPzCtj1Cyu5PN6
 dCyGRUVFECXP80NGlRk16BXcX3gbZso//yqL56U=
X-Google-Smtp-Source: ABdhPJyAe7GcUDsrs+dSHZd9Vfe1y6sJo9D5E0LucF6cMtP13um1o5ZvCcfasdMUK+fJK1uxR9GV+b9VQk6exd5hH2c=
X-Received: by 2002:a5e:dd45:: with SMTP id u5mr7204097iop.118.1590786438618; 
 Fri, 29 May 2020 14:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-47-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-47-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 13:58:14 -0700
Message-ID: <CAKmqyKP_XRXhHX=aeipBxpQUuTPvG=3T3gVK4sbEkW=3Sb=tKA@mail.gmail.com>
Subject: Re: [PATCH v8 46/62] target/riscv: vector single-width integer
 reduction instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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

On Thu, May 21, 2020 at 4:17 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 33 +++++++++++
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 18 ++++++
>  target/riscv/vector_helper.c            | 74 +++++++++++++++++++++++++
>  4 files changed, 133 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 82c5d1129e..93a7a303ee 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1033,3 +1033,36 @@ DEF_HELPER_5(vfncvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfncvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfncvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfncvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
> +
> +DEF_HELPER_6(vredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredsum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmaxu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmaxu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmaxu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmaxu_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmax_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmax_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmax_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredminu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredminu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredminu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredminu_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmin_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredand_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredand_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredand_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredand_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredxor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredxor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredxor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vredxor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 57ac4de1c2..773b32f0b4 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -529,6 +529,14 @@ vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
>  vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
>  vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
>  vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
> +vredsum_vs      000000 . ..... ..... 010 ..... 1010111 @r_vm
> +vredand_vs      000001 . ..... ..... 010 ..... 1010111 @r_vm
> +vredor_vs       000010 . ..... ..... 010 ..... 1010111 @r_vm
> +vredxor_vs      000011 . ..... ..... 010 ..... 1010111 @r_vm
> +vredminu_vs     000100 . ..... ..... 010 ..... 1010111 @r_vm
> +vredmin_vs      000101 . ..... ..... 010 ..... 1010111 @r_vm
> +vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
> +vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index e63b88a4cc..9dfb9358a2 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2315,3 +2315,21 @@ GEN_OPFV_NARROW_TRANS(vfncvt_x_f_v)
>  GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_v)
>  GEN_OPFV_NARROW_TRANS(vfncvt_f_x_v)
>  GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
> +
> +/*
> + *** Vector Reduction Operations
> + */
> +/* Vector Single-Width Integer Reduction Instructions */
> +static bool reduction_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return vext_check_isa_ill(s) && vext_check_reg(s, a->rs2, false);
> +}
> +
> +GEN_OPIVV_TRANS(vredsum_vs, reduction_check)
> +GEN_OPIVV_TRANS(vredmaxu_vs, reduction_check)
> +GEN_OPIVV_TRANS(vredmax_vs, reduction_check)
> +GEN_OPIVV_TRANS(vredminu_vs, reduction_check)
> +GEN_OPIVV_TRANS(vredmin_vs, reduction_check)
> +GEN_OPIVV_TRANS(vredand_vs, reduction_check)
> +GEN_OPIVV_TRANS(vredor_vs, reduction_check)
> +GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 8e525720d1..00ed6a75a5 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4331,3 +4331,77 @@ RVVCALL(OPFVV1, vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
>  RVVCALL(OPFVV1, vfncvt_f_f_v_w, NOP_UU_W, H4, H8, float64_to_float32)
>  GEN_VEXT_V_ENV(vfncvt_f_f_v_h, 2, 2, clearh)
>  GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)
> +
> +/*
> + *** Vector Reduction Operations
> + */
> +/* Vector Single-Width Integer Reduction Instructions */
> +#define GEN_VEXT_RED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)\
> +void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
> +        void *vs2, CPURISCVState *env, uint32_t desc)     \
> +{                                                         \
> +    uint32_t mlen = vext_mlen(desc);                      \
> +    uint32_t vm = vext_vm(desc);                          \
> +    uint32_t vl = env->vl;                                \
> +    uint32_t i;                                           \
> +    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;        \
> +    TD s1 =  *((TD *)vs1 + HD(0));                        \
> +                                                          \
> +    for (i = 0; i < vl; i++) {                            \
> +        TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
> +            continue;                                     \
> +        }                                                 \
> +        s1 = OP(s1, (TD)s2);                              \
> +    }                                                     \
> +    *((TD *)vd + HD(0)) = s1;                             \
> +    CLEAR_FN(vd, 1, sizeof(TD), tot);                     \
> +}
> +
> +/* vd[0] = sum(vs1[0], vs2[*]) */
> +GEN_VEXT_RED(vredsum_vs_b, int8_t, int8_t, H1, H1, DO_ADD, clearb)
> +GEN_VEXT_RED(vredsum_vs_h, int16_t, int16_t, H2, H2, DO_ADD, clearh)
> +GEN_VEXT_RED(vredsum_vs_w, int32_t, int32_t, H4, H4, DO_ADD, clearl)
> +GEN_VEXT_RED(vredsum_vs_d, int64_t, int64_t, H8, H8, DO_ADD, clearq)
> +
> +/* vd[0] = maxu(vs1[0], vs2[*]) */
> +GEN_VEXT_RED(vredmaxu_vs_b, uint8_t, uint8_t, H1, H1, DO_MAX, clearb)
> +GEN_VEXT_RED(vredmaxu_vs_h, uint16_t, uint16_t, H2, H2, DO_MAX, clearh)
> +GEN_VEXT_RED(vredmaxu_vs_w, uint32_t, uint32_t, H4, H4, DO_MAX, clearl)
> +GEN_VEXT_RED(vredmaxu_vs_d, uint64_t, uint64_t, H8, H8, DO_MAX, clearq)
> +
> +/* vd[0] = max(vs1[0], vs2[*]) */
> +GEN_VEXT_RED(vredmax_vs_b, int8_t, int8_t, H1, H1, DO_MAX, clearb)
> +GEN_VEXT_RED(vredmax_vs_h, int16_t, int16_t, H2, H2, DO_MAX, clearh)
> +GEN_VEXT_RED(vredmax_vs_w, int32_t, int32_t, H4, H4, DO_MAX, clearl)
> +GEN_VEXT_RED(vredmax_vs_d, int64_t, int64_t, H8, H8, DO_MAX, clearq)
> +
> +/* vd[0] = minu(vs1[0], vs2[*]) */
> +GEN_VEXT_RED(vredminu_vs_b, uint8_t, uint8_t, H1, H1, DO_MIN, clearb)
> +GEN_VEXT_RED(vredminu_vs_h, uint16_t, uint16_t, H2, H2, DO_MIN, clearh)
> +GEN_VEXT_RED(vredminu_vs_w, uint32_t, uint32_t, H4, H4, DO_MIN, clearl)
> +GEN_VEXT_RED(vredminu_vs_d, uint64_t, uint64_t, H8, H8, DO_MIN, clearq)
> +
> +/* vd[0] = min(vs1[0], vs2[*]) */
> +GEN_VEXT_RED(vredmin_vs_b, int8_t, int8_t, H1, H1, DO_MIN, clearb)
> +GEN_VEXT_RED(vredmin_vs_h, int16_t, int16_t, H2, H2, DO_MIN, clearh)
> +GEN_VEXT_RED(vredmin_vs_w, int32_t, int32_t, H4, H4, DO_MIN, clearl)
> +GEN_VEXT_RED(vredmin_vs_d, int64_t, int64_t, H8, H8, DO_MIN, clearq)
> +
> +/* vd[0] = and(vs1[0], vs2[*]) */
> +GEN_VEXT_RED(vredand_vs_b, int8_t, int8_t, H1, H1, DO_AND, clearb)
> +GEN_VEXT_RED(vredand_vs_h, int16_t, int16_t, H2, H2, DO_AND, clearh)
> +GEN_VEXT_RED(vredand_vs_w, int32_t, int32_t, H4, H4, DO_AND, clearl)
> +GEN_VEXT_RED(vredand_vs_d, int64_t, int64_t, H8, H8, DO_AND, clearq)
> +
> +/* vd[0] = or(vs1[0], vs2[*]) */
> +GEN_VEXT_RED(vredor_vs_b, int8_t, int8_t, H1, H1, DO_OR, clearb)
> +GEN_VEXT_RED(vredor_vs_h, int16_t, int16_t, H2, H2, DO_OR, clearh)
> +GEN_VEXT_RED(vredor_vs_w, int32_t, int32_t, H4, H4, DO_OR, clearl)
> +GEN_VEXT_RED(vredor_vs_d, int64_t, int64_t, H8, H8, DO_OR, clearq)
> +
> +/* vd[0] = xor(vs1[0], vs2[*]) */
> +GEN_VEXT_RED(vredxor_vs_b, int8_t, int8_t, H1, H1, DO_XOR, clearb)
> +GEN_VEXT_RED(vredxor_vs_h, int16_t, int16_t, H2, H2, DO_XOR, clearh)
> +GEN_VEXT_RED(vredxor_vs_w, int32_t, int32_t, H4, H4, DO_XOR, clearl)
> +GEN_VEXT_RED(vredxor_vs_d, int64_t, int64_t, H8, H8, DO_XOR, clearq)
> --
> 2.23.0
>
>

