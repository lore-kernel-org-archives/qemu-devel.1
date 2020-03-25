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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0FC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1E020740
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5pyBb+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1E020740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9vK-0004pa-FM
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jH9u7-0004Fu-0i
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jH9u5-0003sY-Bw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:33:22 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:37562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jH9u5-0003s7-8B; Wed, 25 Mar 2020 13:33:21 -0400
Received: by mail-vs1-xe43.google.com with SMTP id o3so2051959vsd.4;
 Wed, 25 Mar 2020 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZsXBgE/nquR1hBGoo5Qt4VyuvM4wjz4doEF7+w9MZng=;
 b=r5pyBb+1hQ9JQOF02T0V1JYOnbY0U7N5YzK4KBrO9GHZSK/hKsuZeiHoHtKbsaaObv
 XT1+BvcOPYy9OKtDm+hFMaFEZ3ja4jCaeA6QVu6f4+T19zEfbFZn/JB4FGNQvKzDmyFx
 O6bp1NG5GgYP7/IRb7oV2PVUMmHgVLZbdmV/qtrS1662r7JYtTNqFLL7noPNIiavcAAv
 jhlitRwR05xcgJoUlVJajryk0JOptpAgtZFz/6/unElvLL/h+cmKJm2n47FULTQnhitJ
 wVGzwFUmApUx5+v8fd6ZUH4DLxDCGJSaMGvGoT8pqMefw/kjjL7szoatbHScgrrihbrm
 v0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZsXBgE/nquR1hBGoo5Qt4VyuvM4wjz4doEF7+w9MZng=;
 b=EjYUifd9EIFox4KO4v1zhi/3RT4VNv7QHgrmHm59qLco/ECaWRCDBW4M5NdK5C0Vf2
 hDvnmIwjXPFZBbGVcC9Q1tr85Yc7yax3jExAApW7KiVo4jVHKpDip+b0HfLIVZ6T0cuw
 T4MGrzGHrqRrgbFoJF/b1kzDUwsZISQ0J5afacLGMwPGcDCdeU81cPpcLFlCHOxka8SJ
 dwECXwKdnt89TggVaXQVld/k6w8nzyn8qo5Zb2Wl2W2aJ5CJRVrYOWe4SpePGrHVcdMI
 CoUG2sc9YDr89Ah9G0e9AztCvTSMv0u1POopIrf1SO1SpsG164KGysXx8tGJHaOpUTlq
 PxAg==
X-Gm-Message-State: ANhLgQ1mApU6xUmVseL4ouvBDkx/jolcTS/bpuIAHCGcrG8I50xtOvT+
 V6wMh3O9f2mmH5JP0wWuvuwdQOQ6P++6Yf61VGo=
X-Google-Smtp-Source: ADFU+vswEcMye2DlcJSLPEzTX+10tOHkbvDtJklNgZibIe8oBaomZofna3TOftft3VPwm2kO5LQTqy7sf6Vj3PUUwD4=
X-Received: by 2002:a67:1b81:: with SMTP id b123mr3763523vsb.172.1585157600278; 
 Wed, 25 Mar 2020 10:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-21-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-21-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 10:25:20 -0700
Message-ID: <CAKmqyKMCtP=rKYgser0V5me6mFgyaFqf1jAHrU0MrF2-1X4Gdg@mail.gmail.com>
Subject: Re: [PATCH v6 20/61] target/riscv: vector widening integer multiply
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

On Tue, Mar 17, 2020 at 8:47 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 19 +++++++++
>  target/riscv/insn32.decode              |  6 +++
>  target/riscv/insn_trans/trans_rvv.inc.c |  8 ++++
>  target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++++
>  4 files changed, 84 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 357f149198..1704b8c512 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -591,3 +591,22 @@ DEF_HELPER_6(vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vwmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmulu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmulu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmulu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmulsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmulsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmulsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmulu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmulu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmulsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmulsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmulsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 7fb8f8fad8..ae7cfa3e28 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -379,6 +379,12 @@ vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
>  vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
>  vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
>  vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
> +vwmulu_vv       111000 . ..... ..... 010 ..... 1010111 @r_vm
> +vwmulu_vx       111000 . ..... ..... 110 ..... 1010111 @r_vm
> +vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
> +vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
> +vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
> +vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index ed53eaaef5..98df7e2daa 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1472,3 +1472,11 @@ GEN_OPIVX_TRANS(vdivu_vx, opivx_check)
>  GEN_OPIVX_TRANS(vdiv_vx, opivx_check)
>  GEN_OPIVX_TRANS(vremu_vx, opivx_check)
>  GEN_OPIVX_TRANS(vrem_vx, opivx_check)
> +
> +/* Vector Widening Integer Multiply Instructions */
> +GEN_OPIVV_WIDEN_TRANS(vwmul_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwmulu_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwmulsu_vv, opivv_widen_check)
> +GEN_OPIVX_WIDEN_TRANS(vwmul_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwmulu_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwmulsu_vx)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 4fc7a08954..35c6aa8494 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -856,6 +856,18 @@ GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
>  #define OP_SUS_H int16_t, uint16_t, int16_t, uint16_t, int16_t
>  #define OP_SUS_W int32_t, uint32_t, int32_t, uint32_t, int32_t
>  #define OP_SUS_D int64_t, uint64_t, int64_t, uint64_t, int64_t
> +#define WOP_UUU_B uint16_t, uint8_t, uint8_t, uint16_t, uint16_t
> +#define WOP_UUU_H uint32_t, uint16_t, uint16_t, uint32_t, uint32_t
> +#define WOP_UUU_W uint64_t, uint32_t, uint32_t, uint64_t, uint64_t
> +#define WOP_SSS_B int16_t, int8_t, int8_t, int16_t, int16_t
> +#define WOP_SSS_H int32_t, int16_t, int16_t, int32_t, int32_t
> +#define WOP_SSS_W int64_t, int32_t, int32_t, int64_t, int64_t
> +#define WOP_SUS_B int16_t, uint8_t, int8_t, uint16_t, int16_t
> +#define WOP_SUS_H int32_t, uint16_t, int16_t, uint32_t, int32_t
> +#define WOP_SUS_W int64_t, uint32_t, int32_t, uint64_t, int64_t
> +#define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
> +#define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
> +#define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
>
>  /* operation of two vector elements */
>  typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
> @@ -1815,3 +1827,42 @@ GEN_VEXT_VX(vrem_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX(vrem_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX(vrem_vx_w, 4, 4, clearl)
>  GEN_VEXT_VX(vrem_vx_d, 8, 8, clearq)
> +
> +/* Vector Widening Integer Multiply Instructions */
> +RVVCALL(OPIVV2, vwmul_vv_b, WOP_SSS_B, H2, H1, H1, DO_MUL)
> +RVVCALL(OPIVV2, vwmul_vv_h, WOP_SSS_H, H4, H2, H2, DO_MUL)
> +RVVCALL(OPIVV2, vwmul_vv_w, WOP_SSS_W, H8, H4, H4, DO_MUL)
> +RVVCALL(OPIVV2, vwmulu_vv_b, WOP_UUU_B, H2, H1, H1, DO_MUL)
> +RVVCALL(OPIVV2, vwmulu_vv_h, WOP_UUU_H, H4, H2, H2, DO_MUL)
> +RVVCALL(OPIVV2, vwmulu_vv_w, WOP_UUU_W, H8, H4, H4, DO_MUL)
> +RVVCALL(OPIVV2, vwmulsu_vv_b, WOP_SUS_B, H2, H1, H1, DO_MUL)
> +RVVCALL(OPIVV2, vwmulsu_vv_h, WOP_SUS_H, H4, H2, H2, DO_MUL)
> +RVVCALL(OPIVV2, vwmulsu_vv_w, WOP_SUS_W, H8, H4, H4, DO_MUL)
> +GEN_VEXT_VV(vwmul_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwmul_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwmul_vv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwmulu_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwmulu_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwmulu_vv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwmulsu_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwmulsu_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwmulsu_vv_w, 4, 8, clearq)
> +
> +RVVCALL(OPIVX2, vwmul_vx_b, WOP_SSS_B, H2, H1, DO_MUL)
> +RVVCALL(OPIVX2, vwmul_vx_h, WOP_SSS_H, H4, H2, DO_MUL)
> +RVVCALL(OPIVX2, vwmul_vx_w, WOP_SSS_W, H8, H4, DO_MUL)
> +RVVCALL(OPIVX2, vwmulu_vx_b, WOP_UUU_B, H2, H1, DO_MUL)
> +RVVCALL(OPIVX2, vwmulu_vx_h, WOP_UUU_H, H4, H2, DO_MUL)
> +RVVCALL(OPIVX2, vwmulu_vx_w, WOP_UUU_W, H8, H4, DO_MUL)
> +RVVCALL(OPIVX2, vwmulsu_vx_b, WOP_SUS_B, H2, H1, DO_MUL)
> +RVVCALL(OPIVX2, vwmulsu_vx_h, WOP_SUS_H, H4, H2, DO_MUL)
> +RVVCALL(OPIVX2, vwmulsu_vx_w, WOP_SUS_W, H8, H4, DO_MUL)
> +GEN_VEXT_VX(vwmul_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwmul_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwmul_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwmulu_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwmulu_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwmulu_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwmulsu_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwmulsu_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwmulsu_vx_w, 4, 8, clearq)
> --
> 2.23.0
>

