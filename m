Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E873E206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5uwXt3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E873E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqN0d-0007vw-8n
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqMzl-0006o5-CH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 16:36:45 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqMzi-0001Js-US
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 16:36:45 -0400
Received: by mail-pl1-x641.google.com with SMTP id g17so8943788plq.12
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pQz+eE/LNVaghZDJQsgpqifIdMEhLjlBM5/n4qi5Hyw=;
 b=m5uwXt3Z1VbWbh22VUKH3NWpmw4WKh8E0g3pZrsU7UZ00xgt4j7HW+3KuQnRaiTJn3
 k+VLMgYH/mO/2PQCsGhTiSqNUj0Cgz86iw0Vkb4JH1gXXdx+oFzna1XloCWeKs4WV3HL
 mp52eAErJAM44R44UtATFcBc7IS4YGaBN3KT35FXQ5ViHLbDTptv5kM2TCksMprcGxgL
 SXu/vlypMfFu+6Me8UnwrR4BVEqH7sgXSJcV+UfuAYLgC3CJURnbsFcysicd8iLCXW48
 /E5YCg4YG5lA/UCs3WruszFdnKrTdzGybDRnoQNjgfMx4euLEZLtZ3KvSdtHg7kCYEDn
 YPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pQz+eE/LNVaghZDJQsgpqifIdMEhLjlBM5/n4qi5Hyw=;
 b=FUkPfsDbgSIi/dxsZCObu1tJw9YBa4uGIb1gESeqZGDt9ikjWv5UsTw07nStKZYIL8
 CVNXO6xakARhW4k9Mpsmnid9s8pP7h6dleeKOST3E+JDHgp8A7JGeQMjE7gPzJCMx427
 j50xKNiyAIlzNX7cF/7wHdALThWKXUGf4X+KyM1JFvwvpzPLYdOvKQOAdicqzzJldQry
 GU/5ldDgdi4y1hlmX/a9bXdEmWHYqBb3hQw0r2G6vG/ECzsu0n9wN41RcMmY4pJX8FTI
 IlbaKa8cmZPBWlWMZXFjEGoqNH68d3jJuHnRdjDYWBt40PUX+MKb0aT3gcQPKTo3FFjJ
 0nVA==
X-Gm-Message-State: AOAM533pke9xzCZ88h8k5kHlO8fRd5Ipp+YCCWa4dLal2cAG8jkjhSsh
 mrq/58ePTv9IdPE5135zF98++w==
X-Google-Smtp-Source: ABdhPJzjwcjPn1fBHbtcB3mVRWbwqVl89AsIme9mr4PkMdNWp9pR+UiLfiUQD/I0gATJdwllrsTcfA==
X-Received: by 2002:a17:90b:3187:: with SMTP id
 hc7mr7976511pjb.38.1593549400963; 
 Tue, 30 Jun 2020 13:36:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x24sm3555442pfo.12.2020.06.30.13.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 13:36:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200630145236.27529-1-f4bug@amsat.org>
 <CAHiYmc4=pmzEyhVTHaqxBnCotE8V+vaptMFincyurvAyDHNn6g@mail.gmail.com>
 <5725b99b-b524-ab40-c74d-a615bb28d363@amsat.org>
 <CAHiYmc7AoJd7TMX_Beo3A2f3R1M=yrpe2ZydbsSysREf4Cx3Vw@mail.gmail.com>
 <a503201a-ed9f-dff6-6e3d-4729ed31ad98@amsat.org>
 <CAHiYmc6tp9k9eSOKiSWaQjmaTyvJXi3k+RmLWqLmhTHY9_KDnQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45a0ca3e-06ba-c35d-c88a-e1d1fd944809@linaro.org>
Date: Tue, 30 Jun 2020 13:36:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6tp9k9eSOKiSWaQjmaTyvJXi3k+RmLWqLmhTHY9_KDnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 10:28 AM, Aleksandar Markovic wrote:
> уто, 30. јун 2020. у 19:16 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> On 6/30/20 6:55 PM, Aleksandar Markovic wrote:
>>> уто, 30. јун 2020. у 18:46 Philippe Mathieu-Daudé <f4bug@amsat.org> је
>>> написао/ла:
>>>>
>>>> On 6/30/20 5:38 PM, Aleksandar Markovic wrote:
>>>>> уто, 30. јун 2020. у 16:52 Philippe Mathieu-Daudé <f4bug@amsat.org> је
>>>>> написао/ла:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> This series add a new 'malta-strict' machine, that aims to properly
>>>>>> model the real hardware (which is not what the current 'malta'
>>>>>> machine models).
>>>>>>
>>>>>> As a bonus for Debian builders, a 'malta-unleashed' machine RFC
>>>>>> patch is included. This might start another endless discussion
>>>>>> upstream, but this is not the point of, so I still include it
>>>>>> for people to test. The rest of the series is candidate for merging
>>>>>> in mainstream QEMU.
>>>>>>
>>>>>> Philippe Mathieu-Daudé (6):
>>>>>>   hw/mips/malta: Trivial code movement
>>>>>>   hw/mips/malta: Register the machine as a TypeInfo
>>>>>>   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>>>>>>   hw/mips/malta: Introduce the 'malta-strict' machine
>>>>>>   hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
>>>>>>   hw/mips/malta: Introduce the 'malta-unleashed' 64-bit machine
>>>>>>
>>>>>>  hw/mips/malta.c | 125 ++++++++++++++++++++++++++++++++++++++++++------
>>>>>>  1 file changed, 111 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> --
>>>>>
>>>>> This whole series is based on idea of emulating physically
>>>>> non-existing feature, and as such violates the fundamental principles
>>>>> of QEMU.
>>>>>
>>>>> As such, not acceptable for upstreaming.
>>>>>
>>>>> I don't see the point of sending again the same series, in just
>>>>> cosmetically different form, if it was said to you that the concept is
>>>>> wrong.
>>>>
>>>> Have you looked at the patches? What "violates the fundamental
>>>> principles of QEMU" is the code currently in mainstream. Should
>>>> we remove it? I can send a patch for it if it pleases you, but
>>>> you will make QEMU unuseful for many distribution users.
>>>>
>>>
>>> Past mistakes are past mistakes. We have to live with them. And not
>>> make them in the future.
>>>
>>> I see the whole series as a precursor for your change that repeats
>>> past mistakes, a "wolf in sheep clothing".
>>>
>>> That's why I reject the series as a whole.
>>
>> As a co-maintainer I don't accept that.
>>
> 
> I offered you the full maintainership for Malta.
> 
> You said you can proveide only "Odd fiexes".
> 
> I had to jump in to provide "Maintained" status.
> 
> Therefore, I provide the higher level of maintainership, and you have
> to respect that. But you don't.

You need to cool your jets here, Aleksandar.

You do not have some mythical "higher level" of maintainership.  Nor, as far as
I can tell, are you actually doing anything with Malta whereas Philippe is.


r~

