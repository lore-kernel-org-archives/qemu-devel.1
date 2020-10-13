Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3654AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9289125319
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9289125319
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNqZ-0008KW-Ij
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSNof-0007Px-T5; Tue, 13 Oct 2020 13:10:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:13702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSNoc-00087V-Va; Tue, 13 Oct 2020 13:10:25 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CD992747604;
 Tue, 13 Oct 2020 19:10:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 378CC7475FF; Tue, 13 Oct 2020 19:10:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 367097475FE;
 Tue, 13 Oct 2020 19:10:20 +0200 (CEST)
Date: Tue, 13 Oct 2020 19:10:20 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 3/3] uninorth: use qdev gpios for PCI IRQs
In-Reply-To: <f5ca9c69-c946-7f2e-0fc6-92a3136e63d1@ilande.co.uk>
Message-ID: <35749ba-6daf-9bf-f53-6e67d647f51d@eik.bme.hu>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-4-mark.cave-ayland@ilande.co.uk>
 <f8df313a-24ae-5544-e1a8-32cb7729f680@eik.bme.hu>
 <f5ca9c69-c946-7f2e-0fc6-92a3136e63d1@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-349957433-1602609020=:37098"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 10:41:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, f4bug@amsat.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-349957433-1602609020=:37098
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 Oct 2020, Mark Cave-Ayland wrote:
> On 13/10/2020 14:38, BALATON Zoltan via wrote:
>> On Tue, 13 Oct 2020, Mark Cave-Ayland wrote:
>>> Currently an object link property is used to pass a reference to the 
>>> OpenPIC
>>> into the PCI host bridge so that pci_unin_init_irqs() can connect the PCI
>>> IRQs to the PIC itself.
>>> 
>>> This can be simplified by defining the PCI IRQs as qdev gpios and then 
>>> wiring
>>> up the PCI IRQs to the PIC in the New World machine init function.
>>> 
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>> hw/pci-host/uninorth.c         | 45 +++++++---------------------------
>>> hw/ppc/mac_newworld.c          | 24 ++++++++++++------
>>> include/hw/pci-host/uninorth.h |  2 --
>>> 3 files changed, 25 insertions(+), 46 deletions(-)
>>> 
>>> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
>>> index 1ed1072eeb..0c0a9ecee1 100644
>>> --- a/hw/pci-host/uninorth.c
>>> +++ b/hw/pci-host/uninorth.c
>>> @@ -32,8 +32,6 @@
>>> #include "hw/pci-host/uninorth.h"
>>> #include "trace.h"
>>> 
>>> -static const int unin_irq_line[] = { 0x1b, 0x1c, 0x1d, 0x1e };
>>> -
>>> static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
>>> {
>>>     return (irq_num + (pci_dev->devfn >> 3)) & 3;
>>> @@ -43,7 +41,7 @@ static void pci_unin_set_irq(void *opaque, int irq_num, 
>>> int level)
>>> {
>>>     UNINHostState *s = opaque;
>>> 
>>> -    trace_unin_set_irq(unin_irq_line[irq_num], level);
>>> +    trace_unin_set_irq(irq_num, level);
>>>     qemu_set_irq(s->irqs[irq_num], level);
>>> }
>>> 
>>> @@ -112,15 +110,6 @@ static const MemoryRegionOps unin_data_ops = {
>>>     .endianness = DEVICE_LITTLE_ENDIAN,
>>> };
>>> 
>>> -static void pci_unin_init_irqs(UNINHostState *s)
>>> -{
>>> -    int i;
>>> -
>>> -    for (i = 0; i < ARRAY_SIZE(s->irqs); i++) {
>>> -        s->irqs[i] = qdev_get_gpio_in(DEVICE(s->pic), unin_irq_line[i]);
>>> -    }
>>> -}
>>> -
>>> static char *pci_unin_main_ofw_unit_address(const SysBusDevice *dev)
>>> {
>>>     UNINHostState *s = UNI_NORTH_PCI_HOST_BRIDGE(dev);
>>> @@ -141,7 +130,6 @@ static void pci_unin_main_realize(DeviceState *dev, 
>>> Error **errp)
>>>                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
>>> 
>>>     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-pci");
>>> -    pci_unin_init_irqs(s);
>>> 
>>>     /* DEC 21154 bridge */
>>> #if 0
>>> @@ -172,15 +160,12 @@ static void pci_unin_main_init(Object *obj)
>>>                              "unin-pci-hole", &s->pci_mmio,
>>>                              0x80000000ULL, 0x10000000ULL);
>>> 
>>> -    object_property_add_link(obj, "pic", TYPE_OPENPIC,
>>> -                             (Object **) &s->pic,
>>> -                             qdev_prop_allow_set_link_before_realize,
>>> -                             0);
>>> -
>>>     sysbus_init_mmio(sbd, &h->conf_mem);
>>>     sysbus_init_mmio(sbd, &h->data_mem);
>>>     sysbus_init_mmio(sbd, &s->pci_hole);
>>>     sysbus_init_mmio(sbd, &s->pci_io);
>>> +
>>> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>>> }
>>> 
>>> static void pci_u3_agp_realize(DeviceState *dev, Error **errp)
>>> @@ -196,7 +181,6 @@ static void pci_u3_agp_realize(DeviceState *dev, Error 
>>> **errp)
>>>                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
>>> 
>>>     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "u3-agp");
>>> -    pci_unin_init_irqs(s);
>>> }
>>> 
>>> static void pci_u3_agp_init(Object *obj)
>>> @@ -220,15 +204,12 @@ static void pci_u3_agp_init(Object *obj)
>>>                              "unin-pci-hole", &s->pci_mmio,
>>>                              0x80000000ULL, 0x70000000ULL);
>>> 
>>> -    object_property_add_link(obj, "pic", TYPE_OPENPIC,
>>> -                             (Object **) &s->pic,
>>> -                             qdev_prop_allow_set_link_before_realize,
>>> -                             0);
>>> -
>>>     sysbus_init_mmio(sbd, &h->conf_mem);
>>>     sysbus_init_mmio(sbd, &h->data_mem);
>>>     sysbus_init_mmio(sbd, &s->pci_hole);
>>>     sysbus_init_mmio(sbd, &s->pci_io);
>>> +
>>> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>>> }
>>> 
>>> static void pci_unin_agp_realize(DeviceState *dev, Error **errp)
>>> @@ -244,7 +225,6 @@ static void pci_unin_agp_realize(DeviceState *dev, 
>>> Error **errp)
>>>                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
>>> 
>>>     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
>>> -    pci_unin_init_irqs(s);
>>> }
>>> 
>>> static void pci_unin_agp_init(Object *obj)
>>> @@ -259,13 +239,10 @@ static void pci_unin_agp_init(Object *obj)
>>>     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
>>>                           obj, "unin-agp-conf-data", 0x1000);
>>> 
>>> -    object_property_add_link(obj, "pic", TYPE_OPENPIC,
>>> -                             (Object **) &s->pic,
>>> -                             qdev_prop_allow_set_link_before_realize,
>>> -                             0);
>>> -
>>>     sysbus_init_mmio(sbd, &h->conf_mem);
>>>     sysbus_init_mmio(sbd, &h->data_mem);
>>> +
>>> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>>> }
>>> 
>>> static void pci_unin_internal_realize(DeviceState *dev, Error **errp)
>>> @@ -281,7 +258,6 @@ static void pci_unin_internal_realize(DeviceState 
>>> *dev, Error **errp)
>>>                                    PCI_DEVFN(14, 0), 4, TYPE_PCI_BUS);
>>> 
>>>     pci_create_simple(h->bus, PCI_DEVFN(14, 0), "uni-north-internal-pci");
>>> -    pci_unin_init_irqs(s);
>>> }
>>> 
>>> static void pci_unin_internal_init(Object *obj)
>>> @@ -296,13 +272,10 @@ static void pci_unin_internal_init(Object *obj)
>>>     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
>>>                           obj, "unin-pci-conf-data", 0x1000);
>>> 
>>> -    object_property_add_link(obj, "pic", TYPE_OPENPIC,
>>> -                             (Object **) &s->pic,
>>> -                             qdev_prop_allow_set_link_before_realize,
>>> -                             0);
>>> -
>>>     sysbus_init_mmio(sbd, &h->conf_mem);
>>>     sysbus_init_mmio(sbd, &h->data_mem);
>>> +
>>> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>>> }
>>> 
>>> static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
>>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>>> index 6f5ef2e782..7a8dc09c8d 100644
>>> --- a/hw/ppc/mac_newworld.c
>>> +++ b/hw/ppc/mac_newworld.c
>>> @@ -303,8 +303,6 @@ static void ppc_core99_init(MachineState *machine)
>>>         /* 970 gets a U3 bus */
>>>         /* Uninorth AGP bus */
>>>         dev = qdev_new(TYPE_U3_AGP_HOST_BRIDGE);
>>> -        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
>>> -                                 &error_abort);
>>>         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>>         uninorth_pci = U3_AGP_HOST_BRIDGE(dev);
>>>         s = SYS_BUS_DEVICE(dev);
>>> @@ -317,32 +315,38 @@ static void ppc_core99_init(MachineState *machine)
>>>         sysbus_mmio_map(s, 0, 0xf0800000);
>>>         sysbus_mmio_map(s, 1, 0xf0c00000);
>>> 
>>> +        for (i = 0; i < 4; i++) {
>> 
>> Philippe had a series that replaced all these with PCI_NUM_IRQS or similar 
>> constant. Should you use that instead in new additions?
>
> I'm not sure that's directly relevant here - my understanding was that 
> PCI_NUM_IRQS represents the number of IRQs on the device, not the PCI host 
> bridge. Certainly it could be argued that there is a 1:1 correspondence in 
> this case, however I don't have any documentation to support this so it 
> doesn't feel right to make these values directly equivalent.

OK with me either way, just noted this might be something Philippe would 
suggest anyway :-)

>> This is probably not modelled faithfuly (the whole mac99 machine is a hack 
>> to get the most OSes run, not emulating an actual machine) but I wonder if 
>> it's correct to connect all these irqs for all the different busses to the 
>> same pic lines? Is that how it is on a real PowerMac3,1? (This is just a 
>> question not something that should be fixed in this patch which is a nice 
>> clean up anyway, this just made it more obvious to me what's happening so 
>> maybe we can find out a difference in emulation compared to real hardware 
>> that could be fixed in the future.)
>
> Yeah I spotted that too when I was writing the patch. In its current form it 
> keeps the existing behaviour as-is, but this is something that may be worth 
> investigating later. I'm not aware of any documentation explaining how the 
> PCI/AGP bridges are wired up on a Mac, so it might end up being a case of 
> trawling through driver source code to try and get some answers...

As usual... Maybe there's someone on the list reading this who has an 
answer and could save reading the sources. Maybe asking BenH and Alex Graf 
worth a try.

Regards,
BALATON Zoltan
--3866299591-349957433-1602609020=:37098--

