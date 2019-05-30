Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD34C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEB2258FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdcTIf5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEB2258FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWKWS-0002eX-7i
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 08:51:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWKVV-0002Go-QK
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWKVU-0007rX-Tt
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:50:09 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWKVU-0007qB-O3
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:50:08 -0400
Received: by mail-ot1-x330.google.com with SMTP id n18so5497610otq.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mBOcrcCN5cPqIBGOUFCAceJzgWzTW//EfWBX16JSSYs=;
	b=LdcTIf5UuCm+p+roUmVlVjjf7Mu0r7h/H8BTwmh6I3WSHZCJSf4x9DQL6EZV8j/Itd
	HNzUbUxySXr/YSjjXcLE4LkruNeDIId5fNC9fpiF4Gh8T5/hPUnjAAuzDsSYZ85hnL0L
	Ah6o/HGKatdvPuGFmb5QoyGRIG/ds+zi8aaoMihpfM9rE2rQVIE4n3hh5nSBRAaW1ehc
	BRFbBp70o4sTC3EgjIidJSRW2evRespKqWyPJuoWQS69BmN+Mtr9NKAlQLBiG3NdUKZW
	BXSPPC3Xs+OrdLsQUE5xC0Jx4RWdIKsVkt8Q4XQ2ipYgl9wcPdb6vlpM5zZHmWN/mPZR
	0C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mBOcrcCN5cPqIBGOUFCAceJzgWzTW//EfWBX16JSSYs=;
	b=YI++HMlSNcPsK3112poe0fDJRw/Gkv43Mwvkmt9O6GoOpyTLb6NLfq6fj8X3xmhEv/
	/SW8r6cWHIPzqXZPo2wJ6mVoIkXoGL6mZtLMI2FKCZ1i///mzK6czuikNZCgJtnpXFgk
	fz7uBlCBYLqZq5cdNUNz2Hv8zY5vHv+eCY85YrsRqTav/0SZhYliA1Lh/t3xQQgujGGE
	r9MzB6mKv2eJSPt6HiBT+b6anRmGdWOsNZIqlmN0G289IptYE1PvEKLRt322cuy7+2v8
	eK1xaGgbp3rW8mUUc4naKIa++xt06OwqZdPcwlkC9fCd4B53HJvGUVJcd5M/7l8wLKBR
	McKQ==
X-Gm-Message-State: APjAAAWgdKg1DIpp2w0u+WqpBwnb27MzaVJOX4j3ruj/n6ULGBCo06pG
	3oDBVf4bBtiV5hx56nqwlrygGO8qpkVVIg==
X-Google-Smtp-Source: APXvYqzdTZwqDoOB8lJkRcINiDHs+TwmDcrRDvnPN8xG+bEh4suVKn8aA20PLMVlnPu6td1EfrdtvQ==
X-Received: by 2002:a9d:17c6:: with SMTP id j64mr2432295otj.275.1559220607131; 
	Thu, 30 May 2019 05:50:07 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id l65sm953548oif.20.2019.05.30.05.50.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 05:50:05 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
	<20190522222821.23850-9-richard.henderson@linaro.org>
	<CAFEAcA9MTBqd5GO58hywGhYYGdbbvqiASwCvuKRBE+CVqVZTig@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ecf35f19-ac1e-4964-8c9a-5cab000c6627@linaro.org>
Date: Thu, 30 May 2019 07:50:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9MTBqd5GO58hywGhYYGdbbvqiASwCvuKRBE+CVqVZTig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 6:26 AM, Peter Maydell wrote:
>> -#define TCG_TARGET_HAS_cmpsel_vec       0
>> +#define TCG_TARGET_HAS_cmpsel_vec       -1
> 
> This is the only place where we define a TCG_TARGET_HAS_* macro
> to something other than 0 or 1, which means that Coverity
> complains (CID 1401702) when we use it in a logical boolean expression
>   return have_vec && TCG_TARGET_HAS_cmpsel_vec;
> later on.
> 
> Should it really be -1, or is this a typo for 1 ?

It really should be -1.
See commit 25c012b4009256505be3430480954a0233de343e,
which contains the rationale.


r~

