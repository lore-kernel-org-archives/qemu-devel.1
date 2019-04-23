Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DFBC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBAB20645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBAB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53729 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIvKU-0005GG-Bx
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 09:19:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIvId-00047w-6M
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIv8C-0006Ng-Kj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:06:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hIv8B-0006LX-Hg; Tue, 23 Apr 2019 09:06:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 490DF306DBBB;
	Tue, 23 Apr 2019 13:06:33 +0000 (UTC)
Received: from localhost (ovpn-117-214.ams2.redhat.com [10.36.117.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C5875D719;
	Tue, 23 Apr 2019 13:06:30 +0000 (UTC)
Date: Tue, 23 Apr 2019 14:06:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190423130629.GH32465@stefanha-x1.localdomain>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 23 Apr 2019 13:06:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423130629.rxaCnSQOdFTJLZzlx3Y_z511sapAbTU7fxokGYPvf_E@z>


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 05:58:29PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> We often need to do read/write with buffer, not qiov. Instead of
> creating qiov in such cases, let's introduce corresponding helpers.
>=20
> Vladimir Sementsov-Ogievskiy (9):
>   block: introduce byte-based io helpers
>   block/qcow2: use buffer-based io
>   block/qcow: use buffer-based io
>   block/qed: use buffer-based io
>   block/parallels: use buffer-based io
>   block/backup: use buffer-based io
>   block/commit: use buffer-based io
>   block/stream: use buffer-based io
>   qemu-img: use buffer-based io
>=20
>  include/block/block_int.h      | 16 ++++++++++++++++
>  include/sysemu/block-backend.h | 19 +++++++++++++++++++
>  block/backup.c                 | 14 ++++++--------
>  block/commit.c                 |  5 ++---
>  block/parallels.c              | 14 ++++++--------
>  block/qcow.c                   | 19 ++++++-------------
>  block/qcow2.c                  |  9 ++-------
>  block/qed-table.c              | 12 +++++-------
>  block/qed.c                    |  6 ++----
>  block/stream.c                 |  4 +---
>  qemu-img.c                     | 13 ++++---------
>  11 files changed, 69 insertions(+), 62 deletions(-)
>=20
> --=20
> 2.18.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvw3VAAoJEJykq7OBq3PIFY8H/A73AZiHbd62zm2MUtDfXHM3
iotFiJjIactAxvbDCxS8gcWJMsfOheqlluqPLw86zTExcGVhfCSoYm1oZSPYp1d6
b/4SnO9JcNjbNQg+JzuLbBD2FnQNQUcjZMnfZtEUORHqfykxxLRwZ3kRqnw1SkTD
NCZxT4knowSzgpPYR42bGRT91poDGCEshXLKi3DsKVdZxLpfxsgh2suF8VptKjim
YTUMkrxPGZKYILwBRK/SLQyQaa53P2xTDRde/SfGObcovZGPX720D4cb8g/OAYd7
eM4cIzxpBhQi4iUvOws5J3rE1wMUcRJRa2Ev6AOZ1NMQcv+Lm/15zUCIi/aAEE4=
=hXVO
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--

