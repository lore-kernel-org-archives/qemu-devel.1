Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D30FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477E520878
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgNRDtzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477E520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0fG-0001C8-2V
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iX0eX-0000il-DB
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iX0eW-0001jN-4W
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:22:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iX0eV-0001j4-Vp
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574158951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xiL2Ay90org6FMHBCalgPG00PPoaET7SQJmrz1Tb7zs=;
 b=UgNRDtzYsCT+DGMvxP850IBTN99HG7NzgGyCuqUAxtmVNqg35neVqYMim7VUQixerD+c90
 ai9ffqV17AjhqSYSQ+raNS4wcMhhZApm9atXzoeBRZ9aS0jtZciAABKzfijMEOhv6cGb5/
 QoZVkVp4OXqONPh+izNWYXu1eJ1OOlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-rkGzUgNoNJeN2llEmc3CYw-1; Tue, 19 Nov 2019 05:22:29 -0500
X-MC-Unique: rkGzUgNoNJeN2llEmc3CYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D691005502;
 Tue, 19 Nov 2019 10:22:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-187.ams2.redhat.com
 [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C889F10375CC;
 Tue, 19 Nov 2019 10:22:23 +0000 (UTC)
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
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
Message-ID: <09d0bab1-ed7d-4fd7-555d-93075f10d497@redhat.com>
Date: Tue, 19 Nov 2019 11:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191116163410.12129-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nI4P11XbriFjgC4gsCNW9rn9kBeBoJkrs"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nI4P11XbriFjgC4gsCNW9rn9kBeBoJkrs
Content-Type: multipart/mixed; boundary="WsR7t49ud6O3njAIdM2qDsSEBJN2WyUvm"

--WsR7t49ud6O3njAIdM2qDsSEBJN2WyUvm
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.11.19 17:34, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> I wanted to understand, what is the real difference between bdrv_block_st=
atus_above
> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work thr=
ough
> bdrv_block_status_above..
>=20
> And I found the problem: bdrv_is_allocated_above considers space after EO=
F as
> UNALLOCATED for intermediate nodes..
>=20
> UNALLOCATED is not about allocation at fs level, but about should we go t=
o backing or
> not.. And it seems incorrect for me, as in case of short backing file, we=
'll read
> zeroes after EOF, instead of going further by backing chain.

Should we, though?  It absolutely makes sense to me to consider post-EOF
space as unallocated because, well, it is as unallocated as it gets.

So from my POV it would make more sense to fall back to the backing file
for post-EOF reads.

OTOH, I don=92t know whether changing that behavior would qualify as a
possible security issue now, because maybe someone has sensitive
information in the tail of some disk and then truncated the overlay so
as to hide it?  But honestly, that seems ridiculous and I can=92t imagine
people to do that.  (It would work only for the tail, and why not just
write zeroes there, which works everywhere?)  So in practice I don=92t
believe that to be a problem.

Max

> This leads to the following effect:
>=20
> ./qemu-img create -f qcow2 base.qcow2 2M
> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>=20
> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>=20
> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
> read 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>=20
> But after commit guest visible state is changed, which seems wrong for me=
:
> ./qemu-img commit top.qcow2 -b mid.qcow2
>=20
> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
> Pattern verification failed at offset 1048576, 1048576 bytes
> read 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>=20
> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
> read 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>=20
>=20
> I don't know, is it a real bug, as I don't know, do we support backing fi=
le larger than
> its parent. Still, I'm not sure that this behavior of bdrv_is_allocated_a=
bove don't lead
> to other problems.
>=20
> =3D=3D=3D=3D=3D
>=20
> Hmm, bdrv_block_allocated_above behaves strange too:
>=20
> with want_zero=3Dtrue, it may report unallocated zeroes because of short =
backing files, which
> are actually "allocated" in POV of backing chains. But I see this may inf=
luence only
> qemu-img compare, and I don't see can it trigger some bug..
>=20
> with want_zero=3Dfalse, it may do no progress because of short backing fi=
le. Moreover it may
> report EOF in the middle!! But want_zero=3Dfalse used only in bdrv_is_all=
ocated, which considers
> onlyt top layer, so it seems OK.=20
>=20
> =3D=3D=3D=3D=3D
>=20
> So, I propose these series, still I'm not sure is there a real bug.
>=20
> Vladimir Sementsov-Ogievskiy (4):
>   block/io: fix bdrv_co_block_status_above
>   block/io: bdrv_common_block_status_above: support include_base
>   block/io: bdrv_common_block_status_above: support bs =3D=3D base
>   block/io: fix bdrv_is_allocated_above
>=20
>  block/io.c                 | 104 ++++++++++++++++++-------------------
>  tests/qemu-iotests/154.out |   4 +-
>  2 files changed, 53 insertions(+), 55 deletions(-)
>=20



--WsR7t49ud6O3njAIdM2qDsSEBJN2WyUvm--

--nI4P11XbriFjgC4gsCNW9rn9kBeBoJkrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3Twl0ACgkQ9AfbAGHV
z0CspggAkbcLf9OUzCqgt63EdTwiPYfMDBvwZyrEcn3naAFvEtoXy+B8YP7Srn7p
y5ZfbAhNUCRnqg0mUE6ybNxhNGsfOMmevGpgoQHksGD+dpcthtfJULmkavsQB36I
ELe6Zzi0r8Z1Jj8UJNyR2wKMpYfu5qZMkidI5YJWTmOs8U2tAB7lXGf12/wIywsW
FnXAzCCnVACvad7cNdQ/CqO1kp6shODJGYW+H7H2qzvSgjv1b24hTyyEbFT4NUMa
9YthzB5IAczNtuxoUknJoccq8p1eCl3avT3CdIEMdbPDCrzWxIKog28MMnFTVSa0
uGWgdAHOcsPqRGg921RTir+6ekJX7g==
=1lH6
-----END PGP SIGNATURE-----

--nI4P11XbriFjgC4gsCNW9rn9kBeBoJkrs--


