Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714162070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+wN1je5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714162070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopVH-00051f-PC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jopTa-0002ZF-G1; Fri, 26 Jun 2020 10:37:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jopTY-0006iO-Hj; Fri, 26 Jun 2020 10:37:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id h15so9726777wrq.8;
 Fri, 26 Jun 2020 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/IjNLkgkO8PWVK01Ig+WYwXMu205MByyBnOTr6in1ns=;
 b=u+wN1je5eZE1vejPrdA/0QNIoQB23/j/dYMIQ0VhcJVdYuzF9soKdrBaRJvGVGT2q1
 n0oJ+T3DVnsLHZUGMDoutbUeX6F87R/2kk9khMTBqor4t26s9hMiNT9HWVndY+JsUGUO
 7X9d/AuYMet6c+2uBXsAYnOQ0Kae1/nP6CDk/WhzYdCrtfBL2PpMRLchNAUi2e+lrAfz
 jNdRXVJm/nCRfe+n1VNn0ykLGl0Oysz48rDYjmR1ytNaVGK4Yw+dHssp+VvyDSWZpQTG
 BHE96lKHQjAYNxU5I+JbVW5sSyTS6TnTstaPMJ6f3uZdK0yPQj+0HsDRL4NrP030mm6E
 09JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/IjNLkgkO8PWVK01Ig+WYwXMu205MByyBnOTr6in1ns=;
 b=D9QAxkTMxOlVhlaElbuEPC/Ln+/uLuZqq8Zbc40DmXe/u3fGCTk026Q1uQpvan4w15
 1GICkPyD5QY3f13udZhWg/+aoc7y7tpx8YG7aLcfBsVSy5O9AwA4a1sduLknuqZm2+2p
 +PlqaXFzS1B3nn6IbuhWY+2v07iA4YA9pImFhHDokNv8XNj7naIoblcv+CdsvK15qgo6
 roikeEyVBncP5B6xkhSJpczr+ZyicuoMPdzfU7fa/v7zz6TzC+KL+trC3v3Mi2EyGSZ3
 Y3TU4QWy2jRuMYPolYO31hvDuHJ9ta8/6QqKzTrbRidiU+4/aWM5jECNKvQZ/WMMevKs
 691g==
X-Gm-Message-State: AOAM533SUAzky6qCB7xoafc+0ZzkTOSAM1V5E8RxLnFekXVJiHNeRXCF
 HYt8H7yK7/pWX/RtWkL0QSc=
X-Google-Smtp-Source: ABdhPJy2Xp3mE06IreCHABcBWnAmhWP3fHt8do40ED0LjioFNCB/E1O/rwBUP98NSpEb3gqZVWUGEA==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr3974068wrn.93.1593182226137; 
 Fri, 26 Jun 2020 07:37:06 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c17sm15396530wmd.10.2020.06.26.07.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 07:37:05 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] hw/i2c/smbus_eeprom: Set QOM parent
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261240500.94870@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261251480.94870@zero.eik.bme.hu>
 <f7da6118-a27a-a09d-9c8f-92cbf2eca96f@amsat.org>
 <alpine.BSF.2.22.395.2006261557050.56498@zero.eik.bme.hu>
 <4825239e-1e75-a401-2068-a8c14c38f60b@amsat.org>
 <alpine.BSF.2.22.395.2006261622590.63331@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9a343e4-7fa2-8a72-5c8d-1d2d4b743db0@amsat.org>
Date: Fri, 26 Jun 2020 16:37:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006261622590.63331@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>, Fred Konrad <konrad@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 4:26 PM, BALATON Zoltan wrote:
> On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
>> On 6/26/20 4:03 PM, BALATON Zoltan wrote:
>>> On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
>>>> + Eduardo / Mark / Edgard / Alistair / Fred for QOM design.
>>>>
>>>> On 6/26/20 12:54 PM, BALATON Zoltan wrote:
>>>>> On Fri, 26 Jun 2020, BALATON Zoltan wrote:
>>>>>> On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
>>>>>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>>>> ---
>>>>>>> Aspeed change pending latest ARM pull-request, so meanwhile sending
>>>>>>> as RFC.
>>>>>>> ---
>>>>>>> include/hw/i2c/smbus_eeprom.h |  9 ++++++---
>>>>>>> hw/i2c/smbus_eeprom.c         | 13 ++++++++++---
>>>>>>> hw/mips/fuloong2e.c           |  2 +-
>>>>>>> hw/ppc/sam460ex.c             |  2 +-
>>>>>>> 4 files changed, 18 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/hw/i2c/smbus_eeprom.h
>>>>>>> b/include/hw/i2c/smbus_eeprom.h
>>>>>>> index 68b0063ab6..037612bbbb 100644
>>>>>>> --- a/include/hw/i2c/smbus_eeprom.h
>>>>>>> +++ b/include/hw/i2c/smbus_eeprom.h
>>>>>>> @@ -26,9 +26,12 @@
>>>>>>> #include "exec/cpu-common.h"
>>>>>>> #include "hw/i2c/i2c.h"
>>>>>>>
>>>>>>> -void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t
>>>>>>> *eeprom_buf);
>>>>>>> -void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
>>>>>>> -                       const uint8_t *eeprom_spd, int size);
>>>>>>> +void smbus_eeprom_init_one(Object *parent_obj, const char
>>>>>>> *child_name,
>>>>>>> +                           I2CBus *smbus, uint8_t address,
>>>>>>> +                           uint8_t *eeprom_buf);
>>>>>>> +void smbus_eeprom_init(Object *parent_obj, const char
>>>>>>> *child_name_prefix,
>>>>>>> +                       I2CBus *smbus, int nb_eeprom,
>>>>>>> +                       const uint8_t *eeprom_spd, int
>>>>>>> eeprom_spd_size);
>>>>>>
>>>>>> Keeping I2CBus *smbus and uint8_t address as first parameters before
>>>>>> parent_obj and name looks better to me. These functions still operate
>>>>>> on an I2Cbus so could be regarded as methods of I2CBus therefore
>>>>>> first
>>>>>> parameter should be that.
>>>>>
>>>>> Also isn't parent_obj is the I2Cbus itself? Why is that need to be
>>>>> passed? The i2c_init_bus() also takes parent and name params so both
>>>>> I2Cbus and it's parent should be available as parents of the new I2C
>>>>> device here without more parameters. What am I missing here?
>>>>
>>>> This is where I'm confused too and what I want to resolve with this
>>>> RFC series :)
>>>>
>>>> The SPD EEPROM is soldered on the DIMM module. The DIMM exposes the
>>>> memory address/data pins and the i2c pins. We plug DIMMs on a
>>>> (mother)board.
>>>>
>>>> I see the DIMM module being the parent. As we don't model it in QOM,
>>>> I used the MemoryRegion (which is what the SPD is describing).
>>>>
>>>> We could represent the DIMM as a container of DRAM + SPD EEPROM, but
>>>> it makes the modeling slightly more complex. The only benefit is a
>>>> clearer modeling.
>>>>
>>>> I'm not sure why the I2C bus is expected to be the parent. Maybe an
>>>> old wrong assumption?
>>>
>>> I guess it's a question of what the parent should mean? Is it parent of
>>> the object in which case it's the I2CBus (which is kind of logical view
>>> of the object tree modelling the machine) or the parent of the thing
>>> modelled in the machine (which is physical view of the machine
>>> components) then it should be the RAM module. The confusion probably
>>> comes from this question not answered. Also the DIMM module is not
>>> modelled so when you assign SPD eeproms to memory region it could be
>>> multiple SPD eeproms will be parented by a single RAM memory region
>>> (possibly not covering it fully as in the mac_oldworld or sam460ex case
>>> discussed in another thread). This does not seem too intuitive.
>>
>> From the bus perspective, requests are sent hoping for a device to
>> answer to the requested address ("Hello, do I have children? Hello?
>> Anybody here?"), if nobody is here, the request timeouts.
>> So there is not really a strong family relationship here.
>>
>> If you unplug a DIMM, you remove both the MemoryRegion and the EEPROM.
>> This is how I understand the QOM parent relationship so far (if you
>> remove a parent, you also remove its children).
> 
> OK but what if we don't have a DIMM object as that is not modelled?
> Should you set parent to the board in that case? Or is it still modelled
> as an I2C device that is plugged in an I2C bus. Does it need to have a
> parent in this case at all or is it a case for an unattached device
> (becuase its physical parent is not modelled)?

So you reduced the dependency as SPD -> RAM, which is clever because
we won't have DIMM without RAM =)

Suggestion for new prototype (eeprom content populated in callee):

  SMBusEEPROMDevice spd_eeprom_new(MemoryDeviceState *memdev,
                                   const char *eeprom_name,
                                   I2CBus *smbus,
                                   uint8_t i2c_address);

The SPD describes the @memdev (which is its parent).
We can still modify the eeprom content after its creation.

> 
> Regards,
> BALATON Zoltan

