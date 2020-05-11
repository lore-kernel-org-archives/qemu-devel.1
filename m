Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC19B207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjARBELM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC19B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY21X-0007E3-SS
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY20n-0006k8-4f
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:34:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jY20l-0006gf-Up
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:34:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id m12so11829342wmc.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 23:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ihtLHJsjvXDzEPmkXFvqJBRb71oCHyYlH1TVJyDtLdk=;
 b=ZjARBELM1YdRX9wnsA2N+q6rlghJmdc4fzZZ9JBxJprD5COMdctwRD1BjqKAjnOgQq
 Hol8naYs/rdpUyXossDQSbL4/LTZNqUmLZxJdSZzRkI/DesRunDbOt2fh3S3nR6K3Goz
 /CNPxo0ApfQDAKSl2b4DGZNph/qLJb34jdon463GlsZQ5JxhIHgWxfsPUbE20XOmxlDd
 RwDKtmGMIkpxvFmLhewFNBZVg+jxIYRGShu4T2OwPp+dAScdEdLkrZYl7oVlBYCbKrjf
 rgTbV7laEXCmf4YPGJ+ketTn0XGGVO/sZPYwrYhF/LDLIL6T5R/pQKVsJpgM6s5EFJOp
 2fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ihtLHJsjvXDzEPmkXFvqJBRb71oCHyYlH1TVJyDtLdk=;
 b=kiGAd7oxlhxF514PPL5phZj7e36waMisodhb5Bo0Euee0r/ALTJVz8oacU+KvaUcwN
 Zy/I7o0rMIcYkh4TOSvi2FzHdvrCCdlS1ax7bFsufb6iNtNx95nMQmZrzaK/wC0tPybd
 U/W/Wjc8v3IgRuqBf5lUEfQBguKm19nRgmw7qewZp+tDXUF/MgbQJfhi/y+D0ovWsPSx
 6gJbBrQ0AiDSeDa03xkipqKTTA9emrQzL13B71bFFSYrAb2l3jLPoQrRDTme7j3AOl8q
 aBIViy+ClMYTY97nKKndJN7NZbatzbhEOptFesu4WxQ/NngFKjtjcqHSL23JX5jSMvEC
 iO6Q==
X-Gm-Message-State: AGi0PuZeEP8uZ54Mq48HhpBfJOxUIeUqoSUXTyhUvV6CVriSRJ6v/K/2
 AGjzvnH0JjIoMxq/yYwYhDA=
X-Google-Smtp-Source: APiQypIw7Rg2kg+Munxow2KsSCLi6tAsDETQqbFoDdwX71sPJbbsOmkkjTccykjtZTcYkZJRXPc+3Q==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr29086205wmc.22.1589178838289; 
 Sun, 10 May 2020 23:33:58 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f7sm15075400wrt.10.2020.05.10.23.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2020 23:33:57 -0700 (PDT)
Subject: Re: [PATCH 09/12] hw/pci-host/bonito: Map the different PCI ranges
 more detailled
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-10-f4bug@amsat.org>
 <CAHiYmc4dt43BU41mFrHUv-dK_Xr34Ai8o3xtzXxYikhFaX-N2A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a170e94e-9539-27fd-21a0-04eab99c54b3@amsat.org>
Date: Mon, 11 May 2020 08:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4dt43BU41mFrHUv-dK_Xr34Ai8o3xtzXxYikhFaX-N2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

On 5/11/20 8:12 AM, Aleksandar Markovic wrote:
> нед, 10. мај 2020. у 23:01 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> Better describe the Bonito64 MEM HI/LO and I/O PCI ranges,
>> add more PCI regions as unimplemented.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/bonito.c | 30 ++++++++++++++++++++++++++----
>>   1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
>> index 9761780f44..90a6c52a38 100644
>> --- a/hw/pci-host/bonito.c
>> +++ b/hw/pci-host/bonito.c
>> @@ -39,6 +39,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>   #include "qemu/error-report.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/irq.h"
>> @@ -82,7 +83,7 @@
>>   #define BONITO_PCILO1_BASE      0x14000000
>>   #define BONITO_PCILO2_BASE      0x18000000
>>   #define BONITO_PCIHI_BASE       0x20000000
>> -#define BONITO_PCIHI_SIZE       0x20000000
>> +#define BONITO_PCIHI_SIZE       0x60000000
>>   #define BONITO_PCIHI_TOP        (BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE - 1)
>>   #define BONITO_PCIIO_BASE       0x1fd00000
>>   #define BONITO_PCIIO_BASE_VA    0xbfd00000
>> @@ -606,13 +607,25 @@ static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
>>       PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>>       BonitoState *bs = BONITO_PCI_HOST_BRIDGE(dev);
>>
>> -    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
>> +    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIHI_SIZE);
>>       phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
>>                                        pci_bonito_set_irq, pci_bonito_map_irq,
>>                                        dev, &bs->pci_mem, get_system_io(),
>>                                        0x28, 32, TYPE_PCI_BUS);
>> -    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE,
>> -                                &bs->pci_mem);
>> +
>> +    MemoryRegion *pcimem_lo_alias = g_new(MemoryRegion, 3);
>> +    for (size_t i = 0; i < 3; i++) {
>> +        char *name = g_strdup_printf("pci.lomem%zu", i);
>> +
>> +        memory_region_init_alias(&pcimem_lo_alias[i], NULL, name,
>> +                                 &bs->pci_mem, i * 64 * MiB, 64 * MiB);
>> +        memory_region_add_subregion(get_system_memory(),
>> +                                    BONITO_PCILO_BASE + i * 64 * MiB,
>> +                                    &pcimem_lo_alias[i]);
>> +        g_free(name);
>> +    }
>> +
>> +    create_unimplemented_device("pci.io", 0x1fd00000, 1 * MiB);
> 
> Hi, Philippe.
> 
> I am delighted with the whole series, finally cleaning Bonito code feels good.
> 
> I just want to ask you if it possible to get rid of constants like
> 0x1fd00000 (generally in this code, not limited to this patch), and
> give the some nice "#define" names?

Yes sure. These patches are almost 1year old, gathering the result of a 
debugging session. Also ...

> 
> Yours,
> Aleksandar
> 
>>   }
>>
>>   static void bonito_realize(PCIDevice *dev, Error **errp)
>> @@ -620,6 +633,7 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
>>       PCIBonitoState *s = PCI_BONITO(dev);
>>       SysBusDevice *sysbus = SYS_BUS_DEVICE(s->pcihost);
>>       PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
>> +    BonitoState *bs = BONITO_PCI_HOST_BRIDGE(s->pcihost);
>>
>>       /*
>>        * Bonito North Bridge, built on FPGA,
>> @@ -652,6 +666,7 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
>>       sysbus_init_mmio(sysbus, &s->iomem_ldma);
>>       sysbus_mmio_map(sysbus, 3, 0x1fe00200);
>>
>> +    /* PCI copier */
>>       memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
>>                             "cop", 0x100);
>>       sysbus_init_mmio(sysbus, &s->iomem_cop);
>> @@ -669,6 +684,13 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
>>       sysbus_init_mmio(sysbus, &s->bonito_localio);
>>       sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
>>
>> +    MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);

... I'll declare the variable during function prologue ;)

>> +    memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
>> +                             &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
>> +    memory_region_add_subregion(get_system_memory(),
>> +                                0x20000000ul, pcimem_alias);
>> +    create_unimplemented_device("PCI_2", 0x80000000ul, 2 * GiB); /* pci_hi */

... And add definitions for these addresses.

Thanks for the other reviews in this series!

>> +
>>       /* set the default value of north bridge pci config */
>>       pci_set_word(dev->config + PCI_COMMAND, 0x0000);
>>       pci_set_word(dev->config + PCI_STATUS, 0x0000);
>> --
>> 2.21.3
>>
> 

