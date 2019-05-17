Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3B7C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D82A20879
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D82A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRaiQ-0007Tu-LW
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:07:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hRa9Q-00015F-8j
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hRa9O-0002Zw-PB
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:31:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45406 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hRa9J-0002OG-Ek; Fri, 17 May 2019 06:31:37 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id D1D729E2DCF08A7E1237;
	Fri, 17 May 2019 11:31:24 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.4]) by
	lhreml705-cah.china.huawei.com ([10.201.108.46]) with mapi id
	14.03.0415.000; Fri, 17 May 2019 11:31:15 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device Support
Thread-Index: AQHU7r9fDZwDNe9r+EiYOfOuYN+yBqZYFYcAgAFHvsCAD8XcEIAAWT3wgAWt7ICAAC5E4A==
Date: Fri, 17 May 2019 10:31:15 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F205468@lhreml524-mbs.china.huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-4-shameerali.kolothum.thodi@huawei.com>
	<20190502181252.2e3ae0d4@Igors-MacBook-Pro>
	<5FC3163CFD30C246ABAA99954A238FA83F1EF349@lhreml524-mbb.china.huawei.com>
	<5FC3163CFD30C246ABAA99954A238FA83F1F0EB5@lhreml524-mbb.china.huawei.com>
	<20190517104109.70883a12@Igors-MacBook-Pro>
In-Reply-To: <20190517104109.70883a12@Igors-MacBook-Pro>
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
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Linuxarm <linuxarm@huawei.com>,
	"shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "xuwei
	\(O\)" <xuwei5@huawei.com>,
	"sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
	"lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 17 May 2019 09:41
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> shannon.zhaosl@gmail.com; ard.biesheuvel@linaro.org;
> qemu-devel@nongnu.org; Linuxarm <linuxarm@huawei.com>;
> eric.auger@redhat.com; qemu-arm@nongnu.org; xuwei (O)
> <xuwei5@huawei.com>; sebastien.boeuf@intel.com; lersek@redhat.com
> Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device Suppor=
t
>=20
> On Mon, 13 May 2019 17:00:13 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > Sent: 13 May 2019 17:25
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device
> > > Support
> > >
> > > On Mon, 13 May 2019 11:53:38 +0000
> > > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> wrote:
> > >
> > > > Hi Igor,
> > > >
> > > > > -----Original Message-----
> > > > > From: Shameerali Kolothum Thodi
> > > > > Sent: 03 May 2019 13:46
> > > > > To: 'Igor Mammedov' <imammedo@redhat.com>
> > > > > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > > > > eric.auger@redhat.com; peter.maydell@linaro.org;
> > > > > shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> > > > > sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> > > > > lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> > > > > <linuxarm@huawei.com>
> > > > > Subject: RE: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event
> > > > > Device
> > > Support
> > > > >
> > > > > Hi Igor,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > > > Sent: 02 May 2019 17:13
> > > > > > To: Shameerali Kolothum Thodi
> > > <shameerali.kolothum.thodi@huawei.com>
> > > > > > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > > > > > eric.auger@redhat.com; peter.maydell@linaro.org;
> > > > > > shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> > > > > > sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> > > > > > lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> > > > > > <linuxarm@huawei.com>
> > > > > > Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event
> > > > > > Device
> > > Support
> > > > > >
> > > >
> > > > [...]
> > > >
> > > > > > > +}
> > > > > > > +
> > > > > > > +static Property acpi_ged_properties[] =3D {
> > > > > > > +    /*
> > > > > > > +     * Memory hotplug base address is a property of GED here=
,
> > > > > > > +     * because GED handles memory hotplug event and
> > > > > > MEMORY_HOTPLUG_DEVICE
> > > > > > > +     * gets initialized when GED device is realized.
> > > > > > > +     */
> > > > > > > +    DEFINE_PROP_UINT64("memhp-base", AcpiGedState,
> > > memhp_base,
> > > > > > 0),
> > > > > > > +    DEFINE_PROP_BOOL("memory-hotplug-support",
> AcpiGedState,
> > > > > > > +                     memhp_state.is_enabled, true),
> > > > > > > +    DEFINE_PROP_PTR("gsi", AcpiGedState, gsi),
> > > > > >
> > > > > > PTR shouldn't be used in new code, look at
> > > > > > object_property_add_link() &
> > > co
> > > > >
> > > > > Ok. I will take a look at that.
> > > >
> > > > I attempted to remove _PROP_PTR for "ged-events" and use
> > > > _PROP_LINK
> > > and
> > > > _set_link(),
> > > >
> > > >
> > > > diff --git a/hw/acpi/generic_event_device.c
> > > b/hw/acpi/generic_event_device.c
> > > > index 856ca04c01..978c8e088e 100644
> > > > --- a/hw/acpi/generic_event_device.c
> > > > +++ b/hw/acpi/generic_event_device.c
> > > > @@ -268,7 +268,8 @@ static Property acpi_ged_properties[] =3D {
> > > >      DEFINE_PROP_PTR("gsi", AcpiGedState, gsi),
> > > >      DEFINE_PROP_UINT64("ged-base", AcpiGedState, ged_base, 0),
> > > >      DEFINE_PROP_UINT32("ged-irq", AcpiGedState, ged_irq, 0),
> > > > -    DEFINE_PROP_PTR("ged-events", AcpiGedState, ged_events),
> > > > +    DEFINE_PROP_LINK("ged-events", AcpiGedState, ged_events,
> > > TYPE_ACPI_GED,
> > > > +                     GedEvent *),
> > > >      DEFINE_PROP_UINT32("ged-events-size", AcpiGedState,
> > > ged_events_size, 0),
> > > >      DEFINE_PROP_END_OF_LIST(),
> > > >  };
> > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c index
> > > > 8179b3e511..c89b7b7120 100644
> > > > --- a/hw/arm/virt.c
> > > > +++ b/hw/arm/virt.c
> > > > @@ -537,7 +537,8 @@ static inline DeviceState
> > > *create_acpi_ged(VirtMachineState *vms)
> > > >      qdev_prop_set_ptr(dev, "gsi", vms->gsi);
> > > >      qdev_prop_set_uint64(dev, "ged-base",
> > > vms->memmap[VIRT_ACPI_GED].base);
> > > >      qdev_prop_set_uint32(dev, "ged-irq",
> vms->irqmap[VIRT_ACPI_GED]);
> > > > -    qdev_prop_set_ptr(dev, "ged-events", ged_events);
> > > > +    object_property_set_link(OBJECT(dev), OBJECT(ged_events),
> > > "ged-events",
> > > > +                             &error_abort);
> > > >      qdev_prop_set_uint32(dev, "ged-events-size",
> > > ARRAY_SIZE(ged_events));
> > > >
> > > >      object_property_add_child(qdev_get_machine(), "acpi-ged",
> > > > diff --git a/include/hw/acpi/generic_event_device.h
> > > b/include/hw/acpi/generic_event_device.h
> > > > index 9c840d8064..588f4ecfba 100644
> > > > --- a/include/hw/acpi/generic_event_device.h
> > > > +++ b/include/hw/acpi/generic_event_device.h
> > > > @@ -111,7 +111,7 @@ typedef struct AcpiGedState {
> > > >      hwaddr ged_base;
> > > >      GEDState ged_state;
> > > >      uint32_t ged_irq;
> > > > -    void *ged_events;
> > > > +    GedEvent *ged_events;
> > > >      uint32_t ged_events_size;
> > > >  } AcpiGedState;
> > > >
> > > >
> > > > And with this I get,
> > > >
> > > > Segmentation fault      (core dumped) ./qemu-system-aarch64-ged-v5
> > > > -machine virt, -cpu cortex-a57 -machine type=3Dvirt -nographic -smp
> > > > 1 -m
> > > > 4G,maxmem=3D8G,slots=3D10 -drive if=3Dnone,file=3Dubuntu-est-5.0,id=
=3Dfs
> > > > -device virtio-blk-device,drive=3Dfs -kernel Image_memhp_remove
> > > > -bios QEMU_EFI_Release.fd -object
> > > > memory-backend-ram,id=3Dmem1,size=3D1G
> > > -device
> > > > pc-dimm,id=3Ddimm1,memdev=3Dmem1 -numa node,nodeid=3D0 -append
> > > > "console=3DttyAMA0 root=3D/dev/vda rw acpi=3Dforce movable_node"
> > > >
> > > > It looks like struct pointer cannot be used directly and has to
> > > > make a QOM
> > > object
> > > > for DEFINE_PROP_LINK use. Not sure there is an easy way for
> > > > setting ptr
> > > property
> > > > using link() functions. Please let me know if there any reference
> > > implementation I
> > > > can take a look.
> > >
> > > Simple 'struct' won't work with link, it has to be QOM object.
> > >
> > > Question is do we still need GedEvent array?
> > > We handle only 1 irq and several event types, why not replace
> > > GedEvent with with a 32bit bitmap (1 bit per event type) and pass
> > > that to ged device from machine as 'int' property?
> >
> > Right. That might solve the ged_events ptr issue. But we need to set
> > the irq as well for the GED device. Is there a way to set the irq
> > directly for a TYPE_DEVICE object?
> >
> > (I think Eric mentioned a way of setting it directly earlier but that
> > time GED was a TYPE_SYS_BUS_DEVICE. May be that is a reason to go back
> > to SYS_BUS_DEVICE )
> It's probably not necessary, I think I've found what you are looking for.=
 Pls, take
> a loot at
>=20
> hw/i386/pc_q35.c:
>     for (i =3D 0; i < GSI_NUM_PINS; i++) {
>         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i,
> pcms->gsi[i]);
>     }
>=20

Cool!. Just tried and it works. Thanks for that.

I am going through other comments as well and hopefully will be able to
post a v5 soon.

Cheers,
Shameer

> >
> > Thanks,
> > Shameer
> >
> > > >
> > > > Appreciate your help,
> > > >
> > > > Thanks,
> > > > Shameer
> > > >


