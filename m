Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01753C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFEA720872
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cM3MSZJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEA720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1F0-0008To-0P
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:27:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1EG-0007z4-IC
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1EF-0004EI-Mi
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:26:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:41122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1EF-0004Ds-Fx
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:26:31 -0400
Received: by mail-pf1-x436.google.com with SMTP id q17so5104672pfq.8
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=GWb6+6a4X6Kt4ZfOxfkl0cYoWVHMxYPxIoHrQOXCp14=;
	b=cM3MSZJJDN73NQJROUglbAUE2gYOmKVSbDuyEmAbyg+yRbjB95sxcPAEPy++wb9ekn
	zuKZ9+Txx3wOJdHggPACQXtL6sAc0RgZab/oJt9f6Ga6GIyZ+lzM8FNoZHpAE/03lT4v
	IYts7UbEs0+Vaun80WHJzFn5axAviy4SgmJV1stD9z4KKuOoQuDTJ3gJBeuduauApBK+
	Qd8KPPr0vCGlngwN0IEJ2OmD7+ad+9sUvuHLQqG5UDdSbVn4z+Ju54Y5oaH7bS5c+D8L
	hyMh7RhPynEJScHBG6+VJ0oTw/VnpyC+w0iC963b29jD/dA/TJuPwvKSiIlOmQPty+CF
	b6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GWb6+6a4X6Kt4ZfOxfkl0cYoWVHMxYPxIoHrQOXCp14=;
	b=bGCU2ez8rSypJuHwBUJ5Tct7BNiBSBS2Fv+7NpUhjYCh8/YM7e3w7OicBi9fSApCxK
	WnMpNdo5mTY/2JXFvKQ/CFqPii+heLIjVHgMBuVA6q1DntSfVU9dUY3L9d2/OmMtFdin
	rgLphTpzOjQj/AT+eiq28GNQCGirJ/meDNGAVDBR49sBYuj4wcYzx/82HkRtXJgI9BOE
	OlF9Bi4Q/MOREvy7beQK7rXz9ERMEVermlpjPQOBzh1LKPu5qZeWwCzXhLDY9u2UMTzy
	kNTxQ0rXyOJz/BnFLnto+60Ho7M8rstOMxbuUaX3VidNZDWYr5gVIvwL1Cez1r6NZ6mN
	WFEQ==
X-Gm-Message-State: APjAAAU7R57LK2Inv4boIlRhrWyWhqa1j+ao7BI9WQAlLeUjYJ0Pa7h7
	uS2YA9ry5gw5NR4xv3Y8CpNj8Q==
X-Google-Smtp-Source: APXvYqyLwNFPuq9xWTBlF6c4Gze6CfrMq7NrbExwtPevmvRTnOkMOMQMfcmpzbpNby5Q1pNOhmNAzw==
X-Received: by 2002:aa7:95bb:: with SMTP id a27mr57044321pfk.30.1558193189384; 
	Sat, 18 May 2019 08:26:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	l7sm9500219pfl.9.2019.05.18.08.26.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:26:28 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-2-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a0a9d816-c16a-4071-50e6-aa29a817df53@linaro.org>
Date: Sat, 18 May 2019 08:26:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-2-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::436
Subject: Re: [Qemu-devel] [RISU v2 01/11] Makefile: undefine the arch name
 symbol
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:44 PM, Jan Bobek wrote:
> At least GCC defines the symbol "i386" to 1 to signal the target
> platform. We need to use "i386" as an undefined symbol in order to
> correctly include risu_reginfo_i386.h from risu.h. Add an -U option to
> the build command to make sure the symbol remains undefined.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

