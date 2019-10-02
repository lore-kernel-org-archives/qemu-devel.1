Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8DC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2DE21783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2DE21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfnp-00019r-2x
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFfn2-0000gS-U7
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFfn0-0000C6-Tm
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:39:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFfmx-000089-Vh; Wed, 02 Oct 2019 10:39:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5414130860D5;
 Wed,  2 Oct 2019 14:39:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B3CB1001B22;
 Wed,  2 Oct 2019 14:39:32 +0000 (UTC)
Subject: Re: [PATCH] iotests: Do not run the iotests during "make check"
 anymore
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20191002142146.6124-1-thuth@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <725c14db-2ab7-5ac5-d47d-42d0104b7d93@redhat.com>
Date: Wed, 2 Oct 2019 16:39:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002142146.6124-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l4N6glCTgdllF8BYSxwuE3wP1PFdYjtH6"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 02 Oct 2019 14:39:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l4N6glCTgdllF8BYSxwuE3wP1PFdYjtH6
Content-Type: multipart/mixed; boundary="Xv17nQ5i9ZLNt2lMKQBCo3U8X7bzDeJaQ"

--Xv17nQ5i9ZLNt2lMKQBCo3U8X7bzDeJaQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.10.19 16:21, Thomas Huth wrote:
> Running the iotests during "make check" is causing more headaches than
> benefits for the block layer maintainers, so let's disable the iotests
> during "make check" again.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include   | 2 +-
>  tests/qemu-iotests/group | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

I=E2=80=99ll leave this patch on the list for a while so that others can =
speak
up if they disagree.

The problem is that this causes headaches of rather high importance
(make check), and I have to deal with them.  I=E2=80=99ll gladly accept h=
elp in
dealing with them, but without such help, I don=E2=80=99t feel like it=E2=
=80=99s worth it.

As far as I=E2=80=99m aware, the plan is to still the iotests in e.g. Tra=
vis,
and maybe even more thoroughly then (because we won=E2=80=99t be as const=
rained
by the test duration), just not in make check.

Max


--Xv17nQ5i9ZLNt2lMKQBCo3U8X7bzDeJaQ--

--l4N6glCTgdllF8BYSxwuE3wP1PFdYjtH6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2UtqMACgkQ9AfbAGHV
z0DNeAgAmJjGRuhJt1wjLD4d3gqAG1X8408Qa5F2zwlCI4KiI5UyL9jyv1iZUoZX
+hlt9w9ymm75NgqrR8JI2pGiBNub8E9PpZDtrxzbnxJJlXDLW1s+tQvzsUcN3Kjv
ThtSNVzpfkSeS0W1u40mZaDVY2Cqdy0+qHcbfMyVhnIGvR66zGK4PKHJhP3Pz2rN
a7HZcDZWGcUDSxZ7pZE0Nr9aX7AfVoi0LUu9hhxy0Moe96DjXifREPFwkFYIaMnd
FOGUeLJCYgWQDo9KQTri/aMdIhPYvpA7SQ8s0RacWamVBGO1txFk0D8LJjhlrhJ8
Uj7e5TZfwPVvU09Qq8Fw0YCjcdiTGA==
=z+Bt
-----END PGP SIGNATURE-----

--l4N6glCTgdllF8BYSxwuE3wP1PFdYjtH6--

