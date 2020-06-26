Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E736CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F222067D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du8Y45h+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F222067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopLL-0002v7-W5
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jopJP-0001CT-Jn; Fri, 26 Jun 2020 10:26:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jopJO-0002Ip-2g; Fri, 26 Jun 2020 10:26:39 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so9018371wmg.1;
 Fri, 26 Jun 2020 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a+4BIaAmzumkK8oIJ5s3CLD4zDdPi1t/e6IFA4OGKoc=;
 b=Du8Y45h+4QtSd80HsPO/pV7vN8rFmnw5kRNBXQu+fNhY83iMPx4DKoe08z/hYfdLu3
 h5RoJ/BHJmJ/NLy5m+GIkaPGBx3iTfq120La1a4BhK/7ozUIrjKIYB4HXOOQ4soDpcqF
 mBreHWc61xHxv4ljiRjw4myY4vWAhjUFhr5OHAjLkjUHKqcgEykhAXCxyocv+sOQFmuh
 EVZBLtIBvxTCR+OmvfSan3hsK+I2KRFcxUpEzVXowHD6hzzvV295MLF8z4uNsZAV6Nv1
 U7GRjJR77Jb+ZJzeRdebuU53HjZ8rNbP04XH2B20H/IIaH+sMrH/z1EY7ctw537EffMK
 Z35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a+4BIaAmzumkK8oIJ5s3CLD4zDdPi1t/e6IFA4OGKoc=;
 b=SuRQQkLu3y5b0//nPVj9KOnk5Hzaktr7S4B8lzwVi7ZG1asFmTBRXHK6/72De5IhBi
 WNn8gUdrybIaWDlnma8p+OE86+wXmVFOU40/PbEjfvUWs2thrWv4EApRzGOsOhNpAMJt
 kMj3oMs4MwlPH5PM4nusi/75dScjqyhaep1uYAUwF2FFVw5POV8+sFY6fZytFM1sk6xT
 TvCwWe5hL7SjaHIzgp7OdwlaaajwmT2vELBxnqRYFIN57IkyCLeSAPQYJeC5tqsAE46Q
 HQD0OX5SYal/dFa8zyI5HtQgS5XEKG/2sbZ/HiLqpDZ3YDrMrsP0M3GR1oeqiJ9OyQiK
 Z1zA==
X-Gm-Message-State: AOAM530T++Df8FypV46gDyHZ2NKCQZU3T9/dkL8720Hjc34FAEH4aAaA
 qd5KEw7OgyGHTq31mKCKn3E=
X-Google-Smtp-Source: ABdhPJyN1dskcImBD07NWgMJf+NOsT8SYeynhgt+6554H0UpckvE+Dz4dBj2R6IdOJeSNPx5oYMeHA==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr3655497wml.36.1593181595611; 
 Fri, 26 Jun 2020 07:26:35 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id e5sm37126818wrs.33.2020.06.26.07.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 07:26:34 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] hw/i2c/smbus_eeprom: Add description based on
 child name
To: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-3-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261255120.94870@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5895e827-68e9-8204-aeba-e066d8c0d680@amsat.org>
Date: Fri, 26 Jun 2020 16:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006261255120.94870@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 1:00 PM, BALATON Zoltan wrote:
> On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> hw/i2c/smbus_eeprom.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index 879fd7c416..22ba7b20d4 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -47,6 +47,7 @@ typedef struct SMBusEEPROMDevice {
>>     uint8_t *init_data;
>>     uint8_t offset;
>>     bool accessed;
>> +    char *description;
>> } SMBusEEPROMDevice;
>>
>> static uint8_t eeprom_receive_byte(SMBusDevice *dev)
>> @@ -134,7 +135,9 @@ static void smbus_eeprom_realize(DeviceState *dev,
>> Error **errp)
>>     smbus_eeprom_reset(dev);
>>     if (eeprom->init_data == NULL) {
>>         error_setg(errp, "init_data cannot be NULL");
>> +        return;
>>     }
>> +    eeprom->description =
>> object_get_canonical_path_component(OBJECT(dev));
>> }
>>
>> static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
> 
> What is this for? Shouldn't this description field be in some parent
> object and whatever wants to print it could use the
> object_get_canonical_path_component() as default value if it's not set
> instead of adding more boiler plate to every object?

You are right, if we want to use this field generically, it should be
a static Object field. I'll defer that question to Eduardo/Markus.

> 
> Regards,
> BALATON Zoltan

