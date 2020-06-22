Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703FEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401632070E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 12:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEt324hZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401632070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnLwY-0002Rk-In
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnLvu-0001J4-87
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:52:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnLvr-0004yx-SM
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 08:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592830335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BG+lS/wKJkO+mOmAhP9MCWim4MJEuzjI6ld6TyxMqQ8=;
 b=TEt324hZIYOJenNKC9sdm4VfS5xGlToHVeTg4sV2Z+sxx803TmulRoUq7Cmui4j9f4ip6+
 HOAoHAJgN6refu6Tmfm0pHhlWeWDL+URMBDPv8FwsCg3KOQvtrZAN3mw0qaG5wkKy6lN3L
 JuCguhm8HSQNEMB55Fg7Dduk6D+8UNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-OO7qffv5PXO7muXqCncn_Q-1; Mon, 22 Jun 2020 08:52:11 -0400
X-MC-Unique: OO7qffv5PXO7muXqCncn_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52CCD8014D4;
 Mon, 22 Jun 2020 12:52:10 +0000 (UTC)
Received: from localhost (unknown [10.40.208.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0112310013D7;
 Mon, 22 Jun 2020 12:51:58 +0000 (UTC)
Date: Mon, 22 Jun 2020 14:51:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v6 1/3] acpi: Some build_tpm2() code reshape
Message-ID: <20200622145154.07f1b3de@redhat.com>
In-Reply-To: <20200619141851.16272-2-eric.auger@redhat.com>
References: <20200619141851.16272-1-eric.auger@redhat.com>
 <20200619141851.16272-2-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, drjones@redhat.com,
 mst@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 eric.auger.pro@gmail.com, philmd@redhat.com, ardb@kernel.org,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 16:18:49 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Remove any reference to Acpi20TPM2 and adopt an implementation
> similar to build_ghes_v2().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>

with struct Acpi20TPM2 removed completely and pointer to the spec as we discussed ealier

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> v5 -> v6:
> - add reference to the spec + comment about LAML and LASA fields
> - also moved LASA intro comment above build_append_int_noprefix()
>   as requested by Igor
> ---
>  hw/acpi/aml-build.c | 54 +++++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 2cb7b991ef..1cc08a3eb9 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1878,48 +1878,64 @@ build_hdr:
>                   "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
>  }
>  
> +/*
> + * build_tpm2 - Build the TPM2 table as specified in table 7 of
> + * "TCG ACPI Specification; Family 1.2 and 2.0;
> + * Level 00 Revision 00.37, December 19, 2014"
> + * Note: the LASA and LAML fields are optional for TPM-2.0 (the above
> + * table does not mention them) but are needed at least for SeaBIOS.
> + * See the Acpi20TPM2 struct for the corresponding layout.
> + */
>  void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>  {
> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
> -    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
> -    unsigned log_addr_offset =
> -        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
>      uint8_t start_method_params[12] = {};
> +    unsigned log_addr_offset, tpm2_start;
> +    uint64_t control_area_start_address;
>      TPMIf *tpmif = tpm_find();
> +    uint32_t start_method;
> +    void *tpm2_ptr;
>  
> -    /* platform class */
> +    tpm2_start = table_data->len;
> +    tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    /* Platform Class */
>      build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
> -    /* reserved */
> +    /* Reserved */
>      build_append_int_noprefix(table_data, 0, 2);
>      if (TPM_IS_TIS_ISA(tpmif) || TPM_IS_TIS_SYSBUS(tpmif)) {
> -        /* address of control area */
> -        build_append_int_noprefix(table_data, 0, 8);
> -        /* start method */
> -        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
> +        control_area_start_address = 0;
> +        start_method = TPM2_START_METHOD_MMIO;
>      } else if (TPM_IS_CRB(tpmif)) {
> -        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
> -        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
> +        control_area_start_address = TPM_CRB_ADDR_CTRL;
> +        start_method = TPM2_START_METHOD_CRB;
>      } else {
> -        g_warn_if_reached();
> +        g_assert_not_reached();
>      }
> +    /* Address of Control Area */
> +    build_append_int_noprefix(table_data, control_area_start_address, 8);
> +    /* Start Method */
> +    build_append_int_noprefix(table_data, start_method, 4);
>  
> -    /* platform specific parameters */
> -    g_array_append_vals(table_data, &start_method_params, 12);
> +    /* Platform Specific Parameters */
> +    g_array_append_vals(table_data, &start_method_params,
> +                        ARRAY_SIZE(start_method_params));
>  
> -    /* log area minimum length */
> +    /* Log Area Minimum Length */
>      build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
>  
>      acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
>      bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
>                               false);
>  
> -    /* log area start address to be filled by Guest linker */
> +    log_addr_offset = table_data->len;
> +
> +    /* Log Area Start Address to be filled by Guest linker */
>      build_append_int_noprefix(table_data, 0, 8);
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -                                   log_addr_offset, log_addr_size,
> +                                   log_addr_offset, 8,
>                                     ACPI_BUILD_TPMLOG_FILE, 0);
>      build_header(linker, table_data,
> -                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
> +                 tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4, NULL, NULL);
>  }
>  
>  /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */


