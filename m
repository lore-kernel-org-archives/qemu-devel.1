Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A0CC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30EB2467D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30EB2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aLo-0000Kb-Rj
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j6ZHa-0003CL-PB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j6ZHZ-0006Mk-1Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:25:50 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2504 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j6ZHX-0006Jg-RH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:25:48 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 1C03BAE976CE32B78D09;
 Tue, 25 Feb 2020 20:25:41 +0800 (CST)
Received: from dggeme708-chm.china.huawei.com (10.1.199.104) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 20:25:40 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 25 Feb 2020 20:25:40 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Tue, 25 Feb 2020 20:25:40 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v4 3/3] ACPI/unit-test: Add a new test for pxb-pcie for arm
Thread-Topic: [PATCH v4 3/3] ACPI/unit-test: Add a new test for pxb-pcie for
 arm
Thread-Index: AQHV634D1GQZIb6UqUu+euvnfaaE36grP0SAgACTdIA=
Date: Tue, 25 Feb 2020 12:25:40 +0000
Message-ID: <518693ae75ed4c07ba6d31435ef11221@huawei.com>
References: <20200225015026.940-1-miaoyubo@huawei.com>
 <20200225015026.940-4-miaoyubo@huawei.com>
 <20200225062154-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200225062154-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.29]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.188
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
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, February 25, 2020 7:25 PM
> To: miaoyubo <miaoyubo@huawei.com>
> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; Xiexiangyou
> <xiexiangyou@huawei.com>; imammedo@redhat.com; qemu-
> devel@nongnu.org; berrange@redhat.com
> Subject: Re: [PATCH v4 3/3] ACPI/unit-test: Add a new test for pxb-pcie f=
or
> arm
>=20
> On Tue, Feb 25, 2020 at 09:50:26AM +0800, Yubo Miao wrote:
> > From: miaoyubo <miaoyubo@huawei.com>
> >
> > Currently, pxb-pcie could be defined by the cmdline like
> >     --device pxb-pcie,id=3Dpci.9,bus_nr=3D128 However pxb-pcie is not
> > described in acpi tables for arm.
> >
> > The formal two patches support pxb-pcie for arm, escpcially the
> > specification for pxb-pcie in DSDT table.
>=20
>=20
> especially? Pls spell-check comments and commit log, it's not hard to do.
>=20

Thanks for pointing out and sorry for the mistakes,=20
I will check all the comments and commit log.

> > Add a testcase to make sure the ACPI table is correct for guest.
> >
> > The following table need to be added for this test:
> >     tests/data/acpi/virt/DSDT.pxb
> > Since the ASL diff has 1000+ lines, it would be presented in commit
> > log with the simply diff. the diff are:
> >     Device (PC80) is presented in DSDT.
> >     Resources allocated for Device (PCI0) is changed.
> >
> >   * Disassembling to symbolic ASL+ operators
> >   *
> > - * Disassembly of /home/DSDT, Mon Feb 24 19:35:28 2020
> > + * Disassembly of /home/DSDT.pxb, Mon Feb 24 19:33:38 2020
> >   *
> >   * Original Table Header:
> >   *     Signature        "DSDT"
> > - *     Length           0x000014BB (5307)
> > + *     Length           0x00001F70 (8048)
> >   *     Revision         0x02
> > - *     Checksum         0xD1
> > + *     Checksum         0xCF
> >   *     OEM ID           "BOCHS "
> >   *     OEM Table ID     "BXPCDSDT"
> >   *     OEM Revision     0x00000001 (1)
> >              })
> >          }
> >
> >          {
> >              Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Har=
dware
> ID
> >                      WordBusNumber (ResourceProducer, MinFixed, MaxFixe=
d,
> PosDecode,
> >                          0x0000,             // Granularity
> >                          0x0000,             // Range Minimum
> > -                        0x00FF,             // Range Maximum
> > +                        0x007F,             // Range Maximum
> >                          0x0000,             // Translation Offset
> > -                        0x0100,             // Length
> > +                        0x0080,             // Length
> >                          ,, )
> >                      DWordMemory (ResourceProducer, PosDecode, MinFixed=
,
> MaxFixed, NonCacheable, ReadWrite,
> >                          0x00000000,         // Granularity
> >                          0x10000000,         // Range Minimum
> > -                        0x3EFEFFFF,         // Range Maximum
> > +                        0x3E9EFFFF,         // Range Maximum
> >                          0x00000000,         // Translation Offset
> > -                        0x2EFF0000,         // Length
> > +                        0x2E9F0000,         // Length
> >                          ,, , AddressRangeMemory, TypeStatic)
> >                      DWordIO (ResourceProducer, MinFixed, MaxFixed, Pos=
Decode,
> EntireRange,
> >                          0x00000000,         // Granularity
> >                          0x00000000,         // Range Minimum
> > -                        0x0000FFFF,         // Range Maximum
> > +                        0x0000BFFF,         // Range Maximum
> >                          0x3EFF0000,         // Translation Offset
> > -                        0x00010000,         // Length
> > +                        0x0000C000,         // Length
> >                          ,, , TypeStatic, DenseTranslation)
> >                      QWordMemory (ResourceProducer, PosDecode, MinFixed=
,
> MaxFixed, NonCacheable, ReadWrite,
> >                          0x0000000000000000, // Granularity
> >
> > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
>=20
>=20
> Seems to fail in patchew.
>=20

The failure is due to CONFIG_PXB is not configured.
Since it is not configured by default, I will add ifdef CONFIG_PXB
before the pxb unit test to solve this problem.=20

> > ---
> >  tests/data/acpi/virt/DSDT.pxb               | Bin 0 -> 8048 bytes
> >  tests/qtest/bios-tables-test-allowed-diff.h |   1 +
> >  tests/qtest/bios-tables-test.c              |  54 +++++++++++++++++---
> >  3 files changed, 49 insertions(+), 6 deletions(-)  create mode 100644
> > tests/data/acpi/virt/DSDT.pxb
>=20
> This needs to be in a separate patch.
> See instructions in ./tests/qtest/bios-tables-test.c.
>=20
>=20

Alright, I would separate this patch into three patches.
1. tests/qtest/bios-tables-test-allowed-diff.h
2. Changes made to the unit tests (tests/qtest/bios-tables-test.c)
3. The binary file and clear tests/qtest/bios-tables-test-allowed-diff.h

> > new file mode 100644
> > index
> >
> 0000000000000000000000000000000000000000..6ac0b5212db49513c27ef50da
> 838
> > 240826c2deb7
> > GIT binary patch
> > literal 8048
> >
> >  static void test_acpi_tcg_acpi_hmat(const char *machine)  {
> >      test_data data;
> > @@ -1052,6 +1093,7 @@ int main(int argc, char *argv[])
> >          qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> >          qtest_add_func("acpi/virt/numamem",
> test_acpi_virt_tcg_numamem);
> >          qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
> > +        qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
> >      }
> >      ret =3D g_test_run();
> >      boot_sector_cleanup(disk);
> > --
> > 2.19.1
> >

Regards,
Miao

