Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B61C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8932067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8932067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dhj-0000Y8-S5
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7dc0-0003zv-Hz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7dbz-0003sm-9X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7dbw-0003r0-B9; Tue, 10 Sep 2019 06:43:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D5A030ADBCB;
 Tue, 10 Sep 2019 10:42:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3504C60BE2;
 Tue, 10 Sep 2019 10:42:52 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
References: <20190827185913.27427-1-nsoffer@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <2db5f966-6de7-a9c0-18bb-193325e99d64@redhat.com>
Date: Tue, 10 Sep 2019 12:42:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827185913.27427-1-nsoffer@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VO97rCXxVpvJvfPcmIHFA16GJROj9CULm"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 10 Sep 2019 10:42:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Alignment checks cleanup
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VO97rCXxVpvJvfPcmIHFA16GJROj9CULm
Content-Type: multipart/mixed; boundary="9dtgCOcxisJpmuH7eKWagyPEBrwCqFVFF";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <2db5f966-6de7-a9c0-18bb-193325e99d64@redhat.com>
Subject: Re: [PATCH v2 0/2] Alignment checks cleanup
References: <20190827185913.27427-1-nsoffer@redhat.com>
In-Reply-To: <20190827185913.27427-1-nsoffer@redhat.com>

--9dtgCOcxisJpmuH7eKWagyPEBrwCqFVFF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.08.19 20:59, Nir Soffer wrote:
> While working on 4k support, I noticed that there is lot of code using
> BDRV_SECTOR_SIZE (512) for checking alignment. I wonder how this can wo=
rk with
> 4k storage.
>=20
> Lets start by cleaning up to make the code easier to understand:
> - Use QEMU_IS_ALIGNED macro to check alignment
> - Remove unneeded masks based on BDRV_SECTOR_SIZE
>=20
> Nir Soffer (2):
>   block: Use QEMU_IS_ALIGNED
>   block: Remove unused masks
>=20
>  block/bochs.c         | 4 ++--
>  block/cloop.c         | 4 ++--
>  block/dmg.c           | 4 ++--
>  block/io.c            | 8 ++++----
>  block/qcow2-cluster.c | 4 ++--
>  block/qcow2.c         | 4 ++--
>  block/vvfat.c         | 8 ++++----
>  include/block/block.h | 2 --
>  migration/block.c     | 2 +-
>  qemu-img.c            | 2 +-
>  10 files changed, 20 insertions(+), 22 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block


(I think you should check the setting of git config=E2=80=99s user.email =
in your
qemu directory.  Even if you send the patches through a gmail address
(which I don=E2=80=99t quite know why you=E2=80=99re doing that, but it i=
sn=E2=80=99t like that
really matters), the patches should then still contain a =E2=80=9CFrom: =E2=
=80=9D that
shows the actual author as set by user.name and user.email.)

Max


--9dtgCOcxisJpmuH7eKWagyPEBrwCqFVFF--

--VO97rCXxVpvJvfPcmIHFA16GJROj9CULm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13fioACgkQ9AfbAGHV
z0BAewf+I4BQg0RRnhsWDYU2csCh5iXdXMwUHZZ3h5UHqbAYNDh5fsDfV7bZxwII
bY/BqFq3RpTwLdpd1W2mwUd/Xh487yyzzrd80duZUy193HaE+j5I7PlACcnkFi+k
l6slybafUI43Nn5sPzg4f+EBReyxDLbqP6pa9O2X+xq/8SBuWtOPyiwzPjGLgTyA
LF34Ou/Ukyt9dJ0zLk194ESIL/b/V5OYKCQ6zF9rR3neMoyUKjfXCjq/BL+mwQMH
uk129yLkVob1P2svFrlvXFnOZFutAfzHMT9kyZLZI/P3fAopgdf0GQwXHexJUEQP
QlnA7gBhQQSSIJ/qmdfiAPuvpXPrAA==
=uMCH
-----END PGP SIGNATURE-----

--VO97rCXxVpvJvfPcmIHFA16GJROj9CULm--

