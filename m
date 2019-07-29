Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDBCC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E26206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLP8Eq80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E26206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7a1-0003wx-Sb
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs7WY-0005Sa-D1
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs7WX-0007aP-6z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:25:18 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs7WU-0007XC-Kd
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:25:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so56911443otq.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tQYiCRtH26Y87PUAK+IaWA2wqa2SPbVQTyBd7IRKLsk=;
 b=oLP8Eq80zZ+LtAyH1PCXM4arflZobiuSFbfAxFMA8wz06KiI3xl7e8uVB/szZKrndI
 C5jFQZLvTZaRylFFXQUt9qw+4tvafpEYLa5pcAq+a9fh5rKY/k7h/MeFYvcfAsHL8MyE
 yVnNwDxhZApMmFWrCUpmGr9HxhU6+MEs2VcmSg08fpCrUpsi8TkigS19ElxZksTeeou5
 yTRS5s5eyT7TdyLDtA+sOwZUWBsnnbd7CcmPFNNYKpSrz0mEGAyodPRmNBJ9nHpnsJH0
 rRPZJQtLNskj0QvfvSai22kSLrzzxrmrea2wt2eKbN3B532VMVYAHbGxaBBfkE7rehs1
 mNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tQYiCRtH26Y87PUAK+IaWA2wqa2SPbVQTyBd7IRKLsk=;
 b=lzRrGxDyWUp9tYuUPDrMtiLtjvSMepdI4OUBiQ1kOeIAkkZNotMUgGl5KO/hAu5aqg
 dWepeAhWqSFFIU/g8idma6TybclvZoKzgPb6fWPmqegIMZI2QjhSfRFB/V4TgOm6terw
 BTRBEhm6YluaZKLFYQvYMlE2h3G+rh0B39mINqNkb1ortpNAc7nEKCOte+FjzwaQSkaY
 wsYQuHQjmalgXXrVf4RWujyXCjJsKLWHtSlQKQ4+/CwTJ6kAtBviva7ORu0rRZSm9hcR
 wIpRMWmohdwz0HA3lgqpI9Zjj0FwV6aoySouHvS3kPn5dn67yT6cqZESGpFDXhuRVGoA
 csrA==
X-Gm-Message-State: APjAAAVXn5YiIMElr5ZEvCFpNwdpZC11CIaygHAevar/nad20P6FR2u5
 wxrIxdSuxEfsYA/8/RIzZHIz6ynfjRMLlb3Mk65fQw==
X-Google-Smtp-Source: APXvYqyHGBy0o1S+GW/fiyxYO7K36GVf7P4Iggb0dnhOpWtUkK04b1dVFS6YyhoBhvKRlGlRspj1Bffsxx9heghLtWo=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr76836544otj.97.1564413913114; 
 Mon, 29 Jul 2019 08:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-14-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 16:25:02 +0100
Message-ID: <CAFEAcA-DG5JXVTT5tz7eJa03VWMxmq4RrujbQTk0R7KO-TAa6w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 13/67] target/arm: Convert Data Processing
 (reg, reg-shifted-reg, imm)
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
> Do these all in one lump because these are all logically intertwined.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 747 ++++++++++++++++++++---------------------
>  target/arm/a32.decode  |  84 +++++
>  target/arm/t32.decode  |  91 +++++
>  3 files changed, 536 insertions(+), 386 deletions(-

I'm afraid this patch is too big for me to digest :-(

I just spent about half an hour trying to figure out whether
the changes just to the thumb dp-immediate insns were right
and didn't manage to work through it all.

> +
> +# Data-processing (immediate)
> +
> +%t32extrot       26:1 12:3 0:8  !function=t32_expandimm_rot
> +%t32extimm       26:1 12:3 0:8  !function=t32_expandimm_imm
> +
> +@s_rri_rot       ....... .... s:1 rn:4 . ... rd:4 ........ \
> +                 &s_rri_rot imm=%t32extimm rot=%t32extrot
> +@s_rxi_rot       ....... .... s:1 .... . ... rd:4 ........ \
> +                 &s_rri_rot imm=%t32extimm rot=%t32extrot rn=0
> +@S_xri_rot       ....... .... .   rn:4 . ... .... ........ \
> +                 &s_rri_rot imm=%t32extimm rot=%t32extrot s=1 rd=0
> +
> +{
> +  TST_rri        1111 0.0 0000 1 .... 0 ... 1111 ........     @S_xri_rot
> +  AND_rri        1111 0.0 0000 . .... 0 ... .... ........     @s_rri_rot
> +}
> +BIC_rri          1111 0.0 0001 . .... 0 ... .... ........     @s_rri_rot
> +{
> +  MOV_rri        1111 0.0 0010 . 1111 0 ... .... ........     @s_rxi_rot
> +  ORR_rri        1111 0.0 0010 . .... 0 ... .... ........     @s_rri_rot
> +}
> +{
> +  MVN_rri        1111 0.0 0011 . 1111 0 ... .... ........     @s_rxi_rot
> +  ORN_rri        1111 0.0 0011 . .... 0 ... .... ........     @s_rri_rot
> +}
> +{
> +  TEQ_rri        1111 0.0 0100 1 .... 0 ... 1111 ........     @S_xri_rot
> +  EOR_rri        1111 0.0 0100 . .... 0 ... .... ........     @s_rri_rot
> +}
> +{
> +  CMN_rri        1111 0.0 1000 1 .... 0 ... 1111 ........     @S_xri_rot
> +  ADD_rri        1111 0.0 1000 . .... 0 ... .... ........     @s_rri_rot
> +}
> +ADC_rri          1111 0.0 1010 . .... 0 ... .... ........     @s_rri_rot
> +SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
> +{
> +  CMP_rri        1111 0.0 1101 1 .... 0 ... 1111 ........     @S_xri_rot
> +  SUB_rri        1111 0.0 1101 . .... 0 ... .... ........     @s_rri_rot
> +}
> +RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
> --

Why do we split it up into all these different kinds of patterns
where some insns have special cases for rn==15 and some have
special cases for rd==15 ?
The legacy decoder doesn't seem to do that -- it treats everything
the same.

thanks
-- PMM

