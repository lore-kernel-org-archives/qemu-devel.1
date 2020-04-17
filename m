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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B20C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37015221E9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9qXnx7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37015221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZMM-0001Es-D2
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZKk-0000Y2-Jy
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZKi-0006j0-Q3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:19:38 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:39609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZKi-0006gK-JN; Fri, 17 Apr 2020 18:19:36 -0400
Received: by mail-il1-x142.google.com with SMTP id c17so3730356ilk.6;
 Fri, 17 Apr 2020 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p6N3kwhIh8wQqpJH65UQ6WUXdwXb8aMZTYWyH7oRBwo=;
 b=C9qXnx7AFF2BiWgiyzE6Vkib1fnIR/eFmUBS0gQ/BoXuUxhqHYLmNNE7tLXFPDuAYa
 VfAxTw8Qm37At9cnTndcx1vdx+Pi9NHZndnCOL0JwrhLARQ7SINqkWY8aKs+FWswLCb9
 jsd3DcUg4ZtQ7CZnuWQTFGTsh1DUB9aS2faNa4MQxBqz0bUjnrsyiviRoop/eDYahggM
 ixNLcfhO64t6bv5TL6+/vN3b/l04OnljVxHh6sA2UQWZKpHbVMTLwlQLQdM33u5W+n0Z
 6YlliUkSsO1b2Psv8egyMytQthcqKZv0ATNIeYdugFoKS0Qx5K3heg2sxZGTdyGgXUQQ
 ThSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p6N3kwhIh8wQqpJH65UQ6WUXdwXb8aMZTYWyH7oRBwo=;
 b=UwLUMyv4bQ50uUaqT+1fmNuzYUFZcTr7Kcu/3XB27dQd4Aice94qRAx22TMKIU/Ta8
 ITQ7vtCcQqRkRBbMzjc5qVBr0rGAUhHWsDbSCRActI+BhdktTr5EztQzob/M/+65ZlPD
 gbVrD4OgjRXxLQosc2epETjnKBSXEzOHOYWgVTPgUJ/i4Ix9vineQhBUSNnB3+QvRNhW
 at4aW85u62HVcIPulzVCOVGwzjN+VoRrT1ycM3vnIKSotuXu8q/GD35M/v0uxq2Pa4Ve
 0lmkjMlfA8WfFSUK9Wfnof7a3XGh08Zvt0Tkr8HMq4zFct78BawaT0jgCNbnvlUnM272
 GgHg==
X-Gm-Message-State: AGi0PuYsBgYKZJjgU7Cl4LfInRhifrZIcJaDTL2pPpzmOIae1qv3jrD+
 /0tQ3116M75FDWYvcGCmQu7GlatM47jeZUSNH0un7otA
X-Google-Smtp-Source: APiQypLxSgKrufUwBydgOWYJlpx/4yMeYa1yQnhrovj7k/5qToNI58E+7yl0u1UbAj5Unys7YETiYUXRmUtWelBRIH8=
X-Received: by 2002:a92:79cc:: with SMTP id u195mr5427853ilc.131.1587161974574; 
 Fri, 17 Apr 2020 15:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-36-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-36-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 15:11:11 -0700
Message-ID: <CAKmqyKNysd5qYHJEYDVizC33uf1Pb_TJ3DGWqJrjsUg1tkr=0g@mail.gmail.com>
Subject: Re: [PATCH v7 35/61] target/riscv: vector widening floating-point
 fused multiply-add instructions
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

On Mon, Mar 30, 2020 at 9:47 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 17 +++++
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 10 +++
>  target/riscv/vector_helper.c            | 91 +++++++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 5cd1694412..edf963e787 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -900,3 +900,20 @@ DEF_HELPER_6(vfmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfnmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfnmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfnmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_6(vfwmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index c42bcd141c..56bfd4a919 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -479,6 +479,14 @@ vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
>  vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
>  vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
>  vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwmacc_vv      111100 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwmacc_vf      111100 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwnmacc_vv     111101 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwnmacc_vf     111101 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
> +vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
> +vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index b2af9c314c..5e08c7133c 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2097,3 +2097,13 @@ GEN_OPFVF_TRANS(vfmadd_vf, opfvf_check)
>  GEN_OPFVF_TRANS(vfnmadd_vf, opfvf_check)
>  GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
>  GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
> +
> +/* Vector Widening Floating-Point Fused Multiply-Add Instructions */
> +GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
> +GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
> +GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
> +GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
> +GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
> +GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 016f49507e..171252fb69 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3682,3 +3682,94 @@ RVVCALL(OPFVF3, vfnmsub_vf_d, OP_UUU_D, H8, H8, fnmsub64)
>  GEN_VEXT_VF(vfnmsub_vf_h, 2, 2, clearh)
>  GEN_VEXT_VF(vfnmsub_vf_w, 4, 4, clearl)
>  GEN_VEXT_VF(vfnmsub_vf_d, 8, 8, clearq)
> +
> +/* Vector Widening Floating-Point Fused Multiply-Add Instructions */
> +static uint32_t fwmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(float16_to_float32(a, true, s),
> +                        float16_to_float32(b, true, s), d, 0, s);
> +}
> +
> +static uint64_t fwmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(float32_to_float64(a, s),
> +                        float32_to_float64(b, s), d, 0, s);
> +}
> +
> +RVVCALL(OPFVV3, vfwmacc_vv_h, WOP_UUU_H, H4, H2, H2, fwmacc16)
> +RVVCALL(OPFVV3, vfwmacc_vv_w, WOP_UUU_W, H8, H4, H4, fwmacc32)
> +GEN_VEXT_VV_ENV(vfwmacc_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwmacc_vv_w, 4, 8, clearq)
> +RVVCALL(OPFVF3, vfwmacc_vf_h, WOP_UUU_H, H4, H2, fwmacc16)
> +RVVCALL(OPFVF3, vfwmacc_vf_w, WOP_UUU_W, H8, H4, fwmacc32)
> +GEN_VEXT_VF(vfwmacc_vf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwmacc_vf_w, 4, 8, clearq)
> +
> +static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(float16_to_float32(a, true, s),
> +                        float16_to_float32(b, true, s), d,
> +                        float_muladd_negate_c | float_muladd_negate_product, s);
> +}
> +
> +static uint64_t fwnmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(float32_to_float64(a, s),
> +                        float32_to_float64(b, s), d,
> +                        float_muladd_negate_c | float_muladd_negate_product, s);
> +}
> +
> +RVVCALL(OPFVV3, vfwnmacc_vv_h, WOP_UUU_H, H4, H2, H2, fwnmacc16)
> +RVVCALL(OPFVV3, vfwnmacc_vv_w, WOP_UUU_W, H8, H4, H4, fwnmacc32)
> +GEN_VEXT_VV_ENV(vfwnmacc_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwnmacc_vv_w, 4, 8, clearq)
> +RVVCALL(OPFVF3, vfwnmacc_vf_h, WOP_UUU_H, H4, H2, fwnmacc16)
> +RVVCALL(OPFVF3, vfwnmacc_vf_w, WOP_UUU_W, H8, H4, fwnmacc32)
> +GEN_VEXT_VF(vfwnmacc_vf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwnmacc_vf_w, 4, 8, clearq)
> +
> +static uint32_t fwmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(float16_to_float32(a, true, s),
> +                        float16_to_float32(b, true, s), d,
> +                        float_muladd_negate_c, s);
> +}
> +
> +static uint64_t fwmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(float32_to_float64(a, s),
> +                        float32_to_float64(b, s), d,
> +                        float_muladd_negate_c, s);
> +}
> +
> +RVVCALL(OPFVV3, vfwmsac_vv_h, WOP_UUU_H, H4, H2, H2, fwmsac16)
> +RVVCALL(OPFVV3, vfwmsac_vv_w, WOP_UUU_W, H8, H4, H4, fwmsac32)
> +GEN_VEXT_VV_ENV(vfwmsac_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwmsac_vv_w, 4, 8, clearq)
> +RVVCALL(OPFVF3, vfwmsac_vf_h, WOP_UUU_H, H4, H2, fwmsac16)
> +RVVCALL(OPFVF3, vfwmsac_vf_w, WOP_UUU_W, H8, H4, fwmsac32)
> +GEN_VEXT_VF(vfwmsac_vf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwmsac_vf_w, 4, 8, clearq)
> +
> +static uint32_t fwnmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
> +{
> +    return float32_muladd(float16_to_float32(a, true, s),
> +                        float16_to_float32(b, true, s), d,
> +                        float_muladd_negate_product, s);
> +}
> +
> +static uint64_t fwnmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
> +{
> +    return float64_muladd(float32_to_float64(a, s),
> +                        float32_to_float64(b, s), d,
> +                        float_muladd_negate_product, s);
> +}
> +
> +RVVCALL(OPFVV3, vfwnmsac_vv_h, WOP_UUU_H, H4, H2, H2, fwnmsac16)
> +RVVCALL(OPFVV3, vfwnmsac_vv_w, WOP_UUU_W, H8, H4, H4, fwnmsac32)
> +GEN_VEXT_VV_ENV(vfwnmsac_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV_ENV(vfwnmsac_vv_w, 4, 8, clearq)
> +RVVCALL(OPFVF3, vfwnmsac_vf_h, WOP_UUU_H, H4, H2, fwnmsac16)
> +RVVCALL(OPFVF3, vfwnmsac_vf_w, WOP_UUU_W, H8, H4, fwnmsac32)
> +GEN_VEXT_VF(vfwnmsac_vf_h, 2, 4, clearl)
> +GEN_VEXT_VF(vfwnmsac_vf_w, 4, 8, clearq)
> --
> 2.23.0
>

