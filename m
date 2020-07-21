Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D6EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940322077D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQBRQTSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940322077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxpnz-0006eR-Tl
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxpn3-00062r-85
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:46:31 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:40038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxpmz-0005zc-0w
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:46:28 -0400
Received: by mail-oo1-xc43.google.com with SMTP id p26so3824758oos.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2og3SFbeN6YMGfPfc06lXM9ALGmAvp0vst7R1pqYJ/w=;
 b=HQBRQTSz7++4foz9XXACEBPZWSF8gKkuboQs0aWCskik7A870p44b0UaFJXHmK4KXq
 ELr/dpl9Xl0EPfAFmUDzna+yfZADIYmLD/BjG/Q5+c5TCOD94HjwjGvpZzocjZyL9Cc3
 z01N+r/Pw/jDHLpWy3bGSUxwA6lOUmIzJqnLBRbMSV51NAUJpUWzLe8MIFE1eCh7evYz
 TNtpu6/1XaUBpIl2DZG5uIRrEAqZyMPnRfQVsY0/0JJTzCM/911wqlKSDm/zcRxD2T2P
 uqiefNJx3bP3bWDWdjvhnQleiff16GLdN2ne7HxUnq+irXdpXh8vhymXYKpTkUMCd9RM
 P2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2og3SFbeN6YMGfPfc06lXM9ALGmAvp0vst7R1pqYJ/w=;
 b=GR9K2TdqcN4qFZzwN2bCwvwyFtbwN8CWZxycfwKc/NQRKUCuzd5jQZUHgQI6Lv+q+3
 VuQ/r+zAZuMadcUfpUXwjsyCV9qmduGeBrYwhVI+o7sRDGHVNQUyw5suiXKo4uy3P057
 DFK+U/7p8LKn3X8N4tXT8DL5DlF2UrVwsYS35V+5DcJxVcWE60+DO7IGOZ2A0jL7Gy+k
 FtXnJQ8oKr+LC3Id761SlQ9kKwJo1Ib0rLvjbANGBsJtfo0tasHcYSfDdl1x0XUjjjXj
 f5Rrs60C3cymGnIeY/sRtvCxIGhxcSfIra1TxT1oHkPymOXpSDfkPbEymO6qdInkJb8Y
 Yzeg==
X-Gm-Message-State: AOAM533l9DxhhJlQ6nG8xd9larEBdtrpwOIfJ7s/J6ejD3GijbWAo/dN
 CMVY7N1WwQ7cRqvxRxs/BbH5CVsB2qKI9ps1k3v3Iw==
X-Google-Smtp-Source: ABdhPJwe+75WCi2T9xSOgkKdnlRrn9mdyY+JJA/qmch81YzgMei/e2uxF18LxG4zoffmNiBMQGNu3thi6symQQVpFmM=
X-Received: by 2002:a4a:a685:: with SMTP id f5mr13394425oom.85.1595328383498; 
 Tue, 21 Jul 2020 03:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200711101033.47371-1-drjones@redhat.com>
 <20200711101033.47371-4-drjones@redhat.com>
In-Reply-To: <20200711101033.47371-4-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 11:46:12 +0100
Message-ID: <CAFEAcA_GGVyjV_avxAfrRKnF72mxXEEf=J34aq-L8yMnLndigg@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/arm/virt: Implement kvm-steal-time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 at 11:10, Andrew Jones <drjones@redhat.com> wrote:
>
> We add the kvm-steal-time CPU property and implement it for machvirt.
> A tiny bit of refactoring was also done to allow pmu and pvtime to
> use the same vcpu device helper functions.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst | 11 +++++
>  hw/arm/virt.c                    | 33 ++++++++++++++-
>  include/hw/arm/virt.h            |  2 +
>  target/arm/cpu.c                 | 10 +++++
>  target/arm/cpu.h                 |  4 ++
>  target/arm/kvm.c                 | 20 +++++++++
>  target/arm/kvm32.c               |  5 +++
>  target/arm/kvm64.c               | 70 +++++++++++++++++++++++++++++---
>  target/arm/kvm_arm.h             | 24 ++++++++++-
>  target/arm/monitor.c             |  2 +-
>  tests/qtest/arm-cpu-features.c   | 25 ++++++++++--
>  11 files changed, 193 insertions(+), 13 deletions(-)
>
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 2d5c06cd016b..4e590e6e9f54 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -200,6 +200,17 @@ the list of KVM VCPU features and their descriptions.
>                             adjustment, also restoring the legacy (pre-5.0)
>                             behavior.
>
> +  kvm-steal-time           Since v5.1, kvm-steal-time is enabled by
> +                           default when KVM is enabled, the feature is
> +                           supported, and the guest is 64-bit.
> +
> +                           When kvm-steal-time is enabled a 64-bit guest
> +                           can account for time its CPUs were not running
> +                           due to the host not scheduling the corresponding
> +                           VCPU threads.  The accounting statistics may
> +                           influence the guest scheduler behavior and/or be
> +                           exposed to the guest userspace.
> +
>  SVE CPU Properties
>  ==================
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 63ef530933e5..21965a1665ca 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -151,6 +151,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
>      [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
>      [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
> +    [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -1663,13 +1664,26 @@ static void finalize_gic_version(VirtMachineState *vms)
>   */
>  static void virt_cpu_post_init(VirtMachineState *vms)
>  {
> -    bool aarch64, pmu;
> +    bool aarch64, pmu, steal_time;
>      CPUState *cpu;
>
>      aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
>      pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
> +    steal_time = object_property_get_bool(OBJECT(first_cpu),
> +                                          "kvm-steal-time", NULL);
>
>      if (kvm_enabled()) {
> +        hwaddr pvtime_base = vms->memmap[VIRT_PVTIME].base;
> +        hwaddr pvtime_size = vms->memmap[VIRT_PVTIME].size;
> +
> +        if (steal_time) {
> +            MemoryRegion *pvtime = g_new(MemoryRegion, 1);
> +
> +            memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, NULL);
> +            memory_region_add_subregion(get_system_memory(), pvtime_base,
> +                                        pvtime);

I guess when we are looking at how KVM interacts with MemTag
we'll need to also consider this kind of random-lump-of-ram
(it will need to have tags)... Same thing with framebuffers etc though.

Could you avoid get_system_memory() here and instead pass in
'sysmem' from the caller? The virt board has now 4 different
address spaces it creates and works with (sysmem, secure_sysmem,
tag_sysmem, secure_tag_sysmem) and I think it's going to be better
to aim to consistently have the top level function pass the
lower level functions the MRs they should be putting the devices
in rather than having the low level function say in some cases
"I happen to know that get_system_memory() is the same thing as
'sysmem'".

> +        }
> +
>          CPU_FOREACH(cpu) {
>              if (pmu) {
>                  assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));

> @@ -2528,6 +2558,7 @@ static void virt_machine_5_0_options(MachineClass *mc)
>      mc->numa_mem_supported = true;
>      vmc->acpi_expose_flash = true;
>      mc->auto_enable_numa_with_memdev = false;
> +    vmc->kvm_no_steal_time = true;

This will need to move into the 5_1 options, obviously.

>  }
>  DEFINE_VIRT_MACHINE(5, 0)

> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 0af46b41c847..d3f3195077fa 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -560,6 +560,11 @@ void kvm_arm_pmu_init(CPUState *cs)
>      qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
>  }
>
> +void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
> +}

kvm32.c is going to be removed once 5.1 is out the door
(we deprecated it in 5.0 so can remove in 5.2, I think),
so this is fine.

> +
>  #define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
>  #define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
>  /*

> +void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
> +{
> +    static bool has_steal_time;
> +    static bool probed;
> +    int fdarray[3];
> +
> +    if (!probed) {
> +        probed = true;
> +        if (kvm_check_extension(kvm_state, KVM_CAP_VCPU_ATTRIBUTES)) {
> +            if (!kvm_arm_create_scratch_host_vcpu(NULL, fdarray, NULL)) {
> +                error_report("Failed to create scratch VCPU");
> +                abort();
> +            }
> +
> +            has_steal_time = kvm_device_check_attr(fdarray[2],
> +                                                   KVM_ARM_VCPU_PVTIME_CTRL,
> +                                                   KVM_ARM_VCPU_PVTIME_IPA);
> +
> +            kvm_arm_destroy_scratch_host_vcpu(fdarray);

I was a bit surprised that we create a scratch VCPU here, but
it looks like we've opted for "create scratch VCPU, check specific
detail, destroy VCPU" as the usual coding pattern rather than trying
to coalesce into a single "create scratch VCPU once, cache all
the info we might need for later". I guess if somebody (a) cares
about startup performance and (b) finds through profiling that
creation-and-destruction of the scratch VMs/VCPUs is a significant
contributor they can write the refactoring themselves :-)

> +        }
> +    }
> +
> +    if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
> +        if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +            cpu->kvm_steal_time = ON_OFF_AUTO_OFF;
> +        } else {
> +            cpu->kvm_steal_time = ON_OFF_AUTO_ON;
> +        }
> +    } else if (cpu->kvm_steal_time == ON_OFF_AUTO_ON) {
> +        if (!has_steal_time) {
> +            error_setg(errp, "'kvm-steal-time' cannot be enabled "
> +                             "on this host");
> +            return;
> +        } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +            error_setg(errp, "'kvm-steal-time' cannot be enabled "
> +                             "for AArch32 guests");

Why not? Unlike aarch32-host KVM, aarch32-guest KVM is
still supported. What's the missing piece for kvm-steal-time
to work in that setup?

> +            return;
> +        }
> +    }
> +}
> +
>  bool kvm_arm_aarch32_supported(void)
>  {
>      return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL1_32BIT);

>  static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
> +static inline void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp) {}

Does this stub need to report an error to the caller via errp,
or is it a "never called but needs to exist to avoid linker errors" ?


thanks
-- PMM

