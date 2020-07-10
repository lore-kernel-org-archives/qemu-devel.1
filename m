Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE939C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852CD2077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE+pAuTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852CD2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtp5t-0005Bv-Rl
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtp5D-0004eG-Nn; Fri, 10 Jul 2020 05:12:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtp5B-0002XR-Nk; Fri, 10 Jul 2020 05:12:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so5293382wmh.4;
 Fri, 10 Jul 2020 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=orYU250Ul48K/BeStseGw7anYWCdUYlKIwuy+++2vGk=;
 b=NE+pAuTTG8DwWeBDs5bVWX6RDijUxNi72F7bddyRiuqTLqR7nQabdb+4Q43bc6QYeK
 d9uBk7SvJMkiVeCTB31tspFZiJDKZ+HvHjEcEFIZzRHKp45RzjPdxLSDwyd1NnMq4e+2
 kVuSH9xkqXbqqujWWiaL1GcdUmykt5bIEwc/VWLSdNWHavNQ3GIukzl5pxXSpzjW4q+6
 z+kttEyALWPKwW4ssatA55X6a+Yrv/dyRV7Ow6Hod9zaEk+24z374HBWcZZO9KAkD+oi
 j5fmh5FrZg8D06w238BEzviyp6lw+t2OAi9qAUfxbHI97pHI5Yqb1a+4tm9gZY00JQUg
 8/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=orYU250Ul48K/BeStseGw7anYWCdUYlKIwuy+++2vGk=;
 b=K7BH4NkzbPVl3a0ZDwhpPrI9XOB6lHYjicMd/YPYh43tCgTnEgguFqzs84CsX7WPq5
 fPCJyDltiIsM9qev/+vPWvbRl2x1eI/fmOSy7qQpAiVcH3/NpzEAhJbEwDkNW7bh1RdO
 mHkevfEuXpxp+AC3qog+12UpkaERwEJgY3eauzIKT1KiH5+vfeh6FC0Md6dX8hVx8IGX
 Emc0w7IyyHua2IRw5Ws9jiYYttjiynWxxBsWdo4sQk2ZKUzAN8k/pbnPUNdVercZzseU
 qee1CAYSM0vEyJXtsbr33CfKyw4PFCF3/xo1oOoUxRWxvEV6uiRDBWe1JuFpDhqKxwGl
 Q7xA==
X-Gm-Message-State: AOAM532M7rEpiimTfzqY6+qEcfl6JirPY6ptmvmng/DhnrdBOT7MuxBi
 raXdpYOcVs0AfK/rqpd4PjI=
X-Google-Smtp-Source: ABdhPJwhHJLwB5jP1W5JTJuHK5HLS7D+QNx2hLyFjMdDy/avjZJx7rhgAw4z8PvxXhyaKcsZ0rUG6w==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr4086086wmg.14.1594372355511; 
 Fri, 10 Jul 2020 02:12:35 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g195sm8707330wme.38.2020.07.10.02.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 02:12:34 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] hw/i2c/smbus_eeprom: Set QOM parent
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261240500.94870@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261251480.94870@zero.eik.bme.hu>
 <f7da6118-a27a-a09d-9c8f-92cbf2eca96f@amsat.org>
 <alpine.BSF.2.22.395.2006261557050.56498@zero.eik.bme.hu>
 <4825239e-1e75-a401-2068-a8c14c38f60b@amsat.org>
 <20200709200523.GK780932@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97e85da0-b297-30da-1ab0-dd725ab8f2f3@amsat.org>
Date: Fri, 10 Jul 2020 11:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709200523.GK780932@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>, Fred Konrad <konrad@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 10:05 PM, Eduardo Habkost wrote:
> On Fri, Jun 26, 2020 at 04:15:40PM +0200, Philippe Mathieu-DaudÃ© wrote:
>> On 6/26/20 4:03 PM, BALATON Zoltan wrote:
>>> On Fri, 26 Jun 2020, Philippe Mathieu-DaudÃ© wrote:
>>>> + Eduardo / Mark / Edgard / Alistair / Fred for QOM design.
>>>>
>>>> On 6/26/20 12:54 PM, BALATON Zoltan wrote:
>>>>> On Fri, 26 Jun 2020, BALATON Zoltan wrote:
>>>>>> On Fri, 26 Jun 2020, Philippe Mathieu-DaudÃ© wrote:
>>>>>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>>>>>> Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>>>>>>> ---
>>>>>>> Aspeed change pending latest ARM pull-request, so meanwhile sending
>>>>>>> as RFC.
>>>>>>> ---
>>>>>>> include/hw/i2c/smbus_eeprom.h |Â  9 ++++++---
>>>>>>> hw/i2c/smbus_eeprom.cÂ Â Â Â Â Â Â Â  | 13 ++++++++++---
>>>>>>> hw/mips/fuloong2e.cÂ Â Â Â Â Â Â Â Â Â  |Â  2 +-
>>>>>>> hw/ppc/sam460ex.cÂ Â Â Â Â Â Â Â Â Â Â Â  |Â  2 +-
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
>>>>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  const uint8_t *eeprom_spd, int size);
>>>>>>> +void smbus_eeprom_init_one(Object *parent_obj, const char
>>>>>>> *child_name,
>>>>>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  I2CBus *smbus, uint8_t address,
>>>>>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  uint8_t *eeprom_buf);
>>>>>>> +void smbus_eeprom_init(Object *parent_obj, const char
>>>>>>> *child_name_prefix,
>>>>>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  I2CBus *smbus, int nb_eeprom,
>>>>>>> +Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  const uint8_t *eeprom_spd, int
>>>>>>> eeprom_spd_size);
>>>>>>
>>>>>> Keeping I2CBus *smbus and uint8_t address as first parameters before
>>>>>> parent_obj and name looks better to me. These functions still operate
>>>>>> on an I2Cbus so could be regarded as methods of I2CBus therefore first
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
> I'll be honest: I don't think I understand the main purpose of
> QOM parent/child relationships.  My best guess is that they make
> object destruction easier to manage (if you destroy a parent, you
> will automatically destroy its children).
> 
> If we don't write down what QOM parent/child relationships are
> supposed to mean (and what they are _not_ supposed to mean), we
> will never know when it's appropriate and/or safe to move objects
> to a different parent.

I'm trying to understand these monitor commands:

info qdm  -- show qdev device model list
info qom-tree [path] -- show QOM composition tree
info qtree  -- show device tree

This is the 'QOM composition tree' of the isapc machine:

(qemu) info qom-tree
/machine (isapc-machine)
  /fw_cfg (fw_cfg_io)
    /fwcfg.dma[0] (qemu:memory-region)
    /fwcfg[0] (qemu:memory-region)
  /peripheral (container)
  /peripheral-anon (container)
  /unattached (container)
    /device[0] (486-i386-cpu)
      /memory[0] (qemu:memory-region)
      /memory[1] (qemu:memory-region)
    /device[10] (isa-serial)
      /serial (serial)
      /serial[0] (qemu:memory-region)
    /device[11] (isa-parallel)
      /parallel[0] (qemu:memory-region)
    /device[12] (isa-fdc)
      /fdc[0] (qemu:memory-region)
      /fdc[1] (qemu:memory-region)
      /floppy-bus.0 (floppy-bus)
    /device[13] (floppy)
    /device[14] (i8042)
      /i8042-cmd[0] (qemu:memory-region)
      /i8042-data[0] (qemu:memory-region)
    /device[15] (vmport)
      /vmport[0] (qemu:memory-region)
    /device[16] (vmmouse)
    /device[17] (port92)
      /port92[0] (qemu:memory-region)
    /device[18] (ne2k_isa)
      /ne2000[0] (qemu:memory-region)
    /device[19] (isa-ide)
      /ide.0 (IDE)
      /ide[0] (qemu:memory-region)
      /ide[1] (qemu:memory-region)
    /device[1] (isabus-bridge)
      /isa.0 (ISA)
    /device[20] (isa-ide)
      /ide.1 (IDE)
      /ide[0] (qemu:memory-region)
      /ide[1] (qemu:memory-region)
    /device[21] (ide-cd)
    /device[2] (isa-i8259)
      /elcr[0] (qemu:memory-region)
      /pic[0] (qemu:memory-region)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[1] (irq)
      /unnamed-gpio-in[2] (irq)
      /unnamed-gpio-in[3] (irq)
      /unnamed-gpio-in[4] (irq)
      /unnamed-gpio-in[5] (irq)
      /unnamed-gpio-in[6] (irq)
      /unnamed-gpio-in[7] (irq)
    /device[3] (isa-i8259)
      /elcr[0] (qemu:memory-region)
      /pic[0] (qemu:memory-region)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[1] (irq)
      /unnamed-gpio-in[2] (irq)
      /unnamed-gpio-in[3] (irq)
      /unnamed-gpio-in[4] (irq)
      /unnamed-gpio-in[5] (irq)
      /unnamed-gpio-in[6] (irq)
      /unnamed-gpio-in[7] (irq)
    /device[4] (isa-cirrus-vga)
      /cirrus-bitblt-mmio[0] (qemu:memory-region)
      /cirrus-io[0] (qemu:memory-region)
      /cirrus-linear-io[0] (qemu:memory-region)
      /cirrus-low-memory[0] (qemu:memory-region)
      /cirrus-lowmem-container[0] (qemu:memory-region)
      /cirrus-mmio[0] (qemu:memory-region)
      /vga.bank0[0] (qemu:memory-region)
      /vga.bank1[0] (qemu:memory-region)
      /vga.vram[0] (qemu:memory-region)
    /device[5] (mc146818rtc)
      /rtc-index[0] (qemu:memory-region)
      /rtc[0] (qemu:memory-region)
    /device[6] (isa-pit)
      /pit[0] (qemu:memory-region)
      /unnamed-gpio-in[0] (irq)
    /device[7] (isa-pcspk)
      /pcspk[0] (qemu:memory-region)
    /device[8] (i8257)
      /dma-chan[0] (qemu:memory-region)
      /dma-cont[0] (qemu:memory-region)
      /dma-page[0] (qemu:memory-region)
      /dma-page[1] (qemu:memory-region)
    /device[9] (i8257)
      /dma-chan[0] (qemu:memory-region)
      /dma-cont[0] (qemu:memory-region)
      /dma-page[0] (qemu:memory-region)
      /dma-page[1] (qemu:memory-region)
    /io[0] (qemu:memory-region)
    /ioport80[0] (qemu:memory-region)
    /ioportF0[0] (qemu:memory-region)
    /isa-bios[0] (qemu:memory-region)
    /non-qdev-gpio[0] (irq)
    /non-qdev-gpio[1] (irq)
    /non-qdev-gpio[2] (irq)
    /non-qdev-gpio[3] (irq)
    /non-qdev-gpio[4] (irq)
    /pc.bios[0] (qemu:memory-region)
    /pc.rom[0] (qemu:memory-region)
    /ram-below-4g[0] (qemu:memory-region)
    /sysbus (System)
    /system[0] (qemu:memory-region)

What means for an object to have an '/unattached' parent?


And now the raspi2:

(qemu) info qom-tree
/machine (raspi2-machine)
  /peripheral (container)
  /peripheral-anon (container)
  /soc (bcm2836)
    /control (bcm2836-control)
      /bcm2836-control[0] (qemu:memory-region)
      /cnthpirq[0] (irq)
      /cnthpirq[1] (irq)
      [...]
      /gpu-fiq[0] (irq)
      /gpu-irq[0] (irq)
    /cpu[0] (cortex-a7-arm-cpu)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[1] (irq)
      /unnamed-gpio-in[2] (irq)
      /unnamed-gpio-in[3] (irq)
    /cpu[1] (cortex-a7-arm-cpu)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[1] (irq)
      /unnamed-gpio-in[2] (irq)
      /unnamed-gpio-in[3] (irq)
    /cpu[2] (cortex-a7-arm-cpu)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[1] (irq)
      /unnamed-gpio-in[2] (irq)
      /unnamed-gpio-in[3] (irq)
    /cpu[3] (cortex-a7-arm-cpu)
      /unnamed-gpio-in[0] (irq)
      /unnamed-gpio-in[1] (irq)
      /unnamed-gpio-in[2] (irq)
      /unnamed-gpio-in[3] (irq)
    /peripherals (bcm2835-peripherals)
      /aux (bcm2835-aux)
        /bcm2835-aux[0] (qemu:memory-region)
      /bcm2835-a2w (unimplemented-device)
        /bcm2835-a2w[0] (qemu:memory-region)
      /bcm2835-ave0 (unimplemented-device)
        /bcm2835-ave0[0] (qemu:memory-region)
      /bcm2835-cprman (unimplemented-device)
        /bcm2835-cprman[0] (qemu:memory-region)
      /bcm2835-dbus (unimplemented-device)
        /bcm2835-dbus[0] (qemu:memory-region)
      /bcm2835-gpu-ram-alias\x5b*\x5d[0] (qemu:memory-region)
      /bcm2835-gpu-ram-alias\x5b*\x5d[1] (qemu:memory-region)
      /bcm2835-gpu-ram-alias\x5b*\x5d[2] (qemu:memory-region)
      /bcm2835-gpu-ram-alias\x5b*\x5d[3] (qemu:memory-region)
      /bcm2835-gpu[0] (qemu:memory-region)
      /bcm2835-i2c0 (unimplemented-device)
        /bcm2835-i2c0[0] (qemu:memory-region)
      /bcm2835-i2c1 (unimplemented-device)
        /bcm2835-i2c1[0] (qemu:memory-region)
      /bcm2835-i2c2 (unimplemented-device)
        /bcm2835-i2c2[0] (qemu:memory-region)
      /bcm2835-i2s (unimplemented-device)
        /bcm2835-i2s[0] (qemu:memory-region)
      /bcm2835-mbox[0] (qemu:memory-region)
      /bcm2835-otp (unimplemented-device)
        /bcm2835-otp[0] (qemu:memory-region)
      /bcm2835-peripherals[0] (qemu:memory-region)
      /bcm2835-peripherals[1] (qemu:memory-region)
      /bcm2835-sdramc (unimplemented-device)
        /bcm2835-sdramc[0] (qemu:memory-region)
      /bcm2835-smi (unimplemented-device)
        /bcm2835-smi[0] (qemu:memory-region)
      /bcm2835-sp804 (unimplemented-device)
        /bcm2835-sp804[0] (qemu:memory-region)
      /bcm2835-spi0 (unimplemented-device)
        /bcm2835-spi0[0] (qemu:memory-region)
      /bcm2835-spis (unimplemented-device)
        /bcm2835-spis[0] (qemu:memory-region)
      /dma (bcm2835-dma)
        /bcm2835-dma-chan15[0] (qemu:memory-region)
        /bcm2835-dma[0] (qemu:memory-region)
      /dwc2 (dwc2-usb)
        /dwc2-fifo[0] (qemu:memory-region)
        /dwc2-io[0] (qemu:memory-region)
        /dwc2[0] (qemu:memory-region)
        /usb-bus.0 (usb-bus)
      /fb (bcm2835-fb)
        /bcm2835-fb[0] (qemu:memory-region)
      /gpio (bcm2835_gpio)
        /bcm2835_gpio[0] (qemu:memory-region)
        /sd-bus (sd-bus)
      /ic (bcm2835-ic)
        /arm-irq[0] (irq)
        /arm-irq[1] (irq)
        /arm-irq[2] (irq)
        /arm-irq[3] (irq)
        /arm-irq[4] (irq)
        /arm-irq[5] (irq)
        /arm-irq[6] (irq)
        /arm-irq[7] (irq)
        /bcm2835-ic[0] (qemu:memory-region)
        /gpu-irq[0] (irq)
        /gpu-irq[10] (irq)
        [...]
      /mbox (bcm2835-mbox)
        /bcm2835-mbox[0] (qemu:memory-region)
        /unnamed-gpio-in[0] (irq)
        /unnamed-gpio-in[1] (irq)
        /unnamed-gpio-in[2] (irq)
        /unnamed-gpio-in[3] (irq)
        /unnamed-gpio-in[4] (irq)
        /unnamed-gpio-in[5] (irq)
        /unnamed-gpio-in[6] (irq)
        /unnamed-gpio-in[7] (irq)
        /unnamed-gpio-in[8] (irq)
      /mphi (bcm2835-mphi)
        /mphi[0] (qemu:memory-region)
      /property (bcm2835-property)
        /bcm2835-property[0] (qemu:memory-region)
      /rng (bcm2835-rng)
        /bcm2835-rng[0] (qemu:memory-region)
      /sdhci (generic-sdhci)
        /sd-bus (sdhci-bus)
        /sdhci[0] (qemu:memory-region)
      /sdhost (bcm2835-sdhost)
        /bcm2835-sdhost[0] (qemu:memory-region)
        /sd-bus (bcm2835-sdhost-bus)
      /systimer (bcm2835-sys-timer)
        /bcm2835-sys-timer[0] (qemu:memory-region)
      /thermal (bcm2835-thermal)
        /bcm2835-thermal[0] (qemu:memory-region)
      /uart0 (pl011)
        /pl011[0] (qemu:memory-region)
  /unattached (container)
    /device[0] (sd-card)
    /io[0] (qemu:memory-region)
    /sysbus (System)
    /system[0] (qemu:memory-region)

Who is the 'parent' of the sd-card? The sd-bus? The sdhci controller?
The machine?

The sd-card can be 'reparented' between the sd-busses of
'/sdhci (generic-sdhci)' and '/sdhost (bcm2835-sdhost)'.

Thanks,

Phil.

