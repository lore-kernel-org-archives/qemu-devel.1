Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D53C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD88020652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD88020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL5uv-0005JK-54
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:01:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hL5tv-0004bx-DS
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hL5tj-00028j-HB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:00:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hL5tj-000265-8N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:00:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so2468565edc.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=+9tJhA2irlXwQOzpG5XxMYL3RU0jaBhrylLEAAbP6SY=;
	b=FTwsMmX4msjDPmTYB3qTYnHt9oJFzNFwghBITjsoQsS5SbuE+PCxUJlBA+l7r6KMOY
	KkvV38lqYyRO66kZBxWB4Adstqv3M97ogoUC02Gg9X6C1dhg2FCD0NJ0IWkEaCiYDL4/
	MfjCKeX86bt+s++GJPXsxgn6Z5vTG5mc7d/QU1pE9h0GEWKB1u79rCGnW4Ptsw50vTz8
	sAg+BvTYre4EMY1HxIv5am5DjXNQz/JWbKBdgKifKycD/OzmUw6mMdQ9QGd+5Kl2fhvO
	lFJoZlXIT3xFLFOfv0gpSb8FojGFVA3hauKg0xeiNH7lmvl6G7DRmzCh0gAyPY88GZHC
	WFvw==
X-Gm-Message-State: APjAAAWPWzEC0CgGwnuu/TDYYHFwJWe2MZ5MpmKiAS9bSIbeZhV3Z87I
	qqURTQ72nXKfQEqg6b43GmV2bLhuFNGlLCszoI7x9A==
X-Google-Smtp-Source: APXvYqwuzwNFW3lbf9ocXH+uxkriHKVumAbWxMNUvMfSCcmqLhddLAGsrXqdgu6kz4oEQF+cU9cRbUwjGGe0prwOpl0=
X-Received: by 2002:a50:acc6:: with SMTP id x64mr38541086edc.141.1556542837538;
	Mon, 29 Apr 2019 06:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<CA+aFP1BtbjrzitLz7PW_b-kuYU7WSOiMs5jVfUBC=M3zEuBcew@mail.gmail.com>
	<20190429124712.mmxnpdkkbzhlbmxm@steredhat>
In-Reply-To: <20190429124712.mmxnpdkkbzhlbmxm@steredhat>
From: Jason Dillaman <jdillama@redhat.com>
Date: Mon, 29 Apr 2019 09:00:26 -0400
Message-ID:
 <CA+aFP1Cmc+3TcYJr73jYRmtCWNTAWBcjEtn+Afe7DKZqUYp7=g@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.208.68
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/rbd: add preallocation
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429130026.pwChVcD2BTSV0gBQrV0glCO330YWRpVVlsgoXrNkOUw@z>

On Mon, Apr 29, 2019 at 8:47 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Sat, Apr 27, 2019 at 08:43:26AM -0400, Jason Dillaman wrote:
> > On Sat, Apr 27, 2019 at 7:37 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >
> > > This patch adds the support of preallocation (off/full) for the RBD
> > > block driver.
> > > If available, we use rbd_writesame() to quickly fill the image when
> > > full preallocation is required.
> > >
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
> > >  qapi/block-core.json |   4 +-
> > >  2 files changed, 136 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/block/rbd.c b/block/rbd.c
> > > index 0c549c9935..29dd1bb040 100644
> > > --- a/block/rbd.c
> > > +++ b/block/rbd.c
> > > @@ -13,6 +13,7 @@
> > >
> > >  #include "qemu/osdep.h"
> > >
> > > +#include "qemu/units.h"
> > >  #include <rbd/librbd.h>
> > >  #include "qapi/error.h"
> > >  #include "qemu/error-report.h"
> > > @@ -331,6 +332,110 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
> > >      }
> > >  }
> > >
> > > +static int qemu_rbd_do_truncate(rbd_image_t image, int64_t offset,
> > > +                                PreallocMode prealloc, Error **errp)
> > > +{
> > > +    uint64_t current_length;
> > > +    char *buf = NULL;
> > > +    int ret;
> > > +
> > > +    ret = rbd_get_size(image, &current_length);
> > > +    if (ret < 0) {
> > > +        error_setg_errno(errp, -ret, "Failed to get file length");
> > > +        goto out;
> > > +    }
> > > +
> > > +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> > > +        error_setg(errp, "Cannot use preallocation for shrinking files");
> > > +        ret = -ENOTSUP;
> > > +        goto out;
> > > +    }
> > > +
> > > +    switch (prealloc) {
> > > +    case PREALLOC_MODE_FULL: {
> > > +        uint64_t current_offset = current_length;
> > > +        int buf_size = 64 * KiB;
> >
> > This should probably be 512B or 4KiB (which is the smallest striped
> > unit size). Not only will this avoid sending unnecessary zeroes to the
> > backing cluster, writesame silently turns into a standard write if
> > your buffer isn't properly aligned with the min(object size, stripe
> > unit size).
> >
>
> Okay, I'll change it on v2.
> Should we query about the "stripe_unit" size or we simply use the
> smallest allowed?

Technically we don't prevent a user from choosing terrible stripe unit
sizes (e.g. 1 byte), so you are probably safe to just use 4KiB.

> > > +        ssize_t bytes;
> > > +
> > > +        buf = g_malloc(buf_size);
> > > +        /*
> > > +         * Some versions of rbd_writesame() discards writes of buffers with
> > > +         * all zeroes. In order to avoid this behaviour, we set the first byte
> > > +         * to one.
> > > +         */
> > > +        buf[0] = 1;
> >
> > You could also use "rados_conf_set(cluster,
> > "rbd_discard_on_zeroed_write_same", "false").
> >
>
> I tried it, but it is not supported on all versions. (eg. I have Ceph
> v12.2.11 on my Fedora 29 and it is not supported, but rbd_writesame() is
> available)
>
> Maybe we can use both: "rbd_discard_on_zeroed_write_same = false" and
> "buf[0] = 1"

Probably not worth the effort if it's not supported across all releases.

> > > +        ret = rbd_resize(image, offset);
> > > +        if (ret < 0) {
> > > +            error_setg_errno(errp, -ret, "Failed to resize file");
> > > +            goto out;
> > > +        }
> > > +
> > > +#ifdef LIBRBD_SUPPORTS_WRITESAME
> > > +        while (offset - current_offset > buf_size) {
> > > +            /*
> > > +             * rbd_writesame() supports only request where the size of the
> > > +             * operation is multiple of buffer size and it must be less or
> > > +             * equal to INT_MAX.
> > > +             */
> > > +            bytes = MIN(offset - current_offset, INT_MAX);
> > > +            bytes -= bytes % buf_size;
> >
> > Using the default object size of 4MiB, this write size would result in
> > up to 512 concurrent ops to the backing cluster. Perhaps the size
> > should be bounded such that only a dozen or so concurrent requests are
> > issued per write, always rounded next largest object / stripe period
> > size. librbd and the rbd CLI usually try to bound themselves to the
> > value in the "rbd_concurrent_management_ops" configuration setting
> > (currently defaults to 10).
> >
>
> Do you suggest to use "rbd_concurrent_management_ops" to limit
> concurrent requests or use a new QEMU parameters for the RBD driver?

I think it would be nicer to just query the
"rbd_concurrent_management_ops" limit to derive your writesame size
since the Ceph cluster admin can globally set that option to match the
available parallelism of the cluster.

> Thanks for your comments,
> Stefano


-- 
Jason

