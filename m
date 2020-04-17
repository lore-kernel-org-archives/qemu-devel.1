Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2CCC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435EA221EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7lLW3IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435EA221EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZO7-0002eA-ER
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZNA-0002BJ-Tu
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZN9-0001u2-A8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:22:08 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZN3-0001lE-Fm; Fri, 17 Apr 2020 18:22:07 -0400
Received: by mail-io1-xd43.google.com with SMTP id 19so4070684ioz.10;
 Fri, 17 Apr 2020 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GWlf4htdRVgC0XuLnf1AKptqOIQJov5NGkIagmq6lpo=;
 b=S7lLW3IB3yvmIfsaTYTrrr59jmizG+UlybiCmfirPPPEXhcel3bz5/vUXucpbYYse9
 6h6SBg+KyEiE0xIyuf+pikWAe5VUjy7gxmpuadKocGi7DXWvGiCjUKCDkhnV9dAsYICf
 /4hAMbNhfpar3k+hclBfVCz2KCE89c6qEi8UrzLpCrgOFGO6L/lL7PAMmGLLU8dZweXm
 o89Zz4EDs4WqR6Cb5V9O/NErsoLOLtsuwbvhUTp99iGWybNbo+KqIoAXfl0ZWcMPuLOy
 bM8QfOvgK/3Ja75rfUHYXMEVA/AojqEA55pT8FE1G5S6Gw2Xugm7hAVmDYO8TZkoHUgp
 TP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GWlf4htdRVgC0XuLnf1AKptqOIQJov5NGkIagmq6lpo=;
 b=C8Y+i0O34KNo6WnVJya/sjzx8wIBTs7MGzY5cYT7xCPQhxDzvXXz+eQwf8Pcdzra7i
 FUAPN5sio4fJC5+t89881opUK4vm5KqG06bt0iqg0ge8q39AkTFi0IiteDLGjZbXRXSG
 JnmKx1fxgKstLXYFvOhmPwSZFzrJtFKy/cRaz47qoADm30FK72LIY55/MjAcheniHPjU
 LsCy9Zu/b+bwzG/UsSrh62nIbUwAYnwEHE4W+5VHa3LcPw+CFXkcWN4GTQUj4BrAyHH0
 cdg0L3uZ25Js6zMUJBhIoIn370VjAU/fyJuphao9dkPHlwaPHigYesRrxDBlYYCtvnCl
 NguA==
X-Gm-Message-State: AGi0PuaN3aiaSWMJLaDu0ivgIOUDb37DeNdfBs8ktuQvaL7hOENaM8eR
 XWsqxEMCGvKAYF+eeRRmX8Fbnsdj1XzfAuhlTw4=
X-Google-Smtp-Source: APiQypKU6P3LIqZyPniV4uMOAnbxNMzR740zd1ROtBrAE1C5A6pI1RfiAOylHiWeJh2xWXaY5dNp6MuF1mIIkEp6568=
X-Received: by 2002:a5d:984b:: with SMTP id p11mr5348736ios.175.1587162115437; 
 Fri, 17 Apr 2020 15:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-37-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-37-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 15:13:32 -0700
Message-ID: <CAKmqyKOVDF4NTyqXnEayXTQqeUTj7rEjeJinbATWr9P2F+cYHg@mail.gmail.com>
Subject: Re: [PATCH v7 36/61] target/riscv: vector floating-point square-root
 instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

On Mon, Mar 30, 2020 at 9:49 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  4 +++
>  target/riscv/insn32.decode              |  3 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 42 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 43 +++++++++++++++++++++++++
>  4 files changed, 92 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index edf963e787..db4de7135b 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -917,3 +917,7 @@ DEF_HELPER_6(vfwmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfwmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfwnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_5(vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 56bfd4a919..4ea71eaf39 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -45,6 +45,7 @@
>  &shift     shamt rs1 rd
>  &atomic    aq rl rs2 rs1 rd
>  &rmrr      vm rd rs1 rs2
> +&rmr       vm rd rs2
>  &rwdvm     vm wd rd rs1 rs2
>  &r2nfvm    vm rd rs1 nf
>  &rnfvm     vm rd rs1 rs2 nf
> @@ -68,6 +69,7 @@
>  @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
>  @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
>  @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... &r2nfvm %nf %rs1 %rd
> +@r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
>  @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
>  @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
>  @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
> @@ -487,6 +489,7 @@ vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
>  vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
>  vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
>  vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
> +vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 5e08c7133c..702972fda1 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2107,3 +2107,45 @@ GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
>  GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
>  GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
>  GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
> +
> +/* Vector Floating-Point Square-Root Instruction */
> +
> +/*
> + * If the current SEW does not correspond to a supported IEEE floating-point
> + * type, an illegal instruction exception is raised
> + */
> +static bool opfv_check(DisasContext *s, arg_rmr *a)
> +{
> +   return (vext_check_isa_ill(s) &&
> +            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            (s->sew != 0));
> +}
> +
> +#define GEN_OPFV_TRANS(NAME, CHECK)                                \
> +static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
> +{                                                                  \
> +    if (CHECK(s, a)) {                                             \
> +        uint32_t data = 0;                                         \
> +        static gen_helper_gvec_3_ptr * const fns[3] = {            \
> +            gen_helper_##NAME##_h,                                 \
> +            gen_helper_##NAME##_w,                                 \
> +            gen_helper_##NAME##_d,                                 \
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
> +GEN_OPFV_TRANS(vfsqrt_v, opfv_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 171252fb69..b8b1e496b1 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3773,3 +3773,46 @@ RVVCALL(OPFVF3, vfwnmsac_vf_h, WOP_UUU_H, H4, H2, fwnmsac16)
>  RVVCALL(OPFVF3, vfwnmsac_vf_w, WOP_UUU_W, H8, H4, fwnmsac32)
>  GEN_VEXT_VF(vfwnmsac_vf_h, 2, 4, clearl)
>  GEN_VEXT_VF(vfwnmsac_vf_w, 4, 8, clearq)
> +
> +/* Vector Floating-Point Square-Root Instruction */
> +/* (TD, T2, TX2) */
> +#define OP_UU_H uint16_t, uint16_t, uint16_t
> +#define OP_UU_W uint32_t, uint32_t, uint32_t
> +#define OP_UU_D uint64_t, uint64_t, uint64_t
> +
> +#define OPFVV1(NAME, TD, T2, TX2, HD, HS2, OP)        \
> +static void do_##NAME(void *vd, void *vs2, int i,      \
> +        CPURISCVState *env)                            \
> +{                                                      \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
> +    *((TD *)vd + HD(i)) = OP(s2, &env->fp_status);     \
> +}
> +
> +#define GEN_VEXT_V_ENV(NAME, ESZ, DSZ, CLEAR_FN)       \
> +void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
> +        CPURISCVState *env, uint32_t desc)             \
> +{                                                      \
> +    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
> +    uint32_t mlen = vext_mlen(desc);                   \
> +    uint32_t vm = vext_vm(desc);                       \
> +    uint32_t vl = env->vl;                             \
> +    uint32_t i;                                        \
> +                                                       \
> +    if (vl == 0) {                                     \
> +        return;                                        \
> +    }                                                  \
> +    for (i = 0; i < vl; i++) {                         \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {     \
> +            continue;                                  \
> +        }                                              \
> +        do_##NAME(vd, vs2, i, env);                    \
> +    }                                                  \
> +    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
> +}
> +
> +RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
> +RVVCALL(OPFVV1, vfsqrt_v_w, OP_UU_W, H4, H4, float32_sqrt)
> +RVVCALL(OPFVV1, vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
> +GEN_VEXT_V_ENV(vfsqrt_v_h, 2, 2, clearh)
> +GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
> +GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
> --
> 2.23.0
>

