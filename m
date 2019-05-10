Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FD8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F8D21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVwEgMkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F8D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5y4-0000q7-Ak
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:53:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP5wv-0000Q5-8D
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP5wt-0004bB-M0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:52:32 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP5wr-0004YH-SX
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:52:30 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so2877826plp.10
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=s1yaS2qGTV4sFX3OmBTZVcWIBIRwYq/Ko7F++b45xJA=;
	b=KVwEgMkAYDQKzfbC+ziU6h/Gt/ghZG1ZJRfUwbOlQymhKG2Pp39Get/jRl6Uh78n9y
	6k0WWW6Fwkf+7x8o+mO9BuYNwqHFmik00glNEACElytyHe5Fv+sgo1jUzeAQcLa+NgYb
	jggBc0rfEFQjID30Hp5Zn/4rOTcTDzPf/DNsp1s4We6+WiIlHhPKVeKX71bwAZRVxwfl
	ig0KkNu2PKEON4Dr5woT5vdmaOaD7mo8mvjpgzKoZxjWdoqwkJP3S2fD0YWcdbDArHje
	pd5+HRTOVOLRlB7xsUoPnbFGw/DdvmzkJP9meaS1y8Z84Or76wmWPYSW4pVY0YsB7U8g
	ozxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=s1yaS2qGTV4sFX3OmBTZVcWIBIRwYq/Ko7F++b45xJA=;
	b=A/a7c4hlLPK1pPRyfdKJqMf251tSu6wWYyXYYuUcA065jtTnZi2EJzaS9JFcPHzpaL
	OT7XGJ911FwISL/KG4z8QXhHV/ZieD47PpJ5NBdoBCulEYmnGVDiLJVfL9soMeqNoNYE
	vaPcHHXjXqR8tAgg26H/BdbrHxbuecZgoCBQRVogxJhMOS/g2zANVRMqJDRZSpx7gzHx
	7VcasGFcLMtmJNHl1KKnOP0PUBp3vi02uedq5fhI8zkoQe6y9YsytfORlcrDP/hNBUEM
	ogwYw7xb1abSXGrL0YONiJXAqgZ1CM6mb6epgLOkEqVTf1sH2CF2hhJcLYp6ln0P8eKa
	keng==
X-Gm-Message-State: APjAAAXyzdTvCE5c/sAm8qosCuDqRtP/BhUftgEQKQG5RBJsIFtbJu1N
	ZQQDsJ1I05rzP61gyVZ/9UDagg==
X-Google-Smtp-Source: APXvYqySsVUoEK7Io4a111Hi3tAzTa5C3/4hMUQfPx7j6EQ7VMAoK+VpXeOUQEyD3IeezaSZG51bKg==
X-Received: by 2002:a17:902:a988:: with SMTP id
	bh8mr13015640plb.243.1557496341246; 
	Fri, 10 May 2019 06:52:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	b18sm8931662pfp.32.2019.05.10.06.52.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 06:52:20 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
	<252a5c4b-6ba7-6fa7-8792-fe597e766757@linaro.org>
	<87pnoq4x4o.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f6abf67c-94af-22a6-c648-2fdbfe73974d@linaro.org>
Date: Fri, 10 May 2019 06:52:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87pnoq4x4o.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 11:55 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 5/9/19 9:58 AM, Alex Bennée wrote:
>>> @@ -51,12 +51,18 @@ static inline const char *semihosting_get_cmdline(void)
>>>  {
>>>      return NULL;
>>>  }
>>> +
>>> +static inline Chardev *semihosting_get_chardev(void)
>>> +{
>>> +    return NULL;
>>> +}
>>
>> Isn't the point of this function to avoid...
> 
> Yes... but...
> 
>>
>>> -                return write(STDERR_FILENO, &c, 1);
>>> +#ifdef CONFIG_SOFTMMU
>>> +              Chardev *chardev = semihosting_get_chardev();
>>> +              if (chardev) {
>>> +                  return qemu_chr_write_all(chardev, (uint8_t *) &c,
>> 1);
> 
> The qemu_chr device stuff doesn't have such stubs and is softmmu only as
> well. *sigh*

Ah, I see.  Yes that's a problem.

Well at least you don't need the "else\n#endif\n{" ugliness.  You have the
return out of the then block.


r~

