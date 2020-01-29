Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E6C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1454920720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1454920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkqA-0006YT-4G
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iwkpb-0005xO-EH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iwkpa-0002QS-3i
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:44:23 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2067 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iwkpW-0002O3-QP; Wed, 29 Jan 2020 05:44:18 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 075591C4EC060FD8C653;
 Wed, 29 Jan 2020 10:44:17 +0000 (GMT)
Received: from lhreml708-chm.china.huawei.com (10.201.108.57) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Jan 2020 10:44:16 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml708-chm.china.huawei.com (10.201.108.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 29 Jan 2020 10:44:16 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Wed, 29 Jan 2020 10:44:16 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Subject: RE: [PATCH v2 0/7] ARM virt: Add NVDIMM support
Thread-Topic: [PATCH v2 0/7] ARM virt: Add NVDIMM support
Thread-Index: AQHVzV42yTrHPe4JeEKQykfFHPYCE6gARKaAgAFB8XA=
Date: Wed, 29 Jan 2020 10:44:16 +0000
Message-ID: <c0528fddc5424471969a7d41e02cce2b@huawei.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <7b338b7c-fd47-930b-53d5-894711c69941@redhat.com>
In-Reply-To: <7b338b7c-fd47-930b-53d5-894711c69941@redhat.com>
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
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: 28 January 2020 15:29
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> qemu-devel@nongnu.org; qemu-arm@nongnu.org; imammedo@redhat.com
> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; mst@redhat.com;
> xiaoguangrong.eric@gmail.com; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v2 0/7] ARM virt: Add NVDIMM support
>=20
> Hi Shameer,
>=20
> On 1/17/20 6:45 PM, Shameer Kolothum wrote:
> > This series adds NVDIMM support to arm/virt platform.
> > The series reuses some of the patches posted by Eric
> > in his earlier attempt here[1].
> >
> > Patch #1 is a fix to the Guest reboot issue on NVDIMM
> > hot add case described here[2] and patch #2 is another
> > fix to the nvdimm aml issue discussed here[3].
> >
> > I have done a basic sanity testing of NVDIMM deviecs
> > with Guest booting with both ACPI and DT. Further testing
> > is always welcome.
> >
> > Please let me know your feedback.
>=20
>=20
> With this version, I do not get the former spurious warning reported on v=
1.
>=20
> I can see the nvdimm device topology using ndctl. So it looks fine to me.

Thanks for giving it a spin and confirming.=20

> Unfortunately we cannot test with DAX as kernel dependencies are not yet
> resolved yet but this is an independent problem.

True. I did previously test DAX with "arm64/mm: Enable memory hot remove"
Patch series and that seems to work fine.

Cheers,
Shameer


=20
> Thanks
>=20
> Eric
> >
> > Thanks,
> > Shameer
> >
> > [1] https://patchwork.kernel.org/cover/10830777/
> > [2] https://patchwork.kernel.org/patch/11154757/
> > [3] https://patchwork.kernel.org/cover/11174959/
> >
> > v1 --> v2
> >  -Reworked patch #1 and now fix is inside qemu_ram_resize().
> >  -Added patch #2 to fix the nvdim aml issue.
> >  -Dropped support to DT cold plug.
> >  -Updated test_acpi_virt_tcg_memhp() with pc-dimm and nvdimms(patch
> #7)
> >
> > Kwangwoo Lee (2):
> >   nvdimm: Use configurable ACPI IO base and size
> >   hw/arm/virt: Add nvdimm hot-plug infrastructure
> >
> > Shameer Kolothum (5):
> >   exec: Fix for qemu_ram_resize() callback
> >   hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output  buffer  length
> >   hw/arm/virt: Add nvdimm hotplug support
> >   tests: Update ACPI tables list for upcoming arm/virt test changes
> >   tests/bios-tables-test: Update arm/virt memhp test
> >
> >  docs/specs/acpi_hw_reduced_hotplug.rst      |  1 +
> >  exec.c                                      | 36 +++++++----
> >  hw/acpi/generic_event_device.c              | 13 ++++
> >  hw/acpi/nvdimm.c                            | 68
> +++++++++++++++++----
> >  hw/arm/Kconfig                              |  1 +
> >  hw/arm/virt-acpi-build.c                    |  6 ++
> >  hw/arm/virt.c                               | 35 +++++++++--
> >  hw/i386/acpi-build.c                        |  6 ++
> >  hw/i386/acpi-build.h                        |  3 +
> >  hw/i386/pc_piix.c                           |  2 +
> >  hw/i386/pc_q35.c                            |  2 +
> >  hw/mem/Kconfig                              |  2 +-
> >  include/exec/ram_addr.h                     |  5 +-
> >  include/hw/acpi/generic_event_device.h      |  1 +
> >  include/hw/arm/virt.h                       |  1 +
> >  include/hw/mem/nvdimm.h                     |  3 +
> >  tests/data/acpi/virt/NFIT.memhp             |  0
> >  tests/data/acpi/virt/SSDT.memhp             |  0
> >  tests/qtest/bios-tables-test-allowed-diff.h |  5 ++
> >  tests/qtest/bios-tables-test.c              |  9 ++-
> >  20 files changed, 163 insertions(+), 36 deletions(-)
> >  create mode 100644 tests/data/acpi/virt/NFIT.memhp
> >  create mode 100644 tests/data/acpi/virt/SSDT.memhp
> >


