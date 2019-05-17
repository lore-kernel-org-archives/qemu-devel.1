Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72046C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3585B206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3585B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYS2-0006uI-HQ
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:42:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRYQj-0006Dd-M0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRYQi-0001x3-4n
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:41:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hRYQe-0001qM-Of; Fri, 17 May 2019 04:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BE9A81129;
	Fri, 17 May 2019 08:41:22 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D838D60BE0;
	Fri, 17 May 2019 08:41:15 +0000 (UTC)
Date: Fri, 17 May 2019 10:41:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190517104109.70883a12@Igors-MacBook-Pro>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F1F0EB5@lhreml524-mbb.china.huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-4-shameerali.kolothum.thodi@huawei.com>
	<20190502181252.2e3ae0d4@Igors-MacBook-Pro>
	<5FC3163CFD30C246ABAA99954A238FA83F1EF349@lhreml524-mbb.china.huawei.com>
	<5FC3163CFD30C246ABAA99954A238FA83F1F0EB5@lhreml524-mbb.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 17 May 2019 08:41:22 +0000 (UTC)
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

On Mon, 13 May 2019 17:00:13 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: 13 May 2019 17:25
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device Support
> > 
> > On Mon, 13 May 2019 11:53:38 +0000
> > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
> > 
> > > Hi Igor,
> > >
> > > > -----Original Message-----
> > > > From: Shameerali Kolothum Thodi
> > > > Sent: 03 May 2019 13:46
> > > > To: 'Igor Mammedov' <imammedo@redhat.com>
> > > > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > > > eric.auger@redhat.com; peter.maydell@linaro.org;
> > > > shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> > > > sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> > > > lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> > > > <linuxarm@huawei.com>
> > > > Subject: RE: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device
> > Support
> > > >
> > > > Hi Igor,
> > > >
> > > > > -----Original Message-----
> > > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > > Sent: 02 May 2019 17:13
> > > > > To: Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>
> > > > > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > > > > eric.auger@redhat.com; peter.maydell@linaro.org;
> > > > > shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> > > > > sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> > > > > lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> > > > > <linuxarm@huawei.com>
> > > > > Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device
> > Support
> > > > >
> > >
> > > [...]
> > >
> > > > > > +}
> > > > > > +
> > > > > > +static Property acpi_ged_properties[] = {
> > > > > > +    /*
> > > > > > +     * Memory hotplug base address is a property of GED here,
> > > > > > +     * because GED handles memory hotplug event and
> > > > > MEMORY_HOTPLUG_DEVICE
> > > > > > +     * gets initialized when GED device is realized.
> > > > > > +     */
> > > > > > +    DEFINE_PROP_UINT64("memhp-base", AcpiGedState,
> > memhp_base,
> > > > > 0),
> > > > > > +    DEFINE_PROP_BOOL("memory-hotplug-support", AcpiGedState,
> > > > > > +                     memhp_state.is_enabled, true),
> > > > > > +    DEFINE_PROP_PTR("gsi", AcpiGedState, gsi),
> > > > >
> > > > > PTR shouldn't be used in new code, look at object_property_add_link() &
> > co
> > > >
> > > > Ok. I will take a look at that.
> > >
> > > I attempted to remove _PROP_PTR for "ged-events" and use _PROP_LINK
> > and
> > > _set_link(),
> > >
> > >
> > > diff --git a/hw/acpi/generic_event_device.c
> > b/hw/acpi/generic_event_device.c
> > > index 856ca04c01..978c8e088e 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -268,7 +268,8 @@ static Property acpi_ged_properties[] = {
> > >      DEFINE_PROP_PTR("gsi", AcpiGedState, gsi),
> > >      DEFINE_PROP_UINT64("ged-base", AcpiGedState, ged_base, 0),
> > >      DEFINE_PROP_UINT32("ged-irq", AcpiGedState, ged_irq, 0),
> > > -    DEFINE_PROP_PTR("ged-events", AcpiGedState, ged_events),
> > > +    DEFINE_PROP_LINK("ged-events", AcpiGedState, ged_events,
> > TYPE_ACPI_GED,
> > > +                     GedEvent *),
> > >      DEFINE_PROP_UINT32("ged-events-size", AcpiGedState,
> > ged_events_size, 0),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 8179b3e511..c89b7b7120 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -537,7 +537,8 @@ static inline DeviceState
> > *create_acpi_ged(VirtMachineState *vms)
> > >      qdev_prop_set_ptr(dev, "gsi", vms->gsi);
> > >      qdev_prop_set_uint64(dev, "ged-base",
> > vms->memmap[VIRT_ACPI_GED].base);
> > >      qdev_prop_set_uint32(dev, "ged-irq", vms->irqmap[VIRT_ACPI_GED]);
> > > -    qdev_prop_set_ptr(dev, "ged-events", ged_events);
> > > +    object_property_set_link(OBJECT(dev), OBJECT(ged_events),
> > "ged-events",
> > > +                             &error_abort);
> > >      qdev_prop_set_uint32(dev, "ged-events-size",
> > ARRAY_SIZE(ged_events));
> > >
> > >      object_property_add_child(qdev_get_machine(), "acpi-ged",
> > > diff --git a/include/hw/acpi/generic_event_device.h
> > b/include/hw/acpi/generic_event_device.h
> > > index 9c840d8064..588f4ecfba 100644
> > > --- a/include/hw/acpi/generic_event_device.h
> > > +++ b/include/hw/acpi/generic_event_device.h
> > > @@ -111,7 +111,7 @@ typedef struct AcpiGedState {
> > >      hwaddr ged_base;
> > >      GEDState ged_state;
> > >      uint32_t ged_irq;
> > > -    void *ged_events;
> > > +    GedEvent *ged_events;
> > >      uint32_t ged_events_size;
> > >  } AcpiGedState;
> > >
> > >
> > > And with this I get,
> > >
> > > Segmentation fault      (core dumped) ./qemu-system-aarch64-ged-v5
> > > -machine virt, -cpu cortex-a57 -machine type=virt -nographic -smp 1 -m
> > > 4G,maxmem=8G,slots=10 -drive if=none,file=ubuntu-est-5.0,id=fs -device
> > > virtio-blk-device,drive=fs -kernel Image_memhp_remove -bios
> > > QEMU_EFI_Release.fd -object memory-backend-ram,id=mem1,size=1G
> > -device
> > > pc-dimm,id=dimm1,memdev=mem1 -numa node,nodeid=0 -append
> > > "console=ttyAMA0 root=/dev/vda rw acpi=force movable_node"
> > >
> > > It looks like struct pointer cannot be used directly and has to make a QOM
> > object
> > > for DEFINE_PROP_LINK use. Not sure there is an easy way for setting ptr
> > property
> > > using link() functions. Please let me know if there any reference
> > implementation I
> > > can take a look.
> > 
> > Simple 'struct' won't work with link, it has to be QOM object.
> > 
> > Question is do we still need GedEvent array?
> > We handle only 1 irq and several event types, why not replace GedEvent
> > with with a 32bit bitmap (1 bit per event type) and pass that to
> > ged device from machine as 'int' property?
> 
> Right. That might solve the ged_events ptr issue. But we need to set the irq as
> well for the GED device. Is there a way to set the irq directly for a TYPE_DEVICE
> object? 
> 
> (I think Eric mentioned a way of setting it directly earlier but that time GED was 
> a TYPE_SYS_BUS_DEVICE. May be that is a reason to go back to SYS_BUS_DEVICE )
It's probably not necessary, I think I've found what you are looking for. Pls, take a loot at

hw/i386/pc_q35.c:
    for (i = 0; i < GSI_NUM_PINS; i++) {                                         
        qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, pcms->gsi[i]);    
    } 


> 
> Thanks,
> Shameer
> 
> > >
> > > Appreciate your help,
> > >
> > > Thanks,
> > > Shameer
> > >


