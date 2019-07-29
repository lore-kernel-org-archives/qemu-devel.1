Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E06C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0EC2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0EC2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7ds-0002hP-NT
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45314)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hs7VT-0003Vm-1V
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hs7VR-00061f-U8
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:24:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hs7VP-0005xE-Jb; Mon, 29 Jul 2019 11:24:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 663EC58E23;
 Mon, 29 Jul 2019 15:24:06 +0000 (UTC)
Received: from localhost (ovpn-117-148.ams2.redhat.com [10.36.117.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 391A719C59;
 Mon, 29 Jul 2019 15:24:02 +0000 (UTC)
Date: Mon, 29 Jul 2019 16:24:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190729152400.GB21033@stefanha-x1.localdomain>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 29 Jul 2019 15:24:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for
 io
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is new parameter qiov_offset for io path, to avoid
> a lot of places with same pattern of creating local_qiov or hd_qiov
> variables.
>=20
> These series also includes my
> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
> with some changes [described in 01 and 03 emails]
>=20
> Vladimir Sementsov-Ogievskiy (12):
>   util/iov: introduce qemu_iovec_init_extended
>   util/iov: improve qemu_iovec_is_zero
>   block/io: refactor padding
>   block: define .*_part io handlers in BlockDriver
>   block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
>   block/io: bdrv_co_do_copy_on_readv: lazy allocation
>   block/io: bdrv_aligned_preadv: use and support qiov_offset
>   block/io: bdrv_aligned_pwritev: use and support qiov_offset
>   block/io: introduce bdrv_co_p{read,write}v_part
>   block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>   block/qcow2: implement .bdrv_co_preadv_part
>   block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>=20
>  block/qcow2.h             |   1 +
>  include/block/block_int.h |  21 ++
>  include/qemu/iov.h        |  10 +-
>  block/backup.c            |   2 +-
>  block/io.c                | 532 ++++++++++++++++++++++----------------
>  block/qcow2-cluster.c     |  14 +-
>  block/qcow2.c             | 131 +++++-----
>  qemu-img.c                |   4 +-
>  util/iov.c                | 153 +++++++++--
>  9 files changed, 559 insertions(+), 309 deletions(-)
>=20
> --=20
> 2.18.0

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/D5AACgkQnKSrs4Gr
c8gH6Qf+Odh7j1xA5FrRVYnfiLCNjhUcqva39NsGDWQfWQWU5J1OrOvzqzCrxsny
UOgMLm9ON1laNZ+/dHHO+BxGxDPYgMQg25ZsJPhB6xma+WhWhVgn0sVOVDT/eaXu
A2SSeXcyvyRHAuS+u1o3mTV3VYsoDWmnyKq8YOA0dvvz+49srQcM6G3fLnCjV99x
Im7paLhiouIzyKf2LVh6cutjH+zD3qUGba3wZAwF6JNVQ1iHmPpyQYk7EiklOP8i
5H2c6quzVp+Wfspo1C+vf97MmM/4fRsgSSOUlZdB9UqcPZhlIFDhiTp6FGftYLra
dkRXCCUB8rK9apCCcrkmZMad+vpGbA==
=4KuQ
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--

