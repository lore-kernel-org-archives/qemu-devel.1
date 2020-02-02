Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD8FC3524A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 12:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E503420643
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 12:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E503420643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyEdN-0005kV-5u
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 07:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1iyEcV-0005AG-W6
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 07:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1iyEcU-0006n8-Hy
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 07:44:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44612 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1iyEcR-0006fq-4J; Sun, 02 Feb 2020 07:44:55 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4A0BD4F90B04E2EBA13E;
 Sun,  2 Feb 2020 20:44:43 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sun, 2 Feb 2020
 20:44:37 +0800
Subject: Re: [PATCH v22 5/9] ACPI: Record the Generic Error Status Block
 address
To: Igor Mammedov <imammedo@redhat.com>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
 <20200128154110.04baa5bc@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <02a78eff-865c-b9e0-6d5f-d4caa4daa98d@huawei.com>
Date: Sun, 2 Feb 2020 20:44:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20200128154110.04baa5bc@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
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
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 zhengxiang9@huawei.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sorry for the late response due to Chinese new year

On 2020/1/28 22:41, Igor Mammedov wrote:
> On Wed, 8 Jan 2020 19:32:19 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
> in addition to comments of others:
> 
>> Record the GHEB address via fw_cfg file, when recording
>> a error to CPER, it will use this address to find out
>> Generic Error Data Entries and write the error.
>>
>> Make the HEST GHES to a GED device.
> 
> It's hard to parse this even kno
> Pls rephrase/make commit message more verbose,
> so it would describe why and what patch is supposed to do
Ok, thanks for the comments.

> 
> 
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>>  hw/acpi/generic_event_device.c         | 15 ++++++++++++++-
>>  hw/acpi/ghes.c                         | 16 ++++++++++++++++
>>  hw/arm/virt-acpi-build.c               | 13 ++++++++++++-
>>  include/hw/acpi/generic_event_device.h |  2 ++
>>  include/hw/acpi/ghes.h                 |  6 ++++++
>>  5 files changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>> index 9cee90c..9bf37e4 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -234,12 +234,25 @@ static const VMStateDescription vmstate_ged_state = {
>>      }
>>  };
>>  
>> +static const VMStateDescription vmstate_ghes_state = {
>> +    .name = "acpi-ghes-state",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields      = (VMStateField[]) {
>> +        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_acpi_ged = {
>>      .name = "acpi-ged",
>>      .version_id = 1,
>>      .minimum_version_id = 1,
>>      .fields = (VMStateField[]) {
>> -        VMSTATE_STRUCT(ged_state, AcpiGedState, 1, vmstate_ged_state, GEDState),
>> +        VMSTATE_STRUCT(ged_state, AcpiGedState, 1,
>> +                       vmstate_ged_state, GEDState),
>> +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
>> +                       vmstate_ghes_state, AcpiGhesState),
>>          VMSTATE_END_OF_LIST(),
>>      },
>>      .subsections = (const VMStateDescription * []) {
>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>> index 9d37798..68f4abf 100644
>> --- a/hw/acpi/ghes.c
>> +++ b/hw/acpi/ghes.c
>> @@ -23,6 +23,7 @@
>>  #include "hw/acpi/acpi.h"
>>  #include "hw/acpi/ghes.h"
>>  #include "hw/acpi/aml-build.h"
>> +#include "hw/acpi/generic_event_device.h"
>>  #include "hw/nvram/fw_cfg.h"
>>  #include "sysemu/sysemu.h"
>>  #include "qemu/error-report.h"
>> @@ -208,3 +209,18 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>>      build_header(linker, table_data, (void *)(table_data->data + hest_start),
>>          "HEST", table_data->len - hest_start, 1, NULL, "");
>>  }
>> +
>> +void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>> +                            GArray *hardware_error)
> 
> not aligned properly

will modify it.

> 
>> +{
>> +    size_t size = 2 * sizeof(uint64_t) + ACPI_GHES_MAX_RAW_DATA_LENGTH;
>> +    size_t request_block_size = ACPI_GHES_ERROR_SOURCE_COUNT * size;
>> +
>> +    /* Create a read-only fw_cfg file for GHES */
>> +    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
>> +                    request_block_size);
>> +
>> +    /* Create a read-write fw_cfg file for Address */
>> +    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
>> +        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
>> +}
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 837bbf9..c8aa94d 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -797,6 +797,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>      unsigned dsdt, xsdt;
>>      GArray *tables_blob = tables->table_data;
>>      MachineState *ms = MACHINE(vms);
>> +    AcpiGedState *acpi_ged_state;
>>  
>>      table_offsets = g_array_new(false, true /* clear */,
>>                                          sizeof(uint32_t));
>> @@ -831,7 +832,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>      acpi_add_table(table_offsets, tables_blob);
>>      build_spcr(tables_blob, tables->linker, vms);
>>  
>> -    if (vms->ras) {
>> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>> +                                                       NULL));
>> +    if (acpi_ged_state &&  vms->ras) {
> 
> there is vms->acpi_dev which is GED, so you don't need to look it up
> 
> suggest:
   Thanks for the suggestion.

>  if (ras) {
>     assert(ged)
      assert(vms->acpi_dev), right?

>     do other fun stuff ...
>  }

> 
>>          acpi_add_table(table_offsets, tables_blob);
>>          build_ghes_error_table(tables->hardware_errors, tables->linker);
>>          acpi_build_hest(tables_blob, tables->hardware_errors,
>> @@ -925,6 +928,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>>  {
>>      AcpiBuildTables tables;
>>      AcpiBuildState *build_state;
>> +    AcpiGedState *acpi_ged_state;
>>  
>>      if (!vms->fw_cfg) {
>>          trace_virt_acpi_setup();
>> @@ -955,6 +959,13 @@ void virt_acpi_setup(VirtMachineState *vms)
>>      fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
>>                      acpi_data_len(tables.tcpalog));
>>  
>> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>> +                                                       NULL));
>> +    if (acpi_ged_state && vms->ras) {
> 
> ditto

Ok.

> 
>> +        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
>> +                             vms->fw_cfg, tables.hardware_errors);
>> +    }
>> +
>>      build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
>>                                               build_state, tables.rsdp,
>>                                               ACPI_BUILD_RSDP_FILE, 0);
>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>> index d157eac..037d2b5 100644
>> --- a/include/hw/acpi/generic_event_device.h
>> +++ b/include/hw/acpi/generic_event_device.h
>> @@ -61,6 +61,7 @@
>>  
>>  #include "hw/sysbus.h"
>>  #include "hw/acpi/memory_hotplug.h"
>> +#include "hw/acpi/ghes.h"
>>  
>>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>>  
>> @@ -95,6 +96,7 @@ typedef struct AcpiGedState {
>>      GEDState ged_state;
>>      uint32_t ged_event_bitmap;
>>      qemu_irq irq;
>> +    AcpiGhesState ghes_state;
>>  } AcpiGedState;
>>  
>>  void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
>> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
>> index 09a7f86..a6761e6 100644
>> --- a/include/hw/acpi/ghes.h
>> +++ b/include/hw/acpi/ghes.h
>> @@ -60,7 +60,13 @@ enum {
>>      ACPI_HEST_SRC_ID_RESERVED,
>>  };
>>  
>> +typedef struct AcpiGhesState {
>> +    uint64_t ghes_addr_le;
>> +} AcpiGhesState;
>> +
>>  void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
>>  void acpi_build_hest(GArray *table_data, GArray *hardware_error,
>>                            BIOSLinker *linker);
>> +void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>> +                          GArray *hardware_errors);
>>  #endif
> 
> .
> 


