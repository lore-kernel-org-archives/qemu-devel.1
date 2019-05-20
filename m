Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5FBC04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC99D20645
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F28fQb2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC99D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSYb4-0008K0-1I
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 23:04:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSYa9-00081x-TE
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSYa8-0007PP-Ry
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:03:21 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSYa8-0007Ou-LU
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:03:20 -0400
Received: by mail-pl1-x642.google.com with SMTP id p1so618812plo.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 20:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=1DX8igjHstYRcOPI8ZoSyYvYiERSnw6/WEG2dYqjicM=;
	b=F28fQb2nPfkL30+d+c7IUSvg5Oiis2NFneBSCkmzHoLT8SlwOSbKp+/9CoVmREE8w0
	t37BAp/a3xpXgjEYqjOPcGokzwcVnR2m/e6o6/xhP798Z56+7s43lJsALUEJLJIzaLY6
	LqH++kHgf00fF+wJVU20rtCBA4KP2Zb++LzWM9sXEP60/Pk2ooq5hXG/2jbayXISQN9/
	3xy4D9vSGO05AUrlOlqlujKvM3Cd1/9xcUISawwLU3SPP6/ERhzG+CFxtsuV4IFzipu+
	M0PF5NLhTkJTNQnlIKJcHgsxN1U5xBOR0w8rePX7udVPJxnnzdQOkR6wV16jsubAxO1K
	BL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1DX8igjHstYRcOPI8ZoSyYvYiERSnw6/WEG2dYqjicM=;
	b=pVAoafZETpG1C5rrgbd+J5opymj9M911FyoC8WeQRp6WbJVTOUQBSRGZMWs4NQ9dUo
	jBrKtbgfMmUQ9yD6JAPTtzNI6idWcoURrYjP18CfKfYdZsJfKjV9OYGNJhBhxGd2iTY7
	pczC+cXYeYF9PTEgXkhaTZJ3aMinJ7gQ4W240wZFLlyNxMYRjTHI4nUy6G/eeHC5fWeW
	ZbCokbtVLhnwlp2xonMPPbrQFUXJSvxXPA1920V4n09NhOlu3KfxqRaM30Iux5pz7989
	A6ZHpUv1b4B7vw9mJdEH6d2g4w4emYPZEDCyYLjNB+RrBDmv2hQrsMsK381xuYiYG+WV
	9u3w==
X-Gm-Message-State: APjAAAWFoKYflbsHPZq6/DLNaPY2KaRPevHCpJYFtQxWGVh6FrfzETa8
	1b835hF2dbRaHK+6G97TP3sN9A==
X-Google-Smtp-Source: APXvYqyeEjCuHM9nbhgCipvYUIoGM5Rkvr1VVhjE7u4jFxLVwN/hBqRYff1HYgJR6qjLSyuWwoUpbQ==
X-Received: by 2002:a17:902:e785:: with SMTP id
	cp5mr54756561plb.167.1558321398953; 
	Sun, 19 May 2019 20:03:18 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	p7sm15442879pgb.92.2019.05.19.20.03.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 20:03:17 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190517133149.19593-1-laurent@vivier.eu>
	<20190517133149.19593-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5a1092e4-4f66-7711-6afd-bd9528b086c5@linaro.org>
Date: Sun, 19 May 2019 20:03:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517133149.19593-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: add pseudo
 /proc/cpuinfo for sparc
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 6:31 AM, Laurent Vivier wrote:
> SPARC libc6 debian package wants to check the cpu level to be
> installed or not:
> 
>   WARNING: This machine has a SPARC V8 or earlier class processor.
>   Debian lenny and later does not support such old hardware
>   any longer.
> 
> To avoid this, it only needs to know if the machine type is sun4u or sun4v,
> for that it reads the information from /proc/cpuinfo.
> 
> Fixes: 9a93c152fcdb4ab2cd85094487b33578fd693915
>        ("linux-user: fix UNAME_MACHINE for sparc/sparc64")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

