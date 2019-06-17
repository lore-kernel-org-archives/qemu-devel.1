Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE0C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F90D208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v96rEDHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F90D208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52354 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0K6-0006s2-7u
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36319)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0HE-00059t-IJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0HD-0004Bi-NO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:39:00 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0HD-0004AS-Hi
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:38:59 -0400
Received: by mail-pl1-x644.google.com with SMTP id p1so4786952plo.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S2ca6aRi1iVZhbR1Norb21SKaa7o9tYIgVG84OTL8+k=;
 b=v96rEDHxMHS7nFbiUrfoudpqlxwUTEa4eU0GkVHNX7XUD6LEP+0uE0SYCwTt+TL6Uu
 J5nUpJP04PhaOysE1HL6QX0/EwsSoNZCHQGfvqUgu5aVz5S4ixdLgAiclm+xuqh0zUOM
 0sxJdVwQ+zv1FGc5zauPtVJXJdWCaoC6RrQPuEwjt4uOtruhb5G/f4zfeZzmA3RZ5N35
 xTur93JjezyestxNIcm8PbMwDpWeh+zCfCXhkA2YA0j+v7HKkvQlCcj7X0qZPah1h/Uo
 5iJwEZYc48y8mFZFCjjr7j5m97JtSJhdAzqptwkKPAFhF1zbxpBMu5bWhLNCYLjFE9v+
 i4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S2ca6aRi1iVZhbR1Norb21SKaa7o9tYIgVG84OTL8+k=;
 b=O9St5fZWZYXx4+cuEwLDzkdv0VtRw7iARIEp65/k0AUAvttfBScG/fRdBuw0Br6xFI
 B6oX8yGB+JG54cgXWdIxxCsJYbv6MJehnAOakDpe5uBdGVx7CZh/IQKbNUl91PU18Fpd
 WLhqKrVfQIKanjiysAZtirjLM5MXiBzqjivtmHi+zMLgBq0olLEIL8p2Y7SmeGr1GI7f
 IjolZtlsvBn3nUOgfBpvziXphaDpJgWCPa7Db+iXHnj6cP6LZU5E+C/u9mSaqC6iPN4h
 oQueMwBg0Z/iFPiNDIK4tAWiNh6SatZ9L0ymUmJ6ektf9QWupwTo1TufhaWfO7dDgTH+
 sSSQ==
X-Gm-Message-State: APjAAAWf/6ddlIb/OyxDpycjaFZyBjhKU8pAZRUhzyMAVhjRFF5A+fOW
 tJYX9M3UBOBu7gi02j+Nk1a5sEfPQV4=
X-Google-Smtp-Source: APXvYqzNPS2RF9HfO3UsA37Q2FRnj1+53kUwQ9d9GA7Lr5boUErqekdR1WIog8Jph66+QyxbUXlItw==
X-Received: by 2002:a17:902:d20a:: with SMTP id
 t10mr2787022ply.52.1560811137985; 
 Mon, 17 Jun 2019 15:38:57 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id k13sm12765535pgq.45.2019.06.17.15.38.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:38:57 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-33-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <56936558-afb4-bfc9-e18a-f940a21a4418@linaro.org>
Date: Mon, 17 Jun 2019 15:35:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-33-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v3 32/50] target/alpha: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/alpha/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


