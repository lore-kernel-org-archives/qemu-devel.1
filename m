Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5195BC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D9B20B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjJq5BN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D9B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZ6H-0007YA-4T
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZ5A-0006ct-9h
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZ58-00044U-M5
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:03:32 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZ58-00042K-Ef; Fri, 17 Apr 2020 18:03:30 -0400
Received: by mail-io1-xd41.google.com with SMTP id o127so4087403iof.0;
 Fri, 17 Apr 2020 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a4/x6xRsw9K/HUBExZFp0MUgzjYOQRYa2n5oNgj9u4Y=;
 b=fjJq5BN/yPTqp1tyCuM1CpyIiIEHd8CY5oiTIiTn+jTWvWK+swJMhAtDKTHx7PnBvw
 K0IfnVQ/VrKg3OsCnaBRgcLX+WFGKjgHEw9a7l9AsUYaKi52Mjk6b//uLBk3dVXlfQMm
 CvSbp7bsLbEuzdq1SoJIVIuj83xmYhJnnTlnX10phlFwlydVEztN0HRXkoZjevGIbpbW
 i9EutqZEZhm4on8GPP0cm5yOK8cOwM6Z3S6t3an6IjVDUQC+uHr/xfcXUzcs9jnWCh4G
 VZn2W49hmap/ZK8d0wR095b+aykiZ3zU4hl1bRuyPKyZ6uq10uyQK0ywDOCLVsj357nP
 aFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a4/x6xRsw9K/HUBExZFp0MUgzjYOQRYa2n5oNgj9u4Y=;
 b=jtuZOKDjEYS0x0nklWZyF4myu/5qb6j6VoqVGp4pgiR5fEXSf+vm2DSghnmWhPLdi1
 8L2HLECR8cUvfEJN/N17LlN5ozgbBm+LUuCHug9aE/aeW+O4Q12AB9ABoXZ9q0O9nQEk
 K9lUcW8DvkEk7/0scnoInUUqZzPEGCeEFfvwpaSvobqIgozAj+RkSjK10Zs/j2nuv6RS
 R4S/H7gqXmssAyDQAjCGYM4u1nf/jo5aDhN3mE+wGc0Uv5xvmdMSXGNjp3SgDpnljvwt
 GOwuhaRB2/cXJDJliqZZ7BVd2WSNmODb6YRlDfSFwBr7l2cLci4bgS7QZgAjIfe4R3EP
 mu8g==
X-Gm-Message-State: AGi0PuYeHtY0MLGFoDz3bjIj8NpGgzDf5O5u5rGCeI5dJMFEA8tdyaHb
 I0wDnMnmm+57r5lp7FNJnaYTU5pTIU7yGzksNqM=
X-Google-Smtp-Source: APiQypJzZRiNCiDKibRhfqUID24vrZC2ximHh2ZTtQCHffleVG5Sk3dzjEmqR/ObYtk5JegJptuW+jFJ17/xxsbqo+I=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr5356854ioj.42.1587161009437; 
 Fri, 17 Apr 2020 15:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-29-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-29-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:55:06 -0700
Message-ID: <CAKmqyKM0qvcPNtkaNDph6RqUVuzSBteMt7LjcBHMBE0wcocgJQ@mail.gmail.com>
Subject: Re: [PATCH v7 28/61] target/riscv: vector single-width scaling shift
 instructions
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

On Mon, Mar 30, 2020 at 9:33 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  17 ++++
>  target/riscv/insn32.decode              |   6 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |   8 ++
>  target/riscv/vector_helper.c            | 117 ++++++++++++++++++++++++
>  4 files changed, 148 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index eb383787a2..f36f840714 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -767,3 +767,20 @@ DEF_HELPER_6(vwsmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vwsmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vwsmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vwsmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vssrl_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssrl_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssrl_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssrl_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssra_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssra_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssra_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssra_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssrl_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssrl_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssrl_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssrl_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 2e0e66bdfa..2ecac3d96d 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -431,6 +431,12 @@ vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
>  vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
>  vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
>  vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
> +vssrl_vv        101010 . ..... ..... 000 ..... 1010111 @r_vm
> +vssrl_vx        101010 . ..... ..... 100 ..... 1010111 @r_vm
> +vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
> +vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
> +vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
> +vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index c67faba23c..d5aaf18a07 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1791,3 +1791,11 @@ GEN_OPIVX_WIDEN_TRANS(vwsmaccu_vx)
>  GEN_OPIVX_WIDEN_TRANS(vwsmacc_vx)
>  GEN_OPIVX_WIDEN_TRANS(vwsmaccsu_vx)
>  GEN_OPIVX_WIDEN_TRANS(vwsmaccus_vx)
> +
> +/* Vector Single-Width Scaling Shift Instructions */
> +GEN_OPIVV_TRANS(vssrl_vv, opivv_check)
> +GEN_OPIVV_TRANS(vssra_vv, opivv_check)
> +GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
> +GEN_OPIVI_TRANS(vssrl_vi, 1, vssrl_vx, opivx_check)
> +GEN_OPIVI_TRANS(vssra_vi, 0, vssra_vx, opivx_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index b9c1cf5237..00ee42ea83 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -2908,3 +2908,120 @@ RVVCALL(OPIVX3_RM, vwsmaccus_vx_w, WOP_SUS_W, H8, H4, vwsmaccus32)
>  GEN_VEXT_VX_RM(vwsmaccus_vx_b, 1, 2, clearh)
>  GEN_VEXT_VX_RM(vwsmaccus_vx_h, 2, 4, clearl)
>  GEN_VEXT_VX_RM(vwsmaccus_vx_w, 4, 8, clearq)
> +
> +/* Vector Single-Width Scaling Shift Instructions */
> +static inline uint8_t
> +vssrl8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
> +{
> +    uint8_t round, shift = b & 0x7;
> +    uint8_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +static inline uint16_t
> +vssrl16(CPURISCVState *env, int vxrm, uint16_t a, uint16_t b)
> +{
> +    uint8_t round, shift = b & 0xf;
> +    uint16_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +static inline uint32_t
> +vssrl32(CPURISCVState *env, int vxrm, uint32_t a, uint32_t b)
> +{
> +    uint8_t round, shift = b & 0x1f;
> +    uint32_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +static inline uint64_t
> +vssrl64(CPURISCVState *env, int vxrm, uint64_t a, uint64_t b)
> +{
> +    uint8_t round, shift = b & 0x3f;
> +    uint64_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +RVVCALL(OPIVV2_RM, vssrl_vv_b, OP_UUU_B, H1, H1, H1, vssrl8)
> +RVVCALL(OPIVV2_RM, vssrl_vv_h, OP_UUU_H, H2, H2, H2, vssrl16)
> +RVVCALL(OPIVV2_RM, vssrl_vv_w, OP_UUU_W, H4, H4, H4, vssrl32)
> +RVVCALL(OPIVV2_RM, vssrl_vv_d, OP_UUU_D, H8, H8, H8, vssrl64)
> +GEN_VEXT_VV_RM(vssrl_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vssrl_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vssrl_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vssrl_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vssrl_vx_b, OP_UUU_B, H1, H1, vssrl8)
> +RVVCALL(OPIVX2_RM, vssrl_vx_h, OP_UUU_H, H2, H2, vssrl16)
> +RVVCALL(OPIVX2_RM, vssrl_vx_w, OP_UUU_W, H4, H4, vssrl32)
> +RVVCALL(OPIVX2_RM, vssrl_vx_d, OP_UUU_D, H8, H8, vssrl64)
> +GEN_VEXT_VX_RM(vssrl_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vssrl_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vssrl_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vssrl_vx_d, 8, 8, clearq)
> +
> +static inline int8_t
> +vssra8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
> +{
> +    uint8_t round, shift = b & 0x7;
> +    int8_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +static inline int16_t
> +vssra16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
> +{
> +    uint8_t round, shift = b & 0xf;
> +    int16_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +static inline int32_t
> +vssra32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
> +{
> +    uint8_t round, shift = b & 0x1f;
> +    int32_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +static inline int64_t
> +vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
> +{
> +    uint8_t round, shift = b & 0x3f;
> +    int64_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +RVVCALL(OPIVV2_RM, vssra_vv_b, OP_SSS_B, H1, H1, H1, vssra8)
> +RVVCALL(OPIVV2_RM, vssra_vv_h, OP_SSS_H, H2, H2, H2, vssra16)
> +RVVCALL(OPIVV2_RM, vssra_vv_w, OP_SSS_W, H4, H4, H4, vssra32)
> +RVVCALL(OPIVV2_RM, vssra_vv_d, OP_SSS_D, H8, H8, H8, vssra64)
> +GEN_VEXT_VV_RM(vssra_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vssra_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vssra_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vssra_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vssra_vx_b, OP_SSS_B, H1, H1, vssra8)
> +RVVCALL(OPIVX2_RM, vssra_vx_h, OP_SSS_H, H2, H2, vssra16)
> +RVVCALL(OPIVX2_RM, vssra_vx_w, OP_SSS_W, H4, H4, vssra32)
> +RVVCALL(OPIVX2_RM, vssra_vx_d, OP_SSS_D, H8, H8, vssra64)
> +GEN_VEXT_VX_RM(vssra_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vssra_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vssra_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vssra_vx_d, 8, 8, clearq)
> --
> 2.23.0
>

