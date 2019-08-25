Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF5EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487C6206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgoQlHN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487C6206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1uSy-0001P2-AQ
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 11:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1uRx-0000fN-Ge
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1uRw-0007cc-95
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:29:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1uRw-0007am-4z
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:29:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id f17so13008586otq.4
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4nviZyh8w2IVntWaIYBGw7aiWrNjdMO8FDaAgolaFhE=;
 b=LgoQlHN57BPxtoR86FtBsqWdEMeXAXCEZkqEKhV+7KxgqMNHLLFDoMUoQK+99P89rL
 brWk1M8ls+1ANE33s++kEe6hItFKXqYmA9a4o0Di5V1pvT9T2em0YXTbw9flZdX83krM
 gmNGWOS1VWuH37HoW5PL1Pl4NLaC0HvcCrnllnS8LiwhtW7TSoFaDJAm+D43vRwvHUrS
 1Ii8QjbWFwhDvZ+IKZlkOwnFx0cbjllz4XzxZmJgTk9wTddVO/sEsAjXwk4+6JqNEVO9
 DXD0O5lNhlbo5IAzYj1S44cftQx38A1Y2lVKdMNHi23M4M5LIO9eGZcKI5vW9kGwq63N
 VKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4nviZyh8w2IVntWaIYBGw7aiWrNjdMO8FDaAgolaFhE=;
 b=sdQXgjFL/2FGeUDEj4VWEPllw7bVAjVBkEhbRvklwrowxjI+5cbpbsGKyBhi/DRsAY
 jTBQ7twkq6LZVk+EFVmtux32IC5FHebYqmSGw3jLXu/ASraAUYC78qvYW/00EhDWmRi3
 rKO+aQWl33ZoFdXTZcu7TD+tQomn2GN8BBBUVApmVYTSO8I0dspUL92x0icu+my64HFp
 01gETZwz3zs0D/YGy/UVwF/gPdZnoEnPrywen7XjYS1yYFJV+aIK29Pek46uBQ1g2ypZ
 odCC/6oAoDrralmuUqGKVJbE/ChG2Pjo0uNfUNoofvhUux//gHvUaUj03h4HUHE+3bb3
 U0Fw==
X-Gm-Message-State: APjAAAVsMiiUnA3KQzFR7AWgST8UujIm3w/eYV8mU5NorRK0kTtqJu/Q
 Pl0lYX7TRFh/qoFyKXyQbZmT9GFU5a4BmSvsyOivlw==
X-Google-Smtp-Source: APXvYqy2QtQ2TWjkn/VITCeUrUyDOTGe3KaBmAtPVh2fwyYWaRfMjiuEV16HspKSlYiiadlTXKjLSAipq7yJJlJO9bM=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr799906oti.135.1566746938348; 
 Sun, 25 Aug 2019 08:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-34-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 16:28:47 +0100
Message-ID: <CAFEAcA-bpeJLi1O91ky8xHRvTr96p3OvMLEAuthd0-4b9vqUwQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 33/68] target/arm: Convert RFE and SRS
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

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c       | 150 ++++++++++++++---------------------
>  target/arm/a32-uncond.decode |   8 ++
>  target/arm/t32.decode        |  12 +++
>  3 files changed, 81 insertions(+), 89 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b6d8b7be8c..e268c5168d 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -9980,16 +9980,71 @@ static bool trans_SVC(DisasContext *s, arg_SVC *a)
>      return true;
>  }
>
> +/*
> + * Unconditional system instructions
> + */
> +
> +static bool trans_RFE(DisasContext *s, arg_RFE *a)
> +{
> +    int32_t offset;
> +    TCGv_i32 addr, t1, t2;
> +
> +    if (IS_USER(s) || !ENABLE_ARCH_6) {
> +        return false;
> +    }

The legacy thumb decoder for RFE and SRS also has
"not if M profile", which we seem to be missing here ?

> diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
> index 573ac2cf8e..3b961233e5 100644
> --- a/target/arm/a32-uncond.decode
> +++ b/target/arm/a32-uncond.decode
> @@ -29,3 +29,11 @@
>  %imm24h          0:s24 24:1 !function=times_2
>
>  BLX_i            1111 101 . ........................          &i imm=%imm24h
> +
> +# System Instructions
> +
> +&rfe             rn w pu
> +&srs             mode w pu
> +
> +RFE              1111 100 pu:2 0 w:1 1 rn:4 0000 1010 0000 0000   &rfe
> +SRS              1111 110 pu:2 1 w:1 0 1101 0000 0101 000 mode:5  &srs

Is this SRS encoding correct? The copy of the Arm ARM I'm looking at
thinks that it starts 1111 100, the same as RFE.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

