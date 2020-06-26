Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDD5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD112070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="FWh4GPgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD112070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolUM-0001Ag-7l
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jolTc-0000Qh-7k
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:20:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jolTZ-0000Yn-T7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:20:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id h15so8940673wrq.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 03:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HZszshd4Hekk2xoLPDfr8sMsuK2CP4Yh/pTf9prQI6Y=;
 b=FWh4GPgfPEvwgb4PusLptiK13gJiCdbbRz8yOEtPE69e9KpVY232iQ5mr3NvGSUof4
 qbeahGChVxSvG0zBVs3nqGLXaneDNysc+FXrdNUUkbrvIzRHrioOGsaVtAWaER21YcV4
 JkSdBs8CS/qTdiQ86uIeclnjkeP5TkrCcgHO5xHCiWm2IgJmJOSQz85/vYSAoAKYEh6v
 KVTVOMRBt0fOS0JVj3G6gmXoO2dkIJqgHlpWp4VWpwvUMja0HmyofxiUw9J4tB6xl9Cp
 fu7Qd9KbiSsujJ7tOpB14uinJHFFweiRhwkvnc5Gc20AfZw+hV9S7JQb4KyqlecURwu+
 RiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HZszshd4Hekk2xoLPDfr8sMsuK2CP4Yh/pTf9prQI6Y=;
 b=CNSMgx6B0wAHcGDR9mPBcNbChr2nGXmpVO2lk9adYaH76NWeUGmTqIvfu5n5WsVuIl
 bbzk45BJo0z+OKVMUWTanfzuHYffeaA8FeYa0jepMhUo2zRh5WX6U1qbHPhEVVknmAtb
 tOwPGfGtfATyJTp5cXedm98Cgw2V1L1KGxYpjRp3MmiVFnAnPFbdb926TfZrGBFiNLMu
 tfbEVbqK7g2rcDmQqLp6Z3L35t1Z1GW2TCpIWGSmbYmoSKNJ3JCd1kxMvvqbjNbhkm2+
 npNEbYJFPzIvbdW9Cw9V6g96DNOv3aUk6vgGKPOg/XaGGEe5sT0u43a8RB9ZoAdjeOM8
 yAMw==
X-Gm-Message-State: AOAM530FEvaFdpuzeYZ45eoFUNAOo40aMC8qtTdfrQJhHsodeMKzJhaJ
 QV1iAArMcX9gbDDvOSPsdVL07Q==
X-Google-Smtp-Source: ABdhPJyIuyBitL7hLp3lYEADItoyB6inS+eiwbhxbctCnKxr7SnFOcJm0JEhU1aVBzko/O5qjeTxtA==
X-Received: by 2002:adf:df10:: with SMTP id y16mr2951651wrl.225.1593166852132; 
 Fri, 26 Jun 2020 03:20:52 -0700 (PDT)
Received: from localhost.localdomain
 (lfbn-tou-1-1325-88.w90-89.abo.wanadoo.fr. [90.89.138.88])
 by smtp.gmail.com with ESMTPSA id b17sm26823583wrp.32.2020.06.26.03.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 03:20:51 -0700 (PDT)
Subject: Re: [PATCH] i2c: Match parameters of i2c_start_transfer and
 i2c_send_recv
To: cminyard@mvista.com
References: <20200621145235.9E241745712@zero.eik.bme.hu>
 <20200622213237.GB3258@minyard.net>
From: Fred Konrad <konrad@adacore.com>
Message-ID: <2581492b-3017-37fb-9014-a2f566d4156d@adacore.com>
Date: Fri, 26 Jun 2020 12:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622213237.GB3258@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=konrad@adacore.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Corey,

Le 6/22/20 à 11:32 PM, Corey Minyard a écrit :
> On Sun, Jun 21, 2020 at 04:43:38PM +0200, BALATON Zoltan wrote:
>> These functions have a parameter that decides the direction of
>> transfer but totally confusingly they don't match but inverted sense.
>> To avoid frequent mistakes when using these functions change
>> i2c_send_recv to match i2c_start_transfer. Also use bool in
>> i2c_start_transfer instead of int to match i2c_send_recv.
> 
> Hmm, I have to admit that this is a little better.  Indeed the
> hw/misc/auxbus.c looks suspicious.  I can't imagine that code has ever
> been tested.

Sorry to hear that..., this auxbus stuff is related to the Xilinx Display Port
device, so you may want to CC the MAINTAINERS of the Xilinx Display Port.

Now about the testing, in theory this code is executed when the driver try to 
fetch the EDID from the i2c-ddc device which is connected to it, and you won't
get any framebuffer with an empty EDID.

But this was long ago and I don't have any image anymore to test that today.
CC'ed Edgar, he can probably help with that.

Regards,
Fred

> 
> I don't know the policy on changing an API like this with silent
> semantic changes.  You've gotten all the internal ones; I'm wondering if
> we worry about silently breaking out of tree things.
> 
> I'll pull this into my tree, but hopefully others will comment on this.
> 
> -corey
> 
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> Looks like hw/misc/auxbus.c already got this wrong and calls both
>> i2c_start_transfer and i2c_send_recv with same is_write parameter.
>> Although the name of the is_write variable suggest this may need to be
>> inverted I'm not sure what that value actially means and which usage
>> was correct so I did not touch it. Someone knowing this device might
>> want to review and fix it.
>>
>>   hw/display/sm501.c   |  2 +-
>>   hw/i2c/core.c        | 34 +++++++++++++++++-----------------
>>   hw/i2c/ppc4xx_i2c.c  |  2 +-
>>   include/hw/i2c/i2c.h |  4 ++--
>>   4 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 2db347dcbc..ccd0a6e376 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -1034,7 +1034,7 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
>>                       int i;
>>                       for (i = 0; i <= s->i2c_byte_count; i++) {
>>                           res = i2c_send_recv(s->i2c_bus, &s->i2c_data[i],
>> -                                            !(s->i2c_addr & 1));
>> +                                            s->i2c_addr & 1);
>>                           if (res) {
>>                               s->i2c_status |= SM501_I2C_STATUS_ERROR;
>>                               return;
>> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
>> index 1aac457a2a..c9d01df427 100644
>> --- a/hw/i2c/core.c
>> +++ b/hw/i2c/core.c
>> @@ -91,7 +91,7 @@ int i2c_bus_busy(I2CBus *bus)
>>    * without releasing the bus.  If that fails, the bus is still
>>    * in a transaction.
>>    */
>> -int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
>> +int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv)
>>   {
>>       BusChild *kid;
>>       I2CSlaveClass *sc;
>> @@ -175,26 +175,14 @@ void i2c_end_transfer(I2CBus *bus)
>>       bus->broadcast = false;
>>   }
>>   
>> -int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
>> +int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv)
>>   {
>>       I2CSlaveClass *sc;
>>       I2CSlave *s;
>>       I2CNode *node;
>>       int ret = 0;
>>   
>> -    if (send) {
>> -        QLIST_FOREACH(node, &bus->current_devs, next) {
>> -            s = node->elt;
>> -            sc = I2C_SLAVE_GET_CLASS(s);
>> -            if (sc->send) {
>> -                trace_i2c_send(s->address, *data);
>> -                ret = ret || sc->send(s, *data);
>> -            } else {
>> -                ret = -1;
>> -            }
>> -        }
>> -        return ret ? -1 : 0;
>> -    } else {
>> +    if (recv) {
>>           ret = 0xff;
>>           if (!QLIST_EMPTY(&bus->current_devs) && !bus->broadcast) {
>>               sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)->elt);
>> @@ -206,19 +194,31 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
>>           }
>>           *data = ret;
>>           return 0;
>> +    } else {
>> +        QLIST_FOREACH(node, &bus->current_devs, next) {
>> +            s = node->elt;
>> +            sc = I2C_SLAVE_GET_CLASS(s);
>> +            if (sc->send) {
>> +                trace_i2c_send(s->address, *data);
>> +                ret = ret || sc->send(s, *data);
>> +            } else {
>> +                ret = -1;
>> +            }
>> +        }
>> +        return ret ? -1 : 0;
>>       }
>>   }
>>   
>>   int i2c_send(I2CBus *bus, uint8_t data)
>>   {
>> -    return i2c_send_recv(bus, &data, true);
>> +    return i2c_send_recv(bus, &data, false);
>>   }
>>   
>>   uint8_t i2c_recv(I2CBus *bus)
>>   {
>>       uint8_t data = 0xff;
>>   
>> -    i2c_send_recv(bus, &data, false);
>> +    i2c_send_recv(bus, &data, true);
>>       return data;
>>   }
>>   
>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>> index c0a8e04567..d3899203a4 100644
>> --- a/hw/i2c/ppc4xx_i2c.c
>> +++ b/hw/i2c/ppc4xx_i2c.c
>> @@ -239,7 +239,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
>>                       }
>>                   }
>>                   if (!(i2c->sts & IIC_STS_ERR) &&
>> -                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
>> +                    i2c_send_recv(i2c->bus, &i2c->mdata[i], recv)) {
>>                       i2c->sts |= IIC_STS_ERR;
>>                       i2c->extsts |= IIC_EXTSTS_XFRA;
>>                       break;
>> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
>> index 4117211565..a09ab9230b 100644
>> --- a/include/hw/i2c/i2c.h
>> +++ b/include/hw/i2c/i2c.h
>> @@ -72,10 +72,10 @@ struct I2CBus {
>>   I2CBus *i2c_init_bus(DeviceState *parent, const char *name);
>>   void i2c_set_slave_address(I2CSlave *dev, uint8_t address);
>>   int i2c_bus_busy(I2CBus *bus);
>> -int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv);
>> +int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv);
>>   void i2c_end_transfer(I2CBus *bus);
>>   void i2c_nack(I2CBus *bus);
>> -int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
>> +int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv);
>>   int i2c_send(I2CBus *bus, uint8_t data);
>>   uint8_t i2c_recv(I2CBus *bus);
>>   
>> -- 
>> 2.21.3
>>

