Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2BF207D5
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkwJju/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2BF207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnOX-0000yq-1L
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 06:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jgnNn-0000Jd-QW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:45:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jgnNm-00014X-Jm
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591267557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVM8JuUaZw2TZRtfC/WISO0SshPKUxtuHzMhfdRhjOY=;
 b=RkwJju/FqFVYSySaRxeuD5YjC47fCIdCuKMCqxQpKfeCgBPPKQRhXyllT3PWKZJHND2z3Z
 SNiH61j5F3TuOqCKtZl8nugN8aONhbjayzRn9acQF9jBfRGbeepwzQLLSEkZrXv/uCf8ea
 dSIcbb7MXOt+zkh9syX8PlKTB9IpolI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-ipyjtA68Mc6r45TuL_Xr1Q-1; Thu, 04 Jun 2020 06:45:55 -0400
X-MC-Unique: ipyjtA68Mc6r45TuL_Xr1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 883B7835B42;
 Thu,  4 Jun 2020 10:45:54 +0000 (UTC)
Received: from localhost (unknown [10.40.208.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC82E7CCC8;
 Thu,  4 Jun 2020 10:45:44 +0000 (UTC)
Date: Thu, 4 Jun 2020 12:45:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH] acpi: tpm: Do not build TCPA table for TPM 2
Message-ID: <20200604124543.5df71fa0@redhat.com>
In-Reply-To: <20200529192840.3921141-1-stefanb@linux.vnet.ibm.com>
References: <20200529192840.3921141-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: eric.auger@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 marcandre.lureau@gmail.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 15:28:40 -0400
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Do not build a TCPA table for TPM 2 anymore but create the log area when
> building the TPM2 table. The TCPA table is only needed for TPM 1.2.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2e15f6848e..b5669d6c65 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2317,6 +2317,10 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>      tpm2_ptr->log_area_minimum_length =
>          cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
>  
> +    acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length));
> +    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
> +                             false);
> +
>      /* log area start address to be filled by Guest linker */
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                     log_addr_offset, log_addr_size,
> @@ -2848,10 +2852,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>          build_hpet(tables_blob, tables->linker);
>      }
>      if (misc.tpm_version != TPM_VERSION_UNSPEC) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        build_tpm_tcpa(tables_blob, tables->linker, tables->tcpalog);
> -
> -        if (misc.tpm_version == TPM_VERSION_2_0) {
> +        if (misc.tpm_version == TPM_VERSION_1_2) {
> +            acpi_add_table(table_offsets, tables_blob);
> +            build_tpm_tcpa(tables_blob, tables->linker, tables->tcpalog);
> +        } else { /* TPM_VERSION_2_0 */
>              acpi_add_table(table_offsets, tables_blob);
>              build_tpm2(tables_blob, tables->linker, tables->tcpalog);
>          }


