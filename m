Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4709FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0FE2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0FE2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOBl-0003Ky-7L
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iLOAv-0002k3-MU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iLOAu-0000P7-Ie
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iLOAq-0000KJ-Am; Fri, 18 Oct 2019 05:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C83C3086E27;
 Fri, 18 Oct 2019 09:03:50 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B61E05C1B5;
 Fri, 18 Oct 2019 09:03:48 +0000 (UTC)
Subject: Re: [PATCH v2 01/23] iotests: Introduce $SOCK_DIR
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20191017133155.5327-1-mreitz@redhat.com>
 <20191017133155.5327-2-mreitz@redhat.com>
 <b8251992-a52b-f605-e45e-edf381394130@redhat.com>
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
Message-ID: <1ea69391-fa2b-bb19-ce34-f47036f1a064@redhat.com>
Date: Fri, 18 Oct 2019 11:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b8251992-a52b-f605-e45e-edf381394130@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HayhKeLOle2yT2ew4NGDOMmR3X9YSWCll"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 18 Oct 2019 09:03:50 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HayhKeLOle2yT2ew4NGDOMmR3X9YSWCll
Content-Type: multipart/mixed; boundary="9UT4jQAldrH7oOKnnkiw1D1euHBL7juoz"

--9UT4jQAldrH7oOKnnkiw1D1euHBL7juoz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.10.19 16:52, Eric Blake wrote:
> On 10/17/19 8:31 AM, Max Reitz wrote:
>> Unix sockets generally have a maximum path length.=C2=A0 Depending on =
your
>> $TEST_DIR, it may be exceeded and then all tests that create and use
>> Unix sockets there may fail.
>>
>> Circumvent this by adding a new scratch directory specifically for
>> Unix socket files.=C2=A0 It defaults to a temporary directory (mktemp =
-d)
>> that is completely removed after the iotests are done.
>>
>> (By default, mktemp -d creates a /tmp/tmp.XXXXXXXXXX directory, which
>> should be short enough for our use cases.)
>>
>> Use mkdir -p to create the directory (because it seems right), and do
>> the same for $TEST_DIR (because there is no reason for that to be
>> created in any different way).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/check | 15 +++++++++++++--
>> =C2=A0 1 file changed, 13 insertions(+), 2 deletions(-)
>=20
>> @@ -116,10 +117,14 @@ set_prog_path()
>> =C2=A0 if [ -z "$TEST_DIR" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_DIR=3D$PWD=
/scratch
>> =C2=A0 fi
>> +mkdir -p "$TEST_DIR" || _init_error 'Failed to create TEST_DIR'
>=20
> This one seems fine. We are either using the user's name (and if it is
> pre-existing, not fail) or using a well-known name (if someone else
> slams in files into that directory in parallel with our test run, oh
> well).=C2=A0 But at least the well-known name is a directory that is pr=
obably
> already accessible only to the current user, not world-writable.
>=20
>> =C2=A0 -if [ ! -e "$TEST_DIR" ]; then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir "$TEST_DIR"
>> +tmp_sock_dir=3Dfalse
>> +if [ -z "$SOCK_DIR" ]; then
>> +=C2=A0=C2=A0=C2=A0 SOCK_DIR=3D$(mktemp -d)
>> +=C2=A0=C2=A0=C2=A0 tmp_sock_dir=3Dtrue
>> =C2=A0 fi
>> +mkdir -p "$SOCK_DIR" || _init_error 'Failed to create SOCK_DIR'
>=20
> Thinking about this again: if the user passed in a name, we probably
> want to use it no matter whether the directory already exists (mkdir -p=

> makes sense: either the directory did not exist, or the user is in
> charge of passing us a directory that they already secured).=C2=A0 But =
if we
> generate our own name in a world-writable location in /tmp, using mkdir=

> -p means someone else can race us to the creation of the directory, and=

> potentially populate it in a way to cause us a security hole while we
> execute our tests.

I don=E2=80=99t quite see how this is a security hole.  mktemp -d creates=
 the
directory, so noone can race us.

Max

> I would be a bit more comfortable with:
>=20
> tmp_sock_dir=3Dfalse
> tmp_sock_opt=3D-p
> if [ -z "$SOCK_DIR" ]; then
> =C2=A0=C2=A0=C2=A0 SOCK_DIR=3D$(mktemp -d)
> =C2=A0=C2=A0=C2=A0 tmp_sock_dir=3Dtrue
> =C2=A0=C2=A0=C2=A0 tmp_sock_opt=3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # disa=
ble -p for our generated name
> fi
> mkdir $tmp_sock_opt "$SOCK_DIR" || _init_error 'Failed to create SOCK_D=
IR'
>=20



--9UT4jQAldrH7oOKnnkiw1D1euHBL7juoz--

--HayhKeLOle2yT2ew4NGDOMmR3X9YSWCll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2pf/IACgkQ9AfbAGHV
z0CZLQf9GLUxbmeMLRl9Tvf1ew7vQQaMUOgD2jp5Z2U/Rn0hhwDroW6YyptL2kz/
jXkN7xZfIUwZKGd1p+wrv+bTxCrLp936XR/ryEv5WkRrXhTy2+OEBNfM2fyqkJGm
Fhe9HahnTaPv4kMIitCvPaB5DqlhGtZCMWKKEru+9O2eKVWNeJ1eo//zY894OBDq
lp9ZeoUYv9Ed1mSeYybiOqkyFdOG5CjnbJy6oRWqop6goad092VnjHQjbYSH/1Re
I/yyRj2y97LMDZuL3MQ9H1cn+4s8PO3KV9ZfbTh4nSfFD5NTSIL5PzOJpECKq4L3
xkWJv3sIHKwSpfGg3oJgVkpE4Ng2BQ==
=pBmx
-----END PGP SIGNATURE-----

--HayhKeLOle2yT2ew4NGDOMmR3X9YSWCll--

