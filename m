Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4192CC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34372082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uChwXcnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34372082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izzP0-0000Lc-0a
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izzO8-0008Lf-7h
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izzO6-0006uw-Ut
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:53:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izzO6-0006os-NO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:53:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so1683260wru.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 00:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ocQRA8osZ1UsQk2pAdCSaPXB0TYn8WJCOp8jtmwAdZY=;
 b=uChwXcnu8jnJUkHS3Fvh3IUtkISQ1nKRo8u23A56GXo0y4mnE9fcrZtnv3lLb0Revf
 jQfglLsGSw/AI4e7Owk19cAEg7FAVIx39uFGqCpDdwYBCqX/i/Em3BMCoZgozcZhBI1+
 XC8MCzG+9RvvgYpNQdA6AearwmvlDC1m2X0y8jrzsu2NFV6FO6QIwmSNuCqnrAcUO9rX
 yiuMQ9vAUG8pdoFxZL1HN3hnYmqlaX/tGtdSLKgh0Vg5Y3ZFDSTvN4h/MHaGcwoZaRNz
 J6qZ2JPWFJqbPPleDZNLSRoyTmIG0t5pnm3VnfcywTFqGVrJ5o+O1m/OlyHbxWSk5JjY
 XE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ocQRA8osZ1UsQk2pAdCSaPXB0TYn8WJCOp8jtmwAdZY=;
 b=gkIX6UmssB+cPSlK+hko5h91B5cMzYL47H6T3q7utVPfjhCQ4fimc/w1QKWAEm9ajB
 z6V3sKPW6Kf9pvi4apwr/K8D+30SNYB26XRFD6rB6beqi/rSMxFv5rT8VDy86JDUKyH4
 2fZukRx9jkOpAde27On+taQNg3y19T4FrDgg/egswO5FtxfKVf/q8vXyKC/sFt3czbBE
 WP2/npQR35OWktD9hBnLM95epoIuGBiqG3eiHUQyKwOIjr9WlEqufnVOLP0J8VPm37nJ
 YD0fZDRVxVyJjsME7B/qIKWL4dVN3wI3rwGyTanIDt7C1FPukJg/cDJpgy50T92UrigK
 UkLQ==
X-Gm-Message-State: APjAAAW6Y0NwvnqAV1GUv6xRf1M9dJd+g7TWQNISFzqRQ+dLbPgpR7Eo
 y3aDTPM1kBgu0z09yVBcPZnZ2Q==
X-Google-Smtp-Source: APXvYqy/Yf62yGF5XsaoPFuhZblcsXhtUYwKiLY53CnCRvPA5gOrP8A2CS29mu/mtADk/2bDVgjjCg==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr3318473wrq.232.1581065601476; 
 Fri, 07 Feb 2020 00:53:21 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id o187sm2841106wme.36.2020.02.07.00.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 00:53:21 -0800 (PST)
Subject: Re: [PATCH] Add support for a helper with 7 arguments
To: Taylor Simpson <tsimpson@quicinc.com>, Richard Henderson
 <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <09def3cf-6833-ccf5-457e-1755a7fd0e04@twiddle.net>
 <640ffa37-a70b-dfa9-55ef-cde5c7f0dfcb@twiddle.net>
 <BYAPR02MB48863BDFCB4CB26717467579DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <3614849d-12a5-fa43-fb10-801e9648b40e@twiddle.net>
 <BYAPR02MB48864A309572E1347920CAF0DE1D0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <34caf794-85b7-c177-7951-d821ace5caa9@linaro.org>
 <BYAPR02MB488682AB2538F8EBE631EA80DE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <858bff3f-6e24-20a7-a7f3-49bee2cb8e12@linaro.org>
Date: Fri, 7 Feb 2020 08:53:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488682AB2538F8EBE631EA80DE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 4:46 AM, Taylor Simpson wrote:
>> I think that we can do the store immediately -- I give specifics above.  Do you
>> have a counter-example?  Admittedly I'm new to browsing the architecture,
>> but I
>> don't see a legal packet for which you can't just Store Now.
> 
> You can have two stores in a packet, and the second one could fault.  If anything in the packet faults, none of the instructions commit.

Then what does the manual mean when it says "dual stores have non-parallel
semantics"?  Is that solely about the semantics of the bytes in memory?


r~

