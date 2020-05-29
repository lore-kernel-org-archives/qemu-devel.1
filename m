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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DCA206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u32veTqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DCA206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeled-0003Rz-BP
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jeldA-0002X4-NB; Fri, 29 May 2020 16:29:28 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jeld9-00019B-8a; Fri, 29 May 2020 16:29:28 -0400
Received: by mail-io1-xd43.google.com with SMTP id r2so753508ioo.4;
 Fri, 29 May 2020 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S66q1eSNSnE/u1hbmrSZMOqxYzzdpvdSgDI1f8JSh3o=;
 b=u32veTqiTxbKAKrdIOwW2oZul3X4eU3+V5lQJP0gTrQ8qr+t/ifm2mAt/H1MLiRMTh
 TeRqFuBFiRBOPaZiCkv4rKogR5YfZ5vHYMQd5+mmgFSRTL+rzluMEdshIriY/ATnBPa3
 n4ccrdRGE/RL6moG23SrUD5FtaqdzBG+HCFyZ0vTP+SBHv5iXwGW6GT6Z1JpFyqw61JX
 teGldsohw0KejjxppTlqDGelT24dp26oWcbIYFexZpCBGvx2bvKK5FMbxotdrmJz/xr2
 sjpV5x2xDe43jFlCpYWGPIQ3kuZaIPJwMdobZS2OJywPbgZuF0tpPAzR76lJIsrrd7PX
 6lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S66q1eSNSnE/u1hbmrSZMOqxYzzdpvdSgDI1f8JSh3o=;
 b=tA/znpAV/CAPbPloOyRyOrembRUcsxa6pO3+NdZAE6WcRDSyrGPdrObjfbERTCMejg
 XByIphH5rmqFABCVmh4340XaLR+yHy7qakeKSvcMuwxPI2SO2uoJcZTKvTRu4ErtEbRd
 rDiSgIk5yZpTePab9aWrmfov5hDCn7P/r9PtdcNkVYcW9nDPiXw1fEsKPAZjtqZPViIl
 LYXta4uOEqwutd9vJgp2aYxeQ8mC5Nc07ryfFcCBBA5Y/JDXsQo7h17TYud38Gs70cry
 aV6Ow+QdBQkwXsk+FaPUOIPBiO+QD4cAkQ40h4aZiPDvh3MZswA8aLroTyQHWWoQEISB
 A05A==
X-Gm-Message-State: AOAM530gheAdDYZgaIw6tG4OyHt2yEZ5yDAzjpd5Q/bzVuEKogP5C8cm
 Gd8Kl5lQCMzY4VZhz3TCVzE9HtOUORlt0OJVSN0=
X-Google-Smtp-Source: ABdhPJza9A7QB3COzu9NQbw2Vv7pJi0DD8gA/YI4VDX6VkSfydooqd3Sz81uqLL/4nW5dntoOZtNPz95J6jYP6nz+es=
X-Received: by 2002:a6b:6a13:: with SMTP id x19mr8178130iog.175.1590784165550; 
 Fri, 29 May 2020 13:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-42-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-42-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 13:20:21 -0700
Message-ID: <CAKmqyKOvhYwCrtyezCFXR8o3n2CRWoBYT_QDdRrn21tnSwx24g@mail.gmail.com>
Subject: Re: [PATCH v8 41/62] target/riscv: vector floating-point classify
 instructions
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

On Thu, May 21, 2020 at 4:07 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/fpu_helper.c               | 33 +--------
>  target/riscv/helper.h                   |  4 ++
>  target/riscv/insn32.decode              |  1 +
>  target/riscv/insn_trans/trans_rvv.inc.c |  3 +
>  target/riscv/internals.h                |  5 ++
>  target/riscv/vector_helper.c            | 91 +++++++++++++++++++++++++
>  6 files changed, 107 insertions(+), 30 deletions(-)
>
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 262610e837..fdbdffaef2 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -22,6 +22,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
>  #include "fpu/softfloat.h"
> +#include "internals.h"
>
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
>  {
> @@ -239,21 +240,7 @@ uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
>
>  target_ulong helper_fclass_s(uint64_t frs1)
>  {
> -    float32 f = frs1;
> -    bool sign = float32_is_neg(f);
> -
> -    if (float32_is_infinity(f)) {
> -        return sign ? 1 << 0 : 1 << 7;
> -    } else if (float32_is_zero(f)) {
> -        return sign ? 1 << 3 : 1 << 4;
> -    } else if (float32_is_zero_or_denormal(f)) {
> -        return sign ? 1 << 2 : 1 << 5;
> -    } else if (float32_is_any_nan(f)) {
> -        float_status s = { }; /* for snan_bit_is_one */
> -        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> -    } else {
> -        return sign ? 1 << 1 : 1 << 6;
> -    }
> +    return fclass_s(frs1);
>  }
>
>  uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> @@ -362,19 +349,5 @@ uint64_t helper_fcvt_d_lu(CPURISCVState *env, uint64_t rs1)
>
>  target_ulong helper_fclass_d(uint64_t frs1)
>  {
> -    float64 f = frs1;
> -    bool sign = float64_is_neg(f);
> -
> -    if (float64_is_infinity(f)) {
> -        return sign ? 1 << 0 : 1 << 7;
> -    } else if (float64_is_zero(f)) {
> -        return sign ? 1 << 3 : 1 << 4;
> -    } else if (float64_is_zero_or_denormal(f)) {
> -        return sign ? 1 << 2 : 1 << 5;
> -    } else if (float64_is_any_nan(f)) {
> -        float_status s = { }; /* for snan_bit_is_one */
> -        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> -    } else {
> -        return sign ? 1 << 1 : 1 << 6;
> -    }
> +    return fclass_d(frs1);
>  }
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index bedd4d0114..23b268df90 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -990,3 +990,7 @@ DEF_HELPER_6(vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index b0f1c54d53..23e80fe954 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -512,6 +512,7 @@ vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
>  vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
>  vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
>  vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
> +vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 4a45c00ffb..621220e5ff 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2174,3 +2174,6 @@ GEN_OPFVF_TRANS(vmfle_vf, opfvf_cmp_check)
>  GEN_OPFVF_TRANS(vmfgt_vf, opfvf_cmp_check)
>  GEN_OPFVF_TRANS(vmfge_vf, opfvf_cmp_check)
>  GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
> +
> +/* Vector Floating-Point Classify Instruction */
> +GEN_OPFV_TRANS(vfclass_v, opfv_check)
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 52f6af2513..ed2ad7f0f1 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -30,4 +30,9 @@ FIELD(VDATA, WD, 11, 1)
>
>  /* set float rounding mode */
>  bool riscv_cpu_set_rounding_mode(CPURISCVState *env, uint32_t rm);
> +
> +/* float point classify helpers */
> +target_ulong fclass_h(uint64_t frs1);
> +target_ulong fclass_s(uint64_t frs1);
> +target_ulong fclass_d(uint64_t frs1);
>  #endif
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 92227228b7..63d8873c0a 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4102,3 +4102,94 @@ GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
>  GEN_VEXT_CMP_VF(vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
>  GEN_VEXT_CMP_VF(vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
>  GEN_VEXT_CMP_VF(vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
> +
> +/* Vector Floating-Point Classify Instruction */
> +#define OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP)         \
> +static void do_##NAME(void *vd, void *vs2, int i)      \
> +{                                                      \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
> +    *((TD *)vd + HD(i)) = OP(s2);                      \
> +}
> +
> +#define GEN_VEXT_V(NAME, ESZ, DSZ, CLEAR_FN)           \
> +void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
> +                  CPURISCVState *env, uint32_t desc)   \
> +{                                                      \
> +    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
> +    uint32_t mlen = vext_mlen(desc);                   \
> +    uint32_t vm = vext_vm(desc);                       \
> +    uint32_t vl = env->vl;                             \
> +    uint32_t i;                                        \
> +                                                       \
> +    for (i = 0; i < vl; i++) {                         \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {     \
> +            continue;                                  \
> +        }                                              \
> +        do_##NAME(vd, vs2, i);                         \
> +    }                                                  \
> +    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
> +}
> +
> +target_ulong fclass_h(uint64_t frs1)
> +{
> +    float16 f = frs1;
> +    bool sign = float16_is_neg(f);
> +
> +    if (float16_is_infinity(f)) {
> +        return sign ? 1 << 0 : 1 << 7;
> +    } else if (float16_is_zero(f)) {
> +        return sign ? 1 << 3 : 1 << 4;
> +    } else if (float16_is_zero_or_denormal(f)) {
> +        return sign ? 1 << 2 : 1 << 5;
> +    } else if (float16_is_any_nan(f)) {
> +        float_status s = { }; /* for snan_bit_is_one */
> +        return float16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +    } else {
> +        return sign ? 1 << 1 : 1 << 6;
> +    }
> +}
> +
> +target_ulong fclass_s(uint64_t frs1)
> +{
> +    float32 f = frs1;
> +    bool sign = float32_is_neg(f);
> +
> +    if (float32_is_infinity(f)) {
> +        return sign ? 1 << 0 : 1 << 7;
> +    } else if (float32_is_zero(f)) {
> +        return sign ? 1 << 3 : 1 << 4;
> +    } else if (float32_is_zero_or_denormal(f)) {
> +        return sign ? 1 << 2 : 1 << 5;
> +    } else if (float32_is_any_nan(f)) {
> +        float_status s = { }; /* for snan_bit_is_one */
> +        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +    } else {
> +        return sign ? 1 << 1 : 1 << 6;
> +    }
> +}
> +
> +target_ulong fclass_d(uint64_t frs1)
> +{
> +    float64 f = frs1;
> +    bool sign = float64_is_neg(f);
> +
> +    if (float64_is_infinity(f)) {
> +        return sign ? 1 << 0 : 1 << 7;
> +    } else if (float64_is_zero(f)) {
> +        return sign ? 1 << 3 : 1 << 4;
> +    } else if (float64_is_zero_or_denormal(f)) {
> +        return sign ? 1 << 2 : 1 << 5;
> +    } else if (float64_is_any_nan(f)) {
> +        float_status s = { }; /* for snan_bit_is_one */
> +        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
> +    } else {
> +        return sign ? 1 << 1 : 1 << 6;
> +    }
> +}
> +
> +RVVCALL(OPIVV1, vfclass_v_h, OP_UU_H, H2, H2, fclass_h)
> +RVVCALL(OPIVV1, vfclass_v_w, OP_UU_W, H4, H4, fclass_s)
> +RVVCALL(OPIVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
> +GEN_VEXT_V(vfclass_v_h, 2, 2, clearh)
> +GEN_VEXT_V(vfclass_v_w, 4, 4, clearl)
> +GEN_VEXT_V(vfclass_v_d, 8, 8, clearq)
> --
> 2.23.0
>
>

