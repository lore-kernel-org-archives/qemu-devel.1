Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BF720729
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLAFc0dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BF720729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k55dw-0001Nj-As
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 07:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k55cV-000843-Sb
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k55cS-0006iw-Cn
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597057530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ya60Zz6uhTlDLe9oOXdEuXrAEO6hrNjBI/o7V3Ukz7g=;
 b=hLAFc0dxtHNZedNrXOfAoFqJ13rWWhAXbsRgBIPP5TWv/7veqdkkrz1ufZJih2GcjTgbf+
 V27APNjHPw5sYpIxxSFlHp+zthnAM0/cxEOeW5KWa5ugZ7Z9CBzw2+CyeRTP4ShL2mT4nL
 3ofceBuNL3xsFbZ8ibkipo/low+HyAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-T-xc6igHOHm0De5qHH85VA-1; Mon, 10 Aug 2020 07:05:26 -0400
X-MC-Unique: T-xc6igHOHm0De5qHH85VA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37977800470;
 Mon, 10 Aug 2020 11:05:25 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C18B66FEFE;
 Mon, 10 Aug 2020 11:05:23 +0000 (UTC)
Date: Mon, 10 Aug 2020 13:05:21 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH 6/7] hw/arm/virt: spe: Add SPE fdt binding for virt machine
Message-ID: <20200810110521.4hodliv4tl64v463@kamzik.brq.redhat.com>
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <1663d06172cffa723e00893837ba04634f061fc8.1596768588.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1663d06172cffa723e00893837ba04634f061fc8.1596768588.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:35:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 07, 2020 at 08:10:36AM +0000, Haibo Xu wrote:
> Add a virtual SPE device for virt machine while using PPI 
> 5 for SPE overflow interrupt number.

Any reason PPI 5 was selected?

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

Please look at [1]. I've refactored fdt_add_pmu_nodes(), so it no longer
makes a good pattern for this function.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg727588.html


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

You didn't add any compat code, which means all virt machine types are now
getting an SPE FDT node, ACPI table change, and, most importantly, PPI 5
has gone from unallocated to allocated. We definitely need compat code.

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

Did you test with a userspace irqchip?

>          if (switched_level) {
>              qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
>                            __func__, switched_level);
> -- 
> 2.17.1
> 
>

Thanks,
drew


