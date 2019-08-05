Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA854C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D592086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8w3vzc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D592086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huf77-0004Uf-A9
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huf5w-0002JP-50
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huf5v-000891-3n
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:40:20 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huf5u-00088C-U4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:40:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so57354023ote.13
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9qbLq7WRTEmy+sTg4oGPeIHaZG61/h7NL2vAEF+G4bM=;
 b=U8w3vzc203D49LV1z4536ztvut8mnfyupJ1/zuLdXdKFjflWXz0huDC+PTOAUkHQN2
 cse1QzCzKl6HqP6aiedhFT/SLmbkVDqzz3AXbrsr+VrRF+TLhNt+VsazdyN50NbIVzi4
 K/FNtsu6NcU1d9HVEdmuHn0JjUq7G8oyefZGgQLrklxUbukyP+5pAb8MCU/9OuzXG0Qo
 UUbZ7i2eH0XwHDaOD9B3H/799y9VGX3LdrClVgRpZbpiE42vQeKM/U6x/vRR7i2xJuuH
 tWLdPDNJY9qaUa+JcdHF43vqkFRhTWNlR6jn9gpqgr6dyhRfZu9PA9oHhPDiFVRqTyn3
 g22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9qbLq7WRTEmy+sTg4oGPeIHaZG61/h7NL2vAEF+G4bM=;
 b=SBIv7VUWOsgbNNmcK6ensIDePB+ccYiuxV9oxSG5YoqC+CRMv96fi6rccy36GDWcBI
 9oCmcjEsGf+Z0TPU9kIVPXqhm4y3MLToRZnuSBtlFYngGL+6YJZfArmjJS5mjiF37L7y
 dla6d7XXq+ubbR/diB/nE1lBys/wttsoQ3xEVDRvX4rTzGGNDquwtNtfIRVFNwqwshMK
 XdEh+fVcZaSfic88MqMKrqMPJn8DkHM8fgfL+ZDIOznYnrEq5Sbh5KRaNOdcb94ye+lf
 52qzxB0hrbl9mIfhsJ7LvT0mIU9MVhzR/f4V88oxtqA91dhrRiPDXkZDICrYf7a9R/gN
 jUCw==
X-Gm-Message-State: APjAAAUw8kDXBrN4obwfH4wbDS1MHCpZNw8WBG7LAA0uYA/qxEBTCAcr
 lh1vC/ghJR98Kmcb+XU3fwIFezCLE5H36oYTYefbuA==
X-Google-Smtp-Source: APXvYqyKYizBzxBVZYpNq7b490RwvjKNKGraQXFedDARrVTsSXi8tlIn3kwYS7Ufv/HM1HJc02/5647lMxfPXOVD7X8=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr11739738otr.232.1565019618017; 
 Mon, 05 Aug 2019 08:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-16-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 16:40:07 +0100
Message-ID: <CAFEAcA9h83Xh0D7XjrLBiYB6c+CtP6=ONk8=2ME_4VZGpkhrLA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 15/67] target/arm: Convert Saturating
 addition and subtraction
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h    |  1 -
>  target/arm/op_helper.c | 15 ---------
>  target/arm/translate.c | 74 +++++++++++++++++++++++++++---------------
>  target/arm/a32.decode  | 10 ++++++
>  target/arm/t32.decode  |  9 +++++
>  5 files changed, 66 insertions(+), 43 deletions(-)
>
> +/*
> + * Saturating addition and subtraction
> + */
> +
> +static bool op_qaddsub(DisasContext *s, arg_rrr *a, bool add, bool doub)
> +{
> +    TCGv_i32 t0, t1;
> +
> +    if (s->thumb
> +        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
> +        : !ENABLE_ARCH_5TE) {
> +        return false;
> +    }
> +
> +    t0 = load_reg(s, a->rm);
> +    t1 = load_reg(s, a->rn);
> +    if (doub) {
> +        gen_helper_add_saturate(t1, cpu_env, t1, t1);
> +    }
> +    if (add) {
> +        gen_helper_add_saturate(t0, cpu_env, t0, t1);
> +    } else {
> +        gen_helper_sub_saturate(t0, cpu_env, t0, t1);
> +    }
> +    tcg_temp_free_i32(t1);
> +    store_reg(s, a->rd, t0);
> +    return true;
> +}
> +

> -        case 0x5: /* saturating add/subtract */
> -            ARCH(5TE);
> -            rd = (insn >> 12) & 0xf;
> -            rn = (insn >> 16) & 0xf;
> -            tmp = load_reg(s, rm);
> -            tmp2 = load_reg(s, rn);
> -            if (op1 & 2)
> -                gen_helper_double_saturate(tmp2, cpu_env, tmp2);
> -            if (op1 & 1)
> -                gen_helper_sub_saturate(tmp, cpu_env, tmp, tmp2);
> -            else
> -                gen_helper_add_saturate(tmp, cpu_env, tmp, tmp2);
> -            tcg_temp_free_i32(tmp2);
> -            store_reg(s, rd, tmp);
> -            break;

This is changing the way we generate code in the middle
of also doing the refactoring. Could you not do this,
please (or where it really does make sense to do it then
call it out in the commit message)? It makes it harder
to review because now I have to read the patch for two
different changes at once...

thanks
-- PMM

