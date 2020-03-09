Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9954CC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 01:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698DD205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 01:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698DD205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB7Su-00077k-L0
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 21:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jB7SE-0006hW-1q
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jB7SC-0008Mr-IX
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:43:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3265 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jB7SC-0008Kr-7t
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:43:36 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 25816637F888A8F93429;
 Mon,  9 Mar 2020 08:56:58 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 9 Mar 2020
 08:56:49 +0800
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
Date: Mon, 9 Mar 2020 08:56:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Laurent Vivier <laurent@vivier.eu>, Euler Robot <euler.robot@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/8/2020 9:29 PM, Peter Maydell wrote:
> On Thu, 5 Mar 2020 at 06:39, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>>
>> This patch fix a bug in mac_via where it failed to actually realize devices it was using.
>> And move the init codes which inits the mos6522 objects and properties on them from realize()
>> into init(). However, we keep qdev_set_parent_bus in realize(), otherwise it will cause
>> device-introspect-test test fail. Then do the realize mos6522 device in the mac_vir_realize.
>>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
> 
>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>> index b7d0012794..4c5ad08805 100644
>> --- a/hw/misc/mac_via.c
>> +++ b/hw/misc/mac_via.c
>> @@ -868,24 +868,24 @@ static void mac_via_reset(DeviceState *dev)
>>  static void mac_via_realize(DeviceState *dev, Error **errp)
>>  {
>>      MacVIAState *m = MAC_VIA(dev);
>> -    MOS6522State *ms;
>>      struct tm tm;
>>      int ret;
>> +    Error *err = NULL;
>>
>> -    /* Init VIAs 1 and 2 */
>> -    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
>> -                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
>> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via1), sysbus_get_default());
>> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via2), sysbus_get_default());
> 
> Rather than manually setting the parent bus, you can use
> sysbus_init_child_obj() instead of object_initialize_child() --
> it is a convenience function that does both object_initialize_child()
> and qdev_set_parent_bus() for you.

Actually I used sysbus_init_child_obj() first, but it will fail to run device-introspect-test.
Because qdev_set_parent_bus() will change 'info qtree' after we call 'device-list-properties'.
Thus, I do it in the realize.

> 
>> -    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
>> -                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
>> +    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized", &err);
>> +    if (err != NULL) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>>
>> -    /* Pass through mos6522 output IRQs */
>> -    ms = MOS6522(&m->mos6522_via1);
>> -    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
>> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
>> -    ms = MOS6522(&m->mos6522_via2);
>> -    object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
>> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
>> +    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized", &err);
>> +    if (err != NULL) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>>
>>      /* Pass through mos6522 input IRQs */
>>      qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
>> @@ -932,6 +932,7 @@ static void mac_via_init(Object *obj)
>>  {
>>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>      MacVIAState *m = MAC_VIA(obj);
>> +    MOS6522State *ms;
>>
>>      /* MMIO */
>>      memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
>> @@ -948,6 +949,22 @@ static void mac_via_init(Object *obj)
>>      /* ADB */
>>      qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
>>                          TYPE_ADB_BUS, DEVICE(obj), "adb.0");
>> +
>> +    /* Init VIAs 1 and 2 */
>> +    object_initialize_child(OBJECT(m), "via1", &m->mos6522_via1,
>> +                            sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1,
>> +                            &error_abort, NULL);
>> +    object_initialize_child(OBJECT(m), "via2", &m->mos6522_via2,
>> +                            sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2,
>> +                            &error_abort, NULL);
>> +
>> +    /* Pass through mos6522 output IRQs */
>> +    ms = MOS6522(&m->mos6522_via1);
>> +    object_property_add_alias(OBJECT(m), "irq[0]", OBJECT(ms),
>> +                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
> 
> There's no point in using the MOS6522() cast to get a MOS6522*,
> because the only thing you do with it is immediately cast it
> to an Object* with the OBJECT() cast. Just use the OBJECT cast directly.

Ok, will do it.

Thanks.

> 
>> +    ms = MOS6522(&m->mos6522_via2);
>> +    object_property_add_alias(OBJECT(m), "irq[1]", OBJECT(ms),
>> +                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
>>  }
>>
>>  static void postload_update_cb(void *opaque, int running, RunState state)
> 
> thanks
> -- PMM
> .
> 

