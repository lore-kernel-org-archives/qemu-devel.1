Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809FC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D32620644
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D32620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkOZ-0000YL-LT
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:51:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hOkNi-0008JE-2R
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hOkNf-0006es-Rf
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:50:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hOkNa-0006cZ-R4; Thu, 09 May 2019 10:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7625F10C6F;
	Thu,  9 May 2019 14:50:37 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-72.brq.redhat.com [10.40.204.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D2C75B680;
	Thu,  9 May 2019 14:50:32 +0000 (UTC)
Date: Thu, 9 May 2019 16:50:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190509165024.43cba5b8@Igors-MacBook-Pro>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F1B2B34@lhreml524-mbs.china.huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-4-shameerali.kolothum.thodi@huawei.com>
	<20190502181252.2e3ae0d4@Igors-MacBook-Pro>
	<5FC3163CFD30C246ABAA99954A238FA83F1B08F1@lhreml524-mbs.china.huawei.com>
	<20190503171011.398962b2@Igors-MacBook-Pro>
	<5FC3163CFD30C246ABAA99954A238FA83F1B2B34@lhreml524-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 09 May 2019 14:50:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Linuxarm <linuxarm@huawei.com>,
	"shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"xuwei \(O\)" <xuwei5@huawei.com>,
	"sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
	"lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 09:01:43 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Igor,
> 
> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: 03 May 2019 16:10
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org;
> > shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> > sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> > lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> > <linuxarm@huawei.com>
> > Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device Support
> 
> [...]
> 
> > > > type.
> > > > > +         * The resulting ASL code looks like:
> > > > > +         *
> > > > > +         * Local0 = ISEL
> > > > > +         * If ((Local0 & irq0) == irq0)
> > > > > +         * {
> > > > > +         *     MethodEvent0()
> > > > > +         * }
> > > > > +         *
> > > > > +         * If ((Local0 & irq1) == irq1)
> > > > > +         * {
> > > > > +         *     MethodEvent1()
> > > > > +         * }
> > > > > +         * ...
> > > > > +         */
> > > > Well, I'm confused.
> > > > do we actually use multiple IRQs or we use only one + MMIO for event
> > type?
> > >
> > > It is one irq + MMIO. I will change the comment block something like
> > > this,
> > 
> > change corresponding variable names as well
> 
> Ok.
> 
> > >
> > >     Local0 = ISEL
> > >     If ((Local0 & One) == One)
> > >     {
> > >         MethodEvent1()
> > >     }
> > >
> > >     If ((Local0 & 0x02) == 0x02)
> > >     {
> > >         MethodEvent2()
> > >     }
> > >     ...
> > >
> > > >
> > > > > +        for (i = 0; i < s->ged_events_size; i++) {
> > > >
> > > > > +            ged_aml = ged_event_aml(&ged_events[i]);
> > > > > +            if (!ged_aml) {
> > > > > +                continue;
> > > > > +            }
> > > > I'd get rid of ged_event_aml replace it with more 'switch':
> > > >    for (i,...)
> > > >        if_ctx = aml_if(...)
> > > >        switch (event)
> > > >           case GED_MEMORY_HOTPLUG:
> > > >                aml_append(if_ctx,
> > > > aml_call0(MEMORY_DEVICES_CONTAINER "."
> > > > MEMORY_SLOT_SCAN_METHOD))
> > > >                break
> > > >           default:
> > > >                about(); // make sure that a newly added events have
> > > > a handler
> > >
> > > Ok. I will change this.
> > >
> > > >
> > > > > +
> > > > > +            /* If ((Local1 == irq))*/
> > > > > +            if_ctx = aml_if(aml_equal(aml_and(irq_sel,
> > > > > +
> > > > aml_int(ged_events[i].selector), NULL),
> > > > > +
> > > > aml_int(ged_events[i].selector)));
> > > > > +            {
> > > > > +                /* AML for this specific type of event */
> > > > > +                aml_append(if_ctx), ged_aml);
> > > > > +            }
> > > > > +
> > > > > +            /*
> > > > > +             * We append the first "if" to the "while" context.
> > > > > +             * Other "if"s will be "elseif"s.
> > > > > +             */
> > > > > +            aml_append(evt, if_ctx);
> > > > > +        }
> > > > > +    }
> > > > > +
> > > >
> > > > > +    aml_append(dev, aml_name_decl("_HID",
> > aml_string("ACPI0013")));
> > > > > +    aml_append(dev, aml_name_decl("_UID",
> > aml_string(GED_DEVICE)));
> > > > > +    aml_append(dev, aml_name_decl("_CRS", crs));
> > > > > +
> > > > > +    /* Append IO region */
> > > > > +    aml_append(dev, aml_operation_region(AML_GED_IRQ_REG, rs,
> > > > > +               aml_int(s->ged_base + ACPI_GED_IRQ_SEL_OFFSET),
> > > > > +               ACPI_GED_IRQ_SEL_LEN));
> > > > > +    field = aml_field(AML_GED_IRQ_REG, AML_DWORD_ACC,
> > > > AML_NOLOCK,
> > > > > +                      AML_WRITE_AS_ZEROS);
> > > > > +    aml_append(field, aml_named_field(AML_GED_IRQ_SEL,
> > > > > +                                      ACPI_GED_IRQ_SEL_LEN
> > *
> > > > 8));
> > > > > +    aml_append(dev, field);
> > > >
> > > > I'd move it up above EVT() method, so it would be clear from the
> > > > begging for what device we are building AML
> > >
> > > Ok.
> > >
> > > >
> > > > > +    /* Append _EVT method */
> > > > > +    aml_append(dev, evt);
> > > > > +
> > > > > +    aml_append(table, dev);
> > > > > +}
> > > > > +
> > > > > +/* Memory read by the GED _EVT AML dynamic method */ static
> > > > > +uint64_t ged_read(void *opaque, hwaddr addr, unsigned size) {
> > > > > +    uint64_t val = 0;
> > > > > +    GEDState *ged_st = opaque;
> > > > > +
> > > > > +    switch (addr) {
> > > > > +    case ACPI_GED_IRQ_SEL_OFFSET:
> > > > > +        /* Read the selector value and reset it */
> > > > > +        qemu_mutex_lock(&ged_st->lock);
> > > > > +        val = ged_st->sel;
> > > > > +        ged_st->sel = 0;
> > > > > +        qemu_mutex_unlock(&ged_st->lock);
> > > > > +        break;
> > > > > +    default:
> > > > > +        break;
> > > > > +    }
> > > > > +
> > > > > +    return val;
> > > > > +}
> > > > > +
> > > > > +/* Nothing is expected to be written to the GED memory region */
> > > > > +static void ged_write(void *opaque, hwaddr addr, uint64_t data,
> > > > > +                      unsigned int size) { }
> > > > > +
> > > > > +static const MemoryRegionOps ged_ops = {
> > > > > +    .read = ged_read,
> > > > > +    .write = ged_write,
> > > > > +    .endianness = DEVICE_LITTLE_ENDIAN,
> > > > > +    .valid = {
> > > > > +        .min_access_size = 4,
> > > > > +        .max_access_size = 4,
> > > > > +    },
> > > > > +};
> > > > > +
> > > > > +static void acpi_ged_event(GEDState *ged_st, uint32_t
> > > > > +ged_irq_sel) {
> > > > > +    /*
> > > > > +     * Set the GED IRQ selector to the expected device type value. This
> > > > > +     * way, the ACPI method will be able to trigger the right code based
> > > > > +     * on a unique IRQ.
> > > > > +     */
> > > > > +    qemu_mutex_lock(&ged_st->lock);
> > > > > +    ged_st->sel = ged_irq_sel;
> > > > what if there are 2 events with different sel value and 2nd event
> > > > happens before guesr read the first one?
> > >
> > > This was previously,
> > >    ged_st->sel |= ged_irq_sel;
> > >
> > > and was changed based on the assumption that there won't be any
> > > multiple events. But I think the scenario above is right. I will
> > > change it back so that we won't overwrite.
> > so it was bitmap, then handling it as a DWORD in AML could be wrong and AML
> > part probably should be changed to accommodate it.
> 
> Hmm..I am slightly confused as the AML code already uses the len as 32 bits for this
> register field,
> 
>     /* Append IO region */
>     aml_append(dev, aml_operation_region(AML_GED_IRQ_REG, rs,
>                aml_int(s->ged_base + ACPI_GED_IRQ_SEL_OFFSET),
>                ACPI_GED_IRQ_SEL_LEN));
>     field = aml_field(AML_GED_IRQ_REG, AML_DWORD_ACC, AML_NOLOCK,
>                       AML_WRITE_AS_ZEROS);
>     aml_append(field, aml_named_field(AML_GED_IRQ_SEL,
>                                       ACPI_GED_IRQ_SEL_LEN * 8));
>     aml_append(dev, field);
> 
> and event check logic is, 
> 
>      if_ctx = aml_if(aml_equal(aml_and(irq_sel,
>                           aml_int(ged_events[i].selector), NULL),
>                           aml_int(ged_events[i].selector)));
> 
> Not sure what is the concern here. Please let me know. 

Looking at it second time, it seems I've been mistaken.
that 'if' should work.

one suggestion how to improve AML side,
instead of using  AML_GED_IRQ_REG DWORD + AND masking
you can use bit fields directly.
See how "aml_named_field(...,1)" is used for inspiration.


>             
> > >
> > > >
> > > > > +    qemu_mutex_unlock(&ged_st->lock);
> > > > > +
> > > > > +    /* Trigger the event by sending an interrupt to the guest. */
> > > > > +    qemu_irq_pulse(ged_st->gsi[ged_st->irq]);
> > > > > +}
> > > > > +
> > > > > +static void acpi_ged_init(MemoryRegion *as, DeviceState *dev,
> > > > > +GEDState
> > > > *ged_st)
> > > > > +{
> > > > > +    AcpiGedState *s = ACPI_GED(dev);
> > > > > +
> > > > > +    assert(s->ged_base);
> > > > > +
> > > > > +    ged_st->irq = s->ged_irq;
> > > > > +    ged_st->gsi = s->gsi;
> > > > > +    qemu_mutex_init(&ged_st->lock);
> > > > > +    memory_region_init_io(&ged_st->io, OBJECT(dev), &ged_ops,
> > ged_st,
> > > > > +                          "acpi-ged-event", ACPI_GED_REG_LEN);
> > > > > +    memory_region_add_subregion(as, s->ged_base, &ged_st->io); }
> > > > > +
> > > > > +static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
> > > > > +                                    DeviceState *dev, Error
> > > > > +**errp) {
> > > > > +    AcpiGedState *s = ACPI_GED(hotplug_dev);
> > > > > +
> > > > > +    if (s->memhp_state.is_enabled &&
> > > > > +        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > > > > +            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state,
> > > > > +                                dev, errp);
> > > > > +    } else {
> > > > > +        error_setg(errp, "virt: device plug request for
> > > > > + unsupported
> > > > device"
> > > > > +                   " type: %s",
> > object_get_typename(OBJECT(dev)));
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +static void acpi_ged_send_event(AcpiDeviceIf *adev,
> > > > > +AcpiEventStatusBits
> > > > ev)
> > > > > +{
> > > > > +    AcpiGedState *s = ACPI_GED(adev);
> > > > > +    uint32_t sel;
> > > > > +
> > > > > +    if (ev & ACPI_MEMORY_HOTPLUG_STATUS) {
> > > > > +        sel = ACPI_GED_IRQ_SEL_MEM;
> > > > > +    } else {
> > > > > +        /* Unknown event. Return without generating interrupt. */
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    /*
> > > > > +     * We inject the hotplug interrupt. The IRQ selector will make
> > > > > +     * the difference from the ACPI table.
> > > > > +     */
> > > > > +    acpi_ged_event(&s->ged_state, sel); }
> > > > > +
> > > > > +static void acpi_ged_device_realize(DeviceState *dev, Error
> > > > > +**errp) {
> > > > > +    AcpiGedState *s = ACPI_GED(dev);
> > > > > +
> > > > > +    if (s->memhp_state.is_enabled) {
> > > > > +        acpi_memory_hotplug_init(get_system_memory(),
> > OBJECT(dev),
> > > > > +                                 &s->memhp_state,
> > > > > +                                 s->memhp_base);
> > > > > +        acpi_ged_init(get_system_memory(), dev, &s->ged_state);
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +static Property acpi_ged_properties[] = {
> > > > > +    /*
> > > > > +     * Memory hotplug base address is a property of GED here,
> > > > > +     * because GED handles memory hotplug event and
> > > > MEMORY_HOTPLUG_DEVICE
> > > > > +     * gets initialized when GED device is realized.
> > > > > +     */
> > > > > +    DEFINE_PROP_UINT64("memhp-base", AcpiGedState,
> > memhp_base,
> > > > 0),
> > > > > +    DEFINE_PROP_BOOL("memory-hotplug-support", AcpiGedState,
> > > > > +                     memhp_state.is_enabled, true),
> > > > > +    DEFINE_PROP_PTR("gsi", AcpiGedState, gsi),
> > > >
> > > > PTR shouldn't be used in new code, look at
> > > > object_property_add_link() & co
> > >
> > > Ok. I will take a look at that.
> > >
> > > >
> > > > > +    DEFINE_PROP_UINT64("ged-base", AcpiGedState, ged_base, 0),
> > > > > +    DEFINE_PROP_UINT32("ged-irq", AcpiGedState, ged_irq, 0),
> > > > > +    DEFINE_PROP_PTR("ged-events", AcpiGedState, ged_events),
> > > > > +    DEFINE_PROP_UINT32("ged-events-size", AcpiGedState,
> > > > ged_events_size, 0),
> > > > > +    DEFINE_PROP_END_OF_LIST(),
> > > > > +};
> > > > > +
> > > > > +static void acpi_ged_class_init(ObjectClass *class, void *data) {
> > > > > +    DeviceClass *dc = DEVICE_CLASS(class);
> > > > > +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(class);
> > > > > +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
> > > > > +
> > > > > +    dc->desc = "ACPI";
> > > > > +    dc->props = acpi_ged_properties;
> > > > > +    dc->realize = acpi_ged_device_realize;
> > > > > +
> > > > > +    /* Reason: pointer properties "gsi" and "ged_events" */
> > > > > +    dc->user_creatable = false;
> > > > > +
> > > > > +    hc->plug = acpi_ged_device_plug_cb;
> > > > > +
> > > > > +    adevc->send_event = acpi_ged_send_event; }
> > > > > +
> > > > > +static const TypeInfo acpi_ged_info = {
> > > > > +    .name          = TYPE_ACPI_GED,
> > > > > +    .parent        = TYPE_DEVICE,
> > > > > +    .instance_size = sizeof(AcpiGedState),
> > > > > +    .class_init    = acpi_ged_class_init,
> > > > > +    .interfaces = (InterfaceInfo[]) {
> > > > > +        { TYPE_HOTPLUG_HANDLER },
> > > > > +        { TYPE_ACPI_DEVICE_IF },
> > > > > +        { }
> > > > > +    }
> > > > > +};
> > > > > +
> > > > > +static void acpi_ged_register_types(void) {
> > > > > +    type_register_static(&acpi_ged_info);
> > > > > +}
> > > > > +
> > > > > +type_init(acpi_ged_register_types)
> > > > > diff --git a/include/hw/acpi/generic_event_device.h
> > > > b/include/hw/acpi/generic_event_device.h
> > > > > new file mode 100644
> > > > > index 0000000..9c840d8
> > > > > --- /dev/null
> > > > > +++ b/include/hw/acpi/generic_event_device.h
> > > > > @@ -0,0 +1,121 @@
> > > > > +/*
> > > > > + *
> > > > > + * Copyright (c) 2018 Intel Corporation
> > > > > + *
> > > > > + * This program is free software; you can redistribute it and/or
> > > > > +modify it
> > > > > + * under the terms and conditions of the GNU General Public
> > > > > +License,
> > > > > + * version 2 or later, as published by the Free Software Foundation.
> > > > > + *
> > > > > + * This program is distributed in the hope it will be useful, but
> > > > > +WITHOUT
> > > > > + * ANY WARRANTY; without even the implied warranty of
> > > > MERCHANTABILITY or
> > > > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > > > License for
> > > > > + * more details.
> > > > > + *
> > > > > + * You should have received a copy of the GNU General Public
> > > > > + License along
> > > > with
> > > > > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > > > > + *
> > > > > + * The ACPI Generic Event Device (GED) is a hardware-reduced
> > > > > + specific
> > > > > + * device[ACPI v6.1 Section 5.6.9] that handles all platform
> > > > > + events,
> > > > > + * including the hotplug ones. Generic Event Device allows
> > > > > + platforms
> > > > > + * to handle interrupts in ACPI ASL statements. It follows a very
> > > > > + * similar approach like the _EVT method from GPIO events. All
> > > > > + * interrupts are listed in  _CRS and the handler is written in
> > > > > + _EVT
> > > > > + * method. Here, we use a single interrupt for the GED device,
> > > > > + relying
> > > > > + * on IO memory region to communicate the type of device affected
> > > > > + by
> > > > > + * the interrupt. This way, we can support up to 32 events with a
> > > > > + * unique interrupt.
> > > > > + *
> > > > > + * Here is an example.
> > > > > + *
> > > > > + * Device (\_SB.GED)
> > > > > + * {
> > > > > + *     Name (_HID, "ACPI0013")
> > > > > + *     Name (_UID, Zero)
> > > > > + *     Name (_CRS, ResourceTemplate ()
> > > > > + *     {
> > > > > + *         Interrupt (ResourceConsumer, Edge, ActiveHigh,
> > Exclusive, ,, )
> > > > > + *         {
> > > > > + *              0x00000029,
> > > > > + *         }
> > > > > + *     })
> > > > > + *     OperationRegion (IREG, SystemMemory, 0x09080000, 0x04)
> > > > > + *     Field (IREG, DWordAcc, NoLock, WriteAsZeros)
> > > > > + *     {
> > > > > + *         ISEL,   32
> > > > > + *     }
> > > > > + *
> > > > > + *     Method (_EVT, 1, Serialized)  // _EVT: Event
> > > > > + *     {
> > > > > + *         Local0 = ISEL // ISEL = IO memory region which specifies the
> > > > > + *                       // device type.
> > > > > + *         If (((Local0 & irq0) == irq0))
> > > > > + *         {
> > > > > + *             MethodEvent0()
> > > > > + *         }
> > > > > + *         ElseIf ((Local0 & irq1) == irq1)
> > > > > + *         {
> > > > > + *             MethodEvent1()
> > > > > + *         }
> > > > > + *         ...
> > > > > + *     }
> > > > > + * }
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#ifndef HW_ACPI_GED_H
> > > > > +#define HW_ACPI_GED_H
> > > > > +
> > > > > +#include "hw/acpi/memory_hotplug.h"
> > > > > +
> > > > > +#define TYPE_ACPI_GED "acpi-ged"
> > > > > +#define ACPI_GED(obj) \
> > > > > +    OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
> > > > > +
> > > > > +#define ACPI_GED_IRQ_SEL_OFFSET 0x0
> > > > > +#define ACPI_GED_IRQ_SEL_LEN    0x4
> > > > > +#define ACPI_GED_IRQ_SEL_MEM    0x1
> > > > > +#define ACPI_GED_REG_LEN        0x4
> > > > > +
> > > > > +#define GED_DEVICE      "GED"
> > > > > +#define AML_GED_IRQ_REG "IREG"
> > > > > +#define AML_GED_IRQ_SEL "ISEL"
> > > > > +
> > > > > +typedef enum {
> > > > > +    GED_MEMORY_HOTPLUG = 1,
> > > > > +} GedEventType;
> > > > > +
> > > > > +/*
> > > > > + * Platforms need to specify their own GedEvent array
> > > > > + * to describe what kind of events they want to support
> > > > > + * through GED.
> > > > > + */
> > > > > +typedef struct GedEvent {
> > > > > +    uint32_t     selector;
> > > > > +    GedEventType event;
> > > > > +} GedEvent;
> > > > > +
> > > > > +typedef struct GEDState {
> > > > > +    MemoryRegion io;
> > > > > +    uint32_t     sel;
> > > >
> > > > do we need to migrate this during migration?
> > >
> > > TBH, I don't know and currently this series doesn't address migration
> > > as we don't have any VMStateDescription and friends. Is this something
> > > we can sort later?
> > 
> > It probably should be implemented, otherwise we will have to deal with hard to
> > debug bug reports when users will try to migrate.
> > 
> > Alternative hack could be that, enabling memory hotplug should put migration
> > blocker, but that's probably the same effort as adding proper
> > VMStateDescription
> 
> Ok. I will take a look into VMStateDescription then.
> 
> Thanks,
> Shameer
> 
> > >
> > > Thanks,
> > > Shameer
> > >
> > > > > +    uint32_t     irq;
> > > > > +    qemu_irq     *gsi;
> > > > > +    QemuMutex    lock;
> > > > > +} GEDState;
> > > > > +
> > > > > +
> > > > > +typedef struct AcpiGedState {
> > > > > +    DeviceClass parent_obj;
> > > > > +    MemHotplugState memhp_state;
> > > > > +    hwaddr memhp_base;
> > > > > +    void *gsi;
> > > > > +    hwaddr ged_base;
> > > > > +    GEDState ged_state;
> > > > > +    uint32_t ged_irq;
> > > > > +    void *ged_events;
> > > > > +    uint32_t ged_events_size;
> > > > > +} AcpiGedState;
> > > > > +
> > > > > +void build_ged_aml(Aml *table, const char* name, HotplugHandler
> > > > *hotplug_dev,
> > > > > +                   uint32_t ged_irq, AmlRegionSpace rs);
> > > > > +
> > > > > +#endif
> > >
> 
> 


