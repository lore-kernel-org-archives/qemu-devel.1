Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C6EC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0178121872
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0178121872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU976-0006Qw-4M
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 07:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iU96N-0005iX-CE
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iU96L-0003lR-SL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:47:27 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2049 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iU96I-0003i7-6d; Mon, 11 Nov 2019 07:47:22 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 2536B2190D1575115E8B;
 Mon, 11 Nov 2019 12:47:16 +0000 (GMT)
Received: from lhreml707-chm.china.huawei.com (10.201.108.56) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Nov 2019 12:47:15 +0000
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-chm.china.huawei.com (10.201.108.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 11 Nov 2019 12:47:15 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1713.004; Mon, 11 Nov 2019 12:47:15 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [PATCH 1/5] hw/arm: Align ACPI blob len to PAGE size
Thread-Topic: [PATCH 1/5] hw/arm: Align ACPI blob len to PAGE size
Thread-Index: AQHVeswOt9Cm/mHIvkOjMvan5ZmmMqeBqoOAgAR2W8A=
Date: Mon, 11 Nov 2019 12:47:15 +0000
Message-ID: <3ae89f87a5d64f57bea7246772c41301@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <20191004155302.4632-2-shameerali.kolothum.thodi@huawei.com>
 <20191108171745.1465295b@redhat.com>
In-Reply-To: <20191108171745.1465295b@redhat.com>
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
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 08 November 2019 16:18
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; xuwei (O) <xuwei5@huawei.com>;
> lersek@redhat.com; Linuxarm <linuxarm@huawei.com>; Michael S. Tsirkin
> <mst@redhat.com>
> Subject: Re: [PATCH 1/5] hw/arm: Align ACPI blob len to PAGE size
>=20
> On Fri, 4 Oct 2019 16:52:58 +0100
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>=20
> > If ACPI blob length modifications happens after the initial
> > virt_acpi_build() call, and the changed blob length is within
> > the PAGE size boundary, then the revised size is not seen by
> > the firmware on Guest reboot. The is because in the
> > virt_acpi_build_update() -> acpi_ram_update() -> qemu_ram_resize()
> > path, qemu_ram_resize() uses ram_block size which is aligned
> > to PAGE size and the "resize callback" to update the size seen
> > by firmware is not getting invoked. Hence align ACPI blob sizes
> > to PAGE boundary.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> > More details on this issue can be found here,
> > https://patchwork.kernel.org/patch/11154757/
> re-read it again and it seems to me that this patch is workaround
> rather than a solution to the problem.

Thanks for taking a look at this. Yes, I was also not very sure about this =
approach
as the root cause of the issue is in qemu_ram_resize().

> CCing Michael as an author this code.
> on x86 we have crazy history of manually aligning acpi blobs, see code un=
der
> comment
>=20
>   /* We'll expose it all to Guest so we want to reduce
>=20
> so used_length endups with over-sized value which includes table and padd=
ing
> and it happens that ACPI_BUILD_TABLE_SIZE is much bigger than host page
> size
> so if on reboot we happen to exceed ACPI_BUILD_TABLE_SIZE, the next padde=
d
> table
> size (used_length) would be  2 x ACPI_BUILD_TABLE_SIZE which doesn't
> trigger
>   block->used_length =3D=3D HOST_PAGE_ALIGN(newsize)
> condition so fwcfg gets updated value.

Yes, this is the reason why the issue is not visible on x86.
=20
>=20
> > ---
> >  hw/arm/virt-acpi-build.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 4cd50175e0..074e0c858e 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -790,6 +790,7 @@ void virt_acpi_build(VirtMachineState *vms,
> AcpiBuildTables *tables)
> >      GArray *table_offsets;
> >      unsigned dsdt, xsdt;
> >      GArray *tables_blob =3D tables->table_data;
> > +    GArray *cmd_blob =3D tables->linker->cmd_blob;
> >      MachineState *ms =3D MACHINE(vms);
> >
> >      table_offsets =3D g_array_new(false, true /* clear */,
> > @@ -854,6 +855,19 @@ void virt_acpi_build(VirtMachineState *vms,
> AcpiBuildTables *tables)
> >          build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
> >      }
> >
> > +    /*
> > +     * Align the ACPI blob lengths to PAGE size so that on ACPI table
> > +     * regeneration, the length that firmware sees really gets updated
> > +     * through 'resize' callback in qemu_ram_resize() in the
> > +     * virt_acpi_build_update() -> acpi_ram_update() ->
> qemu_ram_resize()
> > +     * path.
> > +     */
> > +    g_array_set_size(tables_blob,
> > +
> TARGET_PAGE_ALIGN(acpi_data_len(tables_blob)));
> here it would depend on TARGET_PAGE_ALIGN vs HOST_PAGE_ALIGN relation
> so depending on host it could flip it's behavior to opposite.

Ok.

>=20
> one thing we could do is dropping (block->used_length =3D=3D newsize) con=
dition

I tried this before and strangely for some reason on reboot path,

virt_acpi_build_update() is called with build_state being NULL and no acpi_=
ram_update()
happens. Not sure what causes this behavior when we drop the above conditio=
n.

> another is to use value of block->used_length for s->files->f[index].size=
.

I just tried this by passing block->used_length to fw_cfg_add_file_callback=
() .
This could work for this case. But not sure there will be any corner cases
and also there isn't any easy way to access the mr->ram_balck->used_length =
from
hw/core/loader.c.

>=20
> Michael,
> what's your take in this?

Thanks,
Shameer

>=20
> > +    g_array_set_size(tables->rsdp,
> > +
> TARGET_PAGE_ALIGN(acpi_data_len(tables->rsdp)));
> > +    g_array_set_size(cmd_blob,
> > +                     TARGET_PAGE_ALIGN(acpi_data_len(cmd_blob)));
> >      /* Cleanup memory that's no longer used. */
> >      g_array_free(table_offsets, true);
> >  }


