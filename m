Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A01C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30FA20740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30FA20740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZHCh-0002Cr-2I
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iZHBb-0000zz-L3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iZHBZ-0005mB-Kt
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:26:03 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2053 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iZHBV-0005kk-G8; Mon, 25 Nov 2019 11:25:57 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id BDBA7C8177E2AC27D021;
 Mon, 25 Nov 2019 16:25:54 +0000 (GMT)
Received: from lhreml705-chm.china.huawei.com (10.201.108.54) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 25 Nov 2019 16:25:54 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml705-chm.china.huawei.com (10.201.108.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 25 Nov 2019 16:25:54 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Mon, 25 Nov 2019 16:25:54 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Topic: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Index: AQHVeswdQv2zL2ZjnU2+5S1CywnCCKdgnucAgAYn2ECANV3CUIAANK6AgAADjLA=
Date: Mon, 25 Nov 2019 16:25:54 +0000
Message-ID: <444efcb441fe42e5aff58b3af3ab14b4@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
 <441c818f24084b4191315cf2a6267cef@huawei.com>
 <20191125164541.3f0a593f@redhat.com>
In-Reply-To: <20191125164541.3f0a593f@redhat.com>
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
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 25 November 2019 15:46
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Auger Eric <eric.auger@redhat.com>; qemu-devel@nongnu.org;
> qemu-arm@nongnu.org; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH 0/5] ARM virt: Add NVDIMM support
>=20
> On Mon, 25 Nov 2019 13:20:02 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > Hi Eric/Igor,
> >
> > > -----Original Message-----
> > > From: Shameerali Kolothum Thodi
> > > Sent: 22 October 2019 15:05
> > > To: 'Auger Eric' <eric.auger@redhat.com>; qemu-devel@nongnu.org;
> > > qemu-arm@nongnu.org; imammedo@redhat.com
> > > Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; xuwei (O)
> > > <xuwei5@huawei.com>; lersek@redhat.com; Linuxarm
> > > <linuxarm@huawei.com>
> > > Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
>=20
> not related to problem discussed in this patch but you probably
> need to update docs/specs/acpi_nvdimm.txt to account for your changes

Ok.

> > >
> >
> > [..]
> >
> > > > one question: I noticed that when a NVDIMM slot is hotplugged one g=
et
> > > > the following trace on guest:
> > > >
> > > > nfit ACPI0012:00: found a zero length table '0' parsing nfit
> > > > pmem0: detected capacity change from 0 to 1073741824
> > > >
> > > > Have you experienced the 0 length trace?
> > >
> > > I double checked and yes that trace is there. And I did a quick check=
 with
> > > x86 and it is not there.
> > >
> > > The reason looks like, ARM64 kernel receives an additional 8 bytes si=
ze
> when
> > > the kernel evaluates the "_FIT" object.
> > >
> > > For the same test scenario, Qemu reports a FIT buffer size of 0xb8 an=
d
> > >
> > > X86 Guest kernel,
> > > [    1.601077] acpi_nfit_init: data 0xffff8a273dc12b18 sz 0xb8
> > >
> > > ARM64 Guest,
> > > [    0.933133] acpi_nfit_init: data 0xffff00003cbe6018 sz 0xc0
> > >
> > > I am not sure how that size gets changed for ARM which results in
> > > the above mentioned 0 length trace. I need to debug this further.
> > >
> > > Please let me know if you have any pointers...
> >
> > I spend some time debugging this further and it looks like the AML code
> > behaves differently on x86 and ARM64.
> FIT table is built dynamically and you are the first to debug
> such issue.
> (apart from the author the NVDIMM code.
:)
>  btw: why NVDIMM author is not on CC list???)

Right. Missed that. CCd.
=20
>=20
> > Booted guest with nvdimm mem, and used SSDT override with dbg prints
> > added,
> >
> > -object memory-backend-ram,id=3Dmem1,size=3D1G \
> > -device nvdimm,id=3Ddimm1,memdev=3Dmem1 \
> >
> > On X86,
> > -----------
> >
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0 FIT size 0xb8
> Dirty Yes.
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0xc0
> func_ret_status 0
> >
> > [AML]"NVDIMM-NCAL: Rcvd RLEN 000000C0"
> > [AML]"NVDIMM-NCAL: Creating OBUF with 000005E0 bits"
> > [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 000000BC"
> > [AML]"NVDIMM-RFIT Rcvd buf size 000000BC"
> > [AML]"NVDIMM-RFIT Created NVDR.RFIT.BUFF size 000000B8"
> > [AML]"NVDIMM-FIT: Rcvd buf size 000000B8"
> >
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0xb8 FIT size
> 0xb8 Dirty No.
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0x8
> func_ret_status 0
> >
> > [AML]"NVDIMM-NCAL: Rcvd RLEN 00000008"
> > [AML]"NVDIMM-NCAL: Creating OBUF with 00000020 bits"
> > [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 00000004"
> > [AML]"NVDIMM-RFIT Rcvd buf size 00000004"
> > [AML]"NVDIMM-FIT: Rcvd buf size 00000000"
> > [AML]"NVDIMM-FIT: _FIT returned size 000000B8"
> >
> > [ KERNEL] acpi_nfit_init: NVDIMM: data 0xffff9855bb9a7518 sz 0xb8  -->
> Guest receives correct size(0xb8) here
> >
> > On ARM64,
> > ---------------
> >
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0 FIT size 0xb8
> Dirty Yes.
> > [Qemu]VDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0xc0
> func_ret_status 0
> >
> > [AML]"NVDIMM-NCAL: Rcvd RLEN 00000000000000C0"
> > [AML]"NVDIMM-NCAL: Creating OBUF with 00000000000005E0 bits"
> > [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 00000000000000BC"
> > [AML]"NVDIMM-RFIT Rcvd buf size 00000000000000BC"
> > [AML]"NVDIMM-RFIT Created NVDR.RFIT.BUFF size 00000000000000B8"
> > [AML]"NVDIMM-FIT: Rcvd buf size 00000000000000B8"
> >
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0xb8 FIT size
> 0xb8 Dirty No.
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0x8
> func_ret_status 0
> >
> > [AML]"NVDIMM-NCAL: Rcvd RLEN 0000000000000008"
> > [AML]"NVDIMM-NCAL: Creating OBUF with 0000000000000020 bits"  --> All
> looks same as x86 up to here.
> > [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 0000000000000008"  --->
> The size goes wrong. 8 bytes instead of 4!.
>=20
> > [AML]"NVDIMM-RFIT Rcvd buf size 0000000000000008"
> > [AML]"NVDIMM-RFIT Created NVDR.RFIT.BUFF size 0000000000000004"
> > [AML]"NVDIMM-FIT: Rcvd buf size 0000000000000008"  --> Again size goes
> wrong. 8 bytes instead of 4!.
>=20
>                 Local1 =3D SizeOf (Local0)
>                 printf("NVDIMM-RFIT Rcvd buf size %o", Local1)
>=20
>                 Local1 -=3D 0x04
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ here you get -4 so sizes you
> see are consistent

Hmm...IIUC, Method(RFIT, ) creates a buffer of size 0x4 as per=20
this,

"NVDIMM-RFIT Created NVDR.RFIT.BUFF size 0000000000000004"

And this is the buffer received by Method(_FIT, ),=20

                    Local0 =3D RFIT (Local3)
                    Local1 =3D SizeOf (Local0)
                    printf("NVDIMM-FIT: Rcvd buf size %o", Local1)

But "NVDIMM-FIT: Rcvd buf size 0000000000000008".

As you can see above, in the first iteration the buffer size received by _F=
IT is
actually what RFIT created(0xB8).

>=20
>                 If ((Local1 =3D=3D Zero))
>                 {
>                     Return (Buffer (Zero){})
>                 }
>=20
>                 CreateField (Local0, 0x20, (Local1 << 0x03), BUFF)
>                 printf("NVDIMM-RFIT Created NVDR.RFIT.BUFF size %o",
> Local1)
>=20
>=20
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0xc0 FIT size
> 0xb8 Dirty No.  -->Another read is attempted
> > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0x8
> func_ret_status 3  --> Error status returned
>=20
> status 3 means that QEMU didn't like content of NRAM, and there is only
> 1 place like this in nvdimm_dsm_func_read_fit()
>     if (read_fit->offset > fit->len) {
>         func_ret_status =3D NVDIMM_DSM_RET_STATUS_INVALID;
>         goto exit;
>     }
>=20
> so I'd start looking from here and check that QEMU gets expected data
> in nvdimm_dsm_write(). In other words I'd try to trace/compare
> content of DSM buffer (from qemu side).

I had printed the DSM buffer previously and it looked same, I will double c=
heck
that.
=20
>=20
> > [AML]"NVDIMM-NCAL: Rcvd RLEN 0000000000000008"
> > [AML]"NVDIMM-NCAL: Creating OBUF with 0000000000000020 bits"
> > [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 0000000000000008"
> > [AML]"NVDIMM-FIT: Rcvd buf size 0000000000000000"
> RFIT returns 0-sized buffer in case of error

Yes.
                If ((Zero !=3D STAU))
                {
                    Return (Buffer (Zero){})
                }
=20
> > [AML]"NVDIMM-FIT: _FIT returned size 00000000000000C0"   --> Wrong
> size returned.
> after that it goes
>=20
>                     Local0 =3D Buffer (Zero){}
>                     Local0 =3D RFIT (Local3)
>                     Local1 =3D SizeOf (Local0)
>                     printf("NVDIMM-FIT: Rcvd buf size %o", Local1)
>                     If ((RSTA =3D=3D 0x0100))
>                     {
>                         Local2 =3D Buffer (Zero){}
>                         Local3 =3D Zero
>                     }
>                     Else
>                     {
>                         If ((Local1 =3D=3D Zero))
>   --> here, probably on the second iteration of the loop taking Zero
>       size as EOF sign but without checking for any error (RSTA !=3D0)
>       and returning partial buffer only

I guess you meant the third iteration. Yes, it doesn't check for RSTA !=3D =
0
case. And in the second iteration, since status =3D=3D 0 and buffer len rec=
eived is
8 bytes,=20
                        Concatenate (Local2, Local0, Local2)

The final buffer returned to Guest becomes 0xC0 (0xb8 + 0x8).
=20
>                         {
>                            printf("NVDIMM-FIT: _FIT returned size %o",
> SizeOf(Local2))
>                            Return (Local2)
>                         }
>=20
> relevant code in QEMU that builds this AML is in nvdimm_build_fit()
>=20
> > [ KERNEL] acpi_nfit_init: NVDIMM: data 0xffff0000fc57ce18 sz 0xc0
> -->Kernel gets 0xc0 instead of 0xb8
> >
> >
> > It looks like the aml, "CreateField (ODAT, Zero, Local1, OBUF)" goes wr=
ong for
> > ARM64 when the buffer is all zeroes. My knowledge on aml is very limite=
d and
> not
> > sure this is a 32/64bit issue or not. I am attaching the SSDT files wit=
h the
> above
> > dbg prints added. Could you please take a look and let me know what act=
ually
> is
> > going on here...
>=20
> diff -u SSDT-dbg-x86.dsl SSDT-dbg-arm64.dsl
> --- SSDT-dbg-x86.dsl	2019-11-25 14:50:22.024983026 +0100
> +++ SSDT-dbg-arm64.dsl	2019-11-25 14:50:06.740690645 +0100
> @@[...]
> @@ -28,7 +28,7 @@
>              Method (NCAL, 5, Serialized)
>              {
>                  Local6 =3D MEMA /* \MEMA */
> -                OperationRegion (NPIO, SystemIO, 0x0A18, 0x04)
> +                OperationRegion (NPIO, SystemMemory, 0x09090000,
> 0x04)
> that's fine and matches your code
>=20
>                  OperationRegion (NRAM, SystemMemory, Local6, 0x1000)
>                  Field (NPIO, DWordAcc, NoLock, Preserve)
>                  {
> @@ -210,6 +210,6 @@
>          }
>      }
>=20
> -    Name (MEMA, 0xBFBFD000)
> +    Name (MEMA, 0xFFFF0000)
>=20
> However value here is suspicious. If I recall right it should
> point to DMS buffer allocated by firmware somewhere in the guest RAM.

But then it will be horribly wrong and will result in inconsistent behavior
as well, right?

Thanks,
Shameer
=20
>=20
>  }
>=20
> > Much appreciated,
> > Shameer.
> >
> >


