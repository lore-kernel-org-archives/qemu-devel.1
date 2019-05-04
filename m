Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8CEC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331FF206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O58nZNZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331FF206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMo68-00008w-71
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:24:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnxY-0002T8-Df
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnxX-0001WM-KF
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:15:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:38565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnxX-0001Ta-Db
	for qemu-devel@nongnu.org; Sat, 04 May 2019 02:15:43 -0400
Received: by mail-pl1-x636.google.com with SMTP id a59so3745093pla.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 23:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=7I+NxvFtfIt4ex1glmwM+rDwPrwaIoN2L0161d3T5QM=;
	b=O58nZNZDZGsDxPCQN2XKQYw6bMBqv43SsizyBzp0Bo7XPFGbvfIOlgAh8c1aoSq7SL
	U7Js2r6QeWUZM1+ndwDje2EBgJrka3AtvsRACgVWug5ggdLxb/ocdJY7VOQlqU8wBKuV
	mDtLghXG/pJFwjCLNkwyG3QuOZJpR5JXLd/E7POyHViQyIU7W2yIzcdbzEE3OQwLTvb4
	8qjCu2kgZMMwMN6eDFWQ3YcHkGSJgExM1NfbItvs3MpCmLn3tbDvNigJYf5vM2HY5kGY
	Orcb92Z/Jkzkm1Zb9CEdUaCqFv5rDuT8aUlt1/VISSAP9M6BggLXrEKj5TY5JqmKg9wN
	jOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7I+NxvFtfIt4ex1glmwM+rDwPrwaIoN2L0161d3T5QM=;
	b=CNnIeEPe9KcGmVsVVsNHlmw2QPleq99UErT6IJ3me5gm+BQ6OkJH0MJEpWiE8nHBBG
	x2I/ybQ2pBGF+emoVEN4HeliizDl7HtfnxXqNssj6jK544CSq2z0eH/EHyMnbws6hkuV
	JrEoFfFk0CbhBuR5Ik147WCrNXEpBq7Tlym4evn62D+bkZrRmF878uTQ3fjLcpNvNg6i
	DA28akSnwIy+4Bs91iso+vwBFKWcJ0vdwYvtZXRCvHLSlNQazmPkv8r7tN5Bjy87OrJS
	OzANK3dZFtGqijyZqy9KHr83ASHgtptqRwG/JKgGju+9DUW7OWq0pXS7vSm1chC58tkT
	C6DQ==
X-Gm-Message-State: APjAAAXTmvnq/iBEA19s1w6RPdlhVtxt3eJC6fN+iyFpbVhC5ydlR+ia
	3L7f+kovS+Sp/McvE/O/ILEifrX7BDY=
X-Google-Smtp-Source: APXvYqzKRO/iuJGI3H7yQd61cGrT9I4Iuo9cN43XLrONlwOmWe+qb5dOeJOX4rLpzseEqXI5+9Q98Q==
X-Received: by 2002:a17:902:8c85:: with SMTP id
	t5mr16380117plo.23.1556950541918; 
	Fri, 03 May 2019 23:15:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	f21sm4925539pfn.30.2019.05.03.23.15.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 23:15:41 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190501184306.15208-1-richard.henderson@linaro.org>
	<877eb74gc3.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6206383e-d092-28cf-1549-ab01a306bb05@linaro.org>
Date: Fri, 3 May 2019 23:15:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <877eb74gc3.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::636
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/alpha: add system boot.S
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504061539.7aa_GMb_W0sGzU2uoaQ-Fh_FTUE6tq1Fzk3T8Wz8dd8@z>

On 5/3/19 10:07 AM, Alex Bennée wrote:
> +	ldah	$sp, $stack_end($gp)	!gprelhigh
> +	lda	$sp, $stack_end($gp)	!gprellow

Bah.                           ^^^^ $sp

As is, this works only because the test case is tiny, and this happens to
evaluate to the middle of the stack allocation.


r~

