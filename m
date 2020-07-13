Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2EDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA58F2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmi18Wwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA58F2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2Re-0006MX-Qe
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv2Pt-0004eR-S7; Mon, 13 Jul 2020 13:39:01 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv2Pr-0005YZ-Sf; Mon, 13 Jul 2020 13:39:01 -0400
Received: by mail-ed1-x544.google.com with SMTP id dm19so14395804edb.13;
 Mon, 13 Jul 2020 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z36ZAYvnwq9ksAZhdXa7DPRkY3nJXnTgeSqi9jZpawQ=;
 b=Gmi18Wwx0scK30mGetHfACqOY4tP5I15ETro+0zwtGvLBmW03w3k3HOgACZn2eozCi
 ZsCWH9mDLvbeBeuhlGpKVRVixWiGn26fV8apRY2FTa2WyX06+MDO9IQbkhw2rTKC5GTH
 cYm5/35pU47gNcJ7qjnsbon0/VkIHTwsKPh/HbLFgapFoLFTVhfCcxFGiofRZ6GLGxN4
 OWV0pLI+VXS5+HZ7o1OPVTcFTLwpXuNYXUh52Xy3BOWg0/f1ozbz5TaDjP1dcSOMSkWn
 VzAQcsvYG4oLqtkju3RfPLuOjOLGUhtH46kz0lDKK2t6gU4BqP1eQEQn5BaOhM4b8reU
 gXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z36ZAYvnwq9ksAZhdXa7DPRkY3nJXnTgeSqi9jZpawQ=;
 b=bGMxey3WW5+Er8xlOgKDdbRTfEOco6MGE1c+UVLADVXchb2qwa3T8DyIIV2ac1JjXf
 AIdhiC8pAHuSu1YeAOaTM+r6F+FeE1M4rL6gyoRmtvG1J3jcu57hCdiu8zFz/D/GhDUS
 DPH0NqK8bneSq64W68rsGaumP1sahsS6lILhXl/QlDc99aqK2YUSXUmoZ3XlXUB1jWe1
 QAOqZGVyu8IyUGh3rAeITP6jiBAUz1mgVtJi6hReVO3RsWKf1TTPQ7d3djw9Vme8NizQ
 7Ib55G8BV7XcF/AeFSTMPKSN+ZMgU0F8v+myv11EOWjU4rhSu7fSuW4oUliklXMSQyxS
 lfIA==
X-Gm-Message-State: AOAM533PeBfngT1+DL7qgnjLXlB3nvvN3QvRWbBV5DNkoXlSb42b+92N
 5MQY7QeDccp+SVU1CV0TCzaQWk/oUjA=
X-Google-Smtp-Source: ABdhPJyq0rzPqcSoTo3FxCLbwy/8G84ofxrcK+b1qjTxIGGeNJeivZUbqdi3MiFXfTi9zfxevaM2Fg==
X-Received: by 2002:a05:6402:1d35:: with SMTP id
 dh21mr536815edb.186.1594661938106; 
 Mon, 13 Jul 2020 10:38:58 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id i10sm11917540edx.42.2020.07.13.10.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 10:38:57 -0700 (PDT)
Subject: Re: [PATCH v5 09/11] hw/ssi: NPCM7xx Flash Interface Unit device model
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-10-hskinnemoen@google.com>
 <189922e4-b53f-da64-5663-23b599294248@amsat.org>
 <CAFQmdRbY8DHYOOHPREHg63hgLVTVvyMbuMrdauctaBTzaB1=AA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <739105bb-5915-bf11-10cc-485ce5e94e73@amsat.org>
Date: Mon, 13 Jul 2020 19:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRbY8DHYOOHPREHg63hgLVTVvyMbuMrdauctaBTzaB1=AA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 7:42 AM, Havard Skinnemoen wrote:
> On Thu, Jul 9, 2020 at 10:00 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>> This implements a device model for the NPCM7xx SPI flash controller.
>>>
>>> Direct reads and writes, and user-mode transactions have been tested in
>>> various modes. Protection features are not implemented yet.
>>>
>>> All the FIU instances are available in the SoC's address space,
>>> regardless of whether or not they're connected to actual flash chips.
>>>
>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>> ---
>>>  include/hw/arm/npcm7xx.h     |   2 +
>>>  include/hw/ssi/npcm7xx_fiu.h | 100 +++++++
>>>  hw/arm/npcm7xx.c             |  53 ++++
>>>  hw/ssi/npcm7xx_fiu.c         | 510 +++++++++++++++++++++++++++++++++++
>>>  hw/arm/Kconfig               |   1 +
>>>  hw/ssi/Makefile.objs         |   1 +
>>>  hw/ssi/trace-events          |   9 +
>>>  7 files changed, 676 insertions(+)
>>>  create mode 100644 include/hw/ssi/npcm7xx_fiu.h
>>>  create mode 100644 hw/ssi/npcm7xx_fiu.c
[...]

>>> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
>>> index 4d227bb74b..c9ff3dab25 100644
>>> --- a/hw/arm/npcm7xx.c
>>> +++ b/hw/arm/npcm7xx.c
>>> @@ -98,6 +98,37 @@ static const hwaddr npcm7xx_uart_addr[] = {
>>>      0xf0004000,
>>>  };
>>>
>>> +static const hwaddr npcm7xx_fiu0_flash_addr[] = {
>>
>> So per
>> https://github.com/Nuvoton-Israel/bootblock/blob/master/SWC_HAL/Chips/npcm750/npcm750.h
>> this is SPI0 on AHB18,
>>
>>> +    0x80000000,
>>> +    0x88000000,
>>
>> CS0 & CS1,
>>
>> also listed:
>>
>> 0x90000000, // CS2
>> 0x98000000, // CS3
> 
> Confirmed with Nuvoton off-list that these do not exist. SPI0 only
> supports two chip-selects for direct access.

I suppose Novoton confirmed for the particular npcm750, but you aim
to model the npcm7xx family. I doubt 2 similar IP blocks are that
different ;) Anyway with a comment this is good.

> 
> I'll add comments.
> 
>>> +};
>>> +
>>> +static const hwaddr npcm7xx_fiu3_flash_addr[] = {
>>
>> Ditto SPI3 on AHB3, and CS0 to CS3.
>>
>>> +    0xa0000000,
>>> +    0xa8000000,
>>> +    0xb0000000,
>>> +    0xb8000000,
>>> +};
>>> +
>>> +static const struct {
>>> +    const char *name;
>>> +    hwaddr regs_addr;
>>> +    int cs_count;
>>> +    const hwaddr *flash_addr;
>>> +} npcm7xx_fiu[] = {
>>> +    {
>>> +        .name = "fiu0",
>>> +        .regs_addr = 0xfb000000,
>>> +        .cs_count = ARRAY_SIZE(npcm7xx_fiu0_flash_addr),
>>
>> Hmm without the datasheet, can't tell, but I'd expect 4 CS
>> regardless.
> 
> FIU0/SPI0 only has 2 chip selects.
> 
>>> +        .flash_addr = npcm7xx_fiu0_flash_addr,
>>> +    }, {
>>> +        .name = "fiu3",
>>> +        .regs_addr = 0xc0000000,
>>> +        .cs_count = ARRAY_SIZE(npcm7xx_fiu3_flash_addr),
>>> +        .flash_addr = npcm7xx_fiu3_flash_addr,
>>> +    },
>>> +};
[...]

>>> +
>>> +    /* Flash chip model expects one transfer per dummy bit, not byte */
>>> +    dummy_cycles =
>>> +        (FIU_DRD_CFG_DBW(drd_cfg) * 8) >> FIU_DRD_CFG_ACCTYPE(drd_cfg);
>>> +    for (i = 0; i < dummy_cycles; i++) {
>>> +        ssi_transfer(fiu->spi, 0);
>>
>> Note to self, might worth a ssi_shift_dummy(count) generic method.
> 
> I'm not a huge fan of this interface to be honest. It requires the
> flash controller to have intimate knowledge of the flash chip, and if
> it doesn't predict the dummy phase correctly, or the guest programs
> the wrong number of dummy cycles, the end result is very different
> from what you'll see on a real system. I'd love to see something like
> a number-of-bits parameter to ssi_transfer instead.

Do you mean like these?

- ssi_transfer_bit(bool value);
- ssi_shift_dummy_bits(size_t bits);

Some interfaces allow bit shifting. SPI doesn't simply because
nobody had the use :)

> 
>>> +    }
>>> +
>>> +    for (i = 0; i < size; i++) {
>>> +        value |= ssi_transfer(fiu->spi, 0) << (8 * i);
>>> +    }
>>> +
[...]

>>> +static const MemoryRegionOps npcm7xx_fiu_flash_ops = {
>>> +    .read = npcm7xx_fiu_flash_read,
>>> +    .write = npcm7xx_fiu_flash_write,
>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>> +    .valid = {
>>> +        .min_access_size = 1,
>>> +        .max_access_size = 8,
>>
>> Are you sure? Maybe, I can' tell.
> 
> Real hardware supports 16 bytes, but there's no way to do more than 8
> in emulation, I think?

That would mean you can plug this device on a 128-bit wide bus,
and you can transfer 128-bit in a single CPU operation.

>>> +        .unaligned = true,
>>> +    },
>>> +};
>>> +

