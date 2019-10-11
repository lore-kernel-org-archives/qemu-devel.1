Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07675C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21A221A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21A221A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpm4-0005pr-U9
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 03:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIpiU-0001cy-5v
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIpiS-0007aA-J1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIpiN-0007XX-Uh; Fri, 11 Oct 2019 03:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C66C818CB8E8;
 Fri, 11 Oct 2019 07:51:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-40.ams2.redhat.com
 [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1097360600;
 Fri, 11 Oct 2019 07:51:52 +0000 (UTC)
Subject: Re: [PATCH 01/23] iotests: Introduce $SOCK_DIR
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20191010152457.17713-1-mreitz@redhat.com>
 <20191010152457.17713-2-mreitz@redhat.com>
 <28d6c3e1-7efa-7e31-0b95-c8b5c79f75dc@redhat.com>
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
Message-ID: <de01a842-4418-c3f4-7521-d11ae10d2866@redhat.com>
Date: Fri, 11 Oct 2019 09:51:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <28d6c3e1-7efa-7e31-0b95-c8b5c79f75dc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y87eIPQbEVqP3XnoQomm7hycFd90Lh6Uw"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 07:51:54 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y87eIPQbEVqP3XnoQomm7hycFd90Lh6Uw
Content-Type: multipart/mixed; boundary="7uLSqz0Cr1J1qBP1FGInxhBykxNhTzarR"

--7uLSqz0Cr1J1qBP1FGInxhBykxNhTzarR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.10.19 20:18, Eric Blake wrote:
> On 10/10/19 10:24 AM, Max Reitz wrote:
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
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/check | 17 +++++++++++++++++
>=20
>> +tmp_sock_dir=3Dfalse
>> +if [ -z "$SOCK_DIR" ]; then
>> +=C2=A0=C2=A0=C2=A0 SOCK_DIR=3D$(mktemp -d)
>> +=C2=A0=C2=A0=C2=A0 tmp_sock_dir=3Dtrue
>> +fi
>> +
>> +if [ ! -d "$SOCK_DIR" ]; then
>> +=C2=A0=C2=A0=C2=A0 mkdir "$SOCK_DIR"
>> +fi
>=20
> Should this use mkdir -p, in case two parallel processes compete with
> the same SOCK_DIR?

I would have used mkdir -p, but I saw we used this construct for
TEST_DIR, so I thought I=E2=80=98d just go for the same.

> What if SOCK_DIR is set to something that is not a directory (say a
> file), at which point mkdir fails, but you don't seem to be catching
> that failure.

Well, the same applies to TEST_DIR.  And technically, as long as we
don=E2=80=99t use mkdir -p for either, not catching the error at least he=
lps
circumvent the potential race. O:-)

(I=E2=80=99ll convert both to mkdir -p with error handling.)

Max

> Otherwise looks good.



--7uLSqz0Cr1J1qBP1FGInxhBykxNhTzarR--

--y87eIPQbEVqP3XnoQomm7hycFd90Lh6Uw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2gNJYACgkQ9AfbAGHV
z0BbSAgAlv5vgfSXX/7ZTm5Cd+ZEaeJKH6W/ogbJchgvEUcBVDKuu5SrS8UsE6yv
4BaQtoHTW6cfK/Mm6o6XrD5grfucmwufycP0eBuIG+oTYIam9FYGQas6hic3kxgl
TzdeSwOfpXoppXIbAREEdQPPsNm0Jt3E2XV5hnqIK9WNbRC/1grn5iYPQZGk6h3j
EVeS0YWePfrh1yRjOALFfvkoP23V22OoMcvGdDsfO3zPVzTuLrydrMw4X05+bupa
t/ncE8280ZSunEpp+lE8zJASIs64zc8M1TDldnZCLQ9UCnBMBjYCj+gCEbgc/enA
EvbgR1zRoSitofLYpNbK5DcodPgOpw==
=4an6
-----END PGP SIGNATURE-----

--y87eIPQbEVqP3XnoQomm7hycFd90Lh6Uw--

