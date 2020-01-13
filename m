Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773B3C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A1E207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiFrtcQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A1E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir1dE-0002fo-UB
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 10:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ir1by-00012K-Ae
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ir1bw-0003l6-CG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:26:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ir1bw-0003jf-7R
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578929194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWizalQdJGQ8N1MyFx3a6nKtDNdyNDhlC51+PgmN+fM=;
 b=NiFrtcQ++eT4t2PIvVa4FkqIDgbiWvjqD3cPT9G3H1H+OVY+9qVN5i/BTQNABpyi2gaHdf
 UcnTzQ5QMAq+QsWC21PnAnteBFpTtIkicea/6iOYa7Fjp5TT+Xt3/5ZRaMYzUwvTMLupO3
 wkYYTVP4v6WxNPSX6CI07k02BYlgOd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-m8NB10pGNcmJ_Tic4TFrxA-1; Mon, 13 Jan 2020 10:26:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52F04107ACC4;
 Mon, 13 Jan 2020 15:26:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAD6A19C5B;
 Mon, 13 Jan 2020 15:26:25 +0000 (UTC)
Date: Mon, 13 Jan 2020 16:26:23 +0100
From: Andrew Jones <drjones@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified
 by _HID
Message-ID: <20200113152623.dlkxsrs7nr6uriyn@kamzik.brq.redhat.com>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200113130802.5a961482@redhat.com>
 <b5d91ae3-bf37-d27e-264d-ea21ef23776b@huawei.com>
MIME-Version: 1.0
In-Reply-To: <b5d91ae3-bf37-d27e-264d-ea21ef23776b@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: m8NB10pGNcmJ_Tic4TFrxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 13, 2020 at 09:57:55PM +0800, Guoheyi wrote:
>=20
> =E5=9C=A8 2020/1/13 20:08, Igor Mammedov =E5=86=99=E9=81=93:
> > On Thu, 19 Dec 2019 14:47:59 +0800
> > Heyi Guo <guoheyi@huawei.com> wrote:
> >=20
> > > According to ACPI spec, _ADR should be used for device which is on a
> > > bus that has a standard enumeration algorithm. It does not make sense
> > > to have a _ADR object for devices which already have _HID and will be
> > > enumerated by OSPM.
> > >=20
> > > Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> > Are you sure it's does not make sense?
> > Have you checked commit f264d51d8, that added _ADR?
>=20
> I searched in SPCR spec and ACPI spec, but didn't find such requirement f=
or
> serial port device description.
>=20
> Hi Andrew,
>=20
> Could you help to explain the reason?

tl;dr: It was a mistake and I agree with removing _ADR from SPCR.

The long version is that ACPI support for ARM took a long time to get
merged upstream. In the meantime Linaro and Red Hat had ACPI support
in their downstream trees. The initial, never upstreamed implementation
of Linux SPCR support used _ADR to find the console UART (probably
because some vendor hacked their ACPI tables that way). I made the
mistake of using the out-of-tree Linux kernel code as my "specification".

Upstream kernels never had this problem and I don't think we need to
worry about any of those downstream kernels which did. They'd be five
years old by now anyway.

Thanks,
drew

>=20
> Thanks,
>=20
> Heyi
>=20
>=20
>=20
> >=20
> > > ---
> > > Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > Cc: qemu-arm@nongnu.org
> > > Cc: qemu-devel@nongnu.org
> > > ---
> > >   hw/arm/virt-acpi-build.c          |   8 --------
> > >   tests/data/acpi/virt/DSDT         | Bin 18449 -> 18426 bytes
> > >   tests/data/acpi/virt/DSDT.memhp   | Bin 19786 -> 19763 bytes
> > >   tests/data/acpi/virt/DSDT.numamem | Bin 18449 -> 18426 bytes
> > >   4 files changed, 8 deletions(-)
> > >=20
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 9f4c7d1889..be752c0ad8 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -78,11 +78,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const M=
emMapEntry *uart_memmap,
> > >                                AML_EXCLUSIVE, &uart_irq, 1));
> > >       aml_append(dev, aml_name_decl("_CRS", crs));
> > > -    /* The _ADR entry is used to link this device to the UART descri=
bed
> > > -     * in the SPCR table, i.e. SPCR.base_address.address =3D=3D _ADR=
.
> > > -     */
> > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(uart_memmap->base)=
));
> > > -
> > >       aml_append(scope, dev);
> > >   }
> > > @@ -170,7 +165,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const M=
emMapEntry *memmap,
> > >       aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> > >       aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> > >       aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
> > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > >       aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
> > >       aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Devic=
e")));
> > >       aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > > @@ -334,7 +328,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const =
MemMapEntry *gpio_memmap,
> > >   {
> > >       Aml *dev =3D aml_device("GPO0");
> > >       aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
> > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > >       aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > >       Aml *crs =3D aml_resource_template();
> > > @@ -364,7 +357,6 @@ static void acpi_dsdt_add_power_button(Aml *scope=
)
> > >   {
> > >       Aml *dev =3D aml_device(ACPI_POWER_BUTTON_DEVICE);
> > >       aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> > > -    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > >       aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > >       aml_append(scope, dev);
> > >   }
> > > diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
> > > index b5895cb22446860a0b9be3d32ec856feb388be4c..a759ff739a071d5fbf505=
19a6aea296e5e0f1e0c 100644
> > > GIT binary patch
> > > delta 72
> > > zcmbO@f$>*ABbQ6COUN&G1_q{66S<_BT5Bh&t1wzk^tIeLL4lL8ZSqD=3DgU!!5x$Pt+
> > > c1HyxxIO07#U3dfh0t}oDoEbRcLp@y>07w882mk;8
> > >=20
> > > delta 94
> > > zcmey>&p2@cBbQ6CONgKc0|V26iCof5J#`b+RhV2^Ci+-%al|{i1o1F1FmP^cRp4ao
> > > tnY@hCfEg&X`7$S;oxFTNc#soEyoaX?Z-8HbfwO@#16Tu)4E1zj005fm7mWY_
> > >=20
> > > diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/D=
SDT.memhp
> > > index 69ad844f65d047973a3e55198beecd45a35b8fce..6e5cc61977e4cd24f765f=
ec0693f75a528c144c1 100644
> > > GIT binary patch
> > > delta 72
> > > zcmX>#i*fTTMlP3Nmk?uL1_q|eiCof5eHSLGt1wzk^tIeLL4lL8ZSqD=3DgU!!5U7RH)
> > > c1HyxxIO07#U3dfh0t}oDoEbRcLp@y>03)CjmjD0&
> > >=20
> > > delta 94
> > > zcmdlyi}BPfMlP3Nmk=3D*s1_q}3iCof5t(PXMt1!8;O!Tqj;)r*23F2X3VBp-?s=3D&$=
E
> > > tGkF=3DO0W(l&^JPwVXL<R6@E|9Scn?n(-T=3DP<17`zg2CxPo8S3f6006qZ7#siq
> > >=20
> > > diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt=
/DSDT.numamem
> > > index b5895cb22446860a0b9be3d32ec856feb388be4c..a759ff739a071d5fbf505=
19a6aea296e5e0f1e0c 100644
> > > GIT binary patch
> > > delta 72
> > > zcmbO@f$>*ABbQ6COUN&G1_q{66S<_BT5Bh&t1wzk^tIeLL4lL8ZSqD=3DgU!!5x$Pt+
> > > c1HyxxIO07#U3dfh0t}oDoEbRcLp@y>07w882mk;8
> > >=20
> > > delta 94
> > > zcmey>&p2@cBbQ6CONgKc0|V26iCof5J#`b+RhV2^Ci+-%al|{i1o1F1FmP^cRp4ao
> > > tnY@hCfEg&X`7$S;oxFTNc#soEyoaX?Z-8HbfwO@#16Tu)4E1zj005fm7mWY_
> > >=20
> >=20
> > .
>=20
>=20


