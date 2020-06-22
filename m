Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D22FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB841206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLV1jys8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB841206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHsP-00005R-3M
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnHrV-0007ci-PJ; Mon, 22 Jun 2020 04:31:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnHrU-0000f9-5X; Mon, 22 Jun 2020 04:31:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so15738894wrc.7;
 Mon, 22 Jun 2020 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kdXXfZC8l+qXSRdThp7+fN6/Kq9u8ORLvCJNOSYI5ws=;
 b=WLV1jys8Q7hoQ0oAjeyGiUrazea0PPnu1TcZ/BUQmmN2Me64DFCwwNRSSPzss/2hYD
 je/8O225jTQf+Ci02fsBv7JTIw2/LXmKrLtS6PN3rQmtnLVzOp+cp5rANZ2f05BwNrjt
 QJHptpG+6PNzRKMm1w405xlRfngphl02RKBhGo9zeCueEt6QJ6BJ8Y38HEQq4/vAFawN
 2zG+Cj8Iv4Wn1okC51oSFSFTp+uUWrsq5gGnLP66fJvd0VO1UPSRhiOgng8M17VL52dP
 osr4cgWehREYUyu/8xD1D5lX7d54Hre84i8VUqGg+m5Hfmgu6cTNbBas1XoQw8xgAdBv
 dhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kdXXfZC8l+qXSRdThp7+fN6/Kq9u8ORLvCJNOSYI5ws=;
 b=BzwUlD+fQGHA2thH1Zag52PNIgBALC9kd7uItq/gT+KghILg2LdFlSts6QedNSGtem
 52BIp8cwYgCmFka7EROg2QEVZgEVmEkwDolvMjW7wQBeDULhi0xQwEPY+hKazyVTcooC
 dKSthKlpwsMwP8Cq10PqlX88F/ifZ8SQibGzillX+Bv4lEDvat2/n3yrD9gHX2ZTbPrT
 EyWjOrNrCv+7c4Rx+xtavVvM6tAcH/catZeBcEOXEDW64Q+FkWSHa5UEhtVJSLvfEgiQ
 HZrId3hLrFkxcy1vdIYv7sURvGghv5OxosnmsjTNQY4yTh+AHZzVTxgSrsseQyvtmUZC
 xPvQ==
X-Gm-Message-State: AOAM533oZ5XbxTZyTp6Nh8Wg009CfH3r3bSKX3KJ71DecKo2njMgRv5t
 F9cPvcu23TBuJAK19JHMSbU=
X-Google-Smtp-Source: ABdhPJyB0yZ+0pBnTxke1nz+WZjC9KWI8pVM1xaMwk01fgy1Whf9p3Nl6IRPdwrT5IBL7RS2k2s/Eg==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr14895973wrq.401.1592814686232; 
 Mon, 22 Jun 2020 01:31:26 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 125sm16593713wmc.23.2020.06.22.01.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 01:31:25 -0700 (PDT)
Subject: Re: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-5-f4bug@amsat.org>
 <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
Date: Mon, 22 Jun 2020 10:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
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

On 6/22/20 8:27 AM, Cédric Le Goater wrote:
> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>> Add a description field to distinguish between multiple devices.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> Could it be a QOM attribute ? 

What do you call a 'QOM attribute'?
Is it what qdev properties implement?
(in this case via DEFINE_PROP_STRING).

> 
> C.
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/misc/pca9552.h |  1 +
>>  hw/misc/pca9552.c         | 10 ++++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
>> index ef6da4988f..c5be7f1c5e 100644
>> --- a/include/hw/misc/pca9552.h
>> +++ b/include/hw/misc/pca9552.h
>> @@ -27,6 +27,7 @@ typedef struct PCA9552State {
>>  
>>      uint8_t regs[PCA9552_NR_REGS];
>>      uint8_t max_reg;
>> +    char *description; /* For debugging purpose only */
>>      uint8_t nr_leds;
>>  } PCA9552State;
>>  
>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>> index b97fc2893c..54ccdcf6d4 100644
>> --- a/hw/misc/pca9552.c
>> +++ b/hw/misc/pca9552.c
>> @@ -12,6 +12,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu/log.h"
>>  #include "qemu/module.h"
>> +#include "hw/qdev-properties.h"
>>  #include "hw/misc/pca9552.h"
>>  #include "hw/misc/pca9552_regs.h"
>>  #include "migration/vmstate.h"
>> @@ -312,8 +313,16 @@ static void pca9552_realize(DeviceState *dev, Error **errp)
>>                     __func__, s->nr_leds, PCA9552_PIN_COUNT);
>>          return;
>>      }
>> +    if (!s->description) {
>> +        s->description = g_strdup("pca-unspecified");
>> +    }
>>  }
>>  
>> +static Property pca9552_properties[] = {
>> +    DEFINE_PROP_STRING("description", PCA9552State, description),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>>  static void pca9552_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -325,6 +334,7 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
>>      dc->realize = pca9552_realize;
>>      dc->reset = pca9552_reset;
>>      dc->vmsd = &pca9552_vmstate;
>> +    device_class_set_props(dc, pca9552_properties);
>>  }
>>  
>>  static const TypeInfo pca9552_info = {
>>
> 
> 

