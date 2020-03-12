Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71543C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C62E2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyeZLbmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C62E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQiY-0000Gj-0T
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jCQgw-0005no-Vr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jCQgu-0004Cx-NI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:28:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jCQgu-0004Bo-GS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584030491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QY6DqpCPqLTl0EzQC9IzAK2H+be/aVlhpek/py68clI=;
 b=UyeZLbmDZ31Ibs2Y4AWU0wJIOqveuQAWfsNMPozFdm6GdKV1/7q0kPqKQ4lRjL58fY3cu5
 62MpU+OvmoloqRL8O2NAKKkUrympUze43F1iUtskXSdRbRE92kfXQuDBxdWdnAE5qai3FO
 zdj8Ny5RirkPHE6C35CkJ2yzKMgyKXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-gyCGpKDCPJStdRqKafyCHA-1; Thu, 12 Mar 2020 12:27:53 -0400
X-MC-Unique: gyCGpKDCPJStdRqKafyCHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57B41107ACC7;
 Thu, 12 Mar 2020 16:27:52 +0000 (UTC)
Received: from localhost (ovpn-200-48.brq.redhat.com [10.40.200.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B034E92D39;
 Thu, 12 Mar 2020 16:27:47 +0000 (UTC)
Date: Thu, 12 Mar 2020 17:27:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200312172745.1b7b2222@redhat.com>
In-Reply-To: <20200311170826.79419-1-liran.alon@oracle.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Wed, 11 Mar 2020 19:08:26 +0200
Liran Alon <liran.alon@oracle.com> wrote:

> From: Elad Gabay <elad.gabay@oracle.com>
> 
> Microsoft introduced this ACPI table to avoid Windows guests performing
> various workarounds for device erratas. As the virtual device emulated
> by VMM may not have the errata.
> 
> Currently, WAET allows hypervisor to inform guest about two
> specific behaviors: One for RTC and the other for ACPI PM Timer.
> 
> Support for WAET have been introduced since Windows Vista. This ACPI
> table is also exposed by other hypervisors, such as VMware, by default.
> 
> This patch adds WAET ACPI Table to QEMU. It also makes sure to introduce
> the new ACPI table only for new machine-types.

in addition to comments made by Michael ...

> 
> Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
> Co-developed-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/i386/acpi-build.c        | 18 ++++++++++++++++++
>  hw/i386/pc_piix.c           |  2 ++
>  hw/i386/pc_q35.c            |  2 ++
>  include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
>  include/hw/i386/pc.h        |  1 +
>  5 files changed, 48 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9c4e46fa7466..29f70741cd96 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
>      build_header(linker, table_data, (void *)(table_data->data + dmar_start),
>                   "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
>  }
> +
> +static void
> +build_waet(GArray *table_data, BIOSLinker *linker)
see build_hmat_lb() for example how to doc comment for such function
should look like. Use earliest spec version where table was introduced.

> +{
> +    AcpiTableWaet *waet;
> +
> +    waet = acpi_data_push(table_data, sizeof(*waet));
> +    waet->emulated_device_flags = cpu_to_le32(ACPI_WAET_PM_TIMER_GOOD);

we don't use packed structures for building ACPI tables anymore (there is
old code that still does but that's being converted when we touch it)

pls use build_append_int_noprefix() api instead, see build_amd_iommu() as
an example how to build binary tables using it and how to use comments
to document fields.
Basic idea is that api makes function building a table match table's
description in spec (each call represents a row in spec) and comment
belonging to a row should contain verbatim field name as used by spec
so reader could copy/past and grep it easily.




> +
> +    build_header(linker, table_data,
> +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL);
> +}
> +
>  /*
>   *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
>   *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
> @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>                            machine->nvdimms_state, machine->ram_slots);
>      }
>  
> +    if (!pcmc->do_not_add_waet_acpi) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_waet(tables_blob, tables->linker);
> +    }

we typically do not version ACPI table changes (there might be exceptions
but it should be a justified one).
ACPI tables are considered to be a part of firmware (even though they are
generated by QEMU) so on QEMU upgrade user gets a new firmware along with
new ACPI tables.

> +
>      /* Add tables supplied by user (if any) */
>      for (u = acpi_table_first(); u; u = acpi_table_next(u)) {
>          unsigned len = acpi_table_len(u);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 9088db8fb601..2d11a8b50a9c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
>  
>  static void pc_i440fx_4_2_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_5_0_machine_options(m);
>      m->alias = NULL;
>      m->is_default = false;
> +    pcmc->do_not_add_waet_acpi = true;
>      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 84cf925cf43a..1e0a726b27a7 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
>  
>  static void pc_q35_4_2_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_5_0_machine_options(m);
>      m->alias = NULL;
> +    pcmc->do_not_add_waet_acpi = true;
>      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 57a3f58b0c9a..803c904471d5 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -634,4 +634,29 @@ struct AcpiIortRC {
>  } QEMU_PACKED;
>  typedef struct AcpiIortRC AcpiIortRC;
>  
> +/*
> + * Windows ACPI Emulated Devices Table.
> + * Specification:
> + * http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx
> + */
> +
> +/*
> + * Indicates whether the RTC has been enhanced not to require acknowledgment
> + * after it asserts an interrupt. With this bit set, an interrupt handler can
> + * bypass reading the RTC register C to unlatch the pending interrupt.
> + */
> +#define ACPI_WAET_RTC_GOOD      (1 << 0)
> +/*
> + * Indicates whether the ACPI PM timer has been enhanced not to require
> + * multiple reads. With this bit set, only one read of the ACPI PM timer is
> + * necessary to obtain a reliable value.
> + */
> +#define ACPI_WAET_PM_TIMER_GOOD (1 << 1)
> +
> +struct AcpiTableWaet {
> +    ACPI_TABLE_HEADER_DEF
> +    uint32_t emulated_device_flags;
> +} QEMU_PACKED;
> +typedef struct AcpiTableWaet AcpiTableWaet;
> +
>  #endif
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 60c988c4a5aa..f1f64e8f45c8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -100,6 +100,7 @@ typedef struct PCMachineClass {
>      int legacy_acpi_table_size;
>      unsigned acpi_data_size;
>      bool do_not_add_smb_acpi;
> +    bool do_not_add_waet_acpi;
>  
>      /* SMBIOS compat: */
>      bool smbios_defaults;


