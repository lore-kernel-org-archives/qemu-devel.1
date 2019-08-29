Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C2FC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D092189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D092189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Kle-0001Q6-0w
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 09:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i3Kk9-0000qH-6s
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i3Kk8-0007z2-3E
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:45:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45436 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i3Kk5-0007uY-Ij; Thu, 29 Aug 2019 09:45:37 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 97C3896467875FF8B1EB;
 Thu, 29 Aug 2019 14:45:33 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.92]) by
 LHREML714-CAH.china.huawei.com ([10.201.108.37]) with mapi id 14.03.0415.000; 
 Thu, 29 Aug 2019 14:45:24 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [PATCH-for-4.2 v9 01/12] hw/acpi: Make ACPI IO address space
 configurable
Thread-Index: AQHVXkYfh6DcS0TZ1kGZvays3xLkbacR8aaAgAAORQCAACK90A==
Date: Thu, 29 Aug 2019 13:45:23 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F3A23B5@lhreml524-mbs.china.huawei.com>
References: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
 <20190813210539.31164-2-shameerali.kolothum.thodi@huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA83F36E598@lhreml524-mbs.china.huawei.com>
 <20190829104518.0995e7c5@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83F3A2027@lhreml524-mbs.china.huawei.com>
 <20190829143810.1dc33818@redhat.com>
In-Reply-To: <20190829143810.1dc33818@redhat.com>
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
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v9 01/12] hw/acpi: Make ACPI IO
 address space configurable
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
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 29 August 2019 13:38
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; sameo@linux.intel.com;
> ard.biesheuvel@linaro.org; Linuxarm <linuxarm@huawei.com>;
> shannon.zhaosl@gmail.com; sebastien.boeuf@intel.com; lersek@redhat.com
> Subject: Re: [PATCH-for-4.2 v9 01/12] hw/acpi: Make ACPI IO address space
> configurable
>=20
> On Thu, 29 Aug 2019 11:04:27 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

[...]

> >
> > I think what happens is since we are now passing the memhp_io_base
> directly into the
> > build_memory_hotplug_aml() and removed the "static uint16_t
> memhp_io_base", on
> > x86, memory hotplug aml code is always built by default irrespective of
> whether
> > acpi_memory_hotplug_init() is invoked or not.
> >
> > I could either reintroduce a check in build_memory_hotplug_aml() to mak=
e
> sure
> > acpi_memory_hotplug_init() is called, or could do something like below,

> fix looks fine to me, see minor comment below

Ok
=20
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 3995f9a40f..17756c2191 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1873,9 +1873,12 @@ build_dsdt(GArray *table_data, BIOSLinker
> *linker,
> >          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
> >                         "\\_SB.PCI0", "\\_GPE._E02");
> >      }
> > -    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",
> > -                             "\\_GPE._E03", AML_SYSTEM_IO,
> > -                             pcms->memhp_io_base);
> > +
> > +    if (acpi_enabled && pcms->acpi_dev && nr_mem) {
> double-check call path and see if
>   acpi_enabled && pcms->acpi_dev
> is really necessary

Right, looks like those are always true. I will remove those.

Also appreciate if you could take a look at rest of the series and then I c=
an
re-spin along with this.

Thanks,
Shameer
=20

