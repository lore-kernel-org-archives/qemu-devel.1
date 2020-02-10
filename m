Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A183FC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CF52080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CF52080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j175o-0002GA-I6
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1j175C-0001kF-5b
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1j175A-00022m-Ra
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:18:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2700 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1j1757-0001rJ-E8; Mon, 10 Feb 2020 06:18:25 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 81946A329E95B9C74D68;
 Mon, 10 Feb 2020 19:18:16 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 19:18:07 +0800
Subject: Re: [PATCH v22 4/9] ACPI: Build Hardware Error Source Table
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-5-git-send-email-gengdongjiu@huawei.com>
 <20200205164328.00006f1e@Huawei.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <f24fb648-a06b-0b97-1afa-e4ed6137a7d4@huawei.com>
Date: Mon, 10 Feb 2020 19:18:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20200205164328.00006f1e@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
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
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/6 0:43, Jonathan Cameron wrote:
> On Wed, 8 Jan 2020 19:32:18 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
>> This patch builds Hardware Error Source Table(HEST) via fw_cfg blobs.
>> Now it only supports ARMv8 SEA, a type of Generic Hardware Error
>> Source version 2(GHESv2) error source. Afterwards, we can extend
>> the supported types if needed. For the CPER section, currently it
>> is memory section because kernel mainly wants userspace to handle
>> the memory errors.
>>
>> This patch follows the spec ACPI 6.2 to build the Hardware Error
>> Source table. For more detailed information, please refer to
>> document: docs/specs/acpi_hest_ghes.rst
>>
>> build_append_ghes_notify() will help to add Hardware Error Notification
>> to ACPI tables without using packed C structures and avoid endianness
>> issues as API doesn't need explicit conversion.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Acked-by: Xiang Zheng <zhengxiang9@huawei.com>
> 
> Hi. 
> 
> I was forwards porting my old series adding CCIX error injection support
> and came across a place this could 'possibly' be improved.

Jonathan, It is great that you add CCIX error injection support based on this series.
thanks for using it.

> 
> I say possibly because it's really about enabling more flexibility
> in how this code is reused than actually 'fixing' anything here.
> 
> If you don't make the change here, I'll just add a precursor patch to my
> series.  Just seems nice to tidy it up at source.

sure, I make a change to make your patch work well.

> 
> The rest of the partMake your patch very good work.s of this series I am using seems to work great.




> 
> Thanks!
> 
> Jonathan
> 
>> ---
>>  hw/acpi/ghes.c           | 118 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  hw/arm/virt-acpi-build.c |   2 +
>>  include/hw/acpi/ghes.h   |  40 ++++++++++++++++
>>  3 files changed, 159 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>> index b7fdbbb..9d37798 100644
>> --- a/hw/acpi/ghes.c
>> +++ b/hw/acpi/ghes.c
>> @@ -34,9 +34,42 @@
>> +
> ...
>> +/* Build Generic Hardware Error Source version 2 (GHESv2) */
>> +static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> This function takes source ID, which uses the enum of all sources registered.
> However, it doesn't use it to locate the actual physical addresses.
> 
> Currently the code effectively assumes the value is 0.

yes, because there is only one source, so the value is 0.

> 
>> +{
>> +    uint64_t address_offset;
>> +    /*
>> +     * Type:
>> +     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
>> +     */
>> +    build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
>> +    /* Source Id */
>> +    build_append_int_noprefix(table_data, source_id, 2);
>> +    /* Related Source Id */
>> +    build_append_int_noprefix(table_data, 0xffff, 2);
>> +    /* Flags */
>> +    build_append_int_noprefix(table_data, 0, 1);
>> +    /* Enabled */
>> +    build_append_int_noprefix(table_data, 1, 1);
>> +
>> +    /* Number of Records To Pre-allocate */
>> +    build_append_int_noprefix(table_data, 1, 4);
>> +    /* Max Sections Per Record */
>> +    build_append_int_noprefix(table_data, 1, 4);
>> +    /* Max Raw Data Length */
>> +    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
>> +
>> +    address_offset = table_data->len;
>> +    /* Error Status Address */
>> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>> +                     4 /* QWord access */, 0);
>> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>> +        address_offset + GAS_ADDR_OFFSET,
>> +        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
> 
> The offset here would need to be source_id * sizeof(uint64_t) I think
> 
>> +
>> +    /*
>> +     * Notification Structure
>> +     * Now only enable ARMv8 SEA notification type
>> +     */
>> +    build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
> Perhaps a switch for this to allow for other options later.

OK, I will make this change in order to easily support more hardware error source.

> 
> 	switch (source_id) {
> 	case ACPI_HEST_SRC_ID_SEA:
> 		...
> 		break;
> 	default:
> 	//print some error message.
> 
> 	}

ok

>> +
>> +    /* Error Status Block Length */
>> +    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
>> +
>> +    /*
>> +     * Read Ack Register
>> +     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
>> +     * version 2 (GHESv2 - Type 10)
>> +     */
>> +    address_offset = table_data->len;
>> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>> +                     4 /* QWord access */, 0);
>> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>> +        address_offset + GAS_ADDR_OFFSET,
>> +        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
>> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t));
> 
> Offset of (ACPI_GHES_ERROR_SOURCE_COUNT + source_id) * sizeof(uint64_t)
yes, It due to I only support one source, the source_id is zero and not use it.
In order to easily extend, I will add this change.

> 
>> +
>> +    /*
>> +     * Read Ack Preserve
>> +     * We only provide the first bit in Read Ack Register to OSPM to write
>> +     * while the other bits are preserved.
>> +     */
>> +    build_append_int_noprefix(table_data, ~0x1ULL, 8);
>> +    /* Read Ack Write */
>> +    build_append_int_noprefix(table_data, 0x1, 8);
>> +}
> 
> 
> 
> .
> 


