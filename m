Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F1DC33CAA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0AB214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0AB214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqvNn-000863-Ae
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 03:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iqvN5-0007Yk-OU
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 03:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iqvN4-0007v4-AM
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 03:46:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42308 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iqvN1-0007hW-2i; Mon, 13 Jan 2020 03:46:47 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5B40C8C3D87289246465;
 Mon, 13 Jan 2020 16:46:39 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 16:46:25 +0800
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified by
 _HID
From: Guoheyi <guoheyi@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <20200105074308-mutt-send-email-mst@kernel.org>
 <ede9a938-32a3-70e0-d884-325505afb345@huawei.com>
Message-ID: <8d95d1a0-5090-02ee-33da-79703efb715e@huawei.com>
Date: Mon, 13 Jan 2020 16:46:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ede9a938-32a3-70e0-d884-325505afb345@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

Any more comments? Or shall I refine the commit message?

Thanks,

Heyi

=E5=9C=A8 2020/1/6 10:10, Guoheyi =E5=86=99=E9=81=93:
>
> =E5=9C=A8 2020/1/5 20:53, Michael S. Tsirkin =E5=86=99=E9=81=93:
>> On Sun, Jan 05, 2020 at 07:34:01AM -0500, Michael S. Tsirkin wrote:
>>> On Thu, Dec 19, 2019 at 02:47:59PM +0800, Heyi Guo wrote:
>>>> According to ACPI spec, _ADR should be used for device which is on a
>>>> bus that has a standard enumeration algorithm. It does not make sens=
e
>>>> to have a _ADR object for devices which already have _HID and will b=
e
>>>> enumerated by OSPM.
>>>>
>>>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>>> Are you sure? I would think this depends on the ID and the device
>>> really. E.g. PCI devices all are expected to have _ADR and some of th=
em
>>> have a _HID.
>>
>> To clarify I am not commenting on patches.
>> The spec says this:
>> =C2=A0=C2=A0=C2=A0=C2=A06.1.5 _HID (Hardware ID)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0This object is used to supply OSPM with the de=
vice=E2=80=99s PNP ID or=20
>> ACPI ID. 1
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0When describing a platform, use of any _HID ob=
jects is optional.=20
>> However, a _HID object must be
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0used to describe any device that will be enume=
rated by OSPM. OSPM=20
>> only enumerates a device
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0when no bus enumerator can detect the device I=
D. For example,=20
>> devices on an ISA bus are
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0enumerated by OSPM. Use the _ADR object to des=
cribe devices=20
>> enumerated by bus enumerators
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0other than OSPM.
>>
>>
>> Note: "detect the device ID" not "enumerate the device" which I think
>> means there's a driver matching this vendor/device ID.
>>
>> So it seems fine to have _ADR so device is enumerated, and still have
>> _HID e.g. so ACPI driver can be loaded as fallback if there's
>> no bus driver.
>>
>>
>> Note I am not saying the patch itself is not correct.
>> Maybe these devices are not on any standard bus and that
>> is why they should not have _ADR? I have not looked.
>>
>> I am just saying that spec does not seem to imply _HID and _ADR
>> can't coexist.
>
> That's true; I did't find such statement either. Maybe what we can say=20
> is that the _ADR is senseless here.
>
> Thanks,
>
> Heyi
>
>>
>>
>>> CC Corey who added a device with both HID and ADR to x86 recenly.
>>>
>>> Apropos Corey, why was HID APP0005 chosen?
>>>
>>>> ---
>>>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>> Cc: qemu-arm@nongnu.org
>>>> Cc: qemu-devel@nongnu.org
>>>> ---
>>>> =C2=A0 hw/arm/virt-acpi-build.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 --------
>>>> =C2=A0 tests/data/acpi/virt/DSDT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Bin 18449 -> 18426 bytes
>>>> =C2=A0 tests/data/acpi/virt/DSDT.memhp=C2=A0=C2=A0 | Bin 19786 -> 19=
763 bytes
>>>> =C2=A0 tests/data/acpi/virt/DSDT.numamem | Bin 18449 -> 18426 bytes
>>>> =C2=A0 4 files changed, 8 deletions(-)
>>>>
>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>> index 9f4c7d1889..be752c0ad8 100644
>>>> --- a/hw/arm/virt-acpi-build.c
>>>> +++ b/hw/arm/virt-acpi-build.c
>>>> @@ -78,11 +78,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const=20
>>>> MemMapEntry *uart_memmap,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AML_EXCLUSIVE, &uart_irq, 1));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_CRS",=
 crs));
>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /* The _ADR entry is used to link this de=
vice to the UART=20
>>>> described
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * in the SPCR table, i.e. SPCR.base_addres=
s.address =3D=3D _ADR.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_ADR",=20
>>>> aml_int(uart_memmap->base)));
>>>> -
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(scope, dev);
>>>> =C2=A0 }
>>>> =C2=A0 @@ -170,7 +165,6 @@ static void acpi_dsdt_add_pci(Aml *scope,=
=20
>>>> const MemMapEntry *memmap,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_CID",=
 aml_string("PNP0A03")));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_SEG",=
 aml_int(0)));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_BBN",=
 aml_int(0)));
>>>> -=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_ADR", aml_int(0)=
));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_UID",=
 aml_string("PCI0")));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_STR",=
 aml_unicode("PCIe 0=20
>>>> Device")));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_CCA",=
 aml_int(1)));
>>>> @@ -334,7 +328,6 @@ static void acpi_dsdt_add_gpio(Aml *scope,=20
>>>> const MemMapEntry *gpio_memmap,
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Aml *dev =3D aml_device("GPO0");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_HID",=
 aml_string("ARMH0061")));
>>>> -=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_ADR", aml_int(0)=
));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_UID",=
 aml_int(0)));
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Aml *crs =3D aml_resource_temp=
late();
>>>> @@ -364,7 +357,6 @@ static void acpi_dsdt_add_power_button(Aml *scop=
e)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Aml *dev =3D aml_device(ACPI_POWER_BU=
TTON_DEVICE);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_HID",=
 aml_string("PNP0C0C")));
>>>> -=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_ADR", aml_int(0)=
));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_decl("_UID",=
 aml_int(0)));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(scope, dev);
>>>> =C2=A0 }
>>>> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
>>>
>>> Please do not include binary changes in acpi patches.
>>>
>>> See comment at the top of tests/bios-tables-test.c for documentation
>>> on how to update these.
>>>
>>> --=20
>>> MST
>>
>> .


