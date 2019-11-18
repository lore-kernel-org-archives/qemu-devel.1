Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14826C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 06:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7172073A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 06:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7172073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWao3-00031F-QF
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 01:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iWamZ-0002Kf-62
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iWamX-0006s9-Ue
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 01:45:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2265 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iWamU-0006ny-Dy; Mon, 18 Nov 2019 01:45:02 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 94E87DE79A226FC2095D;
 Mon, 18 Nov 2019 14:44:52 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 14:44:37 +0800
Subject: Re: [RFC v2 14/14] virt/acpi: add SDEI table if SDEI is enabled
To: Igor Mammedov <imammedo@redhat.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-15-guoheyi@huawei.com>
 <20191112155253.543e15ad@redhat.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <9f032ccc-ae43-3710-daa8-445c6069903e@huawei.com>
Date: Mon, 18 Nov 2019 14:44:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191112155253.543e15ad@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, Shannon
 Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 James Morse <james.morse@arm.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/11/12 22:52, Igor Mammedov wrote:
> On Tue, 5 Nov 2019 17:10:56 +0800
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
>>
>> Notes:
>>      v2:
>>      - Drop SDEI table definition and add comments
>>
>>   hw/arm/virt-acpi-build.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 4cd50175e0..73d3f8cd15 100644
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
>> @@ -475,6 +476,26 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>                    "IORT", table_data->len - iort_start, 0, NULL, NULL);
>>   }
>>   
>> +/*
>> + * ACPI spec 6.2 Software Delegated Exception Interface (SDEI).
>> + * (Revision 1.0)
>> + * "SDEI" was reserved in ACPI 6.2. See "Links to ACPI-Related Documents"
>> + * (http://uefi.org/acpi) under the heading "Software
>> + * Delegated Exceptions Interface." The definition is under
>> + * "10 Appendix C: ACPI table definitions for SDEI" in the linked document.
>> + *
>> + * This is a dummy table to expose platform SDEI capbility to OS.
>> + */
>> +static void
>> +build_sdei(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>> +{
>> +    int sdei_start = table_data->len;
>> +
>> +    (void)acpi_data_push(table_data, sizeof(AcpiTableHeader));
>> +    build_header(linker, table_data, (void *)(table_data->data + sdei_start),
>> +                 "SDEI", table_data->len - sdei_start, 1, NULL, NULL);
>> +}
>> +
>>   static void
>>   build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>   {
>> @@ -825,6 +846,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>       acpi_add_table(table_offsets, tables_blob);
>>       build_spcr(tables_blob, tables->linker, vms);
>>   
>> +    if (sdei_enabled) {
> globals shouldn't be introduced in new code
OK. For this feature depends on KVM, does it make sense to add a flag to 
struct VirtMachineState?

Thanks,
HG
>
>> +        acpi_add_table(table_offsets, tables_blob);
>> +        build_sdei(tables_blob, tables->linker, vms);
>> +    }
>> +
>>       if (ms->numa_state->num_nodes > 0) {
>>           acpi_add_table(table_offsets, tables_blob);
>>           build_srat(tables_blob, tables->linker, vms);
>
> .
>



