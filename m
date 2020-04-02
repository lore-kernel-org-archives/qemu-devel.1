Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF322073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4ONsqvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF322073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8s9-0004kZ-5i
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 19:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jK8pu-0002r3-Eq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jK8ps-0001J2-HQ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:01:22 -0400
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42]:41008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jK8ps-0001IJ-DE; Thu, 02 Apr 2020 19:01:20 -0400
Received: by mail-vk1-xa42.google.com with SMTP id q8so1494184vka.8;
 Thu, 02 Apr 2020 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+EhoIUMr6AIYNXNpc4UuEHnod2ccJjZ0XpV8EXgn8NE=;
 b=n4ONsqvsoUIA+hsRVliFM7kL3b9Tao6zVrQJaEUB//NVr/4JAOPODfQYAsEfl4oCp5
 +obPXQ36xWg3pa/Y4VhTrkCT9wdFA3pu2Fe79zta+Cp2XWrUnKpQTxOU41XOVv43l2FC
 g97BFDS9Y1lzLR6tAD067lGsyLOjdXgCGsFdClUrf43Ph6GlLga/l8ABtwlaIWn269xF
 Ng3CXQ+6x9uOsfM/9VI9lvG2qc91CPLMj0gNUYTo9gLN0oyx/JHLF0ZX55TT4tuUklPX
 YkDqKKjLhTB+IXn48G01TDhJErF/4dIKqVxBdCCvM/YfZunG0+HNWFxbOVkBRExToEj5
 uNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+EhoIUMr6AIYNXNpc4UuEHnod2ccJjZ0XpV8EXgn8NE=;
 b=WkpYbTimdhiKQ58Y+7qvtPMryeTE4RpSH95DqVpPDS+EIZ6kzGc6kcvoTKxA/NHUIv
 VRYipuUxLYvy38Ga4ITb1CHfXoF1PhWhJDvpgUQbGAwDzrVmcn4Tu8jEa8fiMh8ijJeg
 c7BFud1g4qIsTYir2ZKgdXRkVr+2DS/22f19NsbPFkhuP5pUL70tB2jh87wKd/y+SY8y
 v/iKv59lusHk29r/Pz2j2mQJANYg2cviFKrs7vit9jBaAEIOoC8g3px0W3Z2cGQ+8JkX
 ObZLQKI1hlJnVTrdcbGVE/ohWKKGRsh46sEAu2f/Vwg/12SsZyVumfZ6pMVrypbbssBb
 CYAw==
X-Gm-Message-State: AGi0Puakhfm2btEAOKxooMqsd4PnJEqXmR92iq4T5eSSIXH0fnVQ6ITr
 iukCBzcUcJqXSD7BOXfJ5obQg5mt7MymCLqJNH8=
X-Google-Smtp-Source: APiQypLZlVeiJNtizpwn/YUVS1jYPvoyLpJSBssPfvNbkm1U4hO9uzHlMo6wZkfgAjDeQOp+i02jfOj6jt0BwA92DHc=
X-Received: by 2002:ac5:c4cd:: with SMTP id a13mr4327325vkl.22.1585868479555; 
 Thu, 02 Apr 2020 16:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-28-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-28-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2020 15:53:07 -0700
Message-ID: <CAKmqyKP-oQE9pGMydne9aQ522puo1FbaL898VCU5LN=6OWueKw@mail.gmail.com>
Subject: Re: [PATCH v7 27/61] target/riscv: vector widening saturating scaled
 multiply-add
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a42
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

On Mon, Mar 30, 2020 at 9:31 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  22 +++
>  target/riscv/insn32.decode              |   7 +
>  target/riscv/insn_trans/trans_rvv.inc.c |   9 ++
>  target/riscv/vector_helper.c            | 205 ++++++++++++++++++++++++
>  4 files changed, 243 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index e6cae1b59c..eb383787a2 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -745,3 +745,25 @@ DEF_HELPER_6(vsmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vwsmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 633f782fbf..2e0e66bdfa 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -424,6 +424,13 @@ vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
>  vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
>  vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
>  vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
> +vwsmaccu_vv     111100 . ..... ..... 000 ..... 1010111 @r_vm
> +vwsmaccu_vx     111100 . ..... ..... 100 ..... 1010111 @r_vm
> +vwsmacc_vv      111101 . ..... ..... 000 ..... 1010111 @r_vm
> +vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
> +vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
> +vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
> +vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 08a8444b46..c67faba23c 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1782,3 +1782,12 @@ GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
>  /* Vector Single-Width Fractional Multiply with Rounding and Saturation */
>  GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
>  GEN_OPIVX_TRANS(vsmul_vx,  opivx_check)
> +
> +/* Vector Widening Saturating Scaled Multiply-Add */
> +GEN_OPIVV_WIDEN_TRANS(vwsmaccu_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwsmacc_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwsmaccsu_vv, opivv_widen_check)
> +GEN_OPIVX_WIDEN_TRANS(vwsmaccu_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwsmacc_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwsmaccsu_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwsmaccus_vx)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 23868fb1b2..b9c1cf5237 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -2703,3 +2703,208 @@ GEN_VEXT_VX_RM(vsmul_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX_RM(vsmul_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX_RM(vsmul_vx_w, 4, 4, clearl)
>  GEN_VEXT_VX_RM(vsmul_vx_d, 8, 8, clearq)
> +
> +/* Vector Widening Saturating Scaled Multiply-Add */
> +static inline uint16_t
> +vwsmaccu8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b,
> +          uint16_t c)
> +{
> +    uint8_t round;
> +    uint16_t res = (uint16_t)a * b;
> +
> +    round = get_round(vxrm, res, 4);
> +    res   = (res >> 4) + round;
> +    return saddu16(env, vxrm, c, res);
> +}
> +
> +static inline uint32_t
> +vwsmaccu16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b,
> +           uint32_t c)
> +{
> +    uint8_t round;
> +    uint32_t res = (uint32_t)a * b;
> +
> +    round = get_round(vxrm, res, 8);
> +    res   = (res >> 8) + round;
> +    return saddu32(env, vxrm, c, res);
> +}
> +
> +static inline uint64_t
> +vwsmaccu32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b,
> +           uint64_t c)
> +{
> +    uint8_t round;
> +    uint64_t res = (uint64_t)a * b;
> +
> +    round = get_round(vxrm, res, 16);
> +    res   = (res >> 16) + round;
> +    return saddu64(env, vxrm, c, res);
> +}
> +
> +#define OPIVV3_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)    \
> +static inline void                                                 \
> +do_##NAME(void *vd, void *vs1, void *vs2, int i,                   \
> +          CPURISCVState *env, int vxrm)                            \
> +{                                                                  \
> +    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
> +    TD d = *((TD *)vd + HD(i));                                    \
> +    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, s1, d);                \
> +}
> +
> +RVVCALL(OPIVV3_RM, vwsmaccu_vv_b, WOP_UUU_B, H2, H1, H1, vwsmaccu8)
> +RVVCALL(OPIVV3_RM, vwsmaccu_vv_h, WOP_UUU_H, H4, H2, H2, vwsmaccu16)
> +RVVCALL(OPIVV3_RM, vwsmaccu_vv_w, WOP_UUU_W, H8, H4, H4, vwsmaccu32)
> +GEN_VEXT_VV_RM(vwsmaccu_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV_RM(vwsmaccu_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_RM(vwsmaccu_vv_w, 4, 8, clearq)
> +
> +#define OPIVX3_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)         \
> +static inline void                                                 \
> +do_##NAME(void *vd, target_long s1, void *vs2, int i,              \
> +          CPURISCVState *env, int vxrm)                            \
> +{                                                                  \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
> +    TD d = *((TD *)vd + HD(i));                                    \
> +    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, (TX1)(T1)s1, d);       \
> +}
> +
> +RVVCALL(OPIVX3_RM, vwsmaccu_vx_b, WOP_UUU_B, H2, H1, vwsmaccu8)
> +RVVCALL(OPIVX3_RM, vwsmaccu_vx_h, WOP_UUU_H, H4, H2, vwsmaccu16)
> +RVVCALL(OPIVX3_RM, vwsmaccu_vx_w, WOP_UUU_W, H8, H4, vwsmaccu32)
> +GEN_VEXT_VX_RM(vwsmaccu_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX_RM(vwsmaccu_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX_RM(vwsmaccu_vx_w, 4, 8, clearq)
> +
> +static inline int16_t
> +vwsmacc8(CPURISCVState *env, int vxrm, int8_t a, int8_t b, int16_t c)
> +{
> +    uint8_t round;
> +    int16_t res = (int16_t)a * b;
> +
> +    round = get_round(vxrm, res, 4);
> +    res   = (res >> 4) + round;
> +    return sadd16(env, vxrm, c, res);
> +}
> +
> +static inline int32_t
> +vwsmacc16(CPURISCVState *env, int vxrm, int16_t a, int16_t b, int32_t c)
> +{
> +    uint8_t round;
> +    int32_t res = (int32_t)a * b;
> +
> +    round = get_round(vxrm, res, 8);
> +    res   = (res >> 8) + round;
> +    return sadd32(env, vxrm, c, res);
> +
> +}
> +
> +static inline int64_t
> +vwsmacc32(CPURISCVState *env, int vxrm, int32_t a, int32_t b, int64_t c)
> +{
> +    uint8_t round;
> +    int64_t res = (int64_t)a * b;
> +
> +    round = get_round(vxrm, res, 16);
> +    res   = (res >> 16) + round;
> +    return sadd64(env, vxrm, c, res);
> +}
> +
> +RVVCALL(OPIVV3_RM, vwsmacc_vv_b, WOP_SSS_B, H2, H1, H1, vwsmacc8)
> +RVVCALL(OPIVV3_RM, vwsmacc_vv_h, WOP_SSS_H, H4, H2, H2, vwsmacc16)
> +RVVCALL(OPIVV3_RM, vwsmacc_vv_w, WOP_SSS_W, H8, H4, H4, vwsmacc32)
> +GEN_VEXT_VV_RM(vwsmacc_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV_RM(vwsmacc_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_RM(vwsmacc_vv_w, 4, 8, clearq)
> +RVVCALL(OPIVX3_RM, vwsmacc_vx_b, WOP_SSS_B, H2, H1, vwsmacc8)
> +RVVCALL(OPIVX3_RM, vwsmacc_vx_h, WOP_SSS_H, H4, H2, vwsmacc16)
> +RVVCALL(OPIVX3_RM, vwsmacc_vx_w, WOP_SSS_W, H8, H4, vwsmacc32)
> +GEN_VEXT_VX_RM(vwsmacc_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX_RM(vwsmacc_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX_RM(vwsmacc_vx_w, 4, 8, clearq)
> +
> +static inline int16_t
> +vwsmaccsu8(CPURISCVState *env, int vxrm, uint8_t a, int8_t b, int16_t c)
> +{
> +    uint8_t round;
> +    int16_t res = a * (int16_t)b;
> +
> +    round = get_round(vxrm, res, 4);
> +    res   = (res >> 4) + round;
> +    return ssub16(env, vxrm, c, res);
> +}
> +
> +static inline int32_t
> +vwsmaccsu16(CPURISCVState *env, int vxrm, uint16_t a, int16_t b, uint32_t c)
> +{
> +    uint8_t round;
> +    int32_t res = a * (int32_t)b;
> +
> +    round = get_round(vxrm, res, 8);
> +    res   = (res >> 8) + round;
> +    return ssub32(env, vxrm, c, res);
> +}
> +
> +static inline int64_t
> +vwsmaccsu32(CPURISCVState *env, int vxrm, uint32_t a, int32_t b, int64_t c)
> +{
> +    uint8_t round;
> +    int64_t res = a * (int64_t)b;
> +
> +    round = get_round(vxrm, res, 16);
> +    res   = (res >> 16) + round;
> +    return ssub64(env, vxrm, c, res);
> +}
> +
> +RVVCALL(OPIVV3_RM, vwsmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, vwsmaccsu8)
> +RVVCALL(OPIVV3_RM, vwsmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, vwsmaccsu16)
> +RVVCALL(OPIVV3_RM, vwsmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, vwsmaccsu32)
> +GEN_VEXT_VV_RM(vwsmaccsu_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV_RM(vwsmaccsu_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_RM(vwsmaccsu_vv_w, 4, 8, clearq)
> +RVVCALL(OPIVX3_RM, vwsmaccsu_vx_b, WOP_SSU_B, H2, H1, vwsmaccsu8)
> +RVVCALL(OPIVX3_RM, vwsmaccsu_vx_h, WOP_SSU_H, H4, H2, vwsmaccsu16)
> +RVVCALL(OPIVX3_RM, vwsmaccsu_vx_w, WOP_SSU_W, H8, H4, vwsmaccsu32)
> +GEN_VEXT_VX_RM(vwsmaccsu_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX_RM(vwsmaccsu_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX_RM(vwsmaccsu_vx_w, 4, 8, clearq)
> +
> +static inline int16_t
> +vwsmaccus8(CPURISCVState *env, int vxrm, int8_t a, uint8_t b, int16_t c)
> +{
> +    uint8_t round;
> +    int16_t res = (int16_t)a * b;
> +
> +    round = get_round(vxrm, res, 4);
> +    res   = (res >> 4) + round;
> +    return ssub16(env, vxrm, c, res);
> +}
> +
> +static inline int32_t
> +vwsmaccus16(CPURISCVState *env, int vxrm, int16_t a, uint16_t b, int32_t c)
> +{
> +    uint8_t round;
> +    int32_t res = (int32_t)a * b;
> +
> +    round = get_round(vxrm, res, 8);
> +    res   = (res >> 8) + round;
> +    return ssub32(env, vxrm, c, res);
> +}
> +
> +static inline int64_t
> +vwsmaccus32(CPURISCVState *env, int vxrm, int32_t a, uint32_t b, int64_t c)
> +{
> +    uint8_t round;
> +    int64_t res = (int64_t)a * b;
> +
> +    round = get_round(vxrm, res, 16);
> +    res   = (res >> 16) + round;
> +    return ssub64(env, vxrm, c, res);
> +}
> +
> +RVVCALL(OPIVX3_RM, vwsmaccus_vx_b, WOP_SUS_B, H2, H1, vwsmaccus8)
> +RVVCALL(OPIVX3_RM, vwsmaccus_vx_h, WOP_SUS_H, H4, H2, vwsmaccus16)
> +RVVCALL(OPIVX3_RM, vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
> +GEN_VEXT_VX_RM(vwsmaccus_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX_RM(vwsmaccus_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX_RM(vwsmaccus_vx_w, 4, 8, clearq)
> --
> 2.23.0
>

