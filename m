Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F4C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659D6204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659D6204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNw0I-0006lO-Jy
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:03:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hNvzK-0006Q6-A4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hNvzC-0000wS-Re
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:02:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45399 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hNvz4-0000qV-RU; Tue, 07 May 2019 05:01:59 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
	by Forcepoint Email with ESMTP id B3CE0DA59237C658F67B;
	Tue,  7 May 2019 10:01:53 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.137]) by
	lhreml709-cah.china.huawei.com ([10.201.108.32]) with mapi id
	14.03.0415.000; Tue, 7 May 2019 10:01:44 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device Support
Thread-Index: AQHU7r9fDZwDNe9r+EiYOfOuYN+yBqZYFYcAgAFHvsCAADkTgIAF5RoQ
Date: Tue, 7 May 2019 09:01:43 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F1B2B34@lhreml524-mbs.china.huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-4-shameerali.kolothum.thodi@huawei.com>
	<20190502181252.2e3ae0d4@Igors-MacBook-Pro>
	<5FC3163CFD30C246ABAA99954A238FA83F1B08F1@lhreml524-mbs.china.huawei.com>
	<20190503171011.398962b2@Igors-MacBook-Pro>
In-Reply-To: <20190503171011.398962b2@Igors-MacBook-Pro>
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
Subject: Re: [Qemu-devel] [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event
 Device Support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"xuwei \(O\)" <xuwei5@huawei.com>,
	"sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
	"lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 03 May 2019 16:10
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device Suppor=
t

[...]

> > > type.
> > > > +         * The resulting ASL code looks like:
> > > > +         *
> > > > +         * Local0 =3D ISEL
> > > > +         * If ((Local0 & irq0) =3D=3D irq0)
> > > > +         * {
> > > > +         *     MethodEvent0()
> > > > +         * }
> > > > +         *
> > > > +         * If ((Local0 & irq1) =3D=3D irq1)
> > > > +         * {
> > > > +         *     MethodEvent1()
> > > > +         * }
> > > > +         * ...
> > > > +         */
> > > Well, I'm confused.
> > > do we actually use multiple IRQs or we use only one + MMIO for event
> type?
> >
> > It is one irq + MMIO. I will change the comment block something like
> > this,
>=20
> change corresponding variable names as well

Ok.

> >
> >     Local0 =3D ISEL
> >     If ((Local0 & One) =3D=3D One)
> >     {
> >         MethodEvent1()
> >     }
> >
> >     If ((Local0 & 0x02) =3D=3D 0x02)
> >     {
> >         MethodEvent2()
> >     }
> >     ...
> >
> > >
> > > > +        for (i =3D 0; i < s->ged_events_size; i++) {
> > >
> > > > +            ged_aml =3D ged_event_aml(&ged_events[i]);
> > > > +            if (!ged_aml) {
> > > > +                continue;
> > > > +            }
> > > I'd get rid of ged_event_aml replace it with more 'switch':
> > >    for (i,...)
> > >        if_ctx =3D aml_if(...)
> > >        switch (event)
> > >           case GED_MEMORY_HOTPLUG:
> > >                aml_append(if_ctx,
> > > aml_call0(MEMORY_DEVICES_CONTAINER "."
> > > MEMORY_SLOT_SCAN_METHOD))
> > >                break
> > >           default:
> > >                about(); // make sure that a newly added events have
> > > a handler
> >
> > Ok. I will change this.
> >
> > >
> > > > +
> > > > +            /* If ((Local1 =3D=3D irq))*/
> > > > +            if_ctx =3D aml_if(aml_equal(aml_and(irq_sel,
> > > > +
> > > aml_int(ged_events[i].selector), NULL),
> > > > +
> > > aml_int(ged_events[i].selector)));
> > > > +            {
> > > > +                /* AML for this specific type of event */
> > > > +                aml_append(if_ctx), ged_aml);
> > > > +            }
> > > > +
> > > > +            /*
> > > > +             * We append the first "if" to the "while" context.
> > > > +             * Other "if"s will be "elseif"s.
> > > > +             */
> > > > +            aml_append(evt, if_ctx);
> > > > +        }
> > > > +    }
> > > > +
> > >
> > > > +    aml_append(dev, aml_name_decl("_HID",
> aml_string("ACPI0013")));
> > > > +    aml_append(dev, aml_name_decl("_UID",
> aml_string(GED_DEVICE)));
> > > > +    aml_append(dev, aml_name_decl("_CRS", crs));
> > > > +
> > > > +    /* Append IO region */
> > > > +    aml_append(dev, aml_operation_region(AML_GED_IRQ_REG, rs,
> > > > +               aml_int(s->ged_base + ACPI_GED_IRQ_SEL_OFFSET),
> > > > +               ACPI_GED_IRQ_SEL_LEN));
> > > > +    field =3D aml_field(AML_GED_IRQ_REG, AML_DWORD_ACC,
> > > AML_NOLOCK,
> > > > +                      AML_WRITE_AS_ZEROS);
> > > > +    aml_append(field, aml_named_field(AML_GED_IRQ_SEL,
> > > > +                                      ACPI_GED_IRQ_SEL_LEN
> *
> > > 8));
> > > > +    aml_append(dev, field);
> > >
> > > I'd move it up above EVT() method, so it would be clear from the
> > > begging for what device we are building AML
> >
> > Ok.
> >
> > >
> > > > +    /* Append _EVT method */
> > > > +    aml_append(dev, evt);
> > > > +
> > > > +    aml_append(table, dev);
> > > > +}
> > > > +
> > > > +/* Memory read by the GED _EVT AML dynamic method */ static
> > > > +uint64_t ged_read(void *opaque, hwaddr addr, unsigned size) {
> > > > +    uint64_t val =3D 0;
> > > > +    GEDState *ged_st =3D opaque;
> > > > +
> > > > +    switch (addr) {
> > > > +    case ACPI_GED_IRQ_SEL_OFFSET:
> > > > +        /* Read the selector value and reset it */
> > > > +        qemu_mutex_lock(&ged_st->lock);
> > > > +        val =3D ged_st->sel;
> > > > +        ged_st->sel =3D 0;
> > > > +        qemu_mutex_unlock(&ged_st->lock);
> > > > +        break;
> > > > +    default:
> > > > +        break;
> > > > +    }
> > > > +
> > > > +    return val;
> > > > +}
> > > > +
> > > > +/* Nothing is expected to be written to the GED memory region */
> > > > +static void ged_write(void *opaque, hwaddr addr, uint64_t data,
> > > > +                      unsigned int size) { }
> > > > +
> > > > +static const MemoryRegionOps ged_ops =3D {
> > > > +    .read =3D ged_read,
> > > > +    .write =3D ged_write,
> > > > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > > +    .valid =3D {
> > > > +        .min_access_size =3D 4,
> > > > +        .max_access_size =3D 4,
> > > > +    },
> > > > +};
> > > > +
> > > > +static void acpi_ged_event(GEDState *ged_st, uint32_t
> > > > +ged_irq_sel) {
> > > > +    /*
> > > > +     * Set the GED IRQ selector to the expected device type value.=
 This
> > > > +     * way, the ACPI method will be able to trigger the right code=
 based
> > > > +     * on a unique IRQ.
> > > > +     */
> > > > +    qemu_mutex_lock(&ged_st->lock);
> > > > +    ged_st->sel =3D ged_irq_sel;
> > > what if there are 2 events with different sel value and 2nd event
> > > happens before guesr read the first one?
> >
> > This was previously,
> >    ged_st->sel |=3D ged_irq_sel;
> >
> > and was changed based on the assumption that there won't be any
> > multiple events. But I think the scenario above is right. I will
> > change it back so that we won't overwrite.
> so it was bitmap, then handling it as a DWORD in AML could be wrong and A=
ML
> part probably should be changed to accommodate it.

Hmm..I am slightly confused as the AML code already uses the len as 32 bits=
 for this
register field,

    /* Append IO region */
    aml_append(dev, aml_operation_region(AML_GED_IRQ_REG, rs,
               aml_int(s->ged_base + ACPI_GED_IRQ_SEL_OFFSET),
               ACPI_GED_IRQ_SEL_LEN));
    field =3D aml_field(AML_GED_IRQ_REG, AML_DWORD_ACC, AML_NOLOCK,
                      AML_WRITE_AS_ZEROS);
    aml_append(field, aml_named_field(AML_GED_IRQ_SEL,
                                      ACPI_GED_IRQ_SEL_LEN * 8));
    aml_append(dev, field);

and event check logic is,=20

     if_ctx =3D aml_if(aml_equal(aml_and(irq_sel,
                          aml_int(ged_events[i].selector), NULL),
                          aml_int(ged_events[i].selector)));

Not sure what is the concern here. Please let me know.=20
           =20
> >
> > >
> > > > +    qemu_mutex_unlock(&ged_st->lock);
> > > > +
> > > > +    /* Trigger the event by sending an interrupt to the guest. */
> > > > +    qemu_irq_pulse(ged_st->gsi[ged_st->irq]);
> > > > +}
> > > > +
> > > > +static void acpi_ged_init(MemoryRegion *as, DeviceState *dev,
> > > > +GEDState
> > > *ged_st)
> > > > +{
> > > > +    AcpiGedState *s =3D ACPI_GED(dev);
> > > > +
> > > > +    assert(s->ged_base);
> > > > +
> > > > +    ged_st->irq =3D s->ged_irq;
> > > > +    ged_st->gsi =3D s->gsi;
> > > > +    qemu_mutex_init(&ged_st->lock);
> > > > +    memory_region_init_io(&ged_st->io, OBJECT(dev), &ged_ops,
> ged_st,
> > > > +                          "acpi-ged-event", ACPI_GED_REG_LEN);
> > > > +    memory_region_add_subregion(as, s->ged_base, &ged_st->io); }
> > > > +
> > > > +static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
> > > > +                                    DeviceState *dev, Error
> > > > +**errp) {
> > > > +    AcpiGedState *s =3D ACPI_GED(hotplug_dev);
> > > > +
> > > > +    if (s->memhp_state.is_enabled &&
> > > > +        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > > > +            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state,
> > > > +                                dev, errp);
> > > > +    } else {
> > > > +        error_setg(errp, "virt: device plug request for
> > > > + unsupported
> > > device"
> > > > +                   " type: %s",
> object_get_typename(OBJECT(dev)));
> > > > +    }
> > > > +}
> > > > +
> > > > +static void acpi_ged_send_event(AcpiDeviceIf *adev,
> > > > +AcpiEventStatusBits
> > > ev)
> > > > +{
> > > > +    AcpiGedState *s =3D ACPI_GED(adev);
> > > > +    uint32_t sel;
> > > > +
> > > > +    if (ev & ACPI_MEMORY_HOTPLUG_STATUS) {
> > > > +        sel =3D ACPI_GED_IRQ_SEL_MEM;
> > > > +    } else {
> > > > +        /* Unknown event. Return without generating interrupt. */
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    /*
> > > > +     * We inject the hotplug interrupt. The IRQ selector will make
> > > > +     * the difference from the ACPI table.
> > > > +     */
> > > > +    acpi_ged_event(&s->ged_state, sel); }
> > > > +
> > > > +static void acpi_ged_device_realize(DeviceState *dev, Error
> > > > +**errp) {
> > > > +    AcpiGedState *s =3D ACPI_GED(dev);
> > > > +
> > > > +    if (s->memhp_state.is_enabled) {
> > > > +        acpi_memory_hotplug_init(get_system_memory(),
> OBJECT(dev),
> > > > +                                 &s->memhp_state,
> > > > +                                 s->memhp_base);
> > > > +        acpi_ged_init(get_system_memory(), dev, &s->ged_state);
> > > > +    }
> > > > +}
> > > > +
> > > > +static Property acpi_ged_properties[] =3D {
> > > > +    /*
> > > > +     * Memory hotplug base address is a property of GED here,
> > > > +     * because GED handles memory hotplug event and
> > > MEMORY_HOTPLUG_DEVICE
> > > > +     * gets initialized when GED device is realized.
> > > > +     */
> > > > +    DEFINE_PROP_UINT64("memhp-base", AcpiGedState,
> memhp_base,
> > > 0),
> > > > +    DEFINE_PROP_BOOL("memory-hotplug-support", AcpiGedState,
> > > > +                     memhp_state.is_enabled, true),
> > > > +    DEFINE_PROP_PTR("gsi", AcpiGedState, gsi),
> > >
> > > PTR shouldn't be used in new code, look at
> > > object_property_add_link() & co
> >
> > Ok. I will take a look at that.
> >
> > >
> > > > +    DEFINE_PROP_UINT64("ged-base", AcpiGedState, ged_base, 0),
> > > > +    DEFINE_PROP_UINT32("ged-irq", AcpiGedState, ged_irq, 0),
> > > > +    DEFINE_PROP_PTR("ged-events", AcpiGedState, ged_events),
> > > > +    DEFINE_PROP_UINT32("ged-events-size", AcpiGedState,
> > > ged_events_size, 0),
> > > > +    DEFINE_PROP_END_OF_LIST(),
> > > > +};
> > > > +
> > > > +static void acpi_ged_class_init(ObjectClass *class, void *data) {
> > > > +    DeviceClass *dc =3D DEVICE_CLASS(class);
> > > > +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(class);
> > > > +    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_CLASS(class);
> > > > +
> > > > +    dc->desc =3D "ACPI";
> > > > +    dc->props =3D acpi_ged_properties;
> > > > +    dc->realize =3D acpi_ged_device_realize;
> > > > +
> > > > +    /* Reason: pointer properties "gsi" and "ged_events" */
> > > > +    dc->user_creatable =3D false;
> > > > +
> > > > +    hc->plug =3D acpi_ged_device_plug_cb;
> > > > +
> > > > +    adevc->send_event =3D acpi_ged_send_event; }
> > > > +
> > > > +static const TypeInfo acpi_ged_info =3D {
> > > > +    .name          =3D TYPE_ACPI_GED,
> > > > +    .parent        =3D TYPE_DEVICE,
> > > > +    .instance_size =3D sizeof(AcpiGedState),
> > > > +    .class_init    =3D acpi_ged_class_init,
> > > > +    .interfaces =3D (InterfaceInfo[]) {
> > > > +        { TYPE_HOTPLUG_HANDLER },
> > > > +        { TYPE_ACPI_DEVICE_IF },
> > > > +        { }
> > > > +    }
> > > > +};
> > > > +
> > > > +static void acpi_ged_register_types(void) {
> > > > +    type_register_static(&acpi_ged_info);
> > > > +}
> > > > +
> > > > +type_init(acpi_ged_register_types)
> > > > diff --git a/include/hw/acpi/generic_event_device.h
> > > b/include/hw/acpi/generic_event_device.h
> > > > new file mode 100644
> > > > index 0000000..9c840d8
> > > > --- /dev/null
> > > > +++ b/include/hw/acpi/generic_event_device.h
> > > > @@ -0,0 +1,121 @@
> > > > +/*
> > > > + *
> > > > + * Copyright (c) 2018 Intel Corporation
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or
> > > > +modify it
> > > > + * under the terms and conditions of the GNU General Public
> > > > +License,
> > > > + * version 2 or later, as published by the Free Software Foundatio=
n.
> > > > + *
> > > > + * This program is distributed in the hope it will be useful, but
> > > > +WITHOUT
> > > > + * ANY WARRANTY; without even the implied warranty of
> > > MERCHANTABILITY or
> > > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > > License for
> > > > + * more details.
> > > > + *
> > > > + * You should have received a copy of the GNU General Public
> > > > + License along
> > > with
> > > > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > > > + *
> > > > + * The ACPI Generic Event Device (GED) is a hardware-reduced
> > > > + specific
> > > > + * device[ACPI v6.1 Section 5.6.9] that handles all platform
> > > > + events,
> > > > + * including the hotplug ones. Generic Event Device allows
> > > > + platforms
> > > > + * to handle interrupts in ACPI ASL statements. It follows a very
> > > > + * similar approach like the _EVT method from GPIO events. All
> > > > + * interrupts are listed in  _CRS and the handler is written in
> > > > + _EVT
> > > > + * method. Here, we use a single interrupt for the GED device,
> > > > + relying
> > > > + * on IO memory region to communicate the type of device affected
> > > > + by
> > > > + * the interrupt. This way, we can support up to 32 events with a
> > > > + * unique interrupt.
> > > > + *
> > > > + * Here is an example.
> > > > + *
> > > > + * Device (\_SB.GED)
> > > > + * {
> > > > + *     Name (_HID, "ACPI0013")
> > > > + *     Name (_UID, Zero)
> > > > + *     Name (_CRS, ResourceTemplate ()
> > > > + *     {
> > > > + *         Interrupt (ResourceConsumer, Edge, ActiveHigh,
> Exclusive, ,, )
> > > > + *         {
> > > > + *              0x00000029,
> > > > + *         }
> > > > + *     })
> > > > + *     OperationRegion (IREG, SystemMemory, 0x09080000, 0x04)
> > > > + *     Field (IREG, DWordAcc, NoLock, WriteAsZeros)
> > > > + *     {
> > > > + *         ISEL,   32
> > > > + *     }
> > > > + *
> > > > + *     Method (_EVT, 1, Serialized)  // _EVT: Event
> > > > + *     {
> > > > + *         Local0 =3D ISEL // ISEL =3D IO memory region which spec=
ifies the
> > > > + *                       // device type.
> > > > + *         If (((Local0 & irq0) =3D=3D irq0))
> > > > + *         {
> > > > + *             MethodEvent0()
> > > > + *         }
> > > > + *         ElseIf ((Local0 & irq1) =3D=3D irq1)
> > > > + *         {
> > > > + *             MethodEvent1()
> > > > + *         }
> > > > + *         ...
> > > > + *     }
> > > > + * }
> > > > + *
> > > > + */
> > > > +
> > > > +#ifndef HW_ACPI_GED_H
> > > > +#define HW_ACPI_GED_H
> > > > +
> > > > +#include "hw/acpi/memory_hotplug.h"
> > > > +
> > > > +#define TYPE_ACPI_GED "acpi-ged"
> > > > +#define ACPI_GED(obj) \
> > > > +    OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
> > > > +
> > > > +#define ACPI_GED_IRQ_SEL_OFFSET 0x0
> > > > +#define ACPI_GED_IRQ_SEL_LEN    0x4
> > > > +#define ACPI_GED_IRQ_SEL_MEM    0x1
> > > > +#define ACPI_GED_REG_LEN        0x4
> > > > +
> > > > +#define GED_DEVICE      "GED"
> > > > +#define AML_GED_IRQ_REG "IREG"
> > > > +#define AML_GED_IRQ_SEL "ISEL"
> > > > +
> > > > +typedef enum {
> > > > +    GED_MEMORY_HOTPLUG =3D 1,
> > > > +} GedEventType;
> > > > +
> > > > +/*
> > > > + * Platforms need to specify their own GedEvent array
> > > > + * to describe what kind of events they want to support
> > > > + * through GED.
> > > > + */
> > > > +typedef struct GedEvent {
> > > > +    uint32_t     selector;
> > > > +    GedEventType event;
> > > > +} GedEvent;
> > > > +
> > > > +typedef struct GEDState {
> > > > +    MemoryRegion io;
> > > > +    uint32_t     sel;
> > >
> > > do we need to migrate this during migration?
> >
> > TBH, I don't know and currently this series doesn't address migration
> > as we don't have any VMStateDescription and friends. Is this something
> > we can sort later?
>=20
> It probably should be implemented, otherwise we will have to deal with ha=
rd to
> debug bug reports when users will try to migrate.
>=20
> Alternative hack could be that, enabling memory hotplug should put migrat=
ion
> blocker, but that's probably the same effort as adding proper
> VMStateDescription

Ok. I will take a look into VMStateDescription then.

Thanks,
Shameer

> >
> > Thanks,
> > Shameer
> >
> > > > +    uint32_t     irq;
> > > > +    qemu_irq     *gsi;
> > > > +    QemuMutex    lock;
> > > > +} GEDState;
> > > > +
> > > > +
> > > > +typedef struct AcpiGedState {
> > > > +    DeviceClass parent_obj;
> > > > +    MemHotplugState memhp_state;
> > > > +    hwaddr memhp_base;
> > > > +    void *gsi;
> > > > +    hwaddr ged_base;
> > > > +    GEDState ged_state;
> > > > +    uint32_t ged_irq;
> > > > +    void *ged_events;
> > > > +    uint32_t ged_events_size;
> > > > +} AcpiGedState;
> > > > +
> > > > +void build_ged_aml(Aml *table, const char* name, HotplugHandler
> > > *hotplug_dev,
> > > > +                   uint32_t ged_irq, AmlRegionSpace rs);
> > > > +
> > > > +#endif
> >


