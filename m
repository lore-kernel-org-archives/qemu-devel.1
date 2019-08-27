Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDFDC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 17:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478AD21881
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 17:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478AD21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2fJj-0007gG-5Z
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 13:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2fIg-0007DU-3X
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 13:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2fIe-0008Dp-VL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 13:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2fIc-0008BV-7l; Tue, 27 Aug 2019 13:30:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5E1893087958;
 Tue, 27 Aug 2019 17:30:29 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A2AD60C5D;
 Tue, 27 Aug 2019 17:30:27 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190823133552.11680-1-thuth@redhat.com>
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
Message-ID: <f34d5940-db14-45ea-51a7-1bd308ff07ac@redhat.com>
Date: Tue, 27 Aug 2019 19:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823133552.11680-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KdwXDLZSOGVTrrhvsQAo7cpVZMpQvxA5b"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 27 Aug 2019 17:30:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Check for enabled drivers
 before testing them
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
--KdwXDLZSOGVTrrhvsQAo7cpVZMpQvxA5b
Content-Type: multipart/mixed; boundary="ohq5uJf2Z8lHCc9FZYCkBGIEpeF2chbhb";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f34d5940-db14-45ea-51a7-1bd308ff07ac@redhat.com>
Subject: Re: [PATCH v2] iotests: Check for enabled drivers before testing them
References: <20190823133552.11680-1-thuth@redhat.com>
In-Reply-To: <20190823133552.11680-1-thuth@redhat.com>

--ohq5uJf2Z8lHCc9FZYCkBGIEpeF2chbhb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.08.19 15:35, Thomas Huth wrote:
> It is possible to enable only a subset of the block drivers with the
> "--block-drv-rw-whitelist" option of the "configure" script. All other
> drivers are marked as unusable (or only included as read-only with the
> "--block-drv-ro-whitelist" option). If an iotest is now using such a
> disabled block driver, it is failing - which is bad, since at least the=

> tests in the "auto" group should be able to deal with this situation.
> Thus let's introduce a "_require_drivers" function that can be used by
> the shell tests to check for the availability of certain drivers first,=

> and marks the test as "not run" if one of the drivers is missing.
>=20
> This patch mainly targets the test in the "auto" group which should
> never fail in such a case, but also improves some of the other tests
> along the way. Note that we also assume that the "qcow2" and "file"
> drivers are always available - otherwise it does not make sense to
> run "make check-block" at all (which only tests with qcow2 by default).=

>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Update the check in _require_drivers() according to Max' suggestion
>  - Remove superfluous check in test 081
>  - Mark 120 to require "raw"
>  - Replaced the check in 162 to use the new _require_drivers() function=

>  - Mark 186 to require "null-co"
>=20
>  tests/qemu-iotests/071       |  1 +
>  tests/qemu-iotests/081       |  4 +---
>  tests/qemu-iotests/099       |  1 +
>  tests/qemu-iotests/120       |  1 +
>  tests/qemu-iotests/162       |  4 +---
>  tests/qemu-iotests/184       |  1 +
>  tests/qemu-iotests/186       |  1 +
>  tests/qemu-iotests/common.rc | 14 ++++++++++++++
>  8 files changed, 21 insertions(+), 6 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--ohq5uJf2Z8lHCc9FZYCkBGIEpeF2chbhb--

--KdwXDLZSOGVTrrhvsQAo7cpVZMpQvxA5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1laLIACgkQ9AfbAGHV
z0DpCAf9EIKqnZp34lyxs1sqV1+3EHV5Xr1DfunHIPZh3u8mw6WK9J0qbbImC2/Z
NYfOcQrwNQq7uYh2RQS93Z9JkdakoNQ7jxuS2lYh2cz5/pIGLh2GGQqrnP1dpDvF
h9tlFoF38E9EuG3ShPYoP/k63T+1nfFq38Qg7aZ64AaTkZZubec6sI/KeGb/hfD/
469RVjiK33JHuHjriKHLOzRwzP1hV+b1GuCEcq20iVp7YM2qbbyLz2s2tQ6OCK4F
MoMy0HEbI0F3CtJ71Jjesh6T8Q6nyqbY4qi80BB8tLMF3RMjsHlL4meDZTdfHS6e
9d/+y2mUOXq3B9Qzsy6BV2lAj3SGjw==
=sfe3
-----END PGP SIGNATURE-----

--KdwXDLZSOGVTrrhvsQAo7cpVZMpQvxA5b--

