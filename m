Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE23DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FCB206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kwewixb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FCB206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inMWN-0002mF-I6
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 07:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1inMVa-00023d-48
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1inMVY-0001as-PQ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:56:53 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1inMVY-0001WK-DI
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:56:52 -0500
Received: by mail-ot1-x344.google.com with SMTP id d7so56644032otf.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YuHS3kDBcRl5hERJRpUhJ30ZFxh6O5E6c4KqlgN4B2g=;
 b=Kwewixb6yEjv8RbdpYDnbXQ2MbukQT3B2C+v8U14TO+3xl4bYUcqNlxTuZqiFQG3yg
 06EqJ63r4D9TgMyKlfqNtqvReeijP8jNNHzRd1hSJhI0OeIOkPyJ0Q89h8b6HE3FbAm0
 LEI3mmzcIRAooJPM7/4zIRyOg0Pe4xkCg5AvZroVYouW2y1m+SJk1xZM3wYYW6N+b3yu
 umfOBXFMDMq2BmNreU5X+6+Z9mzmoQnyUG+dNbdNr0lo+dAY/e9k3APJffDqSuc42lVI
 RWi/qR37tNWNyBMeb+PJIwXfQwk23ABdQYDBKlenYD8vheFX1S40inL0AsVF8WaIjjUl
 d7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YuHS3kDBcRl5hERJRpUhJ30ZFxh6O5E6c4KqlgN4B2g=;
 b=JYRriVKLbZ1qqjHTkR7ybQozw4mreQeASWd9zkM+HlzJX6OyjjcqxOp2X0oZnlfWZN
 i01IAR3BVqoKt3Qywtd9k2KTW4sExXHfy40A9ugRmIWhX4uzrKC0nd4Eje/L77eLVbzl
 /AvRGnf2MKUvg6pMiJFCdGYqSUhIguY0kmDuU1TzL98H9xGX5cqYN+GkQILmK794s1vj
 MoVZcisWIJHfspBUIUxnfMrsJn6uacCWnC/KR0d3rYG3oMpYR/TmeVx4/TZnKxi3sTD+
 nH6MrVnk3tBCElC6cVKnvTtfFU5pPL2slGz2yEkt+J+Ct7tUCJL2wLl9u+US5aOA6Db0
 1+Qg==
X-Gm-Message-State: APjAAAVS/sU2T7wbf/U3vEbgl1FEPFD9+yaiAAe4n5WW9cyiDU5ql13i
 8dg7QstdxYbMeZVpWjDLbCqh4A9ZZSsij1C3YASERA==
X-Google-Smtp-Source: APXvYqwY9GpLb4YhUB+egdO7ugg5Yn/kQg6XThSsE5lI7R1GcYgpsLifF5QeUgtPSPS0SmaE3cSd73eUr1WVr/tsNpE=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr89886527otq.135.1578056211554; 
 Fri, 03 Jan 2020 04:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20191219185609.16748-1-richard.henderson@linaro.org>
In-Reply-To: <20191219185609.16748-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jan 2020 12:56:40 +0000
Message-ID: <CAFEAcA-WBtXM=K+n1gNxLAFzttWZDwapYpXX_Sfk_Cws7tg=9g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Set ISSIs16Bit in make_issinfo
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Jeff Kubascik <jeff.kubascik@dornerworks.com>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Dec 2019 at 18:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> During the conversion to decodetree, the setting of
> ISSIs16Bit got lost.  This causes the guest os to
> incorrectly adjust trapping memory operations.
>
> Fixes: 46beb58efbb8a2a32
> Cc: qemu-stable@nongnu.org
> Reported-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 2b6c1f91bf..9f0afbdb75 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8556,6 +8556,9 @@ static ISSInfo make_issinfo(DisasContext *s, int rd, bool p, bool w)
>      /* ISS not valid if writeback */
>      if (p && !w) {
>          ret = rd;
> +        if (s->base.pc_next - s->pc_curr == 2) {
> +            ret |= ISSIs16Bit;
> +        }
>      } else {
>          ret = ISSInvalid;
>      }
> --
> 2.20.1

This is correct, and fixes the regression vs 46beb58efbb8a,
but I agree with Jeff that it's not sufficient (and in fact
we've always been reporting wrong ISS info as a result)
because of the wrong sense of the bool argument to
syn_data_abort_with_iss() in merge_syn_data_abort().

thanks
-- PMM

