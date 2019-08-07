Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62855C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34393218FE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34393218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMVW-0004Bc-B5
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34201)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hvMV3-0003ec-6z
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hvMV1-0005pX-IJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:01:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45432 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hvMUr-0005jU-Ty; Wed, 07 Aug 2019 10:00:58 -0400
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 320F7C4A2FBCADE7A1B8;
 Wed,  7 Aug 2019 15:00:53 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.132]) by
 lhreml706-cah.china.huawei.com ([10.201.108.47]) with mapi id 14.03.0415.000; 
 Wed, 7 Aug 2019 15:00:46 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH-for-4.2 v8 6/9] hw/arm/virt: Enable device
 memory cold/hot plug with ACPI boot
Thread-Index: AQHVTFgcgZAsgDGlxk2I68tSjBvK8KbvVrTQgAABHQCAAF82sA==
Date: Wed, 7 Aug 2019 14:00:44 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F347DE7@lhreml524-mbs.china.huawei.com>
References: <20190726104519.23812-1-shameerali.kolothum.thodi@huawei.com>
 <20190726104519.23812-7-shameerali.kolothum.thodi@huawei.com>
 <20190806150839.350a5add@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83F347054@lhreml524-mbs.china.huawei.com>
 <20190807111520.40592817@redhat.com>
In-Reply-To: <20190807111520.40592817@redhat.com>
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
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 6/9] hw/arm/virt: Enable device
 memory cold/hot plug with ACPI boot
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
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 07 August 2019 10:15
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; sameo@linux.intel.com;
> ard.biesheuvel@linaro.org; Linuxarm <linuxarm@huawei.com>; xuwei (O)
> <xuwei5@huawei.com>; shannon.zhaosl@gmail.com;
> sebastien.boeuf@intel.com; lersek@redhat.com
> Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 6/9] hw/arm/virt: Enable devi=
ce
> memory cold/hot plug with ACPI boot
>=20
> On Wed, 7 Aug 2019 08:19:16 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > Hi Igor,
> >
> > > -----Original Message-----
> > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > Sent: 06 August 2019 14:09
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > > eric.auger@redhat.com; peter.maydell@linaro.org;
> sameo@linux.intel.com;
> > > ard.biesheuvel@linaro.org; Linuxarm <linuxarm@huawei.com>; xuwei (O)
> > > <xuwei5@huawei.com>; shannon.zhaosl@gmail.com;
> > > sebastien.boeuf@intel.com; lersek@redhat.com
> > > Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 6/9] hw/arm/virt: Enable
> device
> > > memory cold/hot plug with ACPI boot
> >
> > [...]
> >
> > > > +static inline DeviceState *create_acpi_ged(VirtMachineState *vms,
> > > qemu_irq *pic)
> > > > +{
> > > > +    DeviceState *dev;
> > > > +    int irq =3D vms->irqmap[VIRT_ACPI_GED];
> > > > +    uint32_t event =3D ACPI_GED_MEM_HOTPLUG_EVT;
> > > > +
> > > > +    dev =3D DEVICE(object_new(TYPE_ACPI_GED));
> > > > +    qdev_prop_set_uint64(dev, "memhp-base",
> > > > +
> vms->memmap[VIRT_PCDIMM_ACPI].base);
> > > > +    qdev_prop_set_uint64(dev, "ged-base",
> > > vms->memmap[VIRT_ACPI_GED].base);
> > > > +    qdev_prop_set_uint32(dev, "ged-event", event);
> > > > +    object_property_add_child(qdev_get_machine(), "acpi-ged",
> > > > +                              OBJECT(dev), NULL);
> > > > +    qdev_init_nofail(dev);
> > > > +    qdev_connect_gpio_out_named(dev, "ged-irq", 0, pic[irq]);
> > > > +
> > > > +    object_unref(OBJECT(dev));
> > > > +
> > > > +    return dev;
> > > > +}
> > >
> > > this function will need changes to accommodate for sysbus device
> > > init sequence [3/9].
> >
> > Yes. I think we are proposing to use sysbus_mmio_map() here for "ged-ba=
se".
> > But what about " memhp-base"? Is it ok to invoke
> > acpi_memory_hotplug_init(get_system_memoty(), ...) from ged device?
> no it's not ok.
>=20
> One could expose container memory region as sysbus mmio and then put
> ged-io and AcpiGedState::memhp_state::io within it.
> something like:
>=20
>         board:
>             sysbus_mmio_map(ged, 0 /* io_contaner number */, ged-base)
>=20
>         ged_initfn()
>             register io_container as sysbus mmio region
>=20
>         ged_realize()
>             memory_region_add_subregion(&ged->io_container, 0,
> &ged_st->io);
>             acpi_memory_hotplug_init(&ged->io_container,,
> &ged->acpi_memory_hotplug, AFTER_GED_IO_OFFSET)
>=20
> that would make GED's MMIO available to guest at ged-base and memhp IO
> will be available at address after it.
> You can go even further (more flexible) and register ged_st->io as separa=
te
> sysbus mmio and use a container exclusively for memhp, in this case you'd=
 be
> able to map memhp io from board independently from ged-base.

Ok. Understood. Thanks.

But looks like both the approaches would require changes to build_memory_ho=
tplug_aml()
code as acpi_memory_hotplug_init() stores the io_base and reuse that in _am=
l() code.

I will have a go and see.

Thanks,
Shameer

>=20
> > Or go with _set_link() function to pass the address space ?
> >
> > Thanks,
> > Shameer
> >
> >
> > > > +
> > > >  static void create_its(VirtMachineState *vms, DeviceState *gicdev)
> > > >  {
> > > >      const char *itsclass =3D its_class_name();
> > > > @@ -1483,6 +1508,7 @@ static void machvirt_init(MachineState
> *machine)
> > > >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > > >      bool firmware_loaded;
> > > >      bool aarch64 =3D true;
> > > > +    bool has_ged =3D !vmc->no_ged;
> > > >      unsigned int smp_cpus =3D machine->smp.cpus;
> > > >      unsigned int max_cpus =3D machine->smp.max_cpus;
> > > >
> > > > @@ -1697,6 +1723,10 @@ static void machvirt_init(MachineState
> > > *machine)
> > > >
> > > >      create_gpio(vms, pic);
> > > >
> > > > +    if (has_ged && aarch64 && firmware_loaded && acpi_enabled) {
> > > > +        vms->acpi_dev =3D create_acpi_ged(vms, pic);
> > > > +    }
> > > > +
> > > >      /* Create mmio transports, so the user can create virtio backe=
nds
> > > >       * (which will be automatically plugged in to the transports).=
 If
> > > >       * no backend is created the transport will just sit harmlessl=
y idle.
> > > > @@ -1876,27 +1906,34 @@ static const CPUArchIdList
> > > *virt_possible_cpu_arch_ids(MachineState *ms)
> > > >  static void virt_memory_pre_plug(HotplugHandler *hotplug_dev,
> > > DeviceState *dev,
> > > >                                   Error **errp)
> > > >  {
> > > > +    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> > > > +    const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev),
> > > TYPE_NVDIMM);
> > > >
> > > > -    /*
> > > > -     * The device memory is not yet exposed to the Guest either
> through
> > > > -     * DT or ACPI and hence both cold/hot plug of memory is explic=
itly
> > > > -     * disabled for now.
> > > > -     */
> > > > -    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > > > -        error_setg(errp, "memory cold/hot plug is not yet supporte=
d");
> > > > +    if (is_nvdimm) {
> > > > +        error_setg(errp, "nvdimm is not yet supported");
> > > >          return;
> > > >      }
> > > >
> > > > +    if (!vms->acpi_dev) {
> > > > +        error_setg(errp, "memory hotplug is not enabled: missing a=
cpi
> > > device");
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    hotplug_handler_pre_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> dev,
> > > errp);
> > > use local_error and check for error condition here. see
> pc_memory_pre_plug()
> > >
> > > > +
> > > >      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
> NULL,
> > > errp);
> > > >  }
> > > >
> > > >  static void virt_memory_plug(HotplugHandler *hotplug_dev,
> > > >                               DeviceState *dev, Error **errp)
> > > >  {
> > > > +    HotplugHandlerClass *hhc;
> > > >      VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> > > >
> > > >      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), NULL);
> > >                                                 ^^^^
> > > >
> > > > +    hhc =3D HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> > > > +    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, NULL);
> > >                                                       ^^^^
> > > why errors are ignored here, pls check for errors and propagate
> > > them to the caller.
> > >
> > > >  }
> > > >
> > > >  static void virt_machine_device_pre_plug_cb(HotplugHandler
> > > *hotplug_dev,
> > > > @@ -2102,8 +2139,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
> > > >
> > > >  static void virt_machine_4_1_options(MachineClass *mc)
> > > >  {
> > > > +    VirtMachineClass *vmc =3D
> VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> > > > +
> > > >      virt_machine_4_2_options(mc);
> > > >      compat_props_add(mc->compat_props, hw_compat_4_1,
> > > hw_compat_4_1_len);
> > > > +    vmc->no_ged =3D true;
> > > >  }
> > > >  DEFINE_VIRT_MACHINE(4, 1)
> > > >
> > > > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > > > index a72094204e..577ee49b4b 100644
> > > > --- a/include/hw/arm/virt.h
> > > > +++ b/include/hw/arm/virt.h
> > > > @@ -77,6 +77,8 @@ enum {
> > > >      VIRT_GPIO,
> > > >      VIRT_SECURE_UART,
> > > >      VIRT_SECURE_MEM,
> > > > +    VIRT_PCDIMM_ACPI,
> > > > +    VIRT_ACPI_GED,
> > > >      VIRT_LOWMEMMAP_LAST,
> > > >  };
> > > >
> > > > @@ -106,6 +108,7 @@ typedef struct {
> > > >      bool claim_edge_triggered_timers;
> > > >      bool smbios_old_sys_ver;
> > > >      bool no_highmem_ecam;
> > > > +    bool no_ged;   /* Machines < 4.2 has no support for ACPI GED
> device
> > > */
> > > >  } VirtMachineClass;
> > > >
> > > >  typedef struct {
> > > > @@ -133,6 +136,7 @@ typedef struct {
> > > >      uint32_t iommu_phandle;
> > > >      int psci_conduit;
> > > >      hwaddr highest_gpa;
> > > > +    DeviceState *acpi_dev;
> > > >  } VirtMachineState;
> > > >
> > > >  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM :
> > > VIRT_PCIE_ECAM)
> > > > diff --git a/tests/bios-tables-test-allowed-diff.h
> > > b/tests/bios-tables-test-allowed-diff.h
> > > > index dfb8523c8b..7b4adbc822 100644
> > > > --- a/tests/bios-tables-test-allowed-diff.h
> > > > +++ b/tests/bios-tables-test-allowed-diff.h
> > > > @@ -1 +1,2 @@
> > > >  /* List of comma-separated changed AML files to ignore */
> > > > +"tests/data/acpi/virt/DSDT",
> >


