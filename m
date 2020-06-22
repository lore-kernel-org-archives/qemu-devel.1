Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD809C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9457206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIWOUCbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9457206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHwP-0003G9-T9
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnHvH-0002EX-Lb; Mon, 22 Jun 2020 04:35:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnHvF-0001Eh-Sq; Mon, 22 Jun 2020 04:35:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so15754813wru.0;
 Mon, 22 Jun 2020 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W7ARpSzGq8gr+HMKn4ogiy5rgDc+meF5RCspDwpmtXU=;
 b=bIWOUCbvTeKCyXLFDt1L2iDC85VoscueSxjFufTozuUXzmaKdA2ah1GRDtSwRstWJh
 bp83+M1ogXNN0kD1mNkVAJm6AW36RI2NHkF+B4+XQYfDj1LEtssbGUN88+0QPW/O8cui
 N421b9oj2oPR91ZXLzCiIHDVujN2GeJebXYSY5RmdllBikDfF3sbL1nNSQE6gkjElZGL
 8a3HCjrGqhDe1Xsg5nBZ8KT7AhDWgutz0yZ4lS8VEozKU12EvPyVqBMwB8rng2F+pEfz
 J/DF6nciEtTDE/VCljEmZy3TfToK/i4QDEdW1YIYyAf9BfvdNy9sxfsEMvwZvZYFZi7I
 S5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W7ARpSzGq8gr+HMKn4ogiy5rgDc+meF5RCspDwpmtXU=;
 b=LQWGKzoQyFyC50rNdo5tKrCYBTql0t1b/OKlXR5c6BN8NN4dOYj6CNFUC/WLWtGUIa
 RmtEiSi9qElV4n+HcZrEfRnWQwRfmsG1vCTw9by3ti28RncDidWnF9RqYs10Uyw9BadS
 7P2JH2uS64ZfQtzl6A9kFtuuJK9JBTnVEJFor7SrfXNmXal1YdqXyN7fXICSV4xx5tUV
 Vb+g351z0r46mJviLnONoq0DHRSavgTB9f/fXlQf+MIun6sZcyICftElbcYJQPpCDi/m
 9bA/9vcl0S2aSpQje7kWRh4ptvuM4RWbT1rORj1Gm+BcSbdLzoCzKojZKLI+3QdRKSUI
 Vbtw==
X-Gm-Message-State: AOAM5321YS2yz53dLle0UoLuIWM7OHPwBVVWXpvRGm5f85hVnyOnc07B
 QFKsrccn1GZRYD6dA0ydqcw=
X-Google-Smtp-Source: ABdhPJwZvPvBAGXcklXF9Zm44YGRp5Gr/E50mBd0TIsDP0J7aDtPSbuIVP8VWYWOWFBdcM8aowrp9Q==
X-Received: by 2002:adf:e647:: with SMTP id b7mr17830205wrn.170.1592814920053; 
 Mon, 22 Jun 2020 01:35:20 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d13sm3046886wrn.61.2020.06.22.01.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 01:35:19 -0700 (PDT)
Subject: Re: [PATCH v4 6/8] hw/arm/aspeed: Describe each PCA9552 device
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-7-f4bug@amsat.org>
 <38918d0a-272f-c05c-6a03-c6ddd8cc592e@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a046bcd2-1937-d971-8a1c-23fae0dfc9b1@amsat.org>
Date: Mon, 22 Jun 2020 10:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <38918d0a-272f-c05c-6a03-c6ddd8cc592e@kaod.org>
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Markus

On 6/22/20 8:49 AM, Cédric Le Goater wrote:
> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>> We have 2 distinct PCA9552 devices. Set their description
>> to distinguish them when looking at the trace events.
> 
> It's nice and usefull but couldn't we do the same with a QOM object name ?

qdev inherits QOM and overloads it with the qdev_ API.
Since we have a qdev object, isn't it better to use the qdev_ API?

I'd keep the QOM API for bare QOM objects.(I find confusing to use
different APIs).

> 
> C. 
> 
>>
>> Description name taken from:
>> https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/arm/aspeed.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 6b7533aeee..3d5dec4692 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -508,12 +508,15 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>>  {
>>      AspeedSoCState *soc = &bmc->soc;
>>      uint8_t *eeprom_buf = g_malloc0(8 * 1024);
>> +    DeviceState *dev;
>>  
>>      /* Bus 3: TODO bmp280@77 */
>>      /* Bus 3: TODO max31785@52 */
>>      /* Bus 3: TODO dps310@76 */
>> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PCA9552,
>> -                     0x60);
>> +    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
>> +    qdev_prop_set_string(dev, "description", "pca1");
>> +    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3),
>> +                          &error_fatal);
>>  
>>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
>>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
>> @@ -528,8 +531,10 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>>  
>>      smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
>>                            eeprom_buf);
>> -    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_PCA9552,
>> -                     0x60);
>> +    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
>> +    qdev_prop_set_string(dev, "description", "pca0");
>> +    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11),
>> +                          &error_fatal);
>>      /* Bus 11: TODO ucd90160@64 */
>>  }
>>  
>>
> 
> 

