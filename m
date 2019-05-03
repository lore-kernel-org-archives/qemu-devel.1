Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76335C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB0D2075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB0D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40871 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYND-00048f-D7
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 09:37:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hMYLw-00037e-5d
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hMYLu-0004IJ-9i
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:35:52 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45398 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hMYLq-0004DH-Cg; Fri, 03 May 2019 09:35:46 -0400
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.106])
	by Forcepoint Email with ESMTP id DE5AFDA193E2EFDDB8ED;
	Fri,  3 May 2019 14:35:43 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.137]) by
	lhreml708-cah.china.huawei.com ([10.201.108.49]) with mapi id
	14.03.0415.000; Fri, 3 May 2019 14:35:33 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Laszlo Ersek <lersek@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "imammedo@redhat.com"
	<imammedo@redhat.com>
Thread-Topic: [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM nodes in the DT
Thread-Index: AQHU7r+FHRV2RRXA40+Yjk9QZW2DraYz3gyAgAE0oHCAJHCRsA==
Date: Fri, 3 May 2019 13:35:33 +0000
Message-ID:
 <5FC3163CFD30C246ABAA99954A238FA83F1B0B26@lhreml524-mbs.china.huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-9-shameerali.kolothum.thodi@huawei.com>
	<4f3df83f-8d45-09d0-ec9e-0ddf843fd3a4@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83935D360@lhreml524-mbs.china.huawei.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83935D360@lhreml524-mbs.china.huawei.com>
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
Subject: Re: [Qemu-devel] [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM
 nodes in the DT
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
	Linuxarm <linuxarm@huawei.com>,
	"shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
	"sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
	"xuwei \(O\)" <xuwei5@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503133533.sJuGo3Urw5459ZTZuqoLTK3nKP1Km1wGGSNcKEfZ_tw@z>



> -----Original Message-----
> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of
> Shameerali Kolothum Thodi
> Sent: 10 April 2019 09:49
> To: Laszlo Ersek <lersek@redhat.com>; qemu-devel@nongnu.org;
> qemu-arm@nongnu.org; eric.auger@redhat.com; imammedo@redhat.com
> Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> ard.biesheuvel@linaro.org; Linuxarm <linuxarm@huawei.com>;
> shannon.zhaosl@gmail.com; sebastien.boeuf@intel.com; xuwei (O)
> <xuwei5@huawei.com>
> Subject: RE: [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM nodes in the
> DT
>=20
>=20
> > -----Original Message-----
> > From: Laszlo Ersek [mailto:lersek@redhat.com]
> > Sent: 09 April 2019 16:09
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > qemu-devel@nongnu.org; qemu-arm@nongnu.org; eric.auger@redhat.com;
> > imammedo@redhat.com
> > Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
> > sameo@linux.intel.com; sebastien.boeuf@intel.com; xuwei (O)
> > <xuwei5@huawei.com>; ard.biesheuvel@linaro.org; Linuxarm
> > <linuxarm@huawei.com>
> > Subject: Re: [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM nodes in th=
e
> > DT
> >
> > On 04/09/19 12:29, Shameer Kolothum wrote:
> > > This patch adds memory nodes corresponding to PC-DIMM regions.
> > > This will enable support for cold plugged device memory for Guests
> > > with DT boot.
> > >
> > > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > ---
> > >  hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > >
> > > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > > index 8c840ba..150e1ed 100644
> > > --- a/hw/arm/boot.c
> > > +++ b/hw/arm/boot.c
> > > @@ -19,6 +19,7 @@
> > >  #include "sysemu/numa.h"
> > >  #include "hw/boards.h"
> > >  #include "hw/loader.h"
> > > +#include "hw/mem/memory-device.h"
> > >  #include "elf.h"
> > >  #include "sysemu/device_tree.h"
> > >  #include "qemu/config-file.h"
> > > @@ -538,6 +539,41 @@ static void fdt_add_psci_node(void *fdt)
> > >      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
> > >  }
> > >
> > > +static int fdt_add_hotpluggable_memory_nodes(void *fdt,
> > > +                                             uint32_t acells,
> > uint32_t scells) {
> > > +    MemoryDeviceInfoList *info, *info_list =3D qmp_memory_device_lis=
t();
> > > +    MemoryDeviceInfo *mi;
> > > +    int ret =3D 0;
> > > +
> > > +    for (info =3D info_list; info !=3D NULL; info =3D info->next) {
> > > +        mi =3D info->value;
> > > +        switch (mi->type) {
> > > +        case MEMORY_DEVICE_INFO_KIND_DIMM:
> > > +        {
> > > +            PCDIMMDeviceInfo *di =3D mi->u.dimm.data;
> > > +
> > > +            ret =3D fdt_add_memory_node(fdt, acells, di->addr, scell=
s,
> > > +                                      di->size, di->node, true);
> > > +            if (ret) {
> > > +                fprintf(stderr,
> > > +                        "couldn't add PCDIMM
> /memory@%"PRIx64"
> > node\n",
> > > +                        di->addr);
> > > +                goto out;
> > > +            }
> > > +            break;
> > > +        }
> > > +        default:
> > > +            fprintf(stderr, "%s memory nodes are not yet supported\n=
",
> > > +                    MemoryDeviceInfoKind_str(mi->type));
> > > +            ret =3D -ENOENT;
> > > +            goto out;
> > > +        }
> > > +    }
> > > +out:
> > > +    qapi_free_MemoryDeviceInfoList(info_list);
> > > +    return ret;
> > > +}
> > > +
> > >  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> > >                   hwaddr addr_limit, AddressSpace *as)
> > >  {
> > > @@ -637,6 +673,12 @@ int arm_load_dtb(hwaddr addr, const struct
> > arm_boot_info *binfo,
> > >          }
> > >      }
> > >
> > > +    rc =3D fdt_add_hotpluggable_memory_nodes(fdt, acells, scells);
> > > +    if (rc < 0) {
> > > +        fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
> > > +        goto fail;
> > > +    }
> > > +
> > >      rc =3D fdt_path_offset(fdt, "/chosen");
> > >      if (rc < 0) {
> > >          qemu_fdt_add_subnode(fdt, "/chosen");
> > >
> >
> >
> > Given patches #7 and #8, as I understand them, the firmware cannot
> > distinguish hotpluggable & present, from hotpluggable & absent. The
> firmware
> > can only skip both hotpluggable cases. That's fine in that the firmware=
 will
> hog
> > neither type -- but is that OK for the OS as well, for both ACPI boot a=
nd DT
> > boot?
>=20
> Right. This only handles the hotpluggable-and-present condition.
>=20
> > Consider in particular the "hotpluggable & present, ACPI boot" case.
> Assuming
> > we modify the firmware to skip "hotpluggable" altogether, the UEFI memm=
ap
> > will not include the range despite it being present at boot. Presumably=
, ACPI
> > will refer to the range somehow, however. Will that not confuse the OS?
>=20
> From my testing so far, without patches #7 and #8(ie, no UEFI memmap entr=
y),
> ACPI boots fine. I think ACPI only relies on aml and SRAT.
>=20
> > When Igor raised this earlier, I suggested that hotpluggable-and-presen=
t
> > should be added by the firmware, but also allocated immediately, as
> > EfiBootServicesData type memory. This will prevent other drivers in the
> > firmware from allocating AcpiNVS or Reserved chunks from the same memor=
y
> > range, the UEFI memmap will contain the range as EfiBootServicesData, a=
nd
> > then the OS can release that allocation in one go early during boot.
>=20
> Ok. Agree that hotpluggable-and-present case it may make sense to make us=
e
> of
> that memory rather than just hiding it altogether.
>=20
> On another note, Does hotpluggable-and-absent case make any valid use cas=
e
> for
> a DT boot? I am not sure how we can hot-add memory in the case of DT boot
> later.
> I have not verified the sysfs probe interface yet and there are discussio=
ns of
> dropping
> that interface altogether.
>=20
> > But this really has to be clarified from the Linux kernel's expectation=
s. Please
> > formalize all of the following cases:
>=20
> Sure. I will wait for suggestions here and work on it.

To continue the discussion on this, this is my proposal,

OS boot (DT/ACPI)  hotpluggable & ...  GetMemoryMap() should report as  DT/=
ACPI should report as
-----------------  ------------------  -------------------------------  ---=
---------------------
DT                present           Normal memory             Report as nor=
mal DT memory node

DT                absent            Not reported                  Not repor=
ted.

ACPI              present            EfiBootServicesData memory  SRAT speci=
fies the memory region
                                                               and device m=
emory discovered
                                                               during Guest=
 boot up through AML.

ACPI              absent             Not reported               SRAT specif=
ies the memory region.
                                                               Supports hot=
 add later.

Not sure I got all the scenarios correct here, please take a look and let m=
e know.

Thanks,
Shameer

>=20
> Thanks,
> Shameer
>=20
> > OS boot (DT/ACPI)  hotpluggable & ...  GetMemoryMap() should report as
> > DT/ACPI should report as
> > -----------------  ------------------  ------------------------------- =
 ------------------------
> > DT
> > present             ?                                ?
> > DT
> > absent              ?                                ?
> > ACPI
> > present             ?                                ?
> > ACPI
> > absent              ?                                ?
> >
> > Again, this table is dictated by Linux.
> >
> > Thanks
> > Laszlo
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm

