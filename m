Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59FDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB98206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiHCyBKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB98206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHyB-0004Xb-VX
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnHxW-0003me-UB; Mon, 22 Jun 2020 04:37:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnHxV-0001bw-CJ; Mon, 22 Jun 2020 04:37:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id a6so13775060wrm.4;
 Mon, 22 Jun 2020 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HqPLRcvm+n/38+Y+FSi/EkoZ0IfGdv4LsKsyqNHMlFU=;
 b=LiHCyBKv6ak7qivAtx8VyaboILedUSw/UaQuxspbkp/VxpQ3x4YnAfsw7JWNcYju/H
 anykXyQ3/X7HPcdMT4lSSbIHbAKpoVIi1Eilm+rZNUpyvnWrszKilZDWZ81g/vAVNlP/
 F+FEROYnFgkq8F40zoBdrEiAvn/2NDyJTXVcH/y+vX5TCFAN+TNT3WYH1LqU2TlG4glw
 G38IVy0+EUPmQQlOzam8SUesgvZvk9vB1Htm6KJK9qbF43ftn6RCld2EgafObjrFTogg
 5DTdyMlpJ9L9Q6rSgS0iWtwDBFc0ye3vYPRNXTtfiDg76SxXRiz7jNB/sFMx9+tMnZ8P
 mfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HqPLRcvm+n/38+Y+FSi/EkoZ0IfGdv4LsKsyqNHMlFU=;
 b=a6Y3zYwoLdBktCddWs4BSVW4F14gkq8gBb21EZMS18B7twwLQiXxN77pKsRkYxyUqb
 6er4XpDE+Gj6GGEXmIkUUWAREjkEfEKkV5TT7a5XG2CvsPKqZ4c7h3iOvyT89r1Olw4X
 yjpaHGhNR3hOuuy+6eMrKHZdlvQUfaY0vr++41aRxCQF/3B92juj6Orq97FEhEc/SjD8
 AdVVGc3FodakLfgDYD1gCkuNGuyhHhkbCiYbh7dMkJPseXnnIzwhimUchdjRQnPrqL/W
 B3mawO9SYzRoJYSNHWLBUKOQOeHMMk64pKpoSDdOWcAdHc+FofRnJBAJJ9XwG3M4ufak
 j7Jg==
X-Gm-Message-State: AOAM532eeTR1+R+vNMw6+nz/sRR+apcN5hxYrjJSCm5sGB7JCJjeatt7
 tZHi21G2jL6oMqkn9PjJABo=
X-Google-Smtp-Source: ABdhPJz6sO0aBZTuthxt6fSRebgEO1ahsOPvKw2UNZ6PU6SMTYg3PghL+UmeSUkpzaoidk11nLhGVg==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr2189385wru.321.1592815059511; 
 Mon, 22 Jun 2020 01:37:39 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id e8sm14992213wrv.24.2020.06.22.01.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 01:37:38 -0700 (PDT)
Subject: Re: [PATCH v4 3/8] hw/misc/pca9552: Use the PCA9552_PIN_COUNT
 definition
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-4-f4bug@amsat.org>
 <4628bf30-9b56-a470-afc2-f140690cc002@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5ced6f5-f1fb-bbc2-8f64-d5d55fe8a7df@amsat.org>
Date: Mon, 22 Jun 2020 10:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4628bf30-9b56-a470-afc2-f140690cc002@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

On 6/22/20 8:25 AM, Cédric Le Goater wrote:
> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>> The current code models the PCA9552, but there are comments
>> saying the code could be easily adapted for the rest of the
>> PCA955x family.
>> Since we assume we have at most 16 pins (for the PCA9552),
>> add a definition and check the instance doesn't use more than
>> this number. This makes the code a bit safer in case other
>> PCA955x devices are added.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> I would introduce a PCA9552Class and move nr_leds under the class.

A bit excessive (for now) for the hobbyist time I can dedicate
to this, but I'll try (also renaming nr_leds -> nr_pins).

> 
> C. 
> 
> 
>> ---
>>  hw/misc/pca9552.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>> index cfefb8fce8..b97fc2893c 100644
>> --- a/hw/misc/pca9552.c
>> +++ b/hw/misc/pca9552.c
>> @@ -303,6 +303,17 @@ static void pca9552_initfn(Object *obj)
>>      }
>>  }
>>  
>> +static void pca9552_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PCA9552State *s = PCA9552(dev);
>> +
>> +    if (s->nr_leds > PCA9552_PIN_COUNT) {
>> +        error_setg(errp, "%s invalid led count %u (max: %u)",
>> +                   __func__, s->nr_leds, PCA9552_PIN_COUNT);
>> +        return;
>> +    }
>> +}
>> +
>>  static void pca9552_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -311,6 +322,7 @@ static void pca9552_class_init(ObjectClass *klass, void *data)
>>      k->event = pca9552_event;
>>      k->recv = pca9552_recv;
>>      k->send = pca9552_send;
>> +    dc->realize = pca9552_realize;
>>      dc->reset = pca9552_reset;
>>      dc->vmsd = &pca9552_vmstate;
>>  }
>>
> 
> 

