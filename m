Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FEC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE4E206DB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE4E206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVr1-0000hr-J0
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ioVqI-0008K7-TQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ioVqH-000148-A1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:07:02 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2058 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ioVqA-0000oi-TT; Mon, 06 Jan 2020 12:06:55 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id DBAD9F27661A12FACF7E;
 Mon,  6 Jan 2020 17:06:45 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 6 Jan 2020 17:06:32 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jan 2020 17:06:32 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Mon, 6 Jan 2020 17:06:32 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Topic: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Index: AQHVeswdQv2zL2ZjnU2+5S1CywnCCKdgnucAgAYn2ECANV3CUIAANK6AgAADjLCAARyUgIADW0wAgBGftACAAodbgIADcKzggCX7GsA=
Date: Mon, 6 Jan 2020 17:06:32 +0000
Message-ID: <8562f82b7c0140d3ad0c7f6616cb6f28@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
 <441c818f24084b4191315cf2a6267cef@huawei.com>
 <20191125164541.3f0a593f@redhat.com>
 <444efcb441fe42e5aff58b3af3ab14b4@huawei.com>
 <20191126095655.27227f59@redhat.com>
 <c2bb0be09e244ee59d27c7aaab1783a9@huawei.com>
 <20191211085727.1ab9564e@redhat.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="iso-8859-1"
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
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 Auger Eric <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: 13 December 2019 12:52
> To: 'Igor Mammedov' <imammedo@redhat.com>
> Cc: xiaoguangrong.eric@gmail.com; peter.maydell@linaro.org;
> drjones@redhat.com; shannon.zhaosl@gmail.com; qemu-devel@nongnu.org;
> Linuxarm <linuxarm@huawei.com>; Auger Eric <eric.auger@redhat.com>;
> qemu-arm@nongnu.org; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com
> Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
>=20

[...]

>=20
> Thanks for your help. I did spend some more time debugging this further.
> I tried to introduce a totally new Buffer field object with different
> sizes and printing the size after creation.
>=20
> --- SSDT.dsl	2019-12-12 15:28:21.976986949 +0000
> +++ SSDT-arm64-dbg.dsl	2019-12-13 12:17:11.026806186 +0000
> @@ -18,7 +18,7 @@
>   *     Compiler ID      "BXPC"
>   *     Compiler Version 0x00000001 (1)
>   */
> -DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
> +DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000002)
>  {
>      Scope (\_SB)
>      {
> @@ -48,6 +48,11 @@
>                      RLEN,   32,
>                      ODAT,   32736
>                  }
> +
> +                Field (NRAM, DWordAcc, NoLock, Preserve)
> +                {
> +                    NBUF,   32768
> +                }
>=20
>                  If ((Arg4 =3D=3D Zero))
>                  {
> @@ -87,6 +92,12 @@
>                      Local3 =3D DerefOf (Local2)
>                      FARG =3D Local3
>                  }
> +
> +                Local2 =3D 0x2
> +                printf("AML:NVDIMM Creating TBUF with bytes %o",
> Local2)
> +                CreateField (NBUF, Zero, (Local2 << 3), TBUF)
> +                Concatenate (Buffer (Zero){}, TBUF, Local3)
> +                printf("AML:NVDIMM Size of TBUF(Local3) %o",
> SizeOf(Local3))
>=20
>                  NTFI =3D Local6
>                  Local1 =3D (RLEN - 0x04)
>=20
> And run it by changing Local2 with different values, It looks on ARM64,
>=20
> For cases where, Local2 <8, the created buffer size is always 8 bytes
>=20
> "AML:NVDIMM Creating TBUF with bytes 0000000000000002"
> "AML:NVDIMM Size of TBUF(Local3) 0000000000000008"
>=20
> ...
> "AML:NVDIMM Creating TBUF with bytes 0000000000000005"
> "AML:NVDIMM Size of TBUF(Local3) 0000000000000008"
>=20
> And once Local2 >=3D8, it gets the correct size,
>=20
> "AML:NVDIMM Creating TBUF with bytes 0000000000000009"
> "AML:NVDIMM Size of TBUF(Local3) 0000000000000009"
>=20
>=20
> But on x86, the behavior is like,
>=20
> For cases where, Local2 <4, the created buffer size is always 4 bytes
>=20
> "AML:NVDIMM Creating TBUF with bytes 00000002"
> "AML:NVDIMM Size of TBUF(Local3) 00000004"
> ....
> "AML:NVDIMM Creating TBUF with bytes 00000003"
> "AML:NVDIMM Size of TBUF(Local3) 00000004"
>=20
> And once Local2 >=3D 4, it is ok
>=20
> "AML:NVDIMM Creating TBUF with bytes 00000005"
> "AML:NVDIMM Size of TBUF(Local3) 00000005"
> ...
> "AML:NVDIMM Creating TBUF with bytes 00000009"
> "AML:NVDIMM Size of TBUF(Local3) 00000009"
>=20
> This is the reason why it works on x86 and not on ARM64. Because, if you
> remember on second iteration of the FIT buffer, the requested buffer size=
 is 4 .
>=20
> I tried changing the AccessType of the below NBUF field from DWordAcc to
> ByteAcc/BufferAcc, but no luck.
>=20
> +                Field (NRAM, DWordAcc, NoLock, Preserve)
> +                {
> +                    NBUF,   32768
> +                }
>=20
> Not sure what we need to change for ARM64 to create buffer object of size=
 4
> here. Please let me know if you have any pointers to debug this further.
>=20
> (I am attaching both x86 and ARM64 SSDT dsl used for reference)

(+Jonathan)

Thanks to Jonathan for taking a fresh look at this issue and spotting this,
https://elixir.bootlin.com/linux/v5.5-rc5/source/drivers/acpi/acpica/utmisc=
.c#L109

And, from ACPI 6.3, table 19-419

"If the Buffer Field is smaller than or equal to the size of an Integer (in=
 bits), it
will be treated as an Integer. Otherwise, it will be treated as a Buffer. T=
he size
of an Integer is indicated by the Definition Block table header's Revision =
field.
A Revision field value less than 2 indicates that the size of an Integer is=
 32 bits.
A value greater than or equal to 2 signifies that the size of an Integer is=
 64 bits."

It looks like the main reason for the difference in behavior of the buffer =
object
size between x86 and ARM/virt, is because of the Revision number used in th=
e
DSDT table. On x86 it is 1 and ARM/virt it is 2.

So most likely,

>     CreateField (ODAT, Zero, Local1, OBUF)
>     Concatenate (Buffer (Zero){}, OBUF, Local7)

defaults to the minimum integer byte length based on DSDT revision number.

I tried changing the DSDT rev number of x86 code to 2,
=20
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 614e48ff38..2941edab8d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2257,7 +2257,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
=A0 =A0 =A0g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len)=
;
=A0 =A0 =A0build_header(linker, table_data,
=A0 =A0 =A0 =A0 =A0(void *)(table_data->data + table_data->len - dsdt->buf-=
>len),
- =A0 =A0 =A0 =A0"DSDT", dsdt->buf->len, 1, NULL, NULL);
+ =A0 =A0 =A0 =A0"DSDT", dsdt->buf->len, 2, NULL, NULL);
=A0 =A0 =A0free_aml_allocator();
=A0}

And the same issue was reported by Guest Kernel,

[ =A0 =A01.636672] nfit ACPI0012:00: found a zero length table '0' parsing =
nfit


With a quick fix to the nvdimm aml code(below) everything seems to work
now. But again this may not be the right fix/approach for this.

Please take a look and let me know.

Thanks,
Shameer

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 64eacfad08..621f9ffd41 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1192,15 +1192,18 @@ static void nvdimm_build_fit(Aml *dev)
=A0 =A0 =A0aml_append(method, ifctx);
=A0
=A0 =A0 =A0aml_append(method, aml_store(aml_sizeof(buf), buf_size));
- =A0 =A0aml_append(method, aml_subtract(buf_size,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0am=
l_int(4) /* the size of "STAU" */,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bu=
f_size));
=A0
=A0 =A0 =A0/* if we read the end of fit. */
- =A0 =A0ifctx =3D aml_if(aml_equal(buf_size, aml_int(0)));
+ =A0 =A0ifctx =3D aml_if(aml_equal(aml_subtract(buf_size,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 aml_sizeof(aml_in=
t(0)), NULL),
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 aml_int(0)));
=A0 =A0 =A0aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
=A0 =A0 =A0aml_append(method, ifctx);
=A0
+ =A0 =A0aml_append(method, aml_subtract(buf_size,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0am=
l_int(4) /* the size of "STAU" */,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bu=
f_size));
+
=A0 =A0 =A0aml_append(method, aml_create_field(buf,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0aml_int(4 * BITS=
_PER_BYTE), /* offset at byte 4.*/
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0aml_shiftleft(bu=
f_size, aml_int(3)), "BUFF"));






