Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6673C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDA22175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDt0rl6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDA22175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTu1k-0004iF-UN
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:09:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTtwQ-0000JO-Jz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTtl5-0002Hl-9a
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:52:12 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:40807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTtl5-0002HF-1e
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:52:11 -0400
Received: by mail-vs1-xe41.google.com with SMTP id c24so4325008vsp.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=XQMNwRorjVyKHrLMe0nR5C3o8n+pTdAqdghpcx38hnc=;
	b=NDt0rl6UH13pTaoOL52gxiRd6FFe3Ld2pWL2lSnZNStbcQcUgAw5N4coFkwySmqraf
	29rtFhjmJDah1C0fUugZ9IqwYkqZulb8WrZrVA2yqwQOFK8YBkKha4R2tJryVO7i8o/x
	14HbnJdosfrqZfBiMUx1zq+hzypjDM6zmy/kLEIAJR+S9IGGFT99oANpZtJmk/OvCfas
	hXYRIMxh3Swy/mPnYMmoEij/kLw6KneU8J9ci2bIfW9RT7aq6JWOTnCwOeRTiyxh/jl+
	eTk/2446CI92OtL3290NYZlQx+aa6wuewyCSs81S6Gse4FERywbjfw3x3fumXmCktApa
	qkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=XQMNwRorjVyKHrLMe0nR5C3o8n+pTdAqdghpcx38hnc=;
	b=AvVCUUWtNeUmLMN668IvTUemoynGSf0XTup6RhNB8rSZYzQ9uy4TnMXs7aNLVMZqOt
	Df3R7opA9p5Bb0A/Rr2jnKTSfHHxCEYK86h/cPKiXIFaIIKYz5oKDge6pSwdODVrWxTs
	qGud6NprOCwpcb4g3jBKreeS+cRh4BYvhVbo0IPL6Ash5WyCri71JSTw4OTGS7g6O5Ft
	5n+SaPP3lgWi7LbZnFX93N6JNQYx4LvKiixTKpGE3FATDjHEvlfLJygX7e1xLHESfeQT
	Z/aalWtDh8x4G9RLj0odJP22mJhriuU9MyQprFyOrTQuWLNAkuPWH+gG4zEEFww68jBl
	rXAw==
X-Gm-Message-State: APjAAAXgGUqhtkR4DWR/LfvYbNwmhfrk0teujo0qSW/1+0gWoZl/Jqoe
	/R4kj+BW/jUEpbJQlROnw2+XgQ==
X-Google-Smtp-Source: APXvYqy3tztU8nAS3nKYQkWSwM9zUxPl6ig0PMQFLEWCxCf4MDWsDcfJvBX+8B/FB0N7DYsI+GkMOA==
X-Received: by 2002:a05:6102:3d9:: with SMTP id
	n25mr22069368vsq.181.1558641129975; 
	Thu, 23 May 2019 12:52:09 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-172-85.orldfl.spcsdns.net.
	[173.130.172.85])
	by smtp.gmail.com with ESMTPSA id z128sm85129vsb.22.2019.05.23.12.52.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 12:52:09 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <165b1791-93cd-9518-e7d2-24f46bb152ab@linaro.org>
Date: Thu, 23 May 2019 15:52:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102532.10486-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e41
Subject: Re: [Qemu-devel] [PATCH v2 09/28] target/mips: only build mips-semi
 for softmmu
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 6:25 AM, Alex Bennée wrote:
> The is_uhi gates all semihosting calls and always returns false for
> CONFIG_USER_ONLY builds. There is no reason to build and link
> mips-semi for these builds so lets fix that.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/Makefile.objs | 3 ++-
>  target/mips/helper.h      | 2 ++
>  target/mips/translate.c   | 8 ++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

