Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C6DC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AA320714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AA320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQUH-0008UU-Fu
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jHQTX-0007XK-R5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jHQTV-0006Gx-WB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:15:03 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2087 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jHQTS-0006DT-2U; Thu, 26 Mar 2020 07:14:58 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id A715B721B8505ED14D4A;
 Thu, 26 Mar 2020 11:14:54 +0000 (GMT)
Received: from lhreml701-chm.china.huawei.com (10.201.108.50) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 26 Mar 2020 11:14:53 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml701-chm.china.huawei.com (10.201.108.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 26 Mar 2020 11:14:54 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Thu, 26 Mar 2020 11:14:53 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [RFC v1] arm/virt: Add memory hot remove support
Thread-Topic: [RFC v1] arm/virt: Add memory hot remove support
Thread-Index: AQHV/SI7g2bnth2huEKfm213qjOT+KhawV2AgAAAwFA=
Date: Thu, 26 Mar 2020 11:14:53 +0000
Message-ID: <246eb04443e342749ed91533949a5e67@huawei.com>
References: <20200318123722.19736-1-shameerali.kolothum.thodi@huawei.com>
 <b6c6f33b-7e4f-0b46-b67d-2de572e12626@redhat.com>
In-Reply-To: <b6c6f33b-7e4f-0b46-b67d-2de572e12626@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.92.97]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.176.76.210
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
 "xuwei \(O\)" <xuwei5@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: 26 March 2020 11:01
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: imammedo@redhat.com; peter.maydell@linaro.org; mst@redhat.com;
> xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> Linuxarm <linuxarm@huawei.com>; Anshuman Khandual
> <anshuman.khandual@arm.com>
> Subject: Re: [RFC v1] arm/virt: Add memory hot remove support
>=20
> Hi Shameer,
>=20
> On 3/18/20 1:37 PM, Shameer Kolothum wrote:
> > This adds support for memory hot remove on arm/virt that
> > uses acpi ged device.
>=20
> I gave this a try and it works fine if the PCDIMM slot was initially
> hotplugged:
> (QEMU) object-add qom-type=3Dmemory-backend-ram id=3Dmem1
> props.size=3D4294967296
> {"return": {}}
> (QEMU) device_add driver=3Dpc-dimm  id=3Dpcdimm1 memdev=3Dmem1
> (QEMU) device_del id=3Dpcdimm1
> {"return": {}}
>=20
> on guest I can see:
> [   82.466321] Offlined Pages 262144
> [   82.541712] Offlined Pages 262144
> [   82.589236] Offlined Pages 262144
> [   82.969166] Offlined Pages 262144
>=20
> However I noticed that if qemu is launched directly with
>=20
> -m 16G,maxmem=3D32G,slots=3D2 \
> -object memory-backend-ram,id=3Dmem1,size=3D4G \
> -device pc-dimm,memdev=3Dmem1,id=3Ddimm1,driver=3Dpc-dimm -device
>=20
> and then in the qmp shell:
> (QEMU) device_del id=3Ddimm1
>=20
> the hot-unplug fails in guest:
>=20
> [   78.897407] Offlined Pages 262144
> [   79.260811] Offlined Pages 262144
> [   79.308105] Offlined Pages 262144
> [   79.333675] page:fffffe00137d1f40 refcount:1 mapcount:0
> mapping:ffff0004ea9f20b1 index:0xaaab11c6e
> [   79.335927] anon flags: 0x17ffff8000080024(uptodate|active|swapbacked)
> [   79.337571] raw: 17ffff8000080024 dead000000000100
> dead000000000122
> ffff0004ea9f20b1
> [   79.339502] raw: 0000000aaab11c6e 0000000000000000 00000001ffffffff
> ffff0004fd4e3000
> [   79.341701] page dumped because: unmovable page
> [   79.342887] page->mem_cgroup:ffff0004fd4e3000
> [   79.354729] page:fffffe00137d1f40 refcount:1 mapcount:0
> mapping:ffff0004ea9f20b1 index:0xaaab11c6e
> [   79.357012] anon flags: 0x17ffff8000080024(uptodate|active|swapbacked)
> [   79.358658] raw: 17ffff8000080024 dead000000000100
> dead000000000122
> ffff0004ea9f20b1
> [   79.360611] raw: 0000000aaab11c6e 0000000000000000 00000001ffffffff
> ffff0004fd4e3000
> [   79.362560] page dumped because: unmovable page
> [   79.363742] page->mem_cgroup:ffff0004fd4e3000
> [   79.368636] memory memory20: Offline failed.
>=20
> I did not expect this. The PCDIMM slot in that case does not seem to be
> interpreted as a hot-unpluggable one (?). I added Anshuman in cc.

Could you please try adding "movable_node" to qemu guest kernel command lin=
e params.
This will prevent any kernel allocation from hotplugable memory nodes which=
 I think is
causing the behavior you are seeing.

Thanks,
Shameer


> Thanks
>=20
> Eric
>=20
>=20
>=20
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  -RFC because linux kernel support for mem hot remove is just queued
> >   for 5.7[1].
> >  -Tested with guest kernel 5.6-rc5 + [1]
> >
> > 1. https://patchwork.kernel.org/cover/11419301/
> > ---
> >  hw/acpi/generic_event_device.c | 28 +++++++++++++++++
> >  hw/arm/virt.c                  | 56
> ++++++++++++++++++++++++++++++++--
> >  2 files changed, 82 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/acpi/generic_event_device.c
> b/hw/acpi/generic_event_device.c
> > index 021ed2bf23..3e28c110fa 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -182,6 +182,32 @@ static void
> acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
> >      }
> >  }
> >
> > +static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
> > +                                       DeviceState *dev, Error
> **errp)
> > +{
> > +    AcpiGedState *s =3D ACPI_GED(hotplug_dev);
> > +
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        acpi_memory_unplug_request_cb(hotplug_dev,
> &s->memhp_state, dev, errp);
> > +    } else {
> > +        error_setg(errp, "acpi: device unplug request for unsupported
> device"
> > +                   " type: %s", object_get_typename(OBJECT(dev)));
> > +    }
> > +}
> > +
> > +static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
> > +                               DeviceState *dev, Error **errp)
> > +{
> > +    AcpiGedState *s =3D ACPI_GED(hotplug_dev);
> > +
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> > +    } else {
> > +        error_setg(errp, "acpi: device unplug for unsupported device"
> > +                   " type: %s", object_get_typename(OBJECT(dev)));
> > +    }
> > +}
> > +
> >  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBit=
s
> ev)
> >  {
> >      AcpiGedState *s =3D ACPI_GED(adev);
> > @@ -286,6 +312,8 @@ static void acpi_ged_class_init(ObjectClass *class,
> void *data)
> >      dc->vmsd =3D &vmstate_acpi_ged;
> >
> >      hc->plug =3D acpi_ged_device_plug_cb;
> > +    hc->unplug_request =3D acpi_ged_unplug_request_cb;
> > +    hc->unplug =3D acpi_ged_unplug_cb;
> >
> >      adevc->send_event =3D acpi_ged_send_event;
> >  }
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 94f93dda54..91974e4e80 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2096,11 +2096,62 @@ static void
> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> >      }
> >  }
> >
> > +static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
> > +                                     DeviceState *dev, Error
> **errp)
> > +{
> > +    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> > +    Error *local_err =3D NULL;
> > +
> > +    if (!vms->acpi_dev) {
> > +        error_setg(errp,
> > +                   "memory hotplug is not enabled: missing acpi-ged
> device");
> > +        goto out;
> > +    }
> > +
> > +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(vms->acpi_dev),
> dev,
> > +                                   &local_err);
> > +out:
> > +    error_propagate(errp, local_err);
> > +}
> > +
> > +static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
> > +                             DeviceState *dev, Error **errp)
> > +{
> > +    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> > +    Error *local_err =3D NULL;
> > +
> > +    hotplug_handler_unplug(HOTPLUG_HANDLER(vms->acpi_dev), dev,
> &local_err);
> > +    if (local_err) {
> > +        goto out;
> > +    }
> > +
> > +    pc_dimm_unplug(PC_DIMM(dev), MACHINE(vms));
> > +    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
> > +
> > + out:
> > +    error_propagate(errp, local_err);
> > +}
> > +
> >  static void virt_machine_device_unplug_request_cb(HotplugHandler
> *hotplug_dev,
> >                                            DeviceState *dev, Error
> **errp)
> >  {
> > -    error_setg(errp, "device unplug request for unsupported device"
> > -               " type: %s", object_get_typename(OBJECT(dev)));
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        virt_dimm_unplug_request(hotplug_dev, dev, errp);
> > +    } else {
> > +        error_setg(errp, "device unplug request for unsupported device=
"
> > +                   " type: %s", object_get_typename(OBJECT(dev)));
> > +    }
> > +}
> > +
> > +static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
> > +                                          DeviceState *dev, Error
> **errp)
> > +{
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        virt_dimm_unplug(hotplug_dev, dev, errp);
> > +    } else {
> > +        error_setg(errp, "virt: device unplug for unsupported device"
> > +                   " type: %s", object_get_typename(OBJECT(dev)));
> > +    }
> >  }
> >
> >  static HotplugHandler *virt_machine_get_hotplug_handler(MachineState
> *machine,
> > @@ -2181,6 +2232,7 @@ static void virt_machine_class_init(ObjectClass
> *oc, void *data)
> >      hc->pre_plug =3D virt_machine_device_pre_plug_cb;
> >      hc->plug =3D virt_machine_device_plug_cb;
> >      hc->unplug_request =3D virt_machine_device_unplug_request_cb;
> > +    hc->unplug =3D virt_machine_device_unplug_cb;
> >      mc->numa_mem_supported =3D true;
> >      mc->auto_enable_numa_with_memhp =3D true;
> >      mc->default_ram_id =3D "mach-virt.ram";
> >


