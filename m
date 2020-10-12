Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5AEC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB4021655
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOI07ySw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB4021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwZ7-00059i-Ks
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRwWQ-0002Pn-4N; Mon, 12 Oct 2020 08:01:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRwWO-0002B1-8L; Mon, 12 Oct 2020 08:01:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id d81so16949988wmc.1;
 Mon, 12 Oct 2020 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6QR6d3zy6MQYEcou36efqNc5AUNkJxoiFHbV+BKd1Po=;
 b=YOI07ySwa7DI8kdf81y4igq4U8/uzmL7mjI6o5bN9pWNYzxNo0HZMSjVF7OFxd2Z2i
 yhCmvBEkH8GrQ4xj0dudTDXgxFpxemBMed9EsKkXZrbSQ3IiHZn0XsU9jnj2c4md48qM
 31VCmjOTbitVFRuAtXt4qdlDAqTWD4giWHKlHq931+KIdBkhME+9HYdR9RAnu96DGBQ8
 zdv0h1KbuAs69ApZcff5VImLW8b03yMQWMFrn4/v2fKV+psdvhTPhpe3/SzhBVYqGmjJ
 hkjc+BM1MwqY5rzp5Wu7Y0jEQ4+v7ks3BffYnzdVrlR28t4E/t5XqWzsWZsZRJi6VM63
 2w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6QR6d3zy6MQYEcou36efqNc5AUNkJxoiFHbV+BKd1Po=;
 b=k/r7TV/N5L89pMPwK7Igw5L2QHTxBZeA9mbHLc/KrDfoTkx44H43owJ6u/iI09wsAx
 RCn686ikkYHBvOLiLJpQtwyScxZ978fYpIbjbCXJPKPFUu7f0Bhfw1c2hvxTEXU9SQbO
 6LvpJmV8Jw8MBc+K2i3iEmMI0DBXmIztnp/ku9g0F+3P6O1s4XMBYpRnrfBFm5eCme1C
 npVb5mW5doQgjDnd9lnDdyBBMdDvrtWliAN+sUL+lrkU0rqtereWlqitOj46spnxXgHU
 cGXfuQ7+98gtK4DAa+Ga086w7MMVTXwZt52p2vtQsE5cRRy8tb2GXlr1gqglK6MM+nbc
 wPXA==
X-Gm-Message-State: AOAM533z2ZU25ExFW5AXSY0Sf+ztvpm+ZwNSKlOuXTOg5D/Rrr/CitPI
 8fOR8bwC2iws4qodnKLNuKU=
X-Google-Smtp-Source: ABdhPJx3MEDik0kDKsrZr6M8ZDpNQVmBQi/3NjuV8wAK+5TNTBRONR5GilE0L5ZUL+z0PjAo+5Kqjw==
X-Received: by 2002:a1c:cc07:: with SMTP id h7mr11040150wmb.55.1602504102203; 
 Mon, 12 Oct 2020 05:01:42 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j5sm19194458wrx.88.2020.10.12.05.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 05:01:41 -0700 (PDT)
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <85549ebe-6644-3c45-0e56-e4d5c509ea80@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <16a5dc5f-0ae9-b513-3579-6839a2db6cc6@amsat.org>
Date: Mon, 12 Oct 2020 14:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <85549ebe-6644-3c45-0e56-e4d5c509ea80@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 11:23 AM, Mark Cave-Ayland wrote:
> On 11/10/2020 20:03, Philippe Mathieu-Daudé wrote:
> 
>> The Grackle PCI host model expects the interrupt controller
>> being set, but does not verify it is present. Add a check to
>> help developers using this model.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/grackle.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
>> index 57c29b20afb..20361d215ca 100644
>> --- a/hw/pci-host/grackle.c
>> +++ b/hw/pci-host/grackle.c
>> @@ -76,6 +76,10 @@ static void grackle_realize(DeviceState *dev, Error **errp)
>>       GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
>>       PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>>   
>> +    if (!s->pic) {
>> +        error_setg(errp, TYPE_GRACKLE_PCI_HOST_BRIDGE ": 'pic' link not set");
>> +        return;
>> +    }
>>       phb->bus = pci_register_root_bus(dev, NULL,
>>                                        pci_grackle_set_irq,
>>                                        pci_grackle_map_irq,
> 
> Reviewing this now, my feeling is that both grackle and uninorth are doing the wrong
> thing here by passing in a link to the PIC - certainly if I had written this more
> recently than I originally did, I would simply use qdev_init_gpio_out() for the IRQ
> lines and do the wiring during machine init.
> 
> I've got a few other things to look at first, but I'll post a patchset later which I
> think will improve this for both Mac machines.

Awesome, thanks!

> 
> 
> ATB,
> 
> Mark.
> 

