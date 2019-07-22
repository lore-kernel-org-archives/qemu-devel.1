Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE435C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A306D21911
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A306D21911
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZ4N-0004vU-SD
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34147)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZ4C-0004RT-6B
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZ4A-0004gf-MF
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:13:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45425 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hpZ47-0004Xl-R8; Mon, 22 Jul 2019 10:13:23 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 0C88AC5C3CA369BF6A41;
 Mon, 22 Jul 2019 15:13:18 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.132]) by
 LHREML712-CAH.china.huawei.com ([10.201.108.35]) with mapi id 14.03.0415.000; 
 Mon, 22 Jul 2019 15:13:12 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH-for-4.2 v7 03/10] hw/acpi: Add ACPI
 Generic Event Device Support
Thread-Index: AQHVPKyeUuREoR+k9k210mjLR3EAGabQLoLQgAAQkgCABnX4kA==
Date: Mon, 22 Jul 2019 14:13:11 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F310A58@lhreml524-mbs.china.huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-4-shameerali.kolothum.thodi@huawei.com>
 <20190717163245.78880d55@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83F30B621@lhreml524-mbs.china.huawei.com>
 <20190718143034.11ef7c12@redhat.com>
In-Reply-To: <20190718143034.11ef7c12@redhat.com>
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



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 18 July 2019 13:31
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
> On Thu, 18 Jul 2019 10:52:10 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > Hi Igor,
> >
> > > -----Original Message-----
> > > From: Qemu-devel
> > >
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongn
> > > u.org] On Behalf Of Igor Mammedov
> > > Sent: 17 July 2019 15:33
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> > > shannon.zhaosl@gmail.com; ard.biesheuvel@linaro.org;
> > > qemu-devel@nongnu.org; xuwei (O) <xuwei5@huawei.com>; Linuxarm
> > > <linuxarm@huawei.com>; eric.auger@redhat.com;
> qemu-arm@nongnu.org;
> > > sebastien.boeuf@intel.com; lersek@redhat.com
> > > Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 03/10] hw/acpi: Add ACPI
> Generic
> > > Event Device Support
> > >
> > > On Tue, 16 Jul 2019 16:38:09 +0100
> > > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> >
> > [...]
> >
> > > > +static void acpi_ged_event(AcpiGedState *s, uint32_t sel)
> > > > +{
> > > > +    GEDState *ged_st =3D &s->ged_state;
> > > > +    /*
> > > > +     * Set the GED IRQ selector to the expected device type value.=
 This
> > > > +     * way, the ACPI method will be able to trigger the right code=
 based
> > > > +     * on a unique IRQ.
> > > comment isn't correct anymore, pls fix it
> >
> > True.
> >
> > >
> > > > +     */
> > > > +    qemu_mutex_lock(&ged_st->lock);
> > > Is this lock really necessary?
> > > (I thought that MMIO and monitor access is guarded by BQL)
> >
> > Hmm..I am not sure. This is to synchronize with the ged_st->sel update =
inside
> > ged_read(). And also acpi_ged_event() gets called through
> _power_down_notifier()
> > as well. BQL guard is in place for all the paths here?
> power down command originates from HMP or QMP monitor, so you don't
> really
> need a lock here.

Ok. I will get rid of it then.

> >
> > >
> > > > +    ged_st->sel |=3D sel;
> > > > +    qemu_mutex_unlock(&ged_st->lock);
> > > > +
> > > > +    /* Trigger the event by sending an interrupt to the guest. */
> > > > +    qemu_irq_pulse(s->irq);
> > > > +}
> > > > +
> > > > +static void acpi_ged_init(MemoryRegion *as, DeviceState *dev,
> GEDState
> > > *ged_st)
> > > > +{
> > > > +    AcpiGedState *s =3D ACPI_GED(dev);
> > > > +
> > > > +    assert(s->ged_base);
> > > > +
> > > > +    qemu_mutex_init(&ged_st->lock);
> > > > +    memory_region_init_io(&ged_st->io, OBJECT(dev), &ged_ops,
> ged_st,
> > > > +                          TYPE_ACPI_GED, ACPI_GED_REG_LEN);
> > > > +    memory_region_add_subregion(as, s->ged_base, &ged_st->io);
> > > > +    qdev_init_gpio_out_named(DEVICE(s), &s->irq, "ged-irq", 1);
> > > > +}
> > > > +
> > > > +static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
> > > > +                                    DeviceState *dev, Error
> **errp)
> > > > +{
> > > > +    AcpiGedState *s =3D ACPI_GED(hotplug_dev);
> > > > +
> > > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > > > +        if (s->memhp_state.is_enabled) {
> > > > +            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state,
> dev,
> > > errp);
> > > > +        } else {
> > > > +            error_setg(errp,
> > > > +                 "memory hotplug is not
> > > enabled: %s.memory-hotplug-support "
> > > > +                 "is not set", object_get_typename(OBJECT(s)));
> > > > +        }
> > > > +    } else {
> > > > +        error_setg(errp, "virt: device plug request for unsupporte=
d
> > > device"
> > > > +                   " type: %s",
> object_get_typename(OBJECT(dev)));
> > > > +    }
> > > > +}
> > > > +
> > > > +static void acpi_ged_send_event(AcpiDeviceIf *adev,
> AcpiEventStatusBits
> > > ev)
> > > > +{
> > > > +    AcpiGedState *s =3D ACPI_GED(adev);
> > > > +    uint32_t sel;
> > > > +
> > > > +    if (ev & ACPI_MEMORY_HOTPLUG_STATUS) {
> > > > +        sel =3D ACPI_GED_MEM_HOTPLUG_EVT;
> > > > +    } else {
> > > > +        /* Unknown event. Return without generating interrupt. */
> > > > +        warn_report("GED: Unsupported event %d. No irq injected",
> ev);
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    /*
> > > > +     * We inject the hotplug interrupt. The IRQ selector will make
> > > > +     * the difference from the ACPI table.
> > > I don't get comment at all, pls rephrase/
> >
> > Ok. I think better to get rid of this comment here and update the one i=
n
> acpi_ged_event()
> > appropriately.
> >
> > >
> > > > +     */
> > > > +    acpi_ged_event(s, sel);
> > > it seems to used only once and only here, suggest to drop acpi_ged_ev=
ent()
> > > and move it's code here.
> >
> > But patch #10 makes use of it from acpi_ged_pm_powerdown_req().
> it looks like a valid shortcut but I'd make it follow AcpiInterface->send=
_event()
> path for consistency so only one call chain would exist.

Agree.=20

Thanks,
Shameer
=20


