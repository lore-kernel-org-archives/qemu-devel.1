Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B615C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C4F208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C4F208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcu0K-0000AT-9q
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hctx1-0006GX-9j
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hctww-0006he-PV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:53:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hctwj-0006SO-W5; Mon, 17 Jun 2019 11:53:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8609A7EBAE;
 Mon, 17 Jun 2019 15:53:23 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 085811FE;
 Mon, 17 Jun 2019 15:53:16 +0000 (UTC)
Date: Mon, 17 Jun 2019 17:53:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190617155315.GK7397@linux.fritz.box>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
 <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 17 Jun 2019 15:53:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 4/7] block: introduce backup-top filter
 driver
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.06.2019 um 16:56 hat Max Reitz geschrieben:
> On 17.06.19 12:36, Vladimir Sementsov-Ogievskiy wrote:
> > 14.06.2019 23:03, Max Reitz wrote:
> >> On 14.06.19 18:22, Vladimir Sementsov-Ogievskiy wrote:
> >>> 14.06.2019 15:57, Max Reitz wrote:
> >>>> On 14.06.19 11:04, Vladimir Sementsov-Ogievskiy wrote:
> >>>>> 13.06.2019 18:57, Max Reitz wrote:
> >>>>>> On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
> >>>>>>> Backup-top filter does copy-before-write operation. It should be
> >>>>>>> inserted above active disk and has a target node for CBW, like the
> >>>>>>> following:
> >>>>>>>
> >>>>>>>        +-------+
> >>>>>>>        | Guest |
> >>>>>>>        +-------+
> >>>>>>>            |r,w
> >>>>>>>            v
> >>>>>>>        +------------+  target   +---------------+
> >>>>>>>        | backup_top |---------->| target(qcow2) |
> >>>>>>>        +------------+   CBW     +---------------+
> >>>>>>>            |
> >>>>>>> backing |r,w
> >>>>>>>            v
> >>>>>>>        +-------------+
> >>>>>>>        | Active disk |
> >>>>>>>        +-------------+
> >>>>>>>
> >>>>>>> The driver will be used in backup instead of write-notifiers.
> >>>>>>>
> >>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo=
=2Ecom>
> >>>>>>> ---
> >>>>>>>     block/backup-top.h  |  64 +++++++++
> >>>>>>>     block/backup-top.c  | 322 +++++++++++++++++++++++++++++++++++=
+++++++++
> >>>>>>>     block/Makefile.objs |   2 +
> >>>>>>>     3 files changed, 388 insertions(+)
> >>>>>>>     create mode 100644 block/backup-top.h
> >>>>>>>     create mode 100644 block/backup-top.c
> >>>>>>>
> >>>>>>> diff --git a/block/backup-top.h b/block/backup-top.h
> >>>>>>> new file mode 100644
> >>>>>>> index 0000000000..788e18c358
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/block/backup-top.h
> >>>>
> >>>> [...]
> >>>>
> >>>>>>> +/*
> >>>>>>> + * bdrv_backup_top_append
> >>>>>>> + *
> >>>>>>> + * Append backup_top filter node above @source node. @target nod=
e will receive
> >>>>>>> + * the data backed up during CBE operations. New filter together=
 with @target
> >>>>>>> + * node are attached to @source aio context.
> >>>>>>> + *
> >>>>>>> + * The resulting filter node is implicit.
> >>>>>>
> >>>>>> Why?  It=E2=80=99s just as easy for the caller to just make it imp=
licit if it
> >>>>>> should be.  (And usually the caller should decide that.)
> >>>>>
> >>>>> Personally, I don't know what are the reasons for filters to bi imp=
licit or not,
> >>>>> I just made it like other job-filters.. I can move making-implicit =
to the caller
> >>>>> or drop it at all (if it will work).
> >>>>
> >>>> Nodes are implicit if they haven=E2=80=99t been added consciously by=
 the user.
> >>>> A node added by a block job can be non-implicit, too, as mirror show=
s;
> >>>> If the user specifies the filter-node-name option, they will know ab=
out
> >>>> the node, thus it is no longer implicit.
> >>>>
> >>>> If the user doesn=E2=80=99t know about the node (they didn=E2=80=99t=
 give the
> >>>> filter-node-name option), the node is implicit.
> >>>>
> >>>
> >>> Ok, I understand it. But it doesn't show, why it should be implicit?
> >>> Isn't it less buggy to make all filters explicit? We don't hide impli=
cit nodes
> >>> from query-named-block-nodes (the only interface to explore the whole=
 graph for now)
> >>> anyway. And we can't absolutely hide side effects of additional node =
in the graph.
> >>
> >> Well, we try, at least.  At least we hide them from query-block.
> >>
> >>> So, is there any real benefit of supporting separation into implicit =
and explicit filters?
> >>> It seems for me that it only complicates things...
> >>> In other words, what will break if we make all filters explicit?
> >>
> >> The theory is that qemu may decide to add nodes at any point, but at
> >> least when managing chains etc., they may not be visible to the user. =
 I
> >> don=E2=80=99t think we can get rid of them so easily.

I think the important point to understand here is that implicit filters
are a concept to maintain compatibility with legacy (pre-blockdev)
management tools which simply don't manage stuff on the node level. So
changing the structure of the graph is not a problem for them and we
just need to make sure that when they do something with a BlockBackend,
we perform the action on the node that they actually mean.

Modern management tools are expected to manage the graph on a node level
and to assign node names to everything.

Note that libvirt is close to becoming a modern management tool, so it's
probably a good idea to now make all block jobs add filters where we'll
need them in the long run.

> >> One example that isn=E2=80=99t implemented yet is copy-on-read.  In th=
eory,
> >> specifying copy-on-read=3Don for -drive should create an implicit COR =
node
> >> on top.  The user shouldn=E2=80=99t see that node when inspecting the =
drive or
> >> when issuing block jobs on it, etc.  And this node has to stay there
> >> when the user does e.g. an active commit somewhere down the chain.
> >=20
> > Why instead not to just write in doc that yes, filter is created when y=
ou
> > enable copy-on-read?
>=20
> Because the problem is that existing users are not aware of that.
>=20
> If they were, they could simply create a COR filter already.
>=20
> I suppose we could interpret the deprecation policy in a way that we
> could change the behavior of -drive copy-on-read=3Don, but as I already
> said, what=E2=80=99s the point of supporting -drive copy-on-read=3Don, wh=
en you
> can simply explicitly create a COR filter on top?

I actually changed my opinion on how to do this since we introduced
implicit filters. I know think that the right way to move forward is to
make sure that the copy-on-read filter can do everything it needs to do,
and then just completely deprecate -drive copy-on-read=3Don instead of
adding compatibility magic to turn it into an implicit copy-on-read
filter internally.

> >> That sounds like a horrible ordeal to implement, so it hasn=E2=80=99t =
been done
> >> yet.  Maybe it never will.  It isn=E2=80=99t that bad for the job filt=
ers,
> >> because they generally freeze the block graph, so there is no problem
> >> with potential modifications.
> >>
> >> All in all I do think having implicit nodes makes sense.  Maybe not so
> >> much now, but in the future (if someone implements converting -drive C=
OR
> >> and throttle options to implicit nodes...).
> >=20
> > But do we have at least strong definition of how implicit nodes should =
behave
> > on any graph-modifying operations around them?
>=20
> No.  Depends on the node.
>=20
> > Should new implicit/explicit
> > filters be created above or under them?
>=20
> That was always the most difficult question we had when we introduced
> filters.
>=20
> The problem is that we never answered it in our code base.
>=20
> One day, we just added filters (=E2=80=9Clet=E2=80=99s see what happens=
=E2=80=9D), and in the
> beginning, they were all explicit, so we still didn=E2=80=99t have to ans=
wer
> this question (in code).  Then job filters were added, and we still
> didn=E2=80=99t have to, because they set blockers so the graph couldn=E2=
=80=99t be
> reorganized with them in place anyway.
>=20
> If we converted copy-on-read=3Don to a COR node, we would have to answer
> that question.

That's why we shouldn't do that, but just remove copy-on-read=3Don. :-)

> >>> But should really filter do that job, or it is here only to do CBW? M=
aybe target
> >>> must have another parent which will care about flushing.
> >>>
> >>> Ok, I think I'll flush target here too for safety, and leave a commen=
t, that something
> >>> smarter would be better.
> >>> (or, if we decide to flush all children by default in generic code, I=
'll drop this handler)
> >>
> >> [1] Thinking more about this, for normal backups the target file does
> >> not reflect a valid disk state until the backup is done; just like for
> >> qemu-img convert.  Just like qemu-img convert, there is therefore no
> >> reason to flush the target until the job is done.

Depends, the target could have the source as its backing file (like
fleecing, but without exporting it right now), and then you could always
have a consistent view on the target. Well, almost.

Almost because to guarantee this, we'd have to flush between each CBW
and the corresponding write to the same block, to make sure that the old
data is backed up before it is overwritten.

Of course, this would perform about as badly as internal COW in qcow2...
So probably not a guarantee we should be making by default. But it might
make sense as an option.

Kevin

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdB7drAAoJEH8JsnLIjy/WtSsP/jz4OMm72xg6M6FiWpl7p6Uz
DjkdFycIWq+NeGDXwZ1JHiMwzU8P7lgNLRX4PlPTHBeRc88JbmDpcAyWannx/o2h
VaF5zE6EOKrll76QKb+aIc7DDFP80J5DeSN4T/rBXXdQSu+fI6k7vOU0f82lwJS1
XR/EiBKefUTyxEwFuUUfJ104TUuxVFoEfcE+yqbBubCv+f8H1nEKwJCG+hUovq43
Hfpnw43e3hYmd4hd7ave/sglAzu+GDjLiDmioufSGgAsRJmKsNw/wt8R9jWge5PC
LhBBAh9muPvIoYqtgV9F5m7YVu0koFDANcUK08yCaJ9fNhr8OWfDAv/ISgsXxU9T
mzRMCsHPCKHrI6jkxAPKbB8EA1lG0z1SIEqWRoTIO3NJvRCTT127E5Grh71NVNhx
7XXsNL8c/2MdO68weXyK2Hcjhq/1RSWKHbo7XqegZ+R9KoW6+trq/FtSivAFQStO
/fzM8tF+pBVhitj6oKDBEWL29Fs3TOnjw+T0xFwvLRYbVPEJAzbQNpM+K7K8ia2E
TTZIZuoMTlARjgJjFiQ0nn1GeUHtyD5BYBkj2dKY5VwmMuxtKBLDckItpcmJYx2N
uhcXTbRFkGogA8A8Iyiw41Ve2E1BwiCT0/qz9CK+1rnBbwl/QjK4qgfsLSKIjMna
pYnDEpyXiGRV2iE8GeoH
=W9ck
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--

