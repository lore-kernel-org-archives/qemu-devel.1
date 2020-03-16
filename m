Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32453C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BAF205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDVwpkgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BAF205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDnc7-0001gv-Mz
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jDn01-00058g-5o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jDmzz-0003qM-G1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:29:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30687
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jDmzz-0003YE-3X
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584354570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deak2Xp6mgo1TjUDBmG8J75sQIF5ztls/Y6iCuBOxwk=;
 b=CDVwpkgyRQ07gfF2KZeAnxJCvzwqEC+bWijqe2EszWWCc83yveH85Y2S5EX+eKhDhEtTTg
 dc7OHkK6r55pJGCV2jPMVv3HE6wOZja/3/g5xsgwspiuJKtlFE2z2W/E0VC0DVlDyCMWIR
 +YbqXKztSWHVf0i6cX/q9PDSCmGYynQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-PkaTN1NoOY6T19z0k8Blww-1; Mon, 16 Mar 2020 06:29:01 -0400
X-MC-Unique: PkaTN1NoOY6T19z0k8Blww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5BB3149D6;
 Mon, 16 Mar 2020 10:29:00 +0000 (UTC)
Received: from localhost (ovpn-200-42.brq.redhat.com [10.40.200.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD69F90806;
 Mon, 16 Mar 2020 10:28:53 +0000 (UTC)
Date: Mon, 16 Mar 2020 11:28:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 2/3] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200316112851.2364eb46@redhat.com>
In-Reply-To: <20200313145009.144820-3-liran.alon@oracle.com>
References: <20200313145009.144820-1-liran.alon@oracle.com>
 <20200313145009.144820-3-liran.alon@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 16:50:08 +0200
Liran Alon <liran.alon@oracle.com> wrote:

> Microsoft introduced this ACPI table to avoid Windows guests performing
> various workarounds for device erratas. As the virtual device emulated
> by VMM may not have the errata.
> 
> Currently, WAET allows hypervisor to inform guest about two
> specific behaviors: One for RTC and the other for ACPI PM timer.
> 
> Support for WAET have been introduced since Windows Vista. This ACPI
> table is also exposed by other common hypervisors by default, including:
> VMware, GCP and AWS.
> 
> This patch adds WAET ACPI Table to QEMU.
> 
> We set "ACPI PM timer good" bit in "Emualted Device Flags" field to
> indicate that the ACPI PM timer has been enhanced to not require
> multiple reads to obtain a reliable value.
> This results in improving the performance of Windows guests that use
> ACPI PM timer by avoiding unnecessary VMExits caused by these multiple
> reads.
> 
> Co-developed-by: Elad Gabay <elad.gabay@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9c4e46fa7466..1c3a2e8fcb3c 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2512,6 +2512,34 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
>      build_header(linker, table_data, (void *)(table_data->data + dmar_start),
>                   "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
>  }
> +
> +/*
> + * Windows ACPI Emulated Devices Table
> + * (Version 1.0 - April 6, 2009)
> + * Spec: http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx
> + *
> + * Helpful to speedup Windows guests and ignored by others.
> + */
> +static void
> +build_waet(GArray *table_data, BIOSLinker *linker)
> +{
> +    int waet_start = table_data->len;
> +
> +    /* WAET header */
> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +    /*
> +     * Set "ACPI PM timer good" flag.
> +     *
> +     * Tells Windows guests that our ACPI PM timer is reliable in the
> +     * sense that guest can read it only once to obtain a reliable value.
> +     * Which avoids costly VMExits caused by guest re-reading it unnecessarily.
> +     */
> +    build_append_int_noprefix(table_data, 1 << 1 /* ACPI PM timer good */, 4);
this should work but, I'd use (1UL << 1) if you'll need to respin


> +
> +    build_header(linker, table_data, (void *)(table_data->data + waet_start),
> +                 "WAET", table_data->len - waet_start, 1, NULL, NULL);
> +}
> +
>  /*
>   *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
>   *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
> @@ -2859,6 +2887,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>                            machine->nvdimms_state, machine->ram_slots);
>      }
>  
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_waet(tables_blob, tables->linker);
> +
>      /* Add tables supplied by user (if any) */
>      for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
>          unsigned len = acpi_table_len(u);


