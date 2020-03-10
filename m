Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B255C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016EE24691
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016EE24691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcyW-0007u0-8r
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jBcxm-00072g-2V
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jBcxj-00080h-CI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:22:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2080 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jBcxg-0007gK-6j; Tue, 10 Mar 2020 07:22:12 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id B6295C1C3748F61208F1;
 Tue, 10 Mar 2020 11:22:05 +0000 (GMT)
Received: from lhreml707-chm.china.huawei.com (10.201.108.56) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 11:22:05 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-chm.china.huawei.com (10.201.108.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 10 Mar 2020 11:22:04 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Tue, 10 Mar 2020 11:22:05 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH v2 2/7] hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM
 output buffer length
Thread-Topic: [PATCH v2 2/7] hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM
 output buffer length
Thread-Index: AQHV3Qdz5JGOPsnNwE6dDrrHrA5o8ahB4dxg
Date: Tue, 10 Mar 2020 11:22:05 +0000
Message-ID: <feb0b61b1bf741219e08b8c2dc6260f8@huawei.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-3-shameerali.kolothum.thodi@huawei.com>
 <20200206170604.12899caf@redhat.com>
In-Reply-To: <20200206170604.12899caf@redhat.com>
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
 "mst@redhat.com" <mst@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei
 \(O\)" <xuwei5@huawei.com>, "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 06 February 2020 16:06
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> xiaoguangrong.eric@gmail.com; mst@redhat.com; Linuxarm
> <linuxarm@huawei.com>; xuwei (O) <xuwei5@huawei.com>;
> shannon.zhaosl@gmail.com; lersek@redhat.com
> Subject: Re: [PATCH v2 2/7] hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM
> output buffer length
>=20
> On Fri, 17 Jan 2020 17:45:17 +0000
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > As per ACPI spec 6.3, Table 19-419 Object Conversion Rules, if the
> > Buffer Field <=3D to the size of an Integer (in bits), it will be
> > treated as an integer. Moreover, the integer size depends on DSDT
> > tables revision number. If revision number is < 2, integer size is 32
> > bits, otherwise it is 64 bits. Current NVDIMM common DSM aml code
> > (NCAL) uses CreateField() for creating DSM output buffer. This creates
> > an issue in arm/virt platform where DSDT revision number is 2 and
> > results in DSM buffer with a wrong
> > size(8 bytes) gets returned when actual length is < 8 bytes.
> > This causes guest kernel to report,
> >
> > "nfit ACPI0012:00: found a zero length table '0' parsing nfit"
> >
> > In order to fix this, aml code is now modified such that it builds the
> > DSM output buffer in a byte by byte fashion when length is smaller
> > than Integer size.
> >
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> > Please find the previous discussion on this here,
> > https://patchwork.kernel.org/cover/11174959/
> >
> > ---
> >  hw/acpi/nvdimm.c                            | 36
> +++++++++++++++++++--
> >  tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
> >  2 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c index
> > 9fdad6dc3f..5e7b8318d0 100644
> > --- a/hw/acpi/nvdimm.c
> > +++ b/hw/acpi/nvdimm.c
> > @@ -964,6 +964,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
> >      Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem,
> *elsectx2;
> >      Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invali=
d;
> >      Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf,
> > *dsm_out_buf_size;
> > +    Aml *whilectx, *offset;
> >      uint8_t byte_list[1];
> >
> >      method =3D aml_method(NVDIMM_COMMON_DSM, 5,
> AML_SERIALIZED); @@
> > -1117,13 +1118,42 @@ static void nvdimm_build_common_dsm(Aml *dev)
> >      /* RLEN is not included in the payload returned to guest. */
> >      aml_append(method,
> aml_subtract(aml_name(NVDIMM_DSM_OUT_BUF_SIZE),
> >                 aml_int(4), dsm_out_buf_size));
> > +
> > +    /*
> > +     * As per ACPI spec 6.3, Table 19-419 Object Conversion Rules, if
> > +     * the Buffer Field <=3D to the size of an Integer (in bits), it w=
ill
> > +     * be treated as an integer. Moreover, the integer size depends on
> > +     * DSDT tables revision number. If revision number is < 2, integer
> > +     * size is 32 bits, otherwise it is 64 bits.
> > +     * Because of this CreateField() canot be used if RLEN < Integer S=
ize.
> > +     * Hence build dsm_out_buf byte by byte.
> > +     */
> > +    ifctx =3D aml_if(aml_lless(dsm_out_buf_size,
> > + aml_sizeof(aml_int(0))));
>=20
> this decomplies into
>=20
>  If (Local1 < SizeOf ())
>=20
> which doesn't look right

Ok. I tried printing the value returned(SizeOf) and that looks alright.

Anyway, changed it into aml_int(1) which decompiles to

   If (Local1 < SizeOf (One))

Hope this is acceptable.

Thanks,
Shameer

