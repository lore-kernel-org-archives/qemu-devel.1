Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C164C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 17:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5573C206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 17:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRLm+RD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5573C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43835 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNKfb-0001V5-Bg
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 13:11:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKeV-0000rU-Kj
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKeR-0004eV-P5
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:10:13 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:43737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNKeN-0004Zx-Qs
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:10:08 -0400
Received: by mail-pg1-x530.google.com with SMTP id t22so5232233pgi.10
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=aO8QhzDR94OcaQqFaSREZ6wZQUDwKyOneAgvuGhqCPU=;
	b=FRLm+RD4fxqp2XS78xJTOrzxjtjwmvd/9HUfJ+b7zDItHXFXwbuHhzBeIyJuXnd21w
	RpdkXy499Uz/cV2gn+dwq619Jrf50DY9jFe0yNSIdaPelSlg5r3AfzLSRUE8GrPfBchD
	jsixX2W3sfpT+/PC5MGUNzgHhBUUknzC29pQKyGwWXQq8KjL8M5xZOqLD1bwU0Jr1m27
	bVE9skfr9tgcgxPKkfCP2nCzBXjm/qh4KjwOMDggGltLpRNETmI+HgYCqQY7QFMCyx/T
	5ObeZP9hx/skEYq6XsWsyma8A9xlrFmczyGpwtVesmMBYChdf1oB2hZAn5asSE5a5r0d
	POEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=aO8QhzDR94OcaQqFaSREZ6wZQUDwKyOneAgvuGhqCPU=;
	b=ZRXRokxGk01b1dkndEj1lq9y3J3NoZQaLcIabbzDBDHOeew+hGCtKYHZ110aik5cSj
	yG8piLzuw9CZnG1uKy65CW5mdfh2JtG+4Wh7AA/UXL7BVa9dVAzxyILIQHsRp/iLe+1G
	TNLJcm0mhw/EpnmK59LWaLpH2ENGS82pnuW9uBVR5JEgHV7h/hQh8hPaN5+HPMhz14bv
	xDgEFzaY21kJZSoTGxobu8SccdBw9VEXg5klMhDgdnn0aQkJT+kdQCtUpHwQE9fyQGBU
	rfHJfa5BoyK+Qz3YfnR10GkJ+lOAHYLbkcC/RHZf5o8C2jpQTT5BzFZYyM8p41AzVIdR
	+S5A==
X-Gm-Message-State: APjAAAUvbCI85Yd8x7GqGsGu+IHB6PPXiLRGN8529sveZgGtjFxMC+UM
	mBYJyC9E2tWEl2H+0GBpimQ7Aw==
X-Google-Smtp-Source: APXvYqyqi3K/9cFqKWdc5Gr9xZWtD1WWN/u3H9o5aJSFg4kA5I6Uygj2zHwhIDUrBzSY23GHLdTKMw==
X-Received: by 2002:a65:56c3:: with SMTP id w3mr8907709pgs.232.1557076206187; 
	Sun, 05 May 2019 10:10:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	c129sm10549242pfg.178.2019.05.05.10.10.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 10:10:05 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <21e07bbe-8b37-f2c7-8144-c303f41175d9@linaro.org>
Date: Sun, 5 May 2019 10:10:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504120528.6389-6-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::530
Subject: Re: [Qemu-devel] [PATCH 5/9] coroutine: add host specific coroutine
 backend for 64-bit s390
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505171002.ZEaKMXR4t2KW1PNMScMuIaaUjS2UIq5DqSz6ZsSupB4@z>

On 5/4/19 5:05 AM, Paolo Bonzini wrote:
> +  "bras %%r3, 1f\n"                /* source PC will be after the BR */ \
> +  "1: aghi %%r3, 12\n"             /* 4 */                              \
> +  "stg %%r3, %[SCRATCH](%%r1)\n"   /* 6 save switch-back PC */          \
> +  "br %%r4\n"                      /* 2 jump to destination PC */       \

Better as

	larl	%r3, 2f
	stg	%r3, SCRATCH(%r1)
	br	%r4
2:


r~

