Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D86C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC8C21019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3GZrp4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC8C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57753 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOm6j-0006Dn-9T
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:41:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOm2b-0002mZ-MR
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOm2Z-0007Wz-Os
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:37:05 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:38443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOm2Z-0007Vz-D4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:37:03 -0400
Received: by mail-lj1-x22f.google.com with SMTP id 14so2590484ljj.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JlW5hMAVo7dXfnwYR6/5YjQVaCGJf+dyyquJjWtwQGA=;
	b=S3GZrp4Cvshf6MgqFFvrMNDGhN8RY65/GEfcdXE5NsCS2K5MFHmvUbOOuZo11wlyS3
	pJ6RaoTYuI+W6INdO8xqOOQD6p7y/dpNe8v+rW7sDfEA+15/yh2RfcvNIM6oa2ohjpEJ
	9M1PgxT/uVs1EvXLTsdUYp3RwXCdtRalaZeghCsp64Ju5LLKeRMT/gMcO8l3/3rg/azP
	EvzKfX+e6zHIDXKOGltqDZ4PSfDxpfcKtiN1LcHVdJCV0rCsS2yQjmcAOLtOQvHntIuZ
	OV30Zp7EfaSixP3KJ/ZNnpotZmVSWnURPENJLFEKFtGICdZdatK2Gf7dA1OyNLcZOrKE
	pZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JlW5hMAVo7dXfnwYR6/5YjQVaCGJf+dyyquJjWtwQGA=;
	b=FCIogN67J9zYVSgUe43/rJkdpi5ZAtGo+caIAc/oBJfXd5xZudKoHh4iKLYmpOtzdr
	Hg9f3DMDS6IM9VXRSPPDHFpzpUhH+tAlZ7fgJ6I7tXiF/ib7oxh4Mp4gHxE8X0tX1glo
	MfqdXbLGIVeZlPkvXtOLRK1iCku5gDT5o1Vi2VYO/AQ7VrLBAw2OiPKyiJS8nB4viq+E
	GXoiUPu81f+k2n8ioZXaoG732S8Hua3kPr3VU/u99VwArul96HhDBvIZNtyl8wKoGFLK
	zrB/uv7kLELPjo8B0P38AbIRFXgd4JNaErwZ9Nh7tLgFg/+NA2OfSQFb01PW3n/hSmyH
	ItgA==
X-Gm-Message-State: APjAAAUvonjkjduDG569tGIrjSUshSo9WfnboxKd8qsrimR7rarl8mGj
	x7eVq1TSQZJIFJhH96Kj7g1oqomVh1jc57ukpzs=
X-Google-Smtp-Source: APXvYqxUPGXBSyzP94gAzgYCaBecM6HL7rOdNmJkM6G2Mhi0KebH3fx4603Mhm3Yn40GIF70Wzg58DMm0Vu+J78gGHk=
X-Received: by 2002:a2e:824b:: with SMTP id j11mr2822040ljh.197.1557419822008; 
	Thu, 09 May 2019 09:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
	<1557131596-25403-3-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1557131596-25403-3-git-send-email-like.xu@linux.intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 09:34:54 -0700
Message-ID: <CAKmqyKNa6v6keC1Ls1GpBaEQi-n69Xb7ZY52rBpMZvX5QEXOew@mail.gmail.com>
To: Like Xu <like.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::22f
Subject: Re: [Qemu-devel] [PATCH v2 02/10] cpu/topology: related call chains
 refactoring to pass MachineState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 6, 2019 at 1:34 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> It's recommended to access smp variables via MachineState
> as an incoming parameter. This approach applies on legacy
> smbios_*_tables*(), *_machine_reset(), *__hot_add_cpu()
> and related *_create_cpu() for later smp variables usages.
>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/virt.c                |  2 +-
>  hw/hppa/machine.c            |  2 +-
>  hw/i386/pc.c                 |  9 ++++-----
>  hw/mips/mips_malta.c         | 21 +++++++++++----------
>  hw/ppc/pnv.c                 |  3 +--
>  hw/ppc/spapr.c               |  3 +--
>  hw/s390x/s390-virtio-ccw.c   |  6 +++---
>  hw/smbios/smbios.c           | 26 +++++++++++++++-----------
>  include/hw/boards.h          |  4 ++--
>  include/hw/firmware/smbios.h |  5 +++--
>  include/hw/i386/pc.h         |  2 +-
>  qmp.c                        |  2 +-
>  vl.c                         |  2 +-
>  13 files changed, 45 insertions(+), 42 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 16ba67f..1b02ba4 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1290,7 +1290,7 @@ static void virt_build_smbios(VirtMachineState *vms)
>                          vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
>                          true, SMBIOS_ENTRY_POINT_30);
>
> -    smbios_get_tables(NULL, 0, &smbios_tables, &smbios_tables_len,
> +    smbios_get_tables(MACHINE(vms), NULL, 0, &smbios_tables, &smbios_tables_len,
>                        &smbios_anchor, &smbios_anchor_len);
>
>      if (smbios_anchor) {
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index d1b1d3c..416e67b 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -240,7 +240,7 @@ static void machine_hppa_init(MachineState *machine)
>      cpu[0]->env.gr[21] = smp_cpus;
>  }
>
> -static void hppa_machine_reset(void)
> +static void hppa_machine_reset(MachineState *ms)
>  {
>      int i;
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d98b737..9bcd867 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -962,7 +962,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>      /* tell smbios about cpuid version and features */
>      smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
>
> -    smbios_tables = smbios_get_table_legacy(&smbios_tables_len);
> +    smbios_tables = smbios_get_table_legacy(ms, &smbios_tables_len);
>      if (smbios_tables) {
>          fw_cfg_add_bytes(pcms->fw_cfg, FW_CFG_SMBIOS_ENTRIES,
>                           smbios_tables, smbios_tables_len);
> @@ -979,7 +979,7 @@ static void pc_build_smbios(PCMachineState *pcms)
>              array_count++;
>          }
>      }
> -    smbios_get_tables(mem_array, array_count,
> +    smbios_get_tables(ms, mem_array, array_count,
>                        &smbios_tables, &smbios_tables_len,
>                        &smbios_anchor, &smbios_anchor_len);
>      g_free(mem_array);
> @@ -1534,9 +1534,8 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
>      error_propagate(errp, local_err);
>  }
>
> -void pc_hot_add_cpu(const int64_t id, Error **errp)
> +void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
>  {
> -    MachineState *ms = MACHINE(qdev_get_machine());
>      int64_t apic_id = x86_cpu_apic_id_from_index(id);
>      Error *local_err = NULL;
>
> @@ -2622,7 +2621,7 @@ static void pc_machine_initfn(Object *obj)
>      pc_system_flash_create(pcms);
>  }
>
> -static void pc_machine_reset(void)
> +static void pc_machine_reset(MachineState *machine)
>  {
>      CPUState *cs;
>      X86CPU *cpu;
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 439665a..534e705 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1124,14 +1124,14 @@ static void main_cpu_reset(void *opaque)
>      }
>  }
>
> -static void create_cpu_without_cps(const char *cpu_type,
> +static void create_cpu_without_cps(MachineState *ms, const char *cpu_type,
>                                     qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
>      CPUMIPSState *env;
>      MIPSCPU *cpu;
>      int i;
>
> -    for (i = 0; i < smp_cpus; i++) {
> +    for (i = 0; i < ms->smp.cpus; i++) {
>          cpu = MIPS_CPU(cpu_create(cpu_type));
>
>          /* Init internal devices */
> @@ -1146,7 +1146,7 @@ static void create_cpu_without_cps(const char *cpu_type,
>      *cbus_irq = env->irq[4];
>  }
>
> -static void create_cps(MaltaState *s, const char *cpu_type,
> +static void create_cps(MachineState *ms, MaltaState *s, const char *cpu_type,
>                         qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
>      Error *err = NULL;
> @@ -1155,7 +1155,7 @@ static void create_cps(MaltaState *s, const char *cpu_type,
>      qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
>
>      object_property_set_str(OBJECT(s->cps), cpu_type, "cpu-type", &err);
> -    object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
> +    object_property_set_int(OBJECT(s->cps), ms->smp.cpus, "num-vp", &err);
>      object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
>      if (err != NULL) {
>          error_report("%s", error_get_pretty(err));
> @@ -1168,13 +1168,14 @@ static void create_cps(MaltaState *s, const char *cpu_type,
>      *cbus_irq = NULL;
>  }
>
> -static void mips_create_cpu(MaltaState *s, const char *cpu_type,
> -                            qemu_irq *cbus_irq, qemu_irq *i8259_irq)
> +static void mips_create_cpu(MachineState *ms, MaltaState *s,
> +                            const char *cpu_type, qemu_irq *cbus_irq,
> +                            qemu_irq *i8259_irq)
>  {
> -    if ((smp_cpus > 1) && cpu_supports_cps_smp(cpu_type)) {
> -        create_cps(s, cpu_type, cbus_irq, i8259_irq);
> +    if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(cpu_type)) {
> +        create_cps(ms, s, cpu_type, cbus_irq, i8259_irq);
>      } else {
> -        create_cpu_without_cps(cpu_type, cbus_irq, i8259_irq);
> +        create_cpu_without_cps(ms, cpu_type, cbus_irq, i8259_irq);
>      }
>  }
>
> @@ -1218,7 +1219,7 @@ void mips_malta_init(MachineState *machine)
>      qdev_init_nofail(dev);
>
>      /* create CPU */
> -    mips_create_cpu(s, machine->cpu_type, &cbus_irq, &i8259_irq);
> +    mips_create_cpu(machine, s, machine->cpu_type, &cbus_irq, &i8259_irq);
>
>      /* allocate RAM */
>      if (ram_size > 2 * GiB) {
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index dfb4ea5..1e8c505 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -520,9 +520,8 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
>      }
>  }
>
> -static void pnv_reset(void)
> +static void pnv_reset(MachineState *machine)
>  {
> -    MachineState *machine = MACHINE(qdev_get_machine());
>      PnvMachineState *pnv = PNV_MACHINE(machine);
>      void *fdt;
>      Object *obj;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2ef3ce4..7fb34de 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1689,9 +1689,8 @@ static int spapr_reset_drcs(Object *child, void *opaque)
>      return 0;
>  }
>
> -static void spapr_machine_reset(void)
> +static void spapr_machine_reset(MachineState *machine)
>  {
> -    MachineState *machine = MACHINE(qdev_get_machine());
>      SpaprMachineState *spapr = SPAPR_MACHINE(machine);
>      PowerPCCPU *first_ppc_cpu;
>      uint32_t rtas_limit;
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index bbc6e8f..ed1fe7a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -338,7 +338,7 @@ static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>  }
>
> -static void s390_machine_reset(void)
> +static void s390_machine_reset(MachineState *machine)
>  {
>      enum s390_reset reset_type;
>      CPUState *cs, *t;
> @@ -439,9 +439,9 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
>      return NULL;
>  }
>
> -static void s390_hot_add_cpu(const int64_t id, Error **errp)
> +static void s390_hot_add_cpu(MachineState *machine,
> +                             const int64_t id, Error **errp)
>  {
> -    MachineState *machine = MACHINE(qdev_get_machine());
>      ObjectClass *oc;
>
>      g_assert(machine->possible_cpus->cpus[0].cpu);
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 47be907..0bf9a01 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -26,6 +26,7 @@
>  #include "sysemu/cpus.h"
>  #include "hw/firmware/smbios.h"
>  #include "hw/loader.h"
> +#include "hw/boards.h"
>  #include "exec/cpu-common.h"
>  #include "smbios_build.h"
>
> @@ -340,9 +341,10 @@ static void smbios_register_config(void)
>
>  opts_init(smbios_register_config);
>
> -static void smbios_validate_table(void)
> +static void smbios_validate_table(MachineState *ms)
>  {
> -    uint32_t expect_t4_count = smbios_legacy ? smp_cpus : smbios_smp_sockets;
> +    uint32_t expect_t4_count = smbios_legacy ?
> +                                        ms->smp.cpus : smbios_smp_sockets;
>
>      if (smbios_type4_count && smbios_type4_count != expect_t4_count) {
>          error_report("Expected %d SMBIOS Type 4 tables, got %d instead",
> @@ -427,7 +429,7 @@ static void smbios_build_type_1_fields(void)
>      }
>  }
>
> -uint8_t *smbios_get_table_legacy(size_t *length)
> +uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length)
>  {
>      if (!smbios_legacy) {
>          *length = 0;
> @@ -437,7 +439,7 @@ uint8_t *smbios_get_table_legacy(size_t *length)
>      if (!smbios_immutable) {
>          smbios_build_type_0_fields();
>          smbios_build_type_1_fields();
> -        smbios_validate_table();
> +        smbios_validate_table(ms);
>          smbios_immutable = true;
>      }
>      *length = smbios_entries_len;
> @@ -569,7 +571,7 @@ static void smbios_build_type_3_table(void)
>      SMBIOS_BUILD_TABLE_POST;
>  }
>
> -static void smbios_build_type_4_table(unsigned instance)
> +static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>  {
>      char sock_str[128];
>
> @@ -596,8 +598,8 @@ static void smbios_build_type_4_table(unsigned instance)
>      SMBIOS_TABLE_SET_STR(4, serial_number_str, type4.serial);
>      SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
>      SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
> -    t->core_count = t->core_enabled = smp_cores;
> -    t->thread_count = smp_threads;
> +    t->core_count = t->core_enabled = ms->smp.cores;
> +    t->thread_count = ms->smp.threads;
>      t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
>      t->processor_family2 = cpu_to_le16(0x01); /* Other */
>
> @@ -838,7 +840,8 @@ static void smbios_entry_point_setup(void)
>      }
>  }
>
> -void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
> +void smbios_get_tables(MachineState *ms,
> +                       const struct smbios_phys_mem_area *mem_array,
>                         const unsigned int mem_array_size,
>                         uint8_t **tables, size_t *tables_len,
>                         uint8_t **anchor, size_t *anchor_len)
> @@ -857,11 +860,12 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
>          smbios_build_type_2_table();
>          smbios_build_type_3_table();
>
> -        smbios_smp_sockets = DIV_ROUND_UP(smp_cpus, smp_cores * smp_threads);
> +        smbios_smp_sockets = DIV_ROUND_UP(ms->smp.cpus,
> +                                          ms->smp.cores * ms->smp.threads);
>          assert(smbios_smp_sockets >= 1);
>
>          for (i = 0; i < smbios_smp_sockets; i++) {
> -            smbios_build_type_4_table(i);
> +            smbios_build_type_4_table(ms, i);
>          }
>
>          smbios_build_type_11_table();
> @@ -887,7 +891,7 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
>          smbios_build_type_38_table();
>          smbios_build_type_127_table();
>
> -        smbios_validate_table();
> +        smbios_validate_table(ms);
>          smbios_entry_point_setup();
>          smbios_immutable = true;
>      }
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index dc89c6d..a7eb0bf 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -171,8 +171,8 @@ struct MachineClass {
>      const char *deprecation_reason;
>
>      void (*init)(MachineState *state);
> -    void (*reset)(void);
> -    void (*hot_add_cpu)(const int64_t id, Error **errp);
> +    void (*reset)(MachineState *state);
> +    void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **errp);
>      int (*kvm_type)(MachineState *machine, const char *arg);
>
>      BlockInterfaceType block_default_type;
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index 6fef32a..02a0ced 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -268,8 +268,9 @@ void smbios_set_cpuid(uint32_t version, uint32_t features);
>  void smbios_set_defaults(const char *manufacturer, const char *product,
>                           const char *version, bool legacy_mode,
>                           bool uuid_encoded, SmbiosEntryPointType ep_type);
> -uint8_t *smbios_get_table_legacy(size_t *length);
> -void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
> +uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length);
> +void smbios_get_tables(MachineState *ms,
> +                       const struct smbios_phys_mem_area *mem_array,
>                         const unsigned int mem_array_size,
>                         uint8_t **tables, size_t *tables_len,
>                         uint8_t **anchor, size_t *anchor_len);
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 43df723..ce3c229 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -186,7 +186,7 @@ void pc_register_ferr_irq(qemu_irq irq);
>  void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>
>  void pc_cpus_init(PCMachineState *pcms);
> -void pc_hot_add_cpu(const int64_t id, Error **errp);
> +void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
>
>  void pc_guest_info_init(PCMachineState *pcms);
>
> diff --git a/qmp.c b/qmp.c
> index b92d62c..ba7aa04 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -123,7 +123,7 @@ void qmp_cpu_add(int64_t id, Error **errp)
>
>      mc = MACHINE_GET_CLASS(current_machine);
>      if (mc->hot_add_cpu) {
> -        mc->hot_add_cpu(id, errp);
> +        mc->hot_add_cpu(current_machine, id, errp);
>      } else {
>          error_setg(errp, "Not supported");
>      }
> diff --git a/vl.c b/vl.c
> index 43fd247..34f05b2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1706,7 +1706,7 @@ void qemu_system_reset(ShutdownCause reason)
>      cpu_synchronize_all_states();
>
>      if (mc && mc->reset) {
> -        mc->reset();
> +        mc->reset(current_machine);
>      } else {
>          qemu_devices_reset();
>      }
> --
> 1.8.3.1
>

