Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382FFC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66382087D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKWvtbM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66382087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbdc-0007WX-RA
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbc7-00068g-Bs
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:16:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29113
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbc4-0006zC-Jt
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599563795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqjlsphl2j3znMxyXVEcKoaK8XPXKbhFnNOoXlqt2qo=;
 b=ZKWvtbM9ivfLZXnfheoXx7JZ3kbnj1Ax4fscb/w7EWintHXswgbUYCS9XIL9L5DGdNlPe9
 bOleSDk9zGmOTFbUcPyzt8zIyJVoZ4T3mcWG+1BF6JPXmd5OmH3VW/pA2bfn/uTQnmK/K+
 ZaQFnPqnlx6c0XM6zAlkveWQ5/VL2BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-4thXYxsZNLek1_8fb-0fHA-1; Tue, 08 Sep 2020 07:16:32 -0400
X-MC-Unique: 4thXYxsZNLek1_8fb-0fHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C74B18015A6;
 Tue,  8 Sep 2020 11:16:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B51E45C1BB;
 Tue,  8 Sep 2020 11:16:28 +0000 (UTC)
Date: Tue, 8 Sep 2020 13:16:25 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v2 09/12] hw/arm/virt: spe: Add SPE fdt binding for virt
 machine
Message-ID: <20200908111625.2wzzn7jh5wt4nnmu@kamzik.brq.redhat.com>
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <c6ac607d2cd253de6a990538edfde7f86066f04f.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <c6ac607d2cd253de6a990538edfde7f86066f04f.1599549462.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This patch does much more than the summary "hw/arm/virt: spe: Add SPE fdt
binding for virt machine" says it does. Please revise the summary.

On Tue, Sep 08, 2020 at 08:13:27AM +0000, Haibo Xu wrote:
> Add a virtual SPE device for virt machine while using
> PPI 5 for SPE overflow interrupt number which has already
> selected in kvmtool.
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c    |  3 +++
>  hw/arm/virt.c               | 43 ++++++++++++++++++++++++++++++++++++-
>  include/hw/acpi/acpi-defs.h |  3 +++
>  include/hw/arm/virt.h       |  1 +
>  target/arm/cpu.c            |  2 ++
>  target/arm/cpu.h            |  2 ++
>  6 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9efd7a3881..3fd80fda53 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -665,6 +665,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
>              gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
>          }
> +        if (cpu_isar_feature(aa64_spe, armcpu)) {
> +            gicc->spe_interrupt = cpu_to_le32(PPI(VIRTUAL_SPE_IRQ));
> +        }
>          if (vms->virt) {
>              gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GIC_MAINT_IRQ));
>          }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 6bacfb668d..bdb1ce925c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -545,6 +545,32 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>      }
>  }
>  
> +static void fdt_add_spe_nodes(const VirtMachineState *vms)
> +{
> +    ARMCPU *armcpu = ARM_CPU(first_cpu);
> +    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
> +
> +    if (!cpu_isar_feature(aa64_spe, armcpu)) {
> +        assert(!object_property_get_bool(OBJECT(armcpu), "spe", NULL));
> +        return;
> +    }
> +
> +    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +        irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
> +                             GIC_FDT_IRQ_PPI_CPU_WIDTH,
> +                             (1 << vms->smp_cpus) - 1);
> +    }
> +
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
> @@ -717,6 +743,10 @@ static void create_gic(VirtMachineState *vms)
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
> @@ -1664,11 +1694,12 @@ static void finalize_gic_version(VirtMachineState *vms)
>  
>  static void virt_cpu_post_init(VirtMachineState *vms)
>  {
> -    bool aarch64, pmu;
> +    bool aarch64, pmu, spe;
>      CPUState *cpu;
>  
>      aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
>      pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
> +    spe = object_property_get_bool(OBJECT(first_cpu), "spe", NULL);
>  
>      if (kvm_enabled()) {
>          CPU_FOREACH(cpu) {
> @@ -1679,6 +1710,14 @@ static void virt_cpu_post_init(VirtMachineState *vms)
>                  }
>                  kvm_arm_pmu_init(cpu);
>              }
> +
> +            if (spe) {
> +                assert(ARM_CPU(cpu)->has_spe == ON_OFF_AUTO_ON);
> +                if (kvm_irqchip_in_kernel()) {
> +                    kvm_arm_spe_set_irq(cpu, PPI(VIRTUAL_SPE_IRQ));
> +                }
> +                kvm_arm_spe_init(cpu);

A later patch introduces userspace irqchip support. Should we avoid
allowing it until then to avoid breaking bisection?

> +            }
>          }
>      } else {
>          if (aarch64 && vms->highmem) {
> @@ -1927,6 +1966,8 @@ static void machvirt_init(MachineState *machine)
>  
>      fdt_add_pmu_nodes(vms);
>  
> +    fdt_add_spe_nodes(vms);
> +
>      create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
>  
>      if (vms->secure) {
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 38a42f409a..21e58f27c5 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -302,6 +302,9 @@ struct AcpiMadtGenericCpuInterface {
>      uint32_t vgic_interrupt;
>      uint64_t gicr_base_address;
>      uint64_t arm_mpidr;
> +    uint8_t  efficiency_class;
> +    uint8_t  reserved2[1];
> +    uint16_t spe_interrupt; /* ACPI 6.3 */
>  } QEMU_PACKED;
>  
>  typedef struct AcpiMadtGenericCpuInterface AcpiMadtGenericCpuInterface;
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 72c269aaa5..6013b6d535 100644
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
> index f211958eaa..786cc6134c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1041,6 +1041,8 @@ static void arm_cpu_initfn(Object *obj)
>                               "gicv3-maintenance-interrupt", 1);
>      qdev_init_gpio_out_named(DEVICE(cpu), &cpu->pmu_interrupt,
>                               "pmu-interrupt", 1);
> +    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->spe_interrupt,
> +                             "spe-interrupt", 1);
>  #endif
>  
>      /* DTB consumers generally don't in fact care what the 'compatible'
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index baf2bbcee8..395a1e5df8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -800,6 +800,8 @@ struct ARMCPU {
>      qemu_irq gicv3_maintenance_interrupt;
>      /* GPIO output for the PMU interrupt */
>      qemu_irq pmu_interrupt;
> +    /* GPIO output for the SPE interrupt */
> +    qemu_irq spe_interrupt;
>  
>      /* MemoryRegion to use for secure physical accesses */
>      MemoryRegion *secure_memory;
> -- 
> 2.17.1
> 
> 

Otherwise

Reviewed-by: Andrew Jones <drjones@redhat.com>


