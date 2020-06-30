Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A01206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYxT3Eo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A01206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBfm-0006FW-8c
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBeG-0004gr-8F; Tue, 30 Jun 2020 04:29:48 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:34581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBeE-0005iK-HI; Tue, 30 Jun 2020 04:29:47 -0400
Received: by mail-ej1-x644.google.com with SMTP id y10so19652795eje.1;
 Tue, 30 Jun 2020 01:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VLB9KdGPiTGQMkdwrnwOKpJ+SdzWfT9IkNjDXiY1yEE=;
 b=AYxT3Eo+1UXnUTkgrXYPMdliIMw3nQx7oqI52mMrJUf0DSLCHQzG10ar/r8mG66o4s
 zFYPprTDK5983h5hnsAORTfWMERC0j6ecyADxqp4YAGNMzMcr3fjLpFNlwC7HdeUMNfP
 hc2uAXDgbCvvSyhONZL7vbszGtYsJe5wNrcCysuTABcHM8GVC7rzepykZp/wzuSqs7HO
 wAZ0dIwbEEYWBqyxJIDo1RglWvm84ZkuapwVeIok14fqSTjHapW/90Dezr6jZjY6gQJm
 rxZh+/cDxzW/DfcBXlkFForuep4cv/WDP5RdP6lDqOWlalK0KsycyZuBPHN0bNiRxL7c
 SO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VLB9KdGPiTGQMkdwrnwOKpJ+SdzWfT9IkNjDXiY1yEE=;
 b=E/jfM//bUn4PWEQfCewPspQHJhp9PHUFlUSlpEUDIu5ZFmyXbmZC0PWcnx8Rmdp4Pr
 mJ5gtIj1KytPyzzB57kMDBliqjV/UmX0paCJ5nSoI5PA16num5oozNdTDTFwgz2Issxu
 vznNvfTlb64k0Uusn0HOR74gjSJ+s+7zn7XWZqQP5z/EPLDc2o0Pn9pQFM2BzjpZ36HO
 VRwcamgYUf93g+4Umg77b5ZBB0a6iL2f9mGnDkAsKv8kyrTg2+Birf48IhwwxR0k4y6P
 6hApOhxsm0xXRR9Eg/LY3MQIq1GJYYqaW2ZBSJV+zuWfxfgTBA9WRiSMvkl87Y8d4Ywf
 2anQ==
X-Gm-Message-State: AOAM531w8XzU/rC7MXCT97Rysqo3xHvx/7v/BmQYL5GOPRrdLgsQVTrI
 ylaeDKTAAg4f2C8Bw7dhz2E=
X-Google-Smtp-Source: ABdhPJw+pFs6cjYW0XnJplgIquh46j2lw9bHdJdcWE2d8QvUFmpcjWzVYgE1dOdBQK+19pW+JqgY4g==
X-Received: by 2002:a17:906:c056:: with SMTP id
 bm22mr7653641ejb.444.1593505784134; 
 Tue, 30 Jun 2020 01:29:44 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g21sm2095590edu.2.2020.06.30.01.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 01:29:43 -0700 (PDT)
Subject: Re: [PATCH 2/5] hw/i2c: Rename i2c_try_create_slave() as
 i2c_slave_new()
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-3-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006292333540.63145@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0b7730a8-bd1d-9104-9a48-5daecaa6b940@amsat.org>
Date: Tue, 30 Jun 2020 10:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006292333540.63145@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 11:37 PM, BALATON Zoltan wrote:
> On Mon, 29 Jun 2020, Philippe Mathieu-Daudé wrote:
>> We use "new" names for functions that allocate and initialize
>> device objects: pci_new(), isa_new(), usb_new().
>> Let's call this one i2c_slave_new(). Since we have to update
>> all the callers, also let it return a I2CSlave object.
> 
> All the callers now need a cast due to change to I2CSlave * instead of
> what they expect. Does that really worth it? Also this introduces
> inconsistency between i2c_create_slave and i2c_new so not sure about
> that part but I don't really mind either way. Maybe return what most
> callers expect so the calls are simple and don't need an additional cast
> in most of the cases?

You are right that the code guidance is not clear regarding what
qdev_foo_new() should return.

Working on another object (LEDs) Richard suggested me to return
the full type, so I understood it was the recommended default:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg714729.html

> 
> Regards,
> BALATON Zoltan
> 
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> include/hw/i2c/i2c.h | 2 +-
>> hw/arm/aspeed.c      | 4 ++--
>> hw/i2c/core.c        | 9 ++++-----
>> 3 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
>> index d6e3d85faf..18efc668f1 100644
>> --- a/include/hw/i2c/i2c.h
>> +++ b/include/hw/i2c/i2c.h
>> @@ -79,8 +79,8 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool
>> send);
>> int i2c_send(I2CBus *bus, uint8_t data);
>> uint8_t i2c_recv(I2CBus *bus);
>>
>> +I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>> DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t
>> addr);
>> -DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
>> bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
>>
>> /* lm832x.c */
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 1285bf82c0..54ca36e0b6 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -513,7 +513,7 @@ static void
>> witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>>     /* Bus 3: TODO bmp280@77 */
>>     /* Bus 3: TODO max31785@52 */
>>     /* Bus 3: TODO dps310@76 */
>> -    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
>> +    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
>>     qdev_prop_set_string(dev, "description", "pca1");
>>     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 3),
>>                           &error_fatal);
>> @@ -531,7 +531,7 @@ static void
>> witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>>
>>     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>>                           eeprom_buf);
>> -    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
>> +    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
>>     qdev_prop_set_string(dev, "description", "pca0");
>>     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 11),
>>                           &error_fatal);
>> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
>> index acf34a12d6..6eacb4a463 100644
>> --- a/hw/i2c/core.c
>> +++ b/hw/i2c/core.c
>> @@ -267,13 +267,13 @@ const VMStateDescription vmstate_i2c_slave = {
>>     }
>> };
>>
>> -DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
>> +I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
>> {
>>     DeviceState *dev;
>>
>>     dev = qdev_new(name);
>>     qdev_prop_set_uint8(dev, "address", addr);
>> -    return dev;
>> +    return I2C_SLAVE(dev);
>> }
>>
>> bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
>> @@ -283,10 +283,9 @@ bool i2c_realize_and_unref(DeviceState *dev,
>> I2CBus *bus, Error **errp)
>>
>> DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t
>> addr)
>> {
>> -    DeviceState *dev;
>> +    DeviceState *dev = DEVICE(i2c_slave_new(name, addr));
>>
>> -    dev = i2c_try_create_slave(name, addr);
>> -    i2c_realize_and_unref(dev, bus, &error_fatal);
>> +    i2c_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
>>
>>     return dev;
>> }
>>

