Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16844C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE9320675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWpYo0VO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE9320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyX3-0004m2-RW
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVyWR-0004Hs-HR
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:26:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVyWQ-0003LR-IR
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588688769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJaqp6t3CRqMVr4oSCWcPsvmAWzsy4f45i/wxN37IcM=;
 b=XWpYo0VO8GFuNMAIwn34MPCIYqQk5vj+4WP2VFa1kgnNPVu9RVVwe1YU5U6kJaRDAsO1Br
 wOjN2yVyaQplLF+raci+tMjnLEzMOIZwH+PvovjSldHm20GNuq1ywVtHn0kiqWI7S8WrQM
 Ed5SsMXfQfgQ8HcTtUVM13qMLE76h1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-92BYn3kJM0mLMe1i3g_Zfw-1; Tue, 05 May 2020 10:26:08 -0400
X-MC-Unique: 92BYn3kJM0mLMe1i3g_Zfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16BB6107ACCD;
 Tue,  5 May 2020 14:26:07 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A0C660BEC;
 Tue,  5 May 2020 14:25:56 +0000 (UTC)
Date: Tue, 5 May 2020 16:25:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 05/13] acpi: move acpi_init_common_fadt_data to
 acpi-common.c
Message-ID: <20200505162555.104fa99a@redhat.com>
In-Reply-To: <20200505134305.22666-6-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-6-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 15:42:57 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

the same question like with FACS, why legacy data are needed for with reduced profile?
it mostly initializes data for fixed-hw model.

I'd preffer if you drop FACS and use minimal FADT like build_fadt_rev5() does
without pulling along a bunch of legacy junk (unless there is a good justification for it).

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/acpi-common.h |  5 ++++-
>  hw/i386/acpi-build.c  | 43 +------------------------------------------
>  hw/i386/acpi-common.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
> index 583c320bbe7d..5788a13da9ca 100644
> --- a/hw/i386/acpi-common.h
> +++ b/hw/i386/acpi-common.h
> @@ -1,7 +1,8 @@
>  #ifndef HW_I386_ACPI_COMMON_H
>  #define HW_I386_ACPI_COMMON_H
> +
> +#include "include/hw/acpi/acpi-defs.h"
>  #include "include/hw/acpi/acpi_dev_interface.h"
> -
>  #include "include/hw/acpi/bios-linker-loader.h"
>  #include "include/hw/i386/x86.h"
>  
> @@ -12,5 +13,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>                       X86MachineState *x86ms, AcpiDeviceIf *adev,
>                       bool has_pci);
>  void acpi_build_facs(GArray *table_data);
> +void acpi_init_common_fadt_data(MachineState *ms, Object *o,
> +                                AcpiFadtData *data);
>  
>  #endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index a69b85a266e7..d1f14394734e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -132,47 +132,6 @@ const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio = {
>      .bit_width = NVDIMM_ACPI_IO_LEN << 3
>  };
>  
> -static void init_common_fadt_data(MachineState *ms, Object *o,
> -                                  AcpiFadtData *data)
> -{
> -    uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> -    AmlAddressSpace as = AML_AS_SYSTEM_IO;
> -    AcpiFadtData fadt = {
> -        .rev = 3,
> -        .flags =
> -            (1 << ACPI_FADT_F_WBINVD) |
> -            (1 << ACPI_FADT_F_PROC_C1) |
> -            (1 << ACPI_FADT_F_SLP_BUTTON) |
> -            (1 << ACPI_FADT_F_RTC_S4) |
> -            (1 << ACPI_FADT_F_USE_PLATFORM_CLOCK) |
> -            /* APIC destination mode ("Flat Logical") has an upper limit of 8
> -             * CPUs for more than 8 CPUs, "Clustered Logical" mode has to be
> -             * used
> -             */
> -            ((ms->smp.max_cpus > 8) ?
> -                        (1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL) : 0),
> -        .int_model = 1 /* Multiple APIC */,
> -        .rtc_century = RTC_CENTURY,
> -        .plvl2_lat = 0xfff /* C2 state not supported */,
> -        .plvl3_lat = 0xfff /* C3 state not supported */,
> -        .smi_cmd = ACPI_PORT_SMI_CMD,
> -        .sci_int = object_property_get_uint(o, ACPI_PM_PROP_SCI_INT, NULL),
> -        .acpi_enable_cmd =
> -            object_property_get_uint(o, ACPI_PM_PROP_ACPI_ENABLE_CMD, NULL),
> -        .acpi_disable_cmd =
> -            object_property_get_uint(o, ACPI_PM_PROP_ACPI_DISABLE_CMD, NULL),
> -        .pm1a_evt = { .space_id = as, .bit_width = 4 * 8, .address = io },
> -        .pm1a_cnt = { .space_id = as, .bit_width = 2 * 8,
> -                      .address = io + 0x04 },
> -        .pm_tmr = { .space_id = as, .bit_width = 4 * 8, .address = io + 0x08 },
> -        .gpe0_blk = { .space_id = as, .bit_width =
> -            object_property_get_uint(o, ACPI_PM_PROP_GPE0_BLK_LEN, NULL) * 8,
> -            .address = object_property_get_uint(o, ACPI_PM_PROP_GPE0_BLK, NULL)
> -        },
> -    };
> -    *data = fadt;
> -}
> -
>  static Object *object_resolve_type_unambiguous(const char *typename)
>  {
>      bool ambig;
> @@ -195,7 +154,7 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>      pm->pcihp_io_len = 0;
>  
>      assert(obj);
> -    init_common_fadt_data(machine, obj, &pm->fadt);
> +    acpi_init_common_fadt_data(machine, obj, &pm->fadt);
>      if (piix) {
>          /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
>          pm->fadt.rev = 1;
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index 5187653893a8..69dfbf0252f3 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -28,6 +28,8 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/utils.h"
>  #include "hw/i386/pc.h"
> +#include "hw/isa/apm.h"
> +#include "hw/rtc/mc146818rtc_regs.h"
>  #include "target/i386/cpu.h"
>  
>  #include "acpi-build.h"
> @@ -161,3 +163,44 @@ void acpi_build_facs(GArray *table_data)
>      memcpy(&facs->signature, "FACS", 4);
>      facs->length = cpu_to_le32(sizeof(*facs));
>  }
> +
> +void acpi_init_common_fadt_data(MachineState *ms, Object *o,
> +                                AcpiFadtData *data)
> +{
> +    uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> +    AmlAddressSpace as = AML_AS_SYSTEM_IO;
> +    AcpiFadtData fadt = {
> +        .rev = 3,
> +        .flags =
> +            (1 << ACPI_FADT_F_WBINVD) |
> +            (1 << ACPI_FADT_F_PROC_C1) |
> +            (1 << ACPI_FADT_F_SLP_BUTTON) |
> +            (1 << ACPI_FADT_F_RTC_S4) |
> +            (1 << ACPI_FADT_F_USE_PLATFORM_CLOCK) |
> +            /* APIC destination mode ("Flat Logical") has an upper limit of 8
> +             * CPUs for more than 8 CPUs, "Clustered Logical" mode has to be
> +             * used
> +             */
> +            ((ms->smp.max_cpus > 8) ?
> +                        (1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL) : 0),
> +        .int_model = 1 /* Multiple APIC */,
> +        .rtc_century = RTC_CENTURY,
> +        .plvl2_lat = 0xfff /* C2 state not supported */,
> +        .plvl3_lat = 0xfff /* C3 state not supported */,
> +        .smi_cmd = ACPI_PORT_SMI_CMD,
> +        .sci_int = object_property_get_uint(o, ACPI_PM_PROP_SCI_INT, NULL),
> +        .acpi_enable_cmd =
> +            object_property_get_uint(o, ACPI_PM_PROP_ACPI_ENABLE_CMD, NULL),
> +        .acpi_disable_cmd =
> +            object_property_get_uint(o, ACPI_PM_PROP_ACPI_DISABLE_CMD, NULL),
> +        .pm1a_evt = { .space_id = as, .bit_width = 4 * 8, .address = io },
> +        .pm1a_cnt = { .space_id = as, .bit_width = 2 * 8,
> +                      .address = io + 0x04 },
> +        .pm_tmr = { .space_id = as, .bit_width = 4 * 8, .address = io + 0x08 },
> +        .gpe0_blk = { .space_id = as, .bit_width =
> +            object_property_get_uint(o, ACPI_PM_PROP_GPE0_BLK_LEN, NULL) * 8,
> +            .address = object_property_get_uint(o, ACPI_PM_PROP_GPE0_BLK, NULL)
> +        },
> +    };
> +    *data = fadt;
> +}


