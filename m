Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C66C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BC5206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nky1AEN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BC5206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRvbK-000426-SP
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRvaf-0003Vj-2X; Mon, 12 Oct 2020 07:02:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRvad-00034N-8N; Mon, 12 Oct 2020 07:02:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so18687208wrq.2;
 Mon, 12 Oct 2020 04:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y/Iy7sMkFYxzvmVsKnIfiRvV3NZm3u3EHnwDPaf7NIY=;
 b=Nky1AEN/MpxvQrtM68uD9XZsyQb2XPbg6NATn5bcQEvZVdzhFAdEumjLorcJSd13LW
 PE4oKU3bNwzxWAKYWbsVrYacMuij2FuGjunRqdiKkdjTJeD1H6N9y+VJOec52QiuurMv
 BIK+dMr+ngQ7wwaS94D3P4a0Ll8gHTW5JxwLM9UXP0Sqz2OZJwvlSwpt0bT2B+R42iFG
 shHoRuWqm3r2bqsTcFNVXkQRFuoO5lRfyFod0mOWGo31oldlyIqGPA0pqUJCtadskG4P
 OSKI4H+HeN6rcJpNuyQBxYoAhwQvMLmyXTeZE0DdS5L7WwuEzkWV2X4W3QimpYSE6dC6
 YlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y/Iy7sMkFYxzvmVsKnIfiRvV3NZm3u3EHnwDPaf7NIY=;
 b=n944iTf7jVPNZJBjdNvTQfdNguzfIzPiRZ0AA8WsAdUVHnJunAy4JqsORYXvWr6mhq
 95zAWoSZJIZb7DW+8tuMuupQwSHNfnA8FLC4vHgCa4DT1K4No6ayf4WqLReG8JgVzEA5
 tLrWMLV4SgAkoASom7G33jGiBw8epGkBGd5X0iFdlyBbUzb8yjP5KcmOda7ch1bq6E+t
 PxW6wPN+ZEHSchF/gULI6PUZ+syei0q4bQBfc3jO7TlUi+R3tn8+/SMns9CaUr+Y5JC1
 RdsN+KL3vsZUmBXbT5WxA4X9b+XBUdtA5m/Q58K0XvqfwrxFQojBpyiH1DfitTpCIZh7
 chAg==
X-Gm-Message-State: AOAM530rAyvnHfSDCFP/215ZMsV7qRBL5qywyurZ8CceE7n2SeS8zy5S
 TJAeKp4r7zvTInzV7choqZo=
X-Google-Smtp-Source: ABdhPJxDW2Dj2Pr1aSdzuLiA71w1hMEKYd+y2nIA3V2BLwXGi+Lp33No11prbbTuVPYPXihIHYDClg==
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr28060010wrx.278.1602500520335; 
 Mon, 12 Oct 2020 04:02:00 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m11sm22794913wmf.10.2020.10.12.04.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 04:01:59 -0700 (PDT)
Subject: Re: [PATCH 3/4] hw/pci-host/prep: Fix PCI swizzling in map_irq()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20201012071906.3301481-1-f4bug@amsat.org>
 <20201012071906.3301481-4-f4bug@amsat.org>
 <f8d454a6-2b1c-cef0-ec95-4046e1479843@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0a3e4451-ecdf-ff46-bb32-cf1eda724bd1@amsat.org>
Date: Mon, 12 Oct 2020 13:01:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f8d454a6-2b1c-cef0-ec95-4046e1479843@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Jocelyn Mayer <l_indien@magic.fr>, Julian Seward <julian@valgrind.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 11:37 AM, Mark Cave-Ayland wrote:
> On 12/10/2020 08:19, Philippe Mathieu-Daudé wrote:
> 
>> In commit a01d8cadadf we changed the number of IRQs to 4 but
>> forgot to update the map_irq() function. Do it now.
>>
>> Fixes: a01d8cadadf ("Fix memory corruption ... in PreP emulation")
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Cc: Jocelyn Mayer <l_indien@magic.fr>
>> Cc: Julian Seward <julian@valgrind.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/prep.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
>> index 064593d1e52..2224135fedb 100644
>> --- a/hw/pci-host/prep.c
>> +++ b/hw/pci-host/prep.c
>> @@ -195,7 +195,7 @@ static const MemoryRegionOps raven_io_ops = {
>>   
>>   static int raven_map_irq(PCIDevice *pci_dev, int irq_num)
>>   {
>> -    return (irq_num + (pci_dev->devfn >> 3)) & 1;
>> +    return (irq_num + (pci_dev->devfn >> 3)) & 3;
>>   }
>>   
>>   static void raven_set_irq(void *opaque, int irq_num, int level)
> 
> It feels like this should also have a corresponding change in OpenBIOS for
> consistency, even though technically because of the OR on IRQ 15 it doesn't really
> matter. The relevant part in OpenBIOS can be found here:
> https://git.qemu.org/?p=openbios.git;a=blob;f=drivers/pci.c;h=34ae69a907b6312a3a7ab218afe8ba9efded1df7;hb=7f28286f5cb1ca682e3ba0a8706d8884f12bc49e#l2001
> and in particular this section:
> 
>      /* Use the same "physical" routing as QEMU's raven_map_irq() although
>         ultimately all 4 PCI interrupts are ORd to IRQ 15 as indicated
>         by the PReP specification */
>      props[(*ncells)++] = arch->irqs[((intno - 1) + (addr >> 11)) & 1];

Done:
https://github.com/openbios/openbios/pull/7

> 
> 
> ATB,
> 
> Mark.
> 

