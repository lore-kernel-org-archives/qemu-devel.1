Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842AEC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500002175B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zhfekn5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500002175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlOx-0006Ao-Hv
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:56:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOlNp-0005S2-EB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOlNo-0001Ze-JO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:54:57 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:44596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOlNo-0001ZG-Be
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:54:56 -0400
Received: by mail-pf1-x42e.google.com with SMTP id g9so1529057pfo.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=MnaDvoTwObsWhz1roI1y4mc4jP6h3T88yjbG9f9hsEk=;
	b=Zhfekn5y3L+Lsn2XcW6rw1SoUehxqJP/fdGYq6odkkdgwPg2kEBxYdnM1WBcsxKEnP
	SISOc6hsF6dw1AeD+yvvqtXpS6GIudRgICdyGdLqpTXP3YE0jkS7QlV0cl0v3gkEqzUO
	QuyVNaO10UQ+H/w72qZXcDUW7m9YR7gvHy/iwbFoWJl14IFYAqfvGXaPaSDSDk5eZUMP
	ap1pXkww/IygT7saA7eXG+BMtZqQi7ED0AMgTZvlr0XlwTjx1c3fdoIQ5iP5NCr4E1E6
	+Q+0U3zhb5hWxqapSa7UTMHYLhVutvPtdJOPw8GDk/KPfDDb8OA5BVcswK27N3r09l8w
	pNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MnaDvoTwObsWhz1roI1y4mc4jP6h3T88yjbG9f9hsEk=;
	b=USLxanqndD4RSig4E6/Bu2kA7uFgCRHFfQGCBme4cfin/RL4Q8M5VPD/w1nWeN+9CT
	a4IMvSH8Vwfaw8JKaAR3jajQaGOijHVf8/0D9bhFLKtFfNc/0Cv7FaDUFNyiyVHvd2g/
	bOhlV3Pa+MfaywnQ2HU/SIWdmLOqlLP9ylt8aaG6tpQEwklijnU3uaj1qamVAId+BiLY
	CwUlGKeNlrJWVyGR4o808ge5pH/XIxYr3x6nV4qbWa5XZRseZ84+ensJzPk5R2KwIGCw
	v3bOvCiN5BfjSy46L1UskHNPGinui8s4JFxt/cU9PktK6+yiX/WCU5PAMVD+x3S2rvKC
	BsoQ==
X-Gm-Message-State: APjAAAXflZQssPpYcz4RbSTAqyNzxYEvLpgHxCycUzxHh22BpVVlEHis
	LZvwaav2M9UZGiKI2nAwZnj8eKW+Wq8=
X-Google-Smtp-Source: APXvYqx+9C7qOJfIDoSN+FYLi9txrbOkbbGcGkhHreNcQmAmpe9BMLi2gVaPtWNada4umnlpYI62oA==
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr6166367pfv.10.1557417294680; 
	Thu, 09 May 2019 08:54:54 -0700 (PDT)
Received: from [172.31.99.192] (50-248-210-99-static.hfc.comcastbusiness.net.
	[50.248.210.99]) by smtp.gmail.com with ESMTPSA id
	v82sm5314160pfa.170.2019.05.09.08.54.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 08:54:54 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190118213122.22865-1-richard.henderson@linaro.org>
	<20190118213122.22865-48-richard.henderson@linaro.org>
	<86bae9b3-75c8-64df-92d1-b4efc35b646c@vivier.eu>
	<c1dc5dbc-cbc7-16a3-9d14-c93b52c362fd@vivier.eu>
	<2004b6c4-0aea-f535-d2bc-80d5c14537be@linaro.org>
	<d0735945-f5de-5ddc-327a-53eaec40d0d1@linaro.org>
	<48937430-bbb1-6c26-3fae-6cc841580555@linaro.org>
	<8e4caba8-4e69-8af3-5c78-afafd9f8182c@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <66d2bcb8-4545-75f1-8f54-87c5291e37cf@linaro.org>
Date: Thu, 9 May 2019 08:54:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8e4caba8-4e69-8af3-5c78-afafd9f8182c@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42e
Subject: Re: [Qemu-devel] [PATCH v6 48/49] linux-user: Split out ioctl
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 8:44 AM, Laurent Vivier wrote:
> Do you plan to send a new version of this series?

Yes.  Soon(tm).


r~

