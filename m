Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA4C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BA620652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pAixm7Fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BA620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48205 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLU8C-0002uk-EH
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 10:53:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLU7M-0002at-Dy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLU7L-0005db-Hm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:52:24 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:34630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLU7L-0005dA-8T
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:52:23 -0400
Received: by mail-pg1-x52b.google.com with SMTP id c13so5983790pgt.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=p/5NPUlsw/ulNGg7HUzofaMTmY0SCmJvsf587diE75I=;
	b=pAixm7FvPutJinrId3ulbsQoMrFbCDBym4RvhDePdPMYMfTxz6lvUkAJ8/MIBuAyW+
	Kg1HipcS3DRZBUf35CXGOCPPB2spOvUF4WVokzx+wnCpJie7Jd7fc83oTsQYn4tQfo+i
	v6Xcj3XA3qvvhULA2h2uaOLOkb7sYTtjEQGoHNSQxX34h2403yc0BgTTjlKn84r1DUHX
	zu4aLzES0Jj/DnsNvh9etfeHNa/r0h5IMQiMKfj7d6dXcuGvanoDh3ix7FQabDGjwJRU
	7FbiCZbPJJq81uBr4J01/71B9P1Da4aOAFB6OzuZpkEzh0LRAEgtx+TyNwxZNElLyWzM
	IeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=p/5NPUlsw/ulNGg7HUzofaMTmY0SCmJvsf587diE75I=;
	b=evveKR4sPmWdX68vJg+Wqr2zIXwBh33kY5ILaKnc6CB334e8HyKIP7X82S6zXuiqcP
	ETqWyAzLkF004Dkj6e+1gAurc5sxh2v4GeKKJE6r55ULZlenHdsCwbIyPAArWGX9bK3c
	2fHFK/n97K5oN9hCJVteq4gZMZXxbXFSHib143xD1S27uipMx31McEeLLkX7c8SRK3KM
	mA+HNmmdSCBjDAg5wXKO/8HDKSspkYKY7wKtr+Hw06KLlWPDUVq7i3aJEA+SFZzOCaTe
	//hUszdPr/vn8CJWFHxu/RZV0Y+9qI1n3fJAL/CeHHWC8yUtPYbBERWPYSZhAzFySVUK
	H5Og==
X-Gm-Message-State: APjAAAWrACK4iiWA81sZG8hVhoLG/ZZWg/ccFH76gbCDPbecamnyg0zO
	1jk8cvSsN50fx/YvJTxGxOKHqw==
X-Google-Smtp-Source: APXvYqyxwY3RRrJkJ7ftzlcMmnn4OoJHzigIVoMzYAQF/4zfmVD5qFhfPu3kDQ4rbgS7aoCxKawvwQ==
X-Received: by 2002:a63:8bc9:: with SMTP id
	j192mr23100726pge.212.1556635941824; 
	Tue, 30 Apr 2019 07:52:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	m11sm75644678pgd.12.2019.04.30.07.52.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 07:52:20 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-8-richard.henderson@linaro.org>
	<CAFEAcA-_OG6DKJCVqYahNOo_oMoiWSq0Tb7+dQhOGh3jFg01=g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9ac3730c-930b-fdaf-6271-e16c1a0b50aa@linaro.org>
Date: Tue, 30 Apr 2019 07:52:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-_OG6DKJCVqYahNOo_oMoiWSq0Tb7+dQhOGh3jFg01=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52b
Subject: Re: [Qemu-devel] [PATCH 07/26] target/i386: Convert to
 CPUClass::tlb_fill
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430145214.NoRBTPs8ixhqt30Drr5ClPkD-jECeSilWJ9a90Y2Fzk@z>

On 4/30/19 4:49 AM, Peter Maydell wrote:
>> --- a/target/i386/mem_helper.c
>> +++ b/target/i386/mem_helper.c
>> @@ -191,24 +191,3 @@ void helper_boundl(CPUX86State *env, target_ulong a0, int v)
>>          raise_exception_ra(env, EXCP05_BOUND, GETPC());
>>      }
>>  }
>> -
>> -#if !defined(CONFIG_USER_ONLY)
>> -/* try to fill the TLB and return an exception if error. If retaddr is
>> - * NULL, it means that the function was called in C code (i.e. not
>> - * from generated code or from helper.c)
>> - */
>> -/* XXX: fix it to restore all registers */
> 
> Is this XXX comment definitely stale ?

This is a pre-TCG comment, from 61382a500a9 ("full softmmu support"), from
2003.  It has only been moved around since.  I can only imagine what problem
Fabrice might have been reminding himself.


r~

