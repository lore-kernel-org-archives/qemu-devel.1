Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE93FC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8F8206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skBqPPnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8F8206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHAFj-0007o9-TD
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHAEm-0007Cu-Jh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHAEk-00086C-Mr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:54:44 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:38180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHAEk-000863-Gl; Wed, 25 Mar 2020 13:54:42 -0400
Received: by mail-vk1-xa44.google.com with SMTP id n128so931872vke.5;
 Wed, 25 Mar 2020 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EiSgyS+F8Ki0Ro1Uai+PKS6+aeJI7JrkE0o6rIN8NDE=;
 b=skBqPPnbeO4UgXfF5KO+StHxAz4R17V08+6ZajmfzRiim8YypdQEo/TFgnhvNWX67a
 GafbC5R++TePcZmumsxH2hugyg9KbXuFz11Z2EyAne5dFJ1sPTlODMFcdwrAGqVV7HCp
 bJSyBXPxUAKrAHBoOPo7VoH+CKztd0tvPG8bTS4J42oTeQMo3L8alh6iSOSqRc+CKq8c
 JNa6CaOHaF+IQvTl1npOdh1FMsaPOc5+1a0NAUApI9Xzufwgti2F1OL06m960ZvbElWg
 0lNWWWX7CVmwcxMboOr+ccLCzuQkKv137HDhIWlTh8vB2//SvScOjU9WrLO7CXKkqu5i
 4xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EiSgyS+F8Ki0Ro1Uai+PKS6+aeJI7JrkE0o6rIN8NDE=;
 b=gPD2u3BE/PVi/GgVqsZR1IahU0iIBIQjc/S1bC1zHiAzTZH40hxN51m6hHbswMabm2
 hftA7LbcwWizyxKHN1Q4qhN9edt1tTuyA5wJpqkY9DeiMrdzHSLH4FoYRof2R19OEaR/
 cqvyoDD9hJOIZyfISXzUmTBLJ5Rf49G5tE3WIshXfELs5Auz9eblR6Uqlph/qGVizu/j
 Q9RV8x28uAZcwh71lW9NXZaATBheNtE4nq/xu26oSF+fGFS8pr3jn3UFRBkY01TxAm+t
 AnhUbsLvVw6gqkRj3yuc7t1Jd99CBj3LZ24xRcwRAjifYmtKsURIDHc1FAxft31wzBJ7
 ztEg==
X-Gm-Message-State: ANhLgQ1/ftb/k+76lDdr8UmRTenWej6eXaLNCoL1VU2jI7rCFZC5IdQb
 MJ3Fs69JphVwDQFOBBEH7WRFZ/ACAcztQXqA4v1VMf3g
X-Google-Smtp-Source: ADFU+vtPvedJqfFFMMe3N3z0DYfK/U2W1xMU0vdxpn6+F5cse5Ke9lC+MMFC7IzFd7ACsiA6XkUuwMVi9jqKZyPtauw=
X-Received: by 2002:a1f:5e0a:: with SMTP id s10mr3380314vkb.37.1585158881558; 
 Wed, 25 Mar 2020 10:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-33-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-33-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 10:46:42 -0700
Message-ID: <CAKmqyKMBOsiuMwBEo2GCARvJqDmvRJ9ec5ie-ZghHoUAEg_q7Q@mail.gmail.com>
Subject: Re: [PATCH v6 32/61] target/riscv: vector single-width floating-point
 multiply/divide instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a44
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

On Tue, Mar 17, 2020 at 9:11 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 16 +++++++++
>  target/riscv/insn32.decode              |  5 +++
>  target/riscv/insn_trans/trans_rvv.inc.c |  7 ++++
>  target/riscv/vector_helper.c            | 48 +++++++++++++++++++++++++
>  4 files changed, 76 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 384d661283..abd0bbd2fc 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -826,3 +826,19 @@ DEF_HELPER_6(vfwadd_wf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfwadd_wf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfwsub_wf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfwsub_wf_w, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_6(vfmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmul_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfrdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfrdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfrdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 68e9448842..16fd938261 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -456,6 +456,11 @@ vfwsub_vv       110010 . ..... ..... 001 ..... 1010111 @r_vm
>  vfwsub_vf       110010 . ..... ..... 101 ..... 1010111 @r_vm
>  vfwsub_wv       110110 . ..... ..... 001 ..... 1010111 @r_vm
>  vfwsub_wf       110110 . ..... ..... 101 ..... 1010111 @r_vm
> +vfmul_vv        100100 . ..... ..... 001 ..... 1010111 @r_vm
> +vfmul_vf        100100 . ..... ..... 101 ..... 1010111 @r_vm
> +vfdiv_vv        100000 . ..... ..... 001 ..... 1010111 @r_vm
> +vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
> +vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 5ec5debc09..f6864b42bb 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1910,3 +1910,10 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
>  }
>  GEN_OPFWF_WIDEN_TRANS(vfwadd_wf)
>  GEN_OPFWF_WIDEN_TRANS(vfwsub_wf)
> +
> +/* Vector Single-Width Floating-Point Multiply/Divide Instructions */
> +GEN_OPFVV_TRANS(vfmul_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfdiv_vv, opfvv_check)
> +GEN_OPFVF_TRANS(vfmul_vf,  opfvf_check)
> +GEN_OPFVF_TRANS(vfdiv_vf,  opfvf_check)
> +GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 16ba9148fb..f5f5897d12 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3343,3 +3343,51 @@ RVVCALL(OPFVF2, vfwsub_wf_h, WOP_WUUU_H, H4, H2, vfwsubw16)
>  RVVCALL(OPFVF2, vfwsub_wf_w, WOP_WUUU_W, H8, H4, vfwsubw32)
>  GEN_VEXT_VF(vfwsub_wf_h, 2, 4, clearl)
>  GEN_VEXT_VF(vfwsub_wf_w, 4, 8, clearq)
> +
> +/* Vector Single-Width Floating-Point Multiply/Divide Instructions */
> +RVVCALL(OPFVV2, vfmul_vv_h, OP_UUU_H, H2, H2, H2, float16_mul)
> +RVVCALL(OPFVV2, vfmul_vv_w, OP_UUU_W, H4, H4, H4, float32_mul)
> +RVVCALL(OPFVV2, vfmul_vv_d, OP_UUU_D, H8, H8, H8, float64_mul)
> +GEN_VEXT_VV_ENV(vfmul_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfmul_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfmul_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfmul_vf_h, OP_UUU_H, H2, H2, float16_mul)
> +RVVCALL(OPFVF2, vfmul_vf_w, OP_UUU_W, H4, H4, float32_mul)
> +RVVCALL(OPFVF2, vfmul_vf_d, OP_UUU_D, H8, H8, float64_mul)
> +GEN_VEXT_VF(vfmul_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfmul_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfmul_vf_d, 8, 8, clearq)
> +
> +RVVCALL(OPFVV2, vfdiv_vv_h, OP_UUU_H, H2, H2, H2, float16_div)
> +RVVCALL(OPFVV2, vfdiv_vv_w, OP_UUU_W, H4, H4, H4, float32_div)
> +RVVCALL(OPFVV2, vfdiv_vv_d, OP_UUU_D, H8, H8, H8, float64_div)
> +GEN_VEXT_VV_ENV(vfdiv_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfdiv_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfdiv_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfdiv_vf_h, OP_UUU_H, H2, H2, float16_div)
> +RVVCALL(OPFVF2, vfdiv_vf_w, OP_UUU_W, H4, H4, float32_div)
> +RVVCALL(OPFVF2, vfdiv_vf_d, OP_UUU_D, H8, H8, float64_div)
> +GEN_VEXT_VF(vfdiv_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfdiv_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfdiv_vf_d, 8, 8, clearq)
> +
> +static uint16_t float16_rdiv(uint16_t a, uint16_t b, float_status *s)
> +{
> +    return float16_div(b, a, s);
> +}
> +
> +static uint32_t float32_rdiv(uint32_t a, uint32_t b, float_status *s)
> +{
> +    return float32_div(b, a, s);
> +}
> +
> +static uint64_t float64_rdiv(uint64_t a, uint64_t b, float_status *s)
> +{
> +    return float64_div(b, a, s);
> +}
> +RVVCALL(OPFVF2, vfrdiv_vf_h, OP_UUU_H, H2, H2, float16_rdiv)
> +RVVCALL(OPFVF2, vfrdiv_vf_w, OP_UUU_W, H4, H4, float32_rdiv)
> +RVVCALL(OPFVF2, vfrdiv_vf_d, OP_UUU_D, H8, H8, float64_rdiv)
> +GEN_VEXT_VF(vfrdiv_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfrdiv_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfrdiv_vf_d, 8, 8, clearq)
> --
> 2.23.0
>

