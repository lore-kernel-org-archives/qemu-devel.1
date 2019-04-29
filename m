Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AE9C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA85C20675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tl58jg+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA85C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59515 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8X3-0004l3-3T
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:49:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL8VW-00047L-9x
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL8VV-0007fx-Cm
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:54 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hL8VV-0007db-3m
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:53 -0400
Received: by mail-pf1-x443.google.com with SMTP id w25so5497426pfi.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=h/1SoBh6eFQiLcZ9tBKK11GXQJEa4THpIDBXFiExC5o=;
	b=tl58jg+e2YH9ip5y+M3U4AIDYv0zOZETMDlW3bwkfPL7wYXn301NzIxNNfnHlbhiRR
	gvIVVLaMs4VLUw5L6ZORBHYkuMtq2cfEc8w0ZfwOYXCWMwKpCUiTgmIazW5n9qY5xWyK
	xzxq8E2GGVm6I/jgdoiVo81SvihkpT+Wv0BK5JqJGOkBpdXmSkGO9EwuXzVpPXqygEfz
	PMajGEaDkLxpZnC9cHFPY0GbBvvS/WPC20rGRdxrQtbag5Era8ZKvBtYUUQayKe9BnLG
	1h3DNfveV6k7myC0XCRdooSuvinzm9hOVOAtCurvmva4n5oT3grU6kRnUu6CvZEdYDpj
	7pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=h/1SoBh6eFQiLcZ9tBKK11GXQJEa4THpIDBXFiExC5o=;
	b=BzMYJDrQ9zPS5oZIjaB+EhOBH0sXCgcrd1eQ5tGE8HYQQVVQwLMWe9J543UogzcQwB
	6BrPp8NeDZaxXVXnSIUBm7M7mdaN/n2q4j30EO+rSNLgQynk8uSWVegREY7k3eMOQ4Y8
	1EL0D/TUieTyfrSNnco0+oJLZhnqYd5d2NqyMDb1CziCFWfPFb1qnptvKqFol6suBbjf
	04D6Ho07Akx75GrgXTdRysJ6HHOf4y7KX9Q7lC2dIuGLi2vTU9ltDYdy/b6vat6tNcSz
	Xoc1AVPHnjxD44QS1W+Nr4Y8MHkHX/7gqX4WvX74PHtCHjI/RxcqfwkxaphojzhzolK3
	OOlw==
X-Gm-Message-State: APjAAAV7LnrYslPxvVrHm+JDBo5OoSHgQO32EY5AMzzOQ37EBxVWJXN1
	NCKZ4uRIzdHmdZzb1mRANmryY0/yfvI=
X-Google-Smtp-Source: APXvYqwhkxE8q14C3HBkdkotzUnFIb0DGmPdongxqRAue7wGALSSLq2d83cIMAaYed8X8NuXokY+ZQ==
X-Received: by 2002:a63:4ce:: with SMTP id 197mr1405571pge.309.1556552871419; 
	Mon, 29 Apr 2019 08:47:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	71sm90563887pfs.36.2019.04.29.08.47.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 08:47:50 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-37-richard.henderson@linaro.org>
	<CAFEAcA-an2BRh+Ji0y-6P9e_3=Z22CDVSMJ1RAEXefa-MFZdFw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fdd4967a-7e65-1497-9377-456232f12d00@linaro.org>
Date: Mon, 29 Apr 2019 08:42:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-an2BRh+Ji0y-6P9e_3=Z22CDVSMJ1RAEXefa-MFZdFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 36/36] tcg/arm: Use LDRD to load
 tlb mask+table
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429154255.uAythx5QJkLO-EeNnTWXC85jkXPgfKwOd7bagedK1ho@z>

On 4/29/19 8:00 AM, Peter Maydell wrote:
> On Thu, 28 Mar 2019 at 23:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tcg/arm/tcg-target.inc.c | 109 +++++++++++++++++++--------------------
>>  1 file changed, 52 insertions(+), 57 deletions(-)
> 
> I think this would be easier to understand if the commit message
> included what the old and new generated code fragments looked like.

Fair enough.  This change is complicated by having
to rearrange register usage, so that we ldrd into r0+r1
instead of ldr into r1+r2, etc.  Just this once it would
have been easier in thumb2.  ;-)

> The same remark about a compile-time check that mask and
> table are where we expect from patch 35 applies here too.

Ok.


r~

