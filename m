Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FECC33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72149206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBqhwJ+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72149206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRlV-00031a-A9
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isRjX-0001eN-Jg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isRjV-0007QO-Nx
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:32:19 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isRjV-0007Ig-Ip
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:32:17 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so22495805otp.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hy18uxb89ZZQrsLX5KmzibiBKtF/Qypel7x5Z2d3dsQ=;
 b=bBqhwJ+9IuA7HmwDo1/5Gk8LgevyWIx7EB4TKepe529xZWcOOsm4ImGJnLnVlJtgHE
 O+wSYzecH6SMYoG8Auym2qvL9ECLzbZYhl+0R5/8cFTltHDcv9+tgXP/YLMaSKfF0ZLZ
 vUOmVh8aaX9ZIu0w01mESHQWvqWxot2tbfMEq9mIgf62t2wJmqGdeQ1d9Of2//CC3+mV
 8YxMsZnvBxFXOk5CGIDSQV5bv7DCAh0Ip2pbEOvIv5Kq3BW9FKzqL2rg3kS409hhGQDu
 uqIAAEyYhuZIcfATT3mDRGo00VfIVxKXdaZznyUZTaaLAQicc//5pTlJLL2LufGPgBg6
 FpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hy18uxb89ZZQrsLX5KmzibiBKtF/Qypel7x5Z2d3dsQ=;
 b=J05pZWqhHRntNICjw5/0rqlCo5/2WMZJ6jMZ2Fdoh2jXnMzrLNkIleu9ddWCQDzVgJ
 A1biKcTl6snpi2tfRNyF1CyjERMUu34kS0ZEgc+sGkLt9sRsF8V9u6u8iLkaBo38seUb
 b7+AICSWi7oa0zWGa1+XxCMEEXfjMpihYg77bKMNDKKGkO4UasmwNTXg5tGVqd+r//g2
 LzX1v5Fg3AIkzS5It507zMm8KbgnCF1Znm7t/sg2tZbhscnKO42ovqEh2jrC5cwJ/VmR
 dNAOUXevNaNsCOJEWE1gGy2q9Tp0FYcGU0P9ccb3DmIwg8plseF3KB4VW8e+jlVAVDx1
 hsUA==
X-Gm-Message-State: APjAAAUdceCrPjiTmYAxaf3VyX12EdVzrM12FbNh0AejUI5icXCyRdEm
 ooUzIy1rl7PgOvF9kYGNewHz3+4n2nF7YX/1jOMKswG8tzc=
X-Google-Smtp-Source: APXvYqzpjFnnjcWXvm9DPAgiFo9UfxH2Mz6agDxEsnaxcmhOVfi5UkQwjnpRsBCicl34SspXm/wBW1yjW7dtuaHRKxg=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr6133219ota.232.1579267925453; 
 Fri, 17 Jan 2020 05:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-4-linux@roeck-us.net>
In-Reply-To: <20200110203942.5745-4-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 13:31:54 +0000
Message-ID: <CAFEAcA8UdoaCO7WFJXuUzz-T4B8JrptUBJ+Wdp3fzUesYT-qcg@mail.gmail.com>
Subject: Re: [PATCH 3/6] hw/char/exynos4210_uart: Convert to support tracing
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Replace debug code with tracing to aid debugging.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/char/exynos4210_uart.c | 96 ++++++++++++---------------------------
>  hw/char/trace-events      | 17 +++++++
>  2 files changed, 47 insertions(+), 66 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

