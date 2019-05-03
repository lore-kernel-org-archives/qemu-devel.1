Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998C3C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC1B2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 12:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC1B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMX2c-0003EC-OM
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 08:11:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMX1b-0002Yx-0G
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMX1a-0005am-0M
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:10:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hMX1Z-0005Zt-QM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:10:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id e9so7622120wrc.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=DkUMttNVdxz0c3JF8OlLekJiVR9g2zu4/RIIRsDY4U0=;
	b=cYUt+3ENb0pfDN08swneckE0dcBrDSfk3CbxVBDE+sqpdWA1i0sPYVJiV5DUOueS/N
	HJNtuFj5kl9g0iuwGGmofe5GpIDNy/IITFI5HNYhn7km8rG/FjNN/1kIkL3sWWtpyPRP
	427hMWGWLgJqHMnTt4nvrqBobPLhy/LZwtBZjlXA//BpCov2L5KhaVFn9NNW7hoY9ky+
	AZG/mFDC5Z3oH/UYP6qtMnlgLPXS/n7JWFvaOx990eXveWkHP4HZPvD3IbURKFteSgfX
	8IvCy8P5hLD1hNo/TZmAm1uX5el9YE0NKT7aB8oTIT26LAxWGApse+/DYzF2UDJANBDl
	STxQ==
X-Gm-Message-State: APjAAAVgclhzsxeBDI477rNZuAmE81Skf2L/pJpG+QHZCVu9ZSDP2ZlN
	UNm0pjm6sMPoi23dz+3YqdkS0A==
X-Google-Smtp-Source: APXvYqzLWjhcGK8SMu1zptLMIMFxHjUI6Lp/cLfpv7z5NqP11d3AGPHKkqvkwqRmGcEQ6PZipu7WRg==
X-Received: by 2002:a5d:508f:: with SMTP id a15mr6885580wrt.273.1556885444637; 
	Fri, 03 May 2019 05:10:44 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103]) by smtp.gmail.com with ESMTPSA id
	h16sm3472038wrb.31.2019.05.03.05.10.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 05:10:43 -0700 (PDT)
Date: Fri, 3 May 2019 14:10:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: dillaman@redhat.com
Message-ID: <20190503121041.xjmg6yygfujohqod@steredhat>
References: <20190503110206.42811-1-sgarzare@redhat.com>
	<CA+aFP1DBc_NdswPJLGGHq3H-uU+LqXON7SLQ16K3H3jAt_02HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CA+aFP1DBc_NdswPJLGGHq3H-uU+LqXON7SLQ16K3H3jAt_02HQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] block/rbd: implement
 .bdrv_get_allocated_file_size callback
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503121041.4WcOYv1tXkWaeE8uJrNWcHK0BzpSVlnL8HqW_Ik5fM0@z>

On Fri, May 03, 2019 at 07:55:01AM -0400, Jason Dillaman wrote:
> On Fri, May 3, 2019 at 7:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > This patch allows 'qemu-img info' to show the 'disk size' for
> > rbd images. We use the rbd_diff_iterate2() API to calculate the
> > allocated size for the image.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  block/rbd.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..61447bc0cb 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -1046,6 +1046,38 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
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
> > +    int64_t alloc_size = 0;
> > +    int r;
> > +
> > +    /*
> > +     * rbd_diff_iterate2(), if the source snapshot name is NULL, invokes
> > +     * the callback on all allocated regions of the image.
> > +     */
> > +    r = rbd_diff_iterate2(s->image, NULL, 0,
> > +                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1,
> > +                          &rbd_allocated_size_cb, &alloc_size);
> 
> Is there any concern that running this on very large images will take
> a very long time since it needs to iterate through each individual
> 4MiB (by default) backing object in the image? In libvirt, it only
> attempts to calculate the actual usage if the fast-diff feature is
> enabled, and recently it also got a new control to optionally disable
> the functionality entirely since even with fast-diff it's can be very
> slow to compute over hundreds of images in a libvirt storage pool.
> 

Thank you for pointing that out to me. I'll add check on fast-diff feature
on v2.
Since we only have one image here, do you think it would be reasonable to add
this feature or is it useless?

Thanks,
Stefano

