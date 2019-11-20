Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BABDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1720F224D2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GS6ZZZ9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1720F224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQ6C-0001YS-HT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXQ4S-0007wu-4O
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXQ4Q-0000EN-Bo
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:31:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXQ4Q-0000EE-83
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574256657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yoT7lzIsTqXewbywSEzVHlQhe1H3+MxEgKvTcXpLro=;
 b=GS6ZZZ9g84YAKyAfs56P8p6+ZykSVQ3VZkzdQAdneZx+HF4JJ8hMt8eZpwhwyXyZMqF0Q9
 sgWI5O0N5y481sVYYSc0d89LA7T0t8GMAOR6gaflv1TgYXwAVUpNvvuHAchf/sgmRqzIQZ
 Tf1/FfRYIJ++XTMthsNLKxGxpm+jhQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-RWE7qR7oN76a7Vh62BxNPA-1; Wed, 20 Nov 2019 08:30:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FBBCDB6D;
 Wed, 20 Nov 2019 13:30:53 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1CAC1077D85;
 Wed, 20 Nov 2019 13:30:48 +0000 (UTC)
Date: Wed, 20 Nov 2019 14:30:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Message-ID: <20191120133047.GC5779@linux.fritz.box>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <7f8574a2-8fd2-9724-a197-d67d3c69d538@virtuozzo.com>
 <20191120114408.GA5779@linux.fritz.box>
 <abb27eb4-1b1d-39b4-3867-b6ade59884d0@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <abb27eb4-1b1d-39b4-3867-b6ade59884d0@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: RWE7qR7oN76a7Vh62BxNPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.11.2019 um 13:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 20.11.2019 14:44, Kevin Wolf wrote:
> > Am 20.11.2019 um 11:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 16.11.2019 19:34, Vladimir Sementsov-Ogievskiy wrote:
> >>> Hi all!
> >>>
> >>> I wanted to understand, what is the real difference between bdrv_bloc=
k_status_above
> >>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work=
 through
> >>> bdrv_block_status_above..
> >>>
> >>> And I found the problem: bdrv_is_allocated_above considers space afte=
r EOF as
> >>> UNALLOCATED for intermediate nodes..
> >>>
> >>> UNALLOCATED is not about allocation at fs level, but about should we =
go to backing or
> >>> not.. And it seems incorrect for me, as in case of short backing file=
, we'll read
> >>> zeroes after EOF, instead of going further by backing chain.
> >>>
> >>> This leads to the following effect:
> >>>
> >>> ./qemu-img create -f qcow2 base.qcow2 2M
> >>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
> >>>
> >>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
> >>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
> >>>
> >>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes=
:
> >>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
> >>> read 1048576/1048576 bytes at offset 1048576
> >>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
> >>>
> >>> But after commit guest visible state is changed, which seems wrong fo=
r me:
> >>> ./qemu-img commit top.qcow2 -b mid.qcow2
> >>>
> >>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
> >>> Pattern verification failed at offset 1048576, 1048576 bytes
> >>> read 1048576/1048576 bytes at offset 1048576
> >>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
> >>>
> >>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
> >>> read 1048576/1048576 bytes at offset 1048576
> >>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
> >>>
> >>>
> >>> I don't know, is it a real bug, as I don't know, do we support backin=
g file larger than
> >>> its parent. Still, I'm not sure that this behavior of bdrv_is_allocat=
ed_above don't lead
> >>> to other problems.
> >>>
> >>> =3D=3D=3D=3D=3D
> >>>
> >>> Hmm, bdrv_block_allocated_above behaves strange too:
> >>>
> >>> with want_zero=3Dtrue, it may report unallocated zeroes because of sh=
ort backing files, which
> >>> are actually "allocated" in POV of backing chains. But I see this may=
 influence only
> >>> qemu-img compare, and I don't see can it trigger some bug..
> >>>
> >>> with want_zero=3Dfalse, it may do no progress because of short backin=
g file. Moreover it may
> >>> report EOF in the middle!! But want_zero=3Dfalse used only in bdrv_is=
_allocated, which considers
> >>> onlyt top layer, so it seems OK.
> >>>
> >>> =3D=3D=3D=3D=3D
> >>>
> >>> So, I propose these series, still I'm not sure is there a real bug.
> >>>
> >>> Vladimir Sementsov-Ogievskiy (4):
> >>>     block/io: fix bdrv_co_block_status_above
> >>>     block/io: bdrv_common_block_status_above: support include_base
> >>>     block/io: bdrv_common_block_status_above: support bs =3D=3D base
> >>>     block/io: fix bdrv_is_allocated_above
> >>>
> >>>    block/io.c                 | 104 ++++++++++++++++++---------------=
----
> >>>    tests/qemu-iotests/154.out |   4 +-
> >>>    2 files changed, 53 insertions(+), 55 deletions(-)
> >>>
> >>
> >>
> >> Interesting that the problem illustrated here is not fixed by the seri=
es, it's actually
> >> relates to the fact that mirror does truncation with PREALLOC_MODE_OFF=
, which leads
> >> to unallocated qcow2 clusters, which I think should be fixed too.
> >=20
> > Yes, this is what I posted yesterday. (With a suggested quick fix, but
> > it turns out it was not quite correct, see below.)
> >=20
> >> To illustrate the problem fixed by the series, we should commit to bas=
e:
> >>
> >> # ./qemu-img commit top.qcow2 -b base.qcow2
> >> Image committed.
> >> # ./qemu-io -c "read -P 0 1M 1M" base.qcow2
> >> Pattern verification failed at offset 1048576, 1048576 bytes
> >> read 1048576/1048576 bytes at offset 1048576
> >> 1 MiB, 1 ops; 00.00 sec (5.366 GiB/sec and 5494.4149 ops/sec)
> >=20
> > Ok, I'll try that later.
> >=20
> >> Hmm, but how to fix the problem about truncate? I think truncate must
> >> not make underlying backing available for read.. Discard operation
> >> doesn't do it.
> >>
> >> So, actually on PREALLOC_MODE_OFF we must allocated L2 tables and mark
> >> new clusters as ZERO?
> >=20
> > Yes, we need to write zeroes to the new area if the backing file covers
> > it. We need to do this not only in mirror/commit/bdrv_commit(), but in
> > fact for all truncate operations: Berto mentioned on IRC yesterday that
> > you can get into the same situation with 'block_resize' monitor
> > commands.
> >=20
> > So I tried to fix this yesterday, and I thought that I had a fix, when =
I
> > noticed that bdrv_co_do_zero_pwritev() takes a 32 bit bytes parameter.
> > So I'll still need to fix this. Other than that, I suppose the followin=
g
> > fix should work (but is probably a bit too invasive for -rc3).
> >=20
> > Kevin
> >=20
> > diff --git a/block/io.c b/block/io.c
> > index f75777f5ea..4118bf0118 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -3382,6 +3382,32 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *chi=
ld, int64_t offset, bool exact,
> >           goto out;
> >       }
> >=20
> > +    /*
> > +     * If the image has a backing file that is large enough that it wo=
uld
> > +     * provide data for the new area, we cannot leave it unallocated b=
ecause
> > +     * then the backing file content would become visible. Instead, ze=
ro-fill
> > +     * the area where backing file and new area overlap.
> > +     */
> > +    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF)=
 {
> > +        int64_t backing_len;
> > +
> > +        backing_len =3D bdrv_getlength(backing_bs(bs));
> > +        if (backing_len < 0) {
> > +            ret =3D backing_len;
> > +            goto out;
> > +        }
> > +
> > +        if (backing_len > old_size) {
> > +            /* FIXME bytes parameter is 32 bits */
> > +            ret =3D bdrv_co_do_zero_pwritev(child, old_size,
> > +                                          MIN(new_bytes, backing_len -=
 old_size),
> > +                                          BDRV_REQ_ZERO_WRITE | BDRV_R=
EQ_MAY_UNMAP, &req);
> > +            if (ret < 0) {
> > +                goto out;
> > +            }
> > +        }
> > +    }
> > +
> >       ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
> >       if (ret < 0) {
> >           error_setg_errno(errp, -ret, "Could not refresh total sector =
count");
> >=20
>=20
> I'm not sure that it is safe enough: we may not have opened backing at
> the moment, but still it may exist and managed by user.

But then I think it's the user's responsibility to make sure that the
backing file still makes sense when they reattach it. You can't tell
QEMU that there is no backing file and then expect QEMU to take care of
your secret backing file.

Of course, we could unconditionally zero out the new area without
looking at the backing file, but I'm not sure if that is wanted.

> PREALLOC_MODE_OFF is documented as
> # @off: no preallocation
>=20
> - not very descriptive, but I think it's nothing about making backing fil=
e available
> through new clusters.
>=20
> I think PREALLOC_MODE_OFF should always make new clusters "BDRV_BLOCK_ALL=
OCATED". If
> for some scenarios (are they exist at all?) we need to preallocate cluste=
r in manner
> that backing file would be visible through them, we'd better add another =
preallocation
> mode which will directly document this behaviour, like PREALLOC_MODE_BACK=
ING.
>=20
> So, I'd consider PREALLOC_MODE_OFF as something that must not create UNAL=
LOCATED (in POV
> of backing chains) clusters, and should be fixed in all formats.. Or as a=
 quick fix may
> we may write zeros from bdrv_co_truncate, but independently of backing fi=
le existence
> and length.

No, that would mean that all images must be preallocated because
BDRV_BLOCK_ALLOCATED isn't supposed to be set for sparse blocks.

Essentially, the mode that you're envisioning for it is the same as
PREALLOC_MODE_METADATA today (except that it would have to be supported
by every driver).

Obviously, that's wrong for PREALLOC_MODE_OFF.

> =3D=3D=3D
>=20
> Also I think it's a wrong thing at all that qcow2 new file is transparent=
 by default..
> It should be transparent only when we create snapshots and incremental ba=
ckups. But when
> we create new disk for new vm it should be zeroed (and extending L1 table=
 entry spec by
> "zero bit" may help)

Why would a qcow2 file even have a backing file when you don't want to
ever access the backing file? Create your image without a backing file
and you get the behaviour you want.

Kevin


