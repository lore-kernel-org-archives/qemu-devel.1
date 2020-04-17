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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFCAC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727ED20776
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmALFK+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727ED20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZPR-0003Zm-Jt
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZNy-0002fL-Lk
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZNx-0003N1-12
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:22:58 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZNw-0003Kg-R0; Fri, 17 Apr 2020 18:22:56 -0400
Received: by mail-io1-xd41.google.com with SMTP id i3so4055381ioo.13;
 Fri, 17 Apr 2020 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yci4dGcm4um/vtAgvtXC7THuPPQi/0cF/TuiO5+jZzk=;
 b=ZmALFK+iLgrsfMoKQDsA5CF3Zouy2hvrE8Uw8a1oelbkxUMrPMdBNZu5KSkSux+AlW
 kM7dDxM4Whg/7xt+IelPwYnNjbO7aYzOznsgIV2GA3ePc0iU+w/CgYCPecXuqDfSX3lQ
 k3Za6sezvHauw2BbOzuzV2qRD2Ot1BtuGwapx4a6qfGmlr6Ingg29h2UC8guiHOD6pdl
 9lTEaWsOTgc30zDGtlKCyzsvS915QYxcwYgn64Ee7XNlSPnlBwYxP8KJPbCqk0wf4+iy
 aYqVofXZMM4GdIDbWlTtWvAGnbJJTEKK8biVB+T+JRiDT9JmrYRQ1o71riDsWuVOeymM
 Iiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yci4dGcm4um/vtAgvtXC7THuPPQi/0cF/TuiO5+jZzk=;
 b=TTQnsIXQEDEvPkkMdhDJdZNuWVSnhIVyM+mNjCHqTqU+pmfViyi8Ac6oNW25Lyfnp9
 BUeHIb4+0O9YXwd2pR8pwYQ388gKRg0yYANz36XAf2GqOOsmjhp9gXsqCxbXsazegyn1
 sJxMskmW3DlIhQa5a6/dH1+mphTNABGKOz/qSBndzyIkemfa7yIZURsg48wpnAqwnbkn
 P8G2F+dBbqSv2M+e9DN/aCvIvmMJIlzXR61qrV/xjci1a498jVW4bfPqj6UcT60ijzhQ
 5XQAAvQBRyhKQtsuLcTsNUgT1SFWcAODt0QhG6swTIUJ6S+z6d3ODYPjGjenLJ5146Pe
 /emg==
X-Gm-Message-State: AGi0PubufFCxrOCsbTSrugspPCO88v2IcFbci5ecwKnudAjS1BgdgOaK
 LPqicBQDjKjRf6rQ6N1PujItEILKjLc8arXUlVM=
X-Google-Smtp-Source: APiQypImW02oTGM3nK/Gc83srFImA520CuJ0W4i4cu0VKeoJeYlETGxaK/MgsplmlNMjy0ynv1Ot8+BsLPpN9Proezs=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr2068920iol.105.1587162175826; 
 Fri, 17 Apr 2020 15:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-39-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-39-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 15:14:32 -0700
Message-ID: <CAKmqyKMuxjsjFJV9y3pNP7DaTVCXH8LKC-Mxv933Q4nb3WoX0Q@mail.gmail.com>
Subject: Re: [PATCH v7 38/61] target/riscv: vector floating-point
 sign-injection instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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

On Mon, Mar 30, 2020 at 9:53 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 19 ++++++
>  target/riscv/insn32.decode              |  6 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  8 +++
>  target/riscv/vector_helper.c            | 85 +++++++++++++++++++++++++
>  4 files changed, 118 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 12d959ba0d..d6e7ce57be 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -934,3 +934,22 @@ DEF_HELPER_6(vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_6(vfsgnj_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnj_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnj_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjn_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjn_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjn_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjx_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjx_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjx_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfsgnj_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsgnj_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsgnj_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjn_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjn_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjn_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 5ec5595e2c..ce2f497ed2 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -494,6 +494,12 @@ vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
>  vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
>  vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
>  vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
> +vfsgnj_vv       001000 . ..... ..... 001 ..... 1010111 @r_vm
> +vfsgnj_vf       001000 . ..... ..... 101 ..... 1010111 @r_vm
> +vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
> +vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
> +vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
> +vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index ea00e2dfb0..4963004dd4 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2155,3 +2155,11 @@ GEN_OPFVV_TRANS(vfmin_vv, opfvv_check)
>  GEN_OPFVV_TRANS(vfmax_vv, opfvv_check)
>  GEN_OPFVF_TRANS(vfmin_vf, opfvf_check)
>  GEN_OPFVF_TRANS(vfmax_vf, opfvf_check)
> +
> +/* Vector Floating-Point Sign-Injection Instructions */
> +GEN_OPFVV_TRANS(vfsgnj_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfsgnjn_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfsgnjx_vv, opfvv_check)
> +GEN_OPFVF_TRANS(vfsgnj_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfsgnjn_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a2c427b26c..3f01fdd83c 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3843,3 +3843,88 @@ RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
>  GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
>  GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
>  GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)
> +
> +/* Vector Floating-Point Sign-Injection Instructions */
> +static uint16_t fsgnj16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    return deposit64(b, 0, 15, a);
> +}
> +
> +static uint32_t fsgnj32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    return deposit64(b, 0, 31, a);
> +}
> +
> +static uint64_t fsgnj64(uint64_t a, uint64_t b, float_status *s)
> +{
> +    return deposit64(b, 0, 63, a);
> +}
> +
> +RVVCALL(OPFVV2, vfsgnj_vv_h, OP_UUU_H, H2, H2, H2, fsgnj16)
> +RVVCALL(OPFVV2, vfsgnj_vv_w, OP_UUU_W, H4, H4, H4, fsgnj32)
> +RVVCALL(OPFVV2, vfsgnj_vv_d, OP_UUU_D, H8, H8, H8, fsgnj64)
> +GEN_VEXT_VV_ENV(vfsgnj_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfsgnj_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfsgnj_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfsgnj_vf_h, OP_UUU_H, H2, H2, fsgnj16)
> +RVVCALL(OPFVF2, vfsgnj_vf_w, OP_UUU_W, H4, H4, fsgnj32)
> +RVVCALL(OPFVF2, vfsgnj_vf_d, OP_UUU_D, H8, H8, fsgnj64)
> +GEN_VEXT_VF(vfsgnj_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfsgnj_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfsgnj_vf_d, 8, 8, clearq)
> +
> +static uint16_t fsgnjn16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    return deposit64(~b, 0, 15, a);
> +}
> +
> +static uint32_t fsgnjn32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    return deposit64(~b, 0, 31, a);
> +}
> +
> +static uint64_t fsgnjn64(uint64_t a, uint64_t b, float_status *s)
> +{
> +    return deposit64(~b, 0, 63, a);
> +}
> +
> +RVVCALL(OPFVV2, vfsgnjn_vv_h, OP_UUU_H, H2, H2, H2, fsgnjn16)
> +RVVCALL(OPFVV2, vfsgnjn_vv_w, OP_UUU_W, H4, H4, H4, fsgnjn32)
> +RVVCALL(OPFVV2, vfsgnjn_vv_d, OP_UUU_D, H8, H8, H8, fsgnjn64)
> +GEN_VEXT_VV_ENV(vfsgnjn_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfsgnjn_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfsgnjn_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfsgnjn_vf_h, OP_UUU_H, H2, H2, fsgnjn16)
> +RVVCALL(OPFVF2, vfsgnjn_vf_w, OP_UUU_W, H4, H4, fsgnjn32)
> +RVVCALL(OPFVF2, vfsgnjn_vf_d, OP_UUU_D, H8, H8, fsgnjn64)
> +GEN_VEXT_VF(vfsgnjn_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfsgnjn_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfsgnjn_vf_d, 8, 8, clearq)
> +
> +static uint16_t fsgnjx16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    return deposit64(b ^ a, 0, 15, a);
> +}
> +
> +static uint32_t fsgnjx32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    return deposit64(b ^ a, 0, 31, a);
> +}
> +
> +static uint64_t fsgnjx64(uint64_t a, uint64_t b, float_status *s)
> +{
> +    return deposit64(b ^ a, 0, 63, a);
> +}
> +
> +RVVCALL(OPFVV2, vfsgnjx_vv_h, OP_UUU_H, H2, H2, H2, fsgnjx16)
> +RVVCALL(OPFVV2, vfsgnjx_vv_w, OP_UUU_W, H4, H4, H4, fsgnjx32)
> +RVVCALL(OPFVV2, vfsgnjx_vv_d, OP_UUU_D, H8, H8, H8, fsgnjx64)
> +GEN_VEXT_VV_ENV(vfsgnjx_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfsgnjx_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfsgnjx_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfsgnjx_vf_h, OP_UUU_H, H2, H2, fsgnjx16)
> +RVVCALL(OPFVF2, vfsgnjx_vf_w, OP_UUU_W, H4, H4, fsgnjx32)
> +RVVCALL(OPFVF2, vfsgnjx_vf_d, OP_UUU_D, H8, H8, fsgnjx64)
> +GEN_VEXT_VF(vfsgnjx_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfsgnjx_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
> --
> 2.23.0
>

