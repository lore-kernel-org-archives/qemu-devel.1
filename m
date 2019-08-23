Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3440C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC0120870
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DN+EMb4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC0120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1B6R-0006pb-Dm
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1B01-0000ZM-4K
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Azz-0001Z9-2Y
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:57:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1Azx-0001YO-A9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:57:06 -0400
Received: by mail-pf1-x443.google.com with SMTP id s11so689291pfe.6
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xPoUhroqLSrDe34vXvIBopbUjEmLdF9oYc+YKNHlzIA=;
 b=DN+EMb4XwYAXoewykcOumDmuIswq0yvLaul2ui6EYCTRI/RwncRLyIgAXUfbqdkZY4
 WaTKRDZM3VYOjzj10NQFRWHKGaN20mW4Aj4MNbExrBq1MyVfwbCxhTv46IX6VllfAdpZ
 LytuA9OC8bn15/OsQcEkMv/jT2rayN4+UpKodCiFr4UVIgjivrl8+NSKQxeuS5s0bKCu
 YSuFtQnWOhVM/oo62B33SdtvfSMOBRKd24kqBQ0pyiukJJo2hEFFKwFbt/UBx4AAAUHa
 ducCFcB+2sDs1ymcnGLxF5H9ymcfcu5lSxgtSHnzYlkVkjerwUvn7r9MTW9c8xsmctaz
 t/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xPoUhroqLSrDe34vXvIBopbUjEmLdF9oYc+YKNHlzIA=;
 b=JELuX6zPvAEXKwEEDj0lVjZL7ek2k2YSM/zE97xzxDqGbBCVwyH1c6b2XKjs7vus5D
 R88bJ/rMbYQXi2G17e/yl9uuOOkm9MghAQwC6BLKrL71YTEukjQLBB975w5ujFrHa3v0
 9H5AVpCP9TJpWFMlbQP0GveEM4XAmXVW5+9QNmMuzr77uWUvuVcXbOyRqtHcB4WOs7DE
 xsnK2Efpm5JyHFbLTI6nx4hdHIQkmCSoyPLeyQpQzeDYmy8HTy2BtLB0BBKYcWbw1NlA
 WKe6FYBbiPssmCGUqUry+uSmEcqj4xjfr5iqF6aWydi/iIOTaEsQEKRxVMUXVogkdIeo
 vTUg==
X-Gm-Message-State: APjAAAVw0UFnTZBYL0JbLzhRPQ3M5UXXW1DRsQ7kO2UfUrVTsD2SFDRe
 AyKZWOQmigo4o2usPmF55PptrQ==
X-Google-Smtp-Source: APXvYqw0xx4KEz2YZEJnRL9VLSbkwZeYr3aQgm9C+VY1SAqyP+DJZAiR7cllMp553FrgmeVB8bz0Og==
X-Received: by 2002:a17:90a:256f:: with SMTP id
 j102mr5943859pje.14.1566572223962; 
 Fri, 23 Aug 2019 07:57:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u18sm4159714pfl.29.2019.08.23.07.57.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 07:57:03 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-20-richard.henderson@linaro.org>
 <CAFEAcA8Q3ujQFtZfLXTsbKBxUQAHCPo0i_TpdX9KcmnNUY04Eg@mail.gmail.com>
 <c8809173-6b8a-afab-507f-69983ac29224@linaro.org>
 <CAFEAcA9Rq3VR3F+zUV3BiZ7zQm-gE=Ut4hv7Hi0cK3me4Vch3Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0548bd91-14d9-8e2b-3b9e-d5adad7a7dfb@linaro.org>
Date: Fri, 23 Aug 2019 07:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Rq3VR3F+zUV3BiZ7zQm-gE=Ut4hv7Hi0cK3me4Vch3Q@mail.gmail.com>
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

On 8/23/19 7:47 AM, Peter Maydell wrote:
> On Fri, 23 Aug 2019 at 15:45, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 8/23/19 6:04 AM, Peter Maydell wrote:
>>>> +&ri              rd imm
>>>>  &r               rm
>>>>  &i               imm
>>>>  &msr_reg         rn r mask
>>>
>>> Should this change be in some other patch ?
>>
>> No, it's used by ADR.
>>
>>>> +  ADR            1111 0.1 0000 0 1111 0 ... rd:4 ........ \
>>>> +                 &ri imm=%imm12_26_12_0
>>
>> ... here.
> 
> This is in t32.decode, which has its own definition of &ri.
> The one I was asking about was the one in a32.decode -- the
> addition of that line is the only change to a32.decode in this patch.

a32.decode is where all of the shared argument sets are declared; t32.decode
gets the !extern markup.  If I only put it in t32.decode now, I'd only have to
move it later.  It will eventually be used in a32.decode by MOVW/MOVT.


r~

