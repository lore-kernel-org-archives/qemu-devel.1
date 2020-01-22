Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B15C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4598B24655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4598B24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9gJ-00010t-FT
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iu9fX-0000Sl-HK
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iu9fW-0004i4-Dz
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:39:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35300 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iu9fT-0004YR-Jw; Wed, 22 Jan 2020 01:39:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 33DF92AD10A168568D0B;
 Wed, 22 Jan 2020 14:39:01 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 14:38:54 +0800
Subject: Re: [PATCH 1/2] arm/virt/acpi: remove meaningless sub device "PR0"
 from PCI0
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-2-guoheyi@huawei.com>
 <20200122003809-mutt-send-email-mst@kernel.org>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <0db6ff09-3575-465f-0c22-f47c4c056da5@huawei.com>
Date: Wed, 22 Jan 2020 14:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122003809-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=D4=DA 2020/1/22 13:39, Michael S. Tsirkin =D0=B4=B5=C0:
> On Thu, Dec 19, 2019 at 02:47:58PM +0800, Heyi Guo wrote:
>> The sub device "PR0" under PCI0 in ACPI/DSDT does not make any sense,
>> so simply remote it.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> So given this has no methods except _ADR, I think it's
> safe to remove:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks.

I'll send v2 to fix up the commit message, and follow the new work flow=20
we disscussed earlier. I found some more issues in ARM ACPI, which will=20
also be included in v2.

Heyi

>
>
>> ---
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>> Cc: qemu-arm@nongnu.org
>> Cc: qemu-devel@nongnu.org
>> ---
>>   hw/arm/virt-acpi-build.c          |   4 ----
>>   tests/data/acpi/virt/DSDT         | Bin 18462 -> 18449 bytes
>>   tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 19786 bytes
>>   tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 18449 bytes
>>   4 files changed, 4 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index bd5f771e9b..9f4c7d1889 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -317,10 +317,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const M=
emMapEntry *memmap,
>>       aml_append(method, aml_return(buf));
>>       aml_append(dev, method);
>>  =20
>> -    Aml *dev_rp0 =3D aml_device("%s", "RP0");
>> -    aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
>> -    aml_append(dev, dev_rp0);
>> -
>>       Aml *dev_res0 =3D aml_device("%s", "RES0");
>>       aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")=
));
>>       crs =3D aml_resource_template();
>> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
>> index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..b5895cb22446860a0b9be3=
d32ec856feb388be4c 100644
>> GIT binary patch
>> delta 39
>> vcmbO?fpOvlMlP3Nmk>b@1_q`B6S<_Bdg?Z+cXBfI+}XT|v(|R9jr$`2@RSW)
>>
>> delta 50
>> zcmbO@fpOjhMlP3Nmk>D*1_q{tiCof5o%I{lJ2{y;?{412S!>J19TZ>?&k^tF5;R%I
>> G{V4!>hYx%J
>>
>> diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DS=
DT.memhp
>> index 41ccc6431b917252bcbaac86c33b340c796be5ce..69ad844f65d047973a3e55=
198beecd45a35b8fce 100644
>> GIT binary patch
>> delta 40
>> wcmcaUi}BPfMlP3Nmk=3D*s1_q}3iCof5t(P{ccXBfI+}XT|v(|RAjk`1(02g)*ivR!s
>>
>> delta 51
>> zcmX>#i}Cs_MlP3NmymE@1_mbiiCof5O_w*ScXBdy-rc;3v(}c2J1D>)o+IATC1|sb
>> HyBr$;t7;Fc
>>
>> diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/=
DSDT.numamem
>> index d0f3afeb134fdf1c11f64cd06dbcdd30be603b80..b5895cb22446860a0b9be3=
d32ec856feb388be4c 100644
>> GIT binary patch
>> delta 39
>> vcmbO?fpOvlMlP3Nmk>b@1_q`B6S<_Bdg?Z+cXBfI+}XT|v(|R9jr$`2@RSW)
>>
>> delta 50
>> zcmbO@fpOjhMlP3Nmk>D*1_q{tiCof5o%I{lJ2{y;?{412S!>J19TZ>?&k^tF5;R%I
>> G{V4!>hYx%J
>>
>> --=20
>> 2.19.1
>
> .


