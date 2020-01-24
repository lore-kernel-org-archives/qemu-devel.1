Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D044C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7DD20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqOqYhrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7DD20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv4uj-0003vH-3j
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 14:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv4tC-0002IP-To
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv4t7-0005fv-9q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:45:10 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv4t7-0005dr-32
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:45:05 -0500
Received: by mail-pj1-x1044.google.com with SMTP id bg7so278344pjb.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 11:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CS1T8g6exv4pZWkk1CKFOOp8Y6k1wtSU7Ui31Lt3wUc=;
 b=BqOqYhrxJvNRQ4syh5+yFYy3OnlDQzw2suJo7y4UbkhEhPQuJFy3KOvfqxpt2pEsNH
 JWHv5ZVS/ICpquVo5Y5h3LnX++FjKHof8zov2mwC2Ed3mOsmygZYUcy3u7xrgWvKQKlk
 KsyLoIHc+1LOrfwZ1TTY40VP0y16oYNVuG7YLvYnUxhM+20H1FR9h4BSddrxESI+gImY
 AXhYFhFpwWc+1WgKErpUDZJF6OGkDslETvoeysB4vTLKCqn0xsYl0o0/KjF7B2+yo0hx
 wrYKPLyzv5fihHXijX020dZyxzEEqlyVh5kVa+NyjynOg+SZ6msiM+H37qaDoSCGEcCf
 bzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CS1T8g6exv4pZWkk1CKFOOp8Y6k1wtSU7Ui31Lt3wUc=;
 b=m+kbQ9KvUTTxBw+T61u8lFS5IB4SUUE4XRNq3mC4bnvi4O0il5ZLmjDef8CiRtbw79
 +D2OvrP0KgRQUiI5PhEoqx3G/0YGxVZcvSwUuMUVCCe1SgH15URaSXzDJLeLAoEECRjQ
 mmWAjXgNiOdmUZ1T/Zi1rV/DtrJjhhTs/pEq1Navd4Aw6EqVv94AvPtPFvlOJwng85Vm
 JB0j3Ir3d1D719hrda96ePYR999tWCrZzQJZey5BSB4JPBkkQcv7yrLcOkHACnMx5Ufo
 QV6XErgp20OJQTFXbVKSrDsq7E3nREhfdjOM4/xHPFOTyRsl5B95x7Kp8azFq0yPj5Ww
 ds8w==
X-Gm-Message-State: APjAAAWE7LHiESgYAY8P4ilFKB+HHdlTM/VguZkmqYVzQ2NmqHV90vJz
 /8whKKT303IDjntzZIA9T3Yltg==
X-Google-Smtp-Source: APXvYqwK3T3PDq2eH4C078z6mvbMYuXE/umz7Y/DSJJD16uCw9WMk+3xtsLXEo9ktxfQ7v+omjm52Q==
X-Received: by 2002:a17:902:8b89:: with SMTP id
 ay9mr5066508plb.309.1579895103611; 
 Fri, 24 Jan 2020 11:45:03 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id h128sm7230819pfe.172.2020.01.24.11.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 11:45:02 -0800 (PST)
Subject: Re: [PATCH v4 6/7] disas: mips: Add micromips R6 disassembler -
 infrastructure and 16-bit instructions
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <779b7b35-16a8-0538-ad87-fac218c93e82@linaro.org>
Date: Fri, 24 Jan 2020 09:44:57 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579883929-1517-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: aleksandar.rikalo@rt-rk.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 6:38 AM, Aleksandar Markovic wrote:
> The basic disassembly logic was obtained by somewhat modified script
> decodetree.py, and such output was further manually modified to
> handle numerous details of micromips 32R6 instruction coding scheme.

What modifications to the script?
What manual modifications to the output?

It's been a while since I looked at micromips, but I don't recall anything so
odd that it couldn't be handled with the current output of decodetree.py.


> +static void getAlias(char *buffer, int regNo)
> +{
> +    switch (regNo) {
> +    case 0:
> +        strncpy(buffer, "zero", 5);
> +        break;
> +    case 1:
> +        strncpy(buffer, "at", 5);
> +        break;
> +    case 2:
> +    case 3:
> +        sprintf(buffer, "v%d", regNo - 2);
> +        break;
> +    case 4:
> +    case 5:
> +    case 6:
> +    case 7:
> +        sprintf(buffer, "a%d", regNo - 4);
> +        break;
> +    case 8:
> +    case 9:
> +    case 10:
> +    case 11:
> +    case 12:
> +    case 13:
> +    case 14:
> +    case 15:
> +        sprintf(buffer, "t%d", regNo - 8);
> +        break;
> +    case 16:
> +    case 17:
> +    case 18:
> +    case 19:
> +    case 20:
> +    case 21:
> +    case 22:
> +    case 23:
> +        sprintf(buffer, "s%d", regNo - 16);
> +        break;
> +    case 24:
> +    case 25:
> +        sprintf(buffer, "t%d", regNo - 16);
> +        break;
> +    case 28:
> +        strncpy(buffer, "gp", 5);
> +        break;
> +    case 29:
> +        strncpy(buffer, "sp", 5);
> +        break;
> +    case 30:
> +        strncpy(buffer, "s8", 5);
> +        break;
> +    case 31:
> +        strncpy(buffer, "ra", 5);
> +        break;
> +    default:
> +        sprintf(buffer, "r%d", regNo);
> +        break;
> +    }
> +}

Surely this would be better as a const array of string literals.  There are
only 32 of them after all.

Then you can just return the const char *, which is much better than
sprintf'ing into a caller-provided buffer of unknown size.


r~

