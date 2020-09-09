Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C467FC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C69820732
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sedaQP0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C69820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFutj-0003Tn-T0
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 03:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFut7-0002vm-IU
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:51:29 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFut5-0000L8-As
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:51:29 -0400
Received: by mail-io1-xd43.google.com with SMTP id r25so2209509ioj.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z8cDTBCiMPSoC6W0ri66YE+1BCNxXKrLEKDARKazsVU=;
 b=sedaQP0+lXDKcbhXEOEuFe/59wVc4Cfq0+dtjc4GIzpjycVKy+qKXELoXxgz/t+OWW
 vRDsfy7jbFcBqlQNQ8opYtUR/ulJiOOyObGwKlPipVohAixbDF6sFtMPYWNJv+jW/kvY
 Nbf+mOrxCGqzk0S6iOanb3X786uh81Gi5KborIN8rcFVp8jjGrVxADpujQ8CNmf8R99T
 Q8sE77aKPXJnpkzD1LSoOtJd8yfyKwo1QDvUKq6UWp/OJzqOIjnbYjpyTXvuF08KbU96
 dZjGm0ZNTez4mDZMKMXAut6RAweeKtgPqOoagmLqf6dN2IXN7xSoL5i5DRQ9tqoM6Umv
 zY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z8cDTBCiMPSoC6W0ri66YE+1BCNxXKrLEKDARKazsVU=;
 b=VATE5gYlgGOwJiWCSw3yH0zioaiGX02q9EqGcWJvqNx7hYEZ/zpRQkHPV3nyMWcl6d
 DhQQfAIhRww/3H/EmwcTKZ0XxseX/OgHHTsd8YBN755Lf99+S4Vr6ngAgekFVSMi9ip4
 vZ3oGTjYgEuEk3gn01Zy8LUO44g7w6Y2xBSk8CKQciJHkx0gGRgdFVuxBH8qlZArz+n7
 pJtO0F1gKwbofr7FIhg7hBCdt4Xgof02O53CxE8CjauWaEsfa5oaYYy9eSkAInBSuwQt
 KEXpeVUsSKJ3lvVjdSX1k1hQLIqx4oTCjlO1NMO5WaYBcyXyaG2v4V/abRHLr8Rpfpuq
 GCxQ==
X-Gm-Message-State: AOAM531v49bOrLjqZCZ5UY6hp1Jev0kxqJdir/+VKm+aJJRx1ON7ML5O
 FlB6hg972hzgMBS/+nMDApTGtztAet+CcHYQqkCq
X-Google-Smtp-Source: ABdhPJwF/mOm0Ig9WGnxEWLF6Ww4/5/ZUXUIZTPqPk5S3xQSKYA4CVKxFu4pSUZqD50VZydKElwdwlNAeY7NGFOiH5A=
X-Received: by 2002:a05:6638:224e:: with SMTP id
 m14mr2899944jas.101.1599637885959; 
 Wed, 09 Sep 2020 00:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <c6ac607d2cd253de6a990538edfde7f86066f04f.1599549462.git.haibo.xu@linaro.org>
 <20200908111625.2wzzn7jh5wt4nnmu@kamzik.brq.redhat.com>
In-Reply-To: <20200908111625.2wzzn7jh5wt4nnmu@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Wed, 9 Sep 2020 15:51:14 +0800
Message-ID: <CAJc+Z1GCmf5fEjifa84O6jmfd6WCih1jT07AXb7vWFC7=sXfrA@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] hw/arm/virt: spe: Add SPE fdt binding for virt
 machine
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 19:16, Andrew Jones <drjones@redhat.com> wrote:
>
>
> This patch does much more than the summary "hw/arm/virt: spe: Add SPE fdt
> binding for virt machine" says it does. Please revise the summary.
>

Will revise it in v3.

Thanks,
Haibo

> On Tue, Sep 08, 2020 at 08:13:27AM +0000, Haibo Xu wrote:
> > Add a virtual SPE device for virt machine while using
> > PPI 5 for SPE overflow interrupt number which has already
> > selected in kvmtool.
> >
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > ---
> >  hw/arm/virt-acpi-build.c    |  3 +++
> >  hw/arm/virt.c               | 43 ++++++++++++++++++++++++++++++++++++-
> >  include/hw/acpi/acpi-defs.h |  3 +++
> >  include/hw/arm/virt.h       |  1 +
> >  target/arm/cpu.c            |  2 ++
> >  target/arm/cpu.h            |  2 ++
> >  6 files changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 9efd7a3881..3fd80fda53 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -665,6 +665,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >          if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
> >              gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
> >          }
> > +        if (cpu_isar_feature(aa64_spe, armcpu)) {
> > +            gicc->spe_interrupt = cpu_to_le32(PPI(VIRTUAL_SPE_IRQ));
> > +        }
> >          if (vms->virt) {
> >              gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GIC_MAINT_IRQ));
> >          }
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 6bacfb668d..bdb1ce925c 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -545,6 +545,32 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
> >      }
> >  }
> >
> > +static void fdt_add_spe_nodes(const VirtMachineState *vms)
> > +{
> > +    ARMCPU *armcpu = ARM_CPU(first_cpu);
> > +    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
> > +
> > +    if (!cpu_isar_feature(aa64_spe, armcpu)) {
> > +        assert(!object_property_get_bool(OBJECT(armcpu), "spe", NULL));
> > +        return;
> > +    }
> > +
> > +    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> > +        irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
> > +                             GIC_FDT_IRQ_PPI_CPU_WIDTH,
> > +                             (1 << vms->smp_cpus) - 1);
> > +    }
> > +
> > +    qemu_fdt_add_subnode(vms->fdt, "/spe");
> > +    if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
> > +        const char compat[] = "arm,statistical-profiling-extension-v1";
> > +        qemu_fdt_setprop(vms->fdt, "/spe", "compatible",
> > +                         compat, sizeof(compat));
> > +        qemu_fdt_setprop_cells(vms->fdt, "/spe", "interrupts",
> > +                               GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_SPE_IRQ, irqflags);
> > +    }
> > +}
> > +
> >  static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
> >  {
> >      DeviceState *dev;
> > @@ -717,6 +743,10 @@ static void create_gic(VirtMachineState *vms)
> >                                      qdev_get_gpio_in(vms->gic, ppibase
> >                                                       + VIRTUAL_PMU_IRQ));
> >
> > +        qdev_connect_gpio_out_named(cpudev, "spe-interrupt", 0,
> > +                                    qdev_get_gpio_in(vms->gic, ppibase
> > +                                                     + VIRTUAL_SPE_IRQ));
> > +
> >          sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> >          sysbus_connect_irq(gicbusdev, i + smp_cpus,
> >                             qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > @@ -1664,11 +1694,12 @@ static void finalize_gic_version(VirtMachineState *vms)
> >
> >  static void virt_cpu_post_init(VirtMachineState *vms)
> >  {
> > -    bool aarch64, pmu;
> > +    bool aarch64, pmu, spe;
> >      CPUState *cpu;
> >
> >      aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
> >      pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
> > +    spe = object_property_get_bool(OBJECT(first_cpu), "spe", NULL);
> >
> >      if (kvm_enabled()) {
> >          CPU_FOREACH(cpu) {
> > @@ -1679,6 +1710,14 @@ static void virt_cpu_post_init(VirtMachineState *vms)
> >                  }
> >                  kvm_arm_pmu_init(cpu);
> >              }
> > +
> > +            if (spe) {
> > +                assert(ARM_CPU(cpu)->has_spe == ON_OFF_AUTO_ON);
> > +                if (kvm_irqchip_in_kernel()) {
> > +                    kvm_arm_spe_set_irq(cpu, PPI(VIRTUAL_SPE_IRQ));
> > +                }
> > +                kvm_arm_spe_init(cpu);
>
> A later patch introduces userspace irqchip support. Should we avoid
> allowing it until then to avoid breaking bisection?
>

Yes, it's possible to break the bisection. To avoid it I think we can
move the above codes
block to a separate patch after adding the userspace irqchip support,
Or, just put the userspace
irqchip support patch before this patch. What's your opinion?

Thanks,
Haibo

> > +            }
> >          }
> >      } else {
> >          if (aarch64 && vms->highmem) {
> > @@ -1927,6 +1966,8 @@ static void machvirt_init(MachineState *machine)
> >
> >      fdt_add_pmu_nodes(vms);
> >
> > +    fdt_add_spe_nodes(vms);
> > +
> >      create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
> >
> >      if (vms->secure) {
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 38a42f409a..21e58f27c5 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -302,6 +302,9 @@ struct AcpiMadtGenericCpuInterface {
> >      uint32_t vgic_interrupt;
> >      uint64_t gicr_base_address;
> >      uint64_t arm_mpidr;
> > +    uint8_t  efficiency_class;
> > +    uint8_t  reserved2[1];
> > +    uint16_t spe_interrupt; /* ACPI 6.3 */
> >  } QEMU_PACKED;
> >
> >  typedef struct AcpiMadtGenericCpuInterface AcpiMadtGenericCpuInterface;
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > index 72c269aaa5..6013b6d535 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -49,6 +49,7 @@
> >  #define ARCH_TIMER_NS_EL1_IRQ 14
> >  #define ARCH_TIMER_NS_EL2_IRQ 10
> >
> > +#define VIRTUAL_SPE_IRQ 5
> >  #define VIRTUAL_PMU_IRQ 7
> >
> >  #define PPI(irq) ((irq) + 16)
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index f211958eaa..786cc6134c 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1041,6 +1041,8 @@ static void arm_cpu_initfn(Object *obj)
> >                               "gicv3-maintenance-interrupt", 1);
> >      qdev_init_gpio_out_named(DEVICE(cpu), &cpu->pmu_interrupt,
> >                               "pmu-interrupt", 1);
> > +    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->spe_interrupt,
> > +                             "spe-interrupt", 1);
> >  #endif
> >
> >      /* DTB consumers generally don't in fact care what the 'compatible'
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index baf2bbcee8..395a1e5df8 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -800,6 +800,8 @@ struct ARMCPU {
> >      qemu_irq gicv3_maintenance_interrupt;
> >      /* GPIO output for the PMU interrupt */
> >      qemu_irq pmu_interrupt;
> > +    /* GPIO output for the SPE interrupt */
> > +    qemu_irq spe_interrupt;
> >
> >      /* MemoryRegion to use for secure physical accesses */
> >      MemoryRegion *secure_memory;
> > --
> > 2.17.1
> >
> >
>
> Otherwise
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>

