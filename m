Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17141C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AF82082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AF82082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he0kU-0003tg-7Z
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 13:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gengdongjiu@huawei.com>) id 1he0hP-0001wb-SO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1he0hO-0006LJ-7x
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:18:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40076 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1he0hK-0006Bn-1m; Thu, 20 Jun 2019 13:18:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8DA1CE588E5E94AEC6A2;
 Fri, 21 Jun 2019 01:17:58 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Jun 2019
 01:17:49 +0800
To: Igor Mammedov <imammedo@redhat.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-3-git-send-email-gengdongjiu@huawei.com>
 <20190620141052.370788fb@redhat.com>
 <f4f94ecb-200c-3e18-1a09-5fb6bc761834@huawei.com>
 <20190620170934.39eae310@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <ec089c94-589b-782c-1bdc-1b2c74e0ea46@huawei.com>
Date: Fri, 21 Jun 2019 01:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190620170934.39eae310@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [PATCH v17 02/10] ACPI: add some GHES structures
 and macros definition
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/6/20 23:09, Igor Mammedov wrote:
> On Thu, 20 Jun 2019 22:04:01 +0800
> gengdongjiu <gengdongjiu@huawei.com> wrote:
>=20
>> Hi Igor,
>>    Thanks for your review.
>>
>> On 2019/6/20 20:10, Igor Mammedov wrote:
>>>> + */
>>>> +struct AcpiGenericErrorStatus {
>>>> +    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
>>>> +    uint32_t block_status;
>>>> +    uint32_t raw_data_offset;
>>>> +    uint32_t raw_data_length;
>>>> +    uint32_t data_length;
>>>> +    uint32_t error_severity;
>>>> +} QEMU_PACKED;
>>>> +typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus; =20
>>> there shouldn't be packed structures,
>>> is it a leftover from previous version? =20
>>
>> I remember some people suggest to add QEMU_PACKED before, anyway I wil=
l remove it in my next version patch.
>=20
> Question is why it's  there and where it is used?
sorry, it is my carelessness. it should be packed structures.

I used this structures to get its actual total size and member offset in =
[PATCH v17 10/10].
If it is not packed structures, the total size and member offset may be n=
ot right.


>=20
> BTW:
> series doesn't apply to master anymore.
> Do you have a repo somewhere available for testing?

Thanks, I appreciated that you can have a test.

I still do not upload repo, you can reset to below commit[1] in master an=
d apply this series.

BTW=EF=BC=9A
If test series, you should make an guest memory hardware error, let guest=
 access the error address, then it will happen RAS error.
I provide a software hard code method to test this series, you can refer =
to https://www.mail-archive.com/qemu-devel@nongnu.org/msg619771.html


[1]:
commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8
Merge: 5f02262 e841257
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri May 10 14:49:36 2019 +0100



>=20
>>
>>>  =20
>>>> +
>>>> +/*
>>>> + * Masks for block_status flags above
>>>> + */
>>>> +#define ACPI_GEBS_UNCORRECTABLE         1
>>>> +
>>>> +/* =20
>>
>=20
> .
>=20


