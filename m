Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251A6C004C9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00D32075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00D32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40287 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMXdo-0008BG-7H
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 08:50:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hMXbi-000777-Ez
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hMXbe-0006zC-NT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:48:06 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45397 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hMXba-0006wj-Vq; Fri, 03 May 2019 08:47:59 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
	by Forcepoint Email with ESMTP id 638FEAC295BB53F9F1BE;
	Fri,  3 May 2019 13:47:57 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.137]) by
	lhreml704-cah.china.huawei.com ([10.201.108.45]) with mapi id
	14.03.0415.000; Fri, 3 May 2019 13:47:51 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [PATCH v4 4/8] hw/arm/virt: Add memory hotplug framework
Thread-Index: AQHU7r9hpSQT1rMAlkOED/ex743ihqZYF2CAgAFnhfA=
Date: Fri, 3 May 2019 12:47:50 +0000
Message-ID:
 <5FC3163CFD30C246ABAA99954A238FA83F1B09C7@lhreml524-mbs.china.huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-5-shameerali.kolothum.thodi@huawei.com>
	<20190502181929.0bad1fb5@Igors-MacBook-Pro>
In-Reply-To: <20190502181929.0bad1fb5@Igors-MacBook-Pro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
Subject: Re: [Qemu-devel] [PATCH v4 4/8] hw/arm/virt: Add memory hotplug
 framework
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
Message-ID: <20190503124750.SqTKns4ILJL3hnzU197L9VYDOysA8lmNNRey2H0Gjoo@z>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 02 May 2019 17:19
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; sameo@linux.intel.com;
> sebastien.boeuf@intel.com; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com; ard.biesheuvel@linaro.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH v4 4/8] hw/arm/virt: Add memory hotplug framework
>=20
> On Tue, 9 Apr 2019 11:29:31 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > From: Eric Auger <eric.auger@redhat.com>
> >
> > This patch adds the memory hot-plug/hot-unplug infrastructure
> > in machvirt. The device memory is not yet exposed to the Guest
> > either though DT or ACPI and hence both cold/hot plug of memory
> s/though/through/

Sure.

> > is explicitly disabled for now.
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  default-configs/arm-softmmu.mak |  3 +++
> >  hw/arm/virt.c                   | 45
> ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/default-configs/arm-softmmu.mak
> b/default-configs/arm-softmmu.mak
> > index 613d19a..9f4b803 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -160,3 +160,6 @@ CONFIG_MUSICPAL=3Dy
> >
> >  # for realview and versatilepb
> >  CONFIG_LSI_SCSI_PCI=3Dy
> > +
> > +CONFIG_MEM_DEVICE=3Dy
> > +CONFIG_DIMM=3Dy
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index ce2664a..da516b3 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -61,6 +61,8 @@
> >  #include "hw/arm/smmuv3.h"
> >  #include "hw/acpi/acpi.h"
> >  #include "target/arm/internals.h"
> > +#include "hw/mem/pc-dimm.h"
> > +#include "hw/mem/nvdimm.h"
> >
> >  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> >      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> > @@ -1806,6 +1808,34 @@ static const CPUArchIdList
> *virt_possible_cpu_arch_ids(MachineState *ms)
> >      return ms->possible_cpus;
> >  }
> >
> > +static void virt_memory_pre_plug(HotplugHandler *hotplug_dev,
> DeviceState *dev,
> > +                                 Error **errp)
> > +{
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        error_setg(errp, "memory cold/hot plug is not yet supported");
> > +        return;
> > +    }
> add comment here why it's needed.

Ok.

>=20
> > +
> > +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL,
> errp);
> maybe before calling this there probably should be check if acpi is enabl=
ed.
>=20
> not sure if arm/virt board honors -no-acpi CLI option.

Ok. I will check this

Thanks,
Shameer
=20
> > +}
> > +
> > +static void virt_memory_plug(HotplugHandler *hotplug_dev,
> > +                             DeviceState *dev, Error **errp)
> > +{
> > +    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> > +
> > +    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), NULL);
> > +
> > +}
> > +
> > +static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_de=
v,
> > +                                            DeviceState *dev,
> Error **errp)
> > +{
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        virt_memory_pre_plug(hotplug_dev, dev, errp);
> > +    }
> > +}
> > +
> >  static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> >                                          DeviceState *dev, Error
> **errp)
> >  {
> > @@ -1817,12 +1847,23 @@ static void
> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> >                                       SYS_BUS_DEVICE(dev));
> >          }
> >      }
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > +        virt_memory_plug(hotplug_dev, dev, errp);
> > +    }
> > +}
> > +
> > +static void virt_machine_device_unplug_request_cb(HotplugHandler
> *hotplug_dev,
> > +                                          DeviceState *dev, Error
> **errp)
> > +{
> > +    error_setg(errp, "device unplug request for unsupported device"
> > +               " type: %s", object_get_typename(OBJECT(dev)));
> >  }
> >
> >  static HotplugHandler *virt_machine_get_hotplug_handler(MachineState
> *machine,
> >
> DeviceState *dev)
> >  {
> > -    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> > +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
> > +       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
> >          return HOTPLUG_HANDLER(machine);
> >      }
> >
> > @@ -1886,7 +1927,9 @@ static void virt_machine_class_init(ObjectClass
> *oc, void *data)
> >      mc->kvm_type =3D virt_kvm_type;
> >      assert(!mc->get_hotplug_handler);
> >      mc->get_hotplug_handler =3D virt_machine_get_hotplug_handler;
> > +    hc->pre_plug =3D virt_machine_device_pre_plug_cb;
> >      hc->plug =3D virt_machine_device_plug_cb;
> > +    hc->unplug_request =3D virt_machine_device_unplug_request_cb;
> >  }
> >
> >  static void virt_instance_init(Object *obj)


