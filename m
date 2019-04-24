Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B06C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B0A2089F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrfVP8j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B0A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ5XX-0005ip-Lm
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 20:13:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5WQ-0004Zp-Tl
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5WQ-0004O8-1J
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:12:22 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ5WP-0004NV-Rj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:12:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id v2so5995580pge.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=/fydwa7araE5rDPRD4fbYYSPjYQ9EqylFEpViLH5T5Q=;
	b=DrfVP8j4Bm+OizsAC68THmVwEifpRtRd8OsviMS/rx+/oQacKmfDqJ3m9LQVyM/snm
	/dPt4qyB/xqCaAZcwBPUyLhS+QkZzqv6Vqa9lLLncTLhkuxlLGKGOgr10+IE8CC6JNvr
	dUpJPgSeNKt6EUUQRjlyP8lrme+6kCu/4PwZXaPcSEjmaQ7CUp1iROCZnraJkcZwFHgN
	mYN7MlQFbWgy0vLOLnfU5dHc5o6Q33qpXtrtztSZxOg9PoEAdA3B1m7czGukuMt8JMQf
	5dqWZy18HsFf7aGZDExz/FXsy6cGJmz6rtemUhoYpuxtDoYTlI99c1aqOJVg8iZKZebP
	YDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/fydwa7araE5rDPRD4fbYYSPjYQ9EqylFEpViLH5T5Q=;
	b=LEWEvobxDfInZwrIJHF8J2/Smq05VwcgbNMusRU97sgh2vnGfeFD3hDUpmh9kjrS1x
	jiy0xVUiDcT60OOJv1WXEp3VWmiUI48K0BObhszUAZ/aWYcwE4DX58Q+ll6hz1160iwR
	zZXuvk5BfC9vEKzo0ph5gFnUikuvDYZlXL1DFx6dwJkTyIopV3drXDesuGcsoJ5p1PvC
	8w5OFtlXvneXunCwlBCii4K3Dd+WKBNWhsQW/tGS6acuN2rk2+URUMVavYsobTWG4FLK
	FgVh/30QiH/qAYiIngvIVAkc1Ck2EjfFeHHrclsvBOFgGI6zHQhSimZaAPGCoXjwAOis
	LdOQ==
X-Gm-Message-State: APjAAAUyOkr4DTSBwSsZeWfp9R1u4bsKSEWAbJQBtbhctxn472rO2FNb
	6Q2vNzd6B0BMCJQb4NSlrlv4cuplLkE=
X-Google-Smtp-Source: APXvYqyG6myOQrc0w30agZy6ipDiGaD7QNUvL13KouvjODtO2vGaTTXqUhoJ+53WXgpTbvizOBu40w==
X-Received: by 2002:a62:5a42:: with SMTP id o63mr31187370pfb.170.1556064740338;
	Tue, 23 Apr 2019 17:12:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	x128sm33705371pfx.103.2019.04.23.17.12.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 17:12:19 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fa60ed75-12a1-7a82-ba34-32117f8d5a18@linaro.org>
Date: Tue, 23 Apr 2019 17:12:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 20/26] target/arm: New helper function
 arm_v7m_mmu_idx_all()
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
Message-ID: <20190424001217.jyNFYsbs3Zi5UwVgHL-UKzsz9CHLd2mIEaVO3zwnE1A@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Add a new helper function which returns the MMU index to use
> for v7M, where the caller specifies all of the security
> state, privilege level and whether the execution priority
> is negative, and reimplement the existing
> arm_v7m_mmu_idx_for_secstate_and_priv() in terms of it.
> 
> We are going to need this for the lazy-FP-stacking code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Suggestions for better function name welcome.
> arm_v7m_mmu_idx_for_secstate_and_priv_and_negpri()
> just seems way too long and unwieldy...

Seems fine.

> ---
>  target/arm/cpu.h    |  7 +++++++
>  target/arm/helper.c | 14 +++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


