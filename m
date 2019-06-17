Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08816C31E49
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70092089E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2ngTbNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70092089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hchA3-0000yN-3Q
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 22:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57681)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hch9A-0000N4-9X
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hch99-0000yo-F8
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:13:24 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hch99-0000yO-9N
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:13:23 -0400
Received: by mail-pf1-x444.google.com with SMTP id i189so4758071pfg.10
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 19:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dnEDf+Fv2UgR7YK/7gscuxkdUSPSo41jrsYMOjx8zRI=;
 b=g2ngTbNEzhishbx3rOnlYQiIpLZm+jkMgFTRt3ugQbzY+wzy1ciQoHd43W/8nKYjVo
 mlaY2CYwqfz+zttGz9cM1AXKDYW61tetNUkk22OYZddfbQxg7rwm4c7wBn8yXsN0Bjr7
 ZHgcoY/8S8Yu0jxp3ICN9aJdtG0o6Ag10oyPmpdALLZJjYZs0nqdE6s/FU5OCClRwqmW
 AZoZnPm0bh6NeAX+1SX8lJnMaV3V8pVXbhKGBzAtAzqxEPr5oRLMauMrB/Qne25JOKVj
 AU3hIzHoiY/e02S8WliRvVsmFlDl+Uz4PsNLfF0S4MyvDKOc2sSaq0jTtDSsFbBroTZm
 7FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dnEDf+Fv2UgR7YK/7gscuxkdUSPSo41jrsYMOjx8zRI=;
 b=l45JoKVQmA1nMQaqjgOumUvLVGHsXKFtn1BpVkyj4lCsUKQAZJg14dhiOX9QcFnJK3
 To/DzDy7j2wtWcxZBIOSd4E8rs0UaaQWsxadIDP0bOzhnwi5rRnffUxaEnXiXjOdcaGC
 3YGrxXTiod2bTuvxxYFtvm+2MjBfTAeIBqSaDYpo38z+2KDapWJTFdBMAKEbe2g85243
 ZLm33qLVRTqz9TxGP0HqxeaJlMup/m0M9eqqsg1CjFfNbJTj8qJgpcr1gFAsWBeRsEcB
 uV7X0WkQdTsVkyyrFJc3fe18Feit7M0NBuB+/8gfhLTxEkgNWy0GlvsmjxHSgAgSN9rE
 QGjw==
X-Gm-Message-State: APjAAAWuzvnuhj+M/te7ej5CZ8CR5QjXMoNP7yuAOj2GA5B934iMMfmc
 n3FIARiDX1/vSv+SDWUvuyrsLg==
X-Google-Smtp-Source: APXvYqyIQ57lyTB3fwpYjpZUJpBplh9OjtJm2leqyAhBY/syHVnfU7b2NbgFKdB1G/VwxqM5TvLXGQ==
X-Received: by 2002:a17:90a:9382:: with SMTP id
 q2mr23925500pjo.131.1560737602243; 
 Sun, 16 Jun 2019 19:13:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 139sm9859523pfw.152.2019.06.16.19.13.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 19:13:21 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5433d93a-705c-9f94-9ebd-658c80b11735@linaro.org>
Date: Sun, 16 Jun 2019 19:13:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 02/50] tcg/README: fix typo
 s/afterwise/afterwards/
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
> Afterwise is "wise after the fact", as in "hindsight".
> Here we meant "afterwards" (as in "subsequently"). Fix it.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tcg/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

