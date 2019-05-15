Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBBFC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA4420815
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JldDYW+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA4420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42730 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR1Fl-0000wY-4I
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 17:15:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hR17r-0003My-5f
	for qemu-devel@nongnu.org; Wed, 15 May 2019 17:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hR17o-000370-M3
	for qemu-devel@nongnu.org; Wed, 15 May 2019 17:07:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hR17m-0002v1-Gl
	for qemu-devel@nongnu.org; Wed, 15 May 2019 17:07:43 -0400
Received: by mail-ot1-x342.google.com with SMTP id g18so1368622otj.11
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=zEAiaEFTDEo5AHTXNi1igG//m3yl73MYATUt/TyQM/s=;
	b=JldDYW+LTAR5BoMmvzt3GhFBKSNFCQljO95A7CQF8h7lezT59wkCmoZR8HlZNeo3ZX
	ACz18is11PqZLJkpbZTbPrVApVsXuwCwQzpumDKhMYUGYyeEKSs4shc89Funjj7rmnrR
	zPCblVOMVW4B/FdfDdDBm0eQtlDpcEoDreFJYHB2TrhXh9porw+VCF0gkgtOPIdPF4AY
	hPK/m0cAXNVhKubNUJt+B+Ge41ks183CJ7yggGXayFgFqQhy+nfr59BSRoNiAIUor77P
	UmqXqpMAHdjAUWsPGhNLbi9iUpZ9FsKZwds3Nd3zmasJxQ+15Rm38l4yGAgNrmpf7grH
	OFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=zEAiaEFTDEo5AHTXNi1igG//m3yl73MYATUt/TyQM/s=;
	b=AI8FtyO8PRBRgpPVThNGW3gkn1PPPizhVoWUZwRpOcZthbFrOLv6fWnj8EANSJk4fX
	RtVsB5zkdwyIgv6jRlxwV24MarF+ccONI5eTz+6Yx3gL3CuQkSqhQZRECAL4KU4Wgpov
	0N6GmDYFTBIAEHLo/8dWxXl/shLqibLoRWGatPHWYIl1V+OlBkMl5yaqXViv9ZaTm9ui
	jXX6oSXOwmz0dTwXKQDFBpmQe3j4FSH2LZ7Y82M3Fc5hNRQHjnfrRsaNDw/IbR4zonWs
	X/CBSU1Z4Egp7o62QAeWSWbWkupsDeJiO7pn7/jk+IuxHN/IHFBc5ZqzeZl7QejwBO0u
	KBFA==
X-Gm-Message-State: APjAAAW4XgXUTtTTNgOOWv9dAMjytzdClBB7Sy0hPlowtM7gmyy29gMw
	uHm312D1/UM9+SRMbAgaTxhhx/ioHidxjCdDbLpDBg==
X-Google-Smtp-Source: APXvYqyDA/EWUSXzmLh3QyRTwliJkHZQ726n1NRYV2Be3duzD6pV8jVLvRmpMo63mBrfvCQmmCONZIUwdUcOhHdo8aI=
X-Received: by 2002:a05:6830:14d3:: with SMTP id
	t19mr27993804otq.57.1557954454945; 
	Wed, 15 May 2019 14:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190514145422.16923-1-pagupta@redhat.com>
	<20190514145422.16923-2-pagupta@redhat.com>
In-Reply-To: <20190514145422.16923-2-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 May 2019 14:07:23 -0700
Message-ID: <CAPcyv4gEr_zPJEQp3k89v2UXfHp9PQwnJXY+W99HwXfxpvua_w@mail.gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Tue, May 14, 2019 at 7:55 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds functionality to perform flush from guest
> to host over VIRTIO. We are registering a callback based
> on 'nd_region' type. virtio_pmem driver requires this special
> flush function. For rest of the region types we are registering
> existing flush function. Report error returned by host fsync
> failure to userspace.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/acpi/nfit/core.c     |  4 ++--
>  drivers/nvdimm/claim.c       |  6 ++++--
>  drivers/nvdimm/nd.h          |  1 +
>  drivers/nvdimm/pmem.c        | 13 ++++++++-----
>  drivers/nvdimm/region_devs.c | 26 ++++++++++++++++++++++++--
>  include/linux/libnvdimm.h    |  8 +++++++-
>  6 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 5a389a4f4f65..08dde76cf459 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2434,7 +2434,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_blk=
, unsigned int bw,
>                 offset =3D to_interleave_offset(offset, mmio);
>
>         writeq(cmd, mmio->addr.base + offset);
> -       nvdimm_flush(nfit_blk->nd_region);
> +       nvdimm_flush(nfit_blk->nd_region, NULL);
>
>         if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
>                 readq(mmio->addr.base + offset);
> @@ -2483,7 +2483,7 @@ static int acpi_nfit_blk_single_io(struct nfit_blk =
*nfit_blk,
>         }
>
>         if (rw)
> -               nvdimm_flush(nfit_blk->nd_region);
> +               nvdimm_flush(nfit_blk->nd_region, NULL);
>
>         rc =3D read_blk_stat(nfit_blk, lane) ? -EIO : 0;
>         return rc;
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index fb667bf469c7..13510bae1e6f 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -263,7 +263,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *=
ndns,
>         struct nd_namespace_io *nsio =3D to_nd_namespace_io(&ndns->dev);
>         unsigned int sz_align =3D ALIGN(size + (offset & (512 - 1)), 512)=
;
>         sector_t sector =3D offset >> 9;
> -       int rc =3D 0;
> +       int rc =3D 0, ret =3D 0;
>
>         if (unlikely(!size))
>                 return 0;
> @@ -301,7 +301,9 @@ static int nsio_rw_bytes(struct nd_namespace_common *=
ndns,
>         }
>
>         memcpy_flushcache(nsio->addr + offset, buf, size);
> -       nvdimm_flush(to_nd_region(ndns->dev.parent));
> +       ret =3D nvdimm_flush(to_nd_region(ndns->dev.parent), NULL);
> +       if (ret)
> +               rc =3D ret;
>
>         return rc;
>  }
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index a5ac3b240293..0c74d2428bd7 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -159,6 +159,7 @@ struct nd_region {
>         struct badblocks bb;
>         struct nd_interleave_set *nd_set;
>         struct nd_percpu_lane __percpu *lane;
> +       int (*flush)(struct nd_region *nd_region, struct bio *bio);

So this triggers:

In file included from drivers/nvdimm/e820.c:7:
./include/linux/libnvdimm.h:140:51: warning: =E2=80=98struct bio=E2=80=99 d=
eclared
inside parameter list will not be visible outside of this definition
or declaration
  int (*flush)(struct nd_region *nd_region, struct bio *bio);
                                                   ^~~
I was already feeling uneasy about trying to squeeze this into v5.2,
but this warning and the continued drip of comments leads me to
conclude that this driver would do well to wait one more development
cycle. Lets close out the final fixups and let this driver soak in
-next. Then for the v5.3 cycle I'll redouble my efforts towards the
goal of closing patch acceptance at the -rc6 / -rc7 development
milestone.

