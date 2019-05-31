Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4CBC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 12:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2958F268DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 12:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjpUJSfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2958F268DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42695 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWggO-0002if-Al
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 08:30:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWgf7-0002Dj-Gi
	for qemu-devel@nongnu.org; Fri, 31 May 2019 08:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWgUd-0006ju-Hi
	for qemu-devel@nongnu.org; Fri, 31 May 2019 08:18:44 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWgUd-0006jS-DI
	for qemu-devel@nongnu.org; Fri, 31 May 2019 08:18:43 -0400
Received: by mail-ot1-x342.google.com with SMTP id l17so8973140otq.1
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=zOudxO+lxcFQ0dAceV2+BYWMrtoFUhxnVm/pIZbiimc=;
	b=bjpUJSfuBuwpfWKXzC2JTJHGH7yV7i9OPwgq4Km4ZGElRZ7qEnh3j3JQc+lKgn5u5+
	c4H4TrWKdrBQ0yxHlb8yeSgJ06WqppjrtNTsNR4LAWrukEhvLzTFP/PiSWgAjEX3biRz
	6G16mrn70Qq1TKJm7WebPadL/GkbtwHN8ggh8aM088rP2oNkLusga/ZqIU3lwna34Bgt
	C+f/bWW7tapXBLsVRpzQBjcuxHFqoFSK8L6vTTDxmuwLSH+xse5B4vZ3ThLsiEsSQFpj
	JLqgCmTflqlOOUICMwFLoK/nEwuqYt6LXdupbCIAddyqe6VsOoyh9cL1O0e4YjsEJ8wu
	IOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=zOudxO+lxcFQ0dAceV2+BYWMrtoFUhxnVm/pIZbiimc=;
	b=cghYGdV51icuKj8T07QQg7cK0Dy7fyhmcbcmEPjQCxBhnxUnLtlfCa+GN+icC/Vf2P
	dy+7HBYnHr5iyPon1DcmTMAEnsWFJXDe14f4AGUNJUdzORXCPhx9VZVsVCiw5f15ql1I
	DujLfTflalkob7PKihK0yzLUKjM+DCbw5e/mXbCrncWDpgIM1jjivj0jc9yQZv2Y08oZ
	mg0ZAp02USzvyTfi3p9tOyLSH7Rm1Ny3gNFcWx/iHj5Z421I2LKvCl93F1s6Xu32smhd
	rUjDRIuiZ4f3Z9c8M5WU6M40fvvesmy+pw7UUgCxXVyvjEzJpMqfDN1MkEoheHvmK99f
	mOdA==
X-Gm-Message-State: APjAAAXJ8eKtfcZOnCQIqgvecJhCg9nXpNPG+t5zMIJmlQXo1IGEzP33
	FacmQvIml9+X0dlRz17fvyu+6z0PHaTZQw==
X-Google-Smtp-Source: APXvYqxiriXbuzUd+ks85I/BW83ypQmd1hfk82CUzyFxNPHOAyUw0LDtYQ4vpeqTYbVhl248xxe/3g==
X-Received: by 2002:a9d:7642:: with SMTP id o2mr313881otl.203.1559305121728;
	Fri, 31 May 2019 05:18:41 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r205sm2083749oig.0.2019.05.31.05.18.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 05:18:39 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
	<20190520170302.13643-20-cohuck@redhat.com>
	<CAFEAcA-NBnfATjAcCdvMBtzuPcEArz4Z_TJnZdnfjdPhKFcaDQ@mail.gmail.com>
	<00219505-bdb0-628b-9aed-f3211eb10b61@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6efe429b-5c3b-dc62-70fd-362b7c48072c@linaro.org>
Date: Fri, 31 May 2019 07:18:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <00219505-bdb0-628b-9aed-f3211eb10b61@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 19/54] s390x/tcg: Implement VECTOR GALOIS
 FIELD MULTIPLY SUM (AND ACCUMULATE)
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 6:32 AM, David Hildenbrand wrote:
> On 30.05.19 13:22, Peter Maydell wrote:
>> Hi -- Coverity (CID 1401703) complains that a lot of this
>> function is dead code:
>>
>>> +static S390Vector galois_multiply64(uint64_t a, uint64_t b)
>>> +{
>>> +    S390Vector res = {};
>>> +    S390Vector va = {
>>> +        .doubleword[1] = a,
>>> +    };
...
>> but I can't make any sense of its annotations or why it
>> thinks this is true. Would somebody like to have a look at the
>> issue? If it's just Coverity getting confused we can mark it
>> as a false positive.
> 
> I can't make absolutely any sense of the coverity gibberish as well.
> 
> The only think is that "vb->doubleword[0]" will always be 0, but that's
> not what coverity is complaining about.
> 
> Marking it as false positive, thanks!

It does seem to be gibberish.  How in the world does it believe that the
dimensionality of S390Vector is variable.

However, because of where the two errors are placed, I can only imagine that
Coverity is confused by the syntax of the initialization.

If it were easier to run and get results, I'd try making the assignment as a
separate statement, instead of the init syntax.  But it's probably not worth
the churn.


r~

