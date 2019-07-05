Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F38BC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2E92133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2E92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLiE-00082Z-7b
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58099)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hjLga-0006fv-Br
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hjLgZ-0005gJ-14
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:43:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hjLgY-0005e4-P2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:43:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so4794539wru.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=uUX8H1e+XL3KDdnpYS4qjFFDhuP6GaNmKAvjKyAJy78=;
 b=cR/HnZniZSbSf5GH3x5sJU/2g3pLRxelxmWzaAAzIBAt0yRiZxZEa7/1t+MA+8dz3G
 AsO6EP5rE6EVAR4XT+4iRjotpacvE+7qrPPm1yeC1oHL5WZ6aleRSkeTQP4Fzj4zP8XO
 /4RM/qCrkpnNEvqKVM0xMsuOmYb86jpTKYVQLszYnhrwLRZwKNvAyJFAr1CeRq7RcyYM
 0S9ylFQuqSnKfP/FY5SQaZyvFZj4+OdEkpVdsDQO+DTHsn6deA+bju3+hqsIu+llmtHG
 QipDCjqV3VWhquO54A+Ele+ntE4oq9asJr3xbzYiOdS684XmP3fhNouAM8ocK5yTvJOc
 Yq2Q==
X-Gm-Message-State: APjAAAX1Jla4piDdd//9GfUS2llCARfSBzXiZZ0pvvpLhAVyeXCfkDmn
 B56FBmxjLV0FViTGrYSNsEli3Q==
X-Google-Smtp-Source: APXvYqzAcV3z5cNa9XJsvxjrcR+3+48zyEhV5JfHYvpPnG6g7s61z2jq76UxOSFLS0CZGZmu8YIh3Q==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr3337036wru.275.1562323401503; 
 Fri, 05 Jul 2019 03:43:21 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id 72sm8468936wrk.22.2019.07.05.03.43.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 03:43:21 -0700 (PDT)
Date: Fri, 5 Jul 2019 12:43:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Jason Dillaman <jdillama@redhat.com>
Message-ID: <20190705104318.dngmmu3lpuvbe2nh@steredhat>
References: <20190705093258.47856-1-sgarzare@redhat.com>
 <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: implement
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
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 11:58:43AM +0200, Max Reitz wrote:
> On 05.07.19 11:32, Stefano Garzarella wrote:
> > This patch allows 'qemu-img info' to show the 'disk size' for
> > the RBD images that have the fast-diff feature enabled.
> > 
> > If this feature is enabled, we use the rbd_diff_iterate2() API
> > to calculate the allocated size for the image.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v3:
> >   - return -ENOTSUP instead of -1 when fast-diff is not available
> >     [John, Jason]
> > v2:
> >   - calculate the actual usage only if the fast-diff feature is
> >     enabled [Jason]
> > ---
> >  block/rbd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> 
> Well, the librbd documentation is non-existing as always, but while
> googling, I at least found that libvirt has exactly the same code.  So I
> suppose it must be quite correct, then.
> 

While I wrote this code I took a look at libvirt implementation and also
at the "rbd" tool in the ceph repository: compute_image_disk_usage() in
src/tools/rbd/action/DiskUsage.cc

> > diff --git a/block/rbd.c b/block/rbd.c
> > index 59757b3120..b6bed683e5 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -1084,6 +1084,59 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
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
> > +        return -ENOTSUP;
> > +    }
> > +
> > +    /*
> > +     * rbd_diff_iterate2(), if the source snapshot name is NULL, invokes
> > +     * the callback on all allocated regions of the image.
> > +     */
> > +    r = rbd_diff_iterate2(s->image, NULL, 0,
> > +                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1,
> > +                          &rbd_allocated_size_cb, &alloc_size);
> 
> But I have a question.  This is basically block_status, right?  So it
> gives us information on which areas are allocated and which are not.
> The result thus gives us a lower bound on the allocation size, but is it
> really exactly the allocation size?
> 
> There are two things I’m concerned about:
> 
> 1. What about metadata?

Good question, I don't think it includes the size used by metadata and I
don't know if there is a way to know it. I'll check better.

> 
> 2. If you have multiple snapshots, this will only report the overall
> allocation information, right?  So say there is something like this:
> 
> (“A” means an allocated MB, “-” is an unallocated MB)
> 
> Snapshot 1: AAAA---
> Snapshot 2: --AAAAA
> Snapshot 3: -AAAA--
> 
> I think the allocated data size is the number of As in total (13 MB).
> But I suppose this API will just return 7 MB, because it looks on
> everything an it sees the whole image range (7 MB) to be allocated.  It
> doesn’t report in how many snapshots some region is allocated.

Looking at the documentation of rbd_diff_iterate2() [1] they says:

 *                        If the source snapshot name is NULL, we
 * interpret that as the beginning of time and return all allocated
 * regions of the image.

But I don't know the answer of your question (maybe Jason can help
here).
I should check better the implementation to understand if I can cycle
on all snapshot to get the exact allocated data size.

https://github.com/ceph/ceph/blob/master/src/include/rbd/librbd.h#L925

I'll back when I have more details on the rbd implementation to better
answer your questions.

Thanks,
Stefano

