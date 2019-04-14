Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E18EC10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 19:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8182073F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 19:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeBCraSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8182073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFl0X-0003Ed-EW
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 15:41:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFkzd-0002oI-Hm
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFkzZ-0004Ew-KQ
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:40:45 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:36820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFkzW-0004Cr-BL
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:40:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id 85so7535174pgc.3
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=nGHobgXK2oi3BhhWYP+ReBEL0ebOMtubngBseljgzDk=;
	b=XeBCraSscpXKDC9V9CxmS5wLjl+saNVuGrIwZL8T6b26bPjc5aFLRxe1CXW/gDuuiz
	jXnFRS4FY6tzQSm9wWXdwzLdtGt13lUuPIuNbNwwBaJZi5unGEe83qd0r7TwKNqQr8ml
	ZccIwK4mJ5fIkMEfJJjIPQn+x/DIBJReoUDupqeBifKxMMUZPwWtfBxd/Lg1UJfcnGso
	e3zpIWsGUXI1TPFm/EPp0/dsa35mMJif9sGjPt7tXmRKnWX1WhGQY0OFQ0ET1hw1yxQ+
	CFLxC2cCEmTkVfm6Xivl3M74hzP5xRD1+WirOOlOHu7nmHCLQ45hR4HPdaW2j0j4YWvk
	zJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=nGHobgXK2oi3BhhWYP+ReBEL0ebOMtubngBseljgzDk=;
	b=tlgz9YA9VtSyduJBoYhhUr1zndV8OeP7XTFYeVrycAdGS5n/q3EiglaUHHALUC6i7d
	9khXGl9TRRlyMO7r+lYdH43rsPda1Ho6jTNL1/4id0GigSIadW2y+iP6krk0QbVBAxk7
	j4+xXqnLQYXtQh9S7TlBf60+CudpP5OzBHr1JmcD8PsuDwZM/TnQXfMiyIsl93n/H8wl
	Fnrvznw8CWq9KDZanqBXPheKPTi+TFPpYyS/ceJFOfoDaQBzUEOMrOPkqwiRM0fVWDf6
	K60pctbP+35G7mQgC3ONhg9/Ixtf1PDFcJ/FYo21iM7/6nS2cX4QawireGGwtmVZ+88z
	xu/A==
X-Gm-Message-State: APjAAAXKn9awrERUe4F4cO0SqMjYjkHn6DAXYpfGQNrdq337zNLR+127
	dkCHRJyp9CRcQFyipX5gY8CrHt202fA=
X-Google-Smtp-Source: APXvYqx9LOrGqHjwphQ5qVujMFcqlAIn2tdpHCiX2N6HUlSt3nUZDL/jqOXuegJ2lr5YNssP3J+4LA==
X-Received: by 2002:aa7:83d1:: with SMTP id j17mr71864621pfn.78.1555270835027; 
	Sun, 14 Apr 2019 12:40:35 -0700 (PDT)
Received: from [100.68.67.33] (rrcs-76-81-86-38.west.biz.rr.com. [76.81.86.38])
	by smtp.gmail.com with ESMTPSA id
	i135sm63493969pgd.41.2019.04.14.12.40.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 14 Apr 2019 12:40:34 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
	<CAFEAcA-dbGvhgTrBKEtx-CPS7f2NJO5X+dj=mdcm+NrkF=uynQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0ee4fdc6-c782-d5f5-ec40-9e25c1c9dd1f@linaro.org>
Date: Sun, 14 Apr 2019 09:40:30 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-dbGvhgTrBKEtx-CPS7f2NJO5X+dj=mdcm+NrkF=uynQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414194030.1B2x5C7iTpHfE17pXieyRDFC44Co9RpFcZ7VIQIOL1M@z>

On 4/14/19 8:02 AM, Peter Maydell wrote:
> There's similar wording for the effect of NSACR on CPACR, so
> again I think we need to actually make the bits RAZ/WI
> regardless of their underlying value, not just force them
> to 0.

I don't see that language for CPACR, just "the corresponding bits in the CPACR
ignore writes and read as 0b00".  I'm willing to believe the manual is sloppy
on this point though, and the "correct" language appears only once, somewhere.

You might want to something akin to arm_hcr_el2_eff so that you don't have to
replicate the NSACR logic in too many places...


r~

