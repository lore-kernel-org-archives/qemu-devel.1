Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A76C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 19:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BCB20665
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 19:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BCB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgaK5-0001xc-SI
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 15:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jdillama@redhat.com>) id 1hgaIy-0000lk-On
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1hgaIx-000898-3f
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:43:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hgaIw-0007tV-Ra
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:43:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so8216962eds.8
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 12:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=m+d0tuHeVHIMXnv4fsPW+FtogfiC4MyqLxUp/LqOTd0=;
 b=aYtUuL3mmZsk1nuAAIPVN6eg6/ODbpSzyRV6hGdgeOemiMcNquhWwYyUYV00HA94SI
 tez+0i3OaMSub9NTmmLbcuxrLp4ZtSXF97seKJqsaSIySTlsnWNjrFJnjTEhvg7+294s
 eU4M4+4M89c6g0T4l1KcNgHjDE693kbyqrzaH0UeL1DlqDzsrQtpqDEeVyOYPP+mRxCX
 /g/OlslUPgBh8CvkS+nCJR2sUPd+mzQgj0N57ASXSFGnEuEfJzIiTFFcue4fxLedoy9Q
 aADEU+FwAIhvULrfetMauVAb0IVD6WQHxwRMKbw5VoTzAJXeAFvajNAv+Bnrqk0d8rmQ
 LgKg==
X-Gm-Message-State: APjAAAW1PlUJtSFMe575R3DG2IhK+NtnOYQMiDs0E1BH7eoZrjt3HZ5m
 3Na6c4gUVrrU7tFxziPPBPaUDlLNLDH8uBpkNBflJA==
X-Google-Smtp-Source: APXvYqyB184lGGjgErVP88OtKM5py+ZQ4erDAvtJkr3MVwlRQ51xbPAKPjWDQIymJ49nZbW5a0dbrLBUEj+0ABrPqak=
X-Received: by 2002:a05:6402:12d2:: with SMTP id
 k18mr6383611edx.197.1561664595564; 
 Thu, 27 Jun 2019 12:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190510153346.238366-1-sgarzare@redhat.com>
 <96429d33-6514-33b5-3fe8-7bdf2eccc8d9@redhat.com>
 <20190627084816.u6fj556uen3iqa3r@steredhat.homenet.telecomitalia.it>
 <b7aaa681-12ae-e256-e295-06e953dc51ff@redhat.com>
In-Reply-To: <b7aaa681-12ae-e256-e295-06e953dc51ff@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Thu, 27 Jun 2019 15:43:04 -0400
Message-ID: <CA+aFP1Btm6O5R0fiNZmBjHOO8t9ZDvvVgH0i1vFHsrQq85d+bA@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.68
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:24 PM John Snow <jsnow@redhat.com> wrote:
>
>
>
> On 6/27/19 4:48 AM, Stefano Garzarella wrote:
> > On Wed, Jun 26, 2019 at 05:04:25PM -0400, John Snow wrote:
> >> It looks like this has hit a 30 day expiration without any reviews or
> >> being merged; do we still want this? If so, can you please resend?
> >
> > Yes, I think we still want :)
> >
> > Is it okay if I send a v3 following your comments?
> >
>
> Yes, but I don't know who is responsible for final approval; I guess
> that's Josh Durgin?

I'm the new (for the past several years) upstream PTL for RBD, so feel
free to tag me.

> >>
> >> On 5/10/19 11:33 AM, Stefano Garzarella wrote:
> >>> This patch allows 'qemu-img info' to show the 'disk size' for
> >>> the RBD images that have the fast-diff feature enabled.
> >>>
> >>> If this feature is enabled, we use the rbd_diff_iterate2() API
> >>> to calculate the allocated size for the image.
> >>>
> >>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>> ---
> >>> v2:
> >>>   - calculate the actual usage only if the fast-diff feature is
> >>>     enabled [Jason]
> >>> ---
> >>>  block/rbd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 54 insertions(+)
> >>>
> >>> diff --git a/block/rbd.c b/block/rbd.c
> >>> index 0c549c9935..f1bc76ab80 100644
> >>> --- a/block/rbd.c
> >>> +++ b/block/rbd.c
> >>> @@ -1046,6 +1046,59 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
> >>>      return info.size;
> >>>  }
> >>>
> >>> +static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exists,
> >>> +                                 void *arg)
> >>> +{
> >>> +    int64_t *alloc_size = (int64_t *) arg;
> >>> +
> >>> +    if (exists) {
> >>> +        (*alloc_size) += len;
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
> >>> +{
> >>> +    BDRVRBDState *s = bs->opaque;
> >>> +    uint64_t flags, features;
> >>> +    int64_t alloc_size = 0;
> >>> +    int r;
> >>> +
> >>> +    r = rbd_get_flags(s->image, &flags);
> >>> +    if (r < 0) {
> >>> +        return r;
> >>> +    }
> >>> +
> >>
> >> Do you know where rbd_get_flags is documented? I can't seem to quickly
> >> find a reference that tells me what to expect from calling it. It
> >> returns an int, I guess an error code, but how can I confirm this?
> >>
> >> *clones the ceph repository*
> >>
> >> src/librbd/internal.cc get_flags convinces me it probably works like I
> >> think, but is there not a reference here?
> >>
> >
> > Good question!
> > I didn't find any docs, but looking in the ceph tests test/librbd/fsx.cc,
> > they print an error message if the return value is less than 0.
> >
> > A 'get_flags' implemented in cls/rbd/cls_rbd.cc for example returns 0 at the
> > end and -EINVAL in a try/catch. It also uses 'read_key()' that in some cases
> > returns -EIO, so I hope that the error returned by rbd_get_flags() is one of
> > the errors defined in errno.h
> >
> >>> +    r = rbd_get_features(s->image, &features);
> >>> +    if (r < 0) {
> >>> +        return r;
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * We use rbd_diff_iterate2() only if the RBD image have fast-diff
> >>> +     * feature enabled. If it is disabled, rbd_diff_iterate2() could be
> >>> +     * very slow on a big image.
> >>> +     */
> >>> +    if (!(features & RBD_FEATURE_FAST_DIFF) ||
> >>> +        (flags & RBD_FLAG_FAST_DIFF_INVALID)) {
> >>> +        return -1;
> >>> +    }
> >>> +
> >>
> >> (Is there a reference for the list of flags to make sure there aren't
> >> other cases we might want to skip this?)
> >
> > Unfortunately no :(
> > As Jason suggested, I followed what libvirt did in the
> > volStorageBackendRBDUseFastDiff() [src/storage/storage_backend_rbd.c]

These are the only ones.

> >>
> >> It looks reasonable at a glance, but maybe let's return -ENOTSUP instead
> >> of -1, based on the idea that bdrv_get_allocated_file_size returns
> >> -ENOMEDIUM in a prominent error case -- let's match that error convention.
> >
> > Sure, -ENOTSUP is absolutely better!
> >
> >>
> >> (Well, I wonder what the librbd calls are returning and if THOSE mean
> >> anything.)
> >
> > I hope they return an errno.h errors, but I'm not sure if the meaning
> > make sense for us.
> >
> > Do you think is better to return -ENOTSUP or -EIO when librbd calls
> > fail?
> >
>
> I'll be honest, I have no idea because I don't know what failure of
> these calls means _at all_, so I don't know if it should be something
> severe like EIO or something more mundane.
>
> I guess just leave them alone in absence of better information, honestly.

It looks like QEMU treats any negative error code like the actual size
isn't available. However, for clarity I would vote for -ENOTSUPP since
that's what would be returned if the driver doesn't support it.

> >
> > Thanks for your comments,
> > Stefano
> >
>
> Thank you for trying to patch rbd :)


-- 
Jason

