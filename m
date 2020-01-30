Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F3AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E088320707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfAiq4S8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E088320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34773 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCP7-0002UB-5z
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixCO0-0000yk-Cw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixCNz-00060Y-7x
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:09:44 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixCNy-0005zz-V1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:09:43 -0500
Received: by mail-pl1-x642.google.com with SMTP id c23so1523345plz.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OPUi8tuEiit9Wmtq/650OfrBNud72916z3wN5jFxgBs=;
 b=OfAiq4S8nalHPgKaThPvzNMLoK9luVmS3USQZNBZssWdXSsuuAsi1mLztW4bhWBltH
 ouwjUMIaqknIj124jYvFn6VqCa3ETsSyU6q6W9PSrUMd9eRKJUFjQ68RdbIjsF7TQuH3
 n5y3uC2MJXzZx+fhKjD0r7nntYtP4LctxsIGBxYfBdahrF0zmcpJSXPUsWsF5m57yt33
 b57IO8ITqBK3jx4MsbmgLeERVvW17aPD2BK4LOv+HhmoWnold+SFNWetF/RjLfEewyVs
 BcOT03DB1z1YlykM53NMHotUmVcIii42tQuvwQes12YzdXFoxDQEb6opDBV/a4E5rTt1
 PvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OPUi8tuEiit9Wmtq/650OfrBNud72916z3wN5jFxgBs=;
 b=Vhh9elSyq6T9YM0HdpTIB9o3QcWsY/aumJpj+VeFoBrJr4YnW39VrrR/MEkkRPXGkm
 5Jh+P0kTuXbutEXcfW1DnLnhh8NI+rR52FnJt3wZ3gPM6iXF6UM3UHvfOW+Jiwo+FHeT
 tbx2pDqSSXktG9m7kbkg+rXcjZSGx/twMBnF5ZtXmJyu/usEAoTrru5Pj1gIPCMf1igZ
 2L9sVH9nTf1JuMA45/C4DALf94eldmnkj/031OBHXHZW2kHvt1R0MXTQWM2vdfo0Gddm
 u5g5XHGg/14v9c21c9TF/YKls8/AvtCySoIYsMn6n3JxNak1PkVZmXYdD5GJXTYmmrYU
 nEUg==
X-Gm-Message-State: APjAAAU6sLzuEuqvaBc4nEHJBKwM28kmiVAmyEsrKCClQX5PUaZPtxj1
 NrtfE3O38k/umvL7vGvJqoIQsQ==
X-Google-Smtp-Source: APXvYqznofrCLzCaPM/XLoF9USUhfOxCYdLKLB92MNxaUp5OA73DuAO6hSa7TmonTdRTAli+30IlaA==
X-Received: by 2002:a17:902:8a8d:: with SMTP id
 p13mr5306275plo.159.1580400581780; 
 Thu, 30 Jan 2020 08:09:41 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d4sm7178468pjg.19.2020.01.30.08.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 08:09:41 -0800 (PST)
Subject: Re: [PATCH 0/4] target/ppc: Use probe_access
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200129235040.24022-1-richard.henderson@linaro.org>
 <CAL1e-=jbTY6a-B4RkoR9hL_h5LiOwio=A6pp3=KqqjUu7bEWUQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <170b1d50-72b5-72c1-7bc5-9c41d84425cf@linaro.org>
Date: Thu, 30 Jan 2020 08:09:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jbTY6a-B4RkoR9hL_h5LiOwio=A6pp3=KqqjUu7bEWUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 5:35 PM, Aleksandar Markovic wrote:
> 00:51 Čet, 30.01.2020. Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> је написао/ла:
>>
>> The first two address the performance regression noticed
>> by Howard Spoelstra.  The last two are just something I
>> noticed at the same time.
>>
> 
> But, performance regression, according to Howard bisect analysis, happened
> because of the change in target-independant code, and the fix presented here is
> in target-specific code. This defies basic logic and deserves clear and
> detailed explanation.
> 
> My additional concern, of course, is: Are other targets exposed to performance
> degradation, and why?

Potentially, yes.  However:

It requires lots of loads in a loop, on a hot path.  I would not have guessed
that the ppc32 Load Multiple Word (et al) was on a hot path at all, since the
instructions are deprecated.  But that's what an ancient os gets you, I suppose.


r~

