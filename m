Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0CFC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74034208C3
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 13:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74034208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huzg3-0003nP-PJ
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 09:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1huzfg-0003Mq-JW
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1huzfb-0002Ki-EH
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 09:38:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1huzfY-0002IC-Bo; Tue, 06 Aug 2019 09:38:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72897306731A;
 Tue,  6 Aug 2019 13:38:27 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45BB55D6A7;
 Tue,  6 Aug 2019 13:38:19 +0000 (UTC)
Date: Tue, 6 Aug 2019 15:38:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190806153818.1aca64d1@redhat.com>
In-Reply-To: <20190726104519.23812-10-shameerali.kolothum.thodi@huawei.com>
References: <20190726104519.23812-1-shameerali.kolothum.thodi@huawei.com>
 <20190726104519.23812-10-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 06 Aug 2019 13:38:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 9/9] hw/arm: Use GED for
 system_powerdown event
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 11:45:19 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> For machines 4.2 or higher with ACPI boot use GED for system_powerdown
> event instead of GPIO. Guest boot with DT still uses GPIO.

one more thing,
though GED is sort of described in ACPI spec, MMIO event mapping
is a totally QEMU invention.

so we probably should describe its ABI in our own spec, maybe in
  docs/specs/acpi_hw_reduced_hotplug.txt
see docs/specs/acpi_foo for examples.

> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v7 --> v8
>  -Retained gpio based system_powerdown support for machines < 4.2.
>  -Reuse of virt_powerdown_req() for ACPI GED use.
>  -Dropped Eric's R-by for now because of above.
> 
> ---
>  hw/acpi/generic_event_device.c       |  2 ++
>  hw/arm/virt-acpi-build.c             |  6 +++---
>  hw/arm/virt.c                        | 27 ++++++++++++++++-----------
>  include/hw/acpi/acpi_dev_interface.h |  1 +
>  include/hw/arm/virt.h                |  1 +
>  5 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 0b3214eff4..f00b0ab14b 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -205,6 +205,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>      if (ev & ACPI_MEMORY_HOTPLUG_STATUS) {
>          sel = ACPI_GED_MEM_HOTPLUG_EVT;
> +    } else if (ev & ACPI_POWER_DOWN_STATUS) {
> +        sel = ACPI_GED_PWR_DOWN_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 75657caa36..31bf2bf775 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -49,7 +49,6 @@
>  #include "kvm_arm.h"
>  
>  #define ARM_SPI_BASE 32
> -#define ACPI_POWER_BUTTON_DEVICE "PWRB"
look like this one belong to the previous patch.
Maybe we should merge both patches together?

>  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
>  {
> @@ -739,12 +738,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
>      acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
>                        vms->highmem, vms->highmem_ecam);
> -    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> -                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      if (vms->acpi_dev) {
>          build_ged_aml(scope, "\\_SB."GED_DEVICE,
>                        HOTPLUG_HANDLER(vms->acpi_dev),
>                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY);
> +    } else {
> +        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> +                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      }
>  
>      if (vms->acpi_dev && ms->ram_slots) {
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 41386a6eb7..73a758d9a9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -528,7 +528,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms, qemu_irq *pic)
>  {
>      DeviceState *dev;
>      int irq = vms->irqmap[VIRT_ACPI_GED];
> -    uint32_t event = ACPI_GED_MEM_HOTPLUG_EVT;
> +    uint32_t event = ACPI_GED_MEM_HOTPLUG_EVT | ACPI_GED_PWR_DOWN_EVT;
>  
>      dev = DEVICE(object_new(TYPE_ACPI_GED));
>      qdev_prop_set_uint64(dev, "memhp-base",
> @@ -784,13 +784,15 @@ static void create_rtc(const VirtMachineState *vms, qemu_irq *pic)
>  static DeviceState *gpio_key_dev;
>  static void virt_powerdown_req(Notifier *n, void *opaque)
>  {
> -    /* use gpio Pin 3 for power button event */
> -    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
> -}
> +    VirtMachineState *s = container_of(n, VirtMachineState, powerdown_notifier);
>  
> -static Notifier virt_system_powerdown_notifier = {
> -    .notify = virt_powerdown_req
> -};
> +    if (s->acpi_dev) {
> +        acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> +    } else {
> +        /* use gpio Pin 3 for power button event */
> +        qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
> +    }
> +}
>  
>  static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
>  {
> @@ -833,9 +835,6 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
>      qemu_fdt_setprop_cells(vms->fdt, "/gpio-keys/poweroff",
>                             "gpios", phandle, 3, 0);
>  
> -    /* connect powerdown request */
> -    qemu_register_powerdown_notifier(&virt_system_powerdown_notifier);
> -
>      g_free(nodename);
>  }
>  
> @@ -1721,12 +1720,18 @@ static void machvirt_init(MachineState *machine)
>  
>      create_pcie(vms, pic);
>  
> -    create_gpio(vms, pic);
>  
>      if (has_ged && aarch64 && firmware_loaded && acpi_enabled) {
>          vms->acpi_dev = create_acpi_ged(vms, pic);
> +    } else {
> +        create_gpio(vms, pic);
>      }
>  
> +    /* connect powerdown request */
> +    vms->powerdown_notifier.notify = virt_powerdown_req;
> +    qemu_register_powerdown_notifier(&vms->powerdown_notifier);
> +
> +
stray wight space?

I'd move factoring out powerdown_notifier from create_gpio into
a separate patch that precedes this one.

>      /* Create mmio transports, so the user can create virtio backends
>       * (which will be automatically plugged in to the transports). If
>       * no backend is created the transport will just sit harmlessly idle.
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 43ff119179..adcb3a816c 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -11,6 +11,7 @@ typedef enum {
>      ACPI_MEMORY_HOTPLUG_STATUS = 8,
>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>      ACPI_VMGENID_CHANGE_STATUS = 32,
> +    ACPI_POWER_DOWN_STATUS = 64,
>  } AcpiEventStatusBits;
>  
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 577ee49b4b..0b41083e9d 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -137,6 +137,7 @@ typedef struct {
>      int psci_conduit;
>      hwaddr highest_gpa;
>      DeviceState *acpi_dev;
> +    Notifier powerdown_notifier;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)


