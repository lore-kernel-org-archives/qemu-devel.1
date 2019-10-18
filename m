Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29BCCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FA420854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FA420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLV3E-0004aM-HB
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iLUz6-0008NX-1z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iLUz3-0003yc-UX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:20:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12947)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iLUz1-0003xR-K6; Fri, 18 Oct 2019 12:20:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D023E3172D9A;
 Fri, 18 Oct 2019 16:20:06 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 457E26107E;
 Fri, 18 Oct 2019 16:19:54 +0000 (UTC)
Subject: Re: [PATCH 2/5] iotests: Test 041 does not work on macOS
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20191011145047.19051-1-thuth@redhat.com>
 <20191011145047.19051-3-thuth@redhat.com>
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
Message-ID: <cacfc0c2-cdb4-fded-e317-a51d38cc512c@redhat.com>
Date: Fri, 18 Oct 2019 18:19:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011145047.19051-3-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4H8pQOsbJYLkbTYVbK9aQOkZifbcJLX8B"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 18 Oct 2019 16:20:06 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4H8pQOsbJYLkbTYVbK9aQOkZifbcJLX8B
Content-Type: multipart/mixed; boundary="z07JpOEVS46HDhlSx4RT1IEr84XIBpqYw"

--z07JpOEVS46HDhlSx4RT1IEr84XIBpqYw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 16:50, Thomas Huth wrote:
> 041 works fine on Linux, FreeBSD and OpenBSD, so let's mark it as
> only supported on these systems.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/041 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 8568426311..7211f1950a 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1123,4 +1123,5 @@ class TestOrphanedSource(iotests.QMPTestCase):
> =20
>  if __name__ =3D=3D '__main__':
>      iotests.main(supported_fmts=3D['qcow2', 'qed'],
> -                 supported_protocols=3D['file'])
> +                 supported_protocols=3D['file'],
> +                 supported_platforms=3D['linux', 'freebsd', 'openbsd6'=
])

Hmm, why not just =E2=80=9Copenbsd=E2=80=9D, or single out macOS as unsup=
ported?  (I
suppose the latter would require an additional patch.)

There=E2=80=99s also the fact that I maybe wanted to let make check skip =
all
tests on macOS and Windows =E2=80=93 though that doesn=E2=80=99t make thi=
s patch
unnecessary, because that would only fix make check, not running the
iotests explicitly.

And I suppose maybe we even want to run the tests in macOS if it=E2=80=99=
s part
of the CI anyway?

Max


--z07JpOEVS46HDhlSx4RT1IEr84XIBpqYw--

--4H8pQOsbJYLkbTYVbK9aQOkZifbcJLX8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2p5igACgkQ9AfbAGHV
z0C6hgf/WbDAGvAOx/MPmnEzdHNCSGgHOz+Azd2zGpcgC0cWNmTzkGCUviqqSgJv
ty7WG45wRzdFtMhXW/a03tDTYMAogAhDDE7NAHcU0WBeA2yVpFgUJbm7Np5hKl4+
MF4c/Z1cMIB/WrvI0oTEi+ovHU+naGsRp4CxQAk3y2ws8qDVIfriEmdLMrAC5c0G
/dPEeuzSDFIGYHRaLo2zrzISrH7Dr1+iTf80IzOLWgxhU65EGLb4f0SXQLU7umwB
KiAFQ5h3/GPOAEbYK2dBHf81ZmfF8uDBJtMrzo4zfb0jtO9L5CjM/SmAUAwdSTcN
ZHmlGw1JBMSpQ90ypKYU9741mFlEnQ==
=NEnM
-----END PGP SIGNATURE-----

--4H8pQOsbJYLkbTYVbK9aQOkZifbcJLX8B--

