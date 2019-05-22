Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BAAC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A2820645
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTmead9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWTo-0004EJ-NM
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:00:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hTWOe-0008Ga-Ne
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hTWG4-0001ZM-5g
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:46:36 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hTWG1-0001Vl-ED; Wed, 22 May 2019 14:46:34 -0400
Received: by mail-yb1-xb43.google.com with SMTP id v78so1270757ybv.1;
	Wed, 22 May 2019 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Wze8lD+Ani6FPOmajUP9WiVt5LEqy7gSKau968Nx7YM=;
	b=KTmead9csu66CHGCbbZjlXOsQqxq+O7nz0dpaSa+gsFHae/Vh/l10MNW+g7csbvgF1
	GdJCdkiVJlq2TNClaR3XneUbewCUkeq7njWmDucXkNliIG82Sp87GUHl7U24Jap4awk8
	KdyUU1F2Lbdmb0bdShj1WWVi4KeoOHGvx0s83iI3GeqHJa3tj1M9bGd9/lNpOKh6X5oU
	iQZPE+su8eT2XasoXkMbtKxXkfw9M931fQ3LUTvqvo3tDRJr1XR157xTsnsUn2MPEKK2
	7P0pkCAIgwPKCn0YKPcUcbEHDDFCXSb7Tvjh1qDE89OQ1eqaHobbsxmlEgzcxrBX/CfW
	FRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=Wze8lD+Ani6FPOmajUP9WiVt5LEqy7gSKau968Nx7YM=;
	b=NSz2cZggbQc3vB71s/n720X682foFVH4Jx3HogzxqK7IJkWho+UGJxvmn74OJce106
	TR10Xv1+qQrMm/Bwmy6z0NfYnLP4bQa0cSd1PK3RNpZFP08gQZpHz3rBSWx5BfGfuyoM
	9UDoSEN1iB7WWcFnEM88l/uNfAyB47VlhPLqpRFa8+5jZpYCjsuNuOd2XcIvLW6jbUun
	RjH+8/WUZEOdk4pGEAv73QyHeSOj/qHiTsr4D2o1RkVUqQl5/uC1/JDRZ6YtzrEPi0xN
	rWsLvcfleu07xgznYLjlSqB6lDF3029dtJAEkUvGKEzNyB5qmAAwPTgMyS6mYf6aB/Kd
	ZSPA==
X-Gm-Message-State: APjAAAXC6eeA+JkzJkLSHxZdQ2CRnMPtjFuG15Cj8gxvMAA6w4rj6fvn
	U2vSQDsiDR4/GTVB/szGOn8=
X-Google-Smtp-Source: APXvYqzv2B7QWxgXaWoH5uWiDQ6YRJjMNy6xHscgFBXY4heTvFL6q9qN2wHwIpjcDMcaD/KgP2XEtg==
X-Received: by 2002:a25:4055:: with SMTP id n82mr4011761yba.351.1558550789576; 
	Wed, 22 May 2019 11:46:29 -0700 (PDT)
Received: from [10.243.31.58] ([71.46.56.17])
	by smtp.googlemail.com with ESMTPSA id
	m185sm6300512ywf.38.2019.05.22.11.46.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:46:28 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-2-david@redhat.com>
	<b3611279-15c4-f9b7-2a91-051ac6431b2c@linaro.org>
	<44d7ddb4-040f-6778-7439-043b94e354ec@redhat.com>
	<0935643f-941f-5883-c481-8ac18d57c98d@linaro.org>
	<1f6001a2-e1d3-2b6f-e84a-8b9963302a3c@redhat.com>
	<CAFXwXr=YzSuVa9wMKAczhojU+sK5zzPqpWOaJXDLovLNcmkYqg@mail.gmail.com>
	<db392f3c-2bb2-6e16-ebe8-3175ef7859f4@redhat.com>
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
Message-ID: <9b00d53e-d676-7d19-cab6-7fb7a6715d1e@twiddle.net>
Date: Wed, 22 May 2019 14:46:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <db392f3c-2bb2-6e16-ebe8-3175ef7859f4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Cornelia Huck <cohuck@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/19 2:16 PM, David Hildenbrand wrote:
> On 22.05.19 17:59, Richard Henderson wrote:
>> On Wed, 22 May 2019 at 07:16, David Hildenbrand <david@redhat.com> wrote:
>>>> Also plausible.  I guess it would be good to know, anyway.
>>>
>>> I'll dump the parameters when booting Linux. My gut feeling is that the
>>> cc option is basically never used ...
>>
>> It looks like our intuition is wrong about that.
> 
> Thanks for checking!
> 
>>
>> rth@cloudburst:~/glibc/src/sysdeps/s390$ grep -r vfaezbs * | wc -l
>> 15
>>
>> These set cc, use zs, and do not use rt.
>>
>> rth@cloudburst:~/glibc/src/sysdeps/s390$ grep -r 'vfaeb' * | wc -l
>> 3
>>
>> These do not set cc, do not use zs, and do use rt.
>>
>> Those are the only two VFAE forms used by glibc (note that the same
>> variants as 'f' are used by the wide-character strings).
>>
> 
> I guess "rt" and "cc" make the biggest difference. Maybe special case
> these two, result in 4 variants for each of the 3 element sizes?

Sounds good.


r~


