Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A0BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C577F2224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C577F2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLO6-0003hZ-IN
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXLMl-0002qM-Pf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:34:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:49400
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXLMi-00089O-F3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:34:07 -0400
Received: from host86-148-103-79.range86-148.btcentralplus.com
 ([86.148.103.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXLMi-00083t-Mn; Tue, 27 Oct 2020 09:34:09 +0000
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201021114300.11579-1-mark.cave-ayland@ilande.co.uk>
 <24f4d006-f8b4-4eac-5319-67ad14b182b5@ilande.co.uk>
 <4dc23e8c-8527-9334-477c-2aed648c621b@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e66f3460-903f-e427-a8e0-55c663e7f4e0@ilande.co.uk>
Date: Tue, 27 Oct 2020 09:33:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4dc23e8c-8527-9334-477c-2aed648c621b@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.103.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] sabre: use object_initialize_child() for iommu child
 object
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.167,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/10/2020 11:41, Philippe Mathieu-Daudé wrote:

> On 10/25/20 12:11 PM, Mark Cave-Ayland wrote:
>> On 21/10/2020 12:43, Mark Cave-Ayland wrote:
>>
>>> Store the child object directly within the sabre object rather than using
>>> link properties.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/pci-host/sabre.c         | 10 ++++------
>>>   hw/sparc64/sun4u.c          |  8 +-------
>>>   include/hw/pci-host/sabre.h |  2 +-
>>>   3 files changed, 6 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
>>> index f41a0cc301..aaa93acd6e 100644
>>> --- a/hw/pci-host/sabre.c
>>> +++ b/hw/pci-host/sabre.c
>>> @@ -383,9 +383,10 @@ static void sabre_realize(DeviceState *dev, Error **errp)
>>>       pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
>>>       /* IOMMU */
>>> +    sysbus_realize(SYS_BUS_DEVICE(&s->iommu), &error_fatal);
>>>       memory_region_add_subregion_overlap(&s->sabre_config, 0x200,
>>> -                    sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 0), 1);
>>> -    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
>>> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->iommu), 0), 1);
>>> +    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, &s->iommu);
>>>       /* APB secondary busses */
>>>       pci_dev = pci_new_multifunction(PCI_DEVFN(1, 0), true,
>>> @@ -422,10 +423,7 @@ static void sabre_init(Object *obj)
>>>       s->pci_irq_in = 0ULL;
>>>       /* IOMMU */
>>> -    object_property_add_link(obj, "iommu", TYPE_SUN4U_IOMMU,
>>> -                             (Object **) &s->iommu,
>>> -                             qdev_prop_allow_set_link_before_realize,
>>> -                             0);
>>> +    object_initialize_child(obj, "iommu", &s->iommu, TYPE_SUN4U_IOMMU);
>>>       /* sabre_config */
>>>       memory_region_init_io(&s->sabre_config, OBJECT(s), &sabre_config_ops, s,
>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>> index 2f8fc670cf..a33f1eccfd 100644
>>> --- a/hw/sparc64/sun4u.c
>>> +++ b/hw/sparc64/sun4u.c
>>> @@ -562,7 +562,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>>       PCIBus *pci_bus, *pci_busA, *pci_busB;
>>>       PCIDevice *ebus, *pci_dev;
>>>       SysBusDevice *s;
>>> -    DeviceState *iommu, *dev;
>>> +    DeviceState *dev;
>>>       FWCfgState *fw_cfg;
>>>       NICInfo *nd;
>>>       MACAddr macaddr;
>>> @@ -571,10 +571,6 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>>       /* init CPUs */
>>>       cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
>>> -    /* IOMMU */
>>> -    iommu = qdev_new(TYPE_SUN4U_IOMMU);
>>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu), &error_fatal);
>>> -
>>>       /* set up devices */
>>>       ram_init(0, machine->ram_size);
>>> @@ -584,8 +580,6 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>>       sabre = SABRE(qdev_new(TYPE_SABRE));
>>>       qdev_prop_set_uint64(DEVICE(sabre), "special-base", PBM_SPECIAL_BASE);
>>>       qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
>>> -    object_property_set_link(OBJECT(sabre), "iommu", OBJECT(iommu),
>>> -                             &error_abort);
>>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(sabre), &error_fatal);
>>>       /* sabre_config */
>>> diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
>>> index 01190241bb..05bf741cde 100644
>>> --- a/include/hw/pci-host/sabre.h
>>> +++ b/include/hw/pci-host/sabre.h
>>> @@ -34,7 +34,7 @@ struct SabreState {
>>>       MemoryRegion pci_mmio;
>>>       MemoryRegion pci_ioport;
>>>       uint64_t pci_irq_in;
>>> -    IOMMUState *iommu;
>>> +    IOMMUState iommu;
>>>       PCIBridge *bridgeA;
>>>       PCIBridge *bridgeB;
>>>       uint32_t pci_control[16];
>>
>> No further comments (and I'm happier that this is a better solution than having an 
>> "optional" link property) so I've applied this to my qemu-sparc branch.
> 
> Sorry I had this patch tagged for review but am having trouble
> managing that folder. This is certainly better, thanks for this
> cleanup.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Looks like this patch exposes another issue related to QOM lifecycle, so I'm dropping 
it from my qemu-sparc branch for now.


ATB,

Mark.

