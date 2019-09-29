Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93CC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 02:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2AC2146E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 02:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2AC2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEObR-0006E9-Nc
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 22:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iEOab-0005g2-BP
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 22:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iEOaa-00087X-1S
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 22:05:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42786 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iEOaX-00080D-Ae; Sat, 28 Sep 2019 22:05:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A16FD56EE928CBC06232;
 Sun, 29 Sep 2019 10:05:21 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sun, 29 Sep 2019
 10:04:52 +0800
Subject: Re: [PATCH v18 1/6] hw/arm/virt: Introduce RAS platform version and
 RAS machine option
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-2-zhengxiang9@huawei.com>
 <CAFEAcA9cQwAJfPBC9fRcxLZVzZqag0Si62nTBNwDPyQiPVwPcg@mail.gmail.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <3d335a56-b90b-f8bb-cb05-95bf52ddade5@huawei.com>
Date: Sun, 29 Sep 2019 10:04:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9cQwAJfPBC9fRcxLZVzZqag0Si62nTBNwDPyQiPVwPcg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>, QEMU
 Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/9/27 22:02, Peter Maydell wrote:
> On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>>
>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>
>> Support RAS Virtualization feature since version 4.2, disable it by
>> default in the old versions. Also add a machine option which allows user
>> to enable it explicitly.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>>  hw/arm/virt.c         | 33 +++++++++++++++++++++++++++++++++
>>  include/hw/arm/virt.h |  2 ++
>>  2 files changed, 35 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index d74538b021..e0451433c8 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1783,6 +1783,20 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
>>      vms->its = value;
>>  }
>>
>> +static bool virt_get_ras(Object *obj, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    return vms->ras;
>> +}
>> +
>> +static void virt_set_ras(Object *obj, bool value, Error **errp)
>> +{
>> +    VirtMachineState *vms = VIRT_MACHINE(obj);
>> +
>> +    vms->ras = value;
>> +}
>> +
>>  static char *virt_get_gic_version(Object *obj, Error **errp)
>>  {
>>      VirtMachineState *vms = VIRT_MACHINE(obj);
>> @@ -2026,6 +2040,19 @@ static void virt_instance_init(Object *obj)
>>                                      "Valid values are none and smmuv3",
>>                                      NULL);
>>
>> +    if (vmc->no_ras) {
>> +        vms->ras = false;
>> +    } else {
>> +        /* Default disallows RAS instantiation */
>> +        vms->ras = false;
>> +        object_property_add_bool(obj, "ras", virt_get_ras,
>> +                                 virt_set_ras, NULL);
>> +        object_property_set_description(obj, "ras",
>> +                                        "Set on/off to enable/disable "
>> +                                        "RAS instantiation",
>> +                                        NULL);
>> +    }
> 
> For a property which is disabled by default, you don't need
> to have a separate flag in the VirtMachineClass struct.
> Those are only needed for properties where we need the old machine
> types to have the property be 'off' but new machine types
> need to default to it be 'on'. Since vms->ras is false
> by default anyway, you can just have this part:
> 
>> +        /* Default disallows RAS instantiation */
>> +        vms->ras = false;
>> +        object_property_add_bool(obj, "ras", virt_get_ras,
>> +                                 virt_set_ras, NULL);
>> +        object_property_set_description(obj, "ras",
>> +                                        "Set on/off to enable/disable "
>> +                                        "RAS instantiation",
>> +                                        NULL);
> 
> Compare the 'vms->secure' flag and associated property
> for an example of this.

Thanks for pointing it out, I will remove the no_ras in the VirtMachineClass struct.

> 
>>      vms->irqmap = a15irqmap;
>>
>>      virt_flash_create(vms);
>> @@ -2058,8 +2085,14 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
>>
>>  static void virt_machine_4_1_options(MachineClass *mc)
>>  {
>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>> +
>>      virt_machine_4_2_options(mc);
>>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>> +    /* Disable memory recovery feature for 4.1 as RAS support was
>> +     * introduced with 4.2.
>> +     */
>> +    vmc->no_ras = true;
>>  }
>>  DEFINE_VIRT_MACHINE(4, 1)
> 
> thanks
> -- PMM
> 
> .
> 

-- 

Thanks,
Xiang


