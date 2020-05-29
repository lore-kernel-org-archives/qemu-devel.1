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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A85C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFCD20897
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPSTuelr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFCD20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jem47-0002SV-U1
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jelt4-0001F8-L7; Fri, 29 May 2020 16:45:56 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:41721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jelt1-0002OC-NG; Fri, 29 May 2020 16:45:54 -0400
Received: by mail-il1-x141.google.com with SMTP id d1so3793752ila.8;
 Fri, 29 May 2020 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RIWfy33Pu8WBV4rCd/lR/2Krl6M801QIKLCcDoCmtik=;
 b=LPSTuelrQoG3v9/TwrOt1kwovKRgH2zZjFKKD7uBV7ZFZDsttSdPMVsK4P5dv+c0Gw
 clzWo0VXCnnW+30Fm1lVQLTYzbMYjG9Ra9S2LYFYGve6Pg0rnq0sMcoye4Q8gUxXJmq5
 6tQj6pD5DRC2sd493J0zUVXolBP55K7bN5YnNORHLa0WgSCfc49w4u2c9q+2R0KXfsx0
 5Wb+9V3FpBuOx7FMQNEShI1MscITqrq5SOtPRLmzYy23gEy2mRZcTEwU+1juqLhZBxtK
 AuYkQEgMhG90rPxgR/uO9mMljBPMqBMwW42p1nHg+AYigGyqD0w301UA8ZIKV+E9eeqE
 SlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RIWfy33Pu8WBV4rCd/lR/2Krl6M801QIKLCcDoCmtik=;
 b=L1ANK8y2ioS6AtTGorEFObZe59p1SDvC0wwMmqh3Gl2y4d8F37627TYmr9HvUbNckH
 V1WA3OV0ZvgPdZpMEjMFtyECtTLPuNVGuABc8G2VBKpw4qEfvNBS+4keNm8PCURqvFSy
 +pDDyUkYaI5Vw4fB6br+mqKmLuFoyVks0MA8Emt/pxR0aZmovp66k/+0C5ZkSi9zFYeq
 FgAHwM2xaetll4P+8EorFDmwxnwjm2xDoPo9AZ0+CgevECmJuzzpL+ELBWPIKX2GLb6I
 GJRQUxChTVIQOgmwB8WRC0+Sz6CBgdo817EmEFlRn5wEMS1CF/bgga+CzWyqQPAP0/NM
 n7Qg==
X-Gm-Message-State: AOAM531eZt7u7046raYyN4a3dPst8qX48K018mEj1xHGyuZHfxmjS1XY
 cmxCLVZErPHgk+Dn7S5yF1vTLw/0nfz5omacMwM=
X-Google-Smtp-Source: ABdhPJz2VzVqLMMk6s6YeiG1jE8NDpa/p+u2KLtb/qelwkS1WjcNKcAE1+7e9Mwn9hDrzAWcl/W9BM+1hTk6R5k2L64=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr3476236ilq.177.1590785150087; 
 Fri, 29 May 2020 13:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-43-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-43-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 13:36:40 -0700
Message-ID: <CAKmqyKMFoxWAAVWBJGNNYJKy-+X1wtuYevKtZv3fbbzvYJ1rsA@mail.gmail.com>
Subject: Re: [PATCH v8 42/62] target/riscv: vector floating-point merge
 instructions
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

On Thu, May 21, 2020 at 4:09 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  4 +++
>  target/riscv/insn32.decode              |  2 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 38 +++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 24 ++++++++++++++++
>  4 files changed, 68 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 23b268df90..21054cc957 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -994,3 +994,7 @@ DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
> +
> +DEF_HELPER_6(vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 23e80fe954..14cb4e2e66 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -513,6 +513,8 @@ vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
>  vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
>  vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
>  vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
> +vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
> +vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 621220e5ff..dfa2177331 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2177,3 +2177,41 @@ GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
>
>  /* Vector Floating-Point Classify Instruction */
>  GEN_OPFV_TRANS(vfclass_v, opfv_check)
> +
> +/* Vector Floating-Point Merge Instruction */
> +GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
> +
> +static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
> +{
> +    if (vext_check_isa_ill(s) &&
> +        vext_check_reg(s, a->rd, false) &&
> +        (s->sew != 0)) {
> +
> +        if (s->vl_eq_vlmax) {
> +            tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
> +                                 MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
> +        } else {
> +            TCGv_ptr dest;
> +            TCGv_i32 desc;
> +            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
> +            static gen_helper_vmv_vx * const fns[3] = {
> +                gen_helper_vmv_v_x_h,
> +                gen_helper_vmv_v_x_w,
> +                gen_helper_vmv_v_x_d,
> +            };
> +            TCGLabel *over = gen_new_label();
> +            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> +
> +            dest = tcg_temp_new_ptr();
> +            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
> +            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
> +            fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
> +
> +            tcg_temp_free_ptr(dest);
> +            tcg_temp_free_i32(desc);
> +            gen_set_label(over);
> +        }
> +        return true;
> +    }
> +    return false;
> +}
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 63d8873c0a..018293570d 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4193,3 +4193,27 @@ RVVCALL(OPIVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
>  GEN_VEXT_V(vfclass_v_h, 2, 2, clearh)
>  GEN_VEXT_V(vfclass_v_w, 4, 4, clearl)
>  GEN_VEXT_V(vfclass_v_d, 8, 8, clearq)
> +
> +/* Vector Floating-Point Merge Instruction */
> +#define GEN_VFMERGE_VF(NAME, ETYPE, H, CLEAR_FN)              \
> +void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
> +                  CPURISCVState *env, uint32_t desc)          \
> +{                                                             \
> +    uint32_t mlen = vext_mlen(desc);                          \
> +    uint32_t vm = vext_vm(desc);                              \
> +    uint32_t vl = env->vl;                                    \
> +    uint32_t esz = sizeof(ETYPE);                             \
> +    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
> +    uint32_t i;                                               \
> +                                                              \
> +    for (i = 0; i < vl; i++) {                                \
> +        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
> +        *((ETYPE *)vd + H(i))                                 \
> +          = (!vm && !vext_elem_mask(v0, mlen, i) ? s2 : s1);  \
> +    }                                                         \
> +    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
> +}
> +
> +GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
> +GEN_VFMERGE_VF(vfmerge_vfm_w, int32_t, H4, clearl)
> +GEN_VFMERGE_VF(vfmerge_vfm_d, int64_t, H8, clearq)
> --
> 2.23.0
>
>

