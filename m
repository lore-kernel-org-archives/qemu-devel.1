Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0061FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD35320781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zw/T7LpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD35320781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVwH-0003G0-2n
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joVtu-0000b5-JU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:43:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joVtr-0007aR-NC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:43:02 -0400
Received: by mail-pl1-x642.google.com with SMTP id d12so3112229ply.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nlAkCT+gz2SnbpwmsNUQ83GM8hrhrF6vbGhaClWBbJM=;
 b=Zw/T7LpMf7uaeMCnwpkM6H7cDNIT/APRlS/4JklECKwO5n1VAvuGILR9Sjml8SbxPp
 whYZnSVdEA6HseHyaKGs+XmYH0d8mUZiNKDljZWJdltS8tNgb7AuJ2juy3OfMq/BHULM
 sin3eLqbYerrHCpgVNTp6U016tzz4OtHAPo+bxvzu+/30wlLutGP5szlL9qe9c8s7YEB
 Q/jva1dgxRwOr2x5vhL2fgI/my/ZVfU0gffBefq9jwH6N0g00vZS5peJboM8ZSAiexMb
 Sz4oEZPBAEyuDm0ORCjINuplFPnTXwfYVoo0WC1MlYRaRyIzG7vqPmYT8HJ0KtOMwxXs
 HAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nlAkCT+gz2SnbpwmsNUQ83GM8hrhrF6vbGhaClWBbJM=;
 b=uj0SF4dG2BXvQ2WMhlmOCeLIutTn/hzhKXBpI3TWTFODsB9NMSiWmN24I6H6nYg7ov
 uSilyqPO545zS/TtEMcDS+tNJSELR4BBE5ko+kGE4Do5S/Hjwq+XkYyP3SVF6Gm7ON00
 JjfDeUMg02Uuq2gY1OjUGYPm0IxfQHYsStnMtVyVPx9vaz7lG63l3eglS+gGA1U+azq4
 5Y3JY0i3DRFDPYQkD4mCTbApDKhoftm9gAfwkm2kzuADz678sePpSd482+oFKtu+TIA8
 MQ+F3C0sIksNTaBV6g6ihWzBtm6MqvrI4o5nIofv5VeT2CYBZ45r9PG+tff1whA8WEwf
 AaRg==
X-Gm-Message-State: AOAM531oLlM7ySpFTYO3fotUwrqOi+rxIIDyEv1Ntm7iPpxkzXILbH6w
 pj02Hv+crv3VjMGWg1rCKBZHEQ==
X-Google-Smtp-Source: ABdhPJx/nHbRN4Qr+DM9gVi8j7fPUpktV2JwyxJI+ZgMz5tjERTn/D4TEI7QI0o3eyCNP/dQ7b/eog==
X-Received: by 2002:a17:902:b687:: with SMTP id
 c7mr12187683pls.102.1593106975311; 
 Thu, 25 Jun 2020 10:42:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q6sm23143723pff.79.2020.06.25.10.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 10:42:54 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] target/ppc: add byte-reverse br[dwh] instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-3-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <199eadcf-9d05-ce25-8b7a-6a0e1a01c1a1@linaro.org>
Date: Thu, 25 Jun 2020 10:42:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625170018.64265-3-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:00 AM, Lijun Pan wrote:
> +static void gen_brh(DisasContext *ctx)
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +
> +    tcg_gen_movi_i64(t0, 0x00ff00ff00ff00ffull);
> +    tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
> +    tcg_gen_and_i64(t2, t1, t0);
> +    tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], t0);
> +    tcg_gen_shli_i64(t1, t1, 8);
> +    tcg_gen_or_i64(cpu_gpr[rA(ctx->opcode)], t1, t2);
> +
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
>  static opcode_t opcodes[] = {
> +#if defined(TARGET_PPC64)
> +GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
> +GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
> +GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
> +#endif

No.  You haven't even tested this -- it doesn't compile.

>   CC      ppc-softmmu/target/ppc/translate.o
> /home/rth/qemu/qemu/target/ppc/translate.c: In function ‘gen_brd’:
> /home/rth/qemu/qemu/target/ppc/translate.c:6980:32: error: passing argument 1 of ‘tcg_gen_bswap64_i64’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>  6980 |     tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
>       |                         ~~~~~~~^~~~~~~~~~~~~~~~~
>       |                                |
>       |                                TCGv_i32 {aka struct TCGv_i32_d *}
> In file included from /home/rth/qemu/qemu/target/ppc/translate.c:26:
> /home/rth/qemu/qemu/include/tcg/tcg-op.h:533:35: note: expected ‘TCGv_i64’ {aka ‘struct TCGv_i64_d *’} but argument is of type ‘TCGv_i32’ {aka ‘struct TCGv_i32_d *’}
>   533 | void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
>       |                          ~~~~~~~~~^~~
> /home/rth/qemu/qemu/target/ppc/translate.c:6980:58: error: passing argument 2 of ‘tcg_gen_bswap64_i64’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>  6980 |     tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
>       |                                                   ~~~~~~~^~~~~~~~~~~~~~~~~
>       |                                                          |
>       |                                                          TCGv_i32 {aka struct TCGv_i32_d *}

and so forth.

I warned you before about this.  Why are you still building only a restricted
set of targets?


r~

