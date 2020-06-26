Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA482C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F1920836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh2O0iet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F1920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonfL-0001iN-Nw
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jonec-000177-UU; Fri, 26 Jun 2020 08:40:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1joneb-0001UH-3p; Fri, 26 Jun 2020 08:40:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id o2so9244182wmh.2;
 Fri, 26 Jun 2020 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gSBJrGE5sK61HmrO+soFxguRKpEIxWDQURVi6K5kOOs=;
 b=Yh2O0ietx7IOqyA5QwIL0C37BkL0M1T6W22m/u7wBWAzicYdl06APOuiOzvqppKPUo
 uzyLomKdpEz2ChDb0wRxUCfF780azdQX7PZv7wI0/KqbHHKL5nQAxw8Fvno60NVzcK2g
 wfvEoW+/+nkLNWkKHAOlM1CQ4XXHkSikzXhi+8G6BYc88fCxyLlgYUNTts3rZKhvwtCF
 zkMSVxSLy5NK2jQ96buJUOpq0FowpwlHx2ATJwMrB8xXYbqwPAMWv8tEZjX0rpFMZFt+
 AKWQNhgX4LExw4AiqKNUqk0qI81gwlagOY1o2id6/kk/8y7mHHta54xLmyPMP4zVi0MT
 t2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gSBJrGE5sK61HmrO+soFxguRKpEIxWDQURVi6K5kOOs=;
 b=hdtt9hI0WDjN9IzImr0aEld0RipTPJcj6HgwwV4fSTMOWAExCa7ZfXfrqQJuvRAvyx
 PmF4sJX5cCX6zq6ORAK1XKp4QA62thZbRXAuzbRSqIxVT7svaYm7zZ2BOy9H8kkp13lc
 hniAhgKcM5T1/4CLZ9Mi5GNsXBQa0/mEmNB+nf7zRM1NDflu+La17TdMQjbWY/n48nmB
 8nNjP8HL0tyhK2N7WTxnhU1I0P4dilnkS3pQtIZU+bp1JqSV1s27EIh7bLnjEAM9nSlY
 PQx1Q4hnWlxJNygBIfVao+i76gSyXHZCeO+B4yxCZ+1L3MmVSf7hKE1OPzbh8ikwJBdh
 nCfg==
X-Gm-Message-State: AOAM532BDNmFNwY6P1kSEJCbLDn6DWMT96FX7UhTbM1oHWO1o9IZ7KKz
 nVz830EYOjIJ8w9KzJkU8L8=
X-Google-Smtp-Source: ABdhPJxHdJL30seKT+sqeY9jJRJiYK9Pz0T4yYFXTHIMzIqgCLP/O0Y0xuCSSRJgGECTBDyZhhGO/Q==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr3256585wmc.150.1593175222902; 
 Fri, 26 Jun 2020 05:40:22 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o29sm29189306wra.5.2020.06.26.05.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 05:40:22 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] hw/i2c/smbus_eeprom: Set QOM parent
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261240500.94870@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261251480.94870@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7da6118-a27a-a09d-9c8f-92cbf2eca96f@amsat.org>
Date: Fri, 26 Jun 2020 14:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006261251480.94870@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Fred Konrad <konrad@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+ Eduardo / Mark / Edgard / Alistair / Fred for QOM design.

On 6/26/20 12:54 PM, BALATON Zoltan wrote:
> On Fri, 26 Jun 2020, BALATON Zoltan wrote:
>> On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>> Aspeed change pending latest ARM pull-request, so meanwhile sending
>>> as RFC.
>>> ---
>>> include/hw/i2c/smbus_eeprom.h |  9 ++++++---
>>> hw/i2c/smbus_eeprom.c         | 13 ++++++++++---
>>> hw/mips/fuloong2e.c           |  2 +-
>>> hw/ppc/sam460ex.c             |  2 +-
>>> 4 files changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/hw/i2c/smbus_eeprom.h
>>> b/include/hw/i2c/smbus_eeprom.h
>>> index 68b0063ab6..037612bbbb 100644
>>> --- a/include/hw/i2c/smbus_eeprom.h
>>> +++ b/include/hw/i2c/smbus_eeprom.h
>>> @@ -26,9 +26,12 @@
>>> #include "exec/cpu-common.h"
>>> #include "hw/i2c/i2c.h"
>>>
>>> -void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t
>>> *eeprom_buf);
>>> -void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
>>> -                       const uint8_t *eeprom_spd, int size);
>>> +void smbus_eeprom_init_one(Object *parent_obj, const char *child_name,
>>> +                           I2CBus *smbus, uint8_t address,
>>> +                           uint8_t *eeprom_buf);
>>> +void smbus_eeprom_init(Object *parent_obj, const char
>>> *child_name_prefix,
>>> +                       I2CBus *smbus, int nb_eeprom,
>>> +                       const uint8_t *eeprom_spd, int eeprom_spd_size);
>>
>> Keeping I2CBus *smbus and uint8_t address as first parameters before
>> parent_obj and name looks better to me. These functions still operate
>> on an I2Cbus so could be regarded as methods of I2CBus therefore first
>> parameter should be that.
> 
> Also isn't parent_obj is the I2Cbus itself? Why is that need to be
> passed? The i2c_init_bus() also takes parent and name params so both
> I2Cbus and it's parent should be available as parents of the new I2C
> device here without more parameters. What am I missing here?

This is where I'm confused too and what I want to resolve with this
RFC series :)

The SPD EEPROM is soldered on the DIMM module. The DIMM exposes the
memory address/data pins and the i2c pins. We plug DIMMs on a
(mother)board.

I see the DIMM module being the parent. As we don't model it in QOM,
I used the MemoryRegion (which is what the SPD is describing).

We could represent the DIMM as a container of DRAM + SPD EEPROM, but
it makes the modeling slightly more complex. The only benefit is a
clearer modeling.

I'm not sure why the I2C bus is expected to be the parent. Maybe an
old wrong assumption?

>> Regards,
>> BALATON Zoltan
>>
>>> enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
>>> uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size);
>>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>>> index b7def9eeb8..879fd7c416 100644
>>> --- a/hw/i2c/smbus_eeprom.c
>>> +++ b/hw/i2c/smbus_eeprom.c
>>> @@ -165,7 +165,9 @@ static void smbus_eeprom_register_types(void)
>>>
>>> type_init(smbus_eeprom_register_types)
>>>
>>> -void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t
>>> *eeprom_buf)
>>> +void smbus_eeprom_init_one(Object *parent_obj, const char *child_name,
>>> +                           I2CBus *smbus, uint8_t address,
>>> +                           uint8_t *eeprom_buf)
>>> {
>>>     DeviceState *dev;
>>>
>>> @@ -173,10 +175,12 @@ void smbus_eeprom_init_one(I2CBus *smbus,
>>> uint8_t address, uint8_t *eeprom_buf)
>>>     qdev_prop_set_uint8(dev, "address", address);
>>>     /* FIXME: use an array of byte or block backend property? */
>>>     SMBUS_EEPROM(dev)->init_data = eeprom_buf;
>>> +    object_property_add_child(parent_obj, child_name, OBJECT(dev));
>>>     qdev_realize_and_unref(dev, (BusState *)smbus, &error_fatal);
>>> }
>>>
>>> -void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>>> +void smbus_eeprom_init(Object *parent_obj, const char
>>> *child_name_prefix,
>>> +                       I2CBus *smbus, int nb_eeprom,
>>>                        const uint8_t *eeprom_spd, int eeprom_spd_size)
>>> {
>>>     int i;
>>> @@ -189,8 +193,11 @@ void smbus_eeprom_init(I2CBus *smbus, int
>>> nb_eeprom,
>>>     }
>>>
>>>     for (i = 0; i < nb_eeprom; i++) {
>>> -        smbus_eeprom_init_one(smbus, 0x50 + i,
>>> +        char *name = g_strdup_printf("%s-%d", child_name_prefix, i);
>>> +
>>> +        smbus_eeprom_init_one(parent_obj, name, smbus, 0x50 + i,
>>>                               eeprom_buf + (i * SMBUS_EEPROM_SIZE));
>>> +        g_free(name);
>>>     }
>>> }
>>>
>>> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
>>> index 8ca31e5162..304a096c6a 100644
>>> --- a/hw/mips/fuloong2e.c
>>> +++ b/hw/mips/fuloong2e.c
>>> @@ -377,7 +377,7 @@ static void mips_fuloong2e_init(MachineState
>>> *machine)
>>>
>>>     /* Populate SPD eeprom data */
>>>     spd_data = spd_data_generate(DDR, machine->ram_size);
>>> -    smbus_eeprom_init_one(smbus, 0x50, spd_data);
>>> +    smbus_eeprom_init_one(OBJECT(machine->ram), "spd", smbus, 0x50,
>>> spd_data);
>>>
>>>     mc146818_rtc_init(isa_bus, 2000, NULL);
>>>
>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>> index 1a106a68de..064d07f4e2 100644
>>> --- a/hw/ppc/sam460ex.c
>>> +++ b/hw/ppc/sam460ex.c
>>> @@ -337,7 +337,7 @@ static void sam460ex_init(MachineState *machine)
>>>     spd_data = spd_data_generate(ram_sizes[0] < 128 * MiB ? DDR : DDR2,
>>>                                  ram_sizes[0]);
>>>     spd_data[20] = 4; /* SO-DIMM module */
>>> -    smbus_eeprom_init_one(i2c, 0x50, spd_data);
>>> +    smbus_eeprom_init_one(OBJECT(machine->ram), "spd", i2c, 0x50,
>>> spd_data);
>>>     /* RTC */
>>>     i2c_create_slave(i2c, "m41t80", 0x68);
>>>
>>

