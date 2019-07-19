Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BBAC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4479A2186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4479A2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUyj-0007vl-Im
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34032)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hoUyX-0007UH-CC
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hoUyT-0002Zj-Mi
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hoUxu-0000be-JD; Fri, 19 Jul 2019 11:38:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B342821D8;
 Fri, 19 Jul 2019 15:16:04 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A039C26FBB;
 Fri, 19 Jul 2019 15:16:00 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1563529204-3368-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563529204-3368-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a4214009-e9ba-2f67-138b-30ce31f7905f@redhat.com>
 <e12c0aa2-6757-856a-bbe0-717895453986@redhat.com>
 <d6093ee2-b0d6-8b85-dbca-9ee76d52688a@virtuozzo.com>
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
Message-ID: <13facb85-33bf-f33e-be56-eed63f4f2d8c@redhat.com>
Date: Fri, 19 Jul 2019 10:15:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d6093ee2-b0d6-8b85-dbca-9ee76d52688a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qe0txVy9b4H6kfIOCwj0GaVSzwyQ6bx3l"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 19 Jul 2019 15:16:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 7/7] block/nbd: NBDReply is used being
 uninitialized
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qe0txVy9b4H6kfIOCwj0GaVSzwyQ6bx3l
Content-Type: multipart/mixed; boundary="OG75EFUgsZ4Yg19yY9HefwIjucMqJP3Zu";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <13facb85-33bf-f33e-be56-eed63f4f2d8c@redhat.com>
Subject: Re: [PATCH v4 7/7] block/nbd: NBDReply is used being uninitialized
References: <1563529204-3368-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563529204-3368-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a4214009-e9ba-2f67-138b-30ce31f7905f@redhat.com>
 <e12c0aa2-6757-856a-bbe0-717895453986@redhat.com>
 <d6093ee2-b0d6-8b85-dbca-9ee76d52688a@virtuozzo.com>
In-Reply-To: <d6093ee2-b0d6-8b85-dbca-9ee76d52688a@virtuozzo.com>

--OG75EFUgsZ4Yg19yY9HefwIjucMqJP3Zu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/19/19 10:00 AM, Andrey Shinkevich wrote:
>=20
>=20
> On 19/07/2019 17:44, Eric Blake wrote:
>> On 7/19/19 9:34 AM, Eric Blake wrote:
>>> On 7/19/19 4:40 AM, Andrey Shinkevich wrote:
>>>> In case nbd_co_receive_one_chunk() fails in
>>>> nbd_reply_chunk_iter_receive(), 'NBDReply reply' parameter is used i=
n
>>>> the check nbd_reply_is_simple() without being initialized. The iotes=
t
>>>> 083 does not pass under the Valgrind: $./check -nbd -valgrind 083.
>>>> The alternative solution is to swap the operands in the condition:
>>>> 'if (s->quit || nbd_reply_is_simple(reply))'
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>   block/nbd.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Huh. Very similar to
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03712.html, =
but
>>> affects a different function. I can queue this one through my NBD tre=
e
>>> to get both in my rc2 pull request.
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Actually, since this is the second patch on the same topic, I'm
>> wondering if it's better to use the following one-liner to fix BOTH
>> issues and without relying on a gcc extension:
>>
>> diff --git i/block/nbd.c w/block/nbd.c
>> index 8d565cc624ec..f751a8e633e5 100644
>> --- i/block/nbd.c
>> +++ w/block/nbd.c
>> @@ -640,6 +640,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
>>                                             request_ret, qiov, payload=
,
>> errp);
>>
>>       if (ret < 0) {
>> +        memset(reply, 0, sizeof *reply);
>=20
> The call to memset() consumes more CPU time. I don't know how frequent =

> the "ret < 0" path is. The initialization ' =3D {0}' is cheaper.

Wrong.  The 'ret < 0' path only happens on error, while the '=3D {0}' pat=
h
happens on ALL cases including success (if you'll look at the generated
assembly code, gcc should emit the same assembly sequence for
zero-initialization of the struct, whether that is a call to memset() or
just inline assignments of zeros based on the small size of the struct,
whether or not your code uses memset or '=3D{}').  You don't need to
optimize the error case, because on error, your NBD connection is dead,
and you have worse problems.  Pre-initialization that is going to be
overwritten on success is worse (although probably immeasurably, because
it is likely in the noise) than exactly one initialization on any
control flow path.

> Is it safe to swap the operands in the condition in=20
> nbd_reply_chunk_iter_receive():
> 'if (s->quit || nbd_reply_is_simple(reply))' ?

Yes, swapping the conditional appears to fix the only use of reply where
it is used uninitialized, at least in the current state of the code (but
it took me longer to audit that).  So if we're going for a one-line fix
for both observations of the problem, changing the conditional instead
of a memset on error is also acceptable for now (and maybe makes the
error case slightly faster, but that's not a big deal, because the error
case already means the NBD connection has bigger problems) - but who
knows what future uses of reply might creep in to an unsuspecting patch
writer that doesn't see the (in)action at a distance?  Which way is more
maintainable, proving that the low-level code always initializes the
variable (easy, since that can be checked at a single function), or
proving that all high-level uses may pass in an uninitialized variable
that is still left uninit on error but that they only use the variable
on success (harder, since now you have to audit every single caller to
see how they use reply on failure)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--OG75EFUgsZ4Yg19yY9HefwIjucMqJP3Zu--

--Qe0txVy9b4H6kfIOCwj0GaVSzwyQ6bx3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0x3qsACgkQp6FrSiUn
Q2ptBQgAi6X3vQIfvi57sP1vdewsCUuhAEvpBqAVG+65sP+eTZL8IC0lUQScaJAo
QH+LV+DhAvOpJJKoJWVNlT4556l8Uvy/ZyqHpbuBsyyKwFiHuR1tDJVo10UsSu4V
JtO8s0tj5RD8YIJqNGbjbtR2Pk0eI3XhJ/KbwEB4eK8sBO5C9Ir4EgxvQyr21mb9
RWA0f1LKRh2sby+Q41PBXDakxyGS6XswIyyOsvdmgXRPzzuzP6B0iBvrbogz2/v9
seWYCKpxmzIJ5nc2H8DZiEAPIqbZmlCvc623BZ5Hk0mqN7O9jGt1XT7BYub8QIhd
O/J6M3Vxwnf9eVNWeoobOsNq/+Ep/Q==
=m8lD
-----END PGP SIGNATURE-----

--Qe0txVy9b4H6kfIOCwj0GaVSzwyQ6bx3l--

