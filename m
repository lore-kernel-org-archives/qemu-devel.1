Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2201C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57B22083B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57B22083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK13z-0005z4-RJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iK12Z-0004lz-Rs
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iK12Y-000379-H7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iK12T-000361-UN; Mon, 14 Oct 2019 10:09:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D596918C4278;
 Mon, 14 Oct 2019 14:09:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-165.ams2.redhat.com
 [10.36.117.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9813A196AE;
 Mon, 14 Oct 2019 14:09:31 +0000 (UTC)
Subject: Re: [PATCH v3 07/16] qcow2: Write v3-compliant snapshot list on
 upgrade
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20191011152814.14791-1-mreitz@redhat.com>
 <20191011152814.14791-8-mreitz@redhat.com>
 <a9263c74-f958-5859-9db3-a67aefe73ff5@redhat.com>
 <085c7aec-edd7-79bd-136f-5a3785a5d430@redhat.com>
 <582dc245-8a09-f88e-d67c-9435200c327d@redhat.com>
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
Message-ID: <61015d9f-7a85-c23f-aa3e-b6d85e7dfbcf@redhat.com>
Date: Mon, 14 Oct 2019 16:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <582dc245-8a09-f88e-d67c-9435200c327d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RbCgoV33OIBSBLZARMq1jmQ0AFveH59BF"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 14 Oct 2019 14:09:32 +0000 (UTC)
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
--RbCgoV33OIBSBLZARMq1jmQ0AFveH59BF
Content-Type: multipart/mixed; boundary="BrwmBGeNUGeMwByUk4nWuRKHMlYd47ZXR"

--BrwmBGeNUGeMwByUk4nWuRKHMlYd47ZXR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.19 15:53, Eric Blake wrote:
> On 10/14/19 3:45 AM, Max Reitz wrote:
>=20
>>>> +=C2=A0=C2=A0=C2=A0 need_snapshot_update =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->nb_snapshots; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->snapshots[i].extr=
a_data_size <
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sizeof_field(QCowSnapshotExtraData, vm_state_size_large) +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sizeof_field(QCowSnapshotExtraData, disk_size))
>>>
>>> Shorter as:
>>> if (s->snapshots[i].extra_data_size < sizeof(QCowSnapshotExtraData))
>>>
>>> but that's stylistic, so R-b still stands.
>>
>> Yes, but if we ever add fields to QCowSnapshotExtraData, we shouldn=E2=
=80=99t
>> count them here.=C2=A0 Therefore, I think we need to count exactly the=
 fields
>> that the standard says are mandatory in v3.
>=20
> If we ever add more fields, I'd prefer that we did something like:
>=20
> struct QCowSnapshotExtraV3Minimum {
> =C2=A0=C2=A0=C2=A0 uint64_t vm_state_size_large;
> =C2=A0=C2=A0=C2=A0 uint64_t disk_size;
> };
> struct QCow3SnapshotExtraFull {
> =C2=A0=C2=A0=C2=A0 struct QCowSnapshotExtraV3Minimum base;
> =C2=A0=C2=A0=C2=A0 new fields...;
> };
>=20
> and use sane naming to get at extra members based on the expected types=
,
> rather than trying to piecemeal portions of a type based on size.
>=20
> Until we actually DO add more fields, why do we have to complicate the
> current code?

I don=E2=80=99t think it=E2=80=99s complicated, I find it very expressive=
=2E  There are
two fields, we check whether they are present; why, that=E2=80=99s obviou=
s,
because those are the ones mandated by the standard.

If we just checked against sizeof(QCowSnapshotExtraData), I=E2=80=99d (as=
 a
na=C3=AFve reader) ask myself what that has to do with the standard.  I=E2=
=80=99d
need to look into the structure definition and see that it currently
contains exactly the fields that are mandated by the standard, and then
I=E2=80=99d think =E2=80=9CBut what if we ever add fields to this structu=
re?=E2=80=9D  The more
verbose version avoids this problem.

And I=E2=80=99m not really inclined to take your proposal above right now=
,
because that would mean having to touch a lot of code.  I prefer this
more verbose code over that.


Also, you explicitly agreed that the code in this patch is preferable to
a plain sizeof(extra) in v2:

https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00942.html

Max


--BrwmBGeNUGeMwByUk4nWuRKHMlYd47ZXR--

--RbCgoV33OIBSBLZARMq1jmQ0AFveH59BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2kgZoACgkQ9AfbAGHV
z0CW3wf/ZcjrU+7eBDutKstONW5u++u1okfmH7IYwagjUR3doFMfOEKDOs0Le/Ow
i5X9X454vuBjuM5V4rQ0MvJHP/fBVNb2NU+UqB/pNJMx3iTXUXMMyAO4cZIocoWX
wuwP0bp8777Mh6VCgbLzOrIj0M32tB83kFj47WnnmNjsZg4+lBaB9eC0VvZ5Nhyl
Lw5L+I2BIySGPasuMamdd26rmVQPfJoby5AaM5O/4RYKtZE4+cEkVpPKCIHqeMQr
svx+y4VAfYK6b+0b90b7nxaPRmZJ5/FeRrr9jUP42CATEyjVb5Tf1q8nzKXmMLW0
oOB9vAw5XF43VH1wFWIYj0LCd8uf6g==
=wtc/
-----END PGP SIGNATURE-----

--RbCgoV33OIBSBLZARMq1jmQ0AFveH59BF--

