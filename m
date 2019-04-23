Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A698FC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C453218D2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 21:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TITAyOnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C453218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3Gm-00068n-O5
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 17:48:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3Ff-0005lK-Qj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ3Fe-0000Nq-Pt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:46:55 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:42393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ3Fe-0000Lj-Hi
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:46:54 -0400
Received: by mail-pg1-x529.google.com with SMTP id p6so8253314pgh.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=FDLMRKRPzp/pSJ3ZDS5uhKHxLRwPh/L4VqETRioA01M=;
	b=TITAyOnSodgtXIyRXeAJtd+5CmZsPqpAa8s96hR2fRmOJItS73ex2p04Zyl91B3htH
	3sKURhJOS3xLLR02szW+wXC5OHFuIdOMHRspMAgNhAHSSrSpa88eszMygnX2+KScmS9u
	kj59cNcbM+XDUewNeVWW3a+7uNit1QK53/t0RF42hVOTZvLB4eJsHeCNHqYlQBT1ZCEb
	rGPIoVTySFy6SvWX0lI4KgicR0b/Z5zdpyWcn05K+mqoocsFOjs7BMNxRqnJc7UOF66y
	XKK+55/qDcjYtocpo56Ost82f7cAd2X2KP35i3uYABXwph4KGoguHT/cNGDFPdnRxi9+
	34wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FDLMRKRPzp/pSJ3ZDS5uhKHxLRwPh/L4VqETRioA01M=;
	b=pMH++GNRJz7NOvWjDRHL56fmxJnwxSPVbrCFUanphwuhrA4JH2Z/HQfjypMgArLjI2
	T/W4+hDjxfBABcuWszDcffZiEnDAGQ3owK2fvT/eleAGia2ZO3sptmYf+4U3ukgOt3LO
	hytjRZyucCXlgiIHoXDYYqSDcqyHD03dc74vY4ybCYdqcDMpGC3+GIVlBn8mCwNadyk7
	JKFjUY5xaw1BtQSzacEVkb+RlaszEqDAP6YtXQpxhYBrdRW2IP+GUd9NBwG3dBNd2Fyg
	1oJmW6hMt9lXFtlFoDOBS2r8a5AZWNxtcd84Foie8/fiZj5HB3iHR/QZ1CvVEPg7yzyX
	7Akw==
X-Gm-Message-State: APjAAAUljvxB7asmFQ3zCCXpboXUJd+CdYYhTIaxFSCFHxqC+4rSRP/e
	M/6Ek8GNFHA7zb56ZOXsgc7HYTQ0wzU=
X-Google-Smtp-Source: APXvYqwUP02UIol0ws0nW05IQ9Y5s3l/WvDj81ysHDsyv6sIjyroxkb7qt9T7t6R/ZnyXhreBPGg3A==
X-Received: by 2002:a63:f24f:: with SMTP id d15mr27177287pgk.410.1556056013194;
	Tue, 23 Apr 2019 14:46:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	n11sm2276008pgm.50.2019.04.23.14.46.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 14:46:52 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <11425be6-f1ec-e707-9a81-eb0ed9362551@linaro.org>
Date: Tue, 23 Apr 2019 14:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: Re: [Qemu-devel] [PATCH 09/26] target/arm/helper: don't return
 early for STKOF faults during stacking
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
Message-ID: <20190423214650.eXll0reiH3Lm2q-ilQ08yFFaanWnS_UgjZqxa30679Y@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Currently the code in v7m_push_stack() which detects a violation
> of the v8M stack limit simply returns early if it does so. This
> is OK for the current integer-only code, but won't work for the
> floating point handling we're about to add. We need to continue
> executing the rest of the function so that we check for other
> exceptions like not having permission to use the FPU and so
> that we correctly set the FPCCR state if we are doing lazy
> stacking. Refactor to avoid the early return.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


