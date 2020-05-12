Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E903C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7ABA20673
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/tYTh43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7ABA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVtX-0006HR-3j
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYVsk-0005JR-GP
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:27:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYVsj-0006Zb-Ix
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589293659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsYA3UfWWGLEWCH4BHP5aFK8ZXlS4/Nu+HPnchz77iQ=;
 b=M/tYTh43WLSrQ/L+L2VLOQ2voJPIGw7RBdeytza5JKI7rs0bm8sSOQPLJIOb4FKxsymS9d
 UalyYA5xBkIQOAFLtMJBfTYGByGB26tWEN+F9ElK+hSYKh5xDZdzJ8Wq+NG9G3Edf9IYuE
 vH4ySh0hYVNqLNL2pmOz9HCVHw+gun0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-JzmwzjHXMHub1n_O_7IQ_w-1; Tue, 12 May 2020 10:27:37 -0400
X-MC-Unique: JzmwzjHXMHub1n_O_7IQ_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 415268014D5;
 Tue, 12 May 2020 14:27:36 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 621AC7D92A;
 Tue, 12 May 2020 14:27:21 +0000 (UTC)
Date: Tue, 12 May 2020 16:27:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 2/3] arm/acpi: TPM2 ACPI table support
Message-ID: <20200512162716.7a4204dd@redhat.com>
In-Reply-To: <20200505144419.29174-3-eric.auger@redhat.com>
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-3-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, gshan@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, marcandre.lureau@redhat.com, eric.auger.pro@gmail.com,
 lersek@redhat.com, ardb@kernel.org, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 16:44:18 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Add a TPM2 ACPI table if a TPM2.0 sysbus device has been
> dynamically instantiated.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

on x86 we also do:

  fw_cfg_add_file(x86ms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,                       
                  tables.tcpalog->data, acpi_data_len(tables.tcpalog)); 

question is why it's not necessary in case of ARM?

> 
> ---
> 
> v1 -> v2:
> - reuse generic build_tpm2() and alloc log area externally
> - call tpm_find() once in build_tpm2()
> ---
>  include/sysemu/tpm.h     |  2 ++
>  hw/acpi/aml-build.c      |  5 +++--
>  hw/arm/virt-acpi-build.c | 11 +++++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index f37851b1aa..03fb25941c 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -50,6 +50,8 @@ typedef struct TPMIfClass {
>  
>  #define TPM_IS_TIS_ISA(chr)                         \
>      object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
> +#define TPM_IS_TIS_SYSBUS(chr)                      \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SYSBUS)
>  #define TPM_IS_CRB(chr)                             \
>      object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
>  #define TPM_IS_SPAPR(chr)                           \
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1f7fd09112..4224675cb2 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1882,12 +1882,13 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>      unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
>      unsigned log_addr_offset =
>          (char *)&tpm2_ptr->log_area_start_address - table_data->data;
> +    TPMIf *tpmif = tpm_find();
>  
>      tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> -    if (TPM_IS_TIS_ISA(tpm_find())) {
> +    if (TPM_IS_TIS_ISA(tpmif) || TPM_IS_TIS_SYSBUS(tpmif)) {
>          tpm2_ptr->control_area_address = cpu_to_le64(0);
>          tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
> -    } else if (TPM_IS_CRB(tpm_find())) {
> +    } else if (TPM_IS_CRB(tpmif)) {
>          tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
>          tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
>      } else {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 81d41a3990..1a2ec10c8f 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -41,11 +41,13 @@
>  #include "hw/acpi/pci.h"
>  #include "hw/acpi/memory_hotplug.h"
>  #include "hw/acpi/generic_event_device.h"
> +#include "hw/acpi/tpm.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/arm/virt.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
> +#include "sysemu/tpm.h"
>  #include "kvm_arm.h"
>  #include "migration/vmstate.h"
>  
> @@ -831,6 +833,15 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          build_iort(tables_blob, tables->linker, vms);
>      }
>  
> +    if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
> +        acpi_data_push(tables->tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
> +        bios_linker_loader_alloc(tables->linker, ACPI_BUILD_TPMLOG_FILE,
> +                                 tables->tcpalog, 1, false);
> +
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_tpm2(tables_blob, tables->linker, tables->tcpalog);
> +    }
> +
>      /* XSDT is pointed to by RSDP */
>      xsdt = tables_blob->len;
>      build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);


