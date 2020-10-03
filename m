Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047FC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 18:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489C3206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 18:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcM5zsn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489C3206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOm3t-0005tz-CO
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 14:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOm34-0005LU-Fc; Sat, 03 Oct 2020 14:14:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOm32-00079t-Jq; Sat, 03 Oct 2020 14:14:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id w2so4703494wmi.1;
 Sat, 03 Oct 2020 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kxQCIZkLUp4cXcK24Uf9Izm4LCAQBro6GywH9pmjLrQ=;
 b=mcM5zsn/B9EblArEbpE5eXMBSgpflN6zdB7bJskMAtfQXICHdH7kqw2/p38uX1QJOS
 eMeSR1PZ+eUBPi490Y80bT2cjBvPQy8uk7nig92wOZBWImtHth5kVdpB6/vUXxKuKKKw
 34O2VY0QK0fFtCmY84UQgZiVwp5dtjnDtI1+F9UR8lIMeMJrrsmNjKlYx92098FzCMYr
 VKPppf7bM4mHRl+K/gfF3LMHqD+KA0IXCCa7PtRT6LGXkEpB1WQDiVLVcccgFXqONoCG
 dDqXzIfAd6nEVhVBdBrzcZgvx7MvfbjZPt03Ma31X7XwNBu1d4Xunf8e0WbmEIUdQGLC
 gvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kxQCIZkLUp4cXcK24Uf9Izm4LCAQBro6GywH9pmjLrQ=;
 b=bNL2IE+dLwHGySHBJX39EOzynTDOUgsbJYHpN4nCvB/yGEt2Ly4K7Z/nDip9B5FL4j
 9hqQr88kjgJ5hH1xYSysmdX/DY4We1SUhnAL52Vr4m4Q60KYWztybVcgMUOVaaKK7y7m
 uJmDhxX3VMos30pdr6pv3CsZGTZzUBQ+cFBlGQcXuMPutlTIG0UhRRGGkmSAGt5LJdNf
 qUCUWvWnXxRcHmxfMqYbo5Lfe8njdrYnlWkYX6Q0tK6xkTFDZq68HSjbejbNzMKYLc4B
 VoSY+TkRDfo1AZcDarB57QQfbmO+K1UwTuYQ5TO+2QjeAT32LHqIlGS8db7B24Yaymep
 NILQ==
X-Gm-Message-State: AOAM533WV+ou80/D69QSPDGWV8Mc0t6cgcoPPqA2XWiUvSQQqHWpQZMg
 L7XJ6QTkdkGKYTrdFyRpFls=
X-Google-Smtp-Source: ABdhPJywd95Iz8HNvH0yv+DltUyscKaUIsdI6HEmpi5W692tJl6Ob4Nc2qe9ErK2OeY6DGYW5LMprQ==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr8584850wme.75.1601748857867; 
 Sat, 03 Oct 2020 11:14:17 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id f14sm6605477wrv.72.2020.10.03.11.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 11:14:16 -0700 (PDT)
Subject: Re: [PATCH 04/14] hw/arm/raspi: add a skeleton implementation of the
 cprman
To: Luc Michel <luc@lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-5-luc@lmichel.fr>
 <85ccb491-8d4a-caf3-595d-7415471f5dc7@amsat.org>
 <20200928084515.r7s3cl6jlzm465iw@sekoia-pc.home.lmichel.fr>
 <4aa9f0c3-dc4b-1e87-d601-87b0498de8b1@amsat.org>
 <20201003115444.m2woqcpit34vfv3u@sekoia-pc.home.lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dfb488db-afa4-d307-cac1-ce71e5ebf29a@amsat.org>
Date: Sat, 3 Oct 2020 20:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003115444.m2woqcpit34vfv3u@sekoia-pc.home.lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 1:54 PM, Luc Michel wrote:
> On 16:37 Fri 02 Oct     , Philippe Mathieu-Daudé wrote:
> 
> [snip]
> 
>>>>> +struct BCM2835CprmanState {
>>>>> +    /*< private >*/
>>>>> +    SysBusDevice parent_obj;
>>>>> +
>>>>> +    /*< public >*/
>>>>> +    MemoryRegion iomem;
>>>>> +
>>>>> +    uint32_t regs[CPRMAN_NUM_REGS];
>>>>> +    uint32_t xosc_freq;
>>>>> +
>>>>> +    Clock *xosc;
>>
>> Isn't it xosc external to the CPRMAN?
>>
> Yes on real hardware I'm pretty sure it's the oscillator we can see on
> the board itself, near the SoC (on the bottom side). This is how I first
> planned to implement it. I then realized that would add complexity to
> the BCM2835Peripherals model for no good reasons IMHO (mainly because of
> migration). So at the end I put it inside the CPRMAN for simplicity, and
> added a property to set its frequency.

OK as long as all boards have a 19.2MHz crystal, but if the property
is not easily accessible why not use a #define in
"hw/arm/raspi_platform.h" instead?

Else we should alias the property using object_property_add_alias()
in TYPE_BCM2835_PERIPHERALS.

> 
>>>>> +};
> 
> [snip]
> 
>>>>> +static const MemoryRegionOps cprman_ops = {
>>>>> +    .read = cprman_read,
>>>>> +    .write = cprman_write,
>>>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>>>> +    .valid      = {
>>>>> +        .min_access_size        = 4,
>>>>> +        .max_access_size        = 4,
>>>>
>>>> I couldn't find this in the public datasheets (any pointer?).
>>>>
>>>> Since your implementation is 32bit, can you explicit .impl
>>>> min/max = 4?
>>>
>>> I could not find this information either, but I assumed this is the
>>> case, mainly because of the 'PASSWORD' field in all registers.
>>
>> Good point. Do you mind adding a comment about it here please?
>>
> 
> OK
> 
>>>
>>> Regarding .impl, I thought that having .valid was enough?
>>
>> Until we eventually figure out we can do 64-bit accesses,
>> so someone change .valid.max to 8 and your model is broken :/
> 
> OK, I'll add the .impl constraints.
> 
> [snip]
> 

