Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01146C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42892076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIntLcut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42892076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGM98-0000Rw-Th
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jGM7M-0005wD-1M
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jGM7K-0006Bd-PX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jGM7K-0006BJ-MJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584966222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDf/vEngzybWz4ot9gQJs4GKlGqS4n9YX81k//UFJBM=;
 b=gIntLcutkfnT+rdGGot2SyqpPrxfKyAcYBYD6QzJAZOHLXaG2XYdvscukiVH4aDGHD0EXH
 dr7fTRS0m0rfsDu2JNLPsh6q9iqphSmPONxL+85ef6suUFeZ4B7uMOmuyWHu3k0ZrkqD0H
 y/zKuHUO3ney6mtrzfb9xNfU3vXjynU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-ElVLvD9sPlqtVFVND3ttIA-1; Mon, 23 Mar 2020 08:23:38 -0400
X-MC-Unique: ElVLvD9sPlqtVFVND3ttIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9ACF801E53;
 Mon, 23 Mar 2020 12:23:36 +0000 (UTC)
Received: from localhost (unknown [10.40.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 577A59B92D;
 Mon, 23 Mar 2020 12:23:24 +0000 (UTC)
Date: Mon, 23 Mar 2020 13:23:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 01/10] acpi: Use macro for table-loader file name
Message-ID: <20200323132322.1339fb96@redhat.com>
In-Reply-To: <20200311172014.33052-2-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200311172014.33052-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 shannon.zhaosl@gmail.com, david@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, mst@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 17:20:05 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Use macro for "etc/table-loader" and move it to the header
> file similar to ACPI_BUILD_TABLE_FILE/ACPI_BUILD_RSDP_FILE etc.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt-acpi-build.c    | 2 +-
>  hw/i386/acpi-build.c        | 2 +-
>  include/hw/acpi/aml-build.h | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index fb4b166f82..c13710b727 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -929,7 +929,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>  
>      build_state->linker_mr =
>          acpi_add_rom_blob(virt_acpi_build_update, build_state,
> -                          tables.linker->cmd_blob, "etc/table-loader", 0);
> +                          tables.linker->cmd_blob, ACPI_BUILD_LOADER_FILE, 0);
>  
>      fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
>                      acpi_data_len(tables.tcpalog));
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9a19c14e66..80f05d728d 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -3043,7 +3043,7 @@ void acpi_setup(void)
>  
>      build_state->linker_mr =
>          acpi_add_rom_blob(acpi_build_update, build_state,
> -                          tables.linker->cmd_blob, "etc/table-loader", 0);
> +                          tables.linker->cmd_blob, ACPI_BUILD_LOADER_FILE, 0);
>  
>      fw_cfg_add_file(x86ms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>                      tables.tcpalog->data, acpi_data_len(tables.tcpalog));
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index de4a406568..0f4ed53d7f 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -13,6 +13,7 @@
>  #define ACPI_BUILD_TABLE_FILE "etc/acpi/tables"
>  #define ACPI_BUILD_RSDP_FILE "etc/acpi/rsdp"
>  #define ACPI_BUILD_TPMLOG_FILE "etc/tpm/log"
> +#define ACPI_BUILD_LOADER_FILE "etc/table-loader"
>  
>  #define AML_NOTIFY_METHOD "NTFY"
>  


