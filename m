Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8BDC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29A720578
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrLN/JAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29A720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJ8B-0003gq-Rk
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJ6p-00033S-At
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJ6o-0006V9-5F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:25:55 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJ6n-0006Up-Oi
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:25:54 -0400
Received: by mail-pf1-x443.google.com with SMTP id y5so2728331pfo.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Yvt3VeLmQWfbl/zRgCN5EnY7/IpEzSBYY1kapUJvzZY=;
 b=WrLN/JArXjsqWROzGe5Lg8uNvvY6a6urcPPh7fdoG0OL9etKmbpJubU2fQ0bcurK6G
 3AEQRD913nn5f8QSsQnX409Y9/LPmH6yArxbiLxuc7QIX9if9RyLynkDE378g9M5sKz3
 AyKfnzEPBCQGQLM6speYtEGMaaifrPcUdyy4Wzf76hG4TwEbfs/3io3621Y4FnKztBEq
 a8iOmICpB5z9C0NuzLKlCar3MrCWp5ctSL4b2drwzj4PerlvhBCgxWNwK+GWZ70J+Qt+
 uyvJ95euexd850xViwVNb6AzUFDxxpppCGmBcmoxE8364/6psJPinJ7aL0Dx9D6/Nh8M
 4RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yvt3VeLmQWfbl/zRgCN5EnY7/IpEzSBYY1kapUJvzZY=;
 b=shppQJQnmtJiuyO/30ULDpDmSSnIGp35I0vDYh8MYk5qKC+cw4yieLzm2uat2pf0RQ
 YhfXZYEEQekAzBLDNlffwdxIE/CprFbT8PvokI5d7Nw7X8TmSqcBY+Q7qUaR5IB93Q6U
 tNFiekcZLxzI/jLgbi399fW3QkUd922bv1rWyZALcrK5RyqkNw/gTvjEv3I1yYGnhDJd
 ZW7Q5BjiYJnBHBfe81uGxLcXCq9urNl0+Wkw0IB+GhEXLv1/BHJjbb52T6QPypbg9bgU
 B9L3cn5fH7lCxyKw8RwQ8R+q1D7nvVYdQibcvL3aO8j62h591gaSFmJwgGB97PEkwHyI
 3Bgw==
X-Gm-Message-State: APjAAAWRlV368MDoNQafWgcurbFlpxRqSUaMSXdEFsOW44GFdwWLp0k0
 9O1xIfGUwKaBjRJ1uGTJCpJhrQ==
X-Google-Smtp-Source: APXvYqwtZWXDAroRdee1GuxDm10lGa87fhc0Vy1dzW9/qb/CJI9J+iFiiSsYVs/XLRoUmhSDctj2OQ==
X-Received: by 2002:a17:90a:178d:: with SMTP id
 q13mr6725873pja.134.1568748352605; 
 Tue, 17 Sep 2019 12:25:52 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g1sm2883687pgg.27.2019.09.17.12.25.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 12:25:51 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
References: <20190912065631.12473-1-andrew@aj.id.au>
 <CAFEAcA_h80VQVC0jE7v8kmsuXU=16+KXSKQ-qhuRNTct7X6X7g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c9f58ca3-36ee-e8bb-a350-29729f4f24df@linaro.org>
Date: Tue, 17 Sep 2019 12:25:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_h80VQVC0jE7v8kmsuXU=16+KXSKQ-qhuRNTct7X6X7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v5] target-arm: Make the counter tick
 relative to cntfrq
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 12:14 PM, Peter Maydell wrote:
>> +static Property arm_cpu_gt_cntfrq_property =
>> +            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq,
>> +                               (1000 * 1000 * 1000) / GTIMER_SCALE);
> I think it would be helpful to have a comment saynig what units
> this property is in.
> 

Should this be NANOSECONDS_PER_SECOND?
It's certainly a suspicious use of 1e9 otherwise.


r~

