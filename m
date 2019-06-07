Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F588C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D6C208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D6C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKvr-00008F-V3
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46967)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hZJOf-0001Sh-Ad
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hZJOe-00030e-3r
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:15:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hZJOb-0002tw-EH; Fri, 07 Jun 2019 14:15:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3714B307D854;
 Fri,  7 Jun 2019 18:15:14 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 654092B027;
 Fri,  7 Jun 2019 18:15:06 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190606184159.979-1-jsnow@redhat.com>
 <20190606184159.979-3-jsnow@redhat.com>
 <70a53585-bdc6-1877-01f5-1b2d1aad8de6@virtuozzo.com>
 <e5bb6d0b-567f-2c2d-6415-93d79fece228@redhat.com>
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
Message-ID: <252579c4-b425-a7fa-ae14-f0ced12f0830@redhat.com>
Date: Fri, 7 Jun 2019 13:15:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e5bb6d0b-567f-2c2d-6415-93d79fece228@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="74H5XKN6hlWXBqhGOMpIc5g6vFwvFKwHO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 07 Jun 2019 18:15:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/5] block/dirty-bitmap: Refactor
 bdrv_can_store_new_bitmap
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--74H5XKN6hlWXBqhGOMpIc5g6vFwvFKwHO
Content-Type: multipart/mixed; boundary="8SqgWHEFKmwlf65a1kLx8ZaUMxYaYat5u";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <252579c4-b425-a7fa-ae14-f0ced12f0830@redhat.com>
Subject: Re: [PATCH 2/5] block/dirty-bitmap: Refactor
 bdrv_can_store_new_bitmap
References: <20190606184159.979-1-jsnow@redhat.com>
 <20190606184159.979-3-jsnow@redhat.com>
 <70a53585-bdc6-1877-01f5-1b2d1aad8de6@virtuozzo.com>
 <e5bb6d0b-567f-2c2d-6415-93d79fece228@redhat.com>
In-Reply-To: <e5bb6d0b-567f-2c2d-6415-93d79fece228@redhat.com>

--8SqgWHEFKmwlf65a1kLx8ZaUMxYaYat5u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/7/19 1:10 PM, John Snow wrote:
>=20
>=20
> On 6/7/19 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 06.06.2019 21:41, John Snow wrote:
>>> Instead of bdrv_can_store_new_bitmap, rework this as
>>> bdrv_add_persistent_dirty_bitmap. This makes a more obvious symmetry
>>> with bdrv_remove_persistent_dirty_bitmap. Most importantly, we are fr=
ee
>>> to modify the driver state because we know we ARE adding a bitmap
>>> instead of simply being asked if we CAN store one.
>>>
>>> As part of this symmetry, move this function next to
>>> bdrv_remove_persistent_bitmap in block/dirty-bitmap.c.
>>>
>>> To cement this semantic distinction, use a bitmap object instead of t=
he
>>> (name, granularity) pair as this allows us to set persistence as a
>>> condition of the "add" succeeding.
>>>
>>> Notably, the qcow2 implementation still does not actually store the n=
ew
>>> bitmap at add time, but merely ensures that it will be able to at sto=
re
>>> time.
>>>

>>> +int bdrv_add_persistent_dirty_bitmap(BlockDriverState *bs,
>>> +                                     BdrvDirtyBitmap *bitmap,
>>> +                                     Error **errp)
>>
>> strange thing for me: "bitmap" in function name is _not_ the same
>> thing as @bitmap argument.. as if it the same,
>> function adds "persistent bitmap", but @bitmap is not persistent yet,
>> so may be function, don't add persistent bitmap, but marks bitmap pers=
istent?
>>
>>
>> Ok, I can think of it like "add persistent dirty bitmap to driver. if =
succeed, set
>> bitmap.persistent flag"
>>
>=20
> Yeah, I meant "Add bitmap to file", where the persistence is implied
> because it's part of the file. The bitmap is indeed not YET persistent,=

> but becomes so as a condition of this call succeeding.
>=20
> Do you have a suggestion for a better name? I liked the symmetry with
> 'remove' so that there was an obvious "add bitmap" and "remove bitmap".=

>=20
> Of course, when you remove, it is indeed persistent, so
> "remove_persistent_dirty_bitmap" makes sense there.
>=20

Or maybe even merely 'bdrv_add_dirty_bitmap' with doc comments stating
that it associates an existing non-persistent bitmap with the bdrv
storage and marks it persistent if successful.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--8SqgWHEFKmwlf65a1kLx8ZaUMxYaYat5u--

--74H5XKN6hlWXBqhGOMpIc5g6vFwvFKwHO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz6qakACgkQp6FrSiUn
Q2pgmQgAgK413fwm90xHOcKTPMP+7armwhrqEL/EbntjUO2Dx5nXo7tNTZC40ThU
iGfPHIBCxXYS6x74DOCvyi4ngf1F0LHaAHgixh4P6J8dyZYWaWv3NgKjjmUuttZa
YIw0RdRlJdfInkDC8JtUwBbmEiXfFtNcLgsYFM/tCZwVzazqBFtN1/j1h/yP7kQH
YuKrlyJvFeqyW3V7xKCI+aP3p0YOL8Mlz9wGBqoG7RSNcVZW4QJgavxxgP/KSpJI
/V8e6jkc22Yfye7V60I2brbJBo6IAUYlAucnvi1dbbC5PmLTLZ6jQ+RAKcIScUUk
pT+P1tXnFpZKleA+dDCHXnE/Anpkxg==
=4HMu
-----END PGP SIGNATURE-----

--74H5XKN6hlWXBqhGOMpIc5g6vFwvFKwHO--

