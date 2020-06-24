Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B1CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AAEA20823
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAEA20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo915-0001ks-Rw
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jo8bU-0006Ki-F4; Wed, 24 Jun 2020 12:50:28 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2469 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jo8bR-0008GI-PM; Wed, 24 Jun 2020 12:50:28 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id C9C521E31A9177A3C4B5;
 Thu, 25 Jun 2020 00:50:15 +0800 (CST)
Received: from dggeme708-chm.china.huawei.com (10.1.199.104) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 25 Jun 2020 00:50:15 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 25 Jun 2020 00:50:14 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Wed, 24 Jun 2020 17:50:11 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH v4] arm/virt: Add memory hot remove support
Thread-Topic: [PATCH v4] arm/virt: Add memory hot remove support
Thread-Index: AQHWSJL/AMH+suS+ZUe4HdNJbU8iyqjnv/sAgAA6PMA=
Date: Wed, 24 Jun 2020 16:50:11 +0000
Message-ID: <3375d8e35d3a481d8298ce3e6a4ce531@huawei.com>
References: <20200622124157.20360-1-shameerali.kolothum.thodi@huawei.com>
 <20200624160834.5191b73e@redhat.com>
In-Reply-To: <20200624160834.5191b73e@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.9]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=shameerali.kolothum.thodi@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 12:50:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>, "mst@redhat.com" <mst@redhat.com>,
 Linuxarm <linuxarm@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei
 \(O\)" <xuwei5@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 24 June 2020 15:09
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> peter.maydell@linaro.org; mst@redhat.com; Linuxarm
> <linuxarm@huawei.com>; xuwei (O) <xuwei5@huawei.com>;
> eric.auger@redhat.com; Zengtao (B) <prime.zeng@hisilicon.com>
> Subject: Re: [PATCH v4] arm/virt: Add memory hot remove support
>=20
> On Mon, 22 Jun 2020 13:41:57 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > This adds support for memory(pc-dimm) hot remove on arm/virt that
> > uses acpi ged device.
> >
> > NVDIMM hot removal is not yet supported.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> > v2 --> v3
> >   -Addressed Eric's comments on v3.
> > v2 --> v3
> >   -Addressed Eric's review comment and added check for NVDIMM.
> > RFC v1 --> v2
> >   -Rebased on top of latest Qemu master.
> >   -Dropped "RFC" and tested with kernel 5.7-rc6
> > ---
> >  hw/acpi/generic_event_device.c | 29 ++++++++++++++++
> >  hw/arm/virt.c                  | 62
> ++++++++++++++++++++++++++++++++--
> >  2 files changed, 89 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/acpi/generic_event_device.c
> b/hw/acpi/generic_event_device.c
> > index 1cb34111e5..b8abdefa1c 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -193,6 +193,33 @@ static void

[...]

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
> > +    qdev_unrealize(dev);
>=20
> doesn't pc_dimm_unplug() do unrealize already?
> (/me wonders why it doesn't explode here,
> are we leaking a refference somewhere so dimm is still alive?)

Does it? From a quick look at the code it is not obvious.

pc_dimm_unplug()
  memory_device_unplug()
    memory_region_del_subregion()
  vmstate_unregister_ram()
    qemu_ram_unset_idstr()
    qemu_ram_unset_migratable()

If it does, then we may need to fix x86/ppc as well.

Thanks,
Shameer

> > +
> > +out:
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
> > @@ -2262,6 +2319,7 @@ static void virt_machine_class_init(ObjectClass
> *oc, void *data)
> >      hc->pre_plug =3D virt_machine_device_pre_plug_cb;
> >      hc->plug =3D virt_machine_device_plug_cb;
> >      hc->unplug_request =3D virt_machine_device_unplug_request_cb;
> > +    hc->unplug =3D virt_machine_device_unplug_cb;
> >      mc->numa_mem_supported =3D true;
> >      mc->nvdimm_supported =3D true;
> >      mc->auto_enable_numa_with_memhp =3D true;


