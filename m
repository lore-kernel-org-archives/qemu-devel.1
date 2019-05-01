Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CBFC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D536E208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJzKDPwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D536E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59968 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqQ8-0001DD-60
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:41:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqPC-0000l6-7N
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqP9-000554-5E
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:40:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqP8-00054F-U4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:40:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id o5so8265112pls.12
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=obT7erebz1d+uJV0k92Xweva75iMWYWGKyB+KwrkqU0=;
	b=GJzKDPwFtSV6GVWi3gE2e+F8JOjK63JYbHkmTdvmNtKMvE9Esvm3Liz/ONNVa6ydnp
	kw4O1YQGEJ1bODn188R2LDvkeLxCfP8Poe7YTreAkZHclRscXTlYkOIXIDL60YVbqkQ5
	UGhuw6aRyfZFbqP9LqPqAk4RM0zScS9NFNXNfVY050DJg+ag09TJ5Fj8rBOxLeJNLwZv
	YgS4eyHAHaP/ujXKZ4d/N4SdlYBN9YbM37kpXfvRdIHWdBYIQ9/c6LI9ghmYW5sWNuZK
	4VV6jWL8BMAR/O4VNSPDY4X+HM6P9DaIv803FuXZV4vbNxL8nvUsnKkC+PvayoWUcSoV
	omiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=obT7erebz1d+uJV0k92Xweva75iMWYWGKyB+KwrkqU0=;
	b=OLQz2pca0buZHeSeFSdkrrnVx2jQ2EfYdX0yml5M/h5tL1d2MdGhRqyTVwEOjZrLKb
	cd18eXKDhBJsSqfCn5XI7zyy6KJsYNWu7lQsXj7ApNSpwLimFEJXdHQMfIUwGR9i2UBF
	/Ce4+3x77MhE9oFGwvM4j/IT5duGacVxr+6LNUITv0sf5cQm1oy0vsx/cE9ZyNvsm2nX
	zI4Q89xzcUZYvKd/t67e5XTcKukclC5+qvUmwkqyHWnMZM5u8hhQ8X1vxJTwAo8gPz/p
	Ouf73nOYMn7Q/j5iFAaXyshIVb7DUHWopK1e9KPyecfEEA76KrSPPd8ZAwoQUM5YHYbK
	8FnA==
X-Gm-Message-State: APjAAAUKPqopTJ4O5Hiw9kMum79RS03yJQf2VB2+VEfp/YKmUY6v8mMN
	UzJUgFBXAuEsHPBvrJiBJJVtyQ==
X-Google-Smtp-Source: APXvYqzUlMRoGauejCkYc02M9GKqXaMD4sFduYT8/gsVu/dCy7E95L1MxqhHv1CXeDOS7z0TaZUriw==
X-Received: by 2002:a17:902:7588:: with SMTP id
	j8mr14365422pll.332.1556721613481; 
	Wed, 01 May 2019 07:40:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	h20sm105922242pfj.40.2019.05.01.07.40.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 07:40:12 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1b33ac75-d531-1a9d-46ea-f392249e2a19@linaro.org>
Date: Wed, 1 May 2019 07:40:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v5 05/15] tests/tcg/minilib: support %c
 format char
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501144010._lWnHruq5sE2EojIoc0BbIwt98wqPnrH3oefStehgO0@z>

On 4/30/19 9:52 AM, Alex Bennée wrote:
> @@ -119,6 +119,10 @@ void ml_printf(const char *fmt, ...)
>              str = va_arg(ap, char*);
>              print_str(str);
>              break;
> +        case 'c':
> +            c = (char) va_arg(ap, int);
> +            __sys_outc(c);
> +            break;

The assignment and cast are both unnecessary.
You could just as well write

    __sys_outc(va_arg(ap, int))

but it's not wrong so

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

