Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC471C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 07:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929FF21881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 07:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929FF21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiZmQ-0001xV-Lr
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 03:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hiZjY-00005K-Ow
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 03:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hiZjW-0000Cw-Ix
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 03:31:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hiZjW-0000Ap-By
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 03:31:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so2238178wme.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 00:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gSlXWLDWSaMNKsmLZqjZvxg48tdPEy0xbhepRe8xU/E=;
 b=IsmzYCAuyhpE6MoKpDO5OriOuDgpZHpszuOwwsUj+ZitiQJh+Hw00QAsqHR02FPFzk
 mN8JfXCQ4ha2Py4/sQBQEWYc4hB3vsbR7ojjfQDwk6gZoqLUV/KEiCTmWv0gpPDWu9vp
 /UK+CVpAiGvpevc3jsmWEVyzmEdfogkJdGU0ef6crPLoNIfSR9Iuwp9o2/8z2K+7Bcwc
 66I9uXu0wmwgaSUgKtVnxV3ROEB6zApdmUfRWgknPnYi/KAdS3UOFXRSnMx+nGiQQx99
 jq3pCmjSx+ANAwnnpfaYK8YAOQC90P7XTqwl81Ki7sF2og+C0ogtbP/Iz/6vCDyHsgY0
 20kQ==
X-Gm-Message-State: APjAAAW454dy6eEJEqccBFUexHllVwZy2eC9udpccfpBsgxwr82sgSzK
 g065COtufcYX580jFHm7lrb26w==
X-Google-Smtp-Source: APXvYqzqNjgLo1Br09kElb5BWqmQNvWZ/16VPKUx13bnyM4x/KpgVH9HmJ02wEOFPcjDvc6uKoIV5Q==
X-Received: by 2002:a05:600c:2243:: with SMTP id
 a3mr6469321wmm.83.1562139071746; 
 Wed, 03 Jul 2019 00:31:11 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id z126sm1704329wmb.32.2019.07.03.00.31.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 00:31:11 -0700 (PDT)
Date: Wed, 3 Jul 2019 09:31:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: dillaman@redhat.com
Message-ID: <20190703073108.rugtqynnxxntp5kw@steredhat>
References: <20190510153346.238366-1-sgarzare@redhat.com>
 <96429d33-6514-33b5-3fe8-7bdf2eccc8d9@redhat.com>
 <20190627084816.u6fj556uen3iqa3r@steredhat.homenet.telecomitalia.it>
 <b7aaa681-12ae-e256-e295-06e953dc51ff@redhat.com>
 <CA+aFP1Btm6O5R0fiNZmBjHOO8t9ZDvvVgH0i1vFHsrQq85d+bA@mail.gmail.com>
 <20190628085901.rnzcfu6rgkvrg46n@steredhat>
 <CA+aFP1C828MUouu+3P2HKn3zHc3STKZ1mcEY8S4HWRNcFoiO9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1C828MUouu+3P2HKn3zHc3STKZ1mcEY8S4HWRNcFoiO9w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
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
 qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 11:09:14AM -0400, Jason Dillaman wrote:
> On Fri, Jun 28, 2019 at 4:59 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Thu, Jun 27, 2019 at 03:43:04PM -0400, Jason Dillaman wrote:
> > > On Thu, Jun 27, 2019 at 1:24 PM John Snow <jsnow@redhat.com> wrote:
> > > > On 6/27/19 4:48 AM, Stefano Garzarella wrote:
> > > > > On Wed, Jun 26, 2019 at 05:04:25PM -0400, John Snow wrote:
> > > > >> It looks like this has hit a 30 day expiration without any reviews or
> > > > >> being merged; do we still want this? If so, can you please resend?
> > > > >
> > > > > Yes, I think we still want :)
> > > > >
> > > > > Is it okay if I send a v3 following your comments?
> > > > >
> > > >
> > > > Yes, but I don't know who is responsible for final approval; I guess
> > > > that's Josh Durgin?
> > >
> > > I'm the new (for the past several years) upstream PTL for RBD, so feel
> > > free to tag me.
> > >
> > > > >>
> > > > >> On 5/10/19 11:33 AM, Stefano Garzarella wrote:
> > > > >>> This patch allows 'qemu-img info' to show the 'disk size' for
> > > > >>> the RBD images that have the fast-diff feature enabled.
> > > > >>>
> > > > >>> If this feature is enabled, we use the rbd_diff_iterate2() API
> > > > >>> to calculate the allocated size for the image.
> > > > >>>
> > > > >>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > >>> ---
> > > > >>> v2:
> > > > >>>   - calculate the actual usage only if the fast-diff feature is
> > > > >>>     enabled [Jason]
> > > > >>> ---
> > > > >>>  block/rbd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >>>  1 file changed, 54 insertions(+)
> > > > >>>
> > > > >>> diff --git a/block/rbd.c b/block/rbd.c
> > > > >>> index 0c549c9935..f1bc76ab80 100644
> > > > >>> --- a/block/rbd.c
> > > > >>> +++ b/block/rbd.c
> > > > >>> @@ -1046,6 +1046,59 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
> > > > >>>      return info.size;
> > > > >>>  }
> > > > >>>
> > > > >>> +static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exists,
> > > > >>> +                                 void *arg)
> > > > >>> +{
> > > > >>> +    int64_t *alloc_size = (int64_t *) arg;
> > > > >>> +
> > > > >>> +    if (exists) {
> > > > >>> +        (*alloc_size) += len;
> > > > >>> +    }
> > > > >>> +
> > > > >>> +    return 0;
> > > > >>> +}
> > > > >>> +
> > > > >>> +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
> > > > >>> +{
> > > > >>> +    BDRVRBDState *s = bs->opaque;
> > > > >>> +    uint64_t flags, features;
> > > > >>> +    int64_t alloc_size = 0;
> > > > >>> +    int r;
> > > > >>> +
> > > > >>> +    r = rbd_get_flags(s->image, &flags);
> > > > >>> +    if (r < 0) {
> > > > >>> +        return r;
> > > > >>> +    }
> > > > >>> +
> > > > >>
> > > > >> Do you know where rbd_get_flags is documented? I can't seem to quickly
> > > > >> find a reference that tells me what to expect from calling it. It
> > > > >> returns an int, I guess an error code, but how can I confirm this?
> > > > >>
> > > > >> *clones the ceph repository*
> > > > >>
> > > > >> src/librbd/internal.cc get_flags convinces me it probably works like I
> > > > >> think, but is there not a reference here?
> > > > >>
> > > > >
> > > > > Good question!
> > > > > I didn't find any docs, but looking in the ceph tests test/librbd/fsx.cc,
> > > > > they print an error message if the return value is less than 0.
> > > > >
> > > > > A 'get_flags' implemented in cls/rbd/cls_rbd.cc for example returns 0 at the
> > > > > end and -EINVAL in a try/catch. It also uses 'read_key()' that in some cases
> > > > > returns -EIO, so I hope that the error returned by rbd_get_flags() is one of
> > > > > the errors defined in errno.h
> > > > >
> > > > >>> +    r = rbd_get_features(s->image, &features);
> > > > >>> +    if (r < 0) {
> > > > >>> +        return r;
> > > > >>> +    }
> > > > >>> +
> > > > >>> +    /*
> > > > >>> +     * We use rbd_diff_iterate2() only if the RBD image have fast-diff
> > > > >>> +     * feature enabled. If it is disabled, rbd_diff_iterate2() could be
> > > > >>> +     * very slow on a big image.
> > > > >>> +     */
> > > > >>> +    if (!(features & RBD_FEATURE_FAST_DIFF) ||
> > > > >>> +        (flags & RBD_FLAG_FAST_DIFF_INVALID)) {
> > > > >>> +        return -1;
> > > > >>> +    }
> > > > >>> +
> > > > >>
> > > > >> (Is there a reference for the list of flags to make sure there aren't
> > > > >> other cases we might want to skip this?)
> > > > >
> > > > > Unfortunately no :(
> > > > > As Jason suggested, I followed what libvirt did in the
> > > > > volStorageBackendRBDUseFastDiff() [src/storage/storage_backend_rbd.c]
> > >
> > > These are the only ones.
> >
> > Thanks for the clarification!
> >
> > >
> > > > >>
> > > > >> It looks reasonable at a glance, but maybe let's return -ENOTSUP instead
> > > > >> of -1, based on the idea that bdrv_get_allocated_file_size returns
> > > > >> -ENOMEDIUM in a prominent error case -- let's match that error convention.
> > > > >
> > > > > Sure, -ENOTSUP is absolutely better!
> > > > >
> > > > >>
> > > > >> (Well, I wonder what the librbd calls are returning and if THOSE mean
> > > > >> anything.)
> > > > >
> > > > > I hope they return an errno.h errors, but I'm not sure if the meaning
> > > > > make sense for us.
> > > > >
> > > > > Do you think is better to return -ENOTSUP or -EIO when librbd calls
> > > > > fail?
> > > > >
> > > >
> > > > I'll be honest, I have no idea because I don't know what failure of
> > > > these calls means _at all_, so I don't know if it should be something
> > > > severe like EIO or something more mundane.
> > > >
> > > > I guess just leave them alone in absence of better information, honestly.
> > >
> > > It looks like QEMU treats any negative error code like the actual size
> > > isn't available. However, for clarity I would vote for -ENOTSUPP since
> > > that's what would be returned if the driver doesn't support it.
> > >
> >
> > Do you mean to return -ENOTSUP even when there's a runtime error in
> > rbd_get_features() or rbd_get_flags() or rbd_diff_iterate2?
> 
> I was advocating for only returning -ENOTSUP in the case where
> fast-diff isn't enabled or is flagged as invalid (instead of the
> hard-coded -1). If one of the librbd APIs returns an error for some
> reason, it seems like you can just pass it along like the current
> patch does since any negative result is handled.

Sure, that's what I wanted to do in v3, but I had a doubt.

Thanks for the clarification, I'll send a v3 following your and John
reviews.

Stefano

