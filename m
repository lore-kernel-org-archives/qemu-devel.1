Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE364C33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 08:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A56C205F4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 08:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A56C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it5pN-0008Vt-Pd
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 03:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1it5od-0007su-Gl
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1it5oc-0006ZR-Bf
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:20:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2686 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1it5oZ-0006Pr-Cq; Sun, 19 Jan 2020 03:20:11 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6B101EBA86C3279E3455;
 Sun, 19 Jan 2020 16:20:02 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 16:19:54 +0800
Subject: Re: [PATCH v22 9/9] MAINTAINERS: Add ACPI/HEST/GHES entries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-10-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA-mLgD8rQ211ep44nd8oxTKSnxc7YmY+nPtADpKZk5asA@mail.gmail.com>
 <1c45a8b4-1ea4-ddfd-cce3-c42699d2b3b9@redhat.com>
 <CAFEAcA_QO1t10EJySQ5tbOHNuXgzQnJrN28n7fmZt_7aP=hvzA@mail.gmail.com>
 <724fbf58-19df-593c-b665-2c2e9fe71189@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <ebf18e13-4f7e-9002-6774-5977a243fca7@huawei.com>
Date: Sun, 19 Jan 2020 16:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <724fbf58-19df-593c-b665-2c2e9fe71189@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/1/17 19:22, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/17/20 12:09 PM, Peter Maydell wrote:
>> On Fri, 17 Jan 2020 at 07:22, Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> On 1/16/20 5:46 PM, Peter Maydell wrote:
>>>> On Wed, 8 Jan 2020 at 11:32, Dongjiu Geng <gengdongjiu@huawei.com> w=
rote:
>>>>>
>>>>> I and Xiang are willing to review the APEI-related patches and
>>>>> volunteer as the reviewers for the HEST/GHES part.
>>>>>
>>>>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>>>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 MAINTAINERS | 9 +++++++++
>>>>> =C2=A0=C2=A0 1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 387879a..5af70a5 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -1423,6 +1423,15 @@ F: tests/bios-tables-test.c
>>>>> =C2=A0=C2=A0 F: tests/acpi-utils.[hc]
>>>>> =C2=A0=C2=A0 F: tests/data/acpi/
>>>>>
>>>>> +ACPI/HEST/GHES
>>>>> +R: Dongjiu Geng <gengdongjiu@huawei.com>
>>>>> +R: Xiang Zheng <zhengxiang9@huawei.com>
>>>>> +L: qemu-arm@nongnu.org
>>>>> +S: Maintained
>>>>> +F: hw/acpi/ghes.c
>>>>> +F: include/hw/acpi/ghes.h
>>>>> +F: docs/specs/acpi_hest_ghes.rst
>>>>> +
>>>>> =C2=A0=C2=A0 ppc4xx
>>>>> =C2=A0=C2=A0 M: David Gibson <david@gibson.dropbear.id.au>
>>>>> =C2=A0=C2=A0 L: qemu-ppc@nongnu.org
>>>>> --=20
>>>>
>>>> Michael, Igor: since this new MAINTAINERS section is
>>>> moving files out of the 'ACPI/SMBIOS' section that you're
>>>> currently responsible for, do you want to provide an
>>>> acked-by: that you think this division of files makes sense?
>>>
>>> The files are not 'moved out', Michael and Igor are still the
>>> maintainers of the supported ACPI/SMBIOS subsystem:=20

In fact, I am willing to maintain with others to the new added files , I =
see some new added files in "hw/acpi" folders are moved out, such as NVDI=
MM/vmgenid.

NVDIMM
M: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
S: Maintained
F: hw/acpi/nvdimm.c
F: hw/mem/nvdimm.c
F: include/hw/mem/nvdimm.h
F: docs/nvdimm.txt

VM Generation ID
M: Ben Warren <ben@skyportsystems.com>
S: Maintained
F: hw/acpi/vmgenid.c
F: include/hw/acpi/vmgenid.h
F: docs/specs/vmgenid.txt
F: tests/vmgenid-test.c
F: stubs/vmgenid.c


