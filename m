Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D347C3A5A4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2B2217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4cs9lYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2B2217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XsR-0007Ka-1Z
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Xrh-0006jg-Pz
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Xrg-00031D-Ix
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:34:13 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2Xrg-00030h-DV
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:34:12 -0400
Received: by mail-oi1-x244.google.com with SMTP id a127so14436470oii.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T+L65C5Rg8qoq1UWu3aNUCFw/66qwLveKp8BIbMMYnY=;
 b=R4cs9lYUzR7vb+cntJ1g5/uidixEyn83PxA0QfSA74fJn6ZyFGnCJlzlKNouMBrYc6
 iqbCMXCXeXpwFiMORnmC3auO4PaZojc7w+NJitAvRYZo/fXczpRpeqsf0xMNqO1nRle0
 98EZWcR9DYAWK3+vKkZSSPLLBSenoskiwOtZKpsM2svCxdjdHbnk+URfX+j6OYvI/+VO
 bwyy0ZgWsrmc2zRAfQnruCMu4Hzy8Pgxhi8N+exhDV6eh4xEBQe+CQGtSbpw3DF9WJ5Z
 bD7Xd6gLQYUyaKekjMIPb4sPaUodsUorHcWUdlZV/O7mEUwDhsU58FSY0MxNfwC3xqOo
 PL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T+L65C5Rg8qoq1UWu3aNUCFw/66qwLveKp8BIbMMYnY=;
 b=AaC91r/gMEffebIrGf1KL02x+DU21xzCL7SxvtMXPY1CL7o7pu+sWcsLKfA1VkmPT5
 c/K3aMihB0zps/pqm0Zjqkwct1Z0W9jTPRwL0UfYXCvvQp6Cw4eoQRyokEYOhTonW3Hn
 cVbR+zs1KTHfjQVOz17oLQwjGYSrxeDcRMfFa/XMcSQWXn2ZcffFk5HCupb5BVW5VWZJ
 MSh0r3qsIIHvS8RWWHefLz6nIPqTKWAPwqmxWLD52aoNhnBdFOhc0/vdFQzM7KIijucf
 HOOewcLzfSw8hWQK/O+0EbNYai8wUPvjH5R2evP/H0zv361V7+kzylWwW2krnD60+pBi
 CaOQ==
X-Gm-Message-State: APjAAAVOl4HR+6jQTsvjQaSa1ScuhWVgyOtA4mrZv2erl5+Y2lkrLpyL
 w0jlef5lOLGriszTO6kTpY7DQCRaZS+doUpjSv3M7A==
X-Google-Smtp-Source: APXvYqzSUwEaxVTlnzCxTovH5EJzCXYSnQ6wVRvkBSjLK+0qhF/eQtI35z3TUnr4h09J3ArwbcyT6UyFCx1aUi0vFpQ=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr14342024oib.48.1566898451427; 
 Tue, 27 Aug 2019 02:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-67-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-67-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 10:34:00 +0100
Message-ID: <CAFEAcA9AbEzR97-2gvpPAbGrGHx_AxGgVhh4-BDufTQUX0gM1w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 66/68] target/arm: Convert T16,
 long branches
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 89 +++++++++++++++++++-----------------------
>  target/arm/t16.decode  |  3 ++
>  2 files changed, 43 insertions(+), 49 deletions(-)

> +static bool trans_BLX_suffix(DisasContext *s, arg_BLX_suffix *a)
> +{
> +    TCGv_i32 tmp;
> +
> +    assert(!arm_dc_feature(s, ARM_FEATURE_THUMB2));
> +    if (!ENABLE_ARCH_5) {
> +        return false;
> +    }
> +    tmp = tcg_temp_new_i32();
> +    tcg_gen_addi_i32(tmp, cpu_R[14], a->imm << 1);
> +    tcg_gen_andi_i32(tmp, tmp, -4);

Minor nit, but can we use 0xfffffffc like the old code did,
to avoid the reader having to do 2s-complement arithmetic
in their head to figure out that we're clearing the low 2 bits?

> +    tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | 1);
> +    gen_bx(s, tmp);
> +    return true;
> +}

> diff --git a/target/arm/t16.decode b/target/arm/t16.decode
> index 35a5b03118..5ee8457efb 100644
> --- a/target/arm/t16.decode
> +++ b/target/arm/t16.decode
> @@ -274,3 +274,6 @@ LDM_t16         1011 110 ......... \
>  %imm11_0x2      0:s11 !function=times_2
>
>  B               11100 ...........               &i imm=%imm11_0x2

This would be a good place to put a comment equivalent to that
in the old decoder:

# thumb_insn_is_16bit() ensures we won't be decoding these as
# T16 instructions for a Thumb2 CPU, so these patterns must be
# a Thumb1 split BL/BLX.

> +BLX_suffix      11101 imm:11                    &i
> +BL_BLX_prefix   11110 imm:s11                   &i
> +BL_suffix       11111 imm:11                    &i

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

