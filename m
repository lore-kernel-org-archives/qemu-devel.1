Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2012EC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7522063F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXS79DDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7522063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxOk8-0004IS-3L
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 00:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41279)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOjd-0003s6-Do
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOjc-0002QV-Ja
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:48:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxOjc-0002Q5-Dg
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:48:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so12745736wrt.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 21:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ATMpykquasTK3TlFhulRGr1azOmjYnsKQPd89bGaQL0=;
 b=rXS79DDF8bMR+BDH88CvNrtWIrqKhNI95w/j9CLxC75vGKyZTSI3/PrQEIjnKarWC/
 PHK72nHP9qIUjL6QtgZqDye5JczXT+p4ekTqOz8Ltu637RuwmkNN8BJQgEdYqxATXALT
 0tEiPL2mXq9JhmIV+49BnBUlyVNeZY3vk3pkJvE8cachT0XRMlCSRGZWDJZ8YI5X99EZ
 O8SplHUbtzCOqPlrGwzXH2WhnkVJg0aXVm+Co0H4jsdmNA9f6bom3H65T2LMyerVjf0Q
 to7sK6958wyOzbYMm84JmXEex8ma6Y8U/ipP+tGA/Qv4iuBCRr5ZzFzrBcQn+QJu3jaN
 t3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ATMpykquasTK3TlFhulRGr1azOmjYnsKQPd89bGaQL0=;
 b=OeP+lLYn8WVo2L3y6ZWTPpx+uN9y100es2x211uua/Y1M7PjvajNPYrIZMR3vcfwJc
 EnE8kIgCVtzXKqgqz3rfhrtpo9gr8URQaXgey52o0ZT9KzOVuAD0U57yyJjwBWmOr28X
 9qEAf1y9k3i24GbOrnVe6F18ZZvDBzzNQDS6A5IfLatXDwccLLyHoWJO3yty1NKaLvhm
 vfNCkrTXlXcqy8Vlo5d3E6n6lalrXrSO93hBI8/Uif5r+x6rJzjxKloLF4bhT4MRzhoE
 x+ftxITyQj0sphMANmFtkSVcH2r1LX4D97HKazTmnSKfl1in3Gi20naLJLhkkD2UL2rI
 n63Q==
X-Gm-Message-State: APjAAAX/623yqnkoElkip+Z0ucWkgCOw8OEoUOckQzmdnx+0lW06a3f3
 bS6Z5yxH2QjEBhvHNZCQscAbpA==
X-Google-Smtp-Source: APXvYqyJrj/H5sU31FZsnnvvsznsaweML33UgN6dZ0OQtNnH9+s680U6Vemj1xg5iOAi/1ICp7RlcA==
X-Received: by 2002:a5d:4b83:: with SMTP id b3mr39003991wrt.104.1565671715510; 
 Mon, 12 Aug 2019 21:48:35 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id o20sm268537584wrh.8.2019.08.12.21.48.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 21:48:34 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-5-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <445e9065-72f3-ac75-26e3-2b26317a0cb0@linaro.org>
Date: Tue, 13 Aug 2019 05:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-5-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/39] target/i386: use dflag from
 DisasContext
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 5:12 AM, Jan Bobek wrote:
> There already is a variable dflag in DisasContext, so reduce the scope
> of the local variable dflag to enforce use of the one in DisasContext.
> 
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/translate.c | 184 ++++++++++++++++++++--------------------
>  1 file changed, 92 insertions(+), 92 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


