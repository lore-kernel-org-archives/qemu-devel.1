Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D943BC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DBE2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVWQl+fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DBE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1C1B-0000qm-P2
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1C0W-0000Ne-LZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1C0V-0004rv-JD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:34:00 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1C0U-0004pZ-RA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:33:59 -0500
Received: by mail-pj1-x1043.google.com with SMTP id fa20so4448276pjb.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KMegj8Lyv6PvRijYEd4qitZOPYz5DOQk9xlT/y3StIM=;
 b=dVWQl+fiZ16WR+s0XYw6992BzNGSODDXvgex4NPBwXC3ycI4XyfcekWtQIfqNQMniO
 ngQEapfDjSISjpJxrDWHknIPh/NWg9WtPVpbNtP3+i0eIRBKAzZfti5sP9govX/V/iXa
 FFuOh6sdW8zkPBOKXRLeIsjbmA7D8tArwQwFJFhXFas2OdKr9yy0K4c7ZK9vODg2tip9
 n2Ct/vMrr9fWMXNfJgzFGv/irfFFB/EoU3XHE0M0AkY7k+D6FNCSShxXPmmffisX8BmV
 7T8b12pltJQhnQ7JcQlMYwrd5gTUQJIXojw1YJX7ltBR3kvYX+iRTBIK1je50ZdxxLMc
 UsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KMegj8Lyv6PvRijYEd4qitZOPYz5DOQk9xlT/y3StIM=;
 b=DNPE5NdWtaByHx0w3fdzWx6Sz1kzCV+qCNPYCG4kzG6uOZJmuZoKSO9Yy5v20/Stzo
 snfDFhkF1RS15p4/y85nAbiouxvhRo4ydd88NHCyYvBF6724n/C/9UwqUBH9E2dtJRCM
 L7rH38ECsonvaVxFRqYJ2sBZKdB7UmR1OTgC6bI+7kJyVubJ5GQGDvE2FxUb2nV0Eahx
 +EJopEGLZIa3IN843rQqDIW8UPinigWl0fW0s4nYhdrgLzIfLgrDJO0Txi8+5AhIPtq2
 o/kJcO/0sN52BjV4DucwGgZxI1lY/DfR55fc74ob3gFuHvAt1lBvYjTJBoBTqndCeVFK
 baHg==
X-Gm-Message-State: APjAAAVvtGnKV8ir+qEkYpAFQtxZGX6naKtVCIC3rfmclg0Nmh1Tmr2g
 PNZzxpDgqMngVRlrh7RTi/vs5w==
X-Google-Smtp-Source: APXvYqwX9WoOPGXhQRgErXgrJIwjRGLPBaf0DXpi5JrJ9P34Ycf4Hi8WHaEJxNwo44l3l17d8eeyyg==
X-Received: by 2002:a17:90a:17e3:: with SMTP id
 q90mr2615767pja.139.1581352436722; 
 Mon, 10 Feb 2020 08:33:56 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w6sm993077pfq.99.2020.02.10.08.33.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 08:33:56 -0800 (PST)
Subject: Re: [PATCH] Add support for a helper with 7 arguments
To: Taylor Simpson <tsimpson@quicinc.com>, Richard Henderson
 <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <b308434a-1ee8-4fb5-0e60-4dfdd047c959@linaro.org>
 <BYAPR02MB4886E14CC87B1169B2F6BE2BDE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a01b3358-a598-9d01-f3c8-d9a84fb7dd28@twiddle.net>
 <SN6PR02MB4895FE0821C3927B41636AB0DE1E0@SN6PR02MB4895.namprd02.prod.outlook.com>
 <fc6876dc-1a15-152c-5585-4ab06deb60fc@linaro.org>
 <BYAPR02MB488629639A76A15DAE7FBEC4DE1E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB4886B8437B6D20F8F6F60DDADE190@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5598f75f-e504-c476-7f99-dcfeb42743f6@linaro.org>
Date: Mon, 10 Feb 2020 08:33:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886B8437B6D20F8F6F60DDADE190@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

On 2/9/20 4:54 AM, Taylor Simpson wrote:
> One question I have from implementing this is
> - Is there a way to pass a constant value to gen_helper_XXX?

No.

> It would be great if this would be possible instead of calling
> tcg_const_tl() and passing the TCGv.
You have to use tcg_const_{i32,i64,tl}.


r~

