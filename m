Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BEC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0021B206DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0021B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEGHi-0008Qq-8F
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 12:41:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEGGa-0007iX-0h
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEGGZ-0006Xv-6V
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:40:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEGGW-0006WS-TF; Wed, 10 Apr 2019 12:40:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E20653086204;
	Wed, 10 Apr 2019 16:39:59 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 506B561102;
	Wed, 10 Apr 2019 16:39:58 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190410162918.9343-1-mreitz@redhat.com>
	<aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
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
Message-ID: <3620d581-c849-f768-b9d4-239ff09f174f@redhat.com>
Date: Wed, 10 Apr 2019 18:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Xzr4c9HRwJtAye50aRY2gVKvSONxqsgU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 10 Apr 2019 16:39:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotests: Let 245 pass on tmpfs
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410163956.teWunrJqTCW4SNrQDl2M_yLiXkAVxUgTYagbQOO8aOc@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Xzr4c9HRwJtAye50aRY2gVKvSONxqsgU
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <3620d581-c849-f768-b9d4-239ff09f174f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0?] iotests: Let 245 pass on tmpfs
References: <20190410162918.9343-1-mreitz@redhat.com>
 <aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
In-Reply-To: <aa9b357f-3485-9819-fa93-23afe6fdb2d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.04.19 18:39, Eric Blake wrote:
> On 4/10/19 11:29 AM, Max Reitz wrote:
>> tmpfs does not support O_DIRECT.  Detect this case, and skip flipping
>> @direct if the filesystem does not support it.
>>
>> Fixes: bf3e50f6239090e63a8ffaaec971671e66d88e07
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/245 | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> Are you trying to get this in 4.0-rc3? (As a test, it has no bearing on=

> the actual binaries; fewer testsuite failures are nice if we squeeze it=

> in, but at the same time it is not enough to delay the release if it
> does not get fixed until 4.1).
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

If there are other patches for rc3, we could take this as well.  But
there is no point in making a pull request just for this.

Max


--2Xzr4c9HRwJtAye50aRY2gVKvSONxqsgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyuHFwACgkQ9AfbAGHV
z0AkXggAheRZgXSdvLICfULz40QOJIP5bTCvfzgDC5AMNwLKNpL1ySskYZHxgbta
Qlo2Ils0mbVOmxOTuQokhMNX+Uw9j3KFra/SPUp6tYIYXHzQSckHqq3jrwHmsHM8
UqQcXGlhaBc/6MonHOKntord5f4/mXCOahkHya/dx+/vHVLkd2gQy1wq/o8OuRPB
ktYtIt/O2ceGCyTzOzG+d41GXpSCMUB7WaMPym7l+ll83BSbAFgLyYd+8oAleJaz
lA1IOye5QbbJS8Kj1drYP1U7ORnV8nDaAw+Pbf0AhXqQ0/DTfaV5wf8XenamXY1I
yU8l8iB/es7RecFutGHZWhVjX0Y/hg==
=q7Nr
-----END PGP SIGNATURE-----

--2Xzr4c9HRwJtAye50aRY2gVKvSONxqsgU--

