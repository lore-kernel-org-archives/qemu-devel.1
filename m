Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4253C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07CD204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMLIUHgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07CD204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpQo-0004ec-UN
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:14:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpOV-0002sw-Tp
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpOV-0005ho-1F
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:35 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:33678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpOU-0005h2-PL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:34 -0400
Received: by mail-vs1-xe42.google.com with SMTP id y6so3822488vsb.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=wC3UR6u8dZDnh7XynwOzXaqOC8XFwBxoBcdv7qIHYfE=;
	b=HMLIUHgJih2oVMi2BlQb+ltJN/RC4l5uklDdKiGnrBr4vmtEeiQrMGfwOSmXJ18ONX
	3/aSi6uZE38niukwdpXCqFi94JX4Gw6/oBYEklMSuNUEMeTVhX1OEKOUQvi+mXSChd35
	4jn5Winh9cZTBSVWPTTFA5f9IlERokcFiVDUt7WlT/Gkepp6zqEijIYNj396Kh+vuJ7L
	AGlxf+v4kHO2HW3ZkmcpRmNmRy1AtWi0qWi1/hU7aLfrbAlCBnhboWDe7TMPKQsJXSZ3
	jmrEe9mHJknjhlnPHsgNnCVaBZ+EbIqvdPkgOUNvQm48jA9DfEkNHKkTnMx7jxF9pk48
	8KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wC3UR6u8dZDnh7XynwOzXaqOC8XFwBxoBcdv7qIHYfE=;
	b=Y5yeqQJLwD9tSluGQ6jYeXwVCcQiEFL3WJ98pCQPhtaOBtluTF2dTTU0s2XUmwBKna
	VqpZR7D6CIYXZuskwzOGlTVWB9WCa1bRXkA4WMr/RYVTb4szbtmltzWtCLcuHBU1OK9C
	4eE3VEKw0X+ktFZJRlH+R6Oa0SD2hqXGKIyejOoIn8H8ixHWubyZJWhmObZuB3Qjb7Y+
	CJnE5xGKg2WpywCRv90CYOZF1JL594PhhXmcyfVt9mQSNKzVvwnPh+uSgED8TDvVESXF
	0RcCUh2dziErVkQuM1oc+uQjLTYdnVGm1UQFI+K8vHZ+ccrO5HVBBXcS28o0JSR9+fxu
	z3vA==
X-Gm-Message-State: APjAAAU/9OWwErmp8ZmN0m5UChFaGGMe52hfZE4CJYkNAzxBGWG3nndg
	3uQ2/pbt5NDiH8Ts1/7YSBbkJg==
X-Google-Smtp-Source: APXvYqw33ySFh92vOl0HjHAeIoMUhaFTBZCqbcBmpDxH4I+bv7tGDEiHjhX1LMrO79HwjfH4K/ysEg==
X-Received: by 2002:a05:6102:1c7:: with SMTP id
	s7mr31887879vsq.136.1558624353876; 
	Thu, 23 May 2019 08:12:33 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	143sm13796557vkj.44.2019.05.23.08.12.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:12:33 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e6c89c18-48df-c85d-39a4-2299f1026cf4@linaro.org>
Date: Thu, 23 May 2019 11:12:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102532.10486-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e42
Subject: Re: [Qemu-devel] [PATCH v2 01/28] semihosting: move semihosting
 configuration into its own directory
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Chris Wulff <crwulff@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 6:25 AM, Alex Bennée wrote:
> In preparation for having some more common semihosting code let's
> excise the current config magic from vl.c into its own file. We shall
> later add more conditionals to the build configurations so we can
> avoid building this if we don't need it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

