Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40145C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 10:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0358206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 10:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0358206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9oIg-0006En-Ms
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 06:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i9oHj-0005jW-KS
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i9oHi-0008Eb-Cb
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:31:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45440 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i9oHf-00088a-2Z; Mon, 16 Sep 2019 06:31:03 -0400
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id CA0D2B3BADA03FA91413;
 Mon, 16 Sep 2019 11:30:54 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.65]) by
 lhreml708-cah.china.huawei.com ([10.201.108.49]) with mapi id 14.03.0415.000; 
 Mon, 16 Sep 2019 11:30:45 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [PATCH-for-4.2 v10 05/11] hw/arm/virt: Enable device memory
 cold/hot plug with ACPI boot
Thread-Index: AQHVaKHVnammLOI3e0qhJzz+2jBkq6cuIIkA
Date: Mon, 16 Sep 2019 10:30:45 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F3F293A@lhreml524-mbs.china.huawei.com>
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-6-shameerali.kolothum.thodi@huawei.com>
 <20190911150700.7a917d14@redhat.com>
In-Reply-To: <20190911150700.7a917d14@redhat.com>
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
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 05/11] hw/arm/virt: Enable
 device memory cold/hot plug with ACPI boot
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
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 11 September 2019 14:07
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH-for-4.2 v10 05/11] hw/arm/virt: Enable device memory
> cold/hot plug with ACPI boot
>=20
> On Wed, 4 Sep 2019 09:56:23 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> [...]
> > @@ -730,6 +733,19 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
> >                        vms->highmem, vms->highmem_ecam);
> >      acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> >                         (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
> > +    if (vms->acpi_dev) {
> > +        build_ged_aml(scope, "\\_SB."GED_DEVICE,
> > +                      HOTPLUG_HANDLER(vms->acpi_dev),
> > +                      irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE,
> AML_SYSTEM_MEMORY,
> > +                      memmap[VIRT_ACPI_GED].base);
> > +    }
> > +
> > +    if (vms->acpi_dev && ms->ram_slots) {
> > +        build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB",
> NULL,
> > +                                 AML_SYSTEM_MEMORY,
> > +
> memmap[VIRT_PCDIMM_ACPI].base);
> > +    }
> one more thing (though non critical), if ms->ram_slots =3D=3D 0 ^^^^
> makes IASL spew a warning
>=20
>     External (_SB_.MHPC.MSCN, MethodObj)    // Warning: Unknown
> method, guessing 0 arguments
>=20
> In general non-existing references within methods are fine if they aren't=
 ever
> used.
> however we can be a little bit less sloppy.
> Below you advertise "event =3D ACPI_GED_MEM_HOTPLUG_EVT", and then here
> suddenly
> don't generate essential AML part for it here.

Ok.

> For consistency if above is conditioned on ms->ram_slots !=3D 0, probably
> it would be better to move that condition where you set 'event' value and
> check property value above instead of ms->ram_slots

I understand the concern here, but not sure I get the suggestion to check=20
the "property" instead of ms->ram_slots correctly.=20

Is this what you have in mind?

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 538b3bbefa..5c9269dca1 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -742,10 +742,15 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
                       memmap[VIRT_ACPI_GED].base);
     }
=20
-    if (vms->acpi_dev && ms->ram_slots) {
-        build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
-                                 AML_SYSTEM_MEMORY,
-                                 memmap[VIRT_PCDIMM_ACPI].base);
+    if (vms->acpi_dev) {
+        uint32_t event =3D object_property_get_uint(OBJECT(vms->acpi_dev),
+                                                  "ged-event", NULL);
+
+        if (event & ACPI_GED_MEM_HOTPLUG_EVT) {
+            build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
+                                     AML_SYSTEM_MEMORY,
+                                     memmap[VIRT_PCDIMM_ACPI].base);
+        }
     }
=20
     acpi_dsdt_add_power_button(scope);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bc152ea2b0..6b024b16df 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -534,8 +534,13 @@ static void fdt_add_pmu_nodes(const VirtMachineState *=
vms)
 static inline DeviceState *create_acpi_ged(VirtMachineState *vms, qemu_irq=
 *pic)
 {
     DeviceState *dev;
+    MachineState *ms =3D MACHINE(vms);
     int irq =3D vms->irqmap[VIRT_ACPI_GED];
-    uint32_t event =3D ACPI_GED_MEM_HOTPLUG_EVT;
+    uint32_t event =3D 0;
+
+    if (ms->ram_slots) {
+        event =3D ACPI_GED_MEM_HOTPLUG_EVT;
+    }
=20
     dev =3D qdev_create(NULL, TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);

---8---

Please let me know.

Thanks,
Shameer

=20
> [...]
> > +static inline DeviceState *create_acpi_ged(VirtMachineState *vms,
> qemu_irq *pic)
> > +{
> > +    DeviceState *dev;
> > +    int irq =3D vms->irqmap[VIRT_ACPI_GED];
> > +    uint32_t event =3D ACPI_GED_MEM_HOTPLUG_EVT;
> > +
> > +    dev =3D qdev_create(NULL, TYPE_ACPI_GED);
> > +    qdev_prop_set_uint32(dev, "ged-event", event);
> > +    qdev_init_nofail(dev);
> > +
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
> vms->memmap[VIRT_ACPI_GED].base);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1,
> vms->memmap[VIRT_PCDIMM_ACPI].base);
> > +
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
> > +
> > +    return dev;
> > +}
> > +
> [...]

