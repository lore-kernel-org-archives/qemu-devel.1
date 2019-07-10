Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F7CC74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 21:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984252087F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 21:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984252087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlKWy-00075X-4o
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 17:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32861)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlKVz-0006Eb-Sa
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 17:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlKVx-0001KK-SU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 17:52:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlKVs-00019Q-BT; Wed, 10 Jul 2019 17:52:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C432D36899;
 Wed, 10 Jul 2019 21:52:27 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F78660C05;
 Wed, 10 Jul 2019 21:52:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
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
Message-ID: <3e82ff24-6f84-9de8-d3ab-c34966f875f0@redhat.com>
Date: Wed, 10 Jul 2019 23:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Cl8axl6flIGJVUJSSdFvyqQiycy0mVxC2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 10 Jul 2019 21:52:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cl8axl6flIGJVUJSSdFvyqQiycy0mVxC2
Content-Type: multipart/mixed; boundary="UrhKt66gsyVr1zTbQjTX224A9dbJfhEkz";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3e82ff24-6f84-9de8-d3ab-c34966f875f0@redhat.com>
Subject: Re: [PATCH] LUKS: support preallocation in qemu-img
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
In-Reply-To: <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>

--UrhKt66gsyVr1zTbQjTX224A9dbJfhEkz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 23:24, Max Reitz wrote:
> On 10.07.19 19:03, Maxim Levitsky wrote:
>> preallocation=3Doff and preallocation=3Dmetadata
>> both allocate luks header only, and preallocation=3Dfalloc/full
>> is passed to underlying file, with the given image size.
>>
>> Note that the actual preallocated size is a bit smaller due
>> to luks header.
>=20
> Couldn=E2=80=99t you just preallocate it after creating the crypto head=
er so
> qcrypto_block_get_payload_offset(crypto->block) + size is the actual
> file size?
>=20
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
>>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> ---
>>  block/crypto.c | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> Hm.  I would expect a preallocated image to read 0.  But if you just
> pass this through to the protocol layer, it won=E2=80=99t read 0.
>=20
> (In fact, I don=E2=80=99t even quite see the point of having LUKS as an=
 own
> format still.  It was useful when qcow2 didn=E2=80=99t have LUKS suppor=
t, but
> now it does, so...  I suppose everyone using the LUKS format should
> actually be using qcow2 with LUKS?)

Kevin just pointed out to me that our LUKS format is compatible to the
actual layout cryptsetup uses.  OK, that is an important use case.

Hm.  Unfortunately, that doesn=E2=80=99t really necessitate preallocation=
=2E

Well, whatever.  If it=E2=80=99s simple enough, that shouldn=E2=80=99t st=
op us from
implementing preallocation anyway.


Now I found that qapi/block-core.json defines PreallocMode=E2=80=99s fall=
oc and
full values as follows:

> # @falloc: like @full preallocation but allocate disk space by
> #          posix_fallocate() rather than writing zeros.
> # @full: preallocate all data by writing zeros to device to ensure disk=

> #        space is really available. @full preallocation also sets up
> #        metadata correctly.

So it isn=E2=80=99t just me who expects these to pre-initialize the image=
 to 0.
 Hm, although...  I suppose @falloc technically does not specify whether
the data reads as zeroes.  I kind of find it to be implied, but, well...

Max


--UrhKt66gsyVr1zTbQjTX224A9dbJfhEkz--

--Cl8axl6flIGJVUJSSdFvyqQiycy0mVxC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mXhgACgkQ9AfbAGHV
z0C0fwf9GW1scMueh0tVnZi8c8r3O0rrCZFJ7VLpdI8HrQmNnrwyo56aBpTrh7ww
XGVVWh00WCioy/6CvTXpDKzCBxMuBuSK+sWYqVM4crNF+XCQb0Nz9vkpH97tc8M/
ltHqjkgnSlIclcd8SX+46zg1VV53wYfoEm3Ze4c1dsUIuEu/ndkdVzvz+Hvbnj/F
J+my10p9d25A5zEvKVDs84SCX5cagBuwTagO4O4VZKx1T+BIzcvQN9/2Tr3DNfxu
WV6aTxe9w2+JshSjNdLIKRZYLFTzJiXU2HjqitLzwZYjKZMk4WfQrVRzP0I602/N
9dUhj47dYheQkGgl4ivewRmQBam2/g==
=vHyT
-----END PGP SIGNATURE-----

--Cl8axl6flIGJVUJSSdFvyqQiycy0mVxC2--

