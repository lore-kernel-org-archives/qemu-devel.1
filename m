Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B28C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4DD20B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4DD20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufPd-0008CM-9N
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58054)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hufOp-000799-6S
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hufOn-0002EW-Gt
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:59:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hufOl-0002DP-5B; Mon, 05 Aug 2019 11:59:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B29C88305;
 Mon,  5 Aug 2019 15:59:46 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE4AF10016EA;
 Mon,  5 Aug 2019 15:59:42 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190805113526.20319-1-mreitz@redhat.com>
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
Message-ID: <69aa0fe6-66d7-f486-ee40-fc8434c413fe@redhat.com>
Date: Mon, 5 Aug 2019 17:59:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805113526.20319-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Eck2nqLS3DDTwCeEJsFdpkn41GKBrOEaC"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 05 Aug 2019 15:59:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Test unaligned blocking mirror
 write
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Eck2nqLS3DDTwCeEJsFdpkn41GKBrOEaC
Content-Type: multipart/mixed; boundary="cyiO8ApHjG8AzGKTmpdKPLnv91RMBPuj7";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <69aa0fe6-66d7-f486-ee40-fc8434c413fe@redhat.com>
Subject: Re: [PATCH] iotests: Test unaligned blocking mirror write
References: <20190805113526.20319-1-mreitz@redhat.com>
In-Reply-To: <20190805113526.20319-1-mreitz@redhat.com>

--cyiO8ApHjG8AzGKTmpdKPLnv91RMBPuj7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.08.19 13:35, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Hi, this is a test for the mirror bug Vladimir found.  Naturally, it
> depends on some patch to fix it.
>=20
> Based-on: <20190802185830.74648-1-vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/151     | 25 +++++++++++++++++++++++++
>  tests/qemu-iotests/151.out |  4 ++--
>  2 files changed, 27 insertions(+), 2 deletions(-)

Thanks for the review, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--cyiO8ApHjG8AzGKTmpdKPLnv91RMBPuj7--

--Eck2nqLS3DDTwCeEJsFdpkn41GKBrOEaC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1IUm0ACgkQ9AfbAGHV
z0A5pwgAtfXz+s0Su6aZQzmOQgzMFmjZIOXGrw6ukAo4Xj54tug9Tj8EuKJvhal7
uR/8pmqHxMEHkNGzCMZv+pnbCumXyKnu8FFyMTX/khx8zU1sQGOkgjNsFNuT7H3T
9P1Vvj9QBaw40Q/L84np9GS2M0hEG7dNL7BRrlvHD9BvBUGONoJIvscrC/dQMbf0
ozha3YimckaMaRv/mG3eR1m0PjwCywQ5n/chalMi8o0ruvGje0677TajnEZVw0m1
6dXCSjWi+1hWQzDNrWlUva7DxHnCaw00f4OlUJAMZ/My0G5QugojhwOy8ZefPz55
vqIkoTQlOKj9eBQr5oQpNzftB3C8EA==
=ecvG
-----END PGP SIGNATURE-----

--Eck2nqLS3DDTwCeEJsFdpkn41GKBrOEaC--

