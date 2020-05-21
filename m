Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EBFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3224920721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdrCyBB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3224920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbl00-00055r-AD
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbkzM-0004Dg-5J
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:11:56 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:38570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbkzK-0001kA-QJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:11:55 -0400
Received: by mail-oi1-x231.google.com with SMTP id j145so6173321oib.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=pbCH7cvRDB2CSohXVGejKmfRT4LkIFOkIsMWTgYmiKM=;
 b=RdrCyBB7Wf/jG+CNlUeRouJA25mxKDV7A6bP9BMmgfsL2rgPh1Qts6x5nlb8w++0hq
 bTsO+1Y4vuyrFhV9k3EJ6QnXI9TXtaSbYfVnpw2eLZe6tz7J7t0dlOf503v6jWbDhy9B
 0zTx/SjVh8RyiSpacSeBUzQX/yYncKZPN5opDSObZCUkJnMNrP7V9mq7S29kV5EgxDs1
 AAWP8TBlqMzZkHX5mQFX7Z0UCsfTCNBT9q9S21Sxid9iTT8UdBvpgRdXSiBw5ZZgqIH+
 Zpe68FykHHg55n5JpwJu/DFYExYLPeKf7zLPJHz25P2ABIVVvDBlEbOueaK13NLb8I8+
 Wa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=pbCH7cvRDB2CSohXVGejKmfRT4LkIFOkIsMWTgYmiKM=;
 b=pt3M4fsrhuoAsdjTL5XrheJjY9w4dI/Yyo/qO+UNBjLlHGvT84uIlOocMyHWEpCWSq
 K17YN+NJepyOgPXyHo/lYSQDmcMMDsfeQuY+eFy4CIgGKiM5yx0OoV4MNWv4Nec9kMt2
 0LpeIrcsK32oC9wuA1Hbr/k2+SDDBnvJQo+Xk1YLjSPGqGjoTMDXyzGUvzf4KyaAsSAD
 evaAcl7rAgaEGoPrfkMlvtXXyhwKcL6VxBn+Kr73NHYmekRFSdjQQynxuZXMq0vOB9Jl
 DJucQZT8O4yA4LEulN1DFCbmYQX8uF6zI2qvk+InOWWTLminjmz1i5s26+0i7kFOgixF
 xxBQ==
X-Gm-Message-State: AOAM532UOekrRGGxbB5KChxI3vPK02Z7BgoBwrrI8IJE972n8ZBqHVHX
 n9uDudZmvnyN6x9u+Q2FuA3J2Wu6mXlA3OF2iCeAVy8CJxA=
X-Google-Smtp-Source: ABdhPJxLBLXCkWwnyw1PyvLWPvKfmvsSku6JjFmbsczJwSU8oGXdM/zK0T3V7kaGRU1WuCbu2WToqkDIq2AzybWavGI=
X-Received: by 2002:a05:6808:6c6:: with SMTP id
 m6mr5260057oih.163.1590066712649; 
 Thu, 21 May 2020 06:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200514142138.20875-1-peter.maydell@linaro.org>
 <20200514142138.20875-18-peter.maydell@linaro.org>
In-Reply-To: <20200514142138.20875-18-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 14:11:41 +0100
Message-ID: <CAFEAcA_odDewgV0CRXvCXAr2PNyW3x6sjqVm2wS=Rya57BBR+g@mail.gmail.com>
Subject: Re: [PULL 17/45] target/arm: Vectorize SABA/UABA
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Include 64-bit element size in preparation for SVE2.

Hi; Coverity points out that after this commit there is
dead code in disas_simd_3same_int():

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 54b06553a65..991e451644c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11197,6 +11197,13 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
>              gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sabd, size);
>          }
>          return;
> +    case 0xf: /* SABA, UABA */
> +        if (u) {
> +            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uaba, size);
> +        } else {
> +            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_saba, size);
> +        }
> +        return;

Here case 0xf is handled entirely and we return early...

>      case 0x10: /* ADD, SUB */
>          if (u) {
>              gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
> @@ -11329,16 +11336,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
>                  genenvfn = fns[size][u];
>                  break;
>              }
> -            case 0xf: /* SABA, UABA */
> -            {
> -                static NeonGenTwoOpFn * const fns[3][2] = {
> -                    { gen_helper_neon_abd_s8, gen_helper_neon_abd_u8 },
> -                    { gen_helper_neon_abd_s16, gen_helper_neon_abd_u16 },
> -                    { gen_helper_neon_abd_s32, gen_helper_neon_abd_u32 },
> -                };
> -                genfn = fns[size][u];
> -                break;
> -            }

...and we did delete the "do the operation" code...

>              case 0x16: /* SQDMULH, SQRDMULH */
>              {
>                  static NeonGenTwoOpEnvFn * const fns[2][2] = {

...but we missed the handling of the accumulate part near the
bottom of the loop:

            if (opcode == 0xf) {
                /* SABA, UABA: accumulating ops */
                static NeonGenTwoOpFn * const fns[3] = {
                    gen_helper_neon_add_u8,
                    gen_helper_neon_add_u16,
                    tcg_gen_add_i32,
                };

                read_vec_element_i32(s, tcg_op1, rd, pass, MO_32);
                fns[size](tcg_res, tcg_op1, tcg_res);
            }

That whole if() is now dead and can be deleted. Richard, do
you want to send a patch?

thanks
-- PMM

