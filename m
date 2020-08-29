Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5C9C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6868F204FD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXVbaxea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6868F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2oH-0000OF-Kr
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kC2gA-0007RA-5T
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:22:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kC2g7-0005fv-4K
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598714521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsoHPe0fo4kmuIZOpXevYhG1xyEG71KI6rwlL1Gqtac=;
 b=NXVbaxeay9Pp7SIMoZXfSxSiaF4jEM3W1/Thj4GH8eNom3GGiYCsajD7wtUJkXfAsgkpS3
 +iHx/rvYJaj2noteyWeb4cGe/Bm/+S1oQOtVpU7s/Ab6ZTUkPaJZZlbRYh+1FxnAQRpJxo
 Ja3x3O+UbObIGe3SEVoF0KsyC1onnTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-B9mG1uoxPgS6ntTnljdy1A-1; Sat, 29 Aug 2020 11:21:59 -0400
X-MC-Unique: B9mG1uoxPgS6ntTnljdy1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E196B802B6A;
 Sat, 29 Aug 2020 15:21:57 +0000 (UTC)
Received: from [10.36.112.112] (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43D895D9D2;
 Sat, 29 Aug 2020 15:21:56 +0000 (UTC)
Subject: Re: [PATCH 6/7] hw/arm/virt: spe: Add SPE fdt binding for virt machine
To: Haibo Xu <haibo.xu@linaro.org>, peter.maydell@linaro.org
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <1663d06172cffa723e00893837ba04634f061fc8.1596768588.git.haibo.xu@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4e6b3ee2-7f81-7c72-c4a9-0e8d330215ab@redhat.com>
Date: Sat, 29 Aug 2020 17:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1663d06172cffa723e00893837ba04634f061fc8.1596768588.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/29 11:22:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Haibo,

On 8/7/20 10:10 AM, Haibo Xu wrote:
> Add a virtual SPE device for virt machine while using PPI 
> 5 for SPE overflow interrupt number.
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c    |  3 +++ 
>  hw/arm/virt.c               | 42 +++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/acpi-defs.h |  1 + 
>  include/hw/arm/virt.h       |  1 + 
>  target/arm/cpu.c            |  2 ++
>  target/arm/cpu.h            |  2 ++
>  target/arm/kvm.c            |  6 ++++++
>  7 files changed, 57 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 91f0df7b13..5073ba22a5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -666,6 +666,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
>              gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
>          }
> +        if (arm_feature(&armcpu->env, ARM_FEATURE_SPE)) {
> +            gicc->spe_interrupt = cpu_to_le32(PPI(VIRTUAL_SPE_IRQ));
> +        }
>          if (vms->virt) {
>              gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GIC_MAINT_IRQ));
>          }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ecfee362a1..c40819705d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -555,6 +555,42 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>      }
>  }
> 
> +static void fdt_add_spe_nodes(const VirtMachineState *vms)
> +{
> +    CPUState *cpu;
> +    ARMCPU *armcpu;
> +    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
> +
> +    CPU_FOREACH(cpu) {
> +        armcpu = ARM_CPU(cpu);
> +        if (!arm_feature(&armcpu->env, ARM_FEATURE_SPE)) {
> +            return;
> +        }
> +        if (kvm_enabled()) {
> +            if (kvm_irqchip_in_kernel()) {
> +                kvm_arm_spe_set_irq(cpu, PPI(VIRTUAL_SPE_IRQ));
> +            }
> +            kvm_arm_spe_init(cpu);
> +        }
> +    }
> +
> +    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +        irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
> +                             GIC_FDT_IRQ_PPI_CPU_WIDTH,
> +                             (1 << vms->smp_cpus) - 1);
> +    }
> +
> +    armcpu = ARM_CPU(qemu_get_cpu(0));
> +    qemu_fdt_add_subnode(vms->fdt, "/spe");
> +    if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
> +        const char compat[] = "arm,statistical-profiling-extension-v1";
> +        qemu_fdt_setprop(vms->fdt, "/spe", "compatible",
> +                         compat, sizeof(compat));
> +        qemu_fdt_setprop_cells(vms->fdt, "/spe", "interrupts",
> +                               GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_SPE_IRQ, irqflags);
> +    }
> +}
> +
>  static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>  {
>      DeviceState *dev;
> @@ -727,6 +763,10 @@ static void create_gic(VirtMachineState *vms)
>                                      qdev_get_gpio_in(vms->gic, ppibase
>                                                       + VIRTUAL_PMU_IRQ));
> 
> +        qdev_connect_gpio_out_named(cpudev, "spe-interrupt", 0,
> +                                    qdev_get_gpio_in(vms->gic, ppibase
> +                                                     + VIRTUAL_SPE_IRQ));
> +
>          sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
>          sysbus_connect_irq(gicbusdev, i + smp_cpus,
>                             qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> @@ -1915,6 +1955,8 @@ static void machvirt_init(MachineState *machine)
> 
>      fdt_add_pmu_nodes(vms);
> 
> +    fdt_add_spe_nodes(vms);
> +
>      create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
> 
>      if (vms->secure) {
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 38a42f409a..56a7f38ae4 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -302,6 +302,7 @@ struct AcpiMadtGenericCpuInterface {
>      uint32_t vgic_interrupt;
>      uint64_t gicr_base_address;
>      uint64_t arm_mpidr;
> +    uint16_t spe_interrupt; /* ACPI 6.3 */
This does not work for me.
You miss 2 uint8_t fields inbetween arm_mpdir and spe_interrupt:
Processor Power Efficiency Class and Reserved.

At the moment arm_spe_acpi_register_device() silently fails on guest
side since
gicc->header.length < ACPI_MADT_GICC_SPE

Thanks

Eric

>  } QEMU_PACKED;
> 
>  typedef struct AcpiMadtGenericCpuInterface AcpiMadtGenericCpuInterface;
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index dff67e1bef..56c83224d2 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -49,6 +49,7 @@
>  #define ARCH_TIMER_NS_EL1_IRQ 14
>  #define ARCH_TIMER_NS_EL2_IRQ 10
> 
> +#define VIRTUAL_SPE_IRQ 5
>  #define VIRTUAL_PMU_IRQ 7
> 
>  #define PPI(irq) ((irq) + 16)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 40768b4d19..67ab0089fd 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1038,6 +1038,8 @@ static void arm_cpu_initfn(Object *obj)
>                               "gicv3-maintenance-interrupt", 1);
>      qdev_init_gpio_out_named(DEVICE(cpu), &cpu->pmu_interrupt,
>                               "pmu-interrupt", 1);
> +    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->spe_interrupt,
> +                             "spe-interrupt", 1);
>  #endif
> 
>      /* DTB consumers generally don't in fact care what the 'compatible'
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index fe0ac14386..4bf8591df8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -790,6 +790,8 @@ struct ARMCPU {
>      qemu_irq gicv3_maintenance_interrupt;
>      /* GPIO output for the PMU interrupt */
>      qemu_irq pmu_interrupt;
> +    /* GPIO output for the SPE interrupt */
> +    qemu_irq spe_interrupt;
> 
>      /* MemoryRegion to use for secure physical accesses */
>      MemoryRegion *secure_memory;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 58f991e890..ecafdda364 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -820,6 +820,12 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
>              switched_level &= ~KVM_ARM_DEV_PMU;
>          }
> 
> +        if (switched_level & KVM_ARM_DEV_SPE) {
> +            qemu_set_irq(cpu->spe_interrupt,
> +                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_SPE));
> +            switched_level &= ~KVM_ARM_DEV_SPE;
> +        }
> +
>          if (switched_level) {
>              qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
>                            __func__, switched_level);
> 


