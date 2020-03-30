Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18524C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE89020732
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE89020732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIq30-0001DW-2u
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 04:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jIq2D-0000i2-4f
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jIq2B-0002tr-Iy
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:44:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2088 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jIq28-0002bl-58; Mon, 30 Mar 2020 04:44:36 -0400
Received: from lhreml703-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id A52C62B286B69241BED5;
 Mon, 30 Mar 2020 09:44:29 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml703-chm.china.huawei.com (10.201.108.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 30 Mar 2020 09:44:29 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Mon, 30 Mar 2020 09:44:29 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v3 00/10] ARM virt: Add NVDIMM support
Thread-Topic: [PATCH v3 00/10] ARM virt: Add NVDIMM support
Thread-Index: AQHV98ng4FwIUKGPUES/xPmID4yPwKhfbgqAgAF+0aA=
Date: Mon, 30 Mar 2020 08:44:29 +0000
Message-ID: <feb17f74f9d547019d052032395b9667@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200329064435-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200329064435-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.27.100]
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
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "david@redhat.com" <david@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei
 \(O\)" <xuwei5@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: 29 March 2020 11:46
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; imammedo@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; xiaoguangrong.eric@gmail.com;
> david@redhat.com; xuwei (O) <xuwei5@huawei.com>; lersek@redhat.com;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v3 00/10] ARM virt: Add NVDIMM support
>=20
> On Wed, Mar 11, 2020 at 05:20:04PM +0000, Shameer Kolothum wrote:
> > This series adds NVDIMM support to arm/virt platform.
>=20
>=20
> So I'm still confused about whether there's a bugfix here
> that we need for 5.0. If yes pls post just that part
> with acks included and for-5.0 in the subject.

Ok. I can send the first 4 patches in this series as general fixes,
but as I mentioned earlier they only matter if we add nvdimm arm/virt
support. The only case I am not sure that may break x86 is the RSDP
table update and the resulting size inconsistency during migration=20
discussed in patch #2.
=20
Anyways I think it is better to send those separately.

Thanks,
Shameer=20

> > The series reuses some of the patches posted by Eric
> > in his earlier attempt here[1].
> >
> > This also include few fixes to qemu in general which were
> > discovered while adding nvdimm support to arm/virt.
> >
> > Patch #2 addresses the issue[2] that, during migration, the
> > source and destination might end up with an inconsistency
> > in acpi table memory region sizes.
> >
> > Patch #3 is to fix the qemu_ram_resize() callback issue[2].
> >
> > Patch #4 is another fix to the nvdimm aml issue discussed
> > here[3].
> >
> > I have done a basic sanity testing of NVDIMM devices
> > with Guest booting with ACPI. Further testing is always
> > welcome.
> >
> > Please let me know your feedback.
> >
> > Thanks,
> > Shameer
> >
> > [1] https://patchwork.kernel.org/cover/10830777/
> > [2] https://patchwork.kernel.org/patch/11339591/
> > [3] https://patchwork.kernel.org/cover/11174959/
> >
> > v2 --> v3
> >  - Added patch #1 and # 2 to fix the inconsistency in acpi
> >    table memory region sizes during migration. Thanks to
> >    David H.
> >  - The fix for qemu_ram_resize() callback was modified to
> >    the one in patch #3. Again thanks to David H.
> >  - Addressed comments from MST and Eric on tests added.
> >  - Addressed comments from Igor/MST on Integer size in patch #4
> >  - Added Eric's R-by to patch #7.
> >
> > v1 --> v2
> >  -Reworked patch #1 and now fix is inside qemu_ram_resize().
> >  -Added patch #2 to fix the nvdim aml issue.
> >  -Dropped support to DT cold plug.
> >  -Updated test_acpi_virt_tcg_memhp() with pc-dimm and nvdimms(patch
> #7)
> >
> > David Hildenbrand (1):
> >   exec: Fix for qemu_ram_resize() callback
> >
> > Kwangwoo Lee (2):
> >   nvdimm: Use configurable ACPI IO base and size
> >   hw/arm/virt: Add nvdimm hot-plug infrastructure
> >
> > Shameer Kolothum (7):
> >   acpi: Use macro for table-loader file name
> >   fw_cfg: Migrate ACPI table mr sizes separately
> >   hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output buffer length
> >   hw/arm/virt: Add nvdimm hotplug support
> >   tests: Update ACPI tables list for upcoming arm/virt test changes
> >   tests/bios-tables-test: Update arm/virt memhp test
> >   tests/acpi: add expected tables for bios-tables-test
> >
> >  docs/specs/acpi_hw_reduced_hotplug.rst |   1 +
> >  exec.c                                 |  14 +++-
> >  hw/acpi/generic_event_device.c         |  15 ++++-
> >  hw/acpi/nvdimm.c                       |  72
> +++++++++++++++++----
> >  hw/arm/Kconfig                         |   1 +
> >  hw/arm/virt-acpi-build.c               |   8 ++-
> >  hw/arm/virt.c                          |  35 ++++++++--
> >  hw/core/machine.c                      |   1 +
> >  hw/i386/acpi-build.c                   |   8 ++-
> >  hw/i386/acpi-build.h                   |   3 +
> >  hw/i386/pc_piix.c                      |   2 +
> >  hw/i386/pc_q35.c                       |   2 +
> >  hw/mem/Kconfig                         |   2 +-
> >  hw/nvram/fw_cfg.c                      |  86
> ++++++++++++++++++++++++-
> >  include/hw/acpi/aml-build.h            |   1 +
> >  include/hw/acpi/generic_event_device.h |   1 +
> >  include/hw/arm/virt.h                  |   1 +
> >  include/hw/mem/nvdimm.h                |   3 +
> >  include/hw/nvram/fw_cfg.h              |   6 ++
> >  tests/data/acpi/pc/SSDT.dimmpxm        | Bin 685 -> 734 bytes
> >  tests/data/acpi/q35/SSDT.dimmpxm       | Bin 685 -> 734 bytes
> >  tests/data/acpi/virt/DSDT.memhp        | Bin 6644 -> 6668 bytes
> >  tests/data/acpi/virt/NFIT.memhp        | Bin 0 -> 224 bytes
> >  tests/data/acpi/virt/SSDT.memhp        | Bin 0 -> 736 bytes
> >  tests/qtest/bios-tables-test.c         |   9 ++-
> >  25 files changed, 244 insertions(+), 27 deletions(-)
> >  create mode 100644 tests/data/acpi/virt/NFIT.memhp
> >  create mode 100644 tests/data/acpi/virt/SSDT.memhp
> >
> > --
> > 2.17.1
> >


