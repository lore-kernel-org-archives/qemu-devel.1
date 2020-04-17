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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B0FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F3320B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ioll/K8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F3320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZER-0003Yl-8k
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZCO-0002Ns-L3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZCM-0001Ni-4k
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:11:00 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZCL-0001LM-VU; Fri, 17 Apr 2020 18:10:58 -0400
Received: by mail-io1-xd42.google.com with SMTP id i3so4028732ioo.13;
 Fri, 17 Apr 2020 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=piU0swIERRP9Yf/WLECtmHgt9WHa4so5z8YIpNNhwuY=;
 b=Ioll/K8rhvDQmYHtYe3AWjV6P662a1N1iQgxG5HwK2LLsntcPg+jsSx1r7QKLRtiBT
 XHnf6m4adjNQB+aoiCFqZS2ePZxogPrXqKKjsXFDAfgmovKhj1If8EPH2/34GeWhSx57
 DGLQQ1ZnSdOnlz6wW/UH17fwT1FEx3H2FP06C4UnnkwM/WCSXSwx3maqfrs342XVnkVD
 Ybb1PD5cdcGF3kYSh00TkRhy6jGfoiBhlE21lRj32VM8SxzZHvPPobdkMav/E5HbArNS
 bccsVjRNkXSfw8rbr521WdKVxUGEO1+asKPAyVg0+0QEshuyCMucuSMaB+TLcQqRN1Co
 kozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=piU0swIERRP9Yf/WLECtmHgt9WHa4so5z8YIpNNhwuY=;
 b=S/tG0i9eITK9puu44vO0bGp4NVpgpdBugJmoXKJTiNIkacqFJAdTdaK+StbGhUIpsC
 uVqRi2Iz4UuLfOs0/PdFvWxkBuEt+9jy/RR18MNmwtEDQ3KO+s+pzXtYK9l5TP1CSjph
 H6fxqJa+KMUlhwWPcQtP0TUKrvUtjK5QlND0/I3bkI+98ixUlda/c7iS1zX6inOr15lu
 ogrDuNs10uteOlvGJ1uJyHWMAjLIQNVcCgxfww1D1+lQ1aWy3/Pgq7UYJAXVdJfjbanA
 NwSdKn5pA5Qlo56MTKd8puxDPV7wDDKXtrOx+L7doZZsvPc/pPaL45chS5vem6pLY64l
 RWvg==
X-Gm-Message-State: AGi0PuY3zMKEZGbQQ2hMTW98HIF4dW9/05OXYN3uK5F1QOzXAZDWKQCV
 oGUkNE5F8wZn+xZsIT4YIJhtMoA86xEpIN3fDCY=
X-Google-Smtp-Source: APiQypK86XLZT+IzVOzYlIvDw3TZ5EmDo3/oxyv3mpD+TX+SrGxI2IOXlA8TLnhBVRs7UGVgFfThO9TbZjj+4d+9/t8=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr5390212ioj.42.1587161457025; 
 Fri, 17 Apr 2020 15:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-35-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-35-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 15:02:33 -0700
Message-ID: <CAKmqyKNgwGd16ff7hXjyiPokP2S49SpiJZXiWo2aoagCqXNn1A@mail.gmail.com>
Subject: Re: [PATCH v7 34/61] target/riscv: vector single-width floating-point
 fused multiply-add instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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

On Mon, Mar 30, 2020 at 9:45 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  49 +++++
>  target/riscv/insn32.decode              |  16 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  18 ++
>  target/riscv/vector_helper.c            | 251 ++++++++++++++++++++++++
>  4 files changed, 334 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 5b3340a4af..5cd1694412 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -851,3 +851,52 @@ DEF_HELPER_6(vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_6(vfmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfnmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 1d963f0b8a..c42bcd141c 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -463,6 +463,22 @@ vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
>  vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
>  vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
>  vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
> +vfmacc_vv       101100 . ..... ..... 001 ..... 1010111 @r_vm
> +vfnmacc_vv      101101 . ..... ..... 001 ..... 1010111 @r_vm
> +vfnmacc_vf      101101 . ..... ..... 101 ..... 1010111 @r_vm
> +vfmacc_vf       101100 . ..... ..... 101 ..... 1010111 @r_vm
> +vfmsac_vv       101110 . ..... ..... 001 ..... 1010111 @r_vm
> +vfmsac_vf       101110 . ..... ..... 101 ..... 1010111 @r_vm
> +vfnmsac_vv      101111 . ..... ..... 001 ..... 1010111 @r_vm
> +vfnmsac_vf      101111 . ..... ..... 101 ..... 1010111 @r_vm
> +vfmadd_vv       101000 . ..... ..... 001 ..... 1010111 @r_vm
> +vfmadd_vf       101000 . ..... ..... 101 ..... 1010111 @r_vm
> +vfnmadd_vv      101001 . ..... ..... 001 ..... 1010111 @r_vm
> +vfnmadd_vf      101001 . ..... ..... 101 ..... 1010111 @r_vm
> +vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
> +vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
> +vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
> +vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 5395063b1b..b2af9c314c 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2079,3 +2079,21 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
>  /* Vector Widening Floating-Point Multiply */
>  GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
>  GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
> +
> +/* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
> +GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfnmacc_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfmsac_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfnmsac_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfmadd_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfnmadd_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfmsub_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfnmsub_vv, opfvv_check)
> +GEN_OPFVF_TRANS(vfmacc_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfnmacc_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfmsac_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfnmsac_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfmadd_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfnmadd_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index bbe3719e69..016f49507e 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3431,3 +3431,254 @@ RVVCALL(OPFVF2, vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
>  RVVCALL(OPFVF2, vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
>  GEN_VEXT_VF(vfwmul_vf_h, 2, 4, clearl)
>  GEN_VEXT_VF(vfwmul_vf_w, 4, 8, clearq)
> +
> +/* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
> +#define OPFVV3(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)       \
> +static void do_##NAME(void *vd, void *vs1, void *vs2, int i,       \
> +        CPURISCVState *env)                                        \
> +{                                                                  \
> +    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
> +    TD d = *((TD *)vd + HD(i));                                    \
> +    *((TD *)vd + HD(i)) = OP(s2, s1, d, &env->fp_status);          \
> +}
> +
> +static uint16_t fmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
> +{
> +    return float16_muladd(a, b, d, 0, s);
> +}
> +
> +static uint32_t fmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(a, b, d, 0, s);
> +}
> +
> +static uint64_t fmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(a, b, d, 0, s);
> +}
> +
> +RVVCALL(OPFVV3, vfmacc_vv_h, OP_UUU_H, H2, H2, H2, fmacc16)
> +RVVCALL(OPFVV3, vfmacc_vv_w, OP_UUU_W, H4, H4, H4, fmacc32)
> +RVVCALL(OPFVV3, vfmacc_vv_d, OP_UUU_D, H8, H8, H8, fmacc64)
> +GEN_VEXT_VV_ENV(vfmacc_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfmacc_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfmacc_vv_d, 8, 8, clearq)
> +
> +#define OPFVF3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)           \
> +static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i,    \
> +        CPURISCVState *env)                                       \
> +{                                                                 \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                               \
> +    TD d = *((TD *)vd + HD(i));                                   \
> +    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d, &env->fp_status);\
> +}
> +
> +RVVCALL(OPFVF3, vfmacc_vf_h, OP_UUU_H, H2, H2, fmacc16)
> +RVVCALL(OPFVF3, vfmacc_vf_w, OP_UUU_W, H4, H4, fmacc32)
> +RVVCALL(OPFVF3, vfmacc_vf_d, OP_UUU_D, H8, H8, fmacc64)
> +GEN_VEXT_VF(vfmacc_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfmacc_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfmacc_vf_d, 8, 8, clearq)
> +
> +static uint16_t fnmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
> +{
> +    return float16_muladd(a, b, d,
> +            float_muladd_negate_c | float_muladd_negate_product, s);
> +}
> +
> +static uint32_t fnmacc32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(a, b, d,
> +            float_muladd_negate_c | float_muladd_negate_product, s);
> +}
> +
> +static uint64_t fnmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(a, b, d,
> +            float_muladd_negate_c | float_muladd_negate_product, s);
> +}
> +
> +RVVCALL(OPFVV3, vfnmacc_vv_h, OP_UUU_H, H2, H2, H2, fnmacc16)
> +RVVCALL(OPFVV3, vfnmacc_vv_w, OP_UUU_W, H4, H4, H4, fnmacc32)
> +RVVCALL(OPFVV3, vfnmacc_vv_d, OP_UUU_D, H8, H8, H8, fnmacc64)
> +GEN_VEXT_VV_ENV(vfnmacc_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfnmacc_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfnmacc_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF3, vfnmacc_vf_h, OP_UUU_H, H2, H2, fnmacc16)
> +RVVCALL(OPFVF3, vfnmacc_vf_w, OP_UUU_W, H4, H4, fnmacc32)
> +RVVCALL(OPFVF3, vfnmacc_vf_d, OP_UUU_D, H8, H8, fnmacc64)
> +GEN_VEXT_VF(vfnmacc_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfnmacc_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfnmacc_vf_d, 8, 8, clearq)
> +
> +static uint16_t fmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
> +{
> +    return float16_muladd(a, b, d, float_muladd_negate_c, s);
> +}
> +
> +static uint32_t fmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(a, b, d, float_muladd_negate_c, s);
> +}
> +
> +static uint64_t fmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(a, b, d, float_muladd_negate_c, s);
> +}
> +
> +RVVCALL(OPFVV3, vfmsac_vv_h, OP_UUU_H, H2, H2, H2, fmsac16)
> +RVVCALL(OPFVV3, vfmsac_vv_w, OP_UUU_W, H4, H4, H4, fmsac32)
> +RVVCALL(OPFVV3, vfmsac_vv_d, OP_UUU_D, H8, H8, H8, fmsac64)
> +GEN_VEXT_VV_ENV(vfmsac_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfmsac_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfmsac_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF3, vfmsac_vf_h, OP_UUU_H, H2, H2, fmsac16)
> +RVVCALL(OPFVF3, vfmsac_vf_w, OP_UUU_W, H4, H4, fmsac32)
> +RVVCALL(OPFVF3, vfmsac_vf_d, OP_UUU_D, H8, H8, fmsac64)
> +GEN_VEXT_VF(vfmsac_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfmsac_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfmsac_vf_d, 8, 8, clearq)
> +
> +static uint16_t fnmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
> +{
> +    return float16_muladd(a, b, d, float_muladd_negate_product, s);
> +}
> +
> +static uint32_t fnmsac32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(a, b, d, float_muladd_negate_product, s);
> +}
> +
> +static uint64_t fnmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(a, b, d, float_muladd_negate_product, s);
> +}
> +
> +RVVCALL(OPFVV3, vfnmsac_vv_h, OP_UUU_H, H2, H2, H2, fnmsac16)
> +RVVCALL(OPFVV3, vfnmsac_vv_w, OP_UUU_W, H4, H4, H4, fnmsac32)
> +RVVCALL(OPFVV3, vfnmsac_vv_d, OP_UUU_D, H8, H8, H8, fnmsac64)
> +GEN_VEXT_VV_ENV(vfnmsac_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfnmsac_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfnmsac_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF3, vfnmsac_vf_h, OP_UUU_H, H2, H2, fnmsac16)
> +RVVCALL(OPFVF3, vfnmsac_vf_w, OP_UUU_W, H4, H4, fnmsac32)
> +RVVCALL(OPFVF3, vfnmsac_vf_d, OP_UUU_D, H8, H8, fnmsac64)
> +GEN_VEXT_VF(vfnmsac_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfnmsac_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfnmsac_vf_d, 8, 8, clearq)
> +
> +static uint16_t fmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
> +{
> +    return float16_muladd(d, b, a, 0, s);
> +}
> +
> +static uint32_t fmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(d, b, a, 0, s);
> +}
> +
> +static uint64_t fmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(d, b, a, 0, s);
> +}
> +
> +RVVCALL(OPFVV3, vfmadd_vv_h, OP_UUU_H, H2, H2, H2, fmadd16)
> +RVVCALL(OPFVV3, vfmadd_vv_w, OP_UUU_W, H4, H4, H4, fmadd32)
> +RVVCALL(OPFVV3, vfmadd_vv_d, OP_UUU_D, H8, H8, H8, fmadd64)
> +GEN_VEXT_VV_ENV(vfmadd_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfmadd_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfmadd_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF3, vfmadd_vf_h, OP_UUU_H, H2, H2, fmadd16)
> +RVVCALL(OPFVF3, vfmadd_vf_w, OP_UUU_W, H4, H4, fmadd32)
> +RVVCALL(OPFVF3, vfmadd_vf_d, OP_UUU_D, H8, H8, fmadd64)
> +GEN_VEXT_VF(vfmadd_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfmadd_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfmadd_vf_d, 8, 8, clearq)
> +
> +static uint16_t fnmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
> +{
> +    return float16_muladd(d, b, a,
> +            float_muladd_negate_c | float_muladd_negate_product, s);
> +}
> +
> +static uint32_t fnmadd32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(d, b, a,
> +            float_muladd_negate_c | float_muladd_negate_product, s);
> +}
> +
> +static uint64_t fnmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(d, b, a,
> +            float_muladd_negate_c | float_muladd_negate_product, s);
> +}
> +
> +RVVCALL(OPFVV3, vfnmadd_vv_h, OP_UUU_H, H2, H2, H2, fnmadd16)
> +RVVCALL(OPFVV3, vfnmadd_vv_w, OP_UUU_W, H4, H4, H4, fnmadd32)
> +RVVCALL(OPFVV3, vfnmadd_vv_d, OP_UUU_D, H8, H8, H8, fnmadd64)
> +GEN_VEXT_VV_ENV(vfnmadd_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfnmadd_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfnmadd_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF3, vfnmadd_vf_h, OP_UUU_H, H2, H2, fnmadd16)
> +RVVCALL(OPFVF3, vfnmadd_vf_w, OP_UUU_W, H4, H4, fnmadd32)
> +RVVCALL(OPFVF3, vfnmadd_vf_d, OP_UUU_D, H8, H8, fnmadd64)
> +GEN_VEXT_VF(vfnmadd_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfnmadd_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfnmadd_vf_d, 8, 8, clearq)
> +
> +static uint16_t fmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
> +{
> +    return float16_muladd(d, b, a, float_muladd_negate_c, s);
> +}
> +
> +static uint32_t fmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(d, b, a, float_muladd_negate_c, s);
> +}
> +
> +static uint64_t fmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(d, b, a, float_muladd_negate_c, s);
> +}
> +
> +RVVCALL(OPFVV3, vfmsub_vv_h, OP_UUU_H, H2, H2, H2, fmsub16)
> +RVVCALL(OPFVV3, vfmsub_vv_w, OP_UUU_W, H4, H4, H4, fmsub32)
> +RVVCALL(OPFVV3, vfmsub_vv_d, OP_UUU_D, H8, H8, H8, fmsub64)
> +GEN_VEXT_VV_ENV(vfmsub_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfmsub_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfmsub_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF3, vfmsub_vf_h, OP_UUU_H, H2, H2, fmsub16)
> +RVVCALL(OPFVF3, vfmsub_vf_w, OP_UUU_W, H4, H4, fmsub32)
> +RVVCALL(OPFVF3, vfmsub_vf_d, OP_UUU_D, H8, H8, fmsub64)
> +GEN_VEXT_VF(vfmsub_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfmsub_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfmsub_vf_d, 8, 8, clearq)
> +
> +static uint16_t fnmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
> +{
> +    return float16_muladd(d, b, a, float_muladd_negate_product, s);
> +}
> +
> +static uint32_t fnmsub32(uint32_t a, uint32_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(d, b, a, float_muladd_negate_product, s);
> +}
> +
> +static uint64_t fnmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(d, b, a, float_muladd_negate_product, s);
> +}
> +
> +RVVCALL(OPFVV3, vfnmsub_vv_h, OP_UUU_H, H2, H2, H2, fnmsub16)
> +RVVCALL(OPFVV3, vfnmsub_vv_w, OP_UUU_W, H4, H4, H4, fnmsub32)
> +RVVCALL(OPFVV3, vfnmsub_vv_d, OP_UUU_D, H8, H8, H8, fnmsub64)
> +GEN_VEXT_VV_ENV(vfnmsub_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfnmsub_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfnmsub_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF3, vfnmsub_vf_h, OP_UUU_H, H2, H2, fnmsub16)
> +RVVCALL(OPFVF3, vfnmsub_vf_w, OP_UUU_W, H4, H4, fnmsub32)
> +RVVCALL(OPFVF3, vfnmsub_vf_d, OP_UUU_D, H8, H8, fnmsub64)
> +GEN_VEXT_VF(vfnmsub_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfnmsub_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfnmsub_vf_d, 8, 8, clearq)
> --
> 2.23.0
>

