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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57C6C54FD4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A0F2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtabC08O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A0F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9xq-0007xG-OD
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jH9wW-0006ad-I8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jH9wU-0005kr-Px
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:35:52 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:45107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jH9wU-0005kU-LU; Wed, 25 Mar 2020 13:35:50 -0400
Received: by mail-vs1-xe44.google.com with SMTP id x82so2023207vsc.12;
 Wed, 25 Mar 2020 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WmzvpTbpUjcdnvX/xav3ImBBWtYI2Ue7lS5Dh12w2vw=;
 b=ZtabC08OvT5/dUhdXT+Em3w+hIwodHx+t2mTDl9O5wsLP4gIhydnSw+xwNrMC3sDxx
 bO8Dpbu5lLVBqZ073YC/VTlITiACnp1/msxmQr2AcgCofk8VAbiQcrQHXIHl7maJ+mAS
 3lJ4JmrzES5hEWhh+OTx3Zm2CpCI36duGiyN5/dB94MHTYJYyG3HtoOu45OffcwkYnuK
 eo6DkL9FUh+kTEGiU3EIg6ZH9qkvbG5/D3nyXQ/rRJZ2KEljiSnYcOQ4+esZmMBfVrrG
 YrBA/E857Odt6CXjJyjHYljeEvPFWIgMmShAGXQ7ThzDwBNmRQ9xBttE7G0jMLzXUNeN
 slfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WmzvpTbpUjcdnvX/xav3ImBBWtYI2Ue7lS5Dh12w2vw=;
 b=e7O6MeCTRrwY4SCg3xOkQA9mO/0WqjC6sEwsco9AV4BHZ7FnklvgcngfAysM9GoQCr
 qNtduv23BvBAPE0cMK3ocZc1MTmmgTUqO1L9dfaxdzHXgbc3i5rWhhewwgL/EzFtgZXE
 aZvIwibMSbepTgC5SS4dXfUJzX0xzCAz0sUhQD/pcl+WxlI1Xgd5WJbhIYdhDeqVnG+w
 Gb1pVz6GwyT/OyVAMef4vFT/efW061be7m5USALEO+URwu2sli2uqgehV1aw5kF1BYmc
 YaBLwPjzAkyc0LteMHVSKM00LJiLdefExyDv9Rd7URXEKM9nAW1ZYKuoMB3PUORquk10
 zGbw==
X-Gm-Message-State: ANhLgQ2EgR8l85wboEIBuOlrz+klYXCbhp9FhTcPuUWT7w/do0xpDnap
 7+ZmPajNnwCq21TXadSMlCXFS3/KMqPl8q7/wdM=
X-Google-Smtp-Source: ADFU+vvYK11WRd8KKPtJldkfWYnB58pT/u12jYbhdeNrQs5QwexSbbAeS4CPMsuJo/gvrpwxOkwhrj5Vj+0alBTip4k=
X-Received: by 2002:a67:1b81:: with SMTP id b123mr3773995vsb.172.1585157750056; 
 Wed, 25 Mar 2020 10:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-22-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-22-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 10:27:49 -0700
Message-ID: <CAKmqyKMqrW_5HQyG5YJntG-mmq+EDEZPkXKOqvB4fpMiyLf1TQ@mail.gmail.com>
Subject: Re: [PATCH v6 21/61] target/riscv: vector single-width integer
 multiply-add instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e44
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

On Tue, Mar 17, 2020 at 8:49 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 33 ++++++++++
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 10 +++
>  target/riscv/vector_helper.c            | 88 +++++++++++++++++++++++++
>  4 files changed, 139 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 1704b8c512..098288df76 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -610,3 +610,36 @@ DEF_HELPER_6(vwmulu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vwmulsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vwmulsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vwmulsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnmsac_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnmsub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmacc_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnmsac_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnmsac_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnmsac_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnmsac_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnmsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnmsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnmsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnmsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index ae7cfa3e28..b49b60aea1 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -385,6 +385,14 @@ vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
>  vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
>  vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
>  vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
> +vmacc_vv        101101 . ..... ..... 010 ..... 1010111 @r_vm
> +vmacc_vx        101101 . ..... ..... 110 ..... 1010111 @r_vm
> +vnmsac_vv       101111 . ..... ..... 010 ..... 1010111 @r_vm
> +vnmsac_vx       101111 . ..... ..... 110 ..... 1010111 @r_vm
> +vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
> +vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
> +vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
> +vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 98df7e2daa..6d2ccbd615 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1480,3 +1480,13 @@ GEN_OPIVV_WIDEN_TRANS(vwmulsu_vv, opivv_widen_check)
>  GEN_OPIVX_WIDEN_TRANS(vwmul_vx)
>  GEN_OPIVX_WIDEN_TRANS(vwmulu_vx)
>  GEN_OPIVX_WIDEN_TRANS(vwmulsu_vx)
> +
> +/* Vector Single-Width Integer Multiply-Add Instructions */
> +GEN_OPIVV_TRANS(vmacc_vv, opivv_check)
> +GEN_OPIVV_TRANS(vnmsac_vv, opivv_check)
> +GEN_OPIVV_TRANS(vmadd_vv, opivv_check)
> +GEN_OPIVV_TRANS(vnmsub_vv, opivv_check)
> +GEN_OPIVX_TRANS(vmacc_vx, opivx_check)
> +GEN_OPIVX_TRANS(vnmsac_vx, opivx_check)
> +GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
> +GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 35c6aa8494..f65ed6abbc 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -1866,3 +1866,91 @@ GEN_VEXT_VX(vwmulu_vx_w, 4, 8, clearq)
>  GEN_VEXT_VX(vwmulsu_vx_b, 1, 2, clearh)
>  GEN_VEXT_VX(vwmulsu_vx_h, 2, 4, clearl)
>  GEN_VEXT_VX(vwmulsu_vx_w, 4, 8, clearq)
> +
> +/* Vector Single-Width Integer Multiply-Add Instructions */
> +#define OPIVV3(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)   \
> +static void do_##NAME(void *vd, void *vs1, void *vs2, int i)       \
> +{                                                                  \
> +    TX1 s1 = *((T1 *)vs1 + HS1(i));                                \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                \
> +    TD d = *((TD *)vd + HD(i));                                    \
> +    *((TD *)vd + HD(i)) = OP(s2, s1, d);                           \
> +}
> +
> +#define DO_MACC(N, M, D) (M * N + D)
> +#define DO_NMSAC(N, M, D) (-(M * N) + D)
> +#define DO_MADD(N, M, D) (M * D + N)
> +#define DO_NMSUB(N, M, D) (-(M * D) + N)
> +RVVCALL(OPIVV3, vmacc_vv_b, OP_SSS_B, H1, H1, H1, DO_MACC)
> +RVVCALL(OPIVV3, vmacc_vv_h, OP_SSS_H, H2, H2, H2, DO_MACC)
> +RVVCALL(OPIVV3, vmacc_vv_w, OP_SSS_W, H4, H4, H4, DO_MACC)
> +RVVCALL(OPIVV3, vmacc_vv_d, OP_SSS_D, H8, H8, H8, DO_MACC)
> +RVVCALL(OPIVV3, vnmsac_vv_b, OP_SSS_B, H1, H1, H1, DO_NMSAC)
> +RVVCALL(OPIVV3, vnmsac_vv_h, OP_SSS_H, H2, H2, H2, DO_NMSAC)
> +RVVCALL(OPIVV3, vnmsac_vv_w, OP_SSS_W, H4, H4, H4, DO_NMSAC)
> +RVVCALL(OPIVV3, vnmsac_vv_d, OP_SSS_D, H8, H8, H8, DO_NMSAC)
> +RVVCALL(OPIVV3, vmadd_vv_b, OP_SSS_B, H1, H1, H1, DO_MADD)
> +RVVCALL(OPIVV3, vmadd_vv_h, OP_SSS_H, H2, H2, H2, DO_MADD)
> +RVVCALL(OPIVV3, vmadd_vv_w, OP_SSS_W, H4, H4, H4, DO_MADD)
> +RVVCALL(OPIVV3, vmadd_vv_d, OP_SSS_D, H8, H8, H8, DO_MADD)
> +RVVCALL(OPIVV3, vnmsub_vv_b, OP_SSS_B, H1, H1, H1, DO_NMSUB)
> +RVVCALL(OPIVV3, vnmsub_vv_h, OP_SSS_H, H2, H2, H2, DO_NMSUB)
> +RVVCALL(OPIVV3, vnmsub_vv_w, OP_SSS_W, H4, H4, H4, DO_NMSUB)
> +RVVCALL(OPIVV3, vnmsub_vv_d, OP_SSS_D, H8, H8, H8, DO_NMSUB)
> +GEN_VEXT_VV(vmacc_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vmacc_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vmacc_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vmacc_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vnmsac_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vnmsac_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vnmsac_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vnmsac_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vmadd_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vmadd_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vmadd_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vmadd_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vnmsub_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vnmsub_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vnmsub_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vnmsub_vv_d, 8, 8, clearq)
> +
> +#define OPIVX3(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)             \
> +static void do_##NAME(void *vd, target_long s1, void *vs2, int i)   \
> +{                                                                   \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
> +    TD d = *((TD *)vd + HD(i));                                     \
> +    *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d);                   \
> +}
> +
> +RVVCALL(OPIVX3, vmacc_vx_b, OP_SSS_B, H1, H1, DO_MACC)
> +RVVCALL(OPIVX3, vmacc_vx_h, OP_SSS_H, H2, H2, DO_MACC)
> +RVVCALL(OPIVX3, vmacc_vx_w, OP_SSS_W, H4, H4, DO_MACC)
> +RVVCALL(OPIVX3, vmacc_vx_d, OP_SSS_D, H8, H8, DO_MACC)
> +RVVCALL(OPIVX3, vnmsac_vx_b, OP_SSS_B, H1, H1, DO_NMSAC)
> +RVVCALL(OPIVX3, vnmsac_vx_h, OP_SSS_H, H2, H2, DO_NMSAC)
> +RVVCALL(OPIVX3, vnmsac_vx_w, OP_SSS_W, H4, H4, DO_NMSAC)
> +RVVCALL(OPIVX3, vnmsac_vx_d, OP_SSS_D, H8, H8, DO_NMSAC)
> +RVVCALL(OPIVX3, vmadd_vx_b, OP_SSS_B, H1, H1, DO_MADD)
> +RVVCALL(OPIVX3, vmadd_vx_h, OP_SSS_H, H2, H2, DO_MADD)
> +RVVCALL(OPIVX3, vmadd_vx_w, OP_SSS_W, H4, H4, DO_MADD)
> +RVVCALL(OPIVX3, vmadd_vx_d, OP_SSS_D, H8, H8, DO_MADD)
> +RVVCALL(OPIVX3, vnmsub_vx_b, OP_SSS_B, H1, H1, DO_NMSUB)
> +RVVCALL(OPIVX3, vnmsub_vx_h, OP_SSS_H, H2, H2, DO_NMSUB)
> +RVVCALL(OPIVX3, vnmsub_vx_w, OP_SSS_W, H4, H4, DO_NMSUB)
> +RVVCALL(OPIVX3, vnmsub_vx_d, OP_SSS_D, H8, H8, DO_NMSUB)
> +GEN_VEXT_VX(vmacc_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vmacc_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vmacc_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vmacc_vx_d, 8, 8, clearq)
> +GEN_VEXT_VX(vnmsac_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vnmsac_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vnmsac_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vnmsac_vx_d, 8, 8, clearq)
> +GEN_VEXT_VX(vmadd_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vmadd_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vmadd_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vmadd_vx_d, 8, 8, clearq)
> +GEN_VEXT_VX(vnmsub_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vnmsub_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vnmsub_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vnmsub_vx_d, 8, 8, clearq)
> --
> 2.23.0
>

