Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61885C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAC220870
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCxALKB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAC220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1B5g-0006C4-48
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1AoR-0004hO-34
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1AoP-0002yf-N4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:45:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1AoP-0002vk-51
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:45:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id w26so6583374pfq.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t5KLg6wG4uIOGb4glckszS9qjHVN5Bcu52P7WbJKD9U=;
 b=NCxALKB6zggQJWeordpFAdQfKw0BCbG4IEfRs6HV0V5Kp24y+td12Z0Hbim7rovWKR
 9oTL4sF90oeHIxsSxgl7Et1nka82ygqq+uVBA+po5uQcuOTdgi8tPZHTpwKN3ybhtorT
 /TtEhHXjLGx8XZBl2uo38vmlkj42ADqCuMnAHKqVAEa/Rdfz+U0513n9xKBmbNAf7GZF
 JpU7/jOeQl3QPqtKOx6sp3bfi+y+YruuWUY+3vIPkjnTGXlyjTRWIZLc1FGwm3BXF/J9
 lTSYpoIrmnqPgr1o9TlNxqoOLdrXlTZarl54glC1itPAAxvA5GMQE4aIO3Ow7uBwxB5C
 V2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t5KLg6wG4uIOGb4glckszS9qjHVN5Bcu52P7WbJKD9U=;
 b=F13xgZB6Pwl100XaF/KSIB8o+Bmo/lEX7tcE2dlGtyZ1km2WOOJOItyYfX8f4XKMvx
 J+SZWm6hPaTPqD/3TsIiaqHVBk5s3p+cpw5mAGbExaAHhJ0nTy5et9AMKnIxzhdE4t7C
 +px6qu7ty5rAw9yYKpgPmLN4FIblWauck7/Y/st2iKTRhjZ8EWiFqvM/KxwhjPxqJKKF
 LYxtD/SUY+DUqlt6lT9XQG2RgZUmKtrdAoskN5bR02vcUU64otN8+SXRJs75tlFBDzF/
 aedgbPSgXJ45t6zlqsIzL5C6UUo5ufZPwn4v9O0lk89vwgTWG0NS6j3YeQIV9BQrzbow
 BZfA==
X-Gm-Message-State: APjAAAWnD9cZxAUPJYzYS6layCOzxuLsBPGdFUFbmLesLcDt4r6v5lDj
 vPvabxfOGjQqXZDSThNf7i3nGA==
X-Google-Smtp-Source: APXvYqyCjyafLZ6wfhhbq1kX8EWk7+EEgKxdfIlYaogm1em/7TcsJWBBebxBmTfEaClvha54SfIGAw==
X-Received: by 2002:a65:690e:: with SMTP id s14mr4362638pgq.47.1566571506593; 
 Fri, 23 Aug 2019 07:45:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m145sm2869750pfd.68.2019.08.23.07.45.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 07:45:05 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-20-richard.henderson@linaro.org>
 <CAFEAcA8Q3ujQFtZfLXTsbKBxUQAHCPo0i_TpdX9KcmnNUY04Eg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c8809173-6b8a-afab-507f-69983ac29224@linaro.org>
Date: Fri, 23 Aug 2019 07:45:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Q3ujQFtZfLXTsbKBxUQAHCPo0i_TpdX9KcmnNUY04Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 19/68] target/arm: Convert T32 ADDW/SUBW
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 6:04 AM, Peter Maydell wrote:
>> +static bool trans_ADR(DisasContext *s, arg_ri *a)
>> +{
>> +    store_reg_bx(s, a->rd, add_reg_for_lit(s, 15, a->imm));
>> +    return true;
>> +}
...
>> -                        if (rn == 13 && rd == 13) {
>> -                            /* ADD SP, SP, imm or SUB SP, SP, imm */
>> -                            store_sp_checked(s, tmp);
>> -                        } else {
>> -                            store_reg(s, rd, tmp);
>> -                        }
>> +                        /* Add/sub 12-bit immediate, in decodetree */
>> +                        goto illegal_op;
> 
> We seem to have lost the store_sp_checked() handling ?

Not from ADR, which of course is ADD RD, PC, IMM, and so wouldn't match.

>> +&ri              rd imm
>>  &r               rm
>>  &i               imm
>>  &msr_reg         rn r mask
> 
> Should this change be in some other patch ?

No, it's used by ADR.

>> +  ADR            1111 0.1 0000 0 1111 0 ... rd:4 ........ \
>> +                 &ri imm=%imm12_26_12_0

... here.

>> +  ADD_rri        1111 0.1 0000 0 .... 0 ... .... ........     @s0_rri_12

The rest of the store_sp_checked handling is here in the existing ADD path.
Recall STREG_SP_CHECK from patch 2.


r~

