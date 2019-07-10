Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95695C73C65
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4957A20651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4957A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl1dp-0007BD-GN
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jdillama@redhat.com>) id 1hl1cx-0006gs-KR
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1hl1cv-0007Du-HW
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:42:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hl1cr-0006yj-9d
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:42:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so334793edq.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 18:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc:content-transfer-encoding;
 bh=ZFE7mLoZKF+VQixZPEomGOSbjk1TFGl7M02iCJIuJ9E=;
 b=CfJxpO/tp+sc5HMCwSeiM5fPu2JIkRQeau4Wv2EpjDlbx0ljTJNRl5KPN4x1GBCFSa
 PMq9RaVmSte+k5mnhoXZiAsIFv78o8YcYcEgU/aYUuOIcEqlJQY1syjTfblinRrKHQZB
 n6XlCXu/3e2KdTB9CxyDZxSgwGhbA4vZdSLjf+Y55YLt34BARpULiNyqb0G7PfF37jGJ
 gwvfd4m3TxWrNWg5JuSaL6xCpGWt1EaSlw5T8Bm9tNXXtPzFXP/LL+rpSYgwPkPa0GHg
 4Ay5jqe7uyAwpvtR0BgB81OBkBO2MJruci7krkMWQE1nj2ztgIwnplQK8+y5S8q+56hM
 mZmw==
X-Gm-Message-State: APjAAAWAOZwTdCX5SdSwSrxzRrsEn9RsXwdDo4yEErmJprsUpRu+NpOG
 Pudt3g24mToxiGaF++JkB2jqR02q3vDr1dw66lfoQQ==
X-Google-Smtp-Source: APXvYqyOl+wudo9xwt0kByTwER35ntNHBMA1T8u+NcV97zTu5Lhz9tIbZD37j2TEStM4keUJUbRwt0EP8k4KAT1XIyw=
X-Received: by 2002:a50:f05a:: with SMTP id u26mr23855093edl.116.1562722946263; 
 Tue, 09 Jul 2019 18:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190705093258.47856-1-sgarzare@redhat.com>
 <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
 <20190705104318.dngmmu3lpuvbe2nh@steredhat>
 <CA+aFP1AgNGJMdAG_E23Q-rf2Gt1rpeKjDfrk1PLA3f4XiUkGtw@mail.gmail.com>
 <754459cc-08c7-6cce-02c6-10f765cb9d00@redhat.com>
 <9438ac63-949b-9e08-42a2-4b4ff2c778f8@redhat.com>
 <CA+aFP1AW9yv+_4H6M4Pq-E2ehP7KHvULm3xogqnvvZUzDdEw0g@mail.gmail.com>
 <20190709130948.ivvncgyu2wp35s3n@steredhat>
 <ac488740-6026-e98f-f702-a9d7808d5d41@redhat.com>
In-Reply-To: <ac488740-6026-e98f-f702-a9d7808d5d41@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Tue, 9 Jul 2019 21:42:14 -0400
Message-ID: <CA+aFP1A9J3L5aPwm9rQtEqHHrUT0JQ+Py0KUqmhWU9eY=_FWXg@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.66
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
 qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, dillaman <dillaman@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 11:32 AM Max Reitz <mreitz@redhat.com> wrote:
>
> On 09.07.19 15:09, Stefano Garzarella wrote:
> > On Tue, Jul 09, 2019 at 08:55:19AM -0400, Jason Dillaman wrote:
> >> On Tue, Jul 9, 2019 at 5:45 AM Max Reitz <mreitz@redhat.com> wrote:
> >>>
> >>> On 09.07.19 10:55, Max Reitz wrote:
> >>>> On 09.07.19 05:08, Jason Dillaman wrote:
> >>>>> On Fri, Jul 5, 2019 at 6:43 AM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
> >>>>>>
> >>>>>> On Fri, Jul 05, 2019 at 11:58:43AM +0200, Max Reitz wrote:
> >>>>>>> On 05.07.19 11:32, Stefano Garzarella wrote:
> >>>>>>>> This patch allows 'qemu-img info' to show the 'disk size' for
> >>>>>>>> the RBD images that have the fast-diff feature enabled.
> >>>>>>>>
> >>>>>>>> If this feature is enabled, we use the rbd_diff_iterate2() API
> >>>>>>>> to calculate the allocated size for the image.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>>>>>>> ---
> >>>>>>>> v3:
> >>>>>>>>   - return -ENOTSUP instead of -1 when fast-diff is not availabl=
e
> >>>>>>>>     [John, Jason]
> >>>>>>>> v2:
> >>>>>>>>   - calculate the actual usage only if the fast-diff feature is
> >>>>>>>>     enabled [Jason]
> >>>>>>>> ---
> >>>>>>>>  block/rbd.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
> >>>>>>>>  1 file changed, 54 insertions(+)
> >>>>>>>
> >>>>>>> Well, the librbd documentation is non-existing as always, but whi=
le
> >>>>>>> googling, I at least found that libvirt has exactly the same code=
.  So I
> >>>>>>> suppose it must be quite correct, then.
> >>>>>>>
> >>>>>>
> >>>>>> While I wrote this code I took a look at libvirt implementation an=
d also
> >>>>>> at the "rbd" tool in the ceph repository: compute_image_disk_usage=
() in
> >>>>>> src/tools/rbd/action/DiskUsage.cc
> >>>>>>
> >>>>>>>> diff --git a/block/rbd.c b/block/rbd.c
> >>>>>>>> index 59757b3120..b6bed683e5 100644
> >>>>>>>> --- a/block/rbd.c
> >>>>>>>> +++ b/block/rbd.c
> >>>>>>>> @@ -1084,6 +1084,59 @@ static int64_t qemu_rbd_getlength(BlockDr=
iverState *bs)
> >>>>>>>>      return info.size;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +static int rbd_allocated_size_cb(uint64_t offset, size_t len, i=
nt exists,
> >>>>>>>> +                                 void *arg)
> >>>>>>>> +{
> >>>>>>>> +    int64_t *alloc_size =3D (int64_t *) arg;
> >>>>>>>> +
> >>>>>>>> +    if (exists) {
> >>>>>>>> +        (*alloc_size) +=3D len;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverStat=
e *bs)
> >>>>>>>> +{
> >>>>>>>> +    BDRVRBDState *s =3D bs->opaque;
> >>>>>>>> +    uint64_t flags, features;
> >>>>>>>> +    int64_t alloc_size =3D 0;
> >>>>>>>> +    int r;
> >>>>>>>> +
> >>>>>>>> +    r =3D rbd_get_flags(s->image, &flags);
> >>>>>>>> +    if (r < 0) {
> >>>>>>>> +        return r;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    r =3D rbd_get_features(s->image, &features);
> >>>>>>>> +    if (r < 0) {
> >>>>>>>> +        return r;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    /*
> >>>>>>>> +     * We use rbd_diff_iterate2() only if the RBD image have fa=
st-diff
> >>>>>>>> +     * feature enabled. If it is disabled, rbd_diff_iterate2() =
could be
> >>>>>>>> +     * very slow on a big image.
> >>>>>>>> +     */
> >>>>>>>> +    if (!(features & RBD_FEATURE_FAST_DIFF) ||
> >>>>>>>> +        (flags & RBD_FLAG_FAST_DIFF_INVALID)) {
> >>>>>>>> +        return -ENOTSUP;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    /*
> >>>>>>>> +     * rbd_diff_iterate2(), if the source snapshot name is NULL=
, invokes
> >>>>>>>> +     * the callback on all allocated regions of the image.
> >>>>>>>> +     */
> >>>>>>>> +    r =3D rbd_diff_iterate2(s->image, NULL, 0,
> >>>>>>>> +                          bs->total_sectors * BDRV_SECTOR_SIZE,=
 0, 1,
> >>>>>>>> +                          &rbd_allocated_size_cb, &alloc_size);
> >>>>>>>
> >>>>>>> But I have a question.  This is basically block_status, right?  S=
o it
> >>>>>>> gives us information on which areas are allocated and which are n=
ot.
> >>>>>>> The result thus gives us a lower bound on the allocation size, bu=
t is it
> >>>>>>> really exactly the allocation size?
> >>>>>>>
> >>>>>>> There are two things I=E2=80=99m concerned about:
> >>>>>>>
> >>>>>>> 1. What about metadata?
> >>>>>>
> >>>>>> Good question, I don't think it includes the size used by metadata=
 and I
> >>>>>> don't know if there is a way to know it. I'll check better.
> >>>>>
> >>>>> It does not include the size of metadata, the "rbd_diff_iterate2"
> >>>>> function is literally just looking for touched data blocks within t=
he
> >>>>> RBD image.
> >>>>>
> >>>>>>>
> >>>>>>> 2. If you have multiple snapshots, this will only report the over=
all
> >>>>>>> allocation information, right?  So say there is something like th=
is:
> >>>>>>>
> >>>>>>> (=E2=80=9CA=E2=80=9D means an allocated MB, =E2=80=9C-=E2=80=9D i=
s an unallocated MB)
> >>>>>>>
> >>>>>>> Snapshot 1: AAAA---
> >>>>>>> Snapshot 2: --AAAAA
> >>>>>>> Snapshot 3: -AAAA--
> >>>>>>>
> >>>>>>> I think the allocated data size is the number of As in total (13 =
MB).
> >>>>>>> But I suppose this API will just return 7 MB, because it looks on
> >>>>>>> everything an it sees the whole image range (7 MB) to be allocate=
d.  It
> >>>>>>> doesn=E2=80=99t report in how many snapshots some region is alloc=
ated.
> >>>>>
> >>>>> It should return 13 dirty data blocks (multipled by the size of the
> >>>>> data block) since when you don't provide a "from snapshot" name, it
> >>>>> will iterate from the first snapshot to the HEAD revision.
> >>>>
> >>>> Have you tested that?
> >>>>
> >>>> I=E2=80=98m so skeptical because the callback function interface has=
 no way of
> >>>> distinguishing between different layers of snapshots.
> >>>>
> >>>> And also because we have the bdrv_block_status_above() function whic=
h
> >>>> just looks strikingly similar (with the difference that it does not
> >>>> invoke a callback but just returns the next allocated range).  If yo=
u
> >>>> pass base=3DNULL to it, it will also =E2=80=9Cinterpret that as the =
beginning of
> >>>> time and return all allocated regions of the image=E2=80=9D (or rath=
er image
> >>>> chain, in our case).  But it would just return 7 MB as allocated.  (=
Even
> >>>> though it does in fact return layer information, i.e. where a given
> >>>> continuous chunk of data is allocated.)
> >>>>
> >>>> Sure, there is no good reason for why our interface should by chance=
 be
> >>>> the same as librbd=E2=80=99s interface.  But without having tested i=
t, the fact
> >>>> that the callback cannot detect which layer a chunk is allocated on =
just
> >>>> makes me wary.
> >>>
> >>> And the librbd code doesn=E2=80=99t alleviate my concerns.
> >>>
> >>> From what I can see, it first creates a bitmap (two bits per entry) t=
hat
> >>> covers the whole image and says which objects are allocated and which
> >>> aren=E2=80=98t.  Through the whole chain, that is.  So in the above e=
xample, the
> >>> bitmap would report everything as allocated.  (Or rather =E2=80=9Cupd=
ated=E2=80=9C in
> >>> librbd=E2=80=98s terms.)
> >>>
> >>> Then it has this piece:
> >>>
> >>>>   uint64_t off =3D m_offset;
> >>>>   uint64_t left =3D m_length;
> >>>>
> >>>>   while (left > 0) {
> >>>>     uint64_t period_off =3D off - (off % period);
> >>>>     uint64_t read_len =3D min(period_off + period - off, left);
> >>>>
> >>>>     // map to extents
> >>>>     map<object_t,vector<ObjectExtent> > object_extents;
> >>>>     Striper::file_to_extents(cct, m_image_ctx.format_string,
> >>>>                              &m_image_ctx.layout, off, read_len, 0,
> >>>>                              object_extents, 0);
> >>>>
> >>>>     // get snap info for each object
> >>>>     for (map<object_t,vector<ObjectExtent> >::iterator p =3D
> >>>>            object_extents.begin();
> >>>>          p !=3D object_extents.end(); ++p)
> >>> [...]
> >>>>           for (std::vector<ObjectExtent>::iterator q =3D p->second.b=
egin();
> >>>>                q !=3D p->second.end(); ++q) {
> >>>>             r =3D m_callback(off + q->offset, q->length, updated, m_=
callback_arg);
> >>> [...]
> >>>>           }
> >>> [...]
> >>>>     }
> >>>>>     left -=3D read_len;
> >>>>     off +=3D read_len;
> >>>>   }
> >>>
> >>> So that iterates over the whole image (in our case, because m_offset =
is
> >>> 0 and m_length is the image length), then picks out a chunk of read_l=
en
> >>> length, converts that to objects, and then iterates over all of those
> >>> objects and all of their extents.
> >>>
> >>> file_to_extents looks like it=E2=80=99s just an arithmetic operation.=
  So it
> >>> doesn=E2=80=98t look like that function returns extents in multiple s=
napshots.
> >>> It just converts a range into subranges called =E2=80=9Cobjects=E2=80=
=9D and =E2=80=9Cextents=E2=80=9D
> >>> (at least that=E2=80=99s the way it looks to me).
> >>>
> >>> So overall, this looks awfully like it simply iterates over the whole
> >>> image and then returns allocation information gathered as a top-down
> >>> view through all of the snapshots, but not for each snapshot individu=
ally.
> >>
> >> Sorry, you're correct. The API function was originally designed to
> >> support delta extents for supporting diff exports, so while it does
> >> open each snapshot's object-map, it only returns a unioned set of
> >> delta extents. The rbd CLI's "disk-usage" action behaves how I
> >> described by counting the actual dirty block usage between snapshots.
> >
> > Max, Jason, thanks for the details!
> >
> > If you agree, I'll try to implement something similar, iterating on all
> > snapshots.
>
> Yes, that should work.
>
> > What about metadata?
> > I saw some APIs (e.g. rbd_metadata_list()) that allow us to get the met=
adata.
> > An idea could be to iterate over them and sum the keys-values size retu=
rned,
> > but I'm not sure they are returned in the same format as they are store=
d.
>
> I wouldn=E2=80=99t mind ignoring metadata too much.  If you can get somet=
hing to
> work, even better, but I don=E2=80=99t consider that too important.

I don't think it's a good idea to attempt to estimate it. If there is
enough desire, we can always add a supported "disk-usage" API method
that takes into account things like the image metadata, object-map,
journaling, etc overhead. However, I wouldn't expect it to be anywhere
near the actual block usage (unless something has gone terribly wrong
w/ journaling and it fails to trim your log).

> Max
>


--=20
Jason

