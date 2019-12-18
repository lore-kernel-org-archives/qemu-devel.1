Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FA5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07167218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tofwp4cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07167218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihj66-0003C9-2O
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 18:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihj5C-0002AY-KX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihj5B-0001kM-HR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:50:22 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihj5B-0001jq-9Q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:50:21 -0500
Received: by mail-pf1-x441.google.com with SMTP id p14so2104904pfn.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 15:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qgRcloLlbvGNG+SlyqQqhUxVaOx55mkNHJe+/ur/HJo=;
 b=tofwp4cs8GaCrbghyYvGagjkZeFwSbfbkeNlKlXkGvVp9nt8Q7sDOvqRo+ZOnCvqWB
 YESbdKB9J/Od7lcb0dm8uN/g7x0RJFvh3fIjMongx59UBYhv670c7VUwFw8ib2PSnvSv
 QjSgoMn+z3fktpltXMyhXckeZQ4wBvZyT3GWfiFAzZK9H+anv8jgim753UDW7zXNfXdW
 pshisIKXLA6+5n0eYGSgnEVo1+bJhGJ6/KokOSZfolq6CGRWTkDKcE+4ueNrEkZWSw5m
 1rmM2QXgqjUVPaXCB6AwE5OpaYq2ZasvhbBptUYUeU/+p1tALzFmXkoTo7uQ31yKo58R
 wBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qgRcloLlbvGNG+SlyqQqhUxVaOx55mkNHJe+/ur/HJo=;
 b=YyVigPtxQAD3lPSduzIuCGU9aegHqdqAvJiUE4wuQacS0ll/J6zmQUB8okgP5Uqj/9
 yULrHEzB0LiWJqBD+lWtuOe98P/CJgz7VynhQHKYo2PIuABBusXKXuZrG0Od/bFd1RaP
 rEVgcClxoMj/5jmbnes9RN1OGnzO1NYcu5pusJzJIbh73cBAyRxWYGfV/ljDSNfC14MA
 cWbookMuRqAFYG936mqPheMWkWeUsC/t569lkioQ0uJjWy8ZEOPM0pSguiNRIHolB6J+
 /3Mh3jZWtZRcln5VWQ9xMdICF20CEPVN4pwTv0tJyJ7qmTd/fdqHGHQGdrySWqxgRQpC
 W99w==
X-Gm-Message-State: APjAAAUXBfvUj+HBsGgbJLjkHIowIsiAoEsE683f7m+scCwBk83+6woE
 T80AFO/ertinOv00K5kXFucEuQ==
X-Google-Smtp-Source: APXvYqwsXA75WyNbDGbj6QmvwksohLs+vNjoFcFOIrOTb/vi3hmksO8MFN93wF1iTyhxJ3N7bNomqA==
X-Received: by 2002:a63:3cb:: with SMTP id 194mr6026611pgd.123.1576713019757; 
 Wed, 18 Dec 2019 15:50:19 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id bo9sm4156341pjb.21.2019.12.18.15.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 15:50:19 -0800 (PST)
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
To: Peter Maydell <peter.maydell@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
 <BYAPR02MB4886C8D82898F1E406C124F8DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
 <87d0dw83uz.fsf@linaro.org>
 <BYAPR02MB48866E2D82D9C76ABBECA842DE760@BYAPR02MB4886.namprd02.prod.outlook.com>
 <ffe58977-f251-df34-4bd0-62e32f78cc1a@linaro.org>
 <SN6PR02MB48953397AA553FA7456E7CFCDE700@SN6PR02MB4895.namprd02.prod.outlook.com>
 <BYAPR02MB488640DD7CC887E5FCC0F167DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAFEAcA-TpZfqbWjGX-tD0Osapt_K4yuTBg6+B=ZxU4MuVr7omg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ba5ef3ee-aafe-0770-10c8-4a020cc423e9@linaro.org>
Date: Wed, 18 Dec 2019 13:50:15 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-TpZfqbWjGX-tD0Osapt_K4yuTBg6+B=ZxU4MuVr7omg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Alessandro Di Federico <ale@rev.ng>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Niccol=c3=b2_Izzo?= <izzoniccolo@gmail.com>,
 "nizzo@rev.ng" <nizzo@rev.ng>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 8:21 AM, Peter Maydell wrote:
> On Tue, 17 Dec 2019 at 18:16, Taylor Simpson <tsimpson@quicinc.com> wrote:
>> Question 2:
>> What is the best source of guidance on breaking down support for a new target into a patch series?
> 
> Look at how previous ports did it.

E.g. the hppa-linux-user port.  The initial merge ends at ebe9383caefd.

There are 15 patches -- mostly in linux-user -- before the one that enables
compilation.  At which point exactly zero instructions are actually implemented.

The actual cpu emulation comes afterwards in 8 patches (hppa 1.1 isn't terribly
complicated).


r~

