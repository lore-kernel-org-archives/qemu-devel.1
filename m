Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F6EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86154221F8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86154221F8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJbH-0003dT-AW
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kaJaV-0003CG-02; Wed, 04 Nov 2020 09:16:35 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:29495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kaJaR-0007JJ-OE; Wed, 04 Nov 2020 09:16:34 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9B00274760E;
 Wed,  4 Nov 2020 15:16:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 706EB7475FE; Wed,  4 Nov 2020 15:16:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6F1A574594E;
 Wed,  4 Nov 2020 15:16:17 +0100 (CET)
Date: Wed, 4 Nov 2020 15:16:17 +0100 (CET)
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 5/6] macio: don't reference serial_hd() directly within
 the device
In-Reply-To: <16f13e17-37cb-a238-4e2a-9a945649cafd@redhat.com>
Message-ID: <1ee5be24-277c-dda1-adc5-beae5177782a@eik.bme.hu>
References: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
 <20200926140216.7368-6-mark.cave-ayland@ilande.co.uk>
 <16f13e17-37cb-a238-4e2a-9a945649cafd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 armbru@redhat.com, qemu-ppc@nongnu.org, atar4qemu@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Wed, 4 Nov 2020, Thomas Huth wrote:
> On 26/09/2020 16.02, Mark Cave-Ayland wrote:
>> Instead use qdev_prop_set_chr() to configure the ESCC serial chardevs at the
>> Mac Old World and New World machine level.
>>
>> Also remove the now obsolete comment referring to the use of serial_hd() and
>> the setting of user_creatable to false accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/misc/macio/macio.c | 4 ----
>>  hw/ppc/mac_newworld.c | 6 ++++++
>>  hw/ppc/mac_oldworld.c | 6 ++++++
>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
>> index 679722628e..51368884d0 100644
>> --- a/hw/misc/macio/macio.c
>> +++ b/hw/misc/macio/macio.c
>> @@ -109,8 +109,6 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
>>      qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>>      qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>>      qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hd(0));
>> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
>>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
>>      qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>>      if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
>> @@ -458,8 +456,6 @@ static void macio_class_init(ObjectClass *klass, void *data)
>>      k->class_id = PCI_CLASS_OTHERS << 8;
>>      device_class_set_props(dc, macio_properties);
>>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>> -    /* Reason: Uses serial_hds in macio_instance_init */
>> -    dc->user_creatable = false;
>>  }
>
> Hi Mark,
>
> the macio device can now be used to crash QEMU:
>
> $ ./qemu-system-ppc -M sam460ex -device macio-newworld
> Segmentation fault (core dumped)
>
> I guess we should either restore the user_creatable flag or add some sanity
> checks elsewhere?

Looks like it needs to check if pic_dev is set:

$ gdb --args ./qemu-system-ppc -M sam460ex -device macio-newworld
(gdb) r
Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
0x0000555555c3d65a in qdev_get_named_gpio_list (dev=0x0, name=0x0)
    at ../hw/core/qdev.c:456
456	    QLIST_FOREACH(ngl, &dev->gpios, node) {
(gdb) bt
#0  0x0000555555c3d65a in qdev_get_named_gpio_list (dev=0x0, name=0x0)
    at ../hw/core/qdev.c:456
#1  0x0000555555c3e349 in qdev_get_gpio_in_named (dev=<optimized out>,
    name=<optimized out>, n=36) at ../hw/core/qdev.c:532
#2  0x00005555559c690f in macio_newworld_realize (d=<optimized out>,
    errp=0x7fffffffda40) at ../hw/misc/macio/macio.c:301
#3  0x0000555555946334 in pci_qdev_realize (qdev=0x555556b578e0,
    errp=<optimized out>) at ../hw/pci/pci.c:2125
#4  0x0000555555c3f1ff in device_set_realized (obj=<optimized out>,
    value=true, errp=0x7fffffffdb50) at ../hw/core/qdev.c:886
[...]
(gdb) up
#1  0x0000555555c3e349 in qdev_get_gpio_in_named (dev=<optimized out>,
    name=<optimized out>, n=36) at ../hw/core/qdev.c:532
532	    NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
(gdb)
#2  0x00005555559c690f in macio_newworld_realize (d=<optimized out>,
    errp=0x7fffffffda40) at ../hw/misc/macio/macio.c:301
301	    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
(gdb) l 285
280	    .read = timer_read,
281	    .write = timer_write,
282	    .endianness = DEVICE_LITTLE_ENDIAN,
283	};
284
285	static void macio_newworld_realize(PCIDevice *d, Error **errp)
286	{
287	    MacIOState *s = MACIO(d);
288	    NewWorldMacIOState *ns = NEWWORLD_MACIO(d);
289	    DeviceState *pic_dev = DEVICE(ns->pic);
(gdb)
290	    Error *err = NULL;
291	    SysBusDevice *sysbus_dev;
292	    MemoryRegion *timer_memory = NULL;
293
294	    macio_common_realize(d, &err);
295	    if (err) {
296	        error_propagate(errp, err);
297	        return;
298	    }
299
(gdb)
300	    sysbus_dev = SYS_BUS_DEVICE(&s->escc);
301	    sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
302	                                                       NEWWORLD_ESCCB_IRQ));
303	    sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
304	                                                       NEWWORLD_ESCCA_IRQ));
305
306	    /* OpenPIC */
307	    sysbus_dev = SYS_BUS_DEVICE(ns->pic);
308	    memory_region_add_subregion(&s->bar, 0x40000,
309	                                sysbus_mmio_get_region(sysbus_dev, 
0));

Maybe something like:

if (!pic_dev) {
    error_setg(errp, "some meaningful error message");
    return;
}

before the sysbus_connect_irq calls but unless the user can set this via 
the command line somehow then keeping the user_creatable = false with 
comment adjusted to say that this device needs to be connected by board 
code is probably better.

Regards,
BALATON Zoltan

