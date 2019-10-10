Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F99C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA4A206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA4A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZ2V-0003IK-Sd
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIZ0r-0002Ek-FF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIZ0q-00066V-9g
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIZ0o-00065s-Nc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:01:52 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6A9364120
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 14:01:49 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id f15so5842515qth.6
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 07:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qVAAqrz8NImQua1Z+MPnnhld52fQmUNm5/UzIy85cAw=;
 b=ULlLcyH7b0FjoVDMM7I0Atdi5zP/zZJz9iQU1PrED2UByKVIQM1Pc40AqNemAfv6qx
 o6wO461sce6hQ1p86KQ5GydFB+JJGVmVOkq9nLlS/HCgSM24B8tic+l6dEvJR/W9K5zB
 9b6SN8Seg3HYNu6nCP/EntElIrQGntXp4B+uzp5APWHublvuO92DW/J9I6wmqmmgmtIH
 B0uHebaeKXkLlwo5DdaGByE9fWtzLgbEchWdWtmkD8l95R/GCdbUn2V6cekkwGRZSCGg
 ZGLcdNt/rWTRXq3K5v+oclAfTkdCKnuaXZUwqJqraxoioDybI1MSFtduvT0T97EVTIBR
 fSlQ==
X-Gm-Message-State: APjAAAXBt4Vaebpcfi+mS8oxCdJY79v5uhAautHaA0WwRLTedEMhfGaH
 icQzF1XdKDg0mFKIuK09ulL3V+bRkckbHP7bYEWbydDABuMirt0JM1AelcDqn74maYv7K34L2PV
 rnbu7mFeprbPSsv0=
X-Received: by 2002:ad4:4cd2:: with SMTP id i18mr10049271qvz.179.1570716109095; 
 Thu, 10 Oct 2019 07:01:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYqCELGRxeh3CQ+BFJgenfbvye6L7ylSnPky4UXagpA1ByKmXrLmgDow8lDw+zIeO6sIjvOA==
X-Received: by 2002:ad4:4cd2:: with SMTP id i18mr10049239qvz.179.1570716108835; 
 Thu, 10 Oct 2019 07:01:48 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 z6sm2312398qkf.125.2019.10.10.07.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 07:01:48 -0700 (PDT)
Date: Thu, 10 Oct 2019 10:01:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [RFC PATCH 12/12] virt/acpi: add SDEI table if SDEI is enabled
Message-ID: <20191010100107-mutt-send-email-mst@kernel.org>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <1569338511-3572-13-git-send-email-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569338511-3572-13-git-send-email-guoheyi@huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 James Morse <james.morse@arm.com>, Igor Mammedov <imammedo@redhat.com>,
 wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 11:21:51PM +0800, Heyi Guo wrote:
> Add SDEI table if SDEI is enabled, so that guest OS can get aware and
> utilize the interfaces.
> 
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c    | 16 ++++++++++++++++
>  include/hw/acpi/acpi-defs.h |  5 +++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6cdf156..1088214 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -32,6 +32,7 @@
>  #include "trace.h"
>  #include "hw/core/cpu.h"
>  #include "target/arm/cpu.h"
> +#include "target/arm/sdei.h"
>  #include "hw/acpi/acpi-defs.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/nvram/fw_cfg.h"
> @@ -475,6 +476,16 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  }
>  
>  static void
> +build_sdei(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +{
> +    int sdei_start = table_data->len;
> +
> +    (void)acpi_data_push(table_data, sizeof(AcpiSdei));
> +    build_header(linker, table_data, (void *)(table_data->data + sdei_start),
> +                 "SDEI", table_data->len - sdei_start, 1, NULL, NULL);
> +}
> +

Please quote the relevant spec, earliest version that includes
this table, and chapter in that spec.

> +static void
>  build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      AcpiSerialPortConsoleRedirection *spcr;
> @@ -796,6 +807,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      acpi_add_table(table_offsets, tables_blob);
>      build_spcr(tables_blob, tables->linker, vms);
>  
> +    if (sdei_enabled) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_sdei(tables_blob, tables->linker, vms);
> +    }
> +
>      if (ms->numa_state->num_nodes > 0) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, vms);
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 57a3f58..0a2265d 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -634,4 +634,9 @@ struct AcpiIortRC {
>  } QEMU_PACKED;
>  typedef struct AcpiIortRC AcpiIortRC;
>  
> +struct AcpiSdei {
> +    ACPI_TABLE_HEADER_DEF     /* ACPI common table header */
> +} QEMU_PACKED;
> +typedef struct AcpiSdei AcpiSdei;
> +
>  #endif
> -- 
> 1.8.3.1

