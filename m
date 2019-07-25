Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392DC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0911422BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0911422BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqYsq-00076M-80
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqYse-0006dK-Tn
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqYsd-0005oj-7B
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:13:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqYsc-0005oF-UO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:13:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so49697516wrl.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 01:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0W8Dzoq3ItSc4alZZ6ywCwxZ5qMCtt8ZX2ujbrqZ7bY=;
 b=rhX30X/EeREz6R1CmLQHPDOOrm+Gpmf3nq9j3/wi/68R4IlPR9AXk9vF9UuboqnwvL
 +zW3s8Mg85uBXw6n4XgKpbddvzLmf4bkTpVDRTHZ6txTgVckynt3JplRJIT1yUUqEGIX
 sqLxNYV8UK8MWnfGBhbhw8HONr3Lcgky7CD/U8AuBBJyyhSDBeDXVMFklWJw3yeQyylq
 Y90HHwBcyDRTwu73Nc4nv8EnfvvI9NXj3QPWZ/cmT2tCj+Cr4ezKFeN7qYrfKzIyCI+t
 kn22y5VRKBlh/0TzSvvnXMl9H6f7Mj0GkzoSuKRZk9eOd8jCi5hKb0hJ5kRPABMuymY7
 9nPg==
X-Gm-Message-State: APjAAAVnIuq1TYckUFV67n4wRkD94KOSD3PE6WyyQ8cSSMvhgc80dRsE
 wrzVqjSilZW/QDER4Y9NAEMmgA==
X-Google-Smtp-Source: APXvYqw/Hr+vQyRWkKY/jj6MRWbLtp3VJ39xdF8BFcj911S9KIfcO9Ek2+PT5qzxV/FCwtbw1SfkCQ==
X-Received: by 2002:a05:6000:1148:: with SMTP id
 d8mr80518610wrx.354.1564042417859; 
 Thu, 25 Jul 2019 01:13:37 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id g8sm53015268wme.20.2019.07.25.01.13.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 01:13:37 -0700 (PDT)
Date: Thu, 25 Jul 2019 10:13:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: dillaman@redhat.com
Message-ID: <20190725081334.s2btvq3zdorj7lb5@steredhat>
References: <20190723071342.383909-1-sgarzare@redhat.com>
 <CA+aFP1BMUitx40WDT-fcWDjO62j3EsoSdg=3HF2b6c1EdwzUxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1BMUitx40WDT-fcWDjO62j3EsoSdg=3HF2b6c1EdwzUxg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: add preallocation support
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 01:48:42PM -0400, Jason Dillaman wrote:
> On Tue, Jul 23, 2019 at 3:13 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > This patch adds the support of preallocation (off/full) for the RBD
> > block driver.
> > If rbd_writesame() is available and supports zeroed buffers, we use
> > it to quickly fill the image when full preallocation is required.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v3:
> >  - rebased on master
> >  - filled with zeroed buffer [Max]
> >  - used rbd_writesame() only when we can disable the discard of zeroed
> >    buffers
> >  - added 'since: 4.2' in qapi/block-core.json [Max]
> >  - used buffer as large as the "stripe unit"
> > ---
> >  block/rbd.c          | 202 ++++++++++++++++++++++++++++++++++++++++---
> >  qapi/block-core.json |   5 +-
> >  2 files changed, 192 insertions(+), 15 deletions(-)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 59757b3120..d923a5a26c 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -64,6 +64,7 @@
> >  #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
> >
> >  #define RBD_MAX_SNAPS 100
> > +#define RBD_DEFAULT_CONCURRENT_OPS 10
> >
> >  /* The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h */
> >  #ifdef LIBRBD_SUPPORTS_IOVEC
> > @@ -104,6 +105,7 @@ typedef struct BDRVRBDState {
> >      char *image_name;
> >      char *snap;
> >      uint64_t image_size;
> > +    bool ws_zero_supported; /* rbd_writesame() supports zeroed buffers */
> >  } BDRVRBDState;
> >
> >  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> > @@ -333,6 +335,155 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
> >      }
> >  }
> >
> > +static int qemu_rbd_get_max_concurrent_ops(rados_t cluster)
> > +{
> > +    char buf[16];
> > +    int ret, max_concurrent_ops;
> > +
> > +    ret = rados_conf_get(cluster, "rbd_concurrent_management_ops", buf,
> > +                         sizeof(buf));
> > +    if (ret < 0) {
> > +        return RBD_DEFAULT_CONCURRENT_OPS;
> > +    }
> > +
> > +    ret = qemu_strtoi(buf, NULL, 10, &max_concurrent_ops);
> > +    if (ret < 0) {
> > +        return RBD_DEFAULT_CONCURRENT_OPS;
> > +    }
> > +
> > +    return max_concurrent_ops;
> > +}
> > +
> > +static int qemu_rbd_do_truncate(rados_t cluster, rbd_image_t image,
> > +                                int64_t offset, PreallocMode prealloc,
> > +                                bool ws_zero_supported, Error **errp)
> > +{
> > +    uint64_t current_length;
> > +    char *buf = NULL;
> > +    int ret;
> > +
> > +    ret = rbd_get_size(image, &current_length);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "Failed to get file length");
> > +        goto out;
> > +    }
> > +
> > +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> > +        error_setg(errp, "Cannot use preallocation for shrinking files");
> > +        ret = -ENOTSUP;
> > +        goto out;
> > +    }
> > +
> > +    switch (prealloc) {
> > +    case PREALLOC_MODE_FULL: {
> > +        uint64_t buf_size, current_offset = current_length;
> > +        ssize_t bytes;
> > +
> > +        ret = rbd_get_stripe_unit(image, &buf_size);
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, -ret, "Failed to get stripe unit");
> > +            goto out;
> > +        }
> > +
> > +        ret = rbd_resize(image, offset);
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, -ret, "Failed to resize file");
> > +            goto out;
> > +        }
> > +
> > +        buf = g_malloc0(buf_size);
> > +
> > +#ifdef LIBRBD_SUPPORTS_WRITESAME
> > +        if (ws_zero_supported) {
> > +            uint64_t writesame_max_size;
> > +            int max_concurrent_ops;
> > +
> > +            max_concurrent_ops = qemu_rbd_get_max_concurrent_ops(cluster);
> > +            /*
> > +             * We limit the rbd_writesame() size to avoid to spawn more then
> > +             * 'rbd_concurrent_management_ops' concurrent operations.
> > +             */
> > +            writesame_max_size = MIN(buf_size * max_concurrent_ops, INT_MAX);
> 
> In the most efficient world, the 'buf_size' would be some small, fixed
> power of 2 value (like 512 bytes) since there isn't much need to send
> extra zeroes. You would then want to writesame the full stripe period
> (if possible), where a stripe period is the data block object size
> (defaults to 4MiB and is availble via 'rbd_stat') * the stripe count.
> In this case, the stripe count becomes the number of in-flight IOs.
> Therefore, you could substitute its value w/ the max_concurrent_ops to
> ensure you are issuing exactly max_concurrent_ops IOs per
> rbd_writesame call.
> 

Initially, I had a fixed buffer size to 4 KiB, but I noted that, when
we didn't use writesame, the rbd_write() was very slow, so I used the
stripe unit as a buffer size.

Do you think is better to have a small buffer (512 byte) when we use
writesame or a 'stripe unit' buffer when we can't use it?


> > +
> > +            while (offset - current_offset > buf_size) {
> > +                bytes = MIN(offset - current_offset, writesame_max_size);
> > +                /*
> > +                 * rbd_writesame() supports only request where the size of the
> > +                 * operation is multiple of buffer size.
> > +                 */
> > +                bytes -= bytes % buf_size;
> > +
> > +                bytes = rbd_writesame(image, current_offset, bytes, buf,
> > +                                      buf_size, 0);
> 
> If the RBD in-memory cache is enabled during this operation, the
> writesame will effectively just be turned into a write. Therefore,
> when pre-allocating, you will want to disable the cache.
> 

During the creation, when preallocation is often used, we disable the cache:

static int qemu_rbd_do_create(BlockdevCreateOptions *options,
                              const char *keypairs, const char *password_secret,
                              Error **errp)
{
    ...

    ret = qemu_rbd_connect(&cluster, &io_ctx, opts->location, false, keypairs,
                                                              ^^ cache param
    ...
}


Do you think I should disable it in any case during the preallocation?



> > +                if (bytes < 0) {
> > +                    ret = bytes;
> > +                    error_setg_errno(errp, -ret,
> > +                                     "Failed to write for preallocation");
> > +                    goto out;
> > +                }
> > +
> > +                current_offset += bytes;
> > +            }
> > +        }
> > +#endif /* LIBRBD_SUPPORTS_WRITESAME */
> > +
> > +        while (current_offset < offset) {
> > +            bytes = rbd_write(image, current_offset,
> > +                              MIN(offset - current_offset, buf_size), buf);
> > +            if (bytes < 0) {
> > +                ret = bytes;
> > +                error_setg_errno(errp, -ret,
> > +                                 "Failed to write for preallocation");
> > +                goto out;
> > +            }
> > +
> > +            current_offset += bytes;
> > +        }
> > +
> > +        ret = rbd_flush(image);
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, -ret, "Failed to flush the file");
> > +            goto out;
> > +        }
> > +
> > +        break;
> > +    }
> > +    case PREALLOC_MODE_OFF:
> > +        ret = rbd_resize(image, offset);
> 
> I'm not familiar enough w/ the QEMU block code, but why would the
> PREALLOC_MODE_FULL case not need to resize the image?

PREALLOC_MODE_FULL need too, I did it just before the g_malloc0() in
this patch :-)

Thanks,
Stefano

