Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E6AC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 17:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32E725EA2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 17:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNX8BVdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32E725EA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWP8E-000381-60
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 13:46:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWP7D-0002cx-5G
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWP78-0007BS-55
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:45:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWP74-0006mx-6D
	for qemu-devel@nongnu.org; Thu, 30 May 2019 13:45:16 -0400
Received: by mail-oi1-x242.google.com with SMTP id v2so5614563oie.6
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=0R8swfNQjrymPqG2pGnlSykEzY9Im3peWnQnAGxobh8=;
	b=eNX8BVdvJnOSp943VEV3mjQndeuRpMDrhrcOm5dkJs+Xt/F5NMg6l6a2vGeeS+o0Zw
	BFzPfdgO7/dAnUU/xOQkj0P+b8xUNgAn8Dpaic3dP48nUubiIjKk252zLSiSse/P1BVU
	c5KeZEJm5wPmwbIP1YEaKPseLp+/PqL6iXxk1Im//EOZdlEXA3w24r613wGDgUcfwP+k
	4vACxirRaqtrtDrHZqJRmabrYspSLWwa47CFO+Rcz5ov8OtzxN7+KG1MX7iJ/WLOKLpp
	ZRInR/5oYiTB+i+xNpaWB5qV7nEhVVcNUYoitsA/kopb6PuFCxEs/ZT6pSXAnxUXZveT
	nLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=0R8swfNQjrymPqG2pGnlSykEzY9Im3peWnQnAGxobh8=;
	b=L4zu94kmLBA+h5aneojZgujyKMYlq0QwYHWs572DPpIEZm4l7V5l/8L1wgvO+pPS/X
	OmrApMCwJHKnqs0TlxJW3FCeFgxEyTmoWIdigHb1JDztdrHB0EZfyIluPBjIWATbUVsv
	UTO+IVQSx6xXLLmzOlmnvlUTIcMJ42Sxp2iAKCbt/jTnBTPyaTbDmcrB6nSZakTojB09
	jxIcioDfzvNJvAYPzJf0IRUkar5fnQXEkg9EjPyxTGDBNOuTzytc3IZMCk6goRZ5xUoZ
	q48fkIXeSJsoyeXOIM+EQUm7aYEq7y40+Iegt0ssupU9ZpB7S9x9vFh/c51DBXBDfipN
	PidA==
X-Gm-Message-State: APjAAAUQo5fdMDMdX0Uq63IIJc3STCRrsuqSKzEBK2r6to79W5CSJkrv
	3Imr5V9P0wHdOLekpcPRp5wr3jG+MsOL8Q==
X-Google-Smtp-Source: APXvYqxDeEezQjF86v5YDGuCBQorlVuxwqyH9Oewi4igzdKPMwdu6fxGZsDOekNQBBmz+ukeI+x37A==
X-Received: by 2002:aca:e005:: with SMTP id x5mr3057476oig.144.1559238310787; 
	Thu, 30 May 2019 10:45:10 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r14sm1199270otk.72.2019.05.30.10.45.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 10:45:09 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
	<20190522222821.23850-9-richard.henderson@linaro.org>
	<CAFEAcA9MTBqd5GO58hywGhYYGdbbvqiASwCvuKRBE+CVqVZTig@mail.gmail.com>
	<ecf35f19-ac1e-4964-8c9a-5cab000c6627@linaro.org>
	<CAL1e-=i6ee0YqGMOFBeiyPsiSzfF55CHePL6Gm_0pM17ZcG-PQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ce9444ea-b046-28b6-cb92-12e93b368caa@linaro.org>
Date: Thu, 30 May 2019 12:45:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i6ee0YqGMOFBeiyPsiSzfF55CHePL6Gm_0pM17ZcG-PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 08/16] tcg/i386: Support vector comparison
 select value
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 9:54 AM, Aleksandar Markovic wrote:
> 
> On May 30, 2019 2:50 PM, "Richard Henderson" <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
>>
>> On 5/30/19 6:26 AM, Peter Maydell wrote:
>> >> -#define TCG_TARGET_HAS_cmpsel_vec       0
>> >> +#define TCG_TARGET_HAS_cmpsel_vec       -1
>> >
>> > This is the only place where we define a TCG_TARGET_HAS_* macro
>> > to something other than 0 or 1, which means that Coverity
>> > complains (CID 1401702) when we use it in a logical boolean expression
>> >   return have_vec && TCG_TARGET_HAS_cmpsel_vec;
>> > later on.
>> >
>> > Should it really be -1, or is this a typo for 1 ?
>>
>> It really should be -1.
>> See commit 25c012b4009256505be3430480954a0233de343e,
>> which contains the rationale.
>>
> 
> How about extending commit message so that it contains explanation for -1
> introduced in this very patch allowing future developers not to need to reverse
> engineer whole git history to (maybe) find the explanation?

No.

There seems to be no point at which you would stop, and not include the entire
git history of the project into each and every commit message.

I will not be drawn into such a discussion further.


r~

