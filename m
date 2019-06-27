Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB47C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 08:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FF620843
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 08:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FF620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgQ6T-0004nN-LB
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 04:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hgQ59-0003g0-6B
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hgQ57-0005x2-10
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:48:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hgQ55-0005g3-QQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:48:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1553837wrs.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 01:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=01hzjEgpeqAVN0DXSUCal/kPrfTIGvJA0N+UxSxSjr4=;
 b=OqzhwABxmsdMVTfcmmLt+dyEqp2RUXyA+Tiez/a0nQMFwaYSCajHKDqdlqqh5+U2V3
 g/dwfA7KaffN/OftLRakr6Q/kduMpcgBJ7kp65tcZo34YJpSHRtXN24r2jmFxzEzrrh9
 MZcu5dAAHxMUUhiHqRZJWZu+dFHDOTdvGWyYuOUKZgW4e+Ceq6+q3jKwCkvihuJDX88+
 s0C66KCy5mPxfAfUj7fZ+c21RljMvJO4ktVd/VkFxXvuOnvYoT4oyfk/ioQbEygbvD5U
 edo4hEcvP/aImXOIWUGwSECutoKoZAYT8fX9S27AHP0Z4PatykNeKimZsXs/OhixSapQ
 9dvg==
X-Gm-Message-State: APjAAAXLd/cllnh8cjuVvG9k8BvYqoAyt3m2nZ8XVb0cJMcs7B3Z7sVE
 bYgc7LApeLHIz1FnMlfBvYkjlg==
X-Google-Smtp-Source: APXvYqz6BQ6re3+LBcdifqUZT/NW4iJyYWTHcTJR0zV93e2iRcJqjQuMJBXqjNPp4y/kFWk4HaHYiQ==
X-Received: by 2002:adf:ed50:: with SMTP id u16mr2102910wro.108.1561625299532; 
 Thu, 27 Jun 2019 01:48:19 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
 (host21-207-dynamic.52-79-r.retail.telecomitalia.it. [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id z5sm4281999wma.36.2019.06.27.01.48.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 01:48:19 -0700 (PDT)
Date: Thu, 27 Jun 2019 10:48:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190627084816.u6fj556uen3iqa3r@steredhat.homenet.telecomitalia.it>
References: <20190510153346.238366-1-sgarzare@redhat.com>
 <96429d33-6514-33b5-3fe8-7bdf2eccc8d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96429d33-6514-33b5-3fe8-7bdf2eccc8d9@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] block/rbd: implement
 .bdrv_get_allocated_file_size callback
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Jason Dillaman <jdillama@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 05:04:25PM -0400, John Snow wrote:
> It looks like this has hit a 30 day expiration without any reviews or
> being merged; do we still want this? If so, can you please resend?

Yes, I think we still want :)

Is it okay if I send a v3 following your comments?

> 
> On 5/10/19 11:33 AM, Stefano Garzarella wrote:
> > This patch allows 'qemu-img info' to show the 'disk size' for
> > the RBD images that have the fast-diff feature enabled.
> > 
> > If this feature is enabled, we use the rbd_diff_iterate2() API
> > to calculate the allocated size for the image.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v2:
> >   - calculate the actual usage only if the fast-diff feature is
> >     enabled [Jason]
> > ---
> >  block/rbd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..f1bc76ab80 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -1046,6 +1046,59 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
> >      return info.size;
> >  }
> >  
> > +static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exists,
> > +                                 void *arg)
> > +{
> > +    int64_t *alloc_size = (int64_t *) arg;
> > +
> > +    if (exists) {
> > +        (*alloc_size) += len;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
> > +{
> > +    BDRVRBDState *s = bs->opaque;
> > +    uint64_t flags, features;
> > +    int64_t alloc_size = 0;
> > +    int r;
> > +
> > +    r = rbd_get_flags(s->image, &flags);
> > +    if (r < 0) {
> > +        return r;
> > +    }
> > +
> 
> Do you know where rbd_get_flags is documented? I can't seem to quickly
> find a reference that tells me what to expect from calling it. It
> returns an int, I guess an error code, but how can I confirm this?
> 
> *clones the ceph repository*
> 
> src/librbd/internal.cc get_flags convinces me it probably works like I
> think, but is there not a reference here?
> 

Good question!
I didn't find any docs, but looking in the ceph tests test/librbd/fsx.cc,
they print an error message if the return value is less than 0.

A 'get_flags' implemented in cls/rbd/cls_rbd.cc for example returns 0 at the
end and -EINVAL in a try/catch. It also uses 'read_key()' that in some cases
returns -EIO, so I hope that the error returned by rbd_get_flags() is one of
the errors defined in errno.h

> > +    r = rbd_get_features(s->image, &features);
> > +    if (r < 0) {
> > +        return r;
> > +    }
> > +
> > +    /*
> > +     * We use rbd_diff_iterate2() only if the RBD image have fast-diff
> > +     * feature enabled. If it is disabled, rbd_diff_iterate2() could be
> > +     * very slow on a big image.
> > +     */
> > +    if (!(features & RBD_FEATURE_FAST_DIFF) ||
> > +        (flags & RBD_FLAG_FAST_DIFF_INVALID)) {
> > +        return -1;
> > +    }
> > +
> 
> (Is there a reference for the list of flags to make sure there aren't
> other cases we might want to skip this?)

Unfortunately no :(
As Jason suggested, I followed what libvirt did in the
volStorageBackendRBDUseFastDiff() [src/storage/storage_backend_rbd.c]

> 
> It looks reasonable at a glance, but maybe let's return -ENOTSUP instead
> of -1, based on the idea that bdrv_get_allocated_file_size returns
> -ENOMEDIUM in a prominent error case -- let's match that error convention.

Sure, -ENOTSUP is absolutely better!

> 
> (Well, I wonder what the librbd calls are returning and if THOSE mean
> anything.)

I hope they return an errno.h errors, but I'm not sure if the meaning
make sense for us.

Do you think is better to return -ENOTSUP or -EIO when librbd calls
fail?


Thanks for your comments,
Stefano

