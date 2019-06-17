Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F234FC31E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0215208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="noCYXGiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0215208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0Ke-0008GS-3D
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36805)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0JS-0006YV-HB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0JR-0006cd-Cw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:41:18 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0JR-0006cE-6Z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:41:17 -0400
Received: by mail-pf1-x444.google.com with SMTP id a186so6430734pfa.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ggAFjJQbIsEorL19cGR9E+nve9A7HavuX+VwpMdaRkY=;
 b=noCYXGiC6+6GO/5Vm5LbAK8x9ZqsWNEd1xGAD7Pf9dKA/nosyIQp227qCuFsjmWQwN
 RRl9yBTUm2+ICYGOxWljAd8h7/d2m8A87bM6Na5qmb3CJGbWBMHR9FJ58peMYcBvwVel
 xfpdUVoXThUuZ8tO24UGxzwmUgAIQfh2q7/czQ3U+OX04yt1qSO/s6yiS5c3QoWG5VeJ
 OdcEAcSdoHSvgOl3ZlEQytO60igMYwYQPYexqmFUendpa8JFVPllqYHWZVe9JqlBcuCi
 xchfcimbT34c0h1AsdlzMqCZMrMYgZWd6Xpa0B9z1bYgWZZhX47wner1HNRNvXqLFF6q
 r09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ggAFjJQbIsEorL19cGR9E+nve9A7HavuX+VwpMdaRkY=;
 b=JphTs5eRZymGW+FMqcjjJ2TgPz/AW8l1bxueipu6lwAQgTuPCIqtGuMD7eNRq2Oznh
 Al5eW2axytfo5ftUl72B1gdvddah9lpRsYTaCSz6SYF68V8BhxVbr6EnIo8syK/rcKL8
 bwmCOayqoZBYwL2hvd1kpOqXGdKp+NQ/UFTcNl/3ukx2kPw/DYPjZ5pEdMBzUlsrV4ch
 YfOF4OnN1ZWxZ8nPZOm+TB1KKrOVU7sNUZW+48WtHzuieHnIEEW4SUUa23zpZushIGn2
 blpUI01fmx34kSzHIIjxHYELgk1NyWk54hhklMvPcQW888PpYwUNgghYUBu5pmdRLCzU
 ad6A==
X-Gm-Message-State: APjAAAWKL/IkZC1JPRwtlqyOtaiDbW9tYgxRaIpFPLrZDHkzd7cNog+l
 3jvEnOqwJYaTxcGUIpp2llP8EA==
X-Google-Smtp-Source: APXvYqwJHcNzIXkKMj6E2Pxo3rlrZj1sgmGjlz94j+xCI6/bSgmlvLOGM7qp96qWChrOBeSB4btYfA==
X-Received: by 2002:a62:8643:: with SMTP id x64mr82071559pfd.7.1560811276300; 
 Mon, 17 Jun 2019 15:41:16 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id l21sm12795909pff.40.2019.06.17.15.41.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:41:15 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-36-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a2e92d9d-0f74-360a-8ec9-806f0cc5605b@linaro.org>
Date: Mon, 17 Jun 2019 15:41:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-36-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 35/50] target/xtensa: fetch code with
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, "Emilio G. Cota" <cota@braap.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/xtensa/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


