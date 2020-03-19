Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA99C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566FD208D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVS2sqnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566FD208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvk9-0005rN-E4
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEvjA-0005SR-NR
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEvj8-0000jn-MK
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:00:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEvj8-0000fx-Fp
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584626449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fuDx3udZHzOcUqRiQ6LeQnX0tMxmHZ2LvtFFxePwIo=;
 b=iVS2sqnM4LPYT145jhctA1H1AuM4bDD5nwDrOES33tJ1X/ybtYZxsPNwYyz4UlgJaQKLAJ
 ABmmWTLvYEXv30RRjWFz2WSzF8O5MMJf90Io6yt7d4+S0FD+Lie2FyfzDqJDKdjrfgf6mL
 djaCGjGZtGIFTusnEpdaEy5P51J6ewg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-MUspV_GXNBCcX0nNxb3DwA-1; Thu, 19 Mar 2020 10:00:47 -0400
X-MC-Unique: MUspV_GXNBCcX0nNxb3DwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72DB1107ACC9;
 Thu, 19 Mar 2020 14:00:46 +0000 (UTC)
Received: from localhost (unknown [10.40.208.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE00166AE;
 Thu, 19 Mar 2020 14:00:35 +0000 (UTC)
Date: Thu, 19 Mar 2020 15:00:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 04/13] microvm: add minimal acpi support.
Message-ID: <20200319150033.13f50947@redhat.com>
In-Reply-To: <20200319080117.7725-5-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-5-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Thu, 19 Mar 2020 09:01:08 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> $subject says all.  Can be disabled using the usual -no-acpi switch.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i386/microvm.h |   3 +
>  hw/i386/acpi-build.c      | 124 +++++++++++++++++++++++++++++++++++---
>  hw/i386/microvm.c         |  14 +++++
>  3 files changed, 133 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> index ba68d1f22bb3..da2852a70195 100644
> --- a/include/hw/i386/microvm.h
> +++ b/include/hw/i386/microvm.h
> @@ -24,6 +24,7 @@
>  
>  #include "hw/boards.h"
>  #include "hw/i386/x86.h"
> +#include "hw/acpi/acpi_dev_interface.h"
>  
>  /* Platform virtio definitions */
>  #define VIRTIO_MMIO_BASE      0xc0000000
> @@ -58,6 +59,8 @@ typedef struct {
>  
>      /* Machine state */
>      bool kernel_cmdline_fixed;
> +    Notifier machine_done;
> +    AcpiDeviceIf *acpi_dev;
>  } MicrovmMachineState;
>  
>  #define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9c98b07116cc..0e45a646af56 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -59,6 +59,7 @@
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/q35.h"
>  #include "hw/i386/x86-iommu.h"
> +#include "hw/i386/microvm.h"
>  
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/utils.h"
> @@ -2749,12 +2750,103 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      return true;
>  }
>  
> +static void
> +build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
> +                   MicrovmMachineState *mms)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(mms);
> +    Aml *dsdt, *sb_scope, *scope, *pkg;
> +
> +    dsdt = init_aml_allocator();
> +
> +    /* Reserve space for header */
> +    acpi_data_push(dsdt->buf, sizeof(AcpiTableHeader));
> +
> +    build_dbg_aml(dsdt);
I'd drop/comment out as it's usually not used and whoever need
to debug aml can enable it when necessary.

> +
> +    sb_scope = aml_scope("_SB");
> +    acpi_dsdt_add_fw_cfg(sb_scope, OBJECT(x86ms->fw_cfg));
> +    aml_append(dsdt, sb_scope);
> +
> +    scope = aml_scope("\\");
> +    pkg = aml_package(4);
> +    aml_append(pkg, aml_int(0)); /* PM1a_CNT.SLP_TYP */
> +    aml_append(pkg, aml_int(0)); /* PM1b_CNT.SLP_TYP not impl. */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(pkg, aml_int(0)); /* reserved */
> +    aml_append(scope, aml_name_decl("_S5", pkg));
> +    aml_append(dsdt, scope);
> +
> +    /* copy AML table into ACPI tables blob and patch header there */
> +    g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
> +    build_header(linker, table_data,
> +        (void *)(table_data->data + table_data->len - dsdt->buf->len),
> +        "DSDT", dsdt->buf->len, 1, NULL, NULL);

make revision at least 2 or newer (like copy arm/virt 5th rev)


> +    free_aml_allocator();
> +}
> +
> +static
> +void acpi_build_microvm(AcpiBuildTables *tables, MachineState *machine)
> +{
> +    MicrovmMachineState *mms = MICROVM_MACHINE(machine);
> +    GArray *table_offsets;
> +    GArray *tables_blob = tables->table_data;
> +    AcpiFadtData pmfadt;
> +    unsigned facs, dsdt, rsdt;
> +
> +    init_common_fadt_data(machine, OBJECT(mms->acpi_dev), &pmfadt);
> +    pmfadt.smi_cmd = 0;
> +
> +    table_offsets = g_array_new(false, true /* clear */,
> +                                        sizeof(uint32_t));
> +    bios_linker_loader_alloc(tables->linker,
> +                             ACPI_BUILD_TABLE_FILE, tables_blob,
> +                             64 /* Ensure FACS is aligned */,
> +                             false /* high memory */);
> +
> +    facs = tables_blob->len;
> +    build_facs(tables_blob);
> +
> +    dsdt = tables_blob->len;
> +    build_dsdt_microvm(tables_blob, tables->linker, mms);
> +
> +    pmfadt.facs_tbl_offset = &facs;
> +    pmfadt.dsdt_tbl_offset = &dsdt;
> +    pmfadt.xdsdt_tbl_offset = &dsdt;
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_fadt(tables_blob, tables->linker, &pmfadt, NULL, NULL);
> +
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_madt(tables_blob, tables->linker, X86_MACHINE(machine),
> +               mms->acpi_dev);
> +
> +    rsdt = tables_blob->len;
> +    build_rsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
> +
> +    /* RSDP is in FSEG memory, so allocate it separately */
> +    {
> +        AcpiRsdpData rsdp_data = {
> +            .revision = 0,
> +            .oem_id = ACPI_BUILD_APPNAME6,
> +            .xsdt_tbl_offset = NULL,
> +            .rsdt_tbl_offset = &rsdt,
are we interested in 32-bit guests?
if not than maybe use xsdt and newer revision like arm/virt does

> +        };
> +        build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
> +    }
> +
> +    acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
> +    acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
> +
> +    /* Cleanup memory that's no longer used. */
> +    g_array_free(table_offsets, true);
> +}
> +
>  static
>  void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>  {
> -    PCMachineState *pcms = PC_MACHINE(machine);
> -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      X86MachineState *x86ms = X86_MACHINE(machine);
> +    PCMachineState *pcms;
> +    PCMachineClass *pcmc;
>      GArray *table_offsets;
>      unsigned facs, dsdt, rsdt, fadt;
>      AcpiPmInfo pm;
> @@ -2767,6 +2859,14 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
>      Object *vmgenid_dev;
>  
> +    if (strcmp(object_get_typename(OBJECT(x86ms)), TYPE_MICROVM_MACHINE) == 0) {
maybe use object_dynamic_cast(OBJECT(x86ms)), TYPE_MICROVM_MACHINE)

> +        acpi_build_microvm(tables, machine);
> +        return;
> +    } else {
> +        pcms = PC_MACHINE(machine);
> +        pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    }
> +
>      acpi_get_pm_info(machine, &pm);
>      acpi_get_misc_info(&misc);
>      acpi_get_pci_holes(&pci_hole, &pci_hole64);
> @@ -3009,21 +3109,29 @@ static const VMStateDescription vmstate_acpi_build = {
>  
>  void acpi_setup(void)
>  {
> -    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> -    X86MachineState *x86ms = X86_MACHINE(pcms);
> +    X86MachineState *x86ms = X86_MACHINE(qdev_get_machine());
> +    PCMachineState *pcms;
> +    PCMachineClass *pcmc;
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
>      Object *vmgenid_dev;
>      TPMIf *tpm;
>      static FwCfgTPMConfig tpm_config;
>  
> +    if (strcmp(object_get_typename(OBJECT(x86ms)), TYPE_MICROVM_MACHINE) == 0) {
> +        pcms = NULL;
> +        pcmc = NULL;
> +    } else {
> +        pcms = PC_MACHINE(x86ms);
> +        pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    }
> +
>      if (!x86ms->fw_cfg) {
>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>          return;
>      }
>  
> -    if (!pcms->acpi_build_enabled) {
> +    if (pcms && !pcms->acpi_build_enabled) {
>          ACPI_BUILD_DPRINTF("ACPI build disabled. Bailing out.\n");
>          return;
>      }
> @@ -3036,7 +3144,7 @@ void acpi_setup(void)
>      build_state = g_malloc0(sizeof *build_state);
>  
>      acpi_build_tables_init(&tables);
> -    acpi_build(&tables, MACHINE(pcms));
> +    acpi_build(&tables, MACHINE(x86ms));
>  
>      /* Now expose it all to Guest */
>      build_state->table_mr = acpi_add_rom_blob(acpi_build_update,
> @@ -3069,7 +3177,7 @@ void acpi_setup(void)
>                             tables.vmgenid);
>      }
>  
> -    if (!pcmc->rsdp_in_ram) {
> +    if (pcmc && !pcmc->rsdp_in_ram) {
>          /*
>           * Keep for compatibility with old machine types.
>           * Though RSDP is small, its contents isn't immutable, so
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 38d8e5170323..362d513f38e1 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -26,6 +26,7 @@
>  #include "sysemu/cpus.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
> +#include "acpi-build.h"
>  
>  #include "hw/loader.h"
>  #include "hw/irq.h"
> @@ -41,6 +42,7 @@
>  #include "hw/i386/e820_memory_layout.h"
>  #include "hw/i386/fw_cfg.h"
>  #include "hw/virtio/virtio-mmio.h"
> +#include "hw/acpi/acpi.h"
>  
>  #include "cpu.h"
>  #include "elf.h"
> @@ -128,6 +130,10 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>      }
>  
>      /* Optional and legacy devices */
> +    if (acpi_enabled) {
> +        ISADevice *acpi = isa_create_simple(isa_bus, "isa-acpi" /* FIXME */);
> +        mms->acpi_dev = ACPI_DEVICE_IF(acpi);
> +    }
>  
>      if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
>          qemu_irq *i8259;
> @@ -468,6 +474,11 @@ static void microvm_machine_set_auto_kernel_cmdline(Object *obj, bool value,
>      mms->auto_kernel_cmdline = value;
>  }
>  
> +static void microvm_machine_done(Notifier *notifier, void *data)
> +{
> +    acpi_setup();
> +}
> +
>  static void microvm_machine_initfn(Object *obj)
>  {
>      MicrovmMachineState *mms = MICROVM_MACHINE(obj);
> @@ -482,6 +493,9 @@ static void microvm_machine_initfn(Object *obj)
>  
>      /* State */
>      mms->kernel_cmdline_fixed = false;
> +
> +    mms->machine_done.notify = microvm_machine_done;
> +    qemu_add_machine_init_done_notifier(&mms->machine_done);
>  }
>  
>  static void microvm_class_init(ObjectClass *oc, void *data)


