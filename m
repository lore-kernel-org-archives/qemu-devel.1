Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3761FC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD302133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD302133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51248 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hblde-00058q-Qx
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hblQJ-0004BF-05
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hblQG-0004vN-VI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:35:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hblQE-0004tU-U1
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:35:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so2199521wma.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 05:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fEaF4clYgZn2kJ7fan+D0LaG00CiaqS56mBWRFxX80o=;
 b=Yc6EBIolmPp2mOGdhWr+SazP2pvLu8/bu8PStukAeDPyZLnolQrT1D7go9NYItzpSZ
 Sj4CojnaPqHUtw1hL+OFDZU1qnsIqwAtsNBWWXhmIxu7GzB/JLtcICv8bxJsHGOPH8AE
 uRQeT0ysHixNa042/oer3DlJy1617m04rLndQNIAcKbwma08QA2zuMI4vO2oY5tzHND2
 KMXipGfZyQ2//IYRL+4mJSHmOE3GfbXLjWvaM/oOqbpVgFt+/gL3vCHTwjM8ku94goXp
 tZNAlt7uECjlAjefomi9akUkd2J/vqRlfwRimoHSe7lcF2lpJnKIzDHn+l+92JJIzDGw
 zLug==
X-Gm-Message-State: APjAAAXp2YjDkAzS5nQ+xuocr1bfJmoyG7qxxrygQW11Us3EezeRsmhT
 +vh6SfMlhk7iNhOpYtzSlN858w==
X-Google-Smtp-Source: APXvYqzzX4wIjjU/WKDEBoyM4jttwVMGibTvdgcOWRj9XCW+kcFR8zp2OwkQevhx+9VmiR9T8Pj4yw==
X-Received: by 2002:a1c:9d86:: with SMTP id g128mr8497166wme.51.1560515709509; 
 Fri, 14 Jun 2019 05:35:09 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t198sm3678080wmt.2.2019.06.14.05.35.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 05:35:08 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-19-clg@kaod.org>
 <f3b3948f-8d24-fb8c-0b65-8fe08019a077@redhat.com>
 <b4401eaf-9898-8c3e-3beb-f550edb83228@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1e2ae27f-d5e9-f2ca-ec35-2c536710a5ef@redhat.com>
Date: Fri, 14 Jun 2019 14:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b4401eaf-9898-8c3e-3beb-f550edb83228@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 18/19] aspeed/smc: inject errors in DMA
 checksum
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus & Marc-André

On 6/14/19 2:02 PM, Cédric Le Goater wrote:
> On 13/06/2019 16:31, Philippe Mathieu-Daudé wrote:
>> Hi Cédric,
>>
>> On 5/25/19 5:12 PM, Cédric Le Goater wrote:
>>> Emulate read errors in the DMA Checksum Register for high frequencies
>>> and optimistic settings of the Read Timing Compensation Register. This
>>> will help in tuning the SPI timing calibration algorithm.
>>>
>>> The values below are those to expect from the first flash device of
>>> the FMC controller of a palmetto-bmc machine.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>  hw/ssi/aspeed_smc.c | 29 +++++++++++++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>>
>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>>> index 406c30c60b3f..4c162912cf62 100644
>>> --- a/hw/ssi/aspeed_smc.c
>>> +++ b/hw/ssi/aspeed_smc.c
>>> @@ -866,6 +866,30 @@ static void aspeed_smc_dma_calibration(AspeedSMCState *s)
>>>      s->regs[s->r_ctrl0 + cs] |= CE_CTRL_CLOCK_FREQ(hclk_div);
>>>  }
>>>  
>>
>> Can you add a comment (like the patch description) here?
> 
> yes. done.
>  
>>> +static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
>>> +{
>>> +    uint8_t delay =
>>> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_DELAY_SHIFT) & DMA_CTRL_DELAY_MASK;
>>> +    uint8_t hclk_mask =
>>> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_FREQ_SHIFT) & DMA_CTRL_FREQ_MASK;
>>> +
>>> +    /*
>>> +     * Typical values of a palmetto-bmc machine.
>>> +     */
>>> +    switch (aspeed_smc_hclk_divisor(hclk_mask)) {
>>> +    case 4 ... 16:
>>> +        return false;
>>> +    case 3: /* at least one HCLK cycle delay */
>>> +        return (delay & 0x7) < 1;
>>> +    case 2: /* at least two HCLK cycle delay */
>>> +        return (delay & 0x7) < 2;
>>> +    case 1: /* (> 100MHz) is above the max freq of the controller */
>>> +        return true;
>>> +    default:
>>> +        g_assert_not_reached();
>>> +    }
>>> +}
>>> +
>>>  /*
>>>   * Accumulate the result of the reads to provide a checksum that will
>>>   * be used to validate the read timing settings.
>>> @@ -903,6 +927,11 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>>>          s->regs[R_DMA_FLASH_ADDR] += 4;
>>>          s->regs[R_DMA_LEN] -= 4;
>>>      }
>>> +
>>> +    if (aspeed_smc_inject_read_failure(s)) {
>>
>> So this model real world where noise eventually triggers errors. Don't
>> we want this to be enable by the user (or a QMP command)?
> 
> I can add a property at the device model level to trigger this behavior.
> Such as :
> 
>    -global driver=aspeed.smc,property=timing,value=true
> 
> timing if defined would provide the maximum clock and delay settings.

I was thinking of a simpler:

    -global driver=aspeed.smc,property=inject_failure,value=true

Then

    if (s->inject_failure && aspeed_smc_inject_read_failure(s)) {
        s->regs[R_DMA_CHECKSUM] = 0xbadc0de;
    }

> 
> Are there any other examples in QEMU ?

I think most of them are hidden in the codebase...

> 
> Thanks,
> 
> C.
> 
>>
>>> +        s->regs[R_DMA_CHECKSUM] = 0xbadc0de;
>>> +    }
>>> +
>>>  }
>>>  
>>>  static void aspeed_smc_dma_rw(AspeedSMCState *s)
>>>
> 

