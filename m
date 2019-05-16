Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0D0C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F36920848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F36920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR9tA-0006uf-Gw
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 02:29:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hR9sR-0006bT-50
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hR9sQ-0003Cz-0t
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hR9sP-0003Be-P0
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21F1B3DDBE;
	Thu, 16 May 2019 06:28:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F29145D9C3;
	Thu, 16 May 2019 06:28:22 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 973501806B11;
	Thu, 16 May 2019 06:28:21 +0000 (UTC)
Date: Thu, 16 May 2019 02:28:20 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <1906905099.29162562.1557988100975.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gEr_zPJEQp3k89v2UXfHp9PQwnJXY+W99HwXfxpvua_w@mail.gmail.com>
References: <20190514145422.16923-1-pagupta@redhat.com>
	<20190514145422.16923-2-pagupta@redhat.com>
	<CAPcyv4gEr_zPJEQp3k89v2UXfHp9PQwnJXY+W99HwXfxpvua_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.65.16.97, 10.4.195.4]
Thread-Topic: libnvdimm: nd_region flush callback support
Thread-Index: VrjlK3y+QUdLL94hHE7OyUkrop5Ojw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 16 May 2019 06:28:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 1/7] libnvdimm: nd_region flush callback
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	virtualization@lists.linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>, jstaron@google.com,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, Adam Borowski <kilobyte@angband.pl>,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> >
> > This patch adds functionality to perform flush from guest
> > to host over VIRTIO. We are registering a callback based
> > on 'nd_region' type. virtio_pmem driver requires this special
> > flush function. For rest of the region types we are registering
> > existing flush function. Report error returned by host fsync
> > failure to userspace.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/acpi/nfit/core.c     |  4 ++--
> >  drivers/nvdimm/claim.c       |  6 ++++--
> >  drivers/nvdimm/nd.h          |  1 +
> >  drivers/nvdimm/pmem.c        | 13 ++++++++-----
> >  drivers/nvdimm/region_devs.c | 26 ++++++++++++++++++++++++--
> >  include/linux/libnvdimm.h    |  8 +++++++-
> >  6 files changed, 46 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 5a389a4f4f65..08dde76cf459 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -2434,7 +2434,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_b=
lk,
> > unsigned int bw,
> >                 offset =3D to_interleave_offset(offset, mmio);
> >
> >         writeq(cmd, mmio->addr.base + offset);
> > -       nvdimm_flush(nfit_blk->nd_region);
> > +       nvdimm_flush(nfit_blk->nd_region, NULL);
> >
> >         if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
> >                 readq(mmio->addr.base + offset);
> > @@ -2483,7 +2483,7 @@ static int acpi_nfit_blk_single_io(struct nfit_bl=
k
> > *nfit_blk,
> >         }
> >
> >         if (rw)
> > -               nvdimm_flush(nfit_blk->nd_region);
> > +               nvdimm_flush(nfit_blk->nd_region, NULL);
> >
> >         rc =3D read_blk_stat(nfit_blk, lane) ? -EIO : 0;
> >         return rc;
> > diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> > index fb667bf469c7..13510bae1e6f 100644
> > --- a/drivers/nvdimm/claim.c
> > +++ b/drivers/nvdimm/claim.c
> > @@ -263,7 +263,7 @@ static int nsio_rw_bytes(struct nd_namespace_common
> > *ndns,
> >         struct nd_namespace_io *nsio =3D to_nd_namespace_io(&ndns->dev)=
;
> >         unsigned int sz_align =3D ALIGN(size + (offset & (512 - 1)), 51=
2);
> >         sector_t sector =3D offset >> 9;
> > -       int rc =3D 0;
> > +       int rc =3D 0, ret =3D 0;
> >
> >         if (unlikely(!size))
> >                 return 0;
> > @@ -301,7 +301,9 @@ static int nsio_rw_bytes(struct nd_namespace_common
> > *ndns,
> >         }
> >
> >         memcpy_flushcache(nsio->addr + offset, buf, size);
> > -       nvdimm_flush(to_nd_region(ndns->dev.parent));
> > +       ret =3D nvdimm_flush(to_nd_region(ndns->dev.parent), NULL);
> > +       if (ret)
> > +               rc =3D ret;
> >
> >         return rc;
> >  }
> > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > index a5ac3b240293..0c74d2428bd7 100644
> > --- a/drivers/nvdimm/nd.h
> > +++ b/drivers/nvdimm/nd.h
> > @@ -159,6 +159,7 @@ struct nd_region {
> >         struct badblocks bb;
> >         struct nd_interleave_set *nd_set;
> >         struct nd_percpu_lane __percpu *lane;
> > +       int (*flush)(struct nd_region *nd_region, struct bio *bio);
>=20
> So this triggers:
>=20
> In file included from drivers/nvdimm/e820.c:7:
> ./include/linux/libnvdimm.h:140:51: warning: =E2=80=98struct bio=E2=80=99=
 declared
> inside parameter list will not be visible outside of this definition
> or declaration
>   int (*flush)(struct nd_region *nd_region, struct bio *bio);
>                                                    ^~~

Sorry! for this. Fixed now.

> I was already feeling uneasy about trying to squeeze this into v5.2,
> but this warning and the continued drip of comments leads me to
> conclude that this driver would do well to wait one more development
> cycle. Lets close out the final fixups and let this driver soak in
> -next. Then for the v5.3 cycle I'll redouble my efforts towards the
> goal of closing patch acceptance at the -rc6 / -rc7 development
> milestone.

o.k. Will wait for Mike's ACK on device mapper patch and send the v10
with final fix-ups. Thank you for your help.

Best regards,
Pankaj



>=20

