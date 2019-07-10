Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A92AC74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712C02086D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 16:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712C02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlFRL-0000iZ-KX
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 12:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlFQT-0008HZ-5L
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlFQQ-0004dg-Fw
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 12:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56126)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlFQM-0004Oz-Qa; Wed, 10 Jul 2019 12:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D970C0733FB;
 Wed, 10 Jul 2019 16:26:25 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CCF1608A6;
 Wed, 10 Jul 2019 16:26:16 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-2-jsnow@redhat.com>
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
Message-ID: <71300a46-3bbd-7c6a-dd25-baf17364e07e@redhat.com>
Date: Wed, 10 Jul 2019 18:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190710010556.32365-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1obWltBLUt6XJH4OekukPBmTKzpKZDYBC"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 10 Jul 2019 16:26:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/8] iotests/257: add Pattern class
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1obWltBLUt6XJH4OekukPBmTKzpKZDYBC
Content-Type: multipart/mixed; boundary="InwhnsRdmaarXwNvnPaPiNIpwa8eCPynk";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <71300a46-3bbd-7c6a-dd25-baf17364e07e@redhat.com>
Subject: Re: [PATCH 1/8] iotests/257: add Pattern class
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-2-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-2-jsnow@redhat.com>

--InwhnsRdmaarXwNvnPaPiNIpwa8eCPynk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 03:05, John Snow wrote:
> Just kidding, this is easier to manage with a full class instead of a
> namedtuple.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/257 | 58 +++++++++++++++++++++++-------------------=

>  1 file changed, 32 insertions(+), 26 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
> index 75a651c7c3..f576a35a5c 100755
> --- a/tests/qemu-iotests/257
> +++ b/tests/qemu-iotests/257
> @@ -19,7 +19,6 @@
>  #
>  # owner=3Djsnow@redhat.com
> =20
> -from collections import namedtuple
>  import math
>  import os
> =20
> @@ -29,10 +28,18 @@ from iotests import log, qemu_img
>  SIZE =3D 64 * 1024 * 1024
>  GRANULARITY =3D 64 * 1024
> =20
> -Pattern =3D namedtuple('Pattern', ['byte', 'offset', 'size'])
> -def mkpattern(byte, offset, size=3DGRANULARITY):
> -    """Constructor for Pattern() with default size"""
> -    return Pattern(byte, offset, size)
> +
> +class Pattern:
> +    def __init__(self, byte, offset, size=3DGRANULARITY):
> +        self.byte =3D byte
> +        self.offset =3D offset
> +        self.size =3D size
> +
> +    def bits(self, granularity):
> +        lower =3D math.floor(self.offset / granularity)
> +        upper =3D math.floor((self.offset + self.size - 1) / granulari=
ty)
> +        return set(range(lower, upper + 1))

By the way, this doesn=E2=80=99t work with Python2 (pre-existing in your =
other
series).  It complains that these are floats.

Now I don=E2=80=99t know whether you care but there is the fact that the
expressions would be shorter if they were of the form x // y instead of
math.floor(x / y).

Max


--InwhnsRdmaarXwNvnPaPiNIpwa8eCPynk--

--1obWltBLUt6XJH4OekukPBmTKzpKZDYBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mEaYACgkQ9AfbAGHV
z0A/tQgAmbscMDXXA4+Gc7xM0Uvi54OamLQ87a6XVGp14t+8sSvKI/lE/SnNuEyC
xiXziKf+rYkgRNBYUgyqJXtoI9DFdMzZRg2tyDuCaZhssSzIyLJhjCNHqqshCNT5
PxqZtzr0Z+331ognIdJE2SYu888W0cwd+TUteSwuSGCMu6/kY02D/Tb61fDQyoBt
hMU975Rcn0yZCSfKljPC0iXH6u7J498MBdjizy0IwO3IFHp2e1aLvoiHy5J/oW62
DpQaLPIS2lmui58ZtTdWnlwibur/dGaeBPvp6Sq+Q0ISripViKUGB7fCr4yMe/g3
0GEc7d7xC5QwSJLeEW5MjAkk7aWQqw==
=w65F
-----END PGP SIGNATURE-----

--1obWltBLUt6XJH4OekukPBmTKzpKZDYBC--

