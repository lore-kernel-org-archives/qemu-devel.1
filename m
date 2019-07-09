Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74321C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A43B2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 03:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A43B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkgWY-0005dy-W1
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 23:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51624)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jdillama@redhat.com>) id 1hkgVK-00058J-2y
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 23:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1hkgVF-00079g-JH
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 23:09:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hkgVC-00071x-1A
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 23:09:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so16282910edr.11
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 20:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc:content-transfer-encoding;
 bh=bscJhhfWM7bBPgunbuc02TusfvSCtAO1YzH3WxQyjL8=;
 b=dhOo6FdeNH2Vgs9CiQcxCfZf+LmUytVqnK7W2/yHYSOx342d8RsXWonDjtweATbxOo
 pgCZ3DuPSsqRsuv58Cvz9vYhwqAsauhS5o7mhrwr/f2oYJjdPxKfnHm+C9R1ExoNCsZT
 uYhKXVG/545XajKQdFqsDDrkkOoeKpwoDY866Yk1U55mJcQfdHeG1s6RzpUnbI40OXaK
 EdD5jCF8YcpNwOk5Z45QR/B6vWntMf4P9ZfN5IvK7coCFShJEOqsI8/296rRd87r0iYG
 MWQ12/kI7dPtfUsBuqYxFiGjhH/T1JOgPk7f6Xp0AM4Hz7Axe90gOT0ZMFpK7cGGK3R9
 Rc1A==
X-Gm-Message-State: APjAAAXpBMJNRFRTa1SU0NhsiGa6q5jqIaxY7/R5GcDlUbEdWtWUACvJ
 KgclyULbCtas0MQj+IdG0+geVUsrYeiQcn4VJmT+sw==
X-Google-Smtp-Source: APXvYqwiSMJuQBXMhRp3VKqbBHFu4Kuc4nrZEAxnqUfayrxbg27v/gTmrDkXQEsBJV+giRss2WVbWBVNUbBIjgDgho8=
X-Received: by 2002:aa7:c753:: with SMTP id c19mr17031830eds.81.1562641744412; 
 Mon, 08 Jul 2019 20:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190705093258.47856-1-sgarzare@redhat.com>
 <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
 <20190705104318.dngmmu3lpuvbe2nh@steredhat>
In-Reply-To: <20190705104318.dngmmu3lpuvbe2nh@steredhat>
From: Jason Dillaman <jdillama@redhat.com>
Date: Mon, 8 Jul 2019 23:08:53 -0400
Message-ID: <CA+aFP1AgNGJMdAG_E23Q-rf2Gt1rpeKjDfrk1PLA3f4XiUkGtw@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.65
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 5, 2019 at 6:43 AM Stefano Garzarella <sgarzare@redhat.com> wro=
te:
>
> On Fri, Jul 05, 2019 at 11:58:43AM +0200, Max Reitz wrote:
> > On 05.07.19 11:32, Stefano Garzarella wrote:
> > > This patch allows 'qemu-img info' to show the 'disk size' for
> > > the RBD images that have the fast-diff feature enabled.
> > >
> > > If this feature is enabled, we use the rbd_diff_iterate2() API
> > > to calculate the allocated size for the image.
> > >
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > v3:
> > >   - return -ENOTSUP instead of -1 when fast-diff is not available
> > >     [John, Jason]
> > > v2:
> > >   - calculate the actual usage only if the fast-diff feature is
> > >     enabled [Jason]
> > > ---
> > >  block/rbd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 54 insertions(+)
> >
> > Well, the librbd documentation is non-existing as always, but while
> > googling, I at least found that libvirt has exactly the same code.  So =
I
> > suppose it must be quite correct, then.
> >
>
> While I wrote this code I took a look at libvirt implementation and also
> at the "rbd" tool in the ceph repository: compute_image_disk_usage() in
> src/tools/rbd/action/DiskUsage.cc
>
> > > diff --git a/block/rbd.c b/block/rbd.c
> > > index 59757b3120..b6bed683e5 100644
> > > --- a/block/rbd.c
> > > +++ b/block/rbd.c
> > > @@ -1084,6 +1084,59 @@ static int64_t qemu_rbd_getlength(BlockDriverS=
tate *bs)
> > >      return info.size;
> > >  }
> > >
> > > +static int rbd_allocated_size_cb(uint64_t offset, size_t len, int ex=
ists,
> > > +                                 void *arg)
> > > +{
> > > +    int64_t *alloc_size =3D (int64_t *) arg;
> > > +
> > > +    if (exists) {
> > > +        (*alloc_size) +=3D len;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs=
)
> > > +{
> > > +    BDRVRBDState *s =3D bs->opaque;
> > > +    uint64_t flags, features;
> > > +    int64_t alloc_size =3D 0;
> > > +    int r;
> > > +
> > > +    r =3D rbd_get_flags(s->image, &flags);
> > > +    if (r < 0) {
> > > +        return r;
> > > +    }
> > > +
> > > +    r =3D rbd_get_features(s->image, &features);
> > > +    if (r < 0) {
> > > +        return r;
> > > +    }
> > > +
> > > +    /*
> > > +     * We use rbd_diff_iterate2() only if the RBD image have fast-di=
ff
> > > +     * feature enabled. If it is disabled, rbd_diff_iterate2() could=
 be
> > > +     * very slow on a big image.
> > > +     */
> > > +    if (!(features & RBD_FEATURE_FAST_DIFF) ||
> > > +        (flags & RBD_FLAG_FAST_DIFF_INVALID)) {
> > > +        return -ENOTSUP;
> > > +    }
> > > +
> > > +    /*
> > > +     * rbd_diff_iterate2(), if the source snapshot name is NULL, inv=
okes
> > > +     * the callback on all allocated regions of the image.
> > > +     */
> > > +    r =3D rbd_diff_iterate2(s->image, NULL, 0,
> > > +                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1=
,
> > > +                          &rbd_allocated_size_cb, &alloc_size);
> >
> > But I have a question.  This is basically block_status, right?  So it
> > gives us information on which areas are allocated and which are not.
> > The result thus gives us a lower bound on the allocation size, but is i=
t
> > really exactly the allocation size?
> >
> > There are two things I=E2=80=99m concerned about:
> >
> > 1. What about metadata?
>
> Good question, I don't think it includes the size used by metadata and I
> don't know if there is a way to know it. I'll check better.

It does not include the size of metadata, the "rbd_diff_iterate2"
function is literally just looking for touched data blocks within the
RBD image.

> >
> > 2. If you have multiple snapshots, this will only report the overall
> > allocation information, right?  So say there is something like this:
> >
> > (=E2=80=9CA=E2=80=9D means an allocated MB, =E2=80=9C-=E2=80=9D is an u=
nallocated MB)
> >
> > Snapshot 1: AAAA---
> > Snapshot 2: --AAAAA
> > Snapshot 3: -AAAA--
> >
> > I think the allocated data size is the number of As in total (13 MB).
> > But I suppose this API will just return 7 MB, because it looks on
> > everything an it sees the whole image range (7 MB) to be allocated.  It
> > doesn=E2=80=99t report in how many snapshots some region is allocated.

It should return 13 dirty data blocks (multipled by the size of the
data block) since when you don't provide a "from snapshot" name, it
will iterate from the first snapshot to the HEAD revision.

> Looking at the documentation of rbd_diff_iterate2() [1] they says:
>
>  *                        If the source snapshot name is NULL, we
>  * interpret that as the beginning of time and return all allocated
>  * regions of the image.
>
> But I don't know the answer of your question (maybe Jason can help
> here).
> I should check better the implementation to understand if I can cycle
> on all snapshot to get the exact allocated data size.
>
> https://github.com/ceph/ceph/blob/master/src/include/rbd/librbd.h#L925
>
> I'll back when I have more details on the rbd implementation to better
> answer your questions.
>
> Thanks,
> Stefano



--=20
Jason

