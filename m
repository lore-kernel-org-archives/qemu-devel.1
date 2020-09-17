Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114FCC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2FC206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM/T/F69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2FC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxJ0-0004XR-FZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIxE6-0007hd-Cp; Thu, 17 Sep 2020 12:57:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIxE3-0004ok-Ic; Thu, 17 Sep 2020 12:57:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id k18so2763811wmj.5;
 Thu, 17 Sep 2020 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6QaMg1AvMw1pue6iNBZDZCiuxftSbFxqP2NNoQR16oU=;
 b=hM/T/F69PEgcWCYjroOjIIv7bfZwEtWdAfXh75vdxaA5lTCXR2DPwxKQAW96Ga0jkW
 XEn2HHqL3uzH433I9Mzod2BDcTfdpChn01KM+SUmP6ELOrDMJRtfl3qD/PFPtr40oaQg
 gJnF4IlmVu7+TSf3wBAxxlpB8OvPQ/dqQwfsj6PnAh7fayYGQbTyROi1G5C5xj+eYBS4
 QXTat0uM3CeNGww+trqHVwSe7gitmOfa+UklCInduE5lO8HM1FCq4LLDKBeoCXeCZrlx
 aLaREZQ+J5cqY5lPmY0l2ZoheT+y160345KZ5dojBOwYF9ajENagzFlw+3b3cIto/Bdt
 jW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6QaMg1AvMw1pue6iNBZDZCiuxftSbFxqP2NNoQR16oU=;
 b=qqyrfJYX6uvde0faaFBz6ld0SVKjr/uWmnP0QpATElLp+Kap+gNh2m0mFHoG1VnYQF
 ctMgxWTHAtMDos3wcCvzMzZIzwShD5zc16UB8KAOSPjdQVxaze3nmTUtAaOUKjlQUPHx
 ftHatruVyrv/DWisOIH2L2+hFaqU0ocxuQc+fSCbLIM13dFsT2qwnVPwu3InAsHMd50Q
 /WSUMTAcgOUjM1xsaNB8tj5T5rilC8XlBLRFm8gxsYC+WQ3rifpOCb8YSc/609CZdjqC
 su9CMfqQXj8Na871pTGJ1vIJkteKn86/1FPTnzIKsW3GoXvNgyMUXckQ0J9vIRCT0ukv
 XXvg==
X-Gm-Message-State: AOAM5314uMV03dGefONuu6UJnYx8w201vhglSOULIaYH1dA16pgJCEsx
 vhoFRcI1gOWDIbZClLtcJJI=
X-Google-Smtp-Source: ABdhPJyV1vhri3vaIpNnRnwVkKpUFg8xhQSJ/NHIO0jV0HpfYmBYkZtpAOMTcmpSdSJuU21PGqXd/w==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr10470848wmj.23.1600361857453; 
 Thu, 17 Sep 2020 09:57:37 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y6sm195832wrt.80.2020.09.17.09.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 09:57:36 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/aspeed: Map the UART5 device unconditionally
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200905212415.760452-1-f4bug@amsat.org>
 <e640309b-b694-e815-d64d-40dd453e52ef@amsat.org>
 <5e27c1f9-6d11-fa62-ba71-0020ce9d595b@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <07b21d1d-fb5b-efb0-50f2-54a4b86df444@amsat.org>
Date: Thu, 17 Sep 2020 18:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5e27c1f9-6d11-fa62-ba71-0020ce9d595b@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 7:51 AM, Cédric Le Goater wrote:
> On 9/15/20 7:23 PM, Philippe Mathieu-Daudé wrote:
>> ping?
> 
> It's reviewed : 
> 
>   http://patchwork.ozlabs.org/project/qemu-devel/patch/20200905212415.760452-1-f4bug@amsat.org/
> 

Yes I know :) This is part of my routine to check if a
patch hasn't been confirmed to be queued 1 week after the
last review, to ping the maintainer (because some
automatically flush patches older than 1month in their
mailbox).

> I will send a PR when I have more patches.

Ah OK. I didn't know you would keep merging the Aspeed
patches. Since this was a single patch, I thought it would
go via the usual qemu-arm queue from Peter.

No rush, I just wanted to be sure the patch was not lost.
Also, once a patch is queued, I understand it is the
maintainer responsibility to keep rebasing the patch
queued.

Thanks!

Phil.

> 
> Thanks,
> 
> C. 
> 
>> On 9/5/20 11:24 PM, Philippe Mathieu-Daudé wrote:
>>> The UART5 is present on the machine regardless there is a
>>> character device connected to it. Map it unconditionally.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  hw/arm/aspeed_ast2600.c | 8 +++-----
>>>  hw/arm/aspeed_soc.c     | 8 +++-----
>>>  2 files changed, 6 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
>>> index 9d95e421435..1450bde7cf2 100644
>>> --- a/hw/arm/aspeed_ast2600.c
>>> +++ b/hw/arm/aspeed_ast2600.c
>>> @@ -325,11 +325,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>>>      }
>>>  
>>>      /* UART - attach an 8250 to the IO space as our UART5 */
>>> -    if (serial_hd(0)) {
>>> -        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_DEV_UART5);
>>> -        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
>>> -                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>>> -    }
>>> +    serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
>>> +                   aspeed_soc_get_irq(s, ASPEED_DEV_UART5),
>>> +                   38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>>>  
>>>      /* I2C */
>>>      object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
>>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>>> index 35be126db6f..7eefd54ac07 100644
>>> --- a/hw/arm/aspeed_soc.c
>>> +++ b/hw/arm/aspeed_soc.c
>>> @@ -283,11 +283,9 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>>>      }
>>>  
>>>      /* UART - attach an 8250 to the IO space as our UART5 */
>>> -    if (serial_hd(0)) {
>>> -        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_DEV_UART5);
>>> -        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
>>> -                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>>> -    }
>>> +    serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
>>> +                   aspeed_soc_get_irq(s, ASPEED_DEV_UART5), 38400,
>>> +                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
>>>  
>>>      /* I2C */
>>>      object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
>>>
> 
> 

