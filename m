Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39149C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE89B218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PT15IhLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE89B218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPvv-0007SD-NQ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57858)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hjPqO-00026M-AK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hjPqI-0002sJ-I4
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:09:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hjPqF-0002A3-5K
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:09:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id h19so7743207wme.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=q1aEPuqPPejoFOCRSaaYleUZYO2DAIq52Qc9x7onAlw=;
 b=PT15IhLg7KfIslfOI2RfmmzLc/GIGvsk05Q+0MoLPgmc3/KVr5vu10CPLdvgZqJKj3
 F5jY6AAe3k5rt5UvZSRbHBAf942MMZNXIuh6dT+IfES8K6HhXKuLTDmvZoXpTh7mtn2m
 QiszJ7kvD9aUJFEEzqkfEILTz6o/2c1QzjsOVnP6YR/fzJ5Jy/w5DiXtsV3MU8BhHTqM
 5FZ6tFeDWgiIZCgeNDhiacLK5+E34fR0ximqezzRY7tSCSZohZvi6r43omrkd2HWl68+
 fG2Jok+A2EjBgwJO4EdhKTf6XrLyyslMePYvGyA9HpQ/ZATqzs5gDDg/EH1QYrEspC1A
 5zHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q1aEPuqPPejoFOCRSaaYleUZYO2DAIq52Qc9x7onAlw=;
 b=ioOMYmnE1m0a/tBZAfuhNfgtr1Bq5QCaf8r17Q0FsF96N/SAHSsnxNuyetvwrFiuYn
 aoJ8eB/SDG7Il1w/QePUfhXUi4P75FTUyBWIStsT5gFHDR4GkPtj6BLvWdJ3gRO69DrS
 uLt03PdBKjHbMqhHqy/ryTTRSpYMTjzjFlzVPTxKCt8MRDYAbjDwbMGCBzoO4KynFPkm
 ArdNpw/BkvZ/xBiq+GyLRviNTq4piCyLBdDwHK7nlwbZpwMi/o5jHe6thlIJJQjNTjGI
 STYa/s7FFQUmBfzCysrSliN+/FFGLl/3BbbaQzEiPK6SYm2dJBHqCcjHi4O+A87In1pE
 u4Uw==
X-Gm-Message-State: APjAAAX3DHQBYrA9LJoYuh62o+HTM+4arhs0TsAh7bQiLkJ9WU+LZw1G
 5YXG+l8ND9KAvPMloUcq2weiTzAFRasbQg==
X-Google-Smtp-Source: APXvYqyfcgEo8qNPzdgoW5dW17I45lvAhBzs+f9ZeziSI56Qqib4qhglypEIfJsmXakJ57RRx8gaVA==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3938218wmi.142.1562339372193; 
 Fri, 05 Jul 2019 08:09:32 -0700 (PDT)
Received: from [10.21.14.234]
 (host218-183-static.63-88-b.business.telecomitalia.it. [88.63.183.218])
 by smtp.gmail.com with ESMTPSA id z6sm6922508wrw.2.2019.07.05.08.09.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 08:09:31 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-2-alex.bennee@linaro.org>
 <927219a5-a56d-bbbe-26ed-ffb8be12f006@linaro.org>
 <87ef36w14t.fsf@zen.linaroharston>
 <e7dcd75f-8897-1939-caf6-c879371a2f84@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <42b9274b-e389-4e2f-2ab5-e5601180f3b1@linaro.org>
Date: Fri, 5 Jul 2019 17:09:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <e7dcd75f-8897-1939-caf6-c879371a2f84@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 1/4] target/arm: handle M-profile
 semihosting at translate time
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/19 12:25 PM, Philippe Mathieu-Daudé wrote:
> 
> 
> On 7/4/19 12:21 PM, Alex Bennée wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 7/3/19 5:52 PM, Alex Bennée wrote:
>>>> +static inline void gen_thumb_bkpt(DisasContext *s, int imm8)
>>>> +{
>>>> +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
>>>> +        semihosting_enabled() &&
>>>> +#ifndef CONFIG_USER_ONLY
>>>> +        s->current_el != 0 &&
>>>> +#endif
>>>> +        (imm8 == 0xab)) {
>>>
>>> Extra parenthesis.
>>
>> The wrapping on imm8 == 0xab? Do you want that cleaned up on the other
>> patches as well?
> 
> I understood this comment for "(s->current_el != 0) &&"
> 

No, I meant imm8 == 0xab.  And, sure, cleaning the other patches would be good.


r~

