Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A57FC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5351920B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yydjUWk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5351920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnqU-00032g-92
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:33:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTnaB-0005Ey-Ny
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTna9-0001xO-R5
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:16:31 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:37632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTna7-0001vJ-QT
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:16:29 -0400
Received: by mail-ua1-x943.google.com with SMTP id t18so2158101uar.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=6KS9d5eT0YUL9nz8APaV1sldA/n7utywrrWd4/ev3xY=;
	b=yydjUWk7RE6UHu0YchjMy59fZJv9VG1WnbKXFq6LnFu/6FZzfa+PrkFgX1G9AH0NRp
	jNueNYOoDqY7KYqeHD9k3J13K2F3n7IDE5OJQMvwqS1yW0FMjhUlnj6saIGA01T4T5F5
	ZMt+aEyE8dI2f3DqlyaUbCmnW/FEHTbPRC32eMkjHwdi+ccHOtQXfQk2JZdgIep1QX6K
	oxbka8/f6EuX6T1waXXDRT8Qbn3z2zDFlHSAzOTjookm/D/VZuhlXCNltllmG5i/VASn
	qHfOZPUhcgfN2QOuftgMHIIuoIrs6plkCwFqcypwkd3w7x0bd4YVBZ4YyzhFaX4fXTel
	VfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=6KS9d5eT0YUL9nz8APaV1sldA/n7utywrrWd4/ev3xY=;
	b=mnPHsOvUm7QZ/RmopzbKxnnaPgADDRzRPsr7ExAOvrv36IZasK5mhR0d9VkriPamGI
	A0a1u0/kqSixbHWd3xZKxJ0M6BULRSJUXbH2J/V6fOzicxkvDVzGITVtrRnySb2tgghV
	vgOqeIEzKaRYnRyPM+ov6Y5aVrBE6dH35X642JqOgYnLBqQmXAfuefDqyx07s7QT1vzH
	6DF7yjHdLxAZ5pmtB59y++Q5Rl9yKyUXolMe3OsCRa1PiJofCVHbbusuLWXFU1NcK3cp
	nS1yeCpJBIlQY+n5hoDGJFlGJE+40xOlkzyIfI0ysW8LadB4Noe20itGaCL8j8dcr+KK
	pgLw==
X-Gm-Message-State: APjAAAXYxZy1tQsL5RqZJOHVaYb3rKfxDu9U4By8AKvpreZTzi2/Xq/a
	xoyP0ek1KBUJ+2Kdmoc2Cm+OqA==
X-Google-Smtp-Source: APXvYqwR1B6t3pXGUj3KDctNsoVS0MHWpAm0485s/+Co/XKbz3JPE94an4CmqfFuNIkJW8Se54I2XA==
X-Received: by 2002:ab0:1849:: with SMTP id j9mr191283uag.75.1558617386118;
	Thu, 23 May 2019 06:16:26 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	o11sm13113027vkf.13.2019.05.23.06.16.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 06:16:25 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190518191934.21887-1-richard.henderson@linaro.org>
	<20190518191934.21887-3-richard.henderson@linaro.org>
	<CAFEAcA88nA_2u1Yc-9ZPAy2w6LVk5f9Rrss0e53E11W4Xb4YpA@mail.gmail.com>
	<e177b43a-2abc-3aee-461c-2cfd9a8a0a20@linaro.org>
	<CAFEAcA_1XuWqVu9gonn5_Y9x1V=UcWNHEXtwop2s0qyUbwiZpg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <13d9e22b-4ac5-fb87-622c-a99b5494d06c@linaro.org>
Date: Thu, 23 May 2019 09:16:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_1XuWqVu9gonn5_Y9x1V=UcWNHEXtwop2s0qyUbwiZpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::943
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Use tcg_gen_gvec_bitsel
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 9:08 AM, Peter Maydell wrote:
>> Because the three different instructions perform the same operation with
>> reshuffled register arguments.
> 
> Ah, so they do. Next question, how do I find out what the
> order of arguments in the above code means so I can compare
> it against the pseudocode expression we're implementing?

>From tcg/README:

* bitsel_vec v0, v1, v2, v3

  Bitwise select, v0 = (v2 & v1) | (v3 & ~v1), across the entire vector.

The "selector" is second, the first input operand.


r~

