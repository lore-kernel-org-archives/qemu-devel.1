Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E137FC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62E82054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62E82054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKzAM-0007OQ-UW
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 02:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iKz9e-0006qP-N8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iKz9d-00027u-Ip
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:20:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58366 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iKz9a-00026V-OZ; Thu, 17 Oct 2019 02:20:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EE5F4266ADB1D7F2B102;
 Thu, 17 Oct 2019 14:20:49 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 14:20:39 +0800
Subject: Re: [PATCH v19 3/5] ACPI: Add APEI GHES table generation support
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191015140140.34748-1-zhengxiang9@huawei.com>
 <20191015140140.34748-4-zhengxiang9@huawei.com>
 <CAFEAcA9CWPKF5XibFtZRwavVj4PboGoaM5368Omje6qrOjV3AQ@mail.gmail.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <f35f10ec-c5e0-bcdc-48a9-ceb754cf1fc1@huawei.com>
Date: Thu, 17 Oct 2019 14:20:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9CWPKF5XibFtZRwavVj4PboGoaM5368Omje6qrOjV3AQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
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



On 2019/10/15 22:52, Peter Maydell wrote:
> On Tue, 15 Oct 2019 at 15:02, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>>
>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>
>> This patch implements APEI GHES Table generation via fw_cfg blobs. Now
>> it only supports ARMv8 SEA, a type of GHESv2 error source. Afterwards,
>> we can extend the supported types if needed. For the CPER section,
>> currently it is memory section because kernel mainly wants userspace to
>> handle the memory errors.
>>
>> This patch follows the spec ACPI 6.2 to build the Hardware Error Source
>> table. For more detailed information, please refer to document:
>> docs/specs/acpi_hest_ghes.rst
>>
>> Suggested-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> 
>> +    /* Error Status Address */
>> +    build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0,
>> +                     4 /* QWord access */, 0);
> 
> Hi; this doesn't seem to compile with clang:
> 
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/acpi/acpi_ghes.c:330:34:
> error: implicit conversion from
>       enumeration type 'AmlRegionSpace' to different enumeration type
> 'AmlAddressSpace'
>       [-Werror,-Wenum-conversion]
>     build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0,
>     ~~~~~~~~~~~~~~~~             ^~~~~~~~~~~~~~~~~
> /home/petmay01/linaro/qemu-from-laptop/qemu/hw/acpi/acpi_ghes.c:351:34:
> error: implicit conversion from
>       enumeration type 'AmlRegionSpace' to different enumeration type
> 'AmlAddressSpace'
>       [-Werror,-Wenum-conversion]
>     build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0,
>     ~~~~~~~~~~~~~~~~             ^~~~~~~~~~~~~~~~~
> 2 errors generated.
> 
> Should these be AML_AS_SYSTEM_MEMORY, or should the build_append_gas()
> function be taking an AmlRegionSpace rather than an AmlAddressSpace ?

Yes, these should be AML_AS_SYSTEM_MEMORY, the first field of Generic Address
Structure(GAS) is Address Space ID. I will fix these compile errors.

> 
> thanks
> -- PMM
> 
> .
> 

-- 

Thanks,
Xiang


