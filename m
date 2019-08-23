Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B382082F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B382082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Db8-0008J2-Ss
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i1DZM-0007Lp-JA
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i1DZL-0000um-Eo
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i1DZI-0000sp-OF; Fri, 23 Aug 2019 13:41:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 777D53084031;
 Fri, 23 Aug 2019 17:41:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-96.brq.redhat.com
 [10.40.204.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D8B460872;
 Fri, 23 Aug 2019 17:41:41 +0000 (UTC)
To: Nir Soffer <nsoffer@redhat.com>
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
 <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
 <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
 <CAMRbyyt5gAOzY7sTQc7_XE20-O4XunVjne2_2_1jmZtButc1eg@mail.gmail.com>
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
Message-ID: <d4cd2864-62ab-2831-fabd-8c4c2d401ed8@redhat.com>
Date: Fri, 23 Aug 2019 19:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyt5gAOzY7sTQc7_XE20-O4XunVjne2_2_1jmZtButc1eg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5N919ZCgmsqlpoz8Lo6s6G5qBB4ILkzr0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 23 Aug 2019 17:41:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: posix: Always allocate the first
 block
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Nir Soffer <nirsof@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5N919ZCgmsqlpoz8Lo6s6G5qBB4ILkzr0
Content-Type: multipart/mixed; boundary="ThdcROBUC6WJus2wFVp30U76eMZIr6Afy";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <d4cd2864-62ab-2831-fabd-8c4c2d401ed8@redhat.com>
Subject: Re: [PATCH] block: posix: Always allocate the first block
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <86c147ef-9dd3-d35a-5005-ec53081196d7@redhat.com>
 <CAMRbyyt3Ku0Znpfx16FDqFTYbp5oJ1-9DnyxntHnArHsbR1ing@mail.gmail.com>
 <271a2dd3-9f2b-013d-896f-f4059c804967@redhat.com>
 <CAMRbyytxF8r9LoX4J_7ca2QPRtnpWgdTtyaKq=p=7ZaoMu-uug@mail.gmail.com>
 <e8db1edb-b1ee-8244-c772-8e08794181f0@redhat.com>
 <CAMRbyyt5gAOzY7sTQc7_XE20-O4XunVjne2_2_1jmZtButc1eg@mail.gmail.com>
In-Reply-To: <CAMRbyyt5gAOzY7sTQc7_XE20-O4XunVjne2_2_1jmZtButc1eg@mail.gmail.com>

--ThdcROBUC6WJus2wFVp30U76eMZIr6Afy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.08.19 18:30, Nir Soffer wrote:
> On Fri, Aug 23, 2019 at 4:58 PM Max Reitz <mreitz@redhat.com
> <mailto:mreitz@redhat.com>> wrote:
>=20

[...]

>     Exactly.=C2=A0 But if posix_fallocate() works, it should have alloc=
ated the
>     first block.
>=20
>=20
> Only if the file system does not support fallocate(). posix_fallocate()=

> first try
> fallocate(), and fall back to manual preallocation:
> https://code.woboq.org/userspace/glibc/sysdeps/unix/sysv/linux/posix_fa=
llocate.c.html#27

I still don=E2=80=99t understand.  Your example does show that the first =
block
is not allocated by fallocate(), but I still don=E2=80=99t understand the=

connection to not having fallocate() support.

If it doesn=E2=80=99t have fallocate() support and posix_fallocate() does=
 fall
back, the result should be that posix_fallocate() manually allocates
data, which should be completely sufficient.

So in fact, it seems to me that the opposite is true: It seems that when
allocating blocks on XFS with fallocate(), that simply won=E2=80=99t be e=
nough
to cause alignment errors.  So it doesn=E2=80=99t seem to be about fallba=
ck
code, but precisely the normal XFS code that fully supports fallocate.

(Just running your example on a local file on XFS shows the same result.)=


So that seems to me why the additional allocation is necessary.  I think
that should be noted in a comment =E2=80=93 if I=E2=80=99m right (I may w=
ell not be).

Max


--ThdcROBUC6WJus2wFVp30U76eMZIr6Afy--

--5N919ZCgmsqlpoz8Lo6s6G5qBB4ILkzr0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1gJVQACgkQ9AfbAGHV
z0AAOwf8DqYBqP1TE/tl7+pcFdjD349h7XC2R+06UaKP1ysxYF0Nkbj2cPKGLa0R
yloCAT66ExtLZ4jDbRVcT77bglwOnkg97V0TZdMI74/792MThoe23U4BhpwLHptX
MZLMrxgMfCeviBIjc3qiIoPo7eAJFylfkCcmoZoqkmn1uIRTVJoIxSK1vwitVWPJ
fEVHWXP9I6LIzW4zcjZnEwooONIupt8q4Q0sbLljiYTqHFYZJqmjKvpzQRHxirA6
kBkjrZmzDlo4kSNQwq5j7GJQ/u1LQM2JxahXyHmgf7fReoofbwVkxn6gTM2jio5g
jaw4SMFhVDHwAEDd0UZnDKc1PgPU6g==
=KAU0
-----END PGP SIGNATURE-----

--5N919ZCgmsqlpoz8Lo6s6G5qBB4ILkzr0--

