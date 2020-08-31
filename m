Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE65C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 06:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B0B20738
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 06:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzdgAFPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B0B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCdIx-0007OK-0l
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 02:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kCdIE-0006k3-Ic
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 02:27:50 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kCdIC-0008OA-GS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 02:27:50 -0400
Received: by mail-io1-xd43.google.com with SMTP id g13so4731354ioo.9
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 23:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IFbepArYBYiEtT18n8i3X49y/Ch7pBYSVm7oj4RrqyY=;
 b=qzdgAFPxGsNa2O+LVKL4mUf7OhicqG0Dbvf24bPn6o1xTvQedXEcippVK4OnIb1X1a
 IgbLc++5+UqcW10jGhfhCqnYtyCxFJAH7eB1QuCQThx1Uu0MHS6Udlf98i4F5Gpw2E0B
 6EqEaWrS4k9OvPiYOTEs5nJqdtKZxlhlH2qoFmK/8Aw1wH/e/KQtnJmQwbwn6LD3/jZ8
 N7M7oQsSn+WMyvalI7pCKSCpfLpBgdCeTsrf+X0yGLsnNdWoE+QKQ5lzREbu+8CiY9CU
 YoEnZraO4ekQ7Wcg3vR1JlxW734hpStWA4sJy6/Htl+Bo+PB0PC53mCmkLQCy70c6DqZ
 tUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IFbepArYBYiEtT18n8i3X49y/Ch7pBYSVm7oj4RrqyY=;
 b=TVnstGVNkbPJcpYr1mSKYG4EH1SX3vO5M1fIOqyq5ku8/hYa6zXGnj3RrCwmEMOylr
 a0Tp4CiZHNMe8q2ZQf1HeOBvlxcKa9aCCTOIWz4UdinGbQF9k5Vr2TUwtz60a8ZULEtz
 Tw5FTb1/QX9HN4Z3lP41AOi7rubBxH12fdUYm9vTr9vku9XuprJ/ZBAO3qZvktWkIFtK
 eeaeIVpT0Kt9b/vINjqLdEAVxMPR8Zb38t9GeIrp3jRW9u5r/CzMI9lpdFXcv0yG5u5P
 6EpDVfvsJEnNtr7dF7ldHQcUZum4LLQp+bw72u8bmxrEOqmiFYQpvUguTyodFdK7hqdo
 AYkA==
X-Gm-Message-State: AOAM5338oG5kMp9fDOJ1oNotgEf5bKjrK6y3jW0dqlLjvIIrthLqiJ7c
 k+OsaeUh1lzYC8x9hLXBnyUQ5glxfZ8Cc9jDSBvO
X-Google-Smtp-Source: ABdhPJwebQXfb0YaDH0kbWaXZSi0giLu8PLolYeV2VndKysnJ58iLPxYZzYrjgAqRRGphsDY0yeudfGDxW/gLAWHdmg=
X-Received: by 2002:a05:6602:2fcf:: with SMTP id
 v15mr176646iow.78.1598855266658; 
 Sun, 30 Aug 2020 23:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <1663d06172cffa723e00893837ba04634f061fc8.1596768588.git.haibo.xu@linaro.org>
 <4e6b3ee2-7f81-7c72-c4a9-0e8d330215ab@redhat.com>
In-Reply-To: <4e6b3ee2-7f81-7c72-c4a9-0e8d330215ab@redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Mon, 31 Aug 2020 14:27:35 +0800
Message-ID: <CAJc+Z1G3BpX-5HDqFkFhXJOK9_bq_zw5hp6LqGR=oeSvGJcfDw@mail.gmail.com>
Subject: Re: [PATCH 6/7] hw/arm/virt: spe: Add SPE fdt binding for virt machine
To: Auger Eric <eric.auger@redhat.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 29 Aug 2020 at 23:22, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Haibo,
>
> On 8/7/20 10:10 AM, Haibo Xu wrote:
> > Add a virtual SPE device for virt machine while using PPI
> > 5 for SPE overflow interrupt number.
> >
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > ---
> >  hw/arm/virt-acpi-build.c    |  3 +++
> >  hw/arm/virt.c               | 42 +++++++++++++++++++++++++++++++++++++
> >  include/hw/acpi/acpi-defs.h |  1 +
> >  include/hw/arm/virt.h       |  1 +
> >  target/arm/cpu.c            |  2 ++
> >  target/arm/cpu.h            |  2 ++
> >  target/arm/kvm.c            |  6 ++++++
> >  7 files changed, 57 insertions(+)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 91f0df7b13..5073ba22a5 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -666,6 +666,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >          if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
> >              gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
> >          }
> > +        if (arm_feature(&armcpu->env, ARM_FEATURE_SPE)) {
> > +            gicc->spe_interrupt = cpu_to_le32(PPI(VIRTUAL_SPE_IRQ));
> > +        }
> >          if (vms->virt) {
> >              gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GIC_MAINT_IRQ));
> >          }
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index ecfee362a1..c40819705d 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -555,6 +555,42 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
> >      }
> >  }
> >
> > +static void fdt_add_spe_nodes(const VirtMachineState *vms)
> > +{
> > +    CPUState *cpu;
> > +    ARMCPU *armcpu;
> > +    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
> > +
> > +    CPU_FOREACH(cpu) {
> > +        armcpu = ARM_CPU(cpu);
> > +        if (!arm_feature(&armcpu->env, ARM_FEATURE_SPE)) {
> > +            return;
> > +        }
> > +        if (kvm_enabled()) {
> > +            if (kvm_irqchip_in_kernel()) {
> > +                kvm_arm_spe_set_irq(cpu, PPI(VIRTUAL_SPE_IRQ));
> > +            }
> > +            kvm_arm_spe_init(cpu);
> > +        }
> > +    }
> > +
> > +    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> > +        irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
> > +                             GIC_FDT_IRQ_PPI_CPU_WIDTH,
> > +                             (1 << vms->smp_cpus) - 1);
> > +    }
> > +
> > +    armcpu = ARM_CPU(qemu_get_cpu(0));
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
> > @@ -727,6 +763,10 @@ static void create_gic(VirtMachineState *vms)
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
> > @@ -1915,6 +1955,8 @@ static void machvirt_init(MachineState *machine)
> >
> >      fdt_add_pmu_nodes(vms);
> >
> > +    fdt_add_spe_nodes(vms);
> > +
> >      create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
> >
> >      if (vms->secure) {
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 38a42f409a..56a7f38ae4 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -302,6 +302,7 @@ struct AcpiMadtGenericCpuInterface {
> >      uint32_t vgic_interrupt;
> >      uint64_t gicr_base_address;
> >      uint64_t arm_mpidr;
> > +    uint16_t spe_interrupt; /* ACPI 6.3 */
> This does not work for me.
> You miss 2 uint8_t fields inbetween arm_mpdir and spe_interrupt:
> Processor Power Efficiency Class and Reserved.
>
> At the moment arm_spe_acpi_register_device() silently fails on guest
> side since
> gicc->header.length < ACPI_MADT_GICC_SPE
>
> Thanks
>
> Eric
>

Thanks for pointing out this. I will fix it in the next version.

> >  } QEMU_PACKED;
> >
> >  typedef struct AcpiMadtGenericCpuInterface AcpiMadtGenericCpuInterface;
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > index dff67e1bef..56c83224d2 100644
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
> > index 40768b4d19..67ab0089fd 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1038,6 +1038,8 @@ static void arm_cpu_initfn(Object *obj)
> >                               "gicv3-maintenance-interrupt", 1);
> >      qdev_init_gpio_out_named(DEVICE(cpu), &cpu->pmu_interrupt,
> >                               "pmu-interrupt", 1);
> > +    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->spe_interrupt,
> > +                             "spe-interrupt", 1);
> >  #endif
> >
> >      /* DTB consumers generally don't in fact care what the 'compatible'
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index fe0ac14386..4bf8591df8 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -790,6 +790,8 @@ struct ARMCPU {
> >      qemu_irq gicv3_maintenance_interrupt;
> >      /* GPIO output for the PMU interrupt */
> >      qemu_irq pmu_interrupt;
> > +    /* GPIO output for the SPE interrupt */
> > +    qemu_irq spe_interrupt;
> >
> >      /* MemoryRegion to use for secure physical accesses */
> >      MemoryRegion *secure_memory;
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 58f991e890..ecafdda364 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -820,6 +820,12 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
> >              switched_level &= ~KVM_ARM_DEV_PMU;
> >          }
> >
> > +        if (switched_level & KVM_ARM_DEV_SPE) {
> > +            qemu_set_irq(cpu->spe_interrupt,
> > +                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_SPE));
> > +            switched_level &= ~KVM_ARM_DEV_SPE;
> > +        }
> > +
> >          if (switched_level) {
> >              qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
> >                            __func__, switched_level);
> >
>

