Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1758C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E0821911
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E0821911
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZ6M-00067l-UP
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZ6A-0005dP-49
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZ68-0006bQ-CA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:15:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45426 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZ65-0006YS-IF; Mon, 22 Jul 2019 10:15:25 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 71FE7EA14D0993548074;
 Mon, 22 Jul 2019 15:15:24 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.132]) by
 lhreml705-cah.china.huawei.com ([10.201.108.46]) with mapi id 14.03.0415.000; 
 Mon, 22 Jul 2019 15:15:17 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH-for-4.2 v7 09/10] hw/arm: Use GED for
 system_powerdown event
Thread-Index: AQHVO+0F0HlnZSau4kWEo4hm5JddvqbQSaSAgAZtyGA=
Date: Mon, 22 Jul 2019 14:15:17 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F310A72@lhreml524-mbs.china.huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-10-shameerali.kolothum.thodi@huawei.com>
 <20190718150301.45b3fb57@redhat.com>
In-Reply-To: <20190718150301.45b3fb57@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 09/10] hw/arm: Use GED for
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "sameo@linux.intel.com" <sameo@linux.intel.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongn
> u.org] On Behalf Of Igor Mammedov
> Sent: 18 July 2019 14:03
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> shannon.zhaosl@gmail.com; ard.biesheuvel@linaro.org;
> qemu-devel@nongnu.org; xuwei (O) <xuwei5@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; eric.auger@redhat.com; qemu-arm@nongnu.org;
> sebastien.boeuf@intel.com; lersek@redhat.com
> Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 09/10] hw/arm: Use GED for
> system_powerdown event
>=20
> On Tue, 16 Jul 2019 16:38:15 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > Use GED for system_powerdown event instead of GPIO for ACPI.
> > Guest boot with DT still uses GPIO.
>=20
>=20
> I'd hate to keep ACPI GPIO around but taking in account migration
> wouldn't this patch break ACPI GPIO based button on 4.0 and older where
> GED is not available and guest was booted as ACPI one and then rebooted o=
n
> new QEMU?

Hmm..That looks like a valid case unfortunately :(. I will keep the GPIO th=
en.

Thanks,
Shameer
=20
>=20
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  hw/arm/virt-acpi-build.c | 37 +------------------------------------
> >  hw/arm/virt.c            |  6 +++---
> >  2 files changed, 4 insertions(+), 39 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 75657caa36..9178ca8e40 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -49,7 +49,6 @@
> >  #include "kvm_arm.h"
> >
> >  #define ARM_SPI_BASE 32
> > -#define ACPI_POWER_BUTTON_DEVICE "PWRB"
> >
> >  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
> >  {
> > @@ -328,37 +327,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const
> MemMapEntry *memmap,
> >      aml_append(scope, dev);
> >  }
> >
> > -static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry
> *gpio_memmap,
> > -                                           uint32_t gpio_irq)
> > -{
> > -    Aml *dev =3D aml_device("GPO0");
> > -    aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
> > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > -
> > -    Aml *crs =3D aml_resource_template();
> > -    aml_append(crs, aml_memory32_fixed(gpio_memmap->base,
> gpio_memmap->size,
> > -                                       AML_READ_WRITE));
> > -    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL,
> AML_ACTIVE_HIGH,
> > -                                  AML_EXCLUSIVE, &gpio_irq, 1));
> > -    aml_append(dev, aml_name_decl("_CRS", crs));
> > -
> > -    Aml *aei =3D aml_resource_template();
> > -    /* Pin 3 for power button */
> > -    const uint32_t pin_list[1] =3D {3};
> > -    aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE,
> AML_ACTIVE_HIGH,
> > -                                 AML_EXCLUSIVE, AML_PULL_UP, 0,
> pin_list, 1,
> > -                                 "GPO0", NULL, 0));
> > -    aml_append(dev, aml_name_decl("_AEI", aei));
> > -
> > -    /* _E03 is handle for power button */
> > -    Aml *method =3D aml_method("_E03", 0, AML_NOTSERIALIZED);
> > -    aml_append(method,
> aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> > -                                  aml_int(0x80)));
> > -    aml_append(dev, method);
> > -    aml_append(scope, dev);
> > -}
> > -
> >  static void acpi_dsdt_add_power_button(Aml *scope)
> >  {
> >      Aml *dev =3D aml_device(ACPI_POWER_BUTTON_DEVICE);
> > @@ -739,9 +707,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
> >                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
> NUM_VIRTIO_TRANSPORTS);
> >      acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] +
> ARM_SPI_BASE),
> >                        vms->highmem, vms->highmem_ecam);
> > -    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> > -                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
> >      if (vms->acpi_dev) {
> > +        acpi_dsdt_add_power_button(scope);
> >          build_ged_aml(scope, "\\_SB."GED_DEVICE,
> >                        HOTPLUG_HANDLER(vms->acpi_dev),
> >                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE,
> AML_SYSTEM_MEMORY);
> > @@ -752,8 +719,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
> >                                   AML_SYSTEM_MEMORY);
> >      }
> >
> > -    acpi_dsdt_add_power_button(scope);
> > -
> >      aml_append(dsdt, scope);
> >
> >      /* copy AML table into ACPI tables blob and patch header there */
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index ffcccc05ad..6e55c25c5f 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -528,7 +528,7 @@ static inline DeviceState
> *create_acpi_ged(VirtMachineState *vms, qemu_irq *pic)
> >  {
> >      DeviceState *dev;
> >      int irq =3D vms->irqmap[VIRT_ACPI_GED];
> > -    uint32_t event =3D ACPI_GED_MEM_HOTPLUG_EVT;
> > +    uint32_t event =3D ACPI_GED_MEM_HOTPLUG_EVT |
> ACPI_GED_PWR_DOWN_EVT;
> >
> >      dev =3D DEVICE(object_new(TYPE_ACPI_GED));
> >      qdev_prop_set_uint64(dev, "memhp-base",
> > @@ -1718,10 +1718,10 @@ static void machvirt_init(MachineState
> *machine)
> >
> >      create_pcie(vms, pic);
> >
> > -    create_gpio(vms, pic);
> > -
> >      if (!vmc->no_acpi_dev && aarch64 && firmware_loaded &&
> acpi_enabled) {
> >          vms->acpi_dev =3D create_acpi_ged(vms, pic);
> > +    } else {
> > +        create_gpio(vms, pic);
> >      }
> >
> >      /* Create mmio transports, so the user can create virtio backends
>=20


