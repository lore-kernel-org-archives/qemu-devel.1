Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E06C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC322081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ip6IYdHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC322081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLu65-00028w-1N
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 14:36:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu4i-0000im-R7
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu4h-000154-LB
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:24 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:41956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLu4h-00014N-0Q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:23 -0400
Received: by mail-pg1-x529.google.com with SMTP id f6so8641297pgs.8
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=/JQSbGM/O19FqjA8tccpETQvPRZf58W19j52MJxDAkE=;
	b=Ip6IYdHKykjavxxak7ouh2KLbvcSxTYCb1KNrElaglbEF7FYYRI8xBgVmO6JrZcUVD
	YT6LzMxOZf7Jd0UvLeqbgSwi24iHQrpsQcMK5sevIeVG+fxvWM0HC17RKLPVAjAcrdk3
	/g+m9hsGqwxknPle515lXpkdqdOP7/ComJM2U+gWMfAKkgR3cSxUCLCg250Ckaqix9Xu
	MnrZ3UmrhQwNYDw/b/l8c8Bec9zLMbYf62vgU1OJ3HXE7XnxjW5xHoXHVXAIdI4z33Oz
	D3a11N3nTrx+67uC7X9rTD0PaDCmd2gfgKNrqXRjw9YQ8wvrG+xiC3RMZFEIVILUQu5L
	mFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/JQSbGM/O19FqjA8tccpETQvPRZf58W19j52MJxDAkE=;
	b=ZmD9tle3JI7wnw9qMLKYNZvWcUH5uI7G8SfYg3krrISCEvwQ0QNWjjgAyzN03aznqr
	/c1M7IJRW860hx/MCUEHXXqfAgwYN1jKHWNmP5UdVrISIm6EKMAe/5LSk24IvT3b6ra4
	Fgazgqeixf5rdKEY+d4uEMhNQwU8YvFW2JS5MoPmWn7DmtZJaTcbyvBdTwnihiitApul
	WS1r+v08u9PBCoM7ORvsX7XUWqHzCnhxZIA/hLeedO5zouV3XCZWAhJoutdI+dScNx+X
	bxsM+ncUooa2f3aoZ6cDc/WOE9pGo+YgkmMk4f+gQqiCT2hIDVrEbXk6tz+jSev/IcBd
	b7rA==
X-Gm-Message-State: APjAAAU/xBFLJiHmhsojorQ2S0djvEmE/CZ6SfHxSCohlvz6JBY4iR3k
	tAhBNagIIS2xxKQ33OgbzdAQ3A==
X-Google-Smtp-Source: APXvYqxNBQzlIm1ZGaYSLhe1PHkFnvh8szrv3LWygBa74uFdNdrP829aFQZR8doOED3iwg+jBauAfQ==
X-Received: by 2002:a63:d908:: with SMTP id r8mr42526024pgg.268.1556735720714; 
	Wed, 01 May 2019 11:35:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	g13sm13384891pgr.63.2019.05.01.11.35.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 11:35:19 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0ef0d685-ddb1-850e-9478-e9c88da8ebb0@linaro.org>
Date: Wed, 1 May 2019 11:35:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: Re: [Qemu-devel] [PATCH v5 01/15] tests/tcg/multiarch: add support
 for multiarch system tests
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
Message-ID: <20190501183517.LbT8hc1OJGnRkMzKYqRKJGdH5mVp44ZpPNfluiNdOsw@z>

On 4/30/19 9:52 AM, Alex Bennée wrote:
> We can certainly support some common tests for system emulation that
> make use of our minimal defined boot.S support. It will still be up to
> individual architectures to ensure they build so we provide a
> MULTIARCH_TESTS variable that they can tack onto TESTS themselves.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile                                 |  1 +
>  tests/tcg/multiarch/system/Makefile.softmmu-target | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



