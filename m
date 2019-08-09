Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD7C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A172089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A172089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Ms-000092-0b
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54943)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hw7M8-0007So-FP
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hw7M7-00069P-5g
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:03:04 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45433 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hw7M3-00062v-C2; Fri, 09 Aug 2019 12:02:59 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id EB33D49403AA34C5652D;
 Fri,  9 Aug 2019 17:02:51 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.132]) by
 lhreml707-cah.china.huawei.com ([10.201.108.48]) with mapi id 14.03.0415.000; 
 Fri, 9 Aug 2019 17:02:39 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH-for-4.2 v8 7/9] hw/arm/virt-acpi-build:
 Add PC-DIMM in SRAT
Thread-Index: AQHVQ5+cfqB1e2O8jUOXpcKQKko1GKbuG7sAgATsqLA=
Date: Fri, 9 Aug 2019 16:02:39 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F34B396@lhreml524-mbs.china.huawei.com>
References: <20190726104519.23812-1-shameerali.kolothum.thodi@huawei.com>
 <20190726104519.23812-8-shameerali.kolothum.thodi@huawei.com>
 <20190806152136.3afbfb4b@redhat.com>
In-Reply-To: <20190806152136.3afbfb4b@redhat.com>
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
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 7/9] hw/arm/virt-acpi-build: Add
 PC-DIMM in SRAT
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

Hi Igor,

> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongn
> u.org] On Behalf Of Igor Mammedov
> Sent: 06 August 2019 14:22
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
> ard.biesheuvel@linaro.org; shannon.zhaosl@gmail.com;
> qemu-devel@nongnu.org; xuwei (O) <xuwei5@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; eric.auger@redhat.com; qemu-arm@nongnu.org;
> sebastien.boeuf@intel.com; lersek@redhat.com
> Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 7/9] hw/arm/virt-acpi-build: =
Add
> PC-DIMM in SRAT
>=20
> On Fri, 26 Jul 2019 11:45:17 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > Generate Memory Affinity Structures for PC-DIMM ranges.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/arm/virt-acpi-build.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 018b1e326d..75657caa36 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -518,6 +518,7 @@ build_srat(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
> >      int i, srat_start;
> >      uint64_t mem_base;
> >      MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> > +    MachineState *ms =3D MACHINE(vms);
> >      const CPUArchIdList *cpu_list =3D
> mc->possible_cpu_arch_ids(MACHINE(vms));
> >
> >      srat_start =3D table_data->len;
> > @@ -543,6 +544,14 @@ build_srat(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
> >          }
> >      }
> >
> > +    if (ms->device_memory) {
> > +        numamem =3D acpi_data_push(table_data, sizeof *numamem);
> > +        build_srat_memory(numamem, ms->device_memory->base,
> > +
> memory_region_size(&ms->device_memory->mr),
> > +                          nb_numa_nodes - 1,
> > +                          MEM_AFFINITY_HOTPLUGGABLE |
> MEM_AFFINITY_ENABLED);
> > +    }
> > +
> >      build_header(linker, table_data, (void *)(table_data->data +
> srat_start),
> >                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
> >  }
>=20
> missing entry in
>   tests/bios-tables-test-allowed-diff.h

I can't find any SRAT file in tests/data/acpi/virt. Arm/virt doesn't have m=
uch
tests in bios-tables-test.c. So does it make any difference?

> PS:
> I don't really know what ARM guest kernel expects but on x86 we had to en=
able
> numa
> for guest to figure out max_possible_pfn
> (see: in linux.git: 8dd330300197 / ec941c5ffede).

From whatever I can find, doesn't look like there is any special handling o=
f
max_possible_pfn in ARM64 world. The variable seems to be only updated
in acpi_numa_memory_affinity_init()

https://elixir.bootlin.com/linux/v5.3-rc3/source/drivers/acpi/numa.c#L298

Is there any way to test this in Guest to see whether this is actually a pr=
oblem?

Thanks,
Shameer

> It's worth to check if we might need a patch for turning on NUMA
> (how to do it in QEMU see: auto_enable_numa_with_memhp)

