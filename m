Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A35C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451EA205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451EA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYw9-00031X-Jp
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51472)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxYvf-0002X2-MA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxYve-0006cK-CL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:41:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxYvb-0006Yw-Q4; Tue, 13 Aug 2019 11:41:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9851314AFBE;
 Tue, 13 Aug 2019 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-18.ams2.redhat.com
 [10.36.117.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC928D66F;
 Tue, 13 Aug 2019 15:41:23 +0000 (UTC)
Date: Tue, 13 Aug 2019 17:41:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190813154122.GL4663@localhost.localdomain>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 13 Aug 2019 15:41:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.08.2019 um 16:43 hat Max Reitz geschrieben:
> On 13.08.19 13:04, Kevin Wolf wrote:
> > Am 12.08.2019 um 20:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> BDRV_BLOCK_RAW makes generic bdrv_co_block_status to fallthrough to
> >> returned file. But is it correct behavior at all? If returned file
> >> itself has a backing file, we may report as totally unallocated and
> >> area which actually has data in bottom backing file.
> >>
> >> So, mirroring of qcow2 under raw-format is broken. Which is illustrated
> >> by following commit with a test. Let's make raw-format behave more
> >> correctly returning BDRV_BLOCK_DATA.
> >>
> >> Suggested-by: Max Reitz <mreitz@redhat.com>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >=20
> > After some reading, I think I came to the conclusion that RAW is the
> > correct thing to do. There is indeed a problem, but this patch is trying
> > to fix it in the wrong place.
> >=20
> > In the case where the backing file contains some data, and we have a
> > 'raw' node above the qcow2 overlay node, the content of the respective
> > block is not defined by the queried backing file layer, so it is
> > completely correct that bdrv_is_allocated() returns false,like it would
> > if you queried the qcow2 layer directly.
>=20
> I disagree.  The queried backing file layer is the raw node.  As I said,
> in my opinion raw nodes are not filter nodes, neither in behavior (they
> have an offset option), nor in how they are generally used (as a format).
>=20
> The raw format does not support backing files.  Therefore, everything on
> a raw node is allocated.
>=20
> (That is, like, my opinion.)
>=20
> >                                          If it returned true, we would
> > copy everything, which isn't right either (the test cases should may add
> > the qemu-img map output of the target so this becomes visible).
>=20
> It is right.

So we don't even agree what mirroring the raw node should even mean.

I can the see your point when you say that the raw node has no backing
file, so everything should be copied. But I can also see the point that
the raw node can really just be used as a filter that limits the data
exposed from the qcow2 layer, and you want to keep the copy a COW
overlay over the same backing file.

Both are valid use cases in principle and there is no single right or
wrong.

We don't currently support the latter use case because we have only
sync=3Dfull or sync=3Dtop, but if you could specify a base node instead, we
could probably suport the case without all of the special-casing filter
nodes and backing file childs.

You would call bdrv_co_block_status_above() with the right base node and
it would just recurse whereever the data is stored, be it bs->backing,
bs->file or even driver-specific children. This would allow you to find
out whether some block in the top node came from the base node that
we're going to keep. If yes, skip it; if no, copy it.

This way we wouldn't have to decide whether raw is a filter or not,
because it wouldn't make a difference. The behaviour would only depend
on the base node given by the user. If you specified the top-level qcow2
file as the base, you get your full copy; if you specified the backing
qcow2, you get the partial copy where the target still uses the same
backing file.

(Hm... It would only actually work if the offsets stay the same in the
chain, which is true for backing file children, but not necessarily for
other children. Anyway, even if we don't gain much functionality, I
really want a more generic model that avoids different types of nodes
and edges as much as possible.)

Kevin

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdUtoiAAoJEH8JsnLIjy/Wsn4QAJt06Q3wP9SiFBhGiy3gVk4N
aY0YCviVAm6wxkXMEq+0J4p/UOUzOv3wMvGvZfBK056dV9jMMTmW7/SxQoy62QEq
2LHa8Bve0CJijMoSnXwtlhiEzwFtzzLkwUy78paAl5ejpxXC0z1YWjMkT5KgWF57
p56ldRZJ/QsBfFk5WbmPlo/q0vlOlopLseuz+eE+Lzrhw9HTqEOxaTLrAnxZKleR
B7yZzScN3cabJk3SlRqn85QIiURurR6EBW8D7uQP68TZMV1bjo1rnKe/DVRWwdip
9GtQoYm8Af6HoUbz50no7HFP4FxsQP063D/jysuwwGQp7iZQ+XR40fWzGOzDaDk0
zDmzJ92mqzYFrA5COxrTHPpEZ9dzY+Xy4n3h3VAVo3BFKCH4KXJNPQLA0d0/1rJY
LSd4bxWjle1MvRBxFRZf+pD/3iBVWUXD2gs8+SLPXDKApQKaUGFWgYh3HjpeBwZh
7MjJ9cru5neIg/mpmtG20lwj3tV5I7UgZ3gywTwx74rq1hKmtiL0MVgjQoQUNDNT
or2DvH2F1gZjdc6k5u0mq2XclmlkkAP2SeI7EYB9gCqcn3LLYlH1h52gL7HdQHiz
Bh4FPOz1Gp3IsjUBoxxI+aXCFJChl/f7n86JBsVyz5wCK/2h9EdU7gSeH3V9I6fm
xSpR6hEpLPuwnmknuyNr
=VYsH
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--

