Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40938C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19667205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19667205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUCs-0008FA-Dd
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxUCT-0007lE-1m
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxUCS-0004Lk-4m
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:38:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxUCP-0004KC-TI; Tue, 13 Aug 2019 06:38:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A28A3083362;
 Tue, 13 Aug 2019 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-18.ams2.redhat.com
 [10.36.117.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D05E526FDB;
 Tue, 13 Aug 2019 10:38:39 +0000 (UTC)
Date: Tue, 13 Aug 2019 12:38:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190813103838.GD4663@localhost.localdomain>
References: <20190725155512.9827-1-mreitz@redhat.com>
 <20190725155512.9827-4-mreitz@redhat.com>
 <627fbb64-5ffe-aca7-6198-9d991d4219e3@virtuozzo.com>
 <f50d585c-ac91-5dfa-365b-efda321aeffa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <f50d585c-ac91-5dfa-365b-efda321aeffa@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 13 Aug 2019 10:38:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] vpc: Do not return RAW from
 block_status
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.08.2019 um 17:56 hat Max Reitz geschrieben:
> On 12.08.19 17:33, Vladimir Sementsov-Ogievskiy wrote:
> > 25.07.2019 18:55, Max Reitz wrote:
> >> vpc is not really a passthrough driver, even when using the fixed
> >> subformat (where host and guest offsets are equal).  It should handle
> >> preallocation like all other drivers do, namely by returning
> >> DATA | RECURSE instead of RAW.
> >>
> >> There is no tangible difference but the fact that bdrv_is_allocated() =
no
> >> longer falls through to the protocol layer.
> >=20
> > Hmm. Isn't a real bug (fixed by this patch) ?
> >=20
> > Assume vpc->file is qcow2 with backing, which have "unallocated" region=
, which is
> > backed by actual data in backing file.
>=20
> Come on now.
>=20
> > So, this region will be reported as not allocated and will be skipped b=
y any copying
> > loop using block-status? Is it a bug of BDRV_BLOCK_RAW itself? Or I don=
't understand
> > something..
>=20
> I think what you don=E2=80=99t understand is that if you have a vpc file =
inside
> of a qcow2 file, you=E2=80=99re doing basically everything wrong. ;-)
>=20
> But maybe we should drop BDRV_BLOCK_RAW...  Does it do anything good for
> us in the raw driver?  Shouldn=E2=80=99t it too just return DATA | RECURS=
E?

DATA | RECURSE is still DATA, i.e. marks the block as allocated. If you
do that unconditionally, we will never consider a block unallocated.
RECURSE doesn't undo this, the only thing it might do is settting ZERO
additionally.

So I would say unconditionally returning DATA | RECURSE is almost always
wrong.

Kevin

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdUpMuAAoJEH8JsnLIjy/W2wUQAKzdZ8a35cChexaqjN77pm6D
DVBmVmBwEJI10l8eRh/UpXJJoTluVw7fkLeXc4siRehGj1eUbE3lMwTsw0sT5meN
nP/zCGU8dJ9Q7kGgQpNZOy6kLy/JSCg7HRDPrOybElMnDBHc8fCrY/YerrkjDoEF
9uhHGZy/LZrkzM8jH3mAw4SvkwkT4ZOFv7PTRvhtw+luhtDd3b5jX5nsUsjtViW2
GHNVQh9u1JmGBXXLdu6rlHVXoxqXuet/yMoN1HfSLqoWK2GKqLbfZSP4XBlL7xLm
z6NEYVIF3+XnSIuTAOjrGj+QR5j06j+kquhaOUP7gMTVKmEa44hDxWqaKjW8sAbH
C0cdhOmJsazOAU82UMrd377erzisIgm24tEzfbrl8H+MplZtC8EwXVQy0cLAOY+2
FhYhg4ovgj3LKHWiAzrwxfFyIwK7Fx4V9wjgd/4rL5jCPQ4g9Q/XATYz8HlnOfIk
Fo+pynuKU9sajRI/6FUmGchPaO4mOtVEGgeqGnlTH82I47oK9pbaK/2jFLX9IJpL
FqrxaTFMe+nJGrdsLwdftJqh8Qaykl1ksJYoP95pJC+JOCkRhxuhbEIrEPqFOnPt
B3Hv2654XsXCw2UNc37NFevkDMw8KcuXoGSLxqxYv5ODj68wDdsJuZSmfCrw8boU
Q42q9FcEnEoQjBIKCObD
=EuU7
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

