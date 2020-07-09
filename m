Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D6DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BBA2053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J01POJav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BBA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtOx2-0005pP-6r
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtOwB-0004sK-8I; Thu, 09 Jul 2020 01:17:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtOw9-0000oN-Hp; Thu, 09 Jul 2020 01:17:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so905089wrm.4;
 Wed, 08 Jul 2020 22:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iD9uRyt3nAO8bZ8dmvoKHU/pnl4/8quiJRT4mg89xvc=;
 b=J01POJavNkAMdcuu0l8iS/wGpOhMAa+74SLqbgMWuh62aH8qez8DTDEsNfjUK87Xik
 tIkXTQBFKqwv57UDXNSiebz2MWM+6XNmc4HWOQucODK7FQlqPCEDOw5RYhRq12+acAT4
 dRUNoILFOUONxjPwSnRgSYSqYm4u9BODFxLKPkG01sKM3ROMcZ83DHDJIjXB0Oje05M4
 sgC151Wvq/QWz/q8Xg6n/MPt+Pz4JfBr0wZHDM8lzBks7vlNE9uiv67D36tDmam3YmTS
 hsO0DUjtS8ZIwQLU4wntRs/ILt1gbKJi0UN0mtHRkCDXAq4M4IeVAfeZau8ifaJO/23w
 rdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iD9uRyt3nAO8bZ8dmvoKHU/pnl4/8quiJRT4mg89xvc=;
 b=YxLzZAtHrTsl2fgJQIH81EuMdOuS7/hCYIJicoYqU9vEk382ltSZjBBn8xydAwD9OJ
 x5tEjEoOoPgwVIZSyFXDXBMNFkQCtC67CrQ5tGvyTWnIAY2rMmT1oi8eYagOAbzWc6Tj
 6Ssr3Jp1nhiiWRfvnY5u6huGbgodeCmZ/ZIRMZCjCr/x3XpkmV6lRHCMHOeVx4bemnEd
 VO7CO9rTaQZ7bVpmGmSLMZ4XFl8yHZpoa7ORsrJ5bqDvbGst6xstYOhO0PM3VmsdUrog
 xHfArnfa3POUXWrM2XaLV1l64boL+fBJgOloHL8vgIVhAxKwZ62df9z//t0sDbr2o8zz
 v7gQ==
X-Gm-Message-State: AOAM533aIvv0A3iExaIdhdOtomzfWY4II0ZznDjYf3g7M4Os9tjaY6hy
 m0nwswxzifINGk857uqqQCo=
X-Google-Smtp-Source: ABdhPJwPv8NQ9Xd94gffK/n44/KofU4x9SSRI8WqSLH1dy2kOhPOdmWKAKf3g6PjgLIReyvjonGLwg==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr60596107wrp.100.1594271851355; 
 Wed, 08 Jul 2020 22:17:31 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u16sm2943756wmn.11.2020.07.08.22.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 22:17:30 -0700 (PDT)
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
 <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
 <2d1e272b-6575-30df-22ff-5d720973951d@amsat.org>
 <CAFQmdRZ-fZGD-Zzr6YvRyB7oEaqdek-e6UeCjekW-DnZLOfbrQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d3254729-e1b2-64aa-3df5-7edfe27e29a7@amsat.org>
Date: Thu, 9 Jul 2020 07:17:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRZ-fZGD-Zzr6YvRyB7oEaqdek-e6UeCjekW-DnZLOfbrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 2:23 AM, Havard Skinnemoen wrote:
> On Wed, Jul 8, 2020 at 10:56 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 7/8/20 7:31 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Havard,
>>>
>>> On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
>>>> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
>>>> Management Controllers in servers. While the family includes four SoCs,
>>>> this patch implements limited support for two of them: NPCM730 (targeted
>>>> for Data Center applications) and NPCM750 (targeted for Enterprise
>>>> applications).
>>>>
>>>> This patch includes little more than the bare minimum needed to boot a
>>>> Linux kernel built with NPCM7xx support in direct-kernel mode:
>>>>
>>>>   - Two Cortex-A9 CPU cores with built-in periperhals.
>>>>   - Global Configuration Registers.
>>>>   - Clock Management.
>>>>   - 3 Timer Modules with 5 timers each.
>>>>   - 4 serial ports.
>>>>
>>>> The chips themselves have a lot more features, some of which will be
>>>> added to the model at a later stage.
>> [...]
>>
>>>> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    NPCM7xxState *s = NPCM7XX(dev);
>>>> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
>>>> +    Error *err = NULL;
>>>> +    int i;
>>>> +
>>>> +    /* I/O space -- unimplemented unless overridden below. */
>>>> +    create_unimplemented_device("npcm7xx.io", NPCM7XX_MMIO_BA, NPCM7XX_MMIO_SZ);
>>>
>>> I still insist this is not the best, but as "The data sheet for these
>>> SoCs is not generally available" there is not much I can suggest to
>>> improve.
>>
>> From your other comment I found:
>>
>> https://github.com/Nuvoton-Israel/bootblock/blob/master/SWC_HAL/Chips/npcm750/npcm750.h
>>
>> In particular:
>>
>> #define AHB1_BASE_ADDR                  0xF0000000      /* AHB1
>> allocation (Including APB allocations)  */
>> #define AHB18_BASE_ADDR                 0x80000000      /* AHB18
>> allocation  */
>> #define AHB3_BASE_ADDR                  0xA0000000      /* AHB3
>> allocation  */
>> #define XBUSR_BASE_ADDR                 0xC0002000      /* XBUS
>> registers  */
>> #define AHB14_BASE_ADDR                 0xE0000000      /* AHB14
>> Allocation  */
>> #define APB14_BASE_ADDR                 0xE0000000      /* APB14
>> Allocation  */
>> #define VDMX_BASE_ADDR                  0xE0800000      /* VDMX  */
>>
>> XBUS doesn't seem important.
>>
>> If SPI flashes aren't connected, returning bus transaction sounds
>> correct:
>>
>> #define SPI0CS0_BASE_ADDR               0x80000000      /* SPI0 direct
>> access CS0  */
>> #define SPI0CS1_BASE_ADDR               0x88000000      /* SPI0 direct
>> access CS1  */
>> #define SPI0CS2_BASE_ADDR               0x90000000      /* SPI0 direct
>> access CS2  */
>> #define SPI0CS3_BASE_ADDR               0x98000000      /* SPI0 direct
>> access CS3  */
>>
>> #define SPI3CS0_BASE_ADDR               0xA0000000      /* SPI3 direct
>> access CS0  */
>> #define SPI3CS1_BASE_ADDR               0xA8000000      /* SPI3 direct
>> access CS1  */
>> #define SPI3CS2_BASE_ADDR               0xB0000000      /* SPI3 direct
>> access CS2  */
>> #define SPI3CS3_BASE_ADDR               0xB8000000      /* SPI3 direct
>> access CS3  */
>>
>> So I'd prefer you use:
>>
>>   create_unimplemented_device("npcm7xx.AHB1",  0xf0000000, 256 * MiB);
>>
>> Maybe for the PCI root complex:
>>
>>   create_unimplemented_device("npcm7xx.AHB14", 0xe0000000, 256 * MiB);
>>
>> What do you think?
> 
> I went ahead and added them all since they are all defined in that
> public file. It does make the -d unimp output a lot more helpful.

Great news!

> I'll send v5 tonight. Not sure if I got the DRAM stuff 100% right.
> Please let me know what you think.

I am seeing this now and v5 is already posted, so I'll review it
directly instead.

> 
> Havard
> 

