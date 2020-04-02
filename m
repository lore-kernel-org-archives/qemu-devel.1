Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4739C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682A420737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoGgElfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682A420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3hw-0004E2-K0
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jK3gb-000377-Ce
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jK3gZ-00074e-MU
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:31:25 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:43822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jK3gZ-00073q-Hr; Thu, 02 Apr 2020 13:31:23 -0400
Received: by mail-ua1-x943.google.com with SMTP id g24so1540827uan.10;
 Thu, 02 Apr 2020 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d6sNGOf7zhVwXJm9O9+zOAPhluGA9ST7ObWtc87JvDY=;
 b=HoGgElfk9GxKehfs8tpVwXHgFcT3lbRz4h38BxOT58q6FK05hbyQXyKaH7vqn4tvvQ
 TkYhuMf/utJUWyIyrlR1QK6QDPwa5zZprzpkL7Y92rhSiuQPx+aLG+7q2OHv/o1rtSLL
 3b4F/E4nozTZ/jujwlqX0ViPWxT/9H/iuw3XtMSgxQ0kfvJRYpABQwlABzZmu+5txjOV
 flr3lFJbHybEVS3dCJrXCRAKviogp7wU0ernVLWJj7m594kFTuLq5AU9jqUVAT2pbuLA
 sH26B+H8Ffs4+1z/Z4qKZL3WYgpoaho7cBVUwXN6LRDus+NB7kG1tE2sqGiGAIWL+sWb
 XCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d6sNGOf7zhVwXJm9O9+zOAPhluGA9ST7ObWtc87JvDY=;
 b=LujRC4Tc8BYuPNzINS+cnA5/MQAxlqFRxtqTvsEKEoodkcTj8f8leusKq0g9a3Y5ud
 wSgDFQtPckmCQraIPQAOa/x02PqdBRdiJCh+eLCPbLWqWBoxQKI+9B8+8cD8JKvjUGAz
 8TTiHaOWCoG1uebAlVFG6bS8jUF9XRn5/5CBs/0iTjgktNxSeADMeZpgF3/D3O99wyWo
 G4L7jeRoULuH3Uf2Wz0Cs9Ket4KTpXth+Wg6g3VD++xBhUDL3jW0gdq8PKLrGFMgBko1
 ks/bbetY+n1uKRfb44Vsd4NEm850CGWq3+n/VlSW7kbrCyzpRS1UAV87wJ013xQVr4eV
 N+1A==
X-Gm-Message-State: AGi0PuZRq14Qqxvspontr1GK++fjgwxTKdbESfy0wLLOmH33/lcT7EZA
 Zs186PtPVO430c8OXoNInX2D1Psvi8AM4Duucyo=
X-Google-Smtp-Source: APiQypJLPkJ2xcVo7EqSeDWGuW2jc8UVg9zEa4RjkpZnmVcIow3uGxNi8ZEuj1m4uU6ymeGChfb7sKT6xL5drcFSWFE=
X-Received: by 2002:a9f:21b8:: with SMTP id 53mr3648552uac.8.1585848681871;
 Thu, 02 Apr 2020 10:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-26-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-26-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2020 10:23:09 -0700
Message-ID: <CAKmqyKNdjP1wFgTtskjdzkjBOyZNw4MwQwahuy4E5c87P21eBw@mail.gmail.com>
Subject: Re: [PATCH v7 25/61] target/riscv: vector single-width averaging add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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

On Mon, Mar 30, 2020 at 9:27 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  17 ++++
>  target/riscv/insn32.decode              |   5 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |   7 ++
>  target/riscv/vector_helper.c            | 100 ++++++++++++++++++++++++
>  4 files changed, 129 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 9416ebb090..32d549ce36 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -719,3 +719,20 @@ DEF_HELPER_6(vssub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vssub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vssub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vssub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vaadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vaadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vaadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vaadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vasub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vasub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vasub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vasub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vaadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vaadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vaadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vaadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index c9a4050adc..e617d7bd60 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -417,6 +417,11 @@ vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
>  vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
>  vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
>  vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
> +vaadd_vv        100100 . ..... ..... 000 ..... 1010111 @r_vm
> +vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
> +vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
> +vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
> +vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 7f9ab4b8b7..a7cf4f4614 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1771,3 +1771,10 @@ GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
>  GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
>  GEN_OPIVI_TRANS(vsaddu_vi, 1, vsaddu_vx, opivx_check)
>  GEN_OPIVI_TRANS(vsadd_vi, 0, vsadd_vx, opivx_check)
> +
> +/* Vector Single-Width Averaging Add and Subtract */
> +GEN_OPIVV_TRANS(vaadd_vv, opivv_check)
> +GEN_OPIVV_TRANS(vasub_vv, opivv_check)
> +GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
> +GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 7f34fcccce..784993b5f6 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -2496,3 +2496,103 @@ GEN_VEXT_VX_RM(vssub_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX_RM(vssub_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX_RM(vssub_vx_w, 4, 4, clearl)
>  GEN_VEXT_VX_RM(vssub_vx_d, 8, 8, clearq)
> +
> +/* Vector Single-Width Averaging Add and Subtract */
> +static inline uint8_t get_round(int vxrm, uint64_t v, uint8_t shift)
> +{
> +    uint8_t d = extract64(v, shift, 1);
> +    uint8_t d1;
> +    uint64_t D1, D2;
> +
> +    if (shift == 0 || shift > 64) {
> +        return 0;
> +    }
> +
> +    d1 = extract64(v, shift - 1, 1);
> +    D1 = extract64(v, 0, shift);
> +    if (vxrm == 0) { /* round-to-nearest-up (add +0.5 LSB) */
> +        return d1;
> +    } else if (vxrm == 1) { /* round-to-nearest-even */
> +        if (shift > 1) {
> +            D2 = extract64(v, 0, shift - 1);
> +            return d1 & ((D2 != 0) | d);
> +        } else {
> +            return d1 & d;
> +        }
> +    } else if (vxrm == 3) { /* round-to-odd (OR bits into LSB, aka "jam") */
> +        return !d & (D1 != 0);
> +    }
> +    return 0; /* round-down (truncate) */
> +}
> +
> +static inline int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
> +{
> +    int64_t res = (int64_t)a + b;
> +    uint8_t round = get_round(vxrm, res, 1);
> +
> +    return (res >> 1) + round;
> +}
> +
> +static inline int64_t aadd64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
> +{
> +    int64_t res = a + b;
> +    uint8_t round = get_round(vxrm, res, 1);
> +    int64_t over = (res ^ a) & (res ^ b) & INT64_MIN;
> +
> +    /* With signed overflow, bit 64 is inverse of bit 63. */
> +    return ((res >> 1) ^ over) + round;
> +}
> +
> +RVVCALL(OPIVV2_RM, vaadd_vv_b, OP_SSS_B, H1, H1, H1, aadd32)
> +RVVCALL(OPIVV2_RM, vaadd_vv_h, OP_SSS_H, H2, H2, H2, aadd32)
> +RVVCALL(OPIVV2_RM, vaadd_vv_w, OP_SSS_W, H4, H4, H4, aadd32)
> +RVVCALL(OPIVV2_RM, vaadd_vv_d, OP_SSS_D, H8, H8, H8, aadd64)
> +GEN_VEXT_VV_RM(vaadd_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vaadd_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vaadd_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vaadd_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vaadd_vx_b, OP_SSS_B, H1, H1, aadd32)
> +RVVCALL(OPIVX2_RM, vaadd_vx_h, OP_SSS_H, H2, H2, aadd32)
> +RVVCALL(OPIVX2_RM, vaadd_vx_w, OP_SSS_W, H4, H4, aadd32)
> +RVVCALL(OPIVX2_RM, vaadd_vx_d, OP_SSS_D, H8, H8, aadd64)
> +GEN_VEXT_VX_RM(vaadd_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vaadd_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vaadd_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vaadd_vx_d, 8, 8, clearq)
> +
> +static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
> +{
> +    int64_t res = (int64_t)a - b;
> +    uint8_t round = get_round(vxrm, res, 1);
> +
> +    return (res >> 1) + round;
> +}
> +
> +static inline int64_t asub64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
> +{
> +    int64_t res = (int64_t)a - b;
> +    uint8_t round = get_round(vxrm, res, 1);
> +    int64_t over = (res ^ a) & (a ^ b) & INT64_MIN;
> +
> +    /* With signed overflow, bit 64 is inverse of bit 63. */
> +    return ((res >> 1) ^ over) + round;
> +}
> +
> +RVVCALL(OPIVV2_RM, vasub_vv_b, OP_SSS_B, H1, H1, H1, asub32)
> +RVVCALL(OPIVV2_RM, vasub_vv_h, OP_SSS_H, H2, H2, H2, asub32)
> +RVVCALL(OPIVV2_RM, vasub_vv_w, OP_SSS_W, H4, H4, H4, asub32)
> +RVVCALL(OPIVV2_RM, vasub_vv_d, OP_SSS_D, H8, H8, H8, asub64)
> +GEN_VEXT_VV_RM(vasub_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vasub_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vasub_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vasub_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vasub_vx_b, OP_SSS_B, H1, H1, asub32)
> +RVVCALL(OPIVX2_RM, vasub_vx_h, OP_SSS_H, H2, H2, asub32)
> +RVVCALL(OPIVX2_RM, vasub_vx_w, OP_SSS_W, H4, H4, asub32)
> +RVVCALL(OPIVX2_RM, vasub_vx_d, OP_SSS_D, H8, H8, asub64)
> +GEN_VEXT_VX_RM(vasub_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vasub_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vasub_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vasub_vx_d, 8, 8, clearq)
> --
> 2.23.0
>

