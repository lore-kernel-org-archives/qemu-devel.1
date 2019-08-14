Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09569C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 15:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04DF2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 15:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04DF2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxv1G-0003jf-Qy
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 11:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hxv09-0002jH-4F
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 11:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hxv07-0004sR-QS
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 11:15:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33719)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hxv04-0004pu-RV; Wed, 14 Aug 2019 11:15:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4565308339B;
 Wed, 14 Aug 2019 15:15:43 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 052C580A28;
 Wed, 14 Aug 2019 15:15:39 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-3-vsementsov@virtuozzo.com>
 <ead713c5-ed20-096c-40cb-a4bb4b3658a6@redhat.com>
 <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>
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
Message-ID: <c439dd02-33fd-8b94-406d-dd14d5c10cde@redhat.com>
Date: Wed, 14 Aug 2019 10:15:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="11hudvIi82GLXYo2QzRAlBvPdgUlt7QQa"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 14 Aug 2019 15:15:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block/qcow2: refactor
 qcow2_co_preadv_part
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--11hudvIi82GLXYo2QzRAlBvPdgUlt7QQa
Content-Type: multipart/mixed; boundary="iKsKN3VKYU8axZRHLsJCjT7MUw8ludki7";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Message-ID: <c439dd02-33fd-8b94-406d-dd14d5c10cde@redhat.com>
Subject: Re: [PATCH v2 2/4] block/qcow2: refactor qcow2_co_preadv_part
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-3-vsementsov@virtuozzo.com>
 <ead713c5-ed20-096c-40cb-a4bb4b3658a6@redhat.com>
 <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>
In-Reply-To: <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>

--iKsKN3VKYU8axZRHLsJCjT7MUw8ludki7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/14/19 4:11 AM, Vladimir Sementsov-Ogievskiy wrote:
> 14.08.2019 0:31, Max Reitz wrote:
>> On 30.07.19 16:18, Vladimir Sementsov-Ogievskiy wrote:
>>> Further patch will run partial requests of iterations of
>>> qcow2_co_preadv in parallel for performance reasons. To prepare for
>>> this, separate part which may be parallelized into separate function
>>> (qcow2_co_preadv_task).
>>>
>>> While being here, also separate encrypted clusters reading to own
>>> function, like it is done for compressed reading.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---

>>> +     * but we must not do decryption in guest buffers for security
>>> +     * reasons.
>>
>> "for security reasons" is a bit handwave-y, no?
>=20
> Hmm, let's think of it a bit.
>=20
> WRITE
>=20
> 1. We can't do any operations on write buffers, as guest may use them f=
or
> something else and not prepared for their change. [thx to Den, pointed =
to this fact]
>=20
> READ
>=20
> Hmm, here otherwise, guest should not expect something meaningful in bu=
ffers until the
> end of read operation, so theoretically we may decrypt directly in gues=
t buffer.. What is
> bad with it?

The badness is that the guest can theoretically reverse-engineer the
encryption keys if they are savvy enough to grab the contents of the
buffer before and after.  The guest must NEVER be able to see the
encrypted bits, which means decryption requires a bounce buffer.

>=20
> 1. Making read-part different from write and implementing support of qi=
ov for decryptin for
> little outcome (hmm, don't double allocation for reads, is it little or=
 not? [*]).
>=20
> 2. Guest can read its buffers.
> So, it may see encrypted data and guess something about it. Ideally gue=
st
> should know nothing about encryption, but on the other hand, is there a=
ny
> real damage? I don't sure..

Yes, this is the security risk.

>=20
> 3. Guest can modify its buffers.
> 3.1 I think there is no guarantee that guest will not modify its data b=
efore we finished
> copying to separate buffer, so what guest finally reads is not predicta=
ble anyway.
> 3.2 But, modifying during decryption may possibly lead to guest visible=
 error
> (which will never be if we operate on separated cluster)
>=20
> So if we don't afraid of [2] and [3.2], and in a specific case [*] is s=
ignificant, we may want
> implement decryption on guest buffers at least as an option..
> But all it looks for me like we'll never do it.
>=20
> =3D=3D=3D
>=20
> So, I'd rewrite my "Note" like this:
>=20
>     Also, decryption in separate buffer is better as it hides from the =
guest information
>     it doesn't own (about encrypted nature of virtual disk).

Possible wording tweak:

Also, decryption in a separate buffer is better as it prevents the guest
from learning information about the encrypted nature of the virtual disk.=



>>> +    }
>>> +
>>> +    g_assert_not_reached();
>>> +
>>> +    return -EIO;
>>
>> Maybe abort()ing instead of g_assert_not_reach() would save you from
>> having to return here?
>>
>=20
> Hmm, will check. Any reason to use g_assert_not_reached() instead of ab=
ort() in "default"?
> I just kept it like it was. But it seems to be more often practice to u=
se just abort() in
> Qemu code.

Both are used. abort() is shorter to type, but g_assert_not_reach() is
slightly friendlier to developers (which are the only people that would
ever see the failure).  As both are marked noreturn, the real fix is to
drop the dead return -EIO line, the compiler is smart enough to not need
a return statement after a noreturn function.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iKsKN3VKYU8axZRHLsJCjT7MUw8ludki7--

--11hudvIi82GLXYo2QzRAlBvPdgUlt7QQa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1UJZoACgkQp6FrSiUn
Q2pKDwf+IjgOJV6zYYtKXs1Keld/EI9SFImv+c52cgTtZIZgxkdzqxJOF0MN2zY4
Wt0SB0Yixgol+vwS0WFKJDetnyggtgfeK5GijGNljicUbq954YvYRUdUwGtl1TMy
8tN6LExJnCETh9tennxojvmzgsPhnEJdmntZjqqm3EV7B1mlcNy/XGcJMqdbEU37
ota0E27RNEWLvZapxBO2GZWuTboixxvYW5fiG0RDjxwF0bG6EQQwcw+SUw1Y7ovK
fpo6q0e0qpaW2HGH2FZf5aBTUSu52teK+1MizBeaeIxty+Fu8WKQ5/rDaFbLw3QJ
L0xxDIl9RoJHEqfFWiat+Si2GYn80Q==
=glR7
-----END PGP SIGNATURE-----

--11hudvIi82GLXYo2QzRAlBvPdgUlt7QQa--

