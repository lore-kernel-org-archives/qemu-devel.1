Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C449C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410D1207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410D1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmDR-0006ZN-H9
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCl47-0002XC-9l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCl3x-0007UC-Nj
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:41:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCl3x-0007Tp-5V
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:41:05 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 594783CA00
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:41:03 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f63so24147wma.7
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8HE8bCC6CItGE2z3SHqlOtC6yfII1OEDE7uPqjpWEJg=;
 b=JxJPi8shRq+z1PMzd9rwtOO3ZK0345oVujxBFfgKeOrtpYCA3FiqMlN/9SspODtltt
 qXRaZmP9PUoyyAmi4BkwYs2HB+Vc6m87sfEVIXsJms+xb3drytjRvZ7CERgN3sGEgVg3
 6FrafZcg/ppsHMREtcCEkTxw9lC4Ch/j9dWJ3penGxBY02DKJKk1T8hiCyaeZZWKTce7
 GujmGiBhRGYzIggb2QGP1JOQUD5VFzVN1Y9XFgWQjOxkqClvBkj3M/LxcIwebgTOHMzI
 B5iMsuNx7cN5ePayevCoCwXky1sG8OED1zAtTyHVqGO0avnxWM1WO7QhvX8tVijokyCQ
 ZoxQ==
X-Gm-Message-State: APjAAAWP6XsloGQr50r942TWX1LyL93kTJCpd7N5aIq5YwIqQLKjhX1B
 8Elijs/tONtAMLn8j6sPWfotzVTWsLpY0Kw4YRe6HzeUSrDaStGbhzsu1MWOB3peWj8xYDF7Fee
 v6UP8BSKqDUH0H0Q=
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr76730wmq.60.1569332459168;
 Tue, 24 Sep 2019 06:40:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyN33Oei6ZYvE7KyuWrrhg4Cj6rItGzNZdMWeP9lzvXPp+CxOts0L5k5fFObRE0w2G9/gepKQ==
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr76630wmq.60.1569332458183;
 Tue, 24 Sep 2019 06:40:58 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u10sm3063212wrg.55.2019.09.24.06.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 06:40:57 -0700 (PDT)
Subject: Re: [PATCH v4 4/8] hw/i386: split PCMachineState deriving
 X86MachineState from it
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-5-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c339da92-dca2-fdf2-bd0b-195baca50589@redhat.com>
Date: Tue, 24 Sep 2019 15:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924124433.96810-5-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 2:44 PM, Sergio Lopez wrote:
> Split up PCMachineState and PCMachineClass and derive X86MachineState
> and X86MachineClass from them. This allows sharing code with non-PC
> machine types.
>=20
> Also, move shared functions from pc.c to x86.c.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  hw/acpi/cpu_hotplug.c |  10 +-
>  hw/i386/Makefile.objs |   1 +
>  hw/i386/acpi-build.c  |  31 +-
>  hw/i386/amd_iommu.c   |   4 +-
>  hw/i386/intel_iommu.c |   4 +-
>  hw/i386/pc.c          | 796 +++++-------------------------------------
>  hw/i386/pc_piix.c     |  48 +--
>  hw/i386/pc_q35.c      |  38 +-
>  hw/i386/pc_sysfw.c    |  60 +---
>  hw/i386/x86.c         | 788 +++++++++++++++++++++++++++++++++++++++++
>  hw/intc/ioapic.c      |   3 +-
>  include/hw/i386/pc.h  |  29 +-
>  include/hw/i386/x86.h |  97 +++++
>  13 files changed, 1045 insertions(+), 864 deletions(-)
>  create mode 100644 hw/i386/x86.c
>  create mode 100644 include/hw/i386/x86.h
>=20
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index 6e8293aac9..3ac2045a95 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -128,7 +128,7 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, Machine=
State *machine,
>      Aml *one =3D aml_int(1);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(machin=
e);
> -    PCMachineState *pcms =3D PC_MACHINE(machine);
> +    X86MachineState *x86ms =3D X86_MACHINE(machine);
> =20
>      /*
>       * _MAT method - creates an madt apic buffer
> @@ -236,9 +236,9 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, Machine=
State *machine,
>      /* The current AML generator can cover the APIC ID range [0..255],
>       * inclusive, for VCPU hotplug. */
>      QEMU_BUILD_BUG_ON(ACPI_CPU_HOTPLUG_ID_LIMIT > 256);
> -    if (pcms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
> +    if (x86ms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
>          error_report("max_cpus is too large. APIC ID of last CPU is %u=
",
> -                     pcms->apic_id_limit - 1);
> +                     x86ms->apic_id_limit - 1);
>          exit(1);
>      }
> =20
> @@ -315,8 +315,8 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, Machine=
State *machine,
>       * ith up to 255 elements. Windows guests up to win2k8 fail when
>       * VarPackageOp is used.
>       */
> -    pkg =3D pcms->apic_id_limit <=3D 255 ? aml_package(pcms->apic_id_l=
imit) :
> -                                       aml_varpackage(pcms->apic_id_li=
mit);
> +    pkg =3D x86ms->apic_id_limit <=3D 255 ? aml_package(x86ms->apic_id=
_limit) :
> +                                        aml_varpackage(x86ms->apic_id_=
limit);
> =20
>      for (i =3D 0, apic_idx =3D 0; i < apic_ids->len; i++) {
>          int apic_id =3D apic_ids->cpus[i].arch_id;
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 149712db07..5b4b3a672e 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_KVM) +=3D kvm/
>  obj-y +=3D multiboot.o
>  obj-y +=3D pvh.o
> +obj-y +=3D x86.o
>  obj-y +=3D pc.o
>  obj-y +=3D e820.o
>  obj-$(CONFIG_I440FX) +=3D pc_piix.o
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index e54e571a75..76e18d3285 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -29,6 +29,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/core/cpu.h"
>  #include "target/i386/cpu.h"
> +#include "hw/i386/x86.h"
>  #include "hw/misc/pvpanic.h"
>  #include "hw/timer/hpet.h"
>  #include "hw/acpi/acpi-defs.h"
> @@ -361,6 +362,7 @@ static void
>  build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcm=
s)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHIN=
E(pcms));
>      int madt_start =3D table_data->len;
>      AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_d=
ev);
> @@ -390,7 +392,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, =
PCMachineState *pcms)
>      io_apic->address =3D cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
>      io_apic->interrupt =3D cpu_to_le32(0);
> =20
> -    if (pcms->apic_xrupt_override) {
> +    if (x86ms->apic_xrupt_override) {
>          intsrcovr =3D acpi_data_push(table_data, sizeof *intsrcovr);
>          intsrcovr->type   =3D ACPI_APIC_XRUPT_OVERRIDE;
>          intsrcovr->length =3D sizeof(*intsrcovr);
> @@ -1817,8 +1819,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>      CrsRangeEntry *entry;
>      Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
>      CrsRangeSet crs_range_set;
> -    PCMachineState *pcms =3D PC_MACHINE(machine);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(machine);
> +    X86MachineState *x86ms =3D X86_MACHINE(machine);
>      AcpiMcfgInfo mcfg;
>      uint32_t nr_mem =3D machine->ram_slots;
>      int root_bus_limit =3D 0xFF;
> @@ -2083,7 +2085,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>           * with half of the 16-bit control register. Hence, the total =
size
>           * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, =
the
>           * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 *=
/
> -        uint8_t io_size =3D object_property_get_bool(OBJECT(pcms->fw_c=
fg),
> +        uint8_t io_size =3D object_property_get_bool(OBJECT(x86ms->fw_=
cfg),
>                                                     "dma_enabled", NULL=
) ?
>                            ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_ad=
dr_t) :
>                            FW_CFG_CTL_SIZE;
> @@ -2318,6 +2320,7 @@ build_srat(GArray *table_data, BIOSLinker *linker=
, MachineState *machine)
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(machin=
e);
>      PCMachineState *pcms =3D PC_MACHINE(machine);
> +    X86MachineState *x86ms =3D X86_MACHINE(machine);
>      ram_addr_t hotplugabble_address_space_size =3D
>          object_property_get_int(OBJECT(pcms), PC_MACHINE_DEVMEM_REGION=
_SIZE,
>                                  NULL);
> @@ -2386,16 +2389,16 @@ build_srat(GArray *table_data, BIOSLinker *link=
er, MachineState *machine)
>          }
> =20
>          /* Cut out the ACPI_PCI hole */
> -        if (mem_base <=3D pcms->below_4g_mem_size &&
> -            next_base > pcms->below_4g_mem_size) {
> -            mem_len -=3D next_base - pcms->below_4g_mem_size;
> +        if (mem_base <=3D x86ms->below_4g_mem_size &&
> +            next_base > x86ms->below_4g_mem_size) {
> +            mem_len -=3D next_base - x86ms->below_4g_mem_size;
>              if (mem_len > 0) {
>                  numamem =3D acpi_data_push(table_data, sizeof *numamem=
);
>                  build_srat_memory(numamem, mem_base, mem_len, i - 1,
>                                    MEM_AFFINITY_ENABLED);
>              }
>              mem_base =3D 1ULL << 32;
> -            mem_len =3D next_base - pcms->below_4g_mem_size;
> +            mem_len =3D next_base - x86ms->below_4g_mem_size;
>              next_base =3D mem_base + mem_len;
>          }
> =20
> @@ -2614,6 +2617,7 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
>  {
>      PCMachineState *pcms =3D PC_MACHINE(machine);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(machine);
>      GArray *table_offsets;
>      unsigned facs, dsdt, rsdt, fadt;
>      AcpiPmInfo pm;
> @@ -2775,7 +2779,7 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
>           */
>          int legacy_aml_len =3D
>              pcmc->legacy_acpi_table_size +
> -            ACPI_BUILD_LEGACY_CPU_AML_SIZE * pcms->apic_id_limit;
> +            ACPI_BUILD_LEGACY_CPU_AML_SIZE * x86ms->apic_id_limit;
>          int legacy_table_size =3D
>              ROUND_UP(tables_blob->len - aml_len + legacy_aml_len,
>                       ACPI_BUILD_ALIGN_SIZE);
> @@ -2865,13 +2869,14 @@ void acpi_setup(void)
>  {
>      PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
>      Object *vmgenid_dev;
>      TPMIf *tpm;
>      static FwCfgTPMConfig tpm_config;
> =20
> -    if (!pcms->fw_cfg) {
> +    if (!x86ms->fw_cfg) {
>          ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
>          return;
>      }
> @@ -2902,7 +2907,7 @@ void acpi_setup(void)
>          acpi_add_rom_blob(acpi_build_update, build_state,
>                            tables.linker->cmd_blob, "etc/table-loader",=
 0);
> =20
> -    fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
> +    fw_cfg_add_file(x86ms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>                      tables.tcpalog->data, acpi_data_len(tables.tcpalog=
));
> =20
>      tpm =3D tpm_find();
> @@ -2912,13 +2917,13 @@ void acpi_setup(void)
>              .tpm_version =3D tpm_get_version(tpm),
>              .tpmppi_version =3D TPM_PPI_VERSION_1_30
>          };
> -        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
> +        fw_cfg_add_file(x86ms->fw_cfg, "etc/tpm/config",
>                          &tpm_config, sizeof tpm_config);
>      }
> =20
>      vmgenid_dev =3D find_vmgenid_dev();
>      if (vmgenid_dev) {
> -        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
> +        vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), x86ms->fw_cfg,
>                             tables.vmgenid);
>      }
> =20
> @@ -2931,7 +2936,7 @@ void acpi_setup(void)
>          uint32_t rsdp_size =3D acpi_data_len(tables.rsdp);
> =20
>          build_state->rsdp =3D g_memdup(tables.rsdp->data, rsdp_size);
> -        fw_cfg_add_file_callback(pcms->fw_cfg, ACPI_BUILD_RSDP_FILE,
> +        fw_cfg_add_file_callback(x86ms->fw_cfg, ACPI_BUILD_RSDP_FILE,
>                                   acpi_build_update, NULL, build_state,
>                                   build_state->rsdp, rsdp_size, true);
>          build_state->rsdp_mr =3D NULL;
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 08884523e2..bb3b5b4563 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -21,6 +21,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "hw/i386/x86.h"
>  #include "hw/i386/pc.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/pci_bus.h"
> @@ -1537,6 +1538,7 @@ static void amdvi_realize(DeviceState *dev, Error=
 **err)
>      X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(dev);
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      PCMachineState *pcms =3D PC_MACHINE(ms);
> +    X86MachineState *x86ms =3D X86_MACHINE(ms);
>      PCIBus *bus =3D pcms->bus;
> =20
>      s->iotlb =3D g_hash_table_new_full(amdvi_uint64_hash,
> @@ -1565,7 +1567,7 @@ static void amdvi_realize(DeviceState *dev, Error=
 **err)
>      }
> =20
>      /* Pseudo address space under root PCI bus. */
> -    pcms->ioapic_as =3D amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_D=
EVID);
> +    x86ms->ioapic_as =3D amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_=
DEVID);
> =20
>      /* set up MMIO */
>      memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdv=
i-mmio",
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 75ca6f9c70..21f091c654 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -29,6 +29,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/i386/x86.h"
>  #include "hw/i386/pc.h"
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/boards.h"
> @@ -3703,6 +3704,7 @@ static void vtd_realize(DeviceState *dev, Error *=
*errp)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      PCMachineState *pcms =3D PC_MACHINE(ms);
> +    X86MachineState *x86ms =3D X86_MACHINE(ms);
>      PCIBus *bus =3D pcms->bus;
>      IntelIOMMUState *s =3D INTEL_IOMMU_DEVICE(dev);
>      X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(dev);
> @@ -3743,7 +3745,7 @@ static void vtd_realize(DeviceState *dev, Error *=
*errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
>      pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
>      /* Pseudo address space under root PCI bus. */
> -    pcms->ioapic_as =3D vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IO=
APIC);
> +    x86ms->ioapic_as =3D vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_I=
OAPIC);
>  }
> =20
>  static void vtd_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3920aa7e85..d18b461f01 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -24,6 +24,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "hw/i386/x86.h"
>  #include "hw/i386/pc.h"
>  #include "hw/char/serial.h"
>  #include "hw/char/parallel.h"
> @@ -676,6 +677,7 @@ void pc_cmos_init(PCMachineState *pcms,
>                    BusState *idebus0, BusState *idebus1,
>                    ISADevice *s)
>  {
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      int val;
>      static pc_cmos_init_late_arg arg;
> =20
> @@ -683,12 +685,12 @@ void pc_cmos_init(PCMachineState *pcms,
> =20
>      /* memory size */
>      /* base memory (first MiB) */
> -    val =3D MIN(pcms->below_4g_mem_size / KiB, 640);
> +    val =3D MIN(x86ms->below_4g_mem_size / KiB, 640);
>      rtc_set_memory(s, 0x15, val);
>      rtc_set_memory(s, 0x16, val >> 8);
>      /* extended memory (next 64MiB) */
> -    if (pcms->below_4g_mem_size > 1 * MiB) {
> -        val =3D (pcms->below_4g_mem_size - 1 * MiB) / KiB;
> +    if (x86ms->below_4g_mem_size > 1 * MiB) {
> +        val =3D (x86ms->below_4g_mem_size - 1 * MiB) / KiB;
>      } else {
>          val =3D 0;
>      }
> @@ -699,8 +701,8 @@ void pc_cmos_init(PCMachineState *pcms,
>      rtc_set_memory(s, 0x30, val);
>      rtc_set_memory(s, 0x31, val >> 8);
>      /* memory between 16MiB and 4GiB */
> -    if (pcms->below_4g_mem_size > 16 * MiB) {
> -        val =3D (pcms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
> +    if (x86ms->below_4g_mem_size > 16 * MiB) {
> +        val =3D (x86ms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
>      } else {
>          val =3D 0;
>      }
> @@ -709,20 +711,20 @@ void pc_cmos_init(PCMachineState *pcms,
>      rtc_set_memory(s, 0x34, val);
>      rtc_set_memory(s, 0x35, val >> 8);
>      /* memory above 4GiB */
> -    val =3D pcms->above_4g_mem_size / 65536;
> +    val =3D x86ms->above_4g_mem_size / 65536;
>      rtc_set_memory(s, 0x5b, val);
>      rtc_set_memory(s, 0x5c, val >> 8);
>      rtc_set_memory(s, 0x5d, val >> 16);
> =20
> -    object_property_add_link(OBJECT(pcms), "rtc_state",
> +    object_property_add_link(OBJECT(x86ms), "rtc_state",
>                               TYPE_ISA_DEVICE,
> -                             (Object **)&pcms->rtc,
> +                             (Object **)&x86ms->rtc,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG, &error_abort);
> -    object_property_set_link(OBJECT(pcms), OBJECT(s),
> +    object_property_set_link(OBJECT(x86ms), OBJECT(s),
>                               "rtc_state", &error_abort);
> =20
> -    set_boot_dev(s, MACHINE(pcms)->boot_order, &error_fatal);
> +    set_boot_dev(s, MACHINE(x86ms)->boot_order, &error_fatal);
> =20
>      val =3D 0;
>      val |=3D 0x02; /* FPU is there */
> @@ -863,35 +865,6 @@ static void handle_a20_line_change(void *opaque, i=
nt irq, int level)
>      x86_cpu_set_a20(cpu, level);
>  }
> =20
> -/* Calculates initial APIC ID for a specific CPU index
> - *
> - * Currently we need to be able to calculate the APIC ID from the CPU =
index
> - * alone (without requiring a CPU object), as the QEMU<->Seabios inter=
faces have
> - * no concept of "CPU index", and the NUMA tables on fw_cfg need the A=
PIC ID of
> - * all CPUs up to max_cpus.
> - */
> -static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
> -                                           unsigned int cpu_index)
> -{
> -    MachineState *ms =3D MACHINE(pcms);
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> -    uint32_t correct_id;
> -    static bool warned;
> -
> -    correct_id =3D x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cor=
es,
> -                                         ms->smp.threads, cpu_index);
> -    if (pcmc->compat_apic_id_mode) {
> -        if (cpu_index !=3D correct_id && !warned && !qtest_enabled()) =
{
> -            error_report("APIC IDs set in compatibility mode, "
> -                         "CPU topology won't match the configuration")=
;
> -            warned =3D true;
> -        }
> -        return cpu_index;
> -    } else {
> -        return correct_id;
> -    }
> -}
> -
>  static void pc_build_smbios(PCMachineState *pcms)
>  {
>      uint8_t *smbios_tables, *smbios_anchor;
> @@ -899,6 +872,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>      struct smbios_phys_mem_area *mem_array;
>      unsigned i, array_count;
>      MachineState *ms =3D MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      X86CPU *cpu =3D X86_CPU(ms->possible_cpus->cpus[0].cpu);
> =20
>      /* tell smbios about cpuid version and features */
> @@ -906,7 +880,7 @@ static void pc_build_smbios(PCMachineState *pcms)
> =20
>      smbios_tables =3D smbios_get_table_legacy(ms, &smbios_tables_len);
>      if (smbios_tables) {
> -        fw_cfg_add_bytes(pcms->fw_cfg, FW_CFG_SMBIOS_ENTRIES,
> +        fw_cfg_add_bytes(x86ms->fw_cfg, FW_CFG_SMBIOS_ENTRIES,
>                           smbios_tables, smbios_tables_len);
>      }
> =20
> @@ -927,9 +901,9 @@ static void pc_build_smbios(PCMachineState *pcms)
>      g_free(mem_array);
> =20
>      if (smbios_anchor) {
> -        fw_cfg_add_file(pcms->fw_cfg, "etc/smbios/smbios-tables",
> +        fw_cfg_add_file(x86ms->fw_cfg, "etc/smbios/smbios-tables",
>                          smbios_tables, smbios_tables_len);
> -        fw_cfg_add_file(pcms->fw_cfg, "etc/smbios/smbios-anchor",
> +        fw_cfg_add_file(x86ms->fw_cfg, "etc/smbios/smbios-anchor",
>                          smbios_anchor, smbios_anchor_len);
>      }
>  }
> @@ -942,10 +916,11 @@ static FWCfgState *bochs_bios_init(AddressSpace *=
as, PCMachineState *pcms)
>      const CPUArchIdList *cpus;
>      MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
>      MachineState *ms =3D MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      int nb_numa_nodes =3D ms->numa_state->num_nodes;
> =20
>      fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, =
as);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
> =20
>      /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
>       *
> @@ -959,7 +934,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as=
, PCMachineState *pcms)
>       * So for compatibility reasons with old BIOSes we are stuck with
>       * "etc/max-cpus" actually being apic_id_limit
>       */
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)pcms->apic_id_li=
mit);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)x86ms->apic_id_l=
imit);
>      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
>                       acpi_tables, acpi_tables_len);
> @@ -972,374 +947,25 @@ static FWCfgState *bochs_bios_init(AddressSpace =
*as, PCMachineState *pcms)
>       * of nodes, one word for each VCPU->node and one word for each no=
de to
>       * hold the amount of memory.
>       */
> -    numa_fw_cfg =3D g_new0(uint64_t, 1 + pcms->apic_id_limit + nb_numa=
_nodes);
> +    numa_fw_cfg =3D g_new0(uint64_t, 1 + x86ms->apic_id_limit + nb_num=
a_nodes);
>      numa_fw_cfg[0] =3D cpu_to_le64(nb_numa_nodes);
>      cpus =3D mc->possible_cpu_arch_ids(MACHINE(pcms));
>      for (i =3D 0; i < cpus->len; i++) {
>          unsigned int apic_id =3D cpus->cpus[i].arch_id;
> -        assert(apic_id < pcms->apic_id_limit);
> +        assert(apic_id < x86ms->apic_id_limit);
>          numa_fw_cfg[apic_id + 1] =3D cpu_to_le64(cpus->cpus[i].props.n=
ode_id);
>      }
>      for (i =3D 0; i < nb_numa_nodes; i++) {
> -        numa_fw_cfg[pcms->apic_id_limit + 1 + i] =3D
> +        numa_fw_cfg[x86ms->apic_id_limit + 1 + i] =3D
>              cpu_to_le64(ms->numa_state->nodes[i].node_mem);
>      }
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
> -                     (1 + pcms->apic_id_limit + nb_numa_nodes) *
> +                     (1 + x86ms->apic_id_limit + nb_numa_nodes) *
>                       sizeof(*numa_fw_cfg));
> =20
>      return fw_cfg;
>  }
> =20
> -static long get_file_size(FILE *f)
> -{
> -    long where, size;
> -
> -    /* XXX: on Unix systems, using fstat() probably makes more sense *=
/
> -
> -    where =3D ftell(f);
> -    fseek(f, 0, SEEK_END);
> -    size =3D ftell(f);
> -    fseek(f, where, SEEK_SET);
> -
> -    return size;
> -}
> -
> -struct setup_data {
> -    uint64_t next;
> -    uint32_t type;
> -    uint32_t len;
> -    uint8_t data[0];
> -} __attribute__((packed));
> -
> -static void load_linux(PCMachineState *pcms,
> -                       FWCfgState *fw_cfg)
> -{
> -    uint16_t protocol;
> -    int setup_size, kernel_size, cmdline_size;
> -    int dtb_size, setup_data_offset;
> -    uint32_t initrd_max;
> -    uint8_t header[8192], *setup, *kernel;
> -    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr =3D 0;
> -    FILE *f;
> -    char *vmode;
> -    MachineState *machine =3D MACHINE(pcms);
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> -    struct setup_data *setup_data;
> -    const char *kernel_filename =3D machine->kernel_filename;
> -    const char *initrd_filename =3D machine->initrd_filename;
> -    const char *dtb_filename =3D machine->dtb;
> -    const char *kernel_cmdline =3D machine->kernel_cmdline;
> -
> -    /* Align to 16 bytes as a paranoia measure */
> -    cmdline_size =3D (strlen(kernel_cmdline)+16) & ~15;
> -
> -    /* load the kernel header */
> -    f =3D fopen(kernel_filename, "rb");
> -    if (!f || !(kernel_size =3D get_file_size(f)) ||
> -        fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=3D
> -        MIN(ARRAY_SIZE(header), kernel_size)) {
> -        fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
> -                kernel_filename, strerror(errno));
> -        exit(1);
> -    }
> -
> -    /* kernel protocol version */
> -#if 0
> -    fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));
> -#endif
> -    if (ldl_p(header+0x202) =3D=3D 0x53726448) {
> -        protocol =3D lduw_p(header+0x206);
> -    } else {
> -        size_t pvh_start_addr;
> -        uint32_t mh_load_addr =3D 0;
> -        uint32_t elf_kernel_size =3D 0;
> -        /*
> -         * This could be a multiboot kernel. If it is, let's stop trea=
ting it
> -         * like a Linux kernel.
> -         * Note: some multiboot images could be in the ELF format (the=
 same of
> -         * PVH), so we try multiboot first since we check the multiboo=
t magic
> -         * header before to load it.
> -         */
> -        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename=
,
> -                           kernel_cmdline, kernel_size, header)) {
> -            return;
> -        }
> -        /*
> -         * Check if the file is an uncompressed kernel file (ELF) and =
load it,
> -         * saving the PVH entry point used by the x86/HVM direct boot =
ABI.
> -         * If load_elfboot() is successful, populate the fw_cfg info.
> -         */
> -        if (pcmc->pvh_enabled &&
> -            pvh_load_elfboot(kernel_filename,
> -                             &mh_load_addr, &elf_kernel_size)) {
> -            fclose(f);
> -
> -            pvh_start_addr =3D pvh_get_start_addr();
> -
> -            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr=
);
> -            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
> -            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size=
);
> -
> -            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
> -                strlen(kernel_cmdline) + 1);
> -            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdl=
ine);
> -
> -            fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
> -            fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
> -                             header, sizeof(header));
> -
> -            /* load initrd */
> -            if (initrd_filename) {
> -                GMappedFile *mapped_file;
> -                gsize initrd_size;
> -                gchar *initrd_data;
> -                GError *gerr =3D NULL;
> -
> -                mapped_file =3D g_mapped_file_new(initrd_filename, fal=
se, &gerr);
> -                if (!mapped_file) {
> -                    fprintf(stderr, "qemu: error reading initrd %s: %s=
\n",
> -                            initrd_filename, gerr->message);
> -                    exit(1);
> -                }
> -                pcms->initrd_mapped_file =3D mapped_file;
> -
> -                initrd_data =3D g_mapped_file_get_contents(mapped_file=
);
> -                initrd_size =3D g_mapped_file_get_length(mapped_file);
> -                initrd_max =3D pcms->below_4g_mem_size - pcmc->acpi_da=
ta_size - 1;
> -                if (initrd_size >=3D initrd_max) {
> -                    fprintf(stderr, "qemu: initrd is too large, cannot=
 support."
> -                            "(max: %"PRIu32", need %"PRId64")\n",
> -                            initrd_max, (uint64_t)initrd_size);
> -                    exit(1);
> -                }
> -
> -                initrd_addr =3D (initrd_max - initrd_size) & ~4095;
> -
> -                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr=
);
> -                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size=
);
> -                fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_da=
ta,
> -                                 initrd_size);
> -            }
> -
> -            option_rom[nb_option_roms].bootindex =3D 0;
> -            option_rom[nb_option_roms].name =3D "pvh.bin";
> -            nb_option_roms++;
> -
> -            return;
> -        }
> -        protocol =3D 0;
> -    }
> -
> -    if (protocol < 0x200 || !(header[0x211] & 0x01)) {
> -        /* Low kernel */
> -        real_addr    =3D 0x90000;
> -        cmdline_addr =3D 0x9a000 - cmdline_size;
> -        prot_addr    =3D 0x10000;
> -    } else if (protocol < 0x202) {
> -        /* High but ancient kernel */
> -        real_addr    =3D 0x90000;
> -        cmdline_addr =3D 0x9a000 - cmdline_size;
> -        prot_addr    =3D 0x100000;
> -    } else {
> -        /* High and recent kernel */
> -        real_addr    =3D 0x10000;
> -        cmdline_addr =3D 0x20000;
> -        prot_addr    =3D 0x100000;
> -    }
> -
> -#if 0
> -    fprintf(stderr,
> -            "qemu: real_addr     =3D 0x" TARGET_FMT_plx "\n"
> -            "qemu: cmdline_addr  =3D 0x" TARGET_FMT_plx "\n"
> -            "qemu: prot_addr     =3D 0x" TARGET_FMT_plx "\n",
> -            real_addr,
> -            cmdline_addr,
> -            prot_addr);
> -#endif
> -
> -    /* highest address for loading the initrd */
> -    if (protocol >=3D 0x20c &&
> -        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> -        /*
> -         * Linux has supported initrd up to 4 GB for a very long time =
(2007,
> -         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2=
013),
> -         * though it only sets initrd_max to 2 GB to "work around boot=
loader
> -         * bugs". Luckily, QEMU firmware(which does something like boo=
tloader)
> -         * has supported this.
> -         *
> -         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, in=
itrd can
> -         * be loaded into any address.
> -         *
> -         * In addition, initrd_max is uint32_t simply because QEMU doe=
sn't
> -         * support the 64-bit boot protocol (specifically the ext_ramd=
isk_image
> -         * field).
> -         *
> -         * Therefore here just limit initrd_max to UINT32_MAX simply a=
s well.
> -         */
> -        initrd_max =3D UINT32_MAX;
> -    } else if (protocol >=3D 0x203) {
> -        initrd_max =3D ldl_p(header+0x22c);
> -    } else {
> -        initrd_max =3D 0x37ffffff;
> -    }
> -
> -    if (initrd_max >=3D pcms->below_4g_mem_size - pcmc->acpi_data_size=
) {
> -        initrd_max =3D pcms->below_4g_mem_size - pcmc->acpi_data_size =
- 1;
> -    }
> -
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline)=
+1);
> -    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
> -
> -    if (protocol >=3D 0x202) {
> -        stl_p(header+0x228, cmdline_addr);
> -    } else {
> -        stw_p(header+0x20, 0xA33F);
> -        stw_p(header+0x22, cmdline_addr-real_addr);
> -    }
> -
> -    /* handle vga=3D parameter */
> -    vmode =3D strstr(kernel_cmdline, "vga=3D");
> -    if (vmode) {
> -        unsigned int video_mode;
> -        /* skip "vga=3D" */
> -        vmode +=3D 4;
> -        if (!strncmp(vmode, "normal", 6)) {
> -            video_mode =3D 0xffff;
> -        } else if (!strncmp(vmode, "ext", 3)) {
> -            video_mode =3D 0xfffe;
> -        } else if (!strncmp(vmode, "ask", 3)) {
> -            video_mode =3D 0xfffd;
> -        } else {
> -            video_mode =3D strtol(vmode, NULL, 0);
> -        }
> -        stw_p(header+0x1fa, video_mode);
> -    }
> -
> -    /* loader type */
> -    /* High nybble =3D B reserved for QEMU; low nybble is revision num=
ber.
> -       If this code is substantially changed, you may want to consider
> -       incrementing the revision. */
> -    if (protocol >=3D 0x200) {
> -        header[0x210] =3D 0xB0;
> -    }
> -    /* heap */
> -    if (protocol >=3D 0x201) {
> -        header[0x211] |=3D 0x80;	/* CAN_USE_HEAP */
> -        stw_p(header+0x224, cmdline_addr-real_addr-0x200);
> -    }
> -
> -    /* load initrd */
> -    if (initrd_filename) {
> -        GMappedFile *mapped_file;
> -        gsize initrd_size;
> -        gchar *initrd_data;
> -        GError *gerr =3D NULL;
> -
> -        if (protocol < 0x200) {
> -            fprintf(stderr, "qemu: linux kernel too old to load a ram =
disk\n");
> -            exit(1);
> -        }
> -
> -        mapped_file =3D g_mapped_file_new(initrd_filename, false, &ger=
r);
> -        if (!mapped_file) {
> -            fprintf(stderr, "qemu: error reading initrd %s: %s\n",
> -                    initrd_filename, gerr->message);
> -            exit(1);
> -        }
> -        pcms->initrd_mapped_file =3D mapped_file;
> -
> -        initrd_data =3D g_mapped_file_get_contents(mapped_file);
> -        initrd_size =3D g_mapped_file_get_length(mapped_file);
> -        if (initrd_size >=3D initrd_max) {
> -            fprintf(stderr, "qemu: initrd is too large, cannot support=
."
> -                    "(max: %"PRIu32", need %"PRId64")\n",
> -                    initrd_max, (uint64_t)initrd_size);
> -            exit(1);
> -        }
> -
> -        initrd_addr =3D (initrd_max-initrd_size) & ~4095;
> -
> -        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
> -        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
> -        fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, init=
rd_size);
> -
> -        stl_p(header+0x218, initrd_addr);
> -        stl_p(header+0x21c, initrd_size);
> -    }
> -
> -    /* load kernel and setup */
> -    setup_size =3D header[0x1f1];
> -    if (setup_size =3D=3D 0) {
> -        setup_size =3D 4;
> -    }
> -    setup_size =3D (setup_size+1)*512;
> -    if (setup_size > kernel_size) {
> -        fprintf(stderr, "qemu: invalid kernel header\n");
> -        exit(1);
> -    }
> -    kernel_size -=3D setup_size;
> -
> -    setup  =3D g_malloc(setup_size);
> -    kernel =3D g_malloc(kernel_size);
> -    fseek(f, 0, SEEK_SET);
> -    if (fread(setup, 1, setup_size, f) !=3D setup_size) {
> -        fprintf(stderr, "fread() failed\n");
> -        exit(1);
> -    }
> -    if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
> -        fprintf(stderr, "fread() failed\n");
> -        exit(1);
> -    }
> -    fclose(f);
> -
> -    /* append dtb to kernel */
> -    if (dtb_filename) {
> -        if (protocol < 0x209) {
> -            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\=
n");
> -            exit(1);
> -        }
> -
> -        dtb_size =3D get_image_size(dtb_filename);
> -        if (dtb_size <=3D 0) {
> -            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
> -                    dtb_filename, strerror(errno));
> -            exit(1);
> -        }
> -
> -        setup_data_offset =3D QEMU_ALIGN_UP(kernel_size, 16);
> -        kernel_size =3D setup_data_offset + sizeof(struct setup_data) =
+ dtb_size;
> -        kernel =3D g_realloc(kernel, kernel_size);
> -
> -        stq_p(header+0x250, prot_addr + setup_data_offset);
> -
> -        setup_data =3D (struct setup_data *)(kernel + setup_data_offse=
t);
> -        setup_data->next =3D 0;
> -        setup_data->type =3D cpu_to_le32(SETUP_DTB);
> -        setup_data->len =3D cpu_to_le32(dtb_size);
> -
> -        load_image_size(dtb_filename, setup_data->data, dtb_size);
> -    }
> -
> -    memcpy(setup, header, MIN(sizeof(header), setup_size));
> -
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
> -    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
> -
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
> -    fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
> -
> -    option_rom[nb_option_roms].bootindex =3D 0;
> -    option_rom[nb_option_roms].name =3D "linuxboot.bin";
> -    if (pcmc->linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
> -        option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
> -    }
> -    nb_option_roms++;
> -}
> -
>  #define NE2000_NB_MAX 6
> =20
>  static const int ne2000_io[NE2000_NB_MAX] =3D { 0x300, 0x320, 0x340, 0=
x360,
> @@ -1376,157 +1002,10 @@ void pc_acpi_smi_interrupt(void *opaque, int i=
rq, int level)
>      }
>  }
> =20
> -static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **=
errp)
> -{
> -    Object *cpu =3D NULL;
> -    Error *local_err =3D NULL;
> -    CPUX86State *env =3D NULL;
> -
> -    cpu =3D object_new(MACHINE(pcms)->cpu_type);
> -
> -    env =3D &X86_CPU(cpu)->env;
> -    env->nr_dies =3D pcms->smp_dies;
> -
> -    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
> -    object_property_set_bool(cpu, true, "realized", &local_err);
> -
> -    object_unref(cpu);
> -    error_propagate(errp, local_err);
> -}
> -
> -/*
> - * This function is very similar to smp_parse()
> - * in hw/core/machine.c but includes CPU die support.
> - */
> -void pc_smp_parse(MachineState *ms, QemuOpts *opts)
> -{
> -    PCMachineState *pcms =3D PC_MACHINE(ms);
> -
> -    if (opts) {
> -        unsigned cpus    =3D qemu_opt_get_number(opts, "cpus", 0);
> -        unsigned sockets =3D qemu_opt_get_number(opts, "sockets", 0);
> -        unsigned dies =3D qemu_opt_get_number(opts, "dies", 1);
> -        unsigned cores   =3D qemu_opt_get_number(opts, "cores", 0);
> -        unsigned threads =3D qemu_opt_get_number(opts, "threads", 0);
> -
> -        /* compute missing values, prefer sockets over cores over thre=
ads */
> -        if (cpus =3D=3D 0 || sockets =3D=3D 0) {
> -            cores =3D cores > 0 ? cores : 1;
> -            threads =3D threads > 0 ? threads : 1;
> -            if (cpus =3D=3D 0) {
> -                sockets =3D sockets > 0 ? sockets : 1;
> -                cpus =3D cores * threads * dies * sockets;
> -            } else {
> -                ms->smp.max_cpus =3D
> -                        qemu_opt_get_number(opts, "maxcpus", cpus);
> -                sockets =3D ms->smp.max_cpus / (cores * threads * dies=
);
> -            }
> -        } else if (cores =3D=3D 0) {
> -            threads =3D threads > 0 ? threads : 1;
> -            cores =3D cpus / (sockets * dies * threads);
> -            cores =3D cores > 0 ? cores : 1;
> -        } else if (threads =3D=3D 0) {
> -            threads =3D cpus / (cores * dies * sockets);
> -            threads =3D threads > 0 ? threads : 1;
> -        } else if (sockets * dies * cores * threads < cpus) {
> -            error_report("cpu topology: "
> -                         "sockets (%u) * dies (%u) * cores (%u) * thre=
ads (%u) < "
> -                         "smp_cpus (%u)",
> -                         sockets, dies, cores, threads, cpus);
> -            exit(1);
> -        }
> -
> -        ms->smp.max_cpus =3D
> -                qemu_opt_get_number(opts, "maxcpus", cpus);
> -
> -        if (ms->smp.max_cpus < cpus) {
> -            error_report("maxcpus must be equal to or greater than smp=
");
> -            exit(1);
> -        }
> -
> -        if (sockets * dies * cores * threads > ms->smp.max_cpus) {
> -            error_report("cpu topology: "
> -                         "sockets (%u) * dies (%u) * cores (%u) * thre=
ads (%u) > "
> -                         "maxcpus (%u)",
> -                         sockets, dies, cores, threads,
> -                         ms->smp.max_cpus);
> -            exit(1);
> -        }
> -
> -        if (sockets * dies * cores * threads !=3D ms->smp.max_cpus) {
> -            warn_report("Invalid CPU topology deprecated: "
> -                        "sockets (%u) * dies (%u) * cores (%u) * threa=
ds (%u) "
> -                        "!=3D maxcpus (%u)",
> -                        sockets, dies, cores, threads,
> -                        ms->smp.max_cpus);
> -        }
> -
> -        ms->smp.cpus =3D cpus;
> -        ms->smp.cores =3D cores;
> -        ms->smp.threads =3D threads;
> -        pcms->smp_dies =3D dies;
> -    }
> -
> -    if (ms->smp.cpus > 1) {
> -        Error *blocker =3D NULL;
> -        error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
> -        replay_add_blocker(blocker);
> -    }
> -}
> -
> -void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
> -{
> -    PCMachineState *pcms =3D PC_MACHINE(ms);
> -    int64_t apic_id =3D x86_cpu_apic_id_from_index(pcms, id);
> -    Error *local_err =3D NULL;
> -
> -    if (id < 0) {
> -        error_setg(errp, "Invalid CPU id: %" PRIi64, id);
> -        return;
> -    }
> -
> -    if (apic_id >=3D ACPI_CPU_HOTPLUG_ID_LIMIT) {
> -        error_setg(errp, "Unable to add CPU: %" PRIi64
> -                   ", resulting APIC ID (%" PRIi64 ") is too large",
> -                   id, apic_id);
> -        return;
> -    }
> -
> -    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -}
> -
> -void pc_cpus_init(PCMachineState *pcms)
> -{
> -    int i;
> -    const CPUArchIdList *possible_cpus;
> -    MachineState *ms =3D MACHINE(pcms);
> -    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(mc);
> -
> -    x86_cpu_set_default_version(pcmc->default_cpu_version);
> -
> -    /* Calculates the limit to CPU APIC ID values
> -     *
> -     * Limit for the APIC ID value, so that all
> -     * CPU APIC IDs are < pcms->apic_id_limit.
> -     *
> -     * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_in=
it().
> -     */
> -    pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(pcms,
> -                                                     ms->smp.max_cpus =
- 1) + 1;
> -    possible_cpus =3D mc->possible_cpu_arch_ids(ms);
> -    for (i =3D 0; i < ms->smp.cpus; i++) {
> -        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal)=
;
> -    }
> -}
> -
>  static void pc_build_feature_control_file(PCMachineState *pcms)
>  {
>      MachineState *ms =3D MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      X86CPU *cpu =3D X86_CPU(ms->possible_cpus->cpus[0].cpu);
>      CPUX86State *env =3D &cpu->env;
>      uint32_t unused, ecx, edx;
> @@ -1550,7 +1029,7 @@ static void pc_build_feature_control_file(PCMachi=
neState *pcms)
> =20
>      val =3D g_malloc(sizeof(*val));
>      *val =3D cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED=
);
> -    fw_cfg_add_file(pcms->fw_cfg, "etc/msr_feature_control", val, size=
of(*val));
> +    fw_cfg_add_file(x86ms->fw_cfg, "etc/msr_feature_control", val, siz=
eof(*val));
>  }
> =20
>  static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
> @@ -1571,10 +1050,11 @@ void pc_machine_done(Notifier *notifier, void *=
data)
>  {
>      PCMachineState *pcms =3D container_of(notifier,
>                                          PCMachineState, machine_done);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      PCIBus *bus =3D pcms->bus;
> =20
>      /* set the number of CPUs */
> -    rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
> +    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> =20
>      if (bus) {
>          int extra_hosts =3D 0;
> @@ -1585,23 +1065,23 @@ void pc_machine_done(Notifier *notifier, void *=
data)
>                  extra_hosts++;
>              }
>          }
> -        if (extra_hosts && pcms->fw_cfg) {
> +        if (extra_hosts && x86ms->fw_cfg) {
>              uint64_t *val =3D g_malloc(sizeof(*val));
>              *val =3D cpu_to_le64(extra_hosts);
> -            fw_cfg_add_file(pcms->fw_cfg,
> +            fw_cfg_add_file(x86ms->fw_cfg,
>                      "etc/extra-pci-roots", val, sizeof(*val));
>          }
>      }
> =20
>      acpi_setup();
> -    if (pcms->fw_cfg) {
> +    if (x86ms->fw_cfg) {
>          pc_build_smbios(pcms);
>          pc_build_feature_control_file(pcms);
>          /* update FW_CFG_NB_CPUS to account for -device added CPUs */
> -        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpu=
s);
> +        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_c=
pus);
>      }
> =20
> -    if (pcms->apic_id_limit > 255 && !xen_enabled()) {
> +    if (x86ms->apic_id_limit > 255 && !xen_enabled()) {
>          IntelIOMMUState *iommu =3D INTEL_IOMMU_DEVICE(x86_iommu_get_de=
fault());
> =20
>          if (!iommu || !x86_iommu_ir_supported(X86_IOMMU_DEVICE(iommu))=
 ||
> @@ -1619,8 +1099,9 @@ void pc_guest_info_init(PCMachineState *pcms)
>  {
>      int i;
>      MachineState *ms =3D MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> =20
> -    pcms->apic_xrupt_override =3D kvm_allows_irq0_override();
> +    x86ms->apic_xrupt_override =3D kvm_allows_irq0_override();
>      pcms->numa_nodes =3D ms->numa_state->num_nodes;
>      pcms->node_mem =3D g_malloc0(pcms->numa_nodes *
>                                      sizeof *pcms->node_mem);
> @@ -1645,14 +1126,17 @@ void xen_load_linux(PCMachineState *pcms)
>  {
>      int i;
>      FWCfgState *fw_cfg;
> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> =20
>      assert(MACHINE(pcms)->kernel_filename !=3D NULL);
> =20
>      fw_cfg =3D fw_cfg_init_io(FW_CFG_IO_BASE);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
>      rom_set_fw(fw_cfg);
> =20
> -    load_linux(pcms, fw_cfg);
> +    load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> +               pcmc->linuxboot_dma_enabled, pcmc->pvh_enabled);
>      for (i =3D 0; i < nb_option_roms; i++) {
>          assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>                 !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> @@ -1660,7 +1144,7 @@ void xen_load_linux(PCMachineState *pcms)
>                 !strcmp(option_rom[i].name, "multiboot.bin"));
>          rom_add_option(option_rom[i].name, option_rom[i].bootindex);
>      }
> -    pcms->fw_cfg =3D fw_cfg;
> +    x86ms->fw_cfg =3D fw_cfg;
>  }
> =20
>  void pc_memory_init(PCMachineState *pcms,
> @@ -1673,10 +1157,11 @@ void pc_memory_init(PCMachineState *pcms,
>      MemoryRegion *ram_below_4g, *ram_above_4g;
>      FWCfgState *fw_cfg;
>      MachineState *machine =3D MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> =20
> -    assert(machine->ram_size =3D=3D pcms->below_4g_mem_size +
> -                                pcms->above_4g_mem_size);
> +    assert(machine->ram_size =3D=3D x86ms->below_4g_mem_size +
> +                                x86ms->above_4g_mem_size);
> =20
>      linux_boot =3D (machine->kernel_filename !=3D NULL);
> =20
> @@ -1690,17 +1175,17 @@ void pc_memory_init(PCMachineState *pcms,
>      *ram_memory =3D ram;
>      ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
>      memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
> -                             0, pcms->below_4g_mem_size);
> +                             0, x86ms->below_4g_mem_size);
>      memory_region_add_subregion(system_memory, 0, ram_below_4g);
> -    e820_add_entry(0, pcms->below_4g_mem_size, E820_RAM);
> -    if (pcms->above_4g_mem_size > 0) {
> +    e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
> +    if (x86ms->above_4g_mem_size > 0) {
>          ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
>          memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", r=
am,
> -                                 pcms->below_4g_mem_size,
> -                                 pcms->above_4g_mem_size);
> +                                 x86ms->below_4g_mem_size,
> +                                 x86ms->above_4g_mem_size);
>          memory_region_add_subregion(system_memory, 0x100000000ULL,
>                                      ram_above_4g);
> -        e820_add_entry(0x100000000ULL, pcms->above_4g_mem_size, E820_R=
AM);
> +        e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_=
RAM);
>      }
> =20
>      if (!pcmc->has_reserved_memory &&
> @@ -1735,7 +1220,7 @@ void pc_memory_init(PCMachineState *pcms,
>          }
> =20
>          machine->device_memory->base =3D
> -            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1 * GiB=
);
> +            ROUND_UP(0x100000000ULL + x86ms->above_4g_mem_size, 1 * Gi=
B);
> =20
>          if (pcmc->enforce_aligned_dimm) {
>              /* size device region assuming 1G page max alignment per s=
lot */
> @@ -1786,16 +1271,17 @@ void pc_memory_init(PCMachineState *pcms,
>      }
> =20
>      if (linux_boot) {
> -        load_linux(pcms, fw_cfg);
> +        load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> +                   pcmc->linuxboot_dma_enabled, pcmc->pvh_enabled);
>      }
> =20
>      for (i =3D 0; i < nb_option_roms; i++) {
>          rom_add_option(option_rom[i].name, option_rom[i].bootindex);
>      }
> -    pcms->fw_cfg =3D fw_cfg;
> +    x86ms->fw_cfg =3D fw_cfg;
> =20
>      /* Init default IOAPIC address space */
> -    pcms->ioapic_as =3D &address_space_memory;
> +    x86ms->ioapic_as =3D &address_space_memory;
>  }
> =20
>  /*
> @@ -1807,6 +1293,7 @@ uint64_t pc_pci_hole64_start(void)
>      PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      MachineState *ms =3D MACHINE(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      uint64_t hole64_start =3D 0;
> =20
>      if (pcmc->has_reserved_memory && ms->device_memory->base) {
> @@ -1815,7 +1302,7 @@ uint64_t pc_pci_hole64_start(void)
>              hole64_start +=3D memory_region_size(&ms->device_memory->m=
r);
>          }
>      } else {
> -        hole64_start =3D 0x100000000ULL + pcms->above_4g_mem_size;
> +        hole64_start =3D 0x100000000ULL + x86ms->above_4g_mem_size;
>      }
> =20
>      return ROUND_UP(hole64_start, 1 * GiB);
> @@ -2154,6 +1641,7 @@ static void pc_cpu_plug(HotplugHandler *hotplug_d=
ev,
>      Error *local_err =3D NULL;
>      X86CPU *cpu =3D X86_CPU(dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> =20
>      if (pcms->acpi_dev) {
>          hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &lo=
cal_err);
> @@ -2163,12 +1651,12 @@ static void pc_cpu_plug(HotplugHandler *hotplug=
_dev,
>      }
> =20
>      /* increment the number of CPUs */
> -    pcms->boot_cpus++;
> -    if (pcms->rtc) {
> -        rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
> +    x86ms->boot_cpus++;
> +    if (x86ms->rtc) {
> +        rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
>      }
> -    if (pcms->fw_cfg) {
> -        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpu=
s);
> +    if (x86ms->fw_cfg) {
> +        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_c=
pus);
>      }
> =20
>      found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
> @@ -2214,6 +1702,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotp=
lug_dev,
>      Error *local_err =3D NULL;
>      X86CPU *cpu =3D X86_CPU(dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> =20
>      hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &loca=
l_err);
>      if (local_err) {
> @@ -2225,10 +1714,10 @@ static void pc_cpu_unplug_cb(HotplugHandler *ho=
tplug_dev,
>      object_property_set_bool(OBJECT(dev), false, "realized", NULL);
> =20
>      /* decrement the number of CPUs */
> -    pcms->boot_cpus--;
> +    x86ms->boot_cpus--;
>      /* Update the number of CPUs in CMOS */
> -    rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
> -    fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
> +    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> +    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus)=
;
>   out:
>      error_propagate(errp, local_err);
>  }
> @@ -2244,6 +1733,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotpl=
ug_dev,
>      CPUX86State *env =3D &cpu->env;
>      MachineState *ms =3D MACHINE(hotplug_dev);
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    X86MachineState *x86ms =3D X86_MACHINE(hotplug_dev);
>      unsigned int smp_cores =3D ms->smp.cores;
>      unsigned int smp_threads =3D ms->smp.threads;
> =20
> @@ -2253,7 +1743,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotpl=
ug_dev,
>          return;
>      }
> =20
> -    env->nr_dies =3D pcms->smp_dies;
> +    env->nr_dies =3D x86ms->smp_dies;
> =20
>      /*
>       * If APIC ID is not set,
> @@ -2261,13 +1751,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hot=
plug_dev,
>       */
>      if (cpu->apic_id =3D=3D UNASSIGNED_APIC_ID) {
>          int max_socket =3D (ms->smp.max_cpus - 1) /
> -                                smp_threads / smp_cores / pcms->smp_di=
es;
> +                                smp_threads / smp_cores / x86ms->smp_d=
ies;
> =20
>          /*
>           * die-id was optional in QEMU 4.0 and older, so keep it optio=
nal
>           * if there's only one die per socket.
>           */
> -        if (cpu->die_id < 0 && pcms->smp_dies =3D=3D 1) {
> +        if (cpu->die_id < 0 && x86ms->smp_dies =3D=3D 1) {
>              cpu->die_id =3D 0;
>          }
> =20
> @@ -2282,9 +1772,9 @@ static void pc_cpu_pre_plug(HotplugHandler *hotpl=
ug_dev,
>          if (cpu->die_id < 0) {
>              error_setg(errp, "CPU die-id is not set");
>              return;
> -        } else if (cpu->die_id > pcms->smp_dies - 1) {
> +        } else if (cpu->die_id > x86ms->smp_dies - 1) {
>              error_setg(errp, "Invalid CPU die-id: %u must be in range =
0:%u",
> -                       cpu->die_id, pcms->smp_dies - 1);
> +                       cpu->die_id, x86ms->smp_dies - 1);
>              return;
>          }
>          if (cpu->core_id < 0) {
> @@ -2308,7 +1798,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotpl=
ug_dev,
>          topo.die_id =3D cpu->die_id;
>          topo.core_id =3D cpu->core_id;
>          topo.smt_id =3D cpu->thread_id;
> -        cpu->apic_id =3D apicid_from_topo_ids(pcms->smp_dies, smp_core=
s,
> +        cpu->apic_id =3D apicid_from_topo_ids(x86ms->smp_dies, smp_cor=
es,
>                                              smp_threads, &topo);
>      }
> =20
> @@ -2316,7 +1806,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotpl=
ug_dev,
>      if (!cpu_slot) {
>          MachineState *ms =3D MACHINE(pcms);
> =20
> -        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> +        x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
>                                   smp_cores, smp_threads, &topo);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] w=
ith"
> @@ -2338,7 +1828,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotpl=
ug_dev,
>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_real=
izefn()
>       * once -smp refactoring is complete and there will be CPU private
>       * CPUState::nr_cores and CPUState::nr_threads fields instead of g=
lobals */
> -    x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
> +    x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
>                               smp_cores, smp_threads, &topo);
>      if (cpu->socket_id !=3D -1 && cpu->socket_id !=3D topo.pkg_id) {
>          error_setg(errp, "property socket-id: %u doesn't match set api=
c-id:"
> @@ -2520,45 +2010,6 @@ pc_machine_get_device_memory_region_size(Object =
*obj, Visitor *v,
>      visit_type_int(v, name, &value, errp);
>  }
> =20
> -static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
> -                                            const char *name, void *op=
aque,
> -                                            Error **errp)
> -{
> -    PCMachineState *pcms =3D PC_MACHINE(obj);
> -    uint64_t value =3D pcms->max_ram_below_4g;
> -
> -    visit_type_size(v, name, &value, errp);
> -}
> -
> -static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
> -                                            const char *name, void *op=
aque,
> -                                            Error **errp)
> -{
> -    PCMachineState *pcms =3D PC_MACHINE(obj);
> -    Error *error =3D NULL;
> -    uint64_t value;
> -
> -    visit_type_size(v, name, &value, &error);
> -    if (error) {
> -        error_propagate(errp, error);
> -        return;
> -    }
> -    if (value > 4 * GiB) {
> -        error_setg(&error,
> -                   "Machine option 'max-ram-below-4g=3D%"PRIu64
> -                   "' expects size less than or equal to 4G", value);
> -        error_propagate(errp, error);
> -        return;
> -    }
> -
> -    if (value < 1 * MiB) {
> -        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boun=
dary,"
> -                    "BIOS may not work with less than 1MiB", value);
> -    }
> -
> -    pcms->max_ram_below_4g =3D value;
> -}
> -
>  static void pc_machine_get_vmport(Object *obj, Visitor *v, const char =
*name,
>                                    void *opaque, Error **errp)
>  {
> @@ -2664,7 +2115,6 @@ static void pc_machine_initfn(Object *obj)
>  {
>      PCMachineState *pcms =3D PC_MACHINE(obj);
> =20
> -    pcms->max_ram_below_4g =3D 0; /* use default */
>      pcms->smm =3D ON_OFF_AUTO_AUTO;
>  #ifdef CONFIG_VMPORT
>      pcms->vmport =3D ON_OFF_AUTO_AUTO;
> @@ -2676,7 +2126,6 @@ static void pc_machine_initfn(Object *obj)
>      pcms->smbus_enabled =3D true;
>      pcms->sata_enabled =3D true;
>      pcms->pit_enabled =3D true;
> -    pcms->smp_dies =3D 1;
> =20
>      pc_system_flash_create(pcms);
>  }
> @@ -2707,85 +2156,6 @@ static void pc_machine_wakeup(MachineState *mach=
ine)
>      cpu_synchronize_all_post_reset();
>  }
> =20
> -static CpuInstanceProperties
> -pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> -{
> -    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> -    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(m=
s);
> -
> -    assert(cpu_index < possible_cpus->len);
> -    return possible_cpus->cpus[cpu_index].props;
> -}
> -
> -static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int =
idx)
> -{
> -   X86CPUTopoInfo topo;
> -   PCMachineState *pcms =3D PC_MACHINE(ms);
> -
> -   assert(idx < ms->possible_cpus->len);
> -   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> -                            pcms->smp_dies, ms->smp.cores,
> -                            ms->smp.threads, &topo);
> -   return topo.pkg_id % ms->numa_state->num_nodes;
> -}
> -
> -static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
> -{
> -    PCMachineState *pcms =3D PC_MACHINE(ms);
> -    int i;
> -    unsigned int max_cpus =3D ms->smp.max_cpus;
> -
> -    if (ms->possible_cpus) {
> -        /*
> -         * make sure that max_cpus hasn't changed since the first use,=
 i.e.
> -         * -smp hasn't been parsed after it
> -        */
> -        assert(ms->possible_cpus->len =3D=3D max_cpus);
> -        return ms->possible_cpus;
> -    }
> -
> -    ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> -                                  sizeof(CPUArchId) * max_cpus);
> -    ms->possible_cpus->len =3D max_cpus;
> -    for (i =3D 0; i < ms->possible_cpus->len; i++) {
> -        X86CPUTopoInfo topo;
> -
> -        ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
> -        ms->possible_cpus->cpus[i].vcpus_count =3D 1;
> -        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_in=
dex(pcms, i);
> -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> -                                 pcms->smp_dies, ms->smp.cores,
> -                                 ms->smp.threads, &topo);
> -        ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
> -        ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
> -        if (pcms->smp_dies > 1) {
> -            ms->possible_cpus->cpus[i].props.has_die_id =3D true;
> -            ms->possible_cpus->cpus[i].props.die_id =3D topo.die_id;
> -        }
> -        ms->possible_cpus->cpus[i].props.has_core_id =3D true;
> -        ms->possible_cpus->cpus[i].props.core_id =3D topo.core_id;
> -        ms->possible_cpus->cpus[i].props.has_thread_id =3D true;
> -        ms->possible_cpus->cpus[i].props.thread_id =3D topo.smt_id;
> -    }
> -    return ms->possible_cpus;
> -}
> -
> -static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
> -{
> -    /* cpu index isn't used */
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        X86CPU *cpu =3D X86_CPU(cs);
> -
> -        if (!cpu->apic_state) {
> -            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
> -        } else {
> -            apic_deliver_nmi(cpu->apic_state);
> -        }
> -    }
> -}
> -
>  static void pc_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -2810,14 +2180,11 @@ static void pc_machine_class_init(ObjectClass *=
oc, void *data)
>      pcmc->pvh_enabled =3D true;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler =3D pc_get_hotplug_handler;
> -    mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
> -    mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
> -    mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
>      mc->auto_enable_numa_with_memhp =3D true;
>      mc->has_hotpluggable_cpus =3D true;
>      mc->default_boot_order =3D "cad";
> -    mc->hot_add_cpu =3D pc_hot_add_cpu;
> -    mc->smp_parse =3D pc_smp_parse;
> +    mc->hot_add_cpu =3D x86_hot_add_cpu;
> +    mc->smp_parse =3D x86_smp_parse;
>      mc->block_default_type =3D IF_IDE;
>      mc->max_cpus =3D 255;
>      mc->reset =3D pc_machine_reset;
> @@ -2835,13 +2202,6 @@ static void pc_machine_class_init(ObjectClass *o=
c, void *data)
>          pc_machine_get_device_memory_region_size, NULL,
>          NULL, NULL, &error_abort);
> =20
> -    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
> -        pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_=
4g,
> -        NULL, NULL, &error_abort);
> -
> -    object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW=
_4G,
> -        "Maximum ram below the 4G boundary (32bit boundary)", &error_a=
bort);
> -
>      object_class_property_add(oc, PC_MACHINE_SMM, "OnOffAuto",
>          pc_machine_get_smm, pc_machine_set_smm,
>          NULL, NULL, &error_abort);
> @@ -2866,7 +2226,7 @@ static void pc_machine_class_init(ObjectClass *oc=
, void *data)
> =20
>  static const TypeInfo pc_machine_info =3D {
>      .name =3D TYPE_PC_MACHINE,
> -    .parent =3D TYPE_MACHINE,
> +    .parent =3D TYPE_X86_MACHINE,
>      .abstract =3D true,
>      .instance_size =3D sizeof(PCMachineState),
>      .instance_init =3D pc_machine_initfn,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 2362675149..f63c27bc74 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -27,6 +27,7 @@
> =20
>  #include "qemu/units.h"
>  #include "hw/loader.h"
> +#include "hw/i386/x86.h"
>  #include "hw/i386/pc.h"
>  #include "hw/i386/apic.h"
>  #include "hw/display/ramfb.h"
> @@ -73,6 +74,7 @@ static void pc_init1(MachineState *machine,
>  {
>      PCMachineState *pcms =3D PC_MACHINE(machine);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *system_io =3D get_system_io();
>      int i;
> @@ -125,11 +127,11 @@ static void pc_init1(MachineState *machine,
>      if (xen_enabled()) {
>          xen_hvm_init(pcms, &ram_memory);
>      } else {
> -        if (!pcms->max_ram_below_4g) {
> -            pcms->max_ram_below_4g =3D 0xe0000000; /* default: 3.5G */
> +        if (!x86ms->max_ram_below_4g) {
> +            x86ms->max_ram_below_4g =3D 0xe0000000; /* default: 3.5G *=
/
>          }
> -        lowmem =3D pcms->max_ram_below_4g;
> -        if (machine->ram_size >=3D pcms->max_ram_below_4g) {
> +        lowmem =3D x86ms->max_ram_below_4g;
> +        if (machine->ram_size >=3D x86ms->max_ram_below_4g) {
>              if (pcmc->gigabyte_align) {
>                  if (lowmem > 0xc0000000) {
>                      lowmem =3D 0xc0000000;
> @@ -138,21 +140,21 @@ static void pc_init1(MachineState *machine,
>                      warn_report("Large machine and max_ram_below_4g "
>                                  "(%" PRIu64 ") not a multiple of 1G; "
>                                  "possible bad performance.",
> -                                pcms->max_ram_below_4g);
> +                                x86ms->max_ram_below_4g);
>                  }
>              }
>          }
> =20
>          if (machine->ram_size >=3D lowmem) {
> -            pcms->above_4g_mem_size =3D machine->ram_size - lowmem;
> -            pcms->below_4g_mem_size =3D lowmem;
> +            x86ms->above_4g_mem_size =3D machine->ram_size - lowmem;
> +            x86ms->below_4g_mem_size =3D lowmem;
>          } else {
> -            pcms->above_4g_mem_size =3D 0;
> -            pcms->below_4g_mem_size =3D machine->ram_size;
> +            x86ms->above_4g_mem_size =3D 0;
> +            x86ms->below_4g_mem_size =3D machine->ram_size;
>          }
>      }
> =20
> -    pc_cpus_init(pcms);
> +    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> =20
>      if (kvm_enabled() && pcmc->kvmclock_enabled) {
>          kvmclock_create();
> @@ -190,19 +192,19 @@ static void pc_init1(MachineState *machine,
>      gsi_state =3D g_malloc0(sizeof(*gsi_state));
>      if (kvm_ioapic_in_kernel()) {
>          kvm_pc_setup_irq_routing(pcmc->pci_enabled);
> -        pcms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state=
,
> -                                       GSI_NUM_PINS);
> +        x86ms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_stat=
e,
> +                                        GSI_NUM_PINS);
>      } else {
> -        pcms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_N=
UM_PINS);
> +        x86ms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_=
NUM_PINS);
>      }
> =20
>      if (pcmc->pci_enabled) {
>          pci_bus =3D i440fx_init(host_type,
>                                pci_type,
> -                              &i440fx_state, &piix3_devfn, &isa_bus, p=
cms->gsi,
> +                              &i440fx_state, &piix3_devfn, &isa_bus, x=
86ms->gsi,
>                                system_memory, system_io, machine->ram_s=
ize,
> -                              pcms->below_4g_mem_size,
> -                              pcms->above_4g_mem_size,
> +                              x86ms->below_4g_mem_size,
> +                              x86ms->above_4g_mem_size,
>                                pci_memory, ram_memory);
>          pcms->bus =3D pci_bus;
>      } else {
> @@ -212,7 +214,7 @@ static void pc_init1(MachineState *machine,
>                                &error_abort);
>          no_hpet =3D 1;
>      }
> -    isa_bus_irqs(isa_bus, pcms->gsi);
> +    isa_bus_irqs(isa_bus, x86ms->gsi);
> =20
>      if (kvm_pic_in_kernel()) {
>          i8259 =3D kvm_i8259_init(isa_bus);
> @@ -230,7 +232,7 @@ static void pc_init1(MachineState *machine,
>          ioapic_init_gsi(gsi_state, "i440fx");
>      }
> =20
> -    pc_register_ferr_irq(pcms->gsi[13]);
> +    pc_register_ferr_irq(x86ms->gsi[13]);
> =20
>      pc_vga_init(isa_bus, pcmc->pci_enabled ? pci_bus : NULL);
> =20
> @@ -240,7 +242,7 @@ static void pc_init1(MachineState *machine,
>      }
> =20
>      /* init basic PC hardware */
> -    pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
> +    pc_basic_device_init(isa_bus, x86ms->gsi, &rtc_state, true,
>                           (pcms->vmport !=3D ON_OFF_AUTO_ON), pcms->pit=
_enabled,
>                           0x4);
> =20
> @@ -288,7 +290,7 @@ else {
>          smi_irq =3D qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu=
, 0);
>          /* TODO: Populate SPD eeprom data.  */
>          smbus =3D piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
> -                              pcms->gsi[9], smi_irq,
> +                              x86ms->gsi[9], smi_irq,
>                                pc_machine_is_smm_enabled(pcms),
>                                &piix4_pm);
>          smbus_eeprom_init(smbus, 8, NULL, 0);
> @@ -304,7 +306,7 @@ else {
> =20
>      if (machine->nvdimms_state->is_enabled) {
>          nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> -                               pcms->fw_cfg, OBJECT(pcms));
> +                               x86ms->fw_cfg, OBJECT(pcms));
>      }
>  }
> =20
> @@ -728,7 +730,7 @@ DEFINE_I440FX_MACHINE(v1_4, "pc-i440fx-1.4", pc_com=
pat_1_4_fn,
> =20
>  static void pc_i440fx_1_3_machine_options(MachineClass *m)
>  {
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
>      static GlobalProperty compat[] =3D {
>          PC_CPU_MODEL_IDS("1.3.0")
>          { "usb-tablet", "usb_version", "1" },
> @@ -739,7 +741,7 @@ static void pc_i440fx_1_3_machine_options(MachineCl=
ass *m)
> =20
>      pc_i440fx_1_4_machine_options(m);
>      m->hw_version =3D "1.3.0";
> -    pcmc->compat_apic_id_mode =3D true;
> +    x86mc->compat_apic_id_mode =3D true;
>      compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> =20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d4e8a1cb9f..71f71bc61d 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -41,6 +41,7 @@
>  #include "hw/pci-host/q35.h"
>  #include "hw/qdev-properties.h"
>  #include "exec/address-spaces.h"
> +#include "hw/i386/x86.h"
>  #include "hw/i386/pc.h"
>  #include "hw/i386/ich9.h"
>  #include "hw/i386/amd_iommu.h"
> @@ -115,6 +116,7 @@ static void pc_q35_init(MachineState *machine)
>  {
>      PCMachineState *pcms =3D PC_MACHINE(machine);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> +    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>      Q35PCIHost *q35_host;
>      PCIHostState *phb;
>      PCIBus *host_bus;
> @@ -152,34 +154,34 @@ static void pc_q35_init(MachineState *machine)
>      /* Handle the machine opt max-ram-below-4g.  It is basically doing
>       * min(qemu limit, user limit).
>       */
> -    if (!pcms->max_ram_below_4g) {
> -        pcms->max_ram_below_4g =3D 1ULL << 32; /* default: 4G */;
> +    if (!x86ms->max_ram_below_4g) {
> +        x86ms->max_ram_below_4g =3D 1ULL << 32; /* default: 4G */;
>      }
> -    if (lowmem > pcms->max_ram_below_4g) {
> -        lowmem =3D pcms->max_ram_below_4g;
> +    if (lowmem > x86ms->max_ram_below_4g) {
> +        lowmem =3D x86ms->max_ram_below_4g;
>          if (machine->ram_size - lowmem > lowmem &&
>              lowmem & (1 * GiB - 1)) {
>              warn_report("There is possibly poor performance as the ram=
 size "
>                          " (0x%" PRIx64 ") is more then twice the size =
of"
>                          " max-ram-below-4g (%"PRIu64") and"
>                          " max-ram-below-4g is not a multiple of 1G.",
> -                        (uint64_t)machine->ram_size, pcms->max_ram_bel=
ow_4g);
> +                        (uint64_t)machine->ram_size, x86ms->max_ram_be=
low_4g);
>          }
>      }
> =20
>      if (machine->ram_size >=3D lowmem) {
> -        pcms->above_4g_mem_size =3D machine->ram_size - lowmem;
> -        pcms->below_4g_mem_size =3D lowmem;
> +        x86ms->above_4g_mem_size =3D machine->ram_size - lowmem;
> +        x86ms->below_4g_mem_size =3D lowmem;
>      } else {
> -        pcms->above_4g_mem_size =3D 0;
> -        pcms->below_4g_mem_size =3D machine->ram_size;
> +        x86ms->above_4g_mem_size =3D 0;
> +        x86ms->below_4g_mem_size =3D machine->ram_size;
>      }
> =20
>      if (xen_enabled()) {
>          xen_hvm_init(pcms, &ram_memory);
>      }
> =20
> -    pc_cpus_init(pcms);
> +    x86_cpus_init(x86ms, pcmc->default_cpu_version);
> =20
>      kvmclock_create();
> =20
> @@ -213,10 +215,10 @@ static void pc_q35_init(MachineState *machine)
>      gsi_state =3D g_malloc0(sizeof(*gsi_state));
>      if (kvm_ioapic_in_kernel()) {
>          kvm_pc_setup_irq_routing(pcmc->pci_enabled);
> -        pcms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state=
,
> +        x86ms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_stat=
e,
>                                         GSI_NUM_PINS);
>      } else {
> -        pcms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_N=
UM_PINS);
> +        x86ms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_=
NUM_PINS);
>      }
> =20
>      /* create pci host bus */
> @@ -231,9 +233,9 @@ static void pc_q35_init(MachineState *machine)
>                               MCH_HOST_PROP_SYSTEM_MEM, NULL);
>      object_property_set_link(OBJECT(q35_host), OBJECT(system_io),
>                               MCH_HOST_PROP_IO_MEM, NULL);
> -    object_property_set_int(OBJECT(q35_host), pcms->below_4g_mem_size,
> +    object_property_set_int(OBJECT(q35_host), x86ms->below_4g_mem_size=
,
>                              PCI_HOST_BELOW_4G_MEM_SIZE, NULL);
> -    object_property_set_int(OBJECT(q35_host), pcms->above_4g_mem_size,
> +    object_property_set_int(OBJECT(q35_host), x86ms->above_4g_mem_size=
,
>                              PCI_HOST_ABOVE_4G_MEM_SIZE, NULL);
>      /* pci */
>      qdev_init_nofail(DEVICE(q35_host));
> @@ -255,7 +257,7 @@ static void pc_q35_init(MachineState *machine)
>      ich9_lpc =3D ICH9_LPC_DEVICE(lpc);
>      lpc_dev =3D DEVICE(lpc);
>      for (i =3D 0; i < GSI_NUM_PINS; i++) {
> -        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, pcms->g=
si[i]);
> +        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->=
gsi[i]);
>      }
>      pci_bus_irqs(host_bus, ich9_lpc_set_irq, ich9_lpc_map_irq, ich9_lp=
c,
>                   ICH9_LPC_NB_PIRQS);
> @@ -279,7 +281,7 @@ static void pc_q35_init(MachineState *machine)
>          ioapic_init_gsi(gsi_state, "q35");
>      }
> =20
> -    pc_register_ferr_irq(pcms->gsi[13]);
> +    pc_register_ferr_irq(x86ms->gsi[13]);
> =20
>      assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
>      if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> @@ -287,7 +289,7 @@ static void pc_q35_init(MachineState *machine)
>      }
> =20
>      /* init basic PC hardware */
> -    pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, !mc->no_flopp=
y,
> +    pc_basic_device_init(isa_bus, x86ms->gsi, &rtc_state, !mc->no_flop=
py,
>                           (pcms->vmport !=3D ON_OFF_AUTO_ON), pcms->pit=
_enabled,
>                           0xff0104);
> =20
> @@ -330,7 +332,7 @@ static void pc_q35_init(MachineState *machine)
> =20
>      if (machine->nvdimms_state->is_enabled) {
>          nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> -                               pcms->fw_cfg, OBJECT(pcms));
> +                               x86ms->fw_cfg, OBJECT(pcms));
>      }
>  }
> =20
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index a9983f0bfb..97f38e0423 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -31,6 +31,7 @@
>  #include "qemu/option.h"
>  #include "qemu/units.h"
>  #include "hw/sysbus.h"
> +#include "hw/i386/x86.h"
>  #include "hw/i386/pc.h"
>  #include "hw/loader.h"
>  #include "hw/qdev-properties.h"
> @@ -38,8 +39,6 @@
>  #include "hw/block/flash.h"
>  #include "sysemu/kvm.h"
> =20
> -#define BIOS_FILENAME "bios.bin"
> -
>  /*
>   * We don't have a theoretically justifiable exact lower bound on the =
base
>   * address of any flash mapping. In practice, the IO-APIC MMIO range i=
s
> @@ -211,59 +210,6 @@ static void pc_system_flash_map(PCMachineState *pc=
ms,
>      }
>  }
> =20
> -static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isap=
c_ram_fw)
> -{
> -    char *filename;
> -    MemoryRegion *bios, *isa_bios;
> -    int bios_size, isa_bios_size;
> -    int ret;
> -
> -    /* BIOS load */
> -    if (bios_name =3D=3D NULL) {
> -        bios_name =3D BIOS_FILENAME;
> -    }
> -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    if (filename) {
> -        bios_size =3D get_image_size(filename);
> -    } else {
> -        bios_size =3D -1;
> -    }
> -    if (bios_size <=3D 0 ||
> -        (bios_size % 65536) !=3D 0) {
> -        goto bios_error;
> -    }
> -    bios =3D g_malloc(sizeof(*bios));
> -    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fa=
tal);
> -    if (!isapc_ram_fw) {
> -        memory_region_set_readonly(bios, true);
> -    }
> -    ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
> -    if (ret !=3D 0) {
> -    bios_error:
> -        fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_na=
me);
> -        exit(1);
> -    }
> -    g_free(filename);
> -
> -    /* map the last 128KB of the BIOS in ISA space */
> -    isa_bios_size =3D MIN(bios_size, 128 * KiB);
> -    isa_bios =3D g_malloc(sizeof(*isa_bios));
> -    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
> -                             bios_size - isa_bios_size, isa_bios_size)=
;
> -    memory_region_add_subregion_overlap(rom_memory,
> -                                        0x100000 - isa_bios_size,
> -                                        isa_bios,
> -                                        1);
> -    if (!isapc_ram_fw) {
> -        memory_region_set_readonly(isa_bios, true);
> -    }
> -
> -    /* map all the bios at the top of memory */
> -    memory_region_add_subregion(rom_memory,
> -                                (uint32_t)(-bios_size),
> -                                bios);
> -}
> -
>  void pc_system_firmware_init(PCMachineState *pcms,
>                               MemoryRegion *rom_memory)
>  {
> @@ -272,7 +218,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
> =20
>      if (!pcmc->pci_enabled) {
> -        old_pc_system_rom_init(rom_memory, true);
> +        x86_system_rom_init(rom_memory, true);
>          return;
>      }
> =20
> @@ -293,7 +239,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
> =20
>      if (!pflash_blk[0]) {
>          /* Machine property pflash0 not set, use ROM mode */
> -        old_pc_system_rom_init(rom_memory, false);
> +        x86_system_rom_init(rom_memory, false);
>      } else {
>          if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>              /*
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> new file mode 100644
> index 0000000000..4de9dd100f
> --- /dev/null
> +++ b/hw/i386/x86.c
> @@ -0,0 +1,788 @@
> +/*
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/cutils.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "qapi/visitor.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/numa.h"
> +#include "sysemu/replay.h"
> +#include "sysemu/sysemu.h"
> +
> +#include "hw/i386/x86.h"
> +#include "target/i386/cpu.h"
> +#include "hw/i386/topology.h"
> +#include "hw/i386/fw_cfg.h"
> +#include "hw/acpi/cpu_hotplug.h"
> +#include "hw/nmi.h"
> +#include "hw/loader.h"
> +#include "multiboot.h"
> +#include "pvh.h"
> +#include "standard-headers/asm-x86/bootparam.h"
> +
> +#define BIOS_FILENAME "bios.bin"
> +
> +/* Calculates initial APIC ID for a specific CPU index
> + *
> + * Currently we need to be able to calculate the APIC ID from the CPU =
index
> + * alone (without requiring a CPU object), as the QEMU<->Seabios inter=
faces have
> + * no concept of "CPU index", and the NUMA tables on fw_cfg need the A=
PIC ID of
> + * all CPUs up to max_cpus.
> + */
> +uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> +                                    unsigned int cpu_index)
> +{
> +    MachineState *ms =3D MACHINE(x86ms);
> +    X86MachineClass *x86mc =3D X86_MACHINE_GET_CLASS(x86ms);
> +    uint32_t correct_id;
> +    static bool warned;
> +
> +    correct_id =3D x86_apicid_from_cpu_idx(x86ms->smp_dies, ms->smp.co=
res,
> +                                         ms->smp.threads, cpu_index);
> +    if (x86mc->compat_apic_id_mode) {
> +        if (cpu_index !=3D correct_id && !warned && !qtest_enabled()) =
{
> +            error_report("APIC IDs set in compatibility mode, "
> +                         "CPU topology won't match the configuration")=
;
> +            warned =3D true;
> +        }
> +        return cpu_index;
> +    } else {
> +        return correct_id;
> +    }
> +}
> +
> +
> +static void x86_new_cpu(X86MachineState *x86ms, int64_t apic_id, Error=
 **errp)
> +{
> +    Object *cpu =3D NULL;
> +    Error *local_err =3D NULL;
> +    CPUX86State *env =3D NULL;
> +
> +    cpu =3D object_new(MACHINE(x86ms)->cpu_type);
> +
> +    env =3D &X86_CPU(cpu)->env;
> +    env->nr_dies =3D x86ms->smp_dies;
> +
> +    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
> +    object_property_set_bool(cpu, true, "realized", &local_err);
> +
> +    object_unref(cpu);
> +    error_propagate(errp, local_err);
> +}
> +
> +/*
> + * This function is very similar to smp_parse()
> + * in hw/core/machine.c but includes CPU die support.
> + */
> +void x86_smp_parse(MachineState *ms, QemuOpts *opts)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(ms);
> +
> +    if (opts) {
> +        unsigned cpus    =3D qemu_opt_get_number(opts, "cpus", 0);
> +        unsigned sockets =3D qemu_opt_get_number(opts, "sockets", 0);
> +        unsigned dies =3D qemu_opt_get_number(opts, "dies", 1);
> +        unsigned cores   =3D qemu_opt_get_number(opts, "cores", 0);
> +        unsigned threads =3D qemu_opt_get_number(opts, "threads", 0);
> +
> +        /* compute missing values, prefer sockets over cores over thre=
ads */
> +        if (cpus =3D=3D 0 || sockets =3D=3D 0) {
> +            cores =3D cores > 0 ? cores : 1;
> +            threads =3D threads > 0 ? threads : 1;
> +            if (cpus =3D=3D 0) {
> +                sockets =3D sockets > 0 ? sockets : 1;
> +                cpus =3D cores * threads * dies * sockets;
> +            } else {
> +                ms->smp.max_cpus =3D
> +                        qemu_opt_get_number(opts, "maxcpus", cpus);
> +                sockets =3D ms->smp.max_cpus / (cores * threads * dies=
);
> +            }
> +        } else if (cores =3D=3D 0) {
> +            threads =3D threads > 0 ? threads : 1;
> +            cores =3D cpus / (sockets * dies * threads);
> +            cores =3D cores > 0 ? cores : 1;
> +        } else if (threads =3D=3D 0) {
> +            threads =3D cpus / (cores * dies * sockets);
> +            threads =3D threads > 0 ? threads : 1;
> +        } else if (sockets * dies * cores * threads < cpus) {
> +            error_report("cpu topology: "
> +                         "sockets (%u) * dies (%u) * cores (%u) * thre=
ads (%u) < "
> +                         "smp_cpus (%u)",
> +                         sockets, dies, cores, threads, cpus);
> +            exit(1);
> +        }
> +
> +        ms->smp.max_cpus =3D
> +                qemu_opt_get_number(opts, "maxcpus", cpus);
> +
> +        if (ms->smp.max_cpus < cpus) {
> +            error_report("maxcpus must be equal to or greater than smp=
");
> +            exit(1);
> +        }
> +
> +        if (sockets * dies * cores * threads > ms->smp.max_cpus) {
> +            error_report("cpu topology: "
> +                         "sockets (%u) * dies (%u) * cores (%u) * thre=
ads (%u) > "
> +                         "maxcpus (%u)",
> +                         sockets, dies, cores, threads,
> +                         ms->smp.max_cpus);
> +            exit(1);
> +        }
> +
> +        if (sockets * dies * cores * threads !=3D ms->smp.max_cpus) {
> +            warn_report("Invalid CPU topology deprecated: "
> +                        "sockets (%u) * dies (%u) * cores (%u) * threa=
ds (%u) "
> +                        "!=3D maxcpus (%u)",
> +                        sockets, dies, cores, threads,
> +                        ms->smp.max_cpus);
> +        }
> +
> +        ms->smp.cpus =3D cpus;
> +        ms->smp.cores =3D cores;
> +        ms->smp.threads =3D threads;
> +        x86ms->smp_dies =3D dies;
> +    }
> +
> +    if (ms->smp.cpus > 1) {
> +        Error *blocker =3D NULL;
> +        error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
> +        replay_add_blocker(blocker);
> +    }
> +}
> +
> +void x86_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(ms);
> +    int64_t apic_id =3D x86_cpu_apic_id_from_index(x86ms, id);
> +    Error *local_err =3D NULL;
> +
> +    if (id < 0) {
> +        error_setg(errp, "Invalid CPU id: %" PRIi64, id);
> +        return;
> +    }
> +
> +    if (apic_id >=3D ACPI_CPU_HOTPLUG_ID_LIMIT) {
> +        error_setg(errp, "Unable to add CPU: %" PRIi64
> +                   ", resulting APIC ID (%" PRIi64 ") is too large",
> +                   id, apic_id);
> +        return;
> +    }
> +
> +    x86_new_cpu(X86_MACHINE(ms), apic_id, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +}
> +
> +void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> +{
> +    int i;
> +    const CPUArchIdList *possible_cpus;
> +    MachineState *ms =3D MACHINE(x86ms);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
> +
> +    x86_cpu_set_default_version(default_cpu_version);
> +
> +    /* Calculates the limit to CPU APIC ID values
> +     *
> +     * Limit for the APIC ID value, so that all
> +     * CPU APIC IDs are < x86ms->apic_id_limit.
> +     *
> +     * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_in=
it().
> +     */
> +    x86ms->apic_id_limit =3D x86_cpu_apic_id_from_index(x86ms,
> +                                                      ms->smp.max_cpus=
 - 1) + 1;
> +    possible_cpus =3D mc->possible_cpu_arch_ids(ms);
> +    for (i =3D 0; i < ms->smp.cpus; i++) {
> +        x86_new_cpu(x86ms, possible_cpus->cpus[i].arch_id, &error_fata=
l);
> +    }
> +}
> +
> +void x86_nmi(NMIState *n, int cpu_index, Error **errp)
> +{
> +    /* cpu index isn't used */
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        X86CPU *cpu =3D X86_CPU(cs);
> +
> +        if (!cpu->apic_state) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
> +        } else {
> +            apic_deliver_nmi(cpu->apic_state);
> +        }
> +    }
> +}
> +
> +CpuInstanceProperties
> +x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(m=
s);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;
> +}
> +
> +int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
> +{
> +   X86CPUTopoInfo topo;
> +   X86MachineState *x86ms =3D X86_MACHINE(ms);
> +
> +   assert(idx < ms->possible_cpus->len);
> +   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> +                            x86ms->smp_dies, ms->smp.cores,
> +                            ms->smp.threads, &topo);
> +   return topo.pkg_id % ms->numa_state->num_nodes;
> +}
> +
> +const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(ms);
> +    int i;
> +    unsigned int max_cpus =3D ms->smp.max_cpus;
> +
> +    if (ms->possible_cpus) {
> +        /*
> +         * make sure that max_cpus hasn't changed since the first use,=
 i.e.
> +         * -smp hasn't been parsed after it
> +        */
> +        assert(ms->possible_cpus->len =3D=3D max_cpus);
> +        return ms->possible_cpus;
> +    }
> +
> +    ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
> +                                  sizeof(CPUArchId) * max_cpus);
> +    ms->possible_cpus->len =3D max_cpus;
> +    for (i =3D 0; i < ms->possible_cpus->len; i++) {
> +        X86CPUTopoInfo topo;
> +
> +        ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
> +        ms->possible_cpus->cpus[i].vcpus_count =3D 1;
> +        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_in=
dex(x86ms, i);
> +        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> +                                 x86ms->smp_dies, ms->smp.cores,
> +                                 ms->smp.threads, &topo);
> +        ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
> +        ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
> +        if (x86ms->smp_dies > 1) {
> +            ms->possible_cpus->cpus[i].props.has_die_id =3D true;
> +            ms->possible_cpus->cpus[i].props.die_id =3D topo.die_id;
> +        }
> +        ms->possible_cpus->cpus[i].props.has_core_id =3D true;
> +        ms->possible_cpus->cpus[i].props.core_id =3D topo.core_id;
> +        ms->possible_cpus->cpus[i].props.has_thread_id =3D true;
> +        ms->possible_cpus->cpus[i].props.thread_id =3D topo.smt_id;
> +    }
> +    return ms->possible_cpus;
> +}
> +
> +void x86_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
> +{
> +    char *filename;
> +    MemoryRegion *bios, *isa_bios;
> +    int bios_size, isa_bios_size;
> +    int ret;
> +
> +    /* BIOS load */
> +    if (bios_name =3D=3D NULL) {
> +        bios_name =3D BIOS_FILENAME;
> +    }
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (filename) {
> +        bios_size =3D get_image_size(filename);
> +    } else {
> +        bios_size =3D -1;
> +    }
> +    if (bios_size <=3D 0 ||
> +        (bios_size % 65536) !=3D 0) {
> +        goto bios_error;
> +    }
> +    bios =3D g_malloc(sizeof(*bios));
> +    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fa=
tal);
> +    if (!isapc_ram_fw) {
> +        memory_region_set_readonly(bios, true);
> +    }
> +    ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
> +    if (ret !=3D 0) {
> +    bios_error:
> +        fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_na=
me);
> +        exit(1);
> +    }
> +    g_free(filename);
> +
> +    /* map the last 128KB of the BIOS in ISA space */
> +    isa_bios_size =3D MIN(bios_size, 128 * KiB);
> +    isa_bios =3D g_malloc(sizeof(*isa_bios));
> +    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
> +                             bios_size - isa_bios_size, isa_bios_size)=
;
> +    memory_region_add_subregion_overlap(rom_memory,
> +                                        0x100000 - isa_bios_size,
> +                                        isa_bios,
> +                                        1);
> +    if (!isapc_ram_fw) {
> +        memory_region_set_readonly(isa_bios, true);
> +    }
> +
> +    /* map all the bios at the top of memory */
> +    memory_region_add_subregion(rom_memory,
> +                                (uint32_t)(-bios_size),
> +                                bios);
> +}
> +
> +static long get_file_size(FILE *f)
> +{
> +    long where, size;
> +
> +    /* XXX: on Unix systems, using fstat() probably makes more sense *=
/
> +
> +    where =3D ftell(f);
> +    fseek(f, 0, SEEK_END);
> +    size =3D ftell(f);
> +    fseek(f, where, SEEK_SET);
> +
> +    return size;
> +}
> +
> +struct setup_data {
> +    uint64_t next;
> +    uint32_t type;
> +    uint32_t len;
> +    uint8_t data[0];
> +} __attribute__((packed));
> +
> +void load_linux(X86MachineState *x86ms,
> +                FWCfgState *fw_cfg,
> +                unsigned acpi_data_size,
> +                bool linuxboot_dma_enabled,
> +                bool pvh_enabled)
> +{
> +    uint16_t protocol;
> +    int setup_size, kernel_size, cmdline_size;
> +    int dtb_size, setup_data_offset;
> +    uint32_t initrd_max;
> +    uint8_t header[8192], *setup, *kernel;
> +    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr =3D 0;
> +    FILE *f;
> +    char *vmode;
> +    MachineState *machine =3D MACHINE(x86ms);
> +    struct setup_data *setup_data;
> +    const char *kernel_filename =3D machine->kernel_filename;
> +    const char *initrd_filename =3D machine->initrd_filename;
> +    const char *dtb_filename =3D machine->dtb;
> +    const char *kernel_cmdline =3D machine->kernel_cmdline;
> +
> +    /* Align to 16 bytes as a paranoia measure */
> +    cmdline_size =3D (strlen(kernel_cmdline)+16) & ~15;
> +
> +    /* load the kernel header */
> +    f =3D fopen(kernel_filename, "rb");
> +    if (!f || !(kernel_size =3D get_file_size(f)) ||
> +        fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=3D
> +        MIN(ARRAY_SIZE(header), kernel_size)) {
> +        fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
> +                kernel_filename, strerror(errno));
> +        exit(1);
> +    }
> +
> +    /* kernel protocol version */
> +#if 0
> +    fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));
> +#endif
> +    if (ldl_p(header+0x202) =3D=3D 0x53726448) {
> +        protocol =3D lduw_p(header+0x206);
> +    } else {
> +        size_t pvh_start_addr;
> +        uint32_t mh_load_addr =3D 0;
> +        uint32_t elf_kernel_size =3D 0;
> +        /*
> +         * This could be a multiboot kernel. If it is, let's stop trea=
ting it
> +         * like a Linux kernel.
> +         * Note: some multiboot images could be in the ELF format (the=
 same of
> +         * PVH), so we try multiboot first since we check the multiboo=
t magic
> +         * header before to load it.
> +         */
> +        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename=
,
> +                           kernel_cmdline, kernel_size, header)) {
> +            return;
> +        }
> +        /*
> +         * Check if the file is an uncompressed kernel file (ELF) and =
load it,
> +         * saving the PVH entry point used by the x86/HVM direct boot =
ABI.
> +         * If load_elfboot() is successful, populate the fw_cfg info.
> +         */
> +        if (pvh_enabled &&
> +            pvh_load_elfboot(kernel_filename,
> +                             &mh_load_addr, &elf_kernel_size)) {
> +            fclose(f);
> +
> +            pvh_start_addr =3D pvh_get_start_addr();
> +
> +            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr=
);
> +            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
> +            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size=
);
> +
> +            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
> +                strlen(kernel_cmdline) + 1);
> +            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdl=
ine);
> +
> +            fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
> +            fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
> +                             header, sizeof(header));
> +
> +            /* load initrd */
> +            if (initrd_filename) {
> +                GMappedFile *mapped_file;
> +                gsize initrd_size;
> +                gchar *initrd_data;
> +                GError *gerr =3D NULL;
> +
> +                mapped_file =3D g_mapped_file_new(initrd_filename, fal=
se, &gerr);
> +                if (!mapped_file) {
> +                    fprintf(stderr, "qemu: error reading initrd %s: %s=
\n",
> +                            initrd_filename, gerr->message);
> +                    exit(1);
> +                }
> +                x86ms->initrd_mapped_file =3D mapped_file;
> +
> +                initrd_data =3D g_mapped_file_get_contents(mapped_file=
);
> +                initrd_size =3D g_mapped_file_get_length(mapped_file);
> +                initrd_max =3D x86ms->below_4g_mem_size - acpi_data_si=
ze - 1;
> +                if (initrd_size >=3D initrd_max) {
> +                    fprintf(stderr, "qemu: initrd is too large, cannot=
 support."
> +                            "(max: %"PRIu32", need %"PRId64")\n",
> +                            initrd_max, (uint64_t)initrd_size);
> +                    exit(1);
> +                }
> +
> +                initrd_addr =3D (initrd_max - initrd_size) & ~4095;
> +
> +                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr=
);
> +                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size=
);
> +                fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_da=
ta,
> +                                 initrd_size);
> +            }
> +
> +            option_rom[nb_option_roms].bootindex =3D 0;
> +            option_rom[nb_option_roms].name =3D "pvh.bin";
> +            nb_option_roms++;
> +
> +            return;
> +        }
> +        protocol =3D 0;
> +    }
> +
> +    if (protocol < 0x200 || !(header[0x211] & 0x01)) {
> +        /* Low kernel */
> +        real_addr    =3D 0x90000;
> +        cmdline_addr =3D 0x9a000 - cmdline_size;
> +        prot_addr    =3D 0x10000;
> +    } else if (protocol < 0x202) {
> +        /* High but ancient kernel */
> +        real_addr    =3D 0x90000;
> +        cmdline_addr =3D 0x9a000 - cmdline_size;
> +        prot_addr    =3D 0x100000;
> +    } else {
> +        /* High and recent kernel */
> +        real_addr    =3D 0x10000;
> +        cmdline_addr =3D 0x20000;
> +        prot_addr    =3D 0x100000;
> +    }
> +
> +#if 0
> +    fprintf(stderr,
> +            "qemu: real_addr     =3D 0x" TARGET_FMT_plx "\n"
> +            "qemu: cmdline_addr  =3D 0x" TARGET_FMT_plx "\n"
> +            "qemu: prot_addr     =3D 0x" TARGET_FMT_plx "\n",
> +            real_addr,
> +            cmdline_addr,
> +            prot_addr);
> +#endif
> +
> +    /* highest address for loading the initrd */
> +    if (protocol >=3D 0x20c &&
> +        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> +        /*
> +         * Linux has supported initrd up to 4 GB for a very long time =
(2007,
> +         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2=
013),
> +         * though it only sets initrd_max to 2 GB to "work around boot=
loader
> +         * bugs". Luckily, QEMU firmware(which does something like boo=
tloader)
> +         * has supported this.
> +         *
> +         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, in=
itrd can
> +         * be loaded into any address.
> +         *
> +         * In addition, initrd_max is uint32_t simply because QEMU doe=
sn't
> +         * support the 64-bit boot protocol (specifically the ext_ramd=
isk_image
> +         * field).
> +         *
> +         * Therefore here just limit initrd_max to UINT32_MAX simply a=
s well.
> +         */
> +        initrd_max =3D UINT32_MAX;
> +    } else if (protocol >=3D 0x203) {
> +        initrd_max =3D ldl_p(header+0x22c);
> +    } else {
> +        initrd_max =3D 0x37ffffff;
> +    }
> +
> +    if (initrd_max >=3D x86ms->below_4g_mem_size - acpi_data_size) {
> +        initrd_max =3D x86ms->below_4g_mem_size - acpi_data_size - 1;
> +    }
> +
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline)=
+1);
> +    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
> +
> +    if (protocol >=3D 0x202) {
> +        stl_p(header+0x228, cmdline_addr);
> +    } else {
> +        stw_p(header+0x20, 0xA33F);
> +        stw_p(header+0x22, cmdline_addr-real_addr);
> +    }
> +
> +    /* handle vga=3D parameter */
> +    vmode =3D strstr(kernel_cmdline, "vga=3D");
> +    if (vmode) {
> +        unsigned int video_mode;
> +        /* skip "vga=3D" */
> +        vmode +=3D 4;
> +        if (!strncmp(vmode, "normal", 6)) {
> +            video_mode =3D 0xffff;
> +        } else if (!strncmp(vmode, "ext", 3)) {
> +            video_mode =3D 0xfffe;
> +        } else if (!strncmp(vmode, "ask", 3)) {
> +            video_mode =3D 0xfffd;
> +        } else {
> +            video_mode =3D strtol(vmode, NULL, 0);
> +        }
> +        stw_p(header+0x1fa, video_mode);
> +    }
> +
> +    /* loader type */
> +    /* High nybble =3D B reserved for QEMU; low nybble is revision num=
ber.
> +       If this code is substantially changed, you may want to consider
> +       incrementing the revision. */
> +    if (protocol >=3D 0x200) {
> +        header[0x210] =3D 0xB0;
> +    }
> +    /* heap */
> +    if (protocol >=3D 0x201) {
> +        header[0x211] |=3D 0x80;	/* CAN_USE_HEAP */
> +        stw_p(header+0x224, cmdline_addr-real_addr-0x200);
> +    }
> +
> +    /* load initrd */
> +    if (initrd_filename) {
> +        GMappedFile *mapped_file;
> +        gsize initrd_size;
> +        gchar *initrd_data;
> +        GError *gerr =3D NULL;
> +
> +        if (protocol < 0x200) {
> +            fprintf(stderr, "qemu: linux kernel too old to load a ram =
disk\n");
> +            exit(1);
> +        }
> +
> +        mapped_file =3D g_mapped_file_new(initrd_filename, false, &ger=
r);
> +        if (!mapped_file) {
> +            fprintf(stderr, "qemu: error reading initrd %s: %s\n",
> +                    initrd_filename, gerr->message);
> +            exit(1);
> +        }
> +        x86ms->initrd_mapped_file =3D mapped_file;
> +
> +        initrd_data =3D g_mapped_file_get_contents(mapped_file);
> +        initrd_size =3D g_mapped_file_get_length(mapped_file);
> +        if (initrd_size >=3D initrd_max) {
> +            fprintf(stderr, "qemu: initrd is too large, cannot support=
."
> +                    "(max: %"PRIu32", need %"PRId64")\n",
> +                    initrd_max, (uint64_t)initrd_size);
> +            exit(1);
> +        }
> +
> +        initrd_addr =3D (initrd_max-initrd_size) & ~4095;
> +
> +        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
> +        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
> +        fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, init=
rd_size);
> +
> +        stl_p(header+0x218, initrd_addr);
> +        stl_p(header+0x21c, initrd_size);
> +    }
> +
> +    /* load kernel and setup */
> +    setup_size =3D header[0x1f1];
> +    if (setup_size =3D=3D 0) {
> +        setup_size =3D 4;
> +    }
> +    setup_size =3D (setup_size+1)*512;
> +    if (setup_size > kernel_size) {
> +        fprintf(stderr, "qemu: invalid kernel header\n");
> +        exit(1);
> +    }
> +    kernel_size -=3D setup_size;
> +
> +    setup  =3D g_malloc(setup_size);
> +    kernel =3D g_malloc(kernel_size);
> +    fseek(f, 0, SEEK_SET);
> +    if (fread(setup, 1, setup_size, f) !=3D setup_size) {
> +        fprintf(stderr, "fread() failed\n");
> +        exit(1);
> +    }
> +    if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
> +        fprintf(stderr, "fread() failed\n");
> +        exit(1);
> +    }
> +    fclose(f);
> +
> +    /* append dtb to kernel */
> +    if (dtb_filename) {
> +        if (protocol < 0x209) {
> +            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\=
n");
> +            exit(1);
> +        }
> +
> +        dtb_size =3D get_image_size(dtb_filename);
> +        if (dtb_size <=3D 0) {
> +            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
> +                    dtb_filename, strerror(errno));
> +            exit(1);
> +        }
> +
> +        setup_data_offset =3D QEMU_ALIGN_UP(kernel_size, 16);
> +        kernel_size =3D setup_data_offset + sizeof(struct setup_data) =
+ dtb_size;
> +        kernel =3D g_realloc(kernel, kernel_size);
> +
> +        stq_p(header+0x250, prot_addr + setup_data_offset);
> +
> +        setup_data =3D (struct setup_data *)(kernel + setup_data_offse=
t);
> +        setup_data->next =3D 0;
> +        setup_data->type =3D cpu_to_le32(SETUP_DTB);
> +        setup_data->len =3D cpu_to_le32(dtb_size);
> +
> +        load_image_size(dtb_filename, setup_data->data, dtb_size);
> +    }
> +
> +    memcpy(setup, header, MIN(sizeof(header), setup_size));
> +
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
> +    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
> +
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
> +    fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
> +
> +    option_rom[nb_option_roms].bootindex =3D 0;
> +    option_rom[nb_option_roms].name =3D "linuxboot.bin";
> +    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
> +        option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
> +    }
> +    nb_option_roms++;
> +}
> +
> +static void x86_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
> +                                             const char *name, void *o=
paque,
> +                                             Error **errp)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(obj);
> +    uint64_t value =3D x86ms->max_ram_below_4g;
> +
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void x86_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
> +                                             const char *name, void *o=
paque,
> +                                             Error **errp)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(obj);
> +    Error *error =3D NULL;
> +    uint64_t value;
> +
> +    visit_type_size(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +    if (value > 4 * GiB) {
> +        error_setg(&error,
> +                   "Machine option 'max-ram-below-4g=3D%"PRIu64
> +                   "' expects size less than or equal to 4G", value);
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    if (value < 1 * MiB) {
> +        warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boun=
dary,"
> +                    "BIOS may not work with less than 1MiB", value);
> +    }
> +
> +    x86ms->max_ram_below_4g =3D value;
> +}
> +
> +static void x86_machine_initfn(Object *obj)
> +{
> +    X86MachineState *x86ms =3D X86_MACHINE(obj);
> +
> +    x86ms->max_ram_below_4g =3D 0; /* use default */
> +    x86ms->smp_dies =3D 1;
> +}
> +
> +static void x86_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->cpu_index_to_instance_props =3D x86_cpu_index_to_props;
> +    mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
> +    mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
> +
> +    object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size"=
,
> +        x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_belo=
w_4g,
> +        NULL, NULL, &error_abort);
> +
> +    object_class_property_set_description(oc, X86_MACHINE_MAX_RAM_BELO=
W_4G,
> +        "Maximum ram below the 4G boundary (32bit boundary)", &error_a=
bort);
> +}
> +
> +static const TypeInfo x86_machine_info =3D {
> +    .name =3D TYPE_X86_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .abstract =3D true,
> +    .instance_size =3D sizeof(X86MachineState),
> +    .instance_init =3D x86_machine_initfn,
> +    .class_size =3D sizeof(X86MachineClass),
> +    .class_init =3D x86_machine_class_init,
> +};
> +
> +static void x86_machine_register_types(void)
> +{
> +    type_register_static(&x86_machine_info);
> +}
> +
> +type_init(x86_machine_register_types)
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 1ede055387..e621dde6c3 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -23,6 +23,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "monitor/monitor.h"
> +#include "hw/i386/x86.h"
>  #include "hw/i386/pc.h"
>  #include "hw/i386/apic.h"
>  #include "hw/i386/ioapic.h"
> @@ -89,7 +90,7 @@ static void ioapic_entry_parse(uint64_t entry, struct=
 ioapic_entry_info *info)
> =20
>  static void ioapic_service(IOAPICCommonState *s)
>  {
> -    AddressSpace *ioapic_as =3D PC_MACHINE(qdev_get_machine())->ioapic=
_as;
> +    AddressSpace *ioapic_as =3D X86_MACHINE(qdev_get_machine())->ioapi=
c_as;
>      struct ioapic_entry_info info;
>      uint8_t i;
>      uint32_t mask;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 062feeb69e..de28d55e5c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -3,6 +3,7 @@
> =20
>  #include "exec/memory.h"
>  #include "hw/boards.h"
> +#include "hw/i386/x86.h"
>  #include "hw/isa/isa.h"
>  #include "hw/block/fdc.h"
>  #include "hw/block/flash.h"
> @@ -27,7 +28,7 @@
>   */
>  struct PCMachineState {
>      /*< private >*/
> -    MachineState parent_obj;
> +    X86MachineState parent_obj;
> =20
>      /* <public> */
> =20
> @@ -36,15 +37,10 @@ struct PCMachineState {
> =20
>      /* Pointers to devices and objects: */
>      HotplugHandler *acpi_dev;
> -    ISADevice *rtc;
>      PCIBus *bus;
> -    FWCfgState *fw_cfg;
> -    qemu_irq *gsi;
>      PFlashCFI01 *flash[2];
> -    GMappedFile *initrd_mapped_file;
> =20
>      /* Configuration options: */
> -    uint64_t max_ram_below_4g;
>      OnOffAuto vmport;
>      OnOffAuto smm;
> =20
> @@ -53,27 +49,13 @@ struct PCMachineState {
>      bool sata_enabled;
>      bool pit_enabled;
> =20
> -    /* RAM information (sizes, addresses, configuration): */
> -    ram_addr_t below_4g_mem_size, above_4g_mem_size;
> -
> -    /* CPU and apic information: */
> -    bool apic_xrupt_override;
> -    unsigned apic_id_limit;
> -    uint16_t boot_cpus;
> -    unsigned smp_dies;
> -
>      /* NUMA information: */
>      uint64_t numa_nodes;
>      uint64_t *node_mem;
> -
> -    /* Address space used by IOAPIC device. All IOAPIC interrupts
> -     * will be translated to MSI messages in the address space. */
> -    AddressSpace *ioapic_as;
>  };
> =20
>  #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
>  #define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
> -#define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
>  #define PC_MACHINE_VMPORT           "vmport"
>  #define PC_MACHINE_SMM              "smm"
>  #define PC_MACHINE_SMBUS            "smbus"
> @@ -139,9 +121,6 @@ typedef struct PCMachineClass {
> =20
>      /* use PVH to load kernels that support this feature */
>      bool pvh_enabled;
> -
> -    /* Enables contiguous-apic-ID mode */
> -    bool compat_apic_id_mode;
>  } PCMachineClass;
> =20
>  #define TYPE_PC_MACHINE "generic-pc-machine"
> @@ -193,10 +172,6 @@ bool pc_machine_is_smm_enabled(PCMachineState *pcm=
s);
>  void pc_register_ferr_irq(qemu_irq irq);
>  void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
> =20
> -void pc_cpus_init(PCMachineState *pcms);
> -void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
> -void pc_smp_parse(MachineState *ms, QemuOpts *opts);
> -
>  void pc_guest_info_init(PCMachineState *pcms);
> =20
>  #define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> new file mode 100644
> index 0000000000..5980090b29
> --- /dev/null
> +++ b/include/hw/i386/x86.h
> @@ -0,0 +1,97 @@
> +/*
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITH=
OUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_I386_X86_H
> +#define HW_I386_X86_H
> +
> +#include "qemu-common.h"
> +#include "exec/hwaddr.h"
> +#include "qemu/notify.h"
> +
> +#include "hw/boards.h"
> +#include "hw/nmi.h"
> +
> +typedef struct {
> +    /*< private >*/
> +    MachineClass parent;
> +
> +    /*< public >*/
> +
> +    /* Enables contiguous-apic-ID mode */
> +    bool compat_apic_id_mode;
> +} X86MachineClass;
> +
> +typedef struct {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +
> +    /* Pointers to devices and objects: */
> +    ISADevice *rtc;
> +    FWCfgState *fw_cfg;
> +    qemu_irq *gsi;
> +    GMappedFile *initrd_mapped_file;
> +
> +    /* Configuration options: */
> +    uint64_t max_ram_below_4g;
> +
> +    /* RAM information (sizes, addresses, configuration): */
> +    ram_addr_t below_4g_mem_size, above_4g_mem_size;
> +
> +    /* CPU and apic information: */
> +    bool apic_xrupt_override;
> +    unsigned apic_id_limit;
> +    uint16_t boot_cpus;
> +    unsigned smp_dies;
> +
> +    /* Address space used by IOAPIC device. All IOAPIC interrupts
> +     * will be translated to MSI messages in the address space. */
> +    AddressSpace *ioapic_as;
> +} X86MachineState;
> +
> +#define X86_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
> +
> +#define TYPE_X86_MACHINE   MACHINE_TYPE_NAME("x86")
> +#define X86_MACHINE(obj) \
> +    OBJECT_CHECK(X86MachineState, (obj), TYPE_X86_MACHINE)
> +#define X86_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(X86MachineClass, obj, TYPE_X86_MACHINE)
> +#define X86_MACHINE_CLASS(class) \
> +    OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
> +
> +uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> +                                    unsigned int cpu_index);
> +
> +void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
> +void x86_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)=
;
> +void x86_smp_parse(MachineState *ms, QemuOpts *opts);
> +void x86_nmi(NMIState *n, int cpu_index, Error **errp);
> +
> +CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
> +                                             unsigned cpu_index);
> +int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
> +const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms);
> +
> +void x86_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
> +
> +void load_linux(X86MachineState *x86ms,

Maybe rename x86_load_linux()?

> +                FWCfgState *fw_cfg,
> +                unsigned acpi_data_size,
> +                bool linuxboot_dma_enabled,
> +                bool pvh_enabled);
> +
> +#endif
>=20

Patch looks good, however I'd split it as:

1/ rename functions x86_*
2/ export functions, add "hw/i386/x86.h"
3/ move functions to hw/i386/x86.c
4/ add/use X86MachineState

Anyhow if the maintainer is happy as it:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

