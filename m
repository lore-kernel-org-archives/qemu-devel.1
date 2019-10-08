Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A16C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE06B20640
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE06B20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHow3-0004Tp-Q0
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iHovC-0003sx-LW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iHovA-0004u7-Du
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:48:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56686 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iHov4-0004VK-T5; Tue, 08 Oct 2019 08:48:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6665B76A80E735CDFC6C;
 Tue,  8 Oct 2019 20:48:45 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 20:48:35 +0800
Subject: Re: [PATCH v18 3/6] ACPI: Add APEI GHES table generation support
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-4-zhengxiang9@huawei.com>
 <20190927113018-mutt-send-email-mst@kernel.org>
 <b554117d-87c2-a469-d3fe-fc2444b33fcc@huawei.com>
 <20191008033417-mutt-send-email-mst@kernel.org>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <f5fe5853-b0f0-4d8a-75e9-3da647e810e6@huawei.com>
Date: Tue, 8 Oct 2019 20:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008033417-mutt-send-email-mst@kernel.org>
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 imammedo@redhat.com, pbonzini@redhat.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, wanghaibin.wang@huawei.com,
 gengdongjiu@huawei.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/10/8 15:45, Michael S. Tsirkin wrote:
> On Tue, Oct 08, 2019 at 02:00:56PM +0800, Xiang Zheng wrote:
>> Hi Michael,
>>
>> Thanks for your review!
>>
>> On 2019/9/27 23:43, Michael S. Tsirkin wrote:
>>> On Fri, Sep 06, 2019 at 04:31:49PM +0800, Xiang Zheng wrote:
>>>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>>>
>>>> This patch implements APEI GHES Table generation via fw_cfg blobs. Now
>>>> it only supports ARMv8 SEA, a type of GHESv2 error source. Afterwards,
>>>> we can extend the supported types if needed. For the CPER section,
>>>> currently it is memory section because kernel mainly wants userspace to
>>>> handle the memory errors.
>>>>
>>>> This patch follows the spec ACPI 6.2 to build the Hardware Error Source
>>>> table. For more detailed information, please refer to document:
>>>> docs/specs/acpi_hest_ghes.txt
>>>>
>>>> Suggested-by: Laszlo Ersek <lersek@redhat.com>
>>>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>>>> ---
>>>>  default-configs/arm-softmmu.mak |   1 +
>>>>  hw/acpi/Kconfig                 |   4 +
>>>>  hw/acpi/Makefile.objs           |   1 +
>>>>  hw/acpi/acpi_ghes.c             | 210 ++++++++++++++++++++++++++++++++
>>>>  hw/acpi/aml-build.c             |   2 +
>>>>  hw/arm/virt-acpi-build.c        |  12 ++
>>>>  include/hw/acpi/acpi_ghes.h     | 103 ++++++++++++++++
>>>>  include/hw/acpi/aml-build.h     |   1 +
>>>>  8 files changed, 334 insertions(+)
>>>>  create mode 100644 hw/acpi/acpi_ghes.c
>>>>  create mode 100644 include/hw/acpi/acpi_ghes.h
>>>>
>>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>>>> index 1f2e0e7fde..5722f3130e 100644
>>>> --- a/default-configs/arm-softmmu.mak
>>>> +++ b/default-configs/arm-softmmu.mak
>>>> @@ -40,3 +40,4 @@ CONFIG_FSL_IMX25=y
>>>>  CONFIG_FSL_IMX7=y
>>>>  CONFIG_FSL_IMX6UL=y
>>>>  CONFIG_SEMIHOSTING=y
>>>> +CONFIG_ACPI_APEI=y
>>>> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
>>>> index 7c59cf900b..2c4d0b9826 100644
>>>> --- a/hw/acpi/Kconfig
>>>> +++ b/hw/acpi/Kconfig
>>>> @@ -23,6 +23,10 @@ config ACPI_NVDIMM
>>>>      bool
>>>>      depends on ACPI
>>>>  
>>>> +config ACPI_APEI
>>>> +    bool
>>>> +    depends on ACPI
>>>> +
>>>>  config ACPI_PCI
>>>>      bool
>>>>      depends on ACPI && PCI
>>>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>>>> index 9bb2101e3b..93fd8e8f64 100644
>>>> --- a/hw/acpi/Makefile.objs
>>>> +++ b/hw/acpi/Makefile.objs
>>>> @@ -5,6 +5,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
>>>>  common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>>>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>>>>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>>>> +common-obj-$(CONFIG_ACPI_APEI) += acpi_ghes.o
>>>>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
>>>>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>>>>  
>>>> diff --git a/hw/acpi/acpi_ghes.c b/hw/acpi/acpi_ghes.c
>>>> new file mode 100644
>>>> index 0000000000..20c45179ff
>>>> --- /dev/null
>>>> +++ b/hw/acpi/acpi_ghes.c
>>>> @@ -0,0 +1,210 @@
>>>> +/* Support for generating APEI tables and record CPER for Guests
>>>> + *
>>>> + * Copyright (C) 2019 Huawei Corporation.
>>>> + *
>>>> + * Author: Dongjiu Geng <gengdongjiu@huawei.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License as published by
>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>> + * (at your option) any later version.
>>>> +
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> +
>>>> + * You should have received a copy of the GNU General Public License along
>>>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/acpi/acpi.h"
>>>> +#include "hw/acpi/aml-build.h"
>>>> +#include "hw/acpi/acpi_ghes.h"
>>>> +#include "hw/nvram/fw_cfg.h"
>>>> +#include "sysemu/sysemu.h"
>>>> +#include "qemu/error-report.h"
>>>> +
>>>> +/* Hardware Error Notification
>>>> + * ACPI 4.0: 17.3.2.7 Hardware Error Notification
>>>> + */
>>>> +static void acpi_ghes_build_notify(GArray *table, const uint8_t type,
>>>> +                                   uint8_t length, uint16_t config_write_enable,
>>>> +                                   uint32_t poll_interval, uint32_t vector,
>>>> +                                   uint32_t polling_threshold_value,
>>>> +                                   uint32_t polling_threshold_window,
>>>> +                                   uint32_t error_threshold_value,
>>>> +                                   uint32_t error_threshold_window)
>>>
>>>
>>> This function has too many arguments.
>>> How about we just hard code all the 0's until we need to set them
>>> to something else?
>>
>> Yes, and we can also hard code the value of length which is always 28 and
>> indicates the total length of the structure in bytes.
>>
>>>
>>>> +{
>>>> +        /* Type */
>>>> +        build_append_int_noprefix(table, type, 1);
>>>> +        /* Length */
>>>> +        build_append_int_noprefix(table, length, 1);
>>>> +        /* Configuration Write Enable */
>>>> +        build_append_int_noprefix(table, config_write_enable, 2);
>>>> +        /* Poll Interval */
>>>> +        build_append_int_noprefix(table, poll_interval, 4);
>>>> +        /* Vector */
>>>> +        build_append_int_noprefix(table, vector, 4);
>>>> +        /* Switch To Polling Threshold Value */
>>>> +        build_append_int_noprefix(table, polling_threshold_value, 4);
>>>> +        /* Switch To Polling Threshold Window */
>>>> +        build_append_int_noprefix(table, polling_threshold_window, 4);
>>>> +        /* Error Threshold Value */
>>>> +        build_append_int_noprefix(table, error_threshold_value, 4);
>>>> +        /* Error Threshold Window */
>>>> +        build_append_int_noprefix(table, error_threshold_window, 4);
>>>> +}
>>>> +
>>>> +/* Build table for the hardware error fw_cfg blob */
>>>> +void acpi_ghes_build_error_table(GArray *hardware_errors, BIOSLinker *linker)
>>>> +{
>>>> +    int i, error_status_block_offset;
>>>> +
>>>> +    /*
>>>> +     * | +--------------------------+
>>>> +     * | |    error_block_address   |
>>>> +     * | |      ..........          |
>>>> +     * | +--------------------------+
>>>> +     * | |    read_ack_register     |
>>>> +     * | |     ...........          |
>>>> +     * | +--------------------------+
>>>> +     * | |  Error Status Data Block |
>>>> +     * | |      ........            |
>>>> +     * | +--------------------------+
>>>> +     */
>>>> +
>>>> +    /* Build error_block_address */
>>>> +    build_append_int_noprefix(hardware_errors, 0,
>>>> +        ACPI_GHES_ADDRESS_SIZE * ACPI_GHES_ERROR_SOURCE_COUNT);
>>>
>>> This works for adding more than 8 bytes but it's a bit of a hack,
>>> only works when value is 0. A loop would be a bit cleaner imho.
>>
>> Yes, this might confuse someone and it's better to use a loop instead.
>>
>>>
>>>> +
>>>> +    /* Build read_ack_register */
>>>> +    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
>>>> +        /* Initialize the value of read_ack_register to 1, so GHES can be
>>>> +         * writeable in the first time.
>>>> +         * ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
>>>> +         * (GHESv2 - Type 10)
>>>> +         */
>>>> +        build_append_int_noprefix(hardware_errors, 1, ACPI_GHES_ADDRESS_SIZE);
>>>> +    }
>>>> +
>>>> +    /* Build Error Status Data Block */
>>>> +    build_append_int_noprefix(hardware_errors, 0,
>>>> +        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
>>>> +
>>>> +    /* Allocate guest memory for the hardware error fw_cfg blob */
>>>> +    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
>>>> +                             hardware_errors, 1, false);
>>>> +
>>>> +    /* Generic Error Status Block offset in the hardware error fw_cfg blob */
>>>> +    error_status_block_offset = ACPI_GHES_ADDRESS_SIZE * 2 *
>>>> +                                ACPI_GHES_ERROR_SOURCE_COUNT;
>>>
>>> a better way to get this is to save hardware_errors->len just before
>>> you append the padding where the value should be.
>>
>> Thanks, this really makes it better.
>>
>>>
>>>> +
>>>> +    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
>>>> +        /* Patch address of Error Status Data Block into
>>>> +         * the error_block_address of hardware_errors fw_cfg blob
>>>> +         */
>>>> +        bios_linker_loader_add_pointer(linker,
>>>> +            ACPI_GHES_ERRORS_FW_CFG_FILE, ACPI_GHES_ADDRESS_SIZE * i,
>>>> +            ACPI_GHES_ADDRESS_SIZE, ACPI_GHES_ERRORS_FW_CFG_FILE,
>>>> +            error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
>>>> +    }
>>>> +
>>>> +    /* Write address of hardware_errors fw_cfg blob into the
>>>> +     * hardware_errors_addr fw_cfg blob.
>>>> +     */
>>>> +    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
>>>> +        0, ACPI_GHES_ADDRESS_SIZE, ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
>>>> +}
>>>> +
>>>> +/* Build Hardware Error Source Table */
>>>> +void acpi_ghes_build_hest(GArray *table_data, GArray *hardware_errors,
>>>> +                          BIOSLinker *linker)
>>>> +{
>>>> +    uint32_t i, hest_start = table_data->len;
>>>> +
>>>> +    /* Reserve Hardware Error Source Table header size */
>>>> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
>>>> +
>>>> +    /* Error Source Count */
>>>> +    build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>>>> +
>>>> +    /* Generic Hardware Error Source version 2(GHESv2 - Type 10) */
>>>> +    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
>>>> +        /* Type */
>>>> +        build_append_int_noprefix(table_data,
>>>> +            ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
>>>> +        /* Source Id */
>>>> +        build_append_int_noprefix(table_data, i, 2);
>>>> +        /* Related Source Id */
>>>> +        build_append_int_noprefix(table_data, 0xffff, 2);
>>>> +        /* Flags */
>>>> +        build_append_int_noprefix(table_data, 0, 1);
>>>> +        /* Enabled */
>>>> +        build_append_int_noprefix(table_data, 1, 1);
>>>> +
>>>> +        /* Number of Records To Pre-allocate */
>>>> +        build_append_int_noprefix(table_data, 1, 4);
>>>> +        /* Max Sections Per Record */
>>>> +        build_append_int_noprefix(table_data, 1, 4);
>>>> +        /* Max Raw Data Length */
>>>> +        build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
>>>> +
>>>> +        /* Error Status Address */
>>>> +        build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0,
>>>> +                         4 /* QWord access */, 0);
>>>> +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>>>> +            ACPI_GHES_ERROR_STATUS_ADDRESS_OFFSET(hest_start, i),
>>>> +            ACPI_GHES_ADDRESS_SIZE, ACPI_GHES_ERRORS_FW_CFG_FILE,
>>>> +            i * ACPI_GHES_ADDRESS_SIZE);
>>>> +
>>>> +        if (i == 0) {
>>>> +            /* Notification Structure
>>>> +             * Now only enable ARMv8 SEA notification type
>>>> +             */
>>>> +            acpi_ghes_build_notify(table_data, ACPI_GHES_NOTIFY_SEA, 28,
>>>
>>>
>>> what's the magic 28? generally acpi_ghes_build_notify isn't self
>>> contained.
>>>
>>
>> According to "ACPI 6.2: 18.3.2.9 Hardware Error Notification", the number "28" indicates
>> the total length of the hardware error notifaction structure in bytes. I will add a new
>> macro such as ACPI_GHES_HW_ERROR_NOTIF_LENGTH.
> 
> 
> no need - just write a comment near where you use it.

OK, thanks.

> 
>>>
>>>> 0,
>>>> +                                   0, 0, 0, 0, 0, 0);
>>>> +        } else {
>>>> +            g_assert_not_reached();
>>>
>>> OK so how about we just drop all these loops for
>>> ACPI_GHES_ERROR_SOURCE_COUNT?
>>
>> Even though we only support ARMv8 SEA notification type now, we still use these loops for
>> scalability. Maybe we need to add a new staic array for these loops, like below:
>>
>> static uint8_t acpi_ghes_hw_srouces[ACPI_GHES_ERROR_SOURCE_COUNT] = {
>>     ACPI_GHES_NOTIFY_SEA
>> };
> 
> just keep code simple, it won't be hard to add loops when needed.
> 

OK, I will drop these loops.

> 
>>>
>>>
>>>> +        }
>>>> +
>>>> +        /* Error Status Block Length */
>>>> +        build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
>>>> +
>>>> +        /* Read Ack Register
>>>> +         * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
>>>> +         * version 2 (GHESv2 - Type 10)
>>>> +         */
>>>> +        build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0,
>>>> +                         4 /* QWord access */, 0);
>>>> +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>>>> +            ACPI_GHES_READ_ACK_REGISTER_ADDRESS_OFFSET(hest_start, i),
>>>> +            ACPI_GHES_ADDRESS_SIZE, ACPI_GHES_ERRORS_FW_CFG_FILE,
>>>> +            (ACPI_GHES_ERROR_SOURCE_COUNT + i) * ACPI_GHES_ADDRESS_SIZE);
>>>> +
>>>> +        /* Read Ack Preserve */
>>>> +        build_append_int_noprefix(table_data, 0xfffffffffffffffe, 8);
>>>
>>> don't we need to specify ULL? Also isn't this just ~0x1ULL?
>>
>> Yes, I will use ~0x1ULL instead.
>>
>>>
>>> you should try to document values not just field names.
>>> e.g. why is ~0x1ULL specifically? which bits are clear?
>>
>> OK, I will document it. According to "ACPI 6.2: 18.3.2.8 Generic Hardware Error
>> Source version 2 (GHESv2 - Type 10)", we only provide the first bit to OSPM while
>> the other bits are preserved. That's why we initialize the value of Read Ack Register
>> to 1.
> 
> so write comments near each value.
> 

Got it.

-- 

Thanks,
Xiang


