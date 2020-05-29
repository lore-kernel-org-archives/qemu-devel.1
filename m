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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A14C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66014207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNu+FFDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66014207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jemFn-0004uW-Jg
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 17:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jemF7-0004T2-2W; Fri, 29 May 2020 17:08:41 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:37135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jemF5-0007Sj-Vv; Fri, 29 May 2020 17:08:40 -0400
Received: by mail-il1-x143.google.com with SMTP id r2so3880700ila.4;
 Fri, 29 May 2020 14:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7qk2yqN6Imij5/sb5OJmdztELgV2Zz1vG0eRtcGX5zI=;
 b=iNu+FFDLNOwDSpsS6r3CcQ1+Q9N6Wfjms8pwTKqxFbRA6kuyDYyZK5zzXuwmW9FUkh
 vfGYa0vwTHjTrjOXFXb9MuhY+3PfUy03PLm+ShYsgrtpiqmZwcLNW4v8/6FUi2t71N8f
 J7eRWrtPO9EPK0L6FXbEB8pYbqsNYruhLqjGNQ0YL/nGROQ/8HCMkV7c5pZb2ZV3/OBX
 epB5cM/ap6H4IsVcQR0gYiKKKGhwSDtwSGfLBIOAdfcvHAU+MvjTFnyJH3I/vZ9+1bos
 kF+aywLYGk/mbu6y4r5b+t9zalCTaIsyTO/+RVchG8p0G/VXx3PWM9UaqYgOsWWUhSMT
 zHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7qk2yqN6Imij5/sb5OJmdztELgV2Zz1vG0eRtcGX5zI=;
 b=IYLC5iNMOLJJHQqXASyvAyCsku35eK2+GMGMU2STfG51Y4VIKB9IZfLkJ2Loqerdgv
 vSStoAeVgjTXss+oE/H2YfQqFTmS+k+waEfE6AxQg52Qq53Eru6wXnHQ67RAa92ASx8f
 YV9WX3rOKbt5EhZH0TimIHICQGMtwtfCO4tF2GuNNqYqrWebwPITbr6AqzQ4r7WL9JcO
 095w5MYPFF3FQLadW7aW9S2MzMnySydETENFI9d4PFVLeg68Zc743Xp7EYoT6FDp6BK/
 MPf+1Wvk2IPQD9OGkmBJKaksiBFr5lZglAhTUehjxJqzCz7w00SQpYZFNHJ/+2Ed0EBu
 w8VA==
X-Gm-Message-State: AOAM530x9Byj67BuIOaIwr1CtIXXVMertuBa8qaEwOu6HndmFhTKYQdb
 T80RfOqze8RlQA0lekYSnoOWc+bDVmTuOThBC7E=
X-Google-Smtp-Source: ABdhPJwj8P7Ru3kxGDd0d8icpmovDfl1qkiM3mKo6VNXHfHr4wPDUYlGGLy0U1sqR3oV4NLnQC5K7Fr9D3MpJcrRR5A=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr3564358ilq.177.1590786518496; 
 Fri, 29 May 2020 14:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200521094413.10425-1-zhiwei_liu@c-sky.com>
 <20200521094413.10425-48-zhiwei_liu@c-sky.com>
In-Reply-To: <20200521094413.10425-48-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 29 May 2020 13:59:34 -0700
Message-ID: <CAKmqyKO3nvjZTHnUk8au9f+8L7h35WmBRwoJGn3FAEOcy5cLow@mail.gmail.com>
Subject: Re: [PATCH v8 47/62] target/riscv: vector wideing integer reduction
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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

On Thu, May 21, 2020 at 4:19 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  7 +++++++
>  target/riscv/insn32.decode              |  2 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  4 ++++
>  target/riscv/vector_helper.c            | 11 +++++++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 93a7a303ee..ce31577ea9 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1066,3 +1066,10 @@ DEF_HELPER_6(vredxor_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vredxor_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vredxor_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vredxor_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
> +
> +DEF_HELPER_6(vwredsumu_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwredsumu_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwredsumu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 773b32f0b4..b69d804fda 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -537,6 +537,8 @@ vredminu_vs     000100 . ..... ..... 010 ..... 1010111 @r_vm
>  vredmin_vs      000101 . ..... ..... 010 ..... 1010111 @r_vm
>  vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
>  vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
> +vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
> +vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 9dfb9358a2..8d75b3ca84 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2333,3 +2333,7 @@ GEN_OPIVV_TRANS(vredmin_vs, reduction_check)
>  GEN_OPIVV_TRANS(vredand_vs, reduction_check)
>  GEN_OPIVV_TRANS(vredor_vs, reduction_check)
>  GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
> +
> +/* Vector Widening Integer Reduction Instructions */
> +GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_check)
> +GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 00ed6a75a5..5035e0bb0e 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4405,3 +4405,14 @@ GEN_VEXT_RED(vredxor_vs_b, int8_t, int8_t, H1, H1, DO_XOR, clearb)
>  GEN_VEXT_RED(vredxor_vs_h, int16_t, int16_t, H2, H2, DO_XOR, clearh)
>  GEN_VEXT_RED(vredxor_vs_w, int32_t, int32_t, H4, H4, DO_XOR, clearl)
>  GEN_VEXT_RED(vredxor_vs_d, int64_t, int64_t, H8, H8, DO_XOR, clearq)
> +
> +/* Vector Widening Integer Reduction Instructions */
> +/* signed sum reduction into double-width accumulator */
> +GEN_VEXT_RED(vwredsum_vs_b, int16_t, int8_t, H2, H1, DO_ADD, clearh)
> +GEN_VEXT_RED(vwredsum_vs_h, int32_t, int16_t, H4, H2, DO_ADD, clearl)
> +GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD, clearq)
> +
> +/* Unsigned sum reduction into double-width accumulator */
> +GEN_VEXT_RED(vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, DO_ADD, clearh)
> +GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD, clearl)
> +GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD, clearq)
> --
> 2.23.0
>
>

