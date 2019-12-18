Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B49C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09A3206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDfj6yAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09A3206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfAp-00068b-Q3
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihf7k-0002ED-2n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihf7i-0007Dp-JP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:43 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihf7i-00079J-71
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:42 -0500
Received: by mail-pl1-x643.google.com with SMTP id f20so1429904plj.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sRHieOSR3HlzGdhhed9nfbAikdwFTYjQYoiiClYl444=;
 b=fDfj6yADO6rO4uIFXtkFxOJicFei2WTlMVoKjaKb8ww0P3a6TlL+CJ6sm20376Xq10
 fQ8gw34VUyvGt+VaURNiCVLYXSHTl5l4BTJjg+CeJ3eLHtOcNj7Tp5HfVBmnnz076n+A
 y6kxxPM16U4WB/jpkwodANmRGp9sHfM50xJExKBT8vAo5TiRFxR6hz/8nrTNZbGt68UL
 Cf2ckMGtO8LKztfcrSPuFUsX68iGSx3UQjJdMNyb4FqbGmqEtJTik7jepvjGRfJqUV8u
 po2UfvNQqXcNMoHuIRKHdcTCXzDkGUZ4pR1Q1KBQC563/AlLvNiCkWBPHNTB3eVnjyHj
 JiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sRHieOSR3HlzGdhhed9nfbAikdwFTYjQYoiiClYl444=;
 b=Iat4IjbIPJ+LjnzDoS+h+xD7u3OxOT/qhrGYdtGsuwzGDDsSq/cHJY4j3O2y3oK74G
 GRnwA3+aa/ioMl8tq6cwFbC9kl5dm243hbSLEEApMLfHALqpO6jsfmNe2/FxjpkoZGdg
 az9X7QBXtsZumDDFD5G4NV/1Lp11bd4YsDI7lNfx2MCKbzymCGCQjV/Z4XWZoG9Cti19
 sAf5ljQOd02NDBRFbq1WY65yZqeGi4D/EBji6feFgx6uW/DHMaN5kptFlLMG+Wcg3ubN
 xvBG3Biy060bJ0MS013zHXzej3I51hiDVl21OKigZP25+/kLIsh/heuVWGiZhOGuFA5n
 pAnA==
X-Gm-Message-State: APjAAAUM4NvMqM3HDviAYXhnaex+GbX3AEeD+rzzywcCj3m8YkA2RjJl
 iqHB5ZxV7rOKvYCefuxCqDZbvXeKTPI=
X-Google-Smtp-Source: APXvYqy1kY/i4HckQ+nlqH1wN3lmBescX8cVsHa9qasVQCLi4mXY1TiYGHV79z7dMNCauQ694T7frA==
X-Received: by 2002:a17:90a:e98a:: with SMTP id
 v10mr4818303pjy.67.1576697800988; 
 Wed, 18 Dec 2019 11:36:40 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id z13sm3893825pjz.15.2019.12.18.11.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 11:36:40 -0800 (PST)
Subject: Re: [PATCH v1 1/4] target/arm: remove unused EXCP_SEMIHOST leg
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191218180029.6744-1-alex.bennee@linaro.org>
 <20191218180029.6744-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <23ab51e5-12fc-fa62-b8ca-942089bd7bec@linaro.org>
Date: Wed, 18 Dec 2019 09:36:37 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218180029.6744-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: pbonzini@redhat.com, keithp@keithp.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 8:00 AM, Alex Bennée wrote:
> All semihosting exceptions are dealt with earlier in the common code
> so we should never get here.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/helper.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

