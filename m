Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CEDC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F986217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMgaVkhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F986217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40343 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTP98-0002dk-Lv
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:10:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTP8B-0002FL-84
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTP8A-0000yi-C1
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:09:59 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:34626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTP8A-0000xX-0b
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:09:58 -0400
Received: by mail-yw1-xc43.google.com with SMTP id n76so689786ywd.1
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=pW0i08vcVu7ySnMBJYTKbCGFNIHZmz47emF+kigRN6Y=;
	b=xMgaVkhWweYlTO1AzmRvIDpNWSpVquxF0BR9cJFH9cQEkI/NV+piNl+mf/UCze6tor
	89gPITF97Cn3PJk6frogBAcwD2mMpdFQ0+XY/5K7vcHNEFoUQDj2OWZliu/y6l/aIqDL
	m5e7N8DpgVRmSA+PBDmnWBVdeqN+d/OSSnT1Qq1c26hr01tDh7hKx+SAnHHvwM9v5Sf3
	ymEZGSb/65EQF/Z/wdtzzNU0R234agWiQxRHcYzn6QLcQqCD1eP+ky6dlGoABIA079xW
	/YKfO2+iuRfYQ44Xghh0zgz5GlGAcgxj6Qtnj5lxc9b8pwABQ97jxQzPngEKGp7yrJg3
	Ymow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pW0i08vcVu7ySnMBJYTKbCGFNIHZmz47emF+kigRN6Y=;
	b=b8PJdqInR3dvNfQFSfmEPcJCRWkInm9/96LtllQOcJrZT1T3CepPhDZxqRjD/mfsjj
	QZE1X9K3L0nCBe1+3mEz/HElUQ0p62dTuJbDUK9njdsbjbGPX9wpH+tMLfsdPoW33sw0
	eVzHoUhj4AV1ibHJ8BaEWjcxH5VSxPh3ze0yZqiPysxNLUn9dvvChfuayRgwfr9C0aWx
	ypY6dYO3RYa1ue8cKzuifFGJkexw47FzhZN/30LfBHzLqb0bm7V+6JpnDYm/axhaeN8A
	CDrmu0iDtEIXBrjPY8GETPNPc9+4bEravkTEDLVtwoL0URDsQxAJRk2nb8TcsnJrDMSY
	RFwA==
X-Gm-Message-State: APjAAAV9dl75f6VgPgW1ic1sqaM7gSePrjKuhEXixY7p7ReILugNC3Ap
	Gazi9eXDVh0LA5TVK5v8LRzu5g==
X-Google-Smtp-Source: APXvYqw2g+jaZe/ar+wdZCWP15aWcEu1OtT1DGzsgdJuiyIxvtrBUKuMBL84R/fOg7eErjyuJ8a92Q==
X-Received: by 2002:a81:a34a:: with SMTP id a71mr29538973ywh.318.1558523396747;
	Wed, 22 May 2019 04:09:56 -0700 (PDT)
Received: from [10.243.202.139] ([71.46.56.72])
	by smtp.gmail.com with ESMTPSA id
	c205sm6183301ywc.10.2019.05.22.04.09.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 04:09:56 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-2-david@redhat.com>
	<b3611279-15c4-f9b7-2a91-051ac6431b2c@linaro.org>
	<44d7ddb4-040f-6778-7439-043b94e354ec@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0935643f-941f-5883-c481-8ac18d57c98d@linaro.org>
Date: Wed, 22 May 2019 07:09:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <44d7ddb4-040f-6778-7439-043b94e354ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390x/tcg: Implement VECTOR FIND
 ANY ELEMENT EQUAL
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/19 7:01 AM, David Hildenbrand wrote:
> 
>> I also think that, if we create a bunch more of these wrappers:
>>
>>> +DEF_VFAE_HELPER(8)
>>> +DEF_VFAE_HELPER(16)
>>> +DEF_VFAE_HELPER(32)
>>
>> then RT and ZS can be passed in as constant parameters to the above, and then
>> the compiler will fold away all of the stuff that's not needed for each
>> different case.  Which, I think, is significant.  These are practically
>> different instructions with the different modifiers.
>>
> 
> So, we have 4 flags, resulting in 16 variants. Times 3 element sizes ...
> 48 helpers in total. Do we really want to go down that path?

Maybe?

> I can also go ahead any try to identify the most frequent users (in
> Linux) and only specialize that one.

Also plausible.  I guess it would be good to know, anyway.

I think RT probably makes the largest difference to the layout of the function,
so maybe that's the one we pick.  We could also leave our options open and make
the 3 non-CC flags be parameters to the inline function, just extract them from
the M4 parameter at the one higher level.


r~

