Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B7BC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E3B2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TziHy47C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E3B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxsa-0005b3-0w
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxpP-0004CS-La
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxpK-0001YW-7W
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:02:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcxpE-0001DX-Pl
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:01:58 -0400
Received: by mail-pf1-x444.google.com with SMTP id a186so6246168pfa.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XbTs0HTzi2yJshTqwj/OCiyPfrmWSy1gyUW7PW6zW9Q=;
 b=TziHy47CcJAkqFGSdXhqcx5zNOg/IuzpzYWMbf8B+ZsCK2O6Ypf/oXAD9U19bXRd83
 UeDNlY6G7uWj81XMfwXpuZztvUTOTjnOl+IHR/p8yOn1aCSWAALhwFv+zo5BvMYSGVC3
 /OF4L7deJ8L0ZUnbKom0aL0o8q44eMAlt5RKIJki+6ofK3FtfP7lf/LsJCiYMhDoH0ll
 3kTb0TCfNwX8GL0zKSS1ogEXjB0lHgh8XfVvucZtvl9hgTiGLEq1wPRsHQ4v/5b3YJp3
 ZhX3O7L139vk31w3/1b28jZ3C5b4AfLimpBi/okVX7AS+ZGQWY6MJLB1tArqS9JG6tSD
 DxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XbTs0HTzi2yJshTqwj/OCiyPfrmWSy1gyUW7PW6zW9Q=;
 b=bOloUYMkvW1uQUJPyFxoyYbbqh96xaZ/p7EU6hcJlzfKTDMDP2GsIo9Pij3zJAo08u
 cT4YW7ZCU2xpciOUV6CY3ffCUklSZ4d+Oux6iOrgwBDNHnpeZjYduQ9qFB23N8kSjZwk
 ji0Kg7f9x5U9+RcvripMNoemMDmBSDqIR4X/PBWWeWXgxlC/nV75qgVG2guBN66+z6D3
 M7jErLAA6mmvQo8RNKxWdMGBHSX6+hm7ZExc6tgI7TXKnfcFsL2d7TMq/Ky3Lgmyv1cL
 YCUO/2NZ+B7ljBdpvo6FXWZT5fKTGRg0yqSSTidEUcEgSoH04eB/RlIOdvHaIOFdGZjD
 gYLA==
X-Gm-Message-State: APjAAAUrHxXjaq2WxTUsBY9NeWM2B394ADWEpr/aCviDrFA5Botmu2pF
 ssYecc59fBrPhmy10DOoMFlc9POLyfw=
X-Google-Smtp-Source: APXvYqz5stPAcKfo667esIksLq8FP2qtYZuSzcLFyKrey5F56xySHylrQ/ipo8Vf7/hXOvz/q0O4+Q==
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr751949pja.8.1560801700878; 
 Mon, 17 Jun 2019 13:01:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id h2sm10702293pgs.17.2019.06.17.13.01.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 13:01:40 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190617175317.27557-1-peter.maydell@linaro.org>
 <20190617175317.27557-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cb2ae0ff-a1cf-19a4-50f0-6cd5e22e8974@linaro.org>
Date: Mon, 17 Jun 2019 13:01:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617175317.27557-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 4/6] target/arm: Use _ra versions of
 cpu_stl_data() in v7M helpers
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

On 6/17/19 10:53 AM, Peter Maydell wrote:
> In the various helper functions for v7M/v8M instructions, use
> the _ra versions of cpu_stl_data() and friends. Otherwise we
> may get wrong behaviour or an assert() due to not being able
> to locate the TB if there is an exception on the memory access
> or if it performs an IO operation when in icount mode.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

