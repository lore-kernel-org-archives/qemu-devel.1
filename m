Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E08DC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D742053B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D742053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83iv-0007WQ-6V
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i83hM-0006A4-M7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i83hK-0008Gu-UH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:34:20 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45439 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i83hH-0008Cc-WE; Wed, 11 Sep 2019 10:34:16 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id F0AADDF8E75B0C40E743;
 Wed, 11 Sep 2019 15:34:07 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.65]) by
 lhreml704-cah.china.huawei.com ([10.201.108.45]) with mapi id 14.03.0415.000; 
 Wed, 11 Sep 2019 15:33:58 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH-for-4.2 v10 10/11] tests: add dummy ACPI
 tables for arm/virt board
Thread-Index: AQHVaKCGzbvsHHTXD0ChWK1EWAGw9qcmbamAgAABfACAABQOkA==
Date: Wed, 11 Sep 2019 14:33:57 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F3EAF63@lhreml524-mbs.china.huawei.com>
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-11-shameerali.kolothum.thodi@huawei.com>
 <CAFEAcA8sEhgOXnj-DGo04pSnpTObO+EeC94yrdGEikKq0=2QeA@mail.gmail.com>
 <20190911155015.3627b072@redhat.com>
 <20190911095332-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190911095332-mutt-send-email-mst@kernel.org>
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
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 10/11] tests: add dummy ACPI
 tables for arm/virt board
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU
 Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "xuwei \(O\)" <xuwei5@huawei.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 Laszlo Ersek <lersek@redhat.com>, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongn
> u.org] On Behalf Of Michael S. Tsirkin
> Sent: 11 September 2019 14:56
> To: Igor Mammedov <imammedo@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Samuel Ortiz
> <sameo@linux.intel.com>; Ard Biesheuvel <ard.biesheuvel@linaro.org>;
> QEMU Developers <qemu-devel@nongnu.org>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; Shannon Zhao <shannon.zhaosl@gmail.com>;
> qemu-arm <qemu-arm@nongnu.org>; xuwei (O) <xuwei5@huawei.com>; Eric
> Auger <eric.auger@redhat.com>; sebastien.boeuf@intel.com; Laszlo Ersek
> <lersek@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 10/11] tests: add dummy ACPI
> tables for arm/virt board
>=20
> On Wed, Sep 11, 2019 at 03:50:15PM +0200, Igor Mammedov wrote:
> > On Wed, 11 Sep 2019 13:57:06 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > > On Wed, 4 Sep 2019 at 09:58, Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com> wrote:
> > > >
> > > > This patch is in preparation for adding numamem and memhp tests
> > > > to arm/virt board so that 'make check' is happy. This may not
> > > > be required once the scripts are run and new tables are
> > > > generated with ".numamem" and ".memhp" extensions.
> > > >
> > > > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > > > ---
> > > > I am not sure this is the right way to do this. But without this, w=
hen
> > > > the numamem and memhp tests are added, you will get,
> > > >
> > > > Looking for expected file 'tests/data/acpi/virt/SRAT.numamem'
> > > > Looking for expected file 'tests/data/acpi/virt/SRAT'
> > > > **
> > > > ERROR:tests/bios-tables-test.c:327:load_expected_aml: assertion fai=
led:
> (exp_sdt.aml_file)
> > > >
> > > > ---
> > > >  tests/data/acpi/virt/SLIT | Bin 0 -> 48 bytes
> > > >  tests/data/acpi/virt/SRAT | Bin 0 -> 224 bytes
> > > >  2 files changed, 0 insertions(+), 0 deletions(-)
> > > >  create mode 100644 tests/data/acpi/virt/SLIT
> > > >  create mode 100644 tests/data/acpi/virt/SRAT
> > >
> > > Do the tests pass with this patch and without the
> > > patch that adds the tests? (That is, can we keep the
> > > two patches separate without breaking bisection, or
> > > do we need to squash them together?)
> > >
> > > I'll leave it to somebody who understands the ACPI
> > > tests stuff to answer whether there's a better way to
> > I'd squash this patch into 11/11 test case,
>=20
>=20
> Pls don't - the way to add this is to add the files in question to
> tests/bios-tables-test-allowed-diff.h.

IIRC, I have tried that but didn't work. I think the reason being, these
are new test cases for arm/virt and both SRAT and SLIT tables are not
present in the tests/data/acpi/virt folder.

As you can see the error is different,

> > > > Looking for expected file 'tests/data/acpi/virt/SRAT.numamem'
> > > > Looking for expected file 'tests/data/acpi/virt/SRAT'
> > > > **
> > > > ERROR:tests/bios-tables-test.c:327:load_expected_aml: assertion fai=
led:

Not sure I missed anything though.

Thanks,
Shameer

> Maintainer will create a separate commit updating
> the binaries and removing them from the whitelist.
>=20
> This way things like rebase work seemlessly.
>=20
>=20
> > CCing Michael (since he's the one who applies ACPI patches)
> >
> > > do this.
> > >
> > > thanks
> > > -- PMM
> > >


