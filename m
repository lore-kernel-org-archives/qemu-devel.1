Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A4C00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646512077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646512077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieN0s-0006I4-Gz
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ieN0F-0005ju-BO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ieN0E-0006Mq-4p
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:39:23 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2056 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ieN0B-0006Je-DP; Mon, 09 Dec 2019 12:39:19 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 6CD5060A903E0C8C1D2D;
 Mon,  9 Dec 2019 17:39:16 +0000 (GMT)
Received: from lhreml704-chm.china.huawei.com (10.201.108.53) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Dec 2019 17:39:16 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml704-chm.china.huawei.com (10.201.108.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 9 Dec 2019 17:39:15 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Mon, 9 Dec 2019 17:39:16 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>
Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Topic: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Index: AQHVeswdQv2zL2ZjnU2+5S1CywnCCKdgnucAgAYn2ECANV3CUIAANK6AgAADjLCAARyUgIADW0wAgBGftAA=
Date: Mon, 9 Dec 2019 17:39:15 +0000
Message-ID: <c2bb0be09e244ee59d27c7aaab1783a9@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
 <441c818f24084b4191315cf2a6267cef@huawei.com>
 <20191125164541.3f0a593f@redhat.com>
 <444efcb441fe42e5aff58b3af3ab14b4@huawei.com>
 <20191126095655.27227f59@redhat.com> 
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
 "drjones@redhat.com" <drjones@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 Linuxarm <linuxarm@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor/ xiaoguangrong,

> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: 28 November 2019 12:36
> To: 'Igor Mammedov' <imammedo@redhat.com>;
> xiaoguangrong.eric@gmail.com
> Cc: peter.maydell@linaro.org; drjones@redhat.com;
> shannon.zhaosl@gmail.com; qemu-devel@nongnu.org; Linuxarm
> <linuxarm@huawei.com>; Auger Eric <eric.auger@redhat.com>;
> qemu-arm@nongnu.org; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com
> Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
>=20
>=20
>=20
> > -----Original Message-----
> > From: Qemu-devel
> >
> [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongn
> > u.org] On Behalf Of Igor Mammedov
> > Sent: 26 November 2019 08:57
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: peter.maydell@linaro.org; drjones@redhat.com;
> > xiaoguangrong.eric@gmail.com; shannon.zhaosl@gmail.com;
> > qemu-devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; Auger Eric
> > <eric.auger@redhat.com>; qemu-arm@nongnu.org; xuwei (O)
> > <xuwei5@huawei.com>; lersek@redhat.com
> > Subject: Re: [PATCH 0/5] ARM virt: Add NVDIMM support
>=20
> [..]
>=20
> > > > 0xb8 Dirty No.  -->Another read is attempted
> > > > > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0x8
> > > > func_ret_status 3  --> Error status returned
> > > >
> > > > status 3 means that QEMU didn't like content of NRAM, and there is =
only
> > > > 1 place like this in nvdimm_dsm_func_read_fit()
> > > >     if (read_fit->offset > fit->len) {
> > > >         func_ret_status =3D NVDIMM_DSM_RET_STATUS_INVALID;
> > > >         goto exit;
> > > >     }
> > > >
> > > > so I'd start looking from here and check that QEMU gets expected da=
ta
> > > > in nvdimm_dsm_write(). In other words I'd try to trace/compare
> > > > content of DSM buffer (from qemu side).
> > >
> > > I had printed the DSM buffer previously and it looked same, I will do=
uble
> check
> > > that.
>=20
> Tried printing the buffer in both Qemu/AML code.
>=20
> On Amr64,

[...]
=20
> Attached the SSDT.dsl used for debugging. I am still not clear why on ARM=
64,
> 2nd iteration case, the created buffer size in NCAL and RFIT methods have
> additional 4 bytes!.
>=20
>     CreateField (ODAT, Zero, Local1, OBUF)
>     Concatenate (Buffer (Zero){}, OBUF, Local7)
>=20
> Please let me know if you have any clue.
>=20

I couldn't figure out yet, why this extra 4 bytes are added by aml code on =
ARM64
when the nvdimm_dsm_func_read_fit() returns NvdimmFuncReadFITOut without
any FIT data. ie, when the FIT buffer len (read_len) is zero.

But the below will fix this issue,

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index f91eea3802..cddf95f4c1 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -588,7 +588,7 @@ static void nvdimm_dsm_func_read_fit(NVDIMMState *state=
, NvdimmDsmIn *in,
     nvdimm_debug("Read FIT: offset %#x FIT size %#x Dirty %s.\n",
                  read_fit->offset, fit->len, fit_buf->dirty ? "Yes" : "No"=
);

-    if (read_fit->offset > fit->len) {
+    if (read_fit->offset >=3D fit->len) {
         func_ret_status =3D NVDIMM_DSM_RET_STATUS_INVALID;
         goto exit;
     }


This will return error code to aml in the second iteration when there is no=
 further
FIT data to report. But, I am not sure why this check was omitted in the fi=
rst place.

Please let me know if this is acceptable and then probably I can look into =
a v2 of this
series.

Thanks,
Shameer




