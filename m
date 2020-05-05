Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EA6C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3502205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqOhxVcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3502205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVutU-00076K-4X
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVus1-000693-6W
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:32:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30649
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVurz-0004Fl-Tt
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588674731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/ATC1Apm8jZkYS/3yZsCVadYViIHtu/niZs3YWzOz4=;
 b=DqOhxVcbA4ubL5U6/TjD9h23oqZQroam7J4H5Y+NhTB8hXdZ0exG7ztBLcMKpt7xhPi50F
 muqg265kMz8fjgIFXKdcllCL1m4fgoRasDtfCFe2KPTtI2TbDxGzKI6iDcC9+TkdBxpGIc
 OB/bP917eMpEjN8vWldmW+jsesIhEh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-rO5dl4xwMwmLCu6sLFolQA-1; Tue, 05 May 2020 06:32:08 -0400
X-MC-Unique: rO5dl4xwMwmLCu6sLFolQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7504107ACF5;
 Tue,  5 May 2020 10:32:06 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60C0F7053F;
 Tue,  5 May 2020 10:31:56 +0000 (UTC)
Date: Tue, 5 May 2020 12:31:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: Re: [PATCH v25 06/10] ACPI: Record the Generic Error Status Block
 address
Message-ID: <20200505123155.3b11394f@redhat.com>
In-Reply-To: <20200410114639.32844-7-gengdongjiu@huawei.com>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <20200410114639.32844-7-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

On Fri, 10 Apr 2020 19:46:35 +0800
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> Record the GHEB address via fw_cfg file, when recording
> a error to CPER, it will use this address to find out
> Generic Error Data Entries and write the error.
> 
> In order to avoid migration failure, make hardware
> error table address to a part of GED device instead
> of global variable, then this address will be migrated
> to target QEMU.
> 
> Acked-by: Xiang Zheng <zhengxiang9@huawei.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> change since v24:
> 1. Use s->ghes_state.ghes_addr_le to check in ghes_needed()
> 2. Using hardware_error->len instead of request_block_size to calculate in acpi_ghes_add_fw_cfg()
> 3. Remove assert(vms->acpi_dev) be build APEI table
> 4. Directly use ACPI_GED(vms->acpi_dev) instead of ACPI_GED(vms->acpi_dev)
> ---
>  hw/acpi/generic_event_device.c         | 19 +++++++++++++++++++
>  hw/acpi/ghes.c                         | 14 ++++++++++++++
>  hw/arm/virt-acpi-build.c               |  8 ++++++++
>  include/hw/acpi/generic_event_device.h |  2 ++
>  include/hw/acpi/ghes.h                 |  6 ++++++
>  5 files changed, 49 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 021ed2b..1491291 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -234,6 +234,24 @@ static const VMStateDescription vmstate_ged_state = {
>      }
>  };
>  
> +static bool ghes_needed(void *opaque)
> +{
> +    AcpiGedState *s = opaque;
> +    return s->ghes_state.ghes_addr_le;
> +}
> +
> +static const VMStateDescription vmstate_ghes_state = {
> +    .name = "acpi-ged/ghes",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = ghes_needed,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> +                       vmstate_ghes_state, AcpiGhesState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_acpi_ged = {
>      .name = "acpi-ged",
>      .version_id = 1,
> @@ -244,6 +262,7 @@ static const VMStateDescription vmstate_acpi_ged = {
>      },
>      .subsections = (const VMStateDescription * []) {
>          &vmstate_memhp_state,
> +        &vmstate_ghes_state,
>          NULL
>      }
>  };
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 091fd87..e74af23 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -24,6 +24,8 @@
>  #include "hw/acpi/ghes.h"
>  #include "hw/acpi/aml-build.h"
>  #include "qemu/error-report.h"
> +#include "hw/acpi/generic_event_device.h"
> +#include "hw/nvram/fw_cfg.h"
>  
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> @@ -213,3 +215,15 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker)
>      build_header(linker, table_data, (void *)(table_data->data + hest_start),
>          "HEST", table_data->len - hest_start, 1, NULL, NULL);
>  }
> +
> +void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> +                          GArray *hardware_error)
> +{
> +    /* Create a read-only fw_cfg file for GHES */
> +    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
> +                    hardware_error->len);
> +
> +    /* Create a read-write fw_cfg file for Address */
> +    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
> +        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f611bce..2726aac 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -911,6 +911,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>  {
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
> +    AcpiGedState *acpi_ged_state;
>  
>      if (!vms->fw_cfg) {
>          trace_virt_acpi_setup();
> @@ -941,6 +942,13 @@ void virt_acpi_setup(VirtMachineState *vms)
>      fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
>                      acpi_data_len(tables.tcpalog));
>  
> +    if (vms->ras) {
> +        assert(vms->acpi_dev);
> +        acpi_ged_state = ACPI_GED(vms->acpi_dev);
> +        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
> +                             vms->fw_cfg, tables.hardware_errors);
> +    }
> +
>      build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
>                                               build_state, tables.rsdp,
>                                               ACPI_BUILD_RSDP_FILE, 0);
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d157eac..037d2b5 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -61,6 +61,7 @@
>  
>  #include "hw/sysbus.h"
>  #include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/ghes.h"
>  
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>  
> @@ -95,6 +96,7 @@ typedef struct AcpiGedState {
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;
> +    AcpiGhesState ghes_state;
>  } AcpiGedState;
>  
>  void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 18debd8..a3420fc 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -62,6 +62,12 @@ enum {
>      ACPI_HEST_SRC_ID_RESERVED,
>  };
>  
> +typedef struct AcpiGhesState {
> +    uint64_t ghes_addr_le;
> +} AcpiGhesState;
> +
>  void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
>  void acpi_build_hest(GArray *table_data, BIOSLinker *linker);
> +void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
> +                          GArray *hardware_errors);
>  #endif


