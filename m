Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F61CC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 09:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C172173C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 09:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ra1y9FCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C172173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGgfa-0004Fd-Mn
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 05:15:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGgej-0003qk-Jn
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 05:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGgei-0000zQ-Bb
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 05:15:01 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hGgeg-0000xO-3B; Wed, 17 Apr 2019 05:14:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id w24so11750022plp.2;
	Wed, 17 Apr 2019 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vyELmQXmNj8pJPSrjeLn9t+323WBzM7meh6+7SR/o5A=;
	b=ra1y9FCx/RS+w4jJQBrmoGEseA9MkVpFvEHYKR+kik3ufXJAs3kgSjWMU1aOhIAlfW
	YJAeFowZQBkM/rWcLn+JGEWhWTyoanddADb4Xar55zmrF+ctx7H4DgLAC5bPzwlsZauj
	URKj7OTwcuAXRc+hFDgq+jbfYxjSLGDO9/CFUGXjeOqg0Znd9w6BLzlgY2ln9CJVC27D
	lFscUxndjnTPp0sl9NwXScq7cdHDXTek5DLvoYIyrsIfPzJMl/3lsor+wuD6zG+dxawu
	C0y9TCWU474vm9sZ6bzySSviYL6Y8sRgKmziD3A9SFX4LYy5sdM7Z09dQ55YCiHrzo74
	T7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=vyELmQXmNj8pJPSrjeLn9t+323WBzM7meh6+7SR/o5A=;
	b=GtjnMH62HMPjPYsr4/zvN8jtstrMHjFaJyL7bVwJOGWS1j3SsySopFoX2YogiwXd1/
	PUv3hl0DJZ/cn+2lJtuiklGBohSBOSqF2yyla2Otxl78ZusIaGwbuVxavjmML5IX9H6h
	5FywNWr/1+u7Bbaah3Kavd7Kb9aR+e0mKka/vT9vC81ylO+cb3fSnRsnu99WZtrrUAtT
	udoCN60ykaKP9jCKzFJhpjttHkhVpmm/sC+P6rzVsA6TmdIUAnvvC0kY5BisSfOfl2/H
	KyTHtu/mnHrtJObEwhghzeE/0QGeE5NEj/ltCteuc3oVf25MYdJ1WQueTY+uf0x95mel
	MnwA==
X-Gm-Message-State: APjAAAWAxi9WLMp7vLZoc/tAI5Q15pW3ZNN8QKuqweQE2MtFb5E0DIVZ
	XvFYbTTvagtEWBXVlTe6bVM=
X-Google-Smtp-Source: APXvYqxP8n/U/6YSTsIWpht2KMJjdA0vQlAlRtRpuZOdjRd33Kl1zahwQuFk6XWquEBz8KcuS/QF1w==
X-Received: by 2002:a17:902:801:: with SMTP id 1mr12296640plk.14.1555492496347;
	Wed, 17 Apr 2019 02:14:56 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.googlemail.com with ESMTPSA id
	a9sm75604436pfo.17.2019.04.17.02.14.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 17 Apr 2019 02:14:55 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-2-david@redhat.com>
	<7ab7e798-1d68-99f8-acda-873ad94a5fae@linaro.org>
	<74ad67c6-bd3e-d37f-598a-334d2febcea1@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
	mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
	n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
	rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
	Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
	n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
	AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
	CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
	cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
	Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
	eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
	LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
	Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
	94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
	86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
	I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
	VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
	+PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
	AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
	Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
	prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
	/E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
	jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
	VcROBqvtH3ecaIL9iw==
Message-ID: <e80a4dda-5837-4ba3-a14e-dad6a4a5b460@twiddle.net>
Date: Tue, 16 Apr 2019 23:14:52 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <74ad67c6-bd3e-d37f-598a-334d2febcea1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::631
Subject: Re: [Qemu-devel] [PATCH v2 01/41] tcg: Implement tcg_gen_gvec_3i()
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
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417091452.p2oqMP19J7oHGGcb6FMJTcj2pasg8ArBhzt3-Fn5skQ@z>

On 4/16/19 9:42 PM, David Hildenbrand wrote:
> On 17.04.19 06:30, Richard Henderson wrote:
>> On 4/16/19 8:52 AM, David Hildenbrand wrote:
>>> Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
>>> without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
>>> for now.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  tcg/tcg-op-gvec.h |  24 ++++++++
>>>  2 files changed, 163 insertions(+)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>
>> r~
>>
> 
> Thanks, can this go via Conny's tree or do you want to include this one
> in your next TCG pull request?
> 

Hmm.  Lemme take it through my tree, so that I can handle the
conflict that's certain to arise with the .opc adjustment.

There's only one patch in this set that depends on this, I think?
Connie may be able to take the other 39 in the meantime.


r~

