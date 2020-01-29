Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2FFC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4201E20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4201E20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwki9-00029z-F4
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iwkhU-0001b7-6L
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iwkhT-0004rH-1K
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:36:00 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2066 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iwkhP-0004Y7-Vt; Wed, 29 Jan 2020 05:35:56 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 8A3F61A824328CE5C8EF;
 Wed, 29 Jan 2020 10:35:49 +0000 (GMT)
Received: from lhreml702-chm.china.huawei.com (10.201.108.51) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Jan 2020 10:35:48 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml702-chm.china.huawei.com (10.201.108.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 29 Jan 2020 10:35:48 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Wed, 29 Jan 2020 10:35:48 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Subject: RE: [PATCH v2 7/7] tests/bios-tables-test: Update arm/virt memhp test
Thread-Topic: [PATCH v2 7/7] tests/bios-tables-test: Update arm/virt memhp test
Thread-Index: AQHVzV5G+cQh10jGFkuymacLK0srHqgAVXcAgAEtZFA=
Date: Wed, 29 Jan 2020 10:35:48 +0000
Message-ID: <77db9c11b6f248208ce50bb6a267bf16@huawei.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-8-shameerali.kolothum.thodi@huawei.com>
 <6cdba6ae-928d-696b-19b2-f4f81f341f3a@redhat.com>
In-Reply-To: <6cdba6ae-928d-696b-19b2-f4f81f341f3a@redhat.com>
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
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "xuwei
 \(O\)" <xuwei5@huawei.com>, "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongn
> u.org] On Behalf Of Auger Eric
> Sent: 28 January 2020 16:29
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> qemu-devel@nongnu.org; qemu-arm@nongnu.org; imammedo@redhat.com
> Cc: peter.maydell@linaro.org; xiaoguangrong.eric@gmail.com;
> mst@redhat.com; Linuxarm <linuxarm@huawei.com>; xuwei (O)
> <xuwei5@huawei.com>; shannon.zhaosl@gmail.com; lersek@redhat.com
> Subject: Re: [PATCH v2 7/7] tests/bios-tables-test: Update arm/virt memhp
> test
>=20
> Hi Shameer,
>=20
> On 1/17/20 6:45 PM, Shameer Kolothum wrote:
> > Since we now have both pc-dimm and nvdimm support, update
> > test_acpi_virt_tcg_memhp() to include those.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  tests/data/acpi/virt/NFIT.memhp | 0
> >  tests/data/acpi/virt/SSDT.memhp | 0
> Is it normal to have those 2 above void files? I lost track about the
> process.

I guess so :). From tests/qtest/bios-tables-test.c,

/*
 * How to add or update the tests:
 * Contributor:
 * 1. add empty files for new tables, if any, under tests/data/acpi
 * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
 * 3. commit the above *before* making changes that affect the tables
 ...

After reading that again, I am not sure those empty files can be in this
Patch or not. I can move it to 6/7.

> >  tests/qtest/bios-tables-test.c  | 9 +++++++--
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> >  create mode 100644 tests/data/acpi/virt/NFIT.memhp
> >  create mode 100644 tests/data/acpi/virt/SSDT.memhp
> >
> > diff --git a/tests/data/acpi/virt/NFIT.memhp
> b/tests/data/acpi/virt/NFIT.memhp
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/virt/SSDT.memhp
> b/tests/data/acpi/virt/SSDT.memhp
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-t=
est.c
> > index f1ac2d7e96..695d2e7fac 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -913,12 +913,17 @@ static void test_acpi_virt_tcg_memhp(void)
> >      };
> >
> >      data.variant =3D ".memhp";
> > -    test_acpi_one(" -cpu cortex-a57"
> > +    test_acpi_one(" -machine nvdimm=3Don"
> nit: maybe keep the same order as before ...
> > +                  " -cpu cortex-a57"
> >                    " -m 256M,slots=3D3,maxmem=3D1G"
> and simply add ,nvdimm=3Don to above line.
> >                    " -object memory-backend-ram,id=3Dram0,size=3D128M"
> >                    " -object memory-backend-ram,id=3Dram1,size=3D128M"
> >                    " -numa node,memdev=3Dram0 -numa
> node,memdev=3Dram1"
> > -                  " -numa dist,src=3D0,dst=3D1,val=3D21",
> > +                  " -numa dist,src=3D0,dst=3D1,val=3D21"
> > +                  " -object memory-backend-ram,id=3Dram2,size=3D128M"
> > +                  " -object memory-backend-ram,id=3Dnvm0,size=3D128M"
> > +                  " -device pc-dimm,id=3Ddimm0,memdev=3Dram2,node=3D0"
> > +                  " -device nvdimm,id=3Ddimm1,memdev=3Dnvm0,node=3D1",
> >                    &data);
> >
> >      free_test_data(&data);
> >

Ok. Noted.

Thanks,
Shameer

