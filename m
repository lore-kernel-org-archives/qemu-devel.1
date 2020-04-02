Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96965C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2936820737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPnCs4ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2936820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3kJ-00062G-CS
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jK3jW-0005WB-DX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jK3jU-0003t7-Ul
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:34:26 -0400
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42]:36103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jK3jU-0003sm-Qu; Thu, 02 Apr 2020 13:34:24 -0400
Received: by mail-vk1-xa42.google.com with SMTP id m131so1161881vkh.3;
 Thu, 02 Apr 2020 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V4Exnl1g0yFZWGgljC6x59RDUrLb96+TEZNvkBD560I=;
 b=WPnCs4vevPpEhlhyUtzIZ8y5MzPFiLkVi+zyizhtc6S95LyOpupfmojgM0DQ4xOGDs
 7OSeTN2SSVxK71ZPZuNn93SGzROLKffBHp9xibwISHtnErWeiZ7OVKuN0hnjqiHa+5II
 noNYf15kwyHNceu3j/92yCBX01m5NMC54dWjAJmpQ7hBM1qh3DPffWM6Zmejt7+IBr8Y
 xiHql1CShuN2SZmFx9Sadp3OObpvX1M+INVWCty+CWk03OZVFOFo4WefSBY7fBWwtnOZ
 3IuTXwNuLm/kJ7I81QQ1auYdquaXG8A4A6QFFhgPAfGltI3MDrSNFKzIfpegr+6/MrDl
 MVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V4Exnl1g0yFZWGgljC6x59RDUrLb96+TEZNvkBD560I=;
 b=NFPqP9hAd4GiZ2BwHKapJUtnIkDw6bS5pWER2wocrsqbcF/QGFtxnmhWe4XZ6D7mIy
 M3E5wlCVmnvJV8o7Y3uu+kHHJEAKVvGoB+zn3ikxIdU6E4TP8zg8+ukcJTPE41Jmt0ld
 9SnPjAyhC+c3wEnDtwK7ZHsqI78QeWeY6YFW9t1pwn/iZJlt8tXmav861/rwiV9eyQFq
 xR4GI5fpUltnWUWbCNBOza9Zuds9I7tIrhjhPO8iSgLc91XFyoT4v+NFxc0ri0Bm72Bz
 Kk1Y+g6w66Fk5iOwQ39HPZUnryXNcZSps6MBsz/9qLCIBtZL/u+U7QBxuodCk9i7mm5f
 yhWQ==
X-Gm-Message-State: AGi0PuY2Vm3go3ll9zA6j8ba76dA3oOte2CUMAYpRfrbJ50DtXGqnEcI
 s/2iicPoalz2sQYhaxSK7uaJDvq7ikQGi/fhMBM=
X-Google-Smtp-Source: APiQypJxi2CR+w2P33VpIFQsSLtkE7j/8QOLlY2qjwhgHdBP1eqfnPjvrc3RsYVUcwleAQJe3vavVeuxm8ztmkO23yg=
X-Received: by 2002:a1f:9ec1:: with SMTP id h184mr3196492vke.70.1585848862610; 
 Thu, 02 Apr 2020 10:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-27-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-27-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2020 10:25:58 -0700
Message-ID: <CAKmqyKOkJufaCWFbHb2keuefO1CxHRpx0Bprhp7B-3YGpU=fqQ@mail.gmail.com>
Subject: Re: [PATCH v7 26/61] target/riscv: vector single-width fractional
 multiply with rounding and saturation
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a42
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

On Mon, Mar 30, 2020 at 9:29 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |   9 ++
>  target/riscv/insn32.decode              |   2 +
>  target/riscv/insn_trans/trans_rvv.inc.c |   4 +
>  target/riscv/vector_helper.c            | 107 ++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 32d549ce36..e6cae1b59c 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -736,3 +736,12 @@ DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vsmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsmul_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsmul_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsmul_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsmul_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index e617d7bd60..633f782fbf 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -422,6 +422,8 @@ vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
>  vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
>  vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
>  vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
> +vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
> +vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index a7cf4f4614..08a8444b46 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1778,3 +1778,7 @@ GEN_OPIVV_TRANS(vasub_vv, opivv_check)
>  GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
>  GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
>  GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
> +
> +/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
> +GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
> +GEN_OPIVX_TRANS(vsmul_vx,  opivx_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 784993b5f6..23868fb1b2 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -2596,3 +2596,110 @@ GEN_VEXT_VX_RM(vasub_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX_RM(vasub_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX_RM(vasub_vx_w, 4, 4, clearl)
>  GEN_VEXT_VX_RM(vasub_vx_d, 8, 8, clearq)
> +
> +/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
> +static inline int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
> +{
> +    uint8_t round;
> +    int16_t res;
> +
> +    res = (int16_t)a * (int16_t)b;
> +    round = get_round(vxrm, res, 7);
> +    res   = (res >> 7) + round;
> +
> +    if (res > INT8_MAX) {
> +        env->vxsat = 0x1;
> +        return INT8_MAX;
> +    } else if (res < INT8_MIN) {
> +        env->vxsat = 0x1;
> +        return INT8_MIN;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +static int16_t vsmul16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
> +{
> +    uint8_t round;
> +    int32_t res;
> +
> +    res = (int32_t)a * (int32_t)b;
> +    round = get_round(vxrm, res, 15);
> +    res   = (res >> 15) + round;
> +
> +    if (res > INT16_MAX) {
> +        env->vxsat = 0x1;
> +        return INT16_MAX;
> +    } else if (res < INT16_MIN) {
> +        env->vxsat = 0x1;
> +        return INT16_MIN;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +static int32_t vsmul32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
> +{
> +    uint8_t round;
> +    int64_t res;
> +
> +    res = (int64_t)a * (int64_t)b;
> +    round = get_round(vxrm, res, 31);
> +    res   = (res >> 31) + round;
> +
> +    if (res > INT32_MAX) {
> +        env->vxsat = 0x1;
> +        return INT32_MAX;
> +    } else if (res < INT32_MIN) {
> +        env->vxsat = 0x1;
> +        return INT32_MIN;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +static int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
> +{
> +    uint8_t round;
> +    uint64_t hi_64, lo_64;
> +    int64_t res;
> +
> +    if (a == INT64_MIN && b == INT64_MIN) {
> +        env->vxsat = 1;
> +        return INT64_MAX;
> +    }
> +
> +    muls64(&lo_64, &hi_64, a, b);
> +    round = get_round(vxrm, lo_64, 63);
> +    /*
> +     * Cannot overflow, as there are always
> +     * 2 sign bits after multiply.
> +     */
> +    res = (hi_64 << 1) | (lo_64 >> 63);
> +    if (round) {
> +        if (res == INT64_MAX) {
> +            env->vxsat = 1;
> +        } else {
> +            res += 1;
> +        }
> +    }
> +    return res;
> +}
> +
> +RVVCALL(OPIVV2_RM, vsmul_vv_b, OP_SSS_B, H1, H1, H1, vsmul8)
> +RVVCALL(OPIVV2_RM, vsmul_vv_h, OP_SSS_H, H2, H2, H2, vsmul16)
> +RVVCALL(OPIVV2_RM, vsmul_vv_w, OP_SSS_W, H4, H4, H4, vsmul32)
> +RVVCALL(OPIVV2_RM, vsmul_vv_d, OP_SSS_D, H8, H8, H8, vsmul64)
> +GEN_VEXT_VV_RM(vsmul_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vsmul_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vsmul_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vsmul_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vsmul_vx_b, OP_SSS_B, H1, H1, vsmul8)
> +RVVCALL(OPIVX2_RM, vsmul_vx_h, OP_SSS_H, H2, H2, vsmul16)
> +RVVCALL(OPIVX2_RM, vsmul_vx_w, OP_SSS_W, H4, H4, vsmul32)
> +RVVCALL(OPIVX2_RM, vsmul_vx_d, OP_SSS_D, H8, H8, vsmul64)
> +GEN_VEXT_VX_RM(vsmul_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vsmul_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vsmul_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vsmul_vx_d, 8, 8, clearq)
> --
> 2.23.0
>

