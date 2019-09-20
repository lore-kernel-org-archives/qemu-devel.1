Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A572C20640
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wydt88o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A572C20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBR7P-00080V-WB
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBR66-0006q6-Ld
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBR64-0005gI-Cb
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:09:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBR61-0005fW-8m
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:09:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so5455986pfl.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xq6CjTsGZJR9XwIXAsothWRRID2FfNd4/CnJWbG8XTM=;
 b=Wydt88o8wqr9s6XOMuXl1rGL6qL6HGEF3+opEmxczu8NZuMzPKPMiuquy8fXQWY0qg
 l7vuSspLHTPzhoaG5YNumwuE05CGagRwls+ttmxKmAkueKos6K+453WZmFJcU//b8Wse
 TS9rOZ6BXnPuEJAL8OMtnjHWpbB36SGP50YiSmhFvd16o+nSjgBOY1Q5PXBPKrSqk9na
 7HZpkOZonKR6AgLaUcn/WNn1Zyu234WBCuWyBOWhHRzNe/6TXrbApp58WSxmMk1UTxdO
 UtY8EPEN/32fft32iiov2H5qFVX8sbJvomxzZJSt7lfuDmUPxpKHKd2Nw5kSzdL3+aJH
 spjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xq6CjTsGZJR9XwIXAsothWRRID2FfNd4/CnJWbG8XTM=;
 b=en74SrHSTyaGJG8L/ntRaiXZ6JrnIg9RmcCnLh5GyM6sFvWQOQCmV4nrXKQpXq8vzN
 VyJN05zOe2Zhg9gVGCLjBEMqbaBm9WBa/rE1ILsWtfoVvKvzVcmTKCvI7BldFgXi7JX2
 Qwb32VRV6jgFdTc03N/m/KikM4dtq5sbQu6aoVZL6oGDHZbiIJ2LGmDDySh8K/x2mJgz
 spTOujp+P766ZxjkWJGG6p88D47yTu5Lj2wKshXIa9u0Ldur2QDy6FAZv9nOTsQ3ISu5
 XYaeihV/LNcwK5YqvF3RoX7MAqU5zI8B1q4D3jMHD+2e+8kDJMEMPWWNaoO+wya9tcX0
 ynEQ==
X-Gm-Message-State: APjAAAVJCDbQG+Iyfbp4qbUB9MattBt29G/0hU8fCCfDO2KxOg3M3j6B
 /FmpiM0GNhniDrztnJ2EFI1uhQ==
X-Google-Smtp-Source: APXvYqz5JelNdtvqL+XIhk1bmq9WBlrlX2ISeidqgXyz7O6rOYDUVY/H+U2T513vCCkNd/0abesKTg==
X-Received: by 2002:a63:5b23:: with SMTP id p35mr17082669pgb.366.1569017383421; 
 Fri, 20 Sep 2019 15:09:43 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v44sm3832336pgn.17.2019.09.20.15.09.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 15:09:42 -0700 (PDT)
Subject: Re: [PATCH v2 10/16] tests/tcg: add generic version of float_convs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-11-alex.bennee@linaro.org>
 <c6cd971c-e84c-c5c9-b313-2e454e02a1da@linaro.org> <87impnz568.fsf@linaro.org>
 <87h857z32j.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0b0c45c7-4b9b-0d03-01aa-25a689a8f914@linaro.org>
Date: Fri, 20 Sep 2019 15:09:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87h857z32j.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 3:15 AM, Alex Bennée wrote:
> I can't figure out what is meant to be going on with CONVERT_BITS. It
> seems to be implying there is a direct relationship between status flags
> and the exception disable bits. But that is confusing because integer
> overflow (IOV) and float overflow (OVF) are different flags bit I assume
> both suppressed by Overflow Disable (OVFD).

I had failed to notice that the kernel routine plays with INV and not IOV for
the emulation of CVTTQ, so it's the SWCR_TRAP_ENABLE_INV bit that controls
whether CVTTQ/S raises a signal.

Will fix.

> Why are we doing this magic 32 bit shuffling anyway? Is it purely to
> save 32 bits of a mostly empty lower half of the FPCR register?

Yes.  Which is not a great answer, but it was done years ago and there's little
point in changing it back now.


r~

