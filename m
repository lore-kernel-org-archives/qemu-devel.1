Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A14C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FFB206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/DSEAAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FFB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVv5c-0000xP-Gq
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVv4T-0000FU-1m
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:45:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVv4R-0002UE-W8
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588675503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqf/6fyyGHT9aaQFvcrKbEghvaAWl4aG5jtCcT4dNB4=;
 b=Q/DSEAAL4X2WzlCQ/jMpt20X5de3jHb7CuBkjmZyMbDdGeJ3OVPf8pZeVqVJse4ASKGqAq
 IQu6K1yZCUEqQZv7u2csg4BHJbF6ZPEaoBgc9B2RQtWkV0ZPHY/luzisbqmP3UroQzzsWU
 g2lB2Q/s+Da0OMgZYnSysQjVC4eU6hY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-5NqVWkQ4ObO4THX4wMy7hg-1; Tue, 05 May 2020 06:44:59 -0400
X-MC-Unique: 5NqVWkQ4ObO4THX4wMy7hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B3B9872FE4;
 Tue,  5 May 2020 10:44:57 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92940600F5;
 Tue,  5 May 2020 10:44:48 +0000 (UTC)
Date: Tue, 5 May 2020 12:44:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v25 08/10] ACPI: Record Generic Error Status Block(GESB)
 table
Message-ID: <20200505124446.2972f407@redhat.com>
In-Reply-To: <20200410114639.32844-9-gengdongjiu@huawei.com>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <20200410114639.32844-9-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com, linuxarm@huawei.com,
 shannon.zhaosl@gmail.com, zhengxiang9@huawei.com, qemu-arm@nongnu.org,
 Jonathan.Cameron@huawei.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Apr 2020 19:46:37 +0800
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> kvm_arch_on_sigbus_vcpu() error injection uses source_id as
> index in etc/hardware_errors to find out Error Status Data
> Block entry corresponding to error source. So supported source_id
> values should be assigned here and not be changed afterwards to
> make sure that guest will write error into expected Error Status
> Data Block.
> 
> Before QEMU writes a new error to ACPI table, it will check whether
> previous error has been acknowledged. If not acknowledged, the new
> errors will be ignored and not be recorded. For the errors section
> type, QEMU simulate it to memory section error.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Also we should ratelimit error messages that could be triggered at runtime
from acpi_ghes_record_errors() and functions it's calling.
It could be a patch on top.


> ---
> change since v24:
> 1. Using g_array_append_vals() to replace build_append_int_noprefix() to build FRU Text.
> 2. Remove the judgement that judge whether acpi_ged_state is NULL.
> 3. Add le64_to_cpu() to error_block_address
> ---
>  hw/acpi/ghes.c         | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/ghes.h |   1 +
>  2 files changed, 220 insertions(+)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e74af23..a3ab2e4 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -26,6 +26,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/nvram/fw_cfg.h"
> +#include "qemu/uuid.h"
>  
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> @@ -43,6 +44,36 @@
>  #define GAS_ADDR_OFFSET 4
>  
>  /*
> + * The total size of Generic Error Data Entry
> + * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> + * Table 18-343 Generic Error Data Entry
> + */
> +#define ACPI_GHES_DATA_LENGTH               72
> +
> +/* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
> +#define ACPI_GHES_MEM_CPER_LENGTH           80
> +
> +/* Masks for block_status flags */
> +#define ACPI_GEBS_UNCORRECTABLE         1
> +
> +/*
> + * Total size for Generic Error Status Block except Generic Error Data Entries
> + * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
> + * Table 18-380 Generic Error Status Block
> + */
> +#define ACPI_GHES_GESB_SIZE                 20
> +
> +/*
> + * Values for error_severity field
> + */
> +enum AcpiGenericErrorSeverity {
> +    ACPI_CPER_SEV_RECOVERABLE = 0,
> +    ACPI_CPER_SEV_FATAL = 1,
> +    ACPI_CPER_SEV_CORRECTED = 2,
> +    ACPI_CPER_SEV_NONE = 3,
> +};
> +
> +/*
>   * Hardware Error Notification
>   * ACPI 4.0: 17.3.2.7 Hardware Error Notification
>   * Composes dummy Hardware Error Notification descriptor of specified type
> @@ -73,6 +104,138 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
>  }
>  
>  /*
> + * Generic Error Data Entry
> + * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> + */
> +static void acpi_ghes_generic_error_data(GArray *table,
> +                const uint8_t *section_type, uint32_t error_severity,
> +                uint8_t validation_bits, uint8_t flags,
> +                uint32_t error_data_length, QemuUUID fru_id,
> +                uint64_t time_stamp)
> +{
> +    const uint8_t fru_text[20] = {0};
> +
> +    /* Section Type */
> +    g_array_append_vals(table, section_type, 16);
> +
> +    /* Error Severity */
> +    build_append_int_noprefix(table, error_severity, 4);
> +    /* Revision */
> +    build_append_int_noprefix(table, 0x300, 2);
> +    /* Validation Bits */
> +    build_append_int_noprefix(table, validation_bits, 1);
> +    /* Flags */
> +    build_append_int_noprefix(table, flags, 1);
> +    /* Error Data Length */
> +    build_append_int_noprefix(table, error_data_length, 4);
> +
> +    /* FRU Id */
> +    g_array_append_vals(table, fru_id.data, ARRAY_SIZE(fru_id.data));
> +
> +    /* FRU Text */
> +    g_array_append_vals(table, fru_text, sizeof(fru_text));
> +
> +    /* Timestamp */
> +    build_append_int_noprefix(table, time_stamp, 8);
> +}
> +
> +/*
> + * Generic Error Status Block
> + * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> + */
> +static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
> +                uint32_t raw_data_offset, uint32_t raw_data_length,
> +                uint32_t data_length, uint32_t error_severity)
> +{
> +    /* Block Status */
> +    build_append_int_noprefix(table, block_status, 4);
> +    /* Raw Data Offset */
> +    build_append_int_noprefix(table, raw_data_offset, 4);
> +    /* Raw Data Length */
> +    build_append_int_noprefix(table, raw_data_length, 4);
> +    /* Data Length */
> +    build_append_int_noprefix(table, data_length, 4);
> +    /* Error Severity */
> +    build_append_int_noprefix(table, error_severity, 4);
> +}
> +
> +/* UEFI 2.6: N.2.5 Memory Error Section */
> +static void acpi_ghes_build_append_mem_cper(GArray *table,
> +                                            uint64_t error_physical_addr)
> +{
> +    /*
> +     * Memory Error Record
> +     */
> +
> +    /* Validation Bits */
> +    build_append_int_noprefix(table,
> +                              (1ULL << 14) | /* Type Valid */
> +                              (1ULL << 1) /* Physical Address Valid */,
> +                              8);
> +    /* Error Status */
> +    build_append_int_noprefix(table, 0, 8);
> +    /* Physical Address */
> +    build_append_int_noprefix(table, error_physical_addr, 8);
> +    /* Skip all the detailed information normally found in such a record */
> +    build_append_int_noprefix(table, 0, 48);
> +    /* Memory Error Type */
> +    build_append_int_noprefix(table, 0 /* Unknown error */, 1);
> +    /* Skip all the detailed information normally found in such a record */
> +    build_append_int_noprefix(table, 0, 7);
> +}
> +
> +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> +                                      uint64_t error_physical_addr)
> +{
> +    GArray *block;
> +
> +    /* Memory Error Section Type */
> +    const uint8_t uefi_cper_mem_sec[] =
> +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> +                  0xED, 0x7C, 0x83, 0xB1);
> +
> +    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> +     * Table 17-13 Generic Error Data Entry
> +     */
> +    QemuUUID fru_id = {};
> +    uint32_t data_length;
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +
> +    /* This is the length if adding a new generic error data entry*/
> +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> +
> +    /*
> +     * Check whether it will run out of the preallocated memory if adding a new
> +     * generic error data entry
> +     */
> +    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> +        error_report("Not enough memory to record new CPER!!!");
> +        g_array_free(block, true);
> +        return -1;
> +    }
> +
> +    /* Build the new generic error status block header */
> +    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> +        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
> +
> +    /* Build this new generic error data entry header */
> +    acpi_ghes_generic_error_data(block, uefi_cper_mem_sec,
> +        ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> +        ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
> +
> +    /* Build the memory section CPER for above new generic error data entry */
> +    acpi_ghes_build_append_mem_cper(block, error_physical_addr);
> +
> +    /* Write the generic error data entry into guest memory */
> +    cpu_physical_memory_write(error_block_address, block->data, block->len);
> +
> +    g_array_free(block, true);
> +
> +    return 0;
> +}
> +
> +/*
>   * Build table for the hardware error fw_cfg blob.
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
> @@ -227,3 +390,59 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
>  }
>
> +int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +{
> +    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> +    uint64_t start_addr;
> +    bool ret = -1;
> +    AcpiGedState *acpi_ged_state;
> +    AcpiGhesState *ags;
> +
> +    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +
> +    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> +                                                       NULL));
> +    g_assert(acpi_ged_state);
> +    ags = &acpi_ged_state->ghes_state;
> +
> +    start_addr = le64_to_cpu(ags->ghes_addr_le);
> +
> +    if (physical_address) {
> +
> +        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> +            start_addr += source_id * sizeof(uint64_t);
> +        }
> +
> +        cpu_physical_memory_read(start_addr, &error_block_addr,
> +                                 sizeof(error_block_addr));
> +
> +        error_block_addr = le64_to_cpu(error_block_addr);
> +
> +        read_ack_register_addr = start_addr +
> +            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +
> +        cpu_physical_memory_read(read_ack_register_addr,
> +                                 &read_ack_register, sizeof(read_ack_register));
> +
> +        /* zero means OSPM does not acknowledge the error */
> +        if (!read_ack_register) {
> +                error_report("OSPM does not acknowledge previous error,"
> +                    " so can not record CPER for current error anymore");
> +        } else if (error_block_addr) {
> +                read_ack_register = cpu_to_le64(0);
> +                /*
> +                 * Clear the Read Ack Register, OSPM will write it to 1 when
> +                 * it acknowledges this error.
> +                 */
> +                cpu_physical_memory_write(read_ack_register_addr,
> +                    &read_ack_register, sizeof(uint64_t));
> +
> +                ret = acpi_ghes_record_mem_error(error_block_addr,
> +                                                 physical_address);
> +        } else
> +                error_report("can not find Generic Error Status Block");
> +    }
> +
> +    return ret;
> +}
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index a3420fc..4ad025e 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -70,4 +70,5 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
>  void acpi_build_hest(GArray *table_data, BIOSLinker *linker);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> +int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
>  #endif


