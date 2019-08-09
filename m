Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A0C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47A320820
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lp5zxZLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47A320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7HX-0000JP-0I
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hw7H7-0008Cs-Md
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hw7H6-0001Qm-N9
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:57:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hw7H6-0001OS-HO
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:57:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id u17so46068632pgi.6
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KvAh0kj7MJYjB42/ASlKSiUOycmdDr5QG3FtOZH9hMQ=;
 b=Lp5zxZLi/lClKwWSiaorzYrdEOyt4ksDRCzqeNRYaTv3NC2L8aSsd8a1r+dIRKGdbO
 kdB6yj9DkMU09auxqM6P9opMzpDYvvDeD5U/WDQHDnOiiQVQgYqcBUAfDdEx0frYGBNw
 0JzIZfDTrkMrx0OYXvCYwJMC56i08s2JAc8Qm5XvLO1efZNx6hUMBbE0NK5bvDicSxUz
 FWF62NNyPKmxH4Ie4DbAnBUgqHaej2nYBAfQ7g9SdyaEL/fwBZTMqFfCVEz/NdashtBW
 zNpioDtrgr4c87R5WbarjVrww0Y3jsFg91Smqm+THT7olDQnaJSRQU7qjQYFNTL08k1D
 5nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KvAh0kj7MJYjB42/ASlKSiUOycmdDr5QG3FtOZH9hMQ=;
 b=kkogoIc4klkUFcKSShqqp1tinhLi5koe3YT7dTEYi9vLQGX734mmpu5dojQ6zcBv95
 c+40Twa96CNxzJhN7pXvpdy6yBsTK13KOo6zgbXTVKjoBcA4Z2lhopKwi5pRDUrtzmmp
 uqK5OyVZF3qwoGUbgb440VGdIKVrjWwGoMaYayVssQQ9GHp8WRV5tjPCh+CYizaEzUo8
 k9zLagAdAnYCz6w8kuQj1O9L8a+cR8dMwYztbaDXYdLE85l+mbrG6pWyFM06mK2ax7D+
 I/KF2cVVUA3j9KtCu4XBGETXhDHJ7KNmCX5EqaSnfsRDuIMdgerJz4vPk1JxivDbhGez
 osNQ==
X-Gm-Message-State: APjAAAXihNTgb0JDKZ77rrf0PvFV8z+IE4DzMylzrdu8hV/b6uIbi8r5
 yVOUB0I/bv2G0m78C04PUD1WdA==
X-Google-Smtp-Source: APXvYqx8i7jcSgJ8jpuZ05hnbOcCw6Lq2Qs1ZyCwoZVfO3greXreaQuEFC3kTLTRirhgCr5DItuYOA==
X-Received: by 2002:a17:90a:c58e:: with SMTP id
 l14mr10075608pjt.104.1565366270313; 
 Fri, 09 Aug 2019 08:57:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i17sm2930603pfo.28.2019.08.09.08.57.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 08:57:49 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190809154153.31763-1-richard.henderson@linaro.org>
 <20190809154153.31763-2-richard.henderson@linaro.org>
 <CAFEAcA_4jCdh94MUbmA9wAxQ7UajC_8TxEeD0tLpZRfn7jMiiw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <935866af-9a2f-1d35-c583-6f26ee00087a@linaro.org>
Date: Fri, 9 Aug 2019 08:57:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4jCdh94MUbmA9wAxQ7UajC_8TxEeD0tLpZRfn7jMiiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 1/3] decodetree: Allow !function with no
 input bits
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 8:52 AM, Peter Maydell wrote:
>> @@ -195,7 +195,10 @@ class MultiField:
>>      """Class representing a compound instruction field"""
>>      def __init__(self, subs, mask):
>>          self.subs = subs
>> -        self.sign = subs[0].sign
>> +        if len(subs):
>> +            self.sign = subs[0].sign
>> +        else:
>> +            self.sign = 0
>>          self.mask = mask
>>
>>      def __str__(self):
> Is this change to MultiField left over from the previous
> implementation ? I was expecting a zero-length MultiField
> to now be a bug in this python script (ie we should never
> try to create one).
> 

Oops, yes.

The error is emitted here:

> +    if len(subs) == 0:
> +        if func:
> +            f = ParameterField(func)
> +        else:
> +            error(lineno, 'field with no value')

and tested:

> +++ b/tests/decode/err_field6.decode
> @@ -0,0 +1,5 @@
> +# This work is licensed under the terms of the GNU LGPL, version 2 or later.
> +# See the COPYING.LIB file in the top-level directory.
> +
> +# Diagnose no bits in field
> +%field


