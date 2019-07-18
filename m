Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39BC76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373CB2173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373CB2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho41m-0001lc-82
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39238)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ho41Z-0001Gx-G5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ho41X-0003NV-If
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:52:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45424 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ho41T-0003Er-Gy; Thu, 18 Jul 2019 06:52:27 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 3C652CADC0FD9FC0C606;
 Thu, 18 Jul 2019 11:52:18 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.132]) by
 LHREML711-CAH.china.huawei.com ([10.201.108.34]) with mapi id 14.03.0415.000; 
 Thu, 18 Jul 2019 11:52:10 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH-for-4.2 v7 03/10] hw/acpi: Add ACPI
 Generic Event Device Support
Thread-Index: AQHVPKyeUuREoR+k9k210mjLR3EAGabQLoLQ
Date: Thu, 18 Jul 2019 10:52:10 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F30B621@lhreml524-mbs.china.huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-4-shameerali.kolothum.thodi@huawei.com>
 <20190717163245.78880d55@redhat.com>
In-Reply-To: <20190717163245.78880d55@redhat.com>
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
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 03/10] hw/acpi: Add ACPI Generic
 Event Device Support
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

Hi Igor,

> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongn
> u.org] On Behalf Of Igor Mammedov
> Sent: 17 July 2019 15:33
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> shannon.zhaosl@gmail.com; ard.biesheuvel@linaro.org;
> qemu-devel@nongnu.org; xuwei (O) <xuwei5@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; eric.auger@redhat.com; qemu-arm@nongnu.org;
> sebastien.boeuf@intel.com; lersek@redhat.com
> Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 03/10] hw/acpi: Add ACPI Gene=
ric
> Event Device Support
>=20
> On Tue, 16 Jul 2019 16:38:09 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

[...]

> > +static void acpi_ged_event(AcpiGedState *s, uint32_t sel)
> > +{
> > +    GEDState *ged_st =3D &s->ged_state;
> > +    /*
> > +     * Set the GED IRQ selector to the expected device type value. Thi=
s
> > +     * way, the ACPI method will be able to trigger the right code bas=
ed
> > +     * on a unique IRQ.
> comment isn't correct anymore, pls fix it

True.

>=20
> > +     */
> > +    qemu_mutex_lock(&ged_st->lock);
> Is this lock really necessary?
> (I thought that MMIO and monitor access is guarded by BQL)

Hmm..I am not sure. This is to synchronize with the ged_st->sel update insi=
de
ged_read(). And also acpi_ged_event() gets called through _power_down_notif=
ier()
as well. BQL guard is in place for all the paths here?=20

>=20
> > +    ged_st->sel |=3D sel;
> > +    qemu_mutex_unlock(&ged_st->lock);
> > +
> > +    /* Trigger the event by sending an interrupt to the guest. */
> > +    qemu_irq_pulse(s->irq);
> > +}
> > +
> > +static void acpi_ged_init(MemoryRegion *as, DeviceState *dev, GEDState
> *ged_st)
> > +{
> > +    AcpiGedState *s =3D ACPI_GED(dev);
> > +
> > +    assert(s->ged_base);
> > +
> > +    qemu_mutex_init(&ged_st->lock);
> > +    memory_region_init_io(&ged_st->io, OBJECT(dev), &ged_ops, ged_st,
> > +                          TYPE_ACPI_GED, ACPI_GED_REG_LEN);
> > +    memory_region_add_subregion(as, s->ged_base, &ged_st->io);
> > +    qdev_init_gpio_out_named(DEVICE(s), &s->irq, "ged-irq", 1);
> > +}
> > +
> > +static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
> > +                                    DeviceState *dev, Error **errp)
> > +{
> > +    AcpiGedState *s =3D ACPI_GED(hotplug_dev);
> > +
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        if (s->memhp_state.is_enabled) {
> > +            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev,
> errp);
> > +        } else {
> > +            error_setg(errp,
> > +                 "memory hotplug is not
> enabled: %s.memory-hotplug-support "
> > +                 "is not set", object_get_typename(OBJECT(s)));
> > +        }
> > +    } else {
> > +        error_setg(errp, "virt: device plug request for unsupported
> device"
> > +                   " type: %s", object_get_typename(OBJECT(dev)));
> > +    }
> > +}
> > +
> > +static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBit=
s
> ev)
> > +{
> > +    AcpiGedState *s =3D ACPI_GED(adev);
> > +    uint32_t sel;
> > +
> > +    if (ev & ACPI_MEMORY_HOTPLUG_STATUS) {
> > +        sel =3D ACPI_GED_MEM_HOTPLUG_EVT;
> > +    } else {
> > +        /* Unknown event. Return without generating interrupt. */
> > +        warn_report("GED: Unsupported event %d. No irq injected", ev);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * We inject the hotplug interrupt. The IRQ selector will make
> > +     * the difference from the ACPI table.
> I don't get comment at all, pls rephrase/

Ok. I think better to get rid of this comment here and update the one in ac=
pi_ged_event()
appropriately.

>=20
> > +     */
> > +    acpi_ged_event(s, sel);
> it seems to used only once and only here, suggest to drop acpi_ged_event(=
)
> and move it's code here.

But patch #10 makes use of it from acpi_ged_pm_powerdown_req().

> > +}
> > +
> > +static void acpi_ged_device_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AcpiGedState *s =3D ACPI_GED(dev);
> > +
> > +    if (s->memhp_state.is_enabled) {
> > +        acpi_memory_hotplug_init(get_system_memory(), OBJECT(dev),
> > +                                 &s->memhp_state,
> > +                                 s->memhp_base);
> > +    }
> > +
> > +    acpi_ged_init(get_system_memory(), dev, &s->ged_state);
> > +}
> > +
> > +static Property acpi_ged_properties[] =3D {
> > +    /*
> > +     * Memory hotplug base address is a property of GED here,
> > +     * because GED handles memory hotplug event and acpi-mem-hotplug
> > +     * memory region gets initialized when GED device is realized.
> > +     */
> > +    DEFINE_PROP_UINT64("memhp-base", AcpiGedState, memhp_base,
> 0),
> > +    DEFINE_PROP_BOOL("memory-hotplug-support", AcpiGedState,
> > +                     memhp_state.is_enabled, true),
> > +    DEFINE_PROP_UINT64("ged-base", AcpiGedState, ged_base, 0),
>=20
> I'd add checks to realize() to ensure that both foo_base are not left
> uninitialized (i.e. at default values)

Ok. ged_base has a check in acpi_ged_init(). I will add check for memhp_bas=
e
and move the ged_base one to realize().

>=20
> > +    DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap,
> 0),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static bool vmstate_test_use_memhp(void *opaque)
> > +{
> > +    AcpiGedState *s =3D opaque;
> > +    return s->memhp_state.is_enabled;
> > +}
> > +
> > +static const VMStateDescription vmstate_memhp_state =3D {
> > +    .name =3D "acpi-ged/memhp",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D vmstate_test_use_memhp,
> > +    .fields      =3D (VMStateField[]) {
> > +        VMSTATE_MEMORY_HOTPLUG(memhp_state, AcpiGedState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static const VMStateDescription vmstate_ged_state =3D {
> > +    .name =3D "acpi-ged-state",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields      =3D (VMStateField[]) {
> > +        VMSTATE_UINT32(sel, GEDState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static const VMStateDescription vmstate_acpi_ged =3D {
> > +    .name =3D "acpi-ged",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_STRUCT(ged_state, AcpiGedState, 1,
> vmstate_ged_state, GEDState),
> > +        VMSTATE_END_OF_LIST(),
> > +    },
> > +    .subsections =3D (const VMStateDescription * []) {
> > +        &vmstate_memhp_state,
> > +        NULL
> > +    }
> > +};
> > +
> > +static void acpi_ged_class_init(ObjectClass *class, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(class);
> > +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(class);
> > +    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_CLASS(class);
> > +
> > +    dc->desc =3D "ACPI Generic Event Device";
> > +    dc->props =3D acpi_ged_properties;
> > +    dc->realize =3D acpi_ged_device_realize;
> > +    dc->vmsd =3D &vmstate_acpi_ged;
> > +
> > +    hc->plug =3D acpi_ged_device_plug_cb;
> > +
> > +    adevc->send_event =3D acpi_ged_send_event;
> > +}
> > +
> > +static const TypeInfo acpi_ged_info =3D {
> > +    .name          =3D TYPE_ACPI_GED,
> > +    .parent        =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(AcpiGedState),
> > +    .class_init    =3D acpi_ged_class_init,
> > +    .interfaces =3D (InterfaceInfo[]) {
> > +        { TYPE_HOTPLUG_HANDLER },
> > +        { TYPE_ACPI_DEVICE_IF },
> > +        { }
> > +    }
> > +};
> > +
> > +static void acpi_ged_register_types(void)
> > +{
> > +    type_register_static(&acpi_ged_info);
> > +}
> > +
> > +type_init(acpi_ged_register_types)
> > diff --git a/include/hw/acpi/generic_event_device.h
> b/include/hw/acpi/generic_event_device.h
> > new file mode 100644
> > index 0000000000..f69d084c89
> > --- /dev/null
> > +++ b/include/hw/acpi/generic_event_device.h
> > @@ -0,0 +1,102 @@
> > +/*
> > + *
> > + * Copyright (c) 2018 Intel Corporation
> > + * Copyright (c) 2019 Huawei Technologies R & D (UK) Ltd
> > + * Written by Samuel Ortiz, Shameer Kolothum
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * The ACPI Generic Event Device (GED) is a hardware-reduced specific
> > + * device[ACPI v6.1 Section 5.6.9] that handles all platform events,
> > + * including the hotplug ones. Generic Event Device allows platforms
> > + * to handle interrupts in ACPI ASL statements. It follows a very
> > + * similar approach like the _EVT method from GPIO events. All
> > + * interrupts are listed in  _CRS and the handler is written in _EVT
> > + * method. Here, we use a single interrupt for the GED device, relying
> > + * on IO memory region to communicate the type of device affected by
> > + * the interrupt. This way, we can support up to 32 events with a
> > + * unique interrupt.
> > + *
> > + * Here is an example.
> > + *
> > + * Device (\_SB.GED)
> > + * {
> > + *     Name (_HID, "ACPI0013")
> > + *     Name (_UID, Zero)
> > + *     Name (_CRS, ResourceTemplate ()
> > + *     {
> > + *         Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,=
, )
> > + *         {
> > + *              0x00000029,
> > + *         }
> > + *     })
> > + *     OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
> > + *     Field (EREG, DWordAcc, NoLock, WriteAsZeros)
> > + *     {
> > + *         ESEL,   32
> > + *     }
> > + *
> > + *     Method (_EVT, 1, Serialized)  // _EVT: Event
> > + *     {
> > + *         Local0 =3D ESEL // ESEL =3D IO memory region which specifie=
s the
> > + *                       // device type.
> > + *         If (((Local0 & One) =3D=3D One))
> > + *         {
> > + *             MethodEvent1()
> > + *         }
> > + *         If ((Local0 & 0x2) =3D=3D 0x2)
> > + *         {
> > + *             MethodEvent2()
> > + *         }
> > + *         ...
> > + *     }
> > + * }
> > + *
> > + */
> > +
> > +#ifndef HW_ACPI_GED_H
> > +#define HW_ACPI_GED_H
> > +
> > +#include "hw/acpi/memory_hotplug.h"
> > +
> > +#define TYPE_ACPI_GED "acpi-ged"
> > +#define ACPI_GED(obj) \
> > +    OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
> > +
> > +#define ACPI_GED_EVT_SEL_OFFSET    0x0
>=20
> > +#define ACPI_GED_EVT_SEL_LEN       0x4
> > +#define ACPI_GED_REG_LEN           0x4
> Didn't both macros refer to the same thing?
> Why not use the same one in AML and in QEMU MMIO handler?

Ok.

Thanks,
Shameer

>=20
> > +
> > +#define GED_DEVICE      "GED"
> > +#define AML_GED_EVT_REG "EREG"
> > +#define AML_GED_EVT_SEL "ESEL"
> > +
> > +/*
> > + * Platforms need to specify the GED event bitmap
> > + * to describe what kind of events they want to support
> > + * through GED.
> > + */
> > +#define ACPI_GED_MEM_HOTPLUG_EVT   0x1
> > +
> > +typedef struct GEDState {
> > +    MemoryRegion io;
> > +    uint32_t     sel;
> > +    QemuMutex    lock;
> > +} GEDState;
> > +
> > +typedef struct AcpiGedState {
> > +    DeviceClass parent_obj;
> > +    MemHotplugState memhp_state;
> > +    hwaddr memhp_base;
> > +    hwaddr ged_base;
> > +    GEDState ged_state;
> > +    uint32_t ged_event_bitmap;
> > +    qemu_irq irq;
> > +} AcpiGedState;
> > +
> > +void build_ged_aml(Aml *table, const char* name, HotplugHandler
> *hotplug_dev,
> > +                   uint32_t ged_irq, AmlRegionSpace rs);
> > +
> > +#endif
>=20


