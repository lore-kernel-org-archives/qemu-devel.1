Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7310AC35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CB62071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CB62071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5RHX-0004LN-EI
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j5RGg-0003q9-3v
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 04:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j5RGe-0001Gr-Q4
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 04:40:13 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2447 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j5RGe-0000yA-E3
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 04:40:12 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 904FA3E0AA9FE18EA6AC;
 Sat, 22 Feb 2020 17:40:08 +0800 (CST)
Received: from dggeme705-chm.china.huawei.com (10.1.199.101) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 22 Feb 2020 17:40:08 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme705-chm.china.huawei.com (10.1.199.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 22 Feb 2020 17:40:07 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Sat, 22 Feb 2020 17:40:07 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [RFC v3 3/3] ACPI/unit-test: Add a new test for pxb-pcie for arm
Thread-Topic: [RFC v3 3/3] ACPI/unit-test: Add a new test for pxb-pcie for arm
Thread-Index: AQHV6IEd6Svy29h+HkqfrMST6pP6Uagk+maAgAH8DnA=
Date: Sat, 22 Feb 2020 09:40:07 +0000
Message-ID: <817d9cb2699d4294a2ba4ae949079eea@huawei.com>
References: <20200221063512.1104-1-miaoyubo@huawei.com>
 <20200221063512.1104-4-miaoyubo@huawei.com>
 <20200221061811-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200221061811-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.131.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.187
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
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Friday, February 21, 2020 7:19 PM
> To: miaoyubo <miaoyubo@huawei.com>
> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; Xiexiangyou
> <xiexiangyou@huawei.com>; imammedo@redhat.com;
> qemu-devel@nongnu.org
> Subject: Re: [RFC v3 3/3] ACPI/unit-test: Add a new test for pxb-pcie for=
 arm
>=20
> On Fri, Feb 21, 2020 at 02:35:12PM +0800, Yubo Miao wrote:
> > From: miaoyubo <miaoyubo@huawei.com>
> >
> > Currently, pxb-pcie could be defined by the cmdline like
> >     --device pxb-pcie,id=3Dpci.9,bus_nr=3D128 However pxb-pcie is not
> > described in acpi tables for arm.
> >
> > The formal two patches support pxb-pcie for arm, escpcially the
> > specification for pxb-pcie in DSDT table.
> >
> > Add a testcase to make sure the ACPI table is correct for guest.
> >
> > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
>=20
>=20
> Please look at the top of tests/qtest/bios-tables-test.c for how to add o=
r
> update tests.
>=20

Thanks for replying, I didn't notice that, I would follow the steps to rebu=
ild this patch.

> > ---
> >  tests/data/acpi/virt/DSDT.pxb  | Bin 0 -> 34209 bytes
> > tests/qtest/bios-tables-test.c |  54 +++++++++++++++++++++++++++++----
> >  2 files changed, 48 insertions(+), 6 deletions(-)  create mode 100644
> > tests/data/acpi/virt/DSDT.pxb
> >
> > diff --git a/tests/data/acpi/virt/DSDT.pxb
> > b/tests/data/acpi/virt/DSDT.pxb new file mode 100644 index
> >
> 0000000000000000000000000000000000000000..4eea3192c75ff28f7054d626
> a936
> > 3ca025b6c0ad
> > GIT binary patch
>=20
> I can't read this.
>=20

I just have a question that is:=20
I just rebuild this aml with tests/data/acpi/rebuild-expected-aml.sh
and git send it or send the aml with attachment?

> > literal 34209
> >
> zcmeI*cXU+szJ~D)1PGxe5PG+us9-{<Do8R35G4>YGz}UAMT!L#ks?x*Dx!d5hoIP
> d
> >
> z?}}o>iWL;GW5HgrlKbvVM&HM??^)~qbMIProvd|8p2_U*%qO!m?AgcPkRQ(<w
> r)WX
> >
> zR3DKyBsMVKK5tZUEMJ#Z3xXj0I{cizY-H-_vUpxu>HL<ltgNimvVn#9^>bszg^Hd*
> >
> zYT59@{GfDxK}u{$QSzH5MFX?4va_qcnOYVriD$G-YqqdX5KgQUqzA#0T0ymH9a
> J-P
> > zt=3D#;Qdf_)p=3DV$jH6t9{xXmH68P3ev)8EFlwrs(=3DX$_(9dxJh>6UU8FZi5vcVla%B=
p
> >
> zz50)g^-pXvw4i9XAYFAU@nN}Xb+t___n%u<uhU$chBua*GNL5;Gf3Q8mfgX>w)`
> 8L
> >
> z7F4goX88!*;pB+$X8&bG_2BOj*;OO*!h6xx&B+mI)uU#l*o>||BPVi3ji?#5Y(|dH
> >
> z=3DoUF6C2B^h&FJPcx<}5a88su#W_0%%JtAk+ikeZ+X7unGJtJq-j+)WHX7uzKy&`9
> %
>=20
> ...

Regards,
Miao

