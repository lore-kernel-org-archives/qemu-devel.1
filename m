Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C745C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2841205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2841205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59523 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNh5g-0001vE-9Z
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:07:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNh4g-0001PZ-E9
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNh4f-0006Ga-Gr
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:06:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hNh4d-0006FY-3n; Mon, 06 May 2019 13:06:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33F7D87637;
	Mon,  6 May 2019 17:06:42 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 805945DAAC;
	Mon,  6 May 2019 17:06:40 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556732434.git.berto@igalia.com>
	<524e211cb818a20f521d6e271e782ab62b8e5e80.1556732434.git.berto@igalia.com>
	<8bff27c1-a93c-d9f0-c95c-6d10d5700f91@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <cd1d6df5-3540-910e-d39b-9074b94ffd38@redhat.com>
Date: Mon, 6 May 2019 12:06:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8bff27c1-a93c-d9f0-c95c-6d10d5700f91@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wbPsoAqYSY7rpYtubuRkqXY5tsujFawp2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 06 May 2019 17:06:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vvfat: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wbPsoAqYSY7rpYtubuRkqXY5tsujFawp2
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <cd1d6df5-3540-910e-d39b-9074b94ffd38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vvfat: Replace bdrv_{read, write}()
 with bdrv_{pread, pwrite}()
References: <cover.1556732434.git.berto@igalia.com>
 <524e211cb818a20f521d6e271e782ab62b8e5e80.1556732434.git.berto@igalia.com>
 <8bff27c1-a93c-d9f0-c95c-6d10d5700f91@virtuozzo.com>
In-Reply-To: <8bff27c1-a93c-d9f0-c95c-6d10d5700f91@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/6/19 11:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.05.2019 21:13, Alberto Garcia wrote:
>> There's only a couple of bdrv_read() and bdrv_write() calls left in
>> the vvfat code, and they can be trivially replaced with the byte-based=

>> bdrv_pread() and bdrv_pwrite().
>>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   block/vvfat.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index 5f66787890..253cc716dd 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -1494,8 +1494,8 @@ static int vvfat_read(BlockDriverState *bs, int6=
4_t sector_num,
>>                   DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
>>                                " allocated\n", sector_num,
>>                                n >> BDRV_SECTOR_BITS));
>> -                if (bdrv_read(s->qcow, sector_num, buf + i * 0x200,
>> -                              n >> BDRV_SECTOR_BITS)) {
>> +                if (bdrv_pread(s->qcow, sector_num * BDRV_SECTOR_SIZE=
,
>> +                               buf + i * 0x200, n) < 0) {
>=20
> Shouldn't we use QEMU_ALIGN_DOWN(n, BDRV_SECTOR_SIZE) ?

No, n should already be aligned, which makes align_down a no-op.

> Could bdrv_is_allocated give unaligned n?
>=20

Yes, bdrv_is_allocated can return unaligned n in some situations; I had
a patch that didn't make 4.0 that would add bdrv_block_status_aligned
for cases where we need to guarantee that different alignment of a
backing chain doesn't bleed through to the specified alignment of the
current layer. But those situations are rare, and I need to revisit
those and send a v2; so I don't see a problem with this one going in
during the meantime as-is.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--wbPsoAqYSY7rpYtubuRkqXY5tsujFawp2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzQaZ8ACgkQp6FrSiUn
Q2pfIAf/T7j9yh4itYU3Hvtr8ilVb4Cmeb8tOsLVYoZ6ScubD833YACdmk8pRxJQ
m/3OgQ8qrnY0x00o1u5DR6edzgtDcRmiAegqpUiKIAWzUvkhLfm5FMc9h73yp9EV
n9FLURBuFKDBMN+GbLT8w7D8uxLcmpCUTv+rQbvmWOi+xzOKZaniwFdMS4s2oOqH
bYd4rY1t3IxuB6NHIy9/+cbgbdk3UNcZp4xoJBf05+k9QZXwV6Ir/9gKRfQcElZJ
FAVGHGXDL/AipcYo/adf7qeplMUT8LoBuurjtEF6Vm0qY4iFjgyeBxpjany1fetF
GrxwboVflFfzLe1PWzevmP+XyWep1A==
=hyuH
-----END PGP SIGNATURE-----

--wbPsoAqYSY7rpYtubuRkqXY5tsujFawp2--

