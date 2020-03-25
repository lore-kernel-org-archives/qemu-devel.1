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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A5C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811BA20774
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h68cwDYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811BA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHAJW-0004Z7-LI
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHAFx-0008UD-OG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHAFw-0000QY-Dx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:55:57 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:39431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHAFw-0000QN-9d; Wed, 25 Mar 2020 13:55:56 -0400
Received: by mail-vs1-xe43.google.com with SMTP id j128so2088508vsd.6;
 Wed, 25 Mar 2020 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hb41Uu9X+qdK+JM63ddY79ni7JfY01j0661vSqrp/JM=;
 b=h68cwDYeO8roMKfbD0BJxpHIPmOM69JncIw6hUCgZQkiqwfEBrDGHwRekOCBoyz2N7
 9scRL+CDDqf2MTJXZXFazZAduOaoFKo0Fr8ZkzC/nqctZtSMPRJejjsPJKZlJDH3mg7C
 /f0nFYz1KNXb4F4t8Ah8YctTVqY4t403K8N9ko0or+HLTB8rZ3cdW+xxrpjCGKb4QXIj
 sE6g1E+mrErfM9EEkhHvW4Glvry1+98KlPVffkiI/wzE8lYI5VU29jcv/LPDdpW7ThdJ
 wTaAmcpQ4L4fc7xxb5Le2S9fzjDE+FgAlBufqKjREsLz0ev0pxDtVOmTCcpTGEi6B5Iz
 XOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hb41Uu9X+qdK+JM63ddY79ni7JfY01j0661vSqrp/JM=;
 b=W6hbkNUKj3gFiAtZGvf6HXXn6tAmSqLKe3FfOoEo14ilpWc6ZYhfAFpNuchDkpapUo
 J7EvQ6827gt1eMfYJ6ovRHslvcVkP3lxYxBVzWOqm6d73oqrWim1FC+k9WpiplgsO2KF
 vdD6AY7d4oC1g04IRUHNHBv7IeThMEvSJDwRgl4rELuHToz+EC2m2ZvR2P4poFiTadTZ
 U3/nX86lig0nHqkal7SIiH6+d3b9E8EXV8x8pTDgnVxznvPoT+q0jzIhJ62E9AgT6+e1
 VxLqHRevuJdFYy2ntI8a5Qa5j0i219KzhZGOGUcjnGtiSv5pJ/5DKS1hkk+H+CIv7oXt
 LOeQ==
X-Gm-Message-State: ANhLgQ2YegcGe4i+grKTNTJDwOlZxdYcxqfkGynAEr6r1LMkfF8jjU0l
 rnmK2tLuKaqabcdN1i26ycBBezhx91qq43z1GFc=
X-Google-Smtp-Source: ADFU+vt5unbIpI5fcJsfTtsLOkOTbmI2DJIvyRkn80JKIE5ja80hlmIkvoQxy/ybHwh/wwnniJWSa3HpIFL5SR2AZEA=
X-Received: by 2002:a67:8a88:: with SMTP id m130mr3662851vsd.70.1585158955633; 
 Wed, 25 Mar 2020 10:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-38-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-38-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 10:47:56 -0700
Message-ID: <CAKmqyKMKGUuD=YVMZTpEWjCgESOZdSyFDPN8XmUispbjT4rUow@mail.gmail.com>
Subject: Re: [PATCH v6 37/61] target/riscv: vector floating-point min/max
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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

On Tue, Mar 17, 2020 at 9:21 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 13 ++++++++++++
>  target/riscv/insn32.decode              |  4 ++++
>  target/riscv/insn_trans/trans_rvv.inc.c |  6 ++++++
>  target/riscv/vector_helper.c            | 27 +++++++++++++++++++++++++
>  4 files changed, 50 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index a5d3a5a832..47d91933de 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -917,3 +917,16 @@ DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_5(vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
> +
> +DEF_HELPER_6(vfmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfmin_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmin_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 4ea71eaf39..5ec5595e2c 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -490,6 +490,10 @@ vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
>  vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
>  vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
>  vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
> +vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
> +vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
> +vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
> +vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index bea126c07b..0c00d44e21 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1986,3 +1986,9 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>      return false;                                                  \
>  }
>  GEN_OPFV_TRANS(vfsqrt_v, opfv_check)
> +
> +/* Vector Floating-Point MIN/MAX Instructions */
> +GEN_OPFVV_TRANS(vfmin_vv, opfvv_check)
> +GEN_OPFVV_TRANS(vfmax_vv, opfvv_check)
> +GEN_OPFVF_TRANS(vfmin_vf, opfvf_check)
> +GEN_OPFVF_TRANS(vfmax_vf, opfvf_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 342ba0c196..f80b522c47 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3768,3 +3768,30 @@ RVVCALL(OPFVV1, vfsqrt_v_d, OP_UU_D, H8, H8, float64_sqrt)
>  GEN_VEXT_V_ENV(vfsqrt_v_h, 2, 2, clearh)
>  GEN_VEXT_V_ENV(vfsqrt_v_w, 4, 4, clearl)
>  GEN_VEXT_V_ENV(vfsqrt_v_d, 8, 8, clearq)
> +
> +/* Vector Floating-Point MIN/MAX Instructions */
> +RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minnum)
> +RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minnum)
> +RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minnum)
> +GEN_VEXT_VV_ENV(vfmin_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfmin_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfmin_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minnum)
> +RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minnum)
> +RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minnum)
> +GEN_VEXT_VF(vfmin_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfmin_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfmin_vf_d, 8, 8, clearq)
> +
> +RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maxnum)
> +RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maxnum)
> +RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maxnum)
> +GEN_VEXT_VV_ENV(vfmax_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfmax_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfmax_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maxnum)
> +RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maxnum)
> +RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maxnum)
> +GEN_VEXT_VF(vfmax_vf_h, 2, 2, clearh)
> +GEN_VEXT_VF(vfmax_vf_w, 4, 4, clearl)
> +GEN_VEXT_VF(vfmax_vf_d, 8, 8, clearq)
> --
> 2.23.0
>

