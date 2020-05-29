Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF6FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D0E206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1V9n6UJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D0E206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jemIf-0007YV-LN
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 17:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jemHE-0006Wn-6e; Fri, 29 May 2020 17:10:52 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jemHC-0007lx-Sd; Fri, 29 May 2020 17:10:51 -0400
Received: by mail-io1-xd43.google.com with SMTP id p20so810462iop.11;
 Fri, 29 May 2020 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iJjiz20d9yKFF5WMVxI0z/eJQ3WnHf4v/DgADs493Dc=;
 b=O1V9n6UJZh/AFSYPNzad6iZZg7r57NLpkOsrWvJRC+JxrWalrXvAi7j+wDTI4VE/V4
 p++obcDSEF30wnBnI9A/52zhe+MFwuOqDbcOUWXqSXjXgYARTmUYIhzR0aTPHAcho6kf
 qnCU683AWYjVeUQb2eSM250J6SPAvLQdhiTQ3MKEMBQwCnDCSTLBGB4r5YeUpwDnh8Uf
 17W2Sma4JBbo/Ru7m5HB4a7C3Dc7CQoOAkKOC8+E0l3K6RQrD3/Gy7HtN0PDjMXng6G1
 N6JwYn+T+ieEJMDb6clgr6arxh/bQ+8eCCNkQdkcURPcrCL5eJI1Z3/m8Xuj0zJ6AjTC
 FAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iJjiz20d9yKFF5WMVxI0z/eJQ3WnHf4v/DgADs493Dc=;
 b=SHBGoyon4peWTAdf2F3SPy2K9Fe5kWp+/M7eLSaOo3OxQ12CYJZyAhb0vkiQ6lDXmG
 P0so1D4j8r8W80LcdOqy5Kg6eqqL+g6m046zJYCNz9eX7ZsZyAF+TJBw9ZOYHGLiDbpt
 SVjiwqR5AIlOgK3c+ucx3736yRIygSzGk5jsvs4q6iG9DFxKV3lBh1Ai6n91txd6WjML
 ulIPSFy5lnVCTxXQva10JnKAiIuiyfM3vFHNoTd8ADmFL3Y81HUcmS7VhYM5RzniUIsj
 o6oAXd/GKcsLYAwStDnZX3U9ttRcnqw/phWwrXGqyCp18x5v0vpvSB3psp9BJJbUOonX
 LXEg==
X-Gm-Message-State: AOAM531AnuPx9PR75stVYBaEtNZyNbIKMY7LBEo8Zl6VkBDqzNjZeVus
 pF+wJ4yM+S4KC0dUbikBl04u29pyQsKuIbk1sKs=
X-Google-Smtp-Source: ABdhPJzpKvcr2EgJxjJ+YjOeM4drU4kmfI/pVDH/HD8+0Nv+THVit0M479rk8UgWQfc2Iy7qkK++ejuWyfDplTBcP18=
X-Received: by 2002:a6b:6a13:: with SMTP id x19mr8315998iog.175.1590786649499; 
 Fri, 29 May 2020 14:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-49-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-49-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 14:01:45 -0700
Message-ID: <CAKmqyKMiT+AZ1WerM7WNOO-xHY3TnJgS44DDLZTDvoR1NLOpKQ@mail.gmail.com>
Subject: Re: [PATCH v8 48/62] target/riscv: vector single-width floating-point
 reduction instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 4:21 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 10 +++++++
>  target/riscv/insn32.decode              |  4 +++
>  target/riscv/insn_trans/trans_rvv.inc.c |  5 ++++
>  target/riscv/vector_helper.c            | 39 +++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index ce31577ea9..17fd02c323 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1073,3 +1073,13 @@ DEF_HELPER_6(vwredsumu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vwredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +
> +DEF_HELPER_6(vfredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfredsum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfredmax_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfredmax_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index b69d804fda..0592075167 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -539,6 +539,10 @@ vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
>  vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
>  vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
>  vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
> +# Vector ordered and unordered reduction sum
> +vfredsum_vs     0000-1 . ..... ..... 001 ..... 1010111 @r_vm
> +vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
> +vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 8d75b3ca84..d74054ff04 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2337,3 +2337,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
>  /* Vector Widening Integer Reduction Instructions */
>  GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_check)
>  GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
> +
> +/* Vector Single-Width Floating-Point Reduction Instructions */
> +GEN_OPFVV_TRANS(vfredsum_vs, reduction_check)
> +GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
> +GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 5035e0bb0e..f37b65288a 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4416,3 +4416,42 @@ GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD, clearq)
>  GEN_VEXT_RED(vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, DO_ADD, clearh)
>  GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD, clearl)
>  GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD, clearq)
> +
> +/* Vector Single-Width Floating-Point Reduction Instructions */
> +#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)\
> +void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
> +                  void *vs2, CPURISCVState *env,           \
> +                  uint32_t desc)                           \
> +{                                                          \
> +    uint32_t mlen = vext_mlen(desc);                       \
> +    uint32_t vm = vext_vm(desc);                           \
> +    uint32_t vl = env->vl;                                 \
> +    uint32_t i;                                            \
> +    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;         \
> +    TD s1 =  *((TD *)vs1 + HD(0));                         \
> +                                                           \
> +    for (i = 0; i < vl; i++) {                             \
> +        TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {         \
> +            continue;                                      \
> +        }                                                  \
> +        s1 = OP(s1, (TD)s2, &env->fp_status);              \
> +    }                                                      \
> +    *((TD *)vd + HD(0)) = s1;                              \
> +    CLEAR_FN(vd, 1, sizeof(TD), tot);                      \
> +}
> +
> +/* Unordered sum */
> +GEN_VEXT_FRED(vfredsum_vs_h, uint16_t, uint16_t, H2, H2, float16_add, clearh)
> +GEN_VEXT_FRED(vfredsum_vs_w, uint32_t, uint32_t, H4, H4, float32_add, clearl)
> +GEN_VEXT_FRED(vfredsum_vs_d, uint64_t, uint64_t, H8, H8, float64_add, clearq)
> +
> +/* Maximum value */
> +GEN_VEXT_FRED(vfredmax_vs_h, uint16_t, uint16_t, H2, H2, float16_maxnum, clearh)
> +GEN_VEXT_FRED(vfredmax_vs_w, uint32_t, uint32_t, H4, H4, float32_maxnum, clearl)
> +GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, float64_maxnum, clearq)
> +
> +/* Minimum value */
> +GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, float16_minnum, clearh)
> +GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, float32_minnum, clearl)
> +GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum, clearq)
> --
> 2.23.0
>
>

