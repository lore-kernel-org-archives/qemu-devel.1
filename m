Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986C2ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707A1222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707A1222BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wjn-0000c3-5W
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7wXJ-0004Zr-9f
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7wXH-00076T-QE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7wXB-000744-Qb; Wed, 11 Sep 2019 02:55:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4ED903C93A;
 Wed, 11 Sep 2019 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-182.ams2.redhat.com
 [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4652E60BF7;
 Wed, 11 Sep 2019 06:55:19 +0000 (UTC)
Date: Wed, 11 Sep 2019 08:55:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190911065517.GA4907@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 11 Sep 2019 06:55:20 +0000 (UTC)
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


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.09.2019 um 08:20 hat Max Reitz geschrieben:
> On 10.09.19 16:52, Kevin Wolf wrote:
> > Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >> If the driver does not implement bdrv_get_allocated_file_size(), we
> >> should fall back to cumulating the allocated size of all non-COW
> >> children instead of just bs->file.
> >>
> >> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >=20
> > This smells like an overgeneralisation, but if we want to count all vmdk
> > extents, the qcow2 external data file, etc. it's an improvement anyway.
> > A driver that has a child that should not be counted must just remember
> > to implement the callback.
> >=20
> > Let me think of an example... How about quorum, for a change? :-)
> > Or the second blkverify child.
> >=20
> > Or eventually the block job filter nodes.
>=20
> I actually think it makes sense for all of these nodes to report the sum
> of all of their children=E2=80=99s allocated sizes.

Hm... Yes, in a way. But not much more than it would make sense to
report the sum of the sizes of all images in the whole backing chain
(this is a useful thing to ask for, just maybe not the right thing to
return for a low-level interface). But I can accept that it's maybe a
bit more expected for quorum and blkverify than for COW images.

If you include the block job filter nodes, I have to disagree, though.
If mirror_top_bs (or any other job filter) sits in the middle of the
source chain, then I certainly don't want to see the target size added
to it.

> If a quorum node has three children with allocated sizes of 3 MB, 1 MB,
> and 2 MB, respectively (totally possible if some have explicit zeroes
> and others don=E2=80=99t; it may also depend on the protocol, the filesys=
tem,
> etc.), then I think it makes most sense to report indeed 6 MB for the
> quorum subtree as a whole.  What would you report?  3 MB?

Do it's the quorum way: Just vote!

No, you're right, of course. -ENOTSUP is probably the only other thing
you could do then.

> > Ehm... Maybe I should just take back what I said first. It almost feels
> > like it would be better if qcow2 and vmdk explicitly used a handler that
> > counts all children (could still be a generic one in block.c) rather
> > than having to remember to disable the functionality everywhere where we
> > don't want to have it.
>=20
> I don=E2=80=99t, because everywhere we don=E2=80=99t want this functional=
ity, we still
> need to choose a child.  This has to be done by the driver anyway.

Well, by default the primary child, which should cover like 90% of the
drivers?

Kevin

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdeJpVAAoJEH8JsnLIjy/Wip4P/2GJ1n7XDgOe6NwbO9OZA1ro
DR/FQ9f2OW5GvU0IJ29Ojl0VPeC8rbOWy3sEZCD+XBJjka2C9QxImjHYu7IayZqm
NoKP1mbjMUTybMmU/TBoVNu8t+gMq1bpGKAOmZyJSXt3daAN7yYLj9NTlPCYrVGh
hRNHWSs2Qc4PrRYlUk93ZCAVXYAhxlPoJGqjlDLGRb0BFlLcL9KRvEZDfdyE35KH
qIUcy5t1i0bhzDNzUKVLzc7294MYc84oRqfZrwYeFPONZth8cmNL0oT+duLmC6CN
V8D/SNsK6ZT2kyTucdi7S1qhfXSgv075Q01uYQ8yjxnNRmRheMA31JY2xxwfLnDR
CRl/PXnOFoCUJ9IAbnCU0+TmSS9ZcMWeLm2Q74Xjk+fm5iqLvUrbl8mXlhMGy8LE
S4PaZKSdsUJJni7/Lq9mA7gY2n9G61kkecuHmtXKm5llwoQy0budP4htXDNdYgpA
kHzKknC3MY/aZHtmvoyIiyD+wZIxDAcq8+pvXTnSegJx8CedyUuA5D7aRy81VJGw
f+pZpex3+j9kPry5G/7WWNDCDM8JEbB8fF8vthA/0Kv59VHA65FqpF1H+hCw2HhB
1YJ9bgUkZ6cpWl2Fk4Q4yc+9DMqJPHd5Wy+XrqX2odmfcDW4tZHn2sJ7uGJTgltg
rMHOlD7r+ZXKKrUHViTI
=IXWu
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

