Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76179C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED9A206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyPMgKcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED9A206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jemJv-0000SN-Dw
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 17:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jemIq-0007zd-EI; Fri, 29 May 2020 17:12:32 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:45103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jemIp-000860-6g; Fri, 29 May 2020 17:12:32 -0400
Received: by mail-il1-x141.google.com with SMTP id 9so3829832ilg.12;
 Fri, 29 May 2020 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sPF3zCpryzkg3/kw9o9jHuh0b64l/W5E/1PxBTv44zo=;
 b=pyPMgKcCOE8Tzk4QoxAPwce+ZG/YvERli7kU+ts/NWTuqWKSPq6psV3JSa0/L4OssX
 yohZUP9uEOyMOKmt90GkH6tAJEyBt+tGpUQU4A5ImHUQgmHvue4PcCOvdKQ2emX2V4T4
 PRqbNZ9zNX4QyU5/sTOjC6M+F++Fs7jB4Qz4Nl7kXof9hsk0BCVWAZtbbmkLYsCWwSkv
 5gJHz+JELjEPho7sDejU3SUjbyASP/ID78To52o3RYCtc43cYa2epr0Wsne6x8QTqoUJ
 vnDhMCfIZ7fjUbz1cKVsy0gwYyGtuuQ0wLEurFqR4+oHN8LHuwYgaSFVslxfAhSSN31H
 B89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sPF3zCpryzkg3/kw9o9jHuh0b64l/W5E/1PxBTv44zo=;
 b=TEMgApYHEoG22BazNVJV6HJ86cgcNyXDsiWjiZU4Q9UGJq/70mWYgByCaAbyfCIuWm
 z7/XyETIx3xfsD5zGTW6xOijsx1s1OobiuoGAU9IhtVJqKW0D77x+iR1Kbu93+cTxYnM
 sqmErexzHA0PuzSp9g5RQCIVUFZmy92EZRdrwA7o0ockyM306EDTbL9fRaZQjcP7Geke
 Zn6D4lg92ZwuhusjQpBO8D1yqQCrxHVGEsiH91efsVVYRyU32JbiolZsqj2xkjU0SW2u
 wM7eCnTiPVYvHB53vy6Y2Fenu2T5TFIUM7YZ2xsZ4xt/5pH9r7jqRiL7KAHxqv+8feNl
 IfCQ==
X-Gm-Message-State: AOAM532a6z33f3cUbKk+Abqrls5VnBe9KEWnYkvUPCFJSbJlL191RVp2
 ROeJIrT39cvVhrYY+HYlNeL3hQ4IREMOHmsLUoc=
X-Google-Smtp-Source: ABdhPJxHaQY1S0iDas8jckrxuy30ziqrMGQ+kTeKb/G5R8Tjj9AAASck11PdjkrH3oYbmQg1YX6cAw7AHR0QC5wWajk=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr3579876ilq.177.1590786749695; 
 Fri, 29 May 2020 14:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-50-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-50-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 14:03:26 -0700
Message-ID: <CAKmqyKMK3O453p_S4zXehguW9VUTsxjd0jH_HwzhniR-cbPYhg@mail.gmail.com>
Subject: Re: [PATCH v8 49/62] target/riscv: vector widening floating-point
 reduction instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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

On Thu, May 21, 2020 at 4:23 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  3 ++
>  target/riscv/insn32.decode              |  2 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  3 ++
>  target/riscv/vector_helper.c            | 46 +++++++++++++++++++++++++
>  4 files changed, 54 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 17fd02c323..6b932b444d 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1083,3 +1083,6 @@ DEF_HELPER_6(vfredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +
> +DEF_HELPER_6(vfwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 0592075167..526a964d28 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -543,6 +543,8 @@ vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
>  vfredsum_vs     0000-1 . ..... ..... 001 ..... 1010111 @r_vm
>  vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
>  vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
> +# Vector widening ordered and unordered float reduction sum
> +vfwredsum_vs    1100-1 . ..... ..... 001 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index d74054ff04..31848a1f88 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2342,3 +2342,6 @@ GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
>  GEN_OPFVV_TRANS(vfredsum_vs, reduction_check)
>  GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
>  GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
> +
> +/* Vector Widening Floating-Point Reduction Instructions */
> +GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index f37b65288a..0074d12538 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4455,3 +4455,49 @@ GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, float64_maxnum, clearq)
>  GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, float16_minnum, clearh)
>  GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, float32_minnum, clearl)
>  GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum, clearq)
> +
> +/* Vector Widening Floating-Point Reduction Instructions */
> +/* Unordered reduce 2*SEW = 2*SEW + sum(promote(SEW)) */
> +void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
> +                            void *vs2, CPURISCVState *env, uint32_t desc)
> +{
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    uint32_t i;
> +    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
> +    uint32_t s1 =  *((uint32_t *)vs1 + H4(0));
> +
> +    for (i = 0; i < vl; i++) {
> +        uint16_t s2 = *((uint16_t *)vs2 + H2(i));
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        s1 = float32_add(s1, float16_to_float32(s2, true, &env->fp_status),
> +                         &env->fp_status);
> +    }
> +    *((uint32_t *)vd + H4(0)) = s1;
> +    clearl(vd, 1, sizeof(uint32_t), tot);
> +}
> +
> +void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
> +                            void *vs2, CPURISCVState *env, uint32_t desc)
> +{
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    uint32_t i;
> +    uint32_t tot = env_archcpu(env)->cfg.vlen / 8;
> +    uint64_t s1 =  *((uint64_t *)vs1);
> +
> +    for (i = 0; i < vl; i++) {
> +        uint32_t s2 = *((uint32_t *)vs2 + H4(i));
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        s1 = float64_add(s1, float32_to_float64(s2, &env->fp_status),
> +                         &env->fp_status);
> +    }
> +    *((uint64_t *)vd) = s1;
> +    clearq(vd, 1, sizeof(uint64_t), tot);
> +}
> --
> 2.23.0
>
>

