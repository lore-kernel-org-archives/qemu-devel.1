Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D9EECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CDF2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CDF2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ydL-0000Lo-D3
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7xyj-00031e-IN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7xyi-0007cr-1T
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:27:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7xyd-0007Z3-6Z; Wed, 11 Sep 2019 04:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30BF818CCEE8;
 Wed, 11 Sep 2019 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-182.ams2.redhat.com
 [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F30F860BEC;
 Wed, 11 Sep 2019 08:27:44 +0000 (UTC)
Date: Wed, 11 Sep 2019 10:27:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190911082743.GC4907@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
 <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 11 Sep 2019 08:27:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 22/42] block: Fix
 bdrv_get_allocated_file_size's fallback
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.09.2019 um 09:37 hat Max Reitz geschrieben:
> On 11.09.19 08:55, Kevin Wolf wrote:
> > Am 11.09.2019 um 08:20 hat Max Reitz geschrieben:
> >> On 10.09.19 16:52, Kevin Wolf wrote:
> >>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >>>> If the driver does not implement bdrv_get_allocated_file_size(), we
> >>>> should fall back to cumulating the allocated size of all non-COW
> >>>> children instead of just bs->file.
> >>>>
> >>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>
> >>> This smells like an overgeneralisation, but if we want to count all v=
mdk
> >>> extents, the qcow2 external data file, etc. it's an improvement anywa=
y.
> >>> A driver that has a child that should not be counted must just rememb=
er
> >>> to implement the callback.
> >>>
> >>> Let me think of an example... How about quorum, for a change? :-)
> >>> Or the second blkverify child.
> >>>
> >>> Or eventually the block job filter nodes.
> >>
> >> I actually think it makes sense for all of these nodes to report the s=
um
> >> of all of their children=E2=80=99s allocated sizes.
> >=20
> > Hm... Yes, in a way. But not much more than it would make sense to
> > report the sum of the sizes of all images in the whole backing chain
> > (this is a useful thing to ask for, just maybe not the right thing to
> > return for a low-level interface). But I can accept that it's maybe a
> > bit more expected for quorum and blkverify than for COW images.
> >=20
> > If you include the block job filter nodes, I have to disagree, though.
> > If mirror_top_bs (or any other job filter) sits in the middle of the
> > source chain, then I certainly don't want to see the target size added
> > to it.
>=20
> Hm, I don=E2=80=99t care much either way.  I think it makes complete sens=
e to
> add the target size there, but OTOH it=E2=80=99s only temporary while the=
 job
> runs, so it may be a bit confusing if it suddenly goes up and then down
> again.

I think the number that most users are interested in is knowing how much
space the image for their /dev/vda takes up on the host.

I can see how they might be interested in not only that one image file,
but all other image files connected to it, i.e. their /dev/vda with all
of its snapshots. This would mean counting backing files. I think adding
up the numbers for this should be done in the management layer.

I can possibly also imagine users wanting to count everything that's
even loosely connected to their /dev/vda, like copies of it. I doubt,
however, they want to count only copies that are currently being made,
but not snapshots and copies that have been completed earlier. So this
is clearly a management layer thing, too.

> But I think this is the special case, so this is what should be handled
> in a driver callback.

It's a special case, yes. But see below.

> >> If a quorum node has three children with allocated sizes of 3 MB, 1 MB,
> >> and 2 MB, respectively (totally possible if some have explicit zeroes
> >> and others don=E2=80=99t; it may also depend on the protocol, the file=
system,
> >> etc.), then I think it makes most sense to report indeed 6 MB for the
> >> quorum subtree as a whole.  What would you report?  3 MB?
> >=20
> > Do it's the quorum way: Just vote!
>=20
> Add an option for it?  Average, maximum, median, majority, sum? :-)

We could also introduce a mode with an Electoral College so that
sometimes an image that missed the majority has a chance to win anyway.

> > No, you're right, of course. -ENOTSUP is probably the only other thing
> > you could do then.
> >=20
> >>> Ehm... Maybe I should just take back what I said first. It almost fee=
ls
> >>> like it would be better if qcow2 and vmdk explicitly used a handler t=
hat
> >>> counts all children (could still be a generic one in block.c) rather
> >>> than having to remember to disable the functionality everywhere where=
 we
> >>> don't want to have it.
> >>
> >> I don=E2=80=99t, because everywhere we don=E2=80=99t want this functio=
nality, we still
> >> need to choose a child.  This has to be done by the driver anyway.
> >=20
> > Well, by default the primary child, which should cover like 90% of the
> > drivers?
>=20
> Hm, yes.
>=20
> But I still think that the drivers that do not want to count every
> single non-COW child are the exception.

They are, but drivers that want to count more than their primary node
are exceptions, too. And I think you're more likely to remember adding
the callback when you want to have a certain feature, not when you don't
want to have it.

I really think we're likely to forget adding the callback where we need
to disable the feature.

I can see two options that should address both of our views:

1. Just don't have a fallback at all, make the callback mandatory and
   provide implementations in block.c that can be referred to in
   BlockDriver. Not specifying the callback causes an assertion failure,
   so we'd hopefully notice it quite early (assuming that we run either
   'qemu-img info' or 'query-block' on a configuration with the block
   driver, but I think that's faily safe to assume).

2. Make the 90% solution a 100% solution: Allow drivers to have multiple
   storage children (for vmdk) and then have the fallback add up the
   primary child plus all storage children. This is what I suggested as
   the documented semantics in my initial reply to this patch (that you
   chose not to answer).

   Adding the size of storage children covers qcow2 and vmdk.

   As the job filter won't declare the target or any other involved
   nodes their storage nodes (I hope), this will do the right thing for
   them, too.

   For quorum and blkverify both ways could be justifiable. I think they
   probably shouldn't declare their children as storage nodes. They are
   more like filters that don't have a single filtered node. So some
   kind of almost-filters.

Kevin

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdeK//AAoJEH8JsnLIjy/WWvMQAJRmYRPWxzSNswQeBja4f41U
aNQWLi/UhAQQV4piehvYP3nlxSG+/eM/xrbdQG851kdL5y+4fQBxp+I4dCr+R080
qGW+5WC/8ng8GpWA2oNd54LOQizBu0XL3sGxZVyzaFNkPDwx3YoGsjfadgOSCl3y
BfiljDgtOK/wFd0ljxOMYKjPWhipi1OX6DSuuA8a86OILAs/uDfZhkYvrkDbldYx
+6miFo3/T6Zq6ICxkLvYizEkMeb2mGmUybdnwKkT/ctyWqjBm+t7XuLHy2IBITX/
PMCUicvmdk/KFY/P9PfH3ccZ5nCNPp5cZjd0r6/+3gdkusjnmxygMhIi/SK9JX1o
j7QpsDaMzAZMOG8TiBkroOz+pGZzWUy0TESa/i+ao4wkrpC9LUkeRlFiqy7yLRBd
p4PmB4V7wY5Z9ZZVfm4J0EGMw8aREvhg7mNFvnogzk2Gh+AB3bwhmEVj6Son9cCM
9r1BmebmUSA8G0mSwSMuMJbcDmqteVgxOmZ+Fy17u8jcq/Wy/YBLz+cITY6ByBBh
N1DVo/X5gRffBeRb0pU8vCY2k0gvwSPy8O22j+gwx43MUoT4jfFwCmQHzhFEsDzQ
s7bYl9L/904LcSki29ebviSJ0kHSKndjejueKKCkguknBpReFpFB+5WavpZgzgQX
PIBelBlGgvH06YMF3Szr
=rnC/
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

