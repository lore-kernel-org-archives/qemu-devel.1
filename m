Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C6FC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F845208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BF3C2QUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F845208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqND-00008F-Jy
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:38:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqMJ-000893-1z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqMF-0002mw-W3
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:37:18 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqMF-0002mU-Oz
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:37:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id t22so5369733pgi.10
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=K8HRtfqe/DTpbny1cHPqirCPHy9DvhWS1/adCdvc9fw=;
	b=BF3C2QUxrV5wQoLEAedIUw7JC6x31XlMxhgfBxL7kaYwQ3Z/4Do06s34hlZM7c4SzL
	Hyod2YWyc0LQYB75LUr4SruGOqwMYqkzmKcYWE2EsIwVcFSbytWGyPUeYT8D39LqTUMq
	crO+f3uAGpAmNrZIyIMRSBw22JnoYb6LIh7eAZeJ0siy8upwcar/EXHFE1nTxZ4GzXna
	i3SUO2oI7njYdKRZwvPeC65aLQZuINYZv4YIN2O15xp9r4sjKShUDEH9GAT0kuVQRFxo
	HGrU33I9guJ1pM7VECqDoTfqsYgwrD+MakM5XgTg0gTN3OeW0rQVaXe40jgy2Yfz0eM6
	FZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=K8HRtfqe/DTpbny1cHPqirCPHy9DvhWS1/adCdvc9fw=;
	b=hoVRcVYpy8azPqw8eFyJYGZ855BONcKYRbhli+zyKb0sVPmsmAKiCVTGdZGKpZCIiV
	lqeSP5Mj6biT8yObg5S2bH60BKwS9I/QUZA5SWpbaXwaKvJcS4A8r+nMepBmjtfzHC6k
	76vgSKMeq9ZYdb7n3YlT+s5+nvx4avR2EFFmsbFMB7oqxvyAz+AGjCryYF2LDO8BmrEw
	zidyHmNtpxlFuhHmFgOVe47kvcsrIDGG/w5ZhqQZOARLKYl1RX7+T6yWNBRg12y7VKZ5
	TWD9lm1P4d3N/7Uf70UqE1qmbtGNPB37xBEAYUVexrm7RtgZ719jEoV1mJBW0nx1pni5
	4dYg==
X-Gm-Message-State: APjAAAVvLVsJO2qiZaxLULulUaURJvdonwpgj25pEOcRWGCTO2vHUTSi
	LNkdo7tzMbobXfkvzSjldnxS10BQFMo=
X-Google-Smtp-Source: APXvYqx9eeE/66IX+bIUYsQP/lMdSFG1sEQVEyUf2XvGpqUNcw6FQsgQlX4ZGYt5NAiSPhcgImJNsA==
X-Received: by 2002:a63:1d09:: with SMTP id d9mr21471236pgd.289.1556721434462; 
	Wed, 01 May 2019 07:37:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	f63sm67220159pfc.180.2019.05.01.07.37.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 07:37:13 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <83e4f91b-a590-2a2a-bf5f-14b99c5aa0fc@linaro.org>
Date: Wed, 1 May 2019 07:37:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v5 03/15] tests/tcg/aarch64: add system
 boot.S
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
Message-ID: <20190501143711.8XVI2gsRGDQdYHWMFR7PM2L11MlX_mAX7ulnI015An8@z>

On 4/30/19 9:52 AM, Alex Bennée wrote:
> +.error:
> +	.string "Terminated by exception.\n"

Put it in .rodata just because we can?

> +        /* Page table setup (identity mapping).  */
> +	adrp	x0, ttb
> +	add	x0, x0, :lo12:ttb

You are in control of the layout of the executable,
and adr has a 1MB range.  Why use adrp+add?

> +        /* Create some (big) pages */
> +	adr	x1, .				/* phys address */
> +	bic	x1, x1, #(1 << 30) - 1		/* 1GB block alignment */

Do you really want 1GB pages?  You'll pretty much only be able to test valid
memory operations with that.  Which is also true until there's something other
than an exit for the exception vector... but ya know what I mean.

> +        /* Setup some stack space and enter the test code.
> +         * Assume everthing except the return value is garbage when we
> +	 * return, we won't need it.
> +         */
> +	adrp	x0, stack
> +	add	x0, x0, :lo12:stack
> +        mov      sp, x0

You need a pointer to the end of the stack, not the beginning.
Again, I think this could be just

	adr	sp, stack_end

Also, there's tab/space confusion all through this file.
IMO, this is assembly, so it *should* be tabs.

> @@ -0,0 +1,22 @@
> +ENTRY(__start)
> +
> +SECTIONS
> +{
> +    /* virt machine, RAM starts at 1gb */
> +    . = (1 << 30);
> +    .text : {
> +        *(.text)
> +    }
> +    .data : {
> +        *(.data)
> +    }
> +    .rodata : {
> +        *(.rodata)
> +    }

If you ever wanted to make this read-only, swap .rodata before .data, so that
it's next to .text.


r~

