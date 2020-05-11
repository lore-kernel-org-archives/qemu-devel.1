Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F6C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8FB207DD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuxc3EKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8FB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY1zS-0005cX-24
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY1xo-00058d-0V
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:30:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY1xn-0006FH-9F
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:30:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id 50so8814461wrc.11
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=quIFR6mhP1x3onKdwu+UFr2o1QVXyu3HI0oYKF2760A=;
 b=Nuxc3EKKo42I/zTJTKgOJYXVPaZbReHov6TkTXi/4XYJboY3wb4Nvv0dAjUp2HLZBh
 KtXpcgG+yFFlhYVpTPIPYcL672pQvQvC9X3B4Ve6ggX9Yd3qM/WHKlkcJD8x4lyR9UOC
 ni1HFM9WiozSguaem6ZxjDIw95XFWUdHilC7gKOwjsOH19gEoXT5ghF0u4qj4DC3Y8CZ
 W+jYNX8Je1KFBAlfa7SlKGIpDJeSjIHDxbbwPS+vbuHKeLCWEBfCpt5VKga5oDbgOLnS
 3pkHHGUfR573NuY+ng+TiynEKqo9iMI13qAybumuGMUeazC68irsyYv5H6zen8SbhEql
 f5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=quIFR6mhP1x3onKdwu+UFr2o1QVXyu3HI0oYKF2760A=;
 b=AeyKsjZrqtJN0nbrl7Pyi4q1abgJvVecuuGhQcu1pg9D5kdOmm2Xa/Wb0tgblac6tT
 gg9vGkkJWRmF5Mk9+WcyuXq1qHWV9QSHZbfLl4iorfbBa7by3O+qo0Wsl4mEqnG5abbh
 aEWCjcvQFgHiCqV9q0CSgqpEErEV3OIyGnFymQWaqwlgMooEJTSthTOrwLsCuGCvlcW4
 AdUSKYcd7QlRnUWZ3uGjFoxBlOAZM0upX1k8vrxSV8J4zLNknymoqLcAe2BmVpFb6dQm
 44COxawFoKT4RvDraxoTOWfKMKqB1+vj+PZmTetj2XSMQCNmxiGMgodJfL73lGNa5v1U
 Z0dg==
X-Gm-Message-State: AGi0PuZtja4QIoe8pRHT2xAQnXW/7lSQUdm6R6e0DhZnGvLaQ1jg7K9C
 Z8Tv69A2Yj6APLeKvHbbm/o=
X-Google-Smtp-Source: APiQypJ2Waw8c3ACqFTZsDcsaD3xU67UESVDZ7CnZD4jcPCWb5cJENXXePojbpI9rkEUeO5OXzo2Fg==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr16839681wrw.319.1589178652665; 
 Sun, 10 May 2020 23:30:52 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id u24sm17912797wmm.47.2020.05.10.23.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2020 23:30:51 -0700 (PDT)
Subject: Re: [PATCH 11/12] hw/pci-host/bonito: Set the Config register reset
 value with FIELD_DP32
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-12-f4bug@amsat.org>
 <CAHiYmc5xCbftuexryEkY4+1FxOWVqz-wzJN2fg_dCiif0-BhYQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58233ffa-f763-9948-6dfa-1b3159ae829f@amsat.org>
Date: Mon, 11 May 2020 08:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5xCbftuexryEkY4+1FxOWVqz-wzJN2fg_dCiif0-BhYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 8:17 AM, Aleksandar Markovic wrote:
> нед, 10. мај 2020. у 23:01 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> Describe some Config registers fields with the registerfields
>> API. Use the FIELD_DP32() macro to set the BONGENCFG register
>> bits at reset.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/bonito.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
> 
> Some Config registers? Is there any reason not to cover all Bonito
> config registers? Or, the commit message was inprecise?

The commit message is not correct English, I wanted to say "some bits of 
the Config register" (I don't want to overload the file defining bits 
we'll never use).

> 
> But, in general, I salute the intent of this patch.

Thanks! I'll reword the description.

> 
> Sincerely,
> Aleksandar
> 
>> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
>> index 335c7787eb..86aceb333a 100644
>> --- a/hw/pci-host/bonito.c
>> +++ b/hw/pci-host/bonito.c
>> @@ -50,6 +50,7 @@
>>   #include "sysemu/runstate.h"
>>   #include "exec/address-spaces.h"
>>   #include "hw/misc/unimp.h"
>> +#include "hw/registerfields.h"
>>
>>   /* #define DEBUG_BONITO */
>>
>> @@ -112,8 +113,19 @@
>>   /* Power on register */
>>
>>   #define BONITO_BONPONCFG        (0x00 >> 2)      /* 0x100 */
>> +
>> +/* PCI configuration register */
>>   #define BONITO_BONGENCFG_OFFSET 0x4
>>   #define BONITO_BONGENCFG        (BONITO_BONGENCFG_OFFSET >> 2)   /*0x104 */
>> +REG32(BONGENCFG,        0x104)
>> +FIELD(BONGENCFG, DEBUGMODE,      0, 1)
>> +FIELD(BONGENCFG, SNOOP,          1, 1)
>> +FIELD(BONGENCFG, CPUSELFRESET,   2, 1)
>> +FIELD(BONGENCFG, BYTESWAP,       6, 1)
>> +FIELD(BONGENCFG, UNCACHED,       7, 1)
>> +FIELD(BONGENCFG, PREFETCH,       8, 1)
>> +FIELD(BONGENCFG, WRITEBEHIND,    9, 1)
>> +FIELD(BONGENCFG, PCIQUEUE,      12, 1)
>>
>>   /* 2. IO & IDE configuration */
>>   #define BONITO_IODEVCFG         (0x08 >> 2)      /* 0x108 */
>> @@ -577,11 +589,18 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
>>   static void bonito_reset(void *opaque)
>>   {
>>       PCIBonitoState *s = opaque;
>> +    uint32_t val = 0;
>>
>>       /* set the default value of north bridge registers */
>>
>>       s->regs[BONITO_BONPONCFG] = 0xc40;
>> -    s->regs[BONITO_BONGENCFG] = 0x1384;
>> +    val = FIELD_DP32(val, BONGENCFG, PCIQUEUE, 1);
>> +    val = FIELD_DP32(val, BONGENCFG, WRITEBEHIND, 1);
>> +    val = FIELD_DP32(val, BONGENCFG, PREFETCH, 1);
>> +    val = FIELD_DP32(val, BONGENCFG, UNCACHED, 1);
>> +    val = FIELD_DP32(val, BONGENCFG, CPUSELFRESET, 1);
>> +    s->regs[BONITO_BONGENCFG] = val;
>> +
>>       s->regs[BONITO_IODEVCFG] = 0x2bff8010;
>>       s->regs[BONITO_SDCFG] = 0x255e0091;
>>
>> --
>> 2.21.3
>>
> 

