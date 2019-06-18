Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D6C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFD12054F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFD12054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdDb4-0005Rp-EX
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hdDYj-0002jy-21
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hdDYh-0006D8-2v
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hdDYZ-0005yG-9d; Tue, 18 Jun 2019 08:49:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23AF4308A951;
 Tue, 18 Jun 2019 12:49:46 +0000 (UTC)
Received: from [10.36.117.84] (ovpn-117-84.ams2.redhat.com [10.36.117.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5840C60922;
 Tue, 18 Jun 2019 12:49:43 +0000 (UTC)
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
References: <20190522162252.28568-1-shameerali.kolothum.thodi@huawei.com>
 <20190522162252.28568-9-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a97f8e60-9055-4d87-3412-a71372c89ae5@redhat.com>
Date: Tue, 18 Jun 2019 14:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190522162252.28568-9-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 18 Jun 2019 12:49:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 8/8] hw/arm: Use GED for
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
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,
On 5/22/19 6:22 PM, Shameer Kolothum wrote:
> Use GED for system_powerdown event instead of GPIO for ACPI.
> Guest boot with DT still uses GPIO.>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  hw/arm/virt-acpi-build.c | 37 +------------------------------------
>  hw/arm/virt.c            |  7 +++----
>  2 files changed, 4 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index ed8e0cee3a..f23b276d77 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -49,7 +49,6 @@
>  #include "kvm_arm.h"
>  
>  #define ARM_SPI_BASE 32
> -#define ACPI_POWER_BUTTON_DEVICE "PWRB">
>  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
>  {
> @@ -328,37 +327,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>      aml_append(scope, dev);
>  }
>  
> -static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
> -                                           uint32_t gpio_irq)
> -{
> -    Aml *dev = aml_device("GPO0");
> -    aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
> -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> -
> -    Aml *crs = aml_resource_template();
> -    aml_append(crs, aml_memory32_fixed(gpio_memmap->base, gpio_memmap->size,
> -                                       AML_READ_WRITE));
> -    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> -                                  AML_EXCLUSIVE, &gpio_irq, 1));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    Aml *aei = aml_resource_template();
> -    /* Pin 3 for power button */
> -    const uint32_t pin_list[1] = {3};
> -    aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> -                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
> -                                 "GPO0", NULL, 0));
> -    aml_append(dev, aml_name_decl("_AEI", aei));
> -
> -    /* _E03 is handle for power button */
> -    Aml *method = aml_method("_E03", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> -                                  aml_int(0x80)));
> -    aml_append(dev, method);
> -    aml_append(scope, dev);
> -}
> -
>  static void acpi_dsdt_add_power_button(Aml *scope)
>  {
>      Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
> @@ -761,9 +729,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
>      acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
>                        vms->highmem, vms->highmem_ecam);
> -    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> -                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      if (vms->acpi_dev) {
> +        acpi_dsdt_add_power_button(scope);
>          build_ged_aml(scope, "\\_SB."GED_DEVICE,
>                        HOTPLUG_HANDLER(vms->acpi_dev),
>                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY);
> @@ -774,8 +741,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                                   AML_SYSTEM_MEMORY);
>      }
>  
> -    acpi_dsdt_add_power_button(scope);
> -
>      aml_append(dsdt, scope);
>  
>      /* copy AML table into ACPI tables blob and patch header there */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 8dfd7537b9..bb83160888 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -525,7 +525,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms, qemu_irq *pic)
>  {
>      DeviceState *dev;
>      int irq = vms->irqmap[VIRT_ACPI_GED];
> -    uint32_t event = ACPI_GED_MEM_HOTPLUG_EVT;
> +    uint32_t event = ACPI_GED_MEM_HOTPLUG_EVT | ACPI_GED_PWR_DOWN_EVT;
>  
>      dev = DEVICE(object_new(TYPE_ACPI_GED));
>      qdev_prop_set_uint64(dev, "memhp-base",
> @@ -1710,12 +1710,11 @@ static void machvirt_init(MachineState *machine)
>  
>      create_pcie(vms, pic);
>  
> -    create_gpio(vms, pic);
> -
>      if (aarch64 && firmware_loaded && acpi_enabled) {
>          vms->acpi_dev = create_acpi_ged(vms, pic);
> +    } else {
> +        create_gpio(vms, pic);
>      }
> -
>      /* Create mmio transports, so the user can create virtio backends
>       * (which will be automatically plugged in to the transports). If
>       * no backend is created the transport will just sit harmlessly idle.
> 

