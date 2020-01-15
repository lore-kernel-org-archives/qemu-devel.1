Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9BFC33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8306F24658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8306F24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irXRz-00045y-C6
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 20:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1irXRE-000360-MU
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1irXRD-0005nO-5f
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:25:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2731 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1irXR8-0005Vg-Hf; Tue, 14 Jan 2020 20:25:35 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AFF11D598492DF987BE8;
 Wed, 15 Jan 2020 09:25:24 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 Jan 2020
 09:25:17 +0800
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified by
 _HID
To: Andrew Jones <drjones@redhat.com>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200113130802.5a961482@redhat.com>
 <b5d91ae3-bf37-d27e-264d-ea21ef23776b@huawei.com>
 <20200113152623.dlkxsrs7nr6uriyn@kamzik.brq.redhat.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <8cbaf4c3-ed40-c386-fd6c-332cc831890f@huawei.com>
Date: Wed, 15 Jan 2020 09:25:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113152623.dlkxsrs7nr6uriyn@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E5=9C=A8 2020/1/13 23:26, Andrew Jones =E5=86=99=E9=81=93:
> On Mon, Jan 13, 2020 at 09:57:55PM +0800, Guoheyi wrote:
>> =E5=9C=A8 2020/1/13 20:08, Igor Mammedov =E5=86=99=E9=81=93:
>>> On Thu, 19 Dec 2019 14:47:59 +0800
>>> Heyi Guo <guoheyi@huawei.com> wrote:
>>>
>>>> According to ACPI spec, _ADR should be used for device which is on a
>>>> bus that has a standard enumeration algorithm. It does not make sens=
e
>>>> to have a _ADR object for devices which already have _HID and will b=
e
>>>> enumerated by OSPM.
>>>>
>>>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>>> Are you sure it's does not make sense?
>>> Have you checked commit f264d51d8, that added _ADR?
>> I searched in SPCR spec and ACPI spec, but didn't find such requiremen=
t for
>> serial port device description.
>>
>> Hi Andrew,
>>
>> Could you help to explain the reason?
> tl;dr: It was a mistake and I agree with removing _ADR from SPCR.
>
> The long version is that ACPI support for ARM took a long time to get
> merged upstream. In the meantime Linaro and Red Hat had ACPI support
> in their downstream trees. The initial, never upstreamed implementation
> of Linux SPCR support used _ADR to find the console UART (probably
> because some vendor hacked their ACPI tables that way). I made the
> mistake of using the out-of-tree Linux kernel code as my "specification=
".
>
> Upstream kernels never had this problem and I don't think we need to
> worry about any of those downstream kernels which did. They'd be five
> years old by now anyway.
>
> Thanks,
> drew

Thanks for your confirmation, Andrew.

Hi Igor,

On arm64 physical machine, we didn't have _ADR for SPCR serial port=20
device attached to system bus either, and we never saw any problem.

Thanks,

Heyi

>> Thanks,
>>
>> Heyi
>>
>>
>>
>>>> ---
>>>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>> Cc: qemu-arm@nongnu.org
>>>> Cc: qemu-devel@nongnu.org
>>>> ---
>>>>    hw/arm/virt-acpi-build.c          |   8 --------
>>>>    tests/data/acpi/virt/DSDT         | Bin 18449 -> 18426 bytes
>>>>    tests/data/acpi/virt/DSDT.memhp   | Bin 19786 -> 19763 bytes
>>>>    tests/data/acpi/virt/DSDT.numamem | Bin 18449 -> 18426 bytes
>>>>    4 files changed, 8 deletions(-)
>>>>
>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>> index 9f4c7d1889..be752c0ad8 100644
>>>> --- a/hw/arm/virt-acpi-build.c
>>>> +++ b/hw/arm/virt-acpi-build.c
>>>> @@ -78,11 +78,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const =
MemMapEntry *uart_memmap,
>>>>                                 AML_EXCLUSIVE, &uart_irq, 1));
>>>>        aml_append(dev, aml_name_decl("_CRS", crs));
>>>> -    /* The _ADR entry is used to link this device to the UART descr=
ibed
>>>> -     * in the SPCR table, i.e. SPCR.base_address.address =3D=3D _AD=
R.
>>>> -     */
>>>> -    aml_append(dev, aml_name_decl("_ADR", aml_int(uart_memmap->base=
)));
>>>> -
>>>>        aml_append(scope, dev);
>>>>    }
>>>> @@ -170,7 +165,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const =
MemMapEntry *memmap,
>>>>        aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")))=
;
>>>>        aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
>>>>        aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
>>>> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>>>>        aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
>>>>        aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Dev=
ice")));
>>>>        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>>>> @@ -334,7 +328,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const=
 MemMapEntry *gpio_memmap,
>>>>    {
>>>>        Aml *dev =3D aml_device("GPO0");
>>>>        aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061"))=
);
>>>> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>>>>        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>>>>        Aml *crs =3D aml_resource_template();
>>>> @@ -364,7 +357,6 @@ static void acpi_dsdt_add_power_button(Aml *scop=
e)
>>>>    {
>>>>        Aml *dev =3D aml_device(ACPI_POWER_BUTTON_DEVICE);
>>>>        aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")))=
;
>>>> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>>>>        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>>>>        aml_append(scope, dev);
>>>>    }
>>>> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
>>>> index b5895cb22446860a0b9be3d32ec856feb388be4c..a759ff739a071d5fbf50=
519a6aea296e5e0f1e0c 100644
>>>> GIT binary patch
>>>> delta 72
>>>> zcmbO@f$>*ABbQ6COUN&G1_q{66S<_BT5Bh&t1wzk^tIeLL4lL8ZSqD=3DgU!!5x$Pt+
>>>> c1HyxxIO07#U3dfh0t}oDoEbRcLp@y>07w882mk;8
>>>>
>>>> delta 94
>>>> zcmey>&p2@cBbQ6CONgKc0|V26iCof5J#`b+RhV2^Ci+-%al|{i1o1F1FmP^cRp4ao
>>>> tnY@hCfEg&X`7$S;oxFTNc#soEyoaX?Z-8HbfwO@#16Tu)4E1zj005fm7mWY_
>>>>
>>>> diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/=
DSDT.memhp
>>>> index 69ad844f65d047973a3e55198beecd45a35b8fce..6e5cc61977e4cd24f765=
fec0693f75a528c144c1 100644
>>>> GIT binary patch
>>>> delta 72
>>>> zcmX>#i*fTTMlP3Nmk?uL1_q|eiCof5eHSLGt1wzk^tIeLL4lL8ZSqD=3DgU!!5U7RH)
>>>> c1HyxxIO07#U3dfh0t}oDoEbRcLp@y>03)CjmjD0&
>>>>
>>>> delta 94
>>>> zcmdlyi}BPfMlP3Nmk=3D*s1_q}3iCof5t(PXMt1!8;O!Tqj;)r*23F2X3VBp-?s=3D&=
$E
>>>> tGkF=3DO0W(l&^JPwVXL<R6@E|9Scn?n(-T=3DP<17`zg2CxPo8S3f6006qZ7#siq
>>>>
>>>> diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/vir=
t/DSDT.numamem
>>>> index b5895cb22446860a0b9be3d32ec856feb388be4c..a759ff739a071d5fbf50=
519a6aea296e5e0f1e0c 100644
>>>> GIT binary patch
>>>> delta 72
>>>> zcmbO@f$>*ABbQ6COUN&G1_q{66S<_BT5Bh&t1wzk^tIeLL4lL8ZSqD=3DgU!!5x$Pt+
>>>> c1HyxxIO07#U3dfh0t}oDoEbRcLp@y>07w882mk;8
>>>>
>>>> delta 94
>>>> zcmey>&p2@cBbQ6CONgKc0|V26iCof5J#`b+RhV2^Ci+-%al|{i1o1F1FmP^cRp4ao
>>>> tnY@hCfEg&X`7$S;oxFTNc#soEyoaX?Z-8HbfwO@#16Tu)4E1zj005fm7mWY_
>>>>
>>> .
>>
>
> .


