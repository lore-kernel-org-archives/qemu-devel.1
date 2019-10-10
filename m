Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D093DC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8784214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8784214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYCH-0002sb-RH
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iIYBR-0001qu-Et
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iIYBQ-0006rr-58
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:08:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55790 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iIYBI-0006jD-LU; Thu, 10 Oct 2019 09:08:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id AF8AC4877A4713569682;
 Thu, 10 Oct 2019 21:08:28 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 10 Oct 2019
 21:08:22 +0800
Subject: Re: [RFC PATCH 12/12] virt/acpi: add SDEI table if SDEI is enabled
To: Igor Mammedov <imammedo@redhat.com>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <1569338511-3572-13-git-send-email-guoheyi@huawei.com>
 <20191010111537.5e2dd584@redhat.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <3e889d37-b877-f7b5-7ee3-70cef6d8e9c1@huawei.com>
Date: Thu, 10 Oct 2019 21:08:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191010111537.5e2dd584@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 James Morse <james.morse@arm.com>, wanghaibin.wang@huawei.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for your comments.

On 2019/10/10 17:15, Igor Mammedov wrote:
> On Tue, 24 Sep 2019 23:21:51 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> Add SDEI table if SDEI is enabled, so that guest OS can get aware and
>> utilize the interfaces.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> ---
>>   hw/arm/virt-acpi-build.c    | 16 ++++++++++++++++
>>   include/hw/acpi/acpi-defs.h |  5 +++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 6cdf156..1088214 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -32,6 +32,7 @@
>>   #include "trace.h"
>>   #include "hw/core/cpu.h"
>>   #include "target/arm/cpu.h"
>> +#include "target/arm/sdei.h"
>>   #include "hw/acpi/acpi-defs.h"
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/nvram/fw_cfg.h"
>> @@ -475,6 +476,16 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>   }
>>   
> here should be a comment describing purpose with a reference to spec
OK.

>
>>   static void
>> +build_sdei(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>> +{
>> +    int sdei_start = table_data->len;
>> +
>> +    (void)acpi_data_push(table_data, sizeof(AcpiSdei));
>> +    build_header(linker, table_data, (void *)(table_data->data + sdei_start),
>> +                 "SDEI", table_data->len - sdei_start, 1, NULL, NULL);
>> +}
> that's dummy table and doesn't match what spec describes,
> It doesn't look correct SDEI table.

Refer to below document, Appendix C, I see the definition of SDEI is 
really a dummy table, also it is said in the document: The table 
consists only of a basic header with revision 1.

http://infocenter.arm.com/help/topic/com.arm.doc.den0054a/ARM_DEN0054A_Software_Delegated_Exception_Interface.pdf

Do I miss anything?

>
>> +
>> +static void
>>   build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>   {
>>       AcpiSerialPortConsoleRedirection *spcr;
>> @@ -796,6 +807,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>       acpi_add_table(table_offsets, tables_blob);
>>       build_spcr(tables_blob, tables->linker, vms);
>>   
>> +    if (sdei_enabled) {
>> +        acpi_add_table(table_offsets, tables_blob);
>> +        build_sdei(tables_blob, tables->linker, vms);
>> +    }
>> +
>>       if (ms->numa_state->num_nodes > 0) {
>>           acpi_add_table(table_offsets, tables_blob);
>>           build_srat(tables_blob, tables->linker, vms);
>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>> index 57a3f58..0a2265d 100644
>> --- a/include/hw/acpi/acpi-defs.h
>> +++ b/include/hw/acpi/acpi-defs.h
>> @@ -634,4 +634,9 @@ struct AcpiIortRC {
>>   } QEMU_PACKED;
>>   typedef struct AcpiIortRC AcpiIortRC;
>>   
>> +struct AcpiSdei {
>> +    ACPI_TABLE_HEADER_DEF     /* ACPI common table header */
>> +} QEMU_PACKED;
>> +typedef struct AcpiSdei AcpiSdei;
> we don't use packed structures for ACPI anymore, see build_rsdp() for
> example of how tables are composed and comment style required for each field.
Sure; will fix it in v2.

Thanks,

Heyi

>
>>   #endif
>
> .
>



