Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6ADC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 10:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241E121569
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 10:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241E121569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it89s-0001Gk-9p
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 05:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1it89E-0000i1-NF
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 05:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1it89D-0004ZF-Eb
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 05:49:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2687 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1it899-0004JR-Kq; Sun, 19 Jan 2020 05:49:35 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 02CC9994C8FC5C0F5679;
 Sun, 19 Jan 2020 18:49:24 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.230) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0;
 Sun, 19 Jan 2020 18:49:17 +0800
Subject: Re: [PATCH v2] hw/arm: Adjust some coding styles about memory hotplug
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200117063822.57918-1-zhukeqian1@huawei.com>
 <CAFEAcA_Cji9poXhv1=cje3r2uwz+X_iYo8TmTxP_wP1CRV-b9g@mail.gmail.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <d7586e9c-2bad-c679-3c6a-66e07a3c6d2d@huawei.com>
Date: Sun, 19 Jan 2020 18:49:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Cji9poXhv1=cje3r2uwz+X_iYo8TmTxP_wP1CRV-b9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, wanghaibin.wang@huawei.com,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/1/17 19:07, Peter Maydell wrote:
> On Fri, 17 Jan 2020 at 06:41, Keqian Zhu <zhukeqian1@huawei.com> wrote:
>>
>> From: zhukeqian <zhukeqian1@huawei.com>
>>
>> There is extra indent in ACPI GED plug cb. And we can use
>> existing helper function to trigger hotplug handler plug.
>>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>
>> v1->v2:
>>  - Add Igor's R-b
>>
>> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/acpi/generic_event_device.c | 2 +-
>>  hw/arm/virt.c                  | 6 +++---
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>> index 9cee90cc70..55eb29d80a 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -175,7 +175,7 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>>      AcpiGedState *s = ACPI_GED(hotplug_dev);
>>
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> -            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>> +        acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>>      } else {
>>          error_setg(errp, "virt: device plug request for unsupported device"
>>                     " type: %s", object_get_typename(OBJECT(dev)));
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 39ab5f47e0..656b0081c2 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1934,7 +1934,6 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>  static void virt_memory_plug(HotplugHandler *hotplug_dev,
>>                               DeviceState *dev, Error **errp)
>>  {
>> -    HotplugHandlerClass *hhc;
>>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>>      Error *local_err = NULL;
>>
>> @@ -1943,8 +1942,9 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>>          goto out;
>>      }
>>
>> -    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
>> -    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &error_abort);
>> +    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
>> +                         dev, &error_abort);
>> +
>>  out:
>>      error_propagate(errp, local_err);
>>  }
> 
> These two changes are unrelated (one is just a whitespace
> fixup, and it's in an entirely different file to the other
> one, which is making an actual code change). I think they
> should not be in the same patch.
> 
> thanks
> -- PMM
> 
Ok, I will reform this patch.

Thanks,
Keqian
> .
> 


