Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E662C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BFE20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BFE20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkao-0005wg-IL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jGkZk-0004cL-27
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jGkZi-0001wK-Ts
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:30:39 -0400
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:57774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jGkZi-0001uH-OA
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:30:38 -0400
Received: from player729.ha.ovh.net (unknown [10.108.35.13])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id ADBF824875B
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 15:30:36 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 85CE310E31950;
 Tue, 24 Mar 2020 14:30:18 +0000 (UTC)
Date: Tue, 24 Mar 2020 15:30:17 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH qemu] vfio/spapr: Fix page size calculation
Message-ID: <20200324153017.01c45ec0@bahia.lan>
In-Reply-To: <87ddd733-8498-57a5-2fe2-8f1a3e60e0c9@redhat.com>
References: <20200324063912.25063-1-aik@ozlabs.ru>
 <87ddd733-8498-57a5-2fe2-8f1a3e60e0c9@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 1840846351093307683
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.98.231
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 14:27:35 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

>=20
>=20
> On 3/24/20 7:39 AM, Alexey Kardashevskiy wrote:
> > Coverity detected an issue (CID 1421903) with potential call of clz64(0)
> > which returns 64 which make it do "<<" with a negative number.
> >=20
> > This checks the mask and avoids undefined behaviour.
> >=20
> > In practice pgsizes and memory_region_iommu_get_min_page_size() always
> > have some common page sizes and even if they did not, the resulting page
> > size would be 0x8000.0000.0000.0000 (gcc 9.2) and
> > ioctl(VFIO_IOMMU_SPAPR_TCE_CREATE) would fail anyway.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >   hw/vfio/spapr.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> > index 33692fc86fd6..2900bd19417a 100644
> > --- a/hw/vfio/spapr.c
> > +++ b/hw/vfio/spapr.c
> > @@ -147,7 +147,7 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
> >   {
> >       int ret =3D 0;
> >       IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
> > -    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_=
mr);
> > +    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_=
mr), pgmask;
> >       unsigned entries, bits_total, bits_per_level, max_levels;
> >       struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof=
(create) };
> >       long rampagesize =3D qemu_minrampagesize();
> > @@ -159,8 +159,8 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
> >       if (pagesize > rampagesize) {
> >           pagesize =3D rampagesize;
> >       }
> > -    pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
> > -                                   (pagesize | (pagesize - 1))));
> > +    pgmask =3D container->pgsizes & (pagesize | (pagesize - 1));
>=20
> Is that ROUND_UP(container->pgsizes, pagesize)?
>=20

This means we clip all page sizes greater than pagesize from
container->pgsizes... It doesn't look like ROUND_UP() semantics
to me.

> > +    pagesize =3D pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
> >       if (!pagesize) {
> >           error_report("Host doesn't support page size 0x%"PRIx64
> >                        ", the supported mask is 0x%lx",
> >=20
>=20
>=20


