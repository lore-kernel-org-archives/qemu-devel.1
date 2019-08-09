Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE8BC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206A220C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206A220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw6zn-0005Uw-Bg
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50128)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hw6z8-0004zk-Fa
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hw6z7-00071J-En
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hw6z5-00070C-5U; Fri, 09 Aug 2019 11:39:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 479133067289;
 Fri,  9 Aug 2019 15:39:14 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 280841001956;
 Fri,  9 Aug 2019 15:39:07 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
 <20190618114328.55249-8-vsementsov@virtuozzo.com>
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
Message-ID: <2375ac0d-f7b1-8ddb-03ab-2a0e7e8885fc@redhat.com>
Date: Fri, 9 Aug 2019 10:39:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618114328.55249-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Cm6vvV9HKlee57jGXobL0RitmNjXVUzop"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 09 Aug 2019 15:39:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 7/9] qemu/units: add SI decimal units
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cm6vvV9HKlee57jGXobL0RitmNjXVUzop
Content-Type: multipart/mixed; boundary="HiLtQ3DdZ8XCWIKAvt4hCw70UY75O2AIj";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <2375ac0d-f7b1-8ddb-03ab-2a0e7e8885fc@redhat.com>
Subject: Re: [PATCH v7 7/9] qemu/units: add SI decimal units
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
 <20190618114328.55249-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190618114328.55249-8-vsementsov@virtuozzo.com>

--HiLtQ3DdZ8XCWIKAvt4hCw70UY75O2AIj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/18/19 6:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/units.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/qemu/units.h b/include/qemu/units.h
> index 692db3fbb2..52ccc7445c 100644
> --- a/include/qemu/units.h
> +++ b/include/qemu/units.h
> @@ -17,4 +17,11 @@
>  #define PiB     (INT64_C(1) << 50)
>  #define EiB     (INT64_C(1) << 60)
> =20
> +#define SI_k 1000LL
> +#define SI_M 1000000LL
> +#define SI_G 1000000000LL
> +#define SI_T 1000000000000LL
> +#define SI_P 1000000000000000LL
> +#define SI_E 1000000000000000000LL

Looks correct; and it's the sort of thing that if we do once here, we
don't have to repeat elsewhere. But bike-shedding a bit, would it be any
easier to read as:

#define SI_k 1000LL
#define SI_M (1000LL * 1000)
#define SI_G (1000LL * 1000 * 1000)
=2E..

or even:

#define SI_k 1000LL
#define SI_M (SI_k * 1000)
#define SI_G (SI_M * 1000)
=2E..

Also, would it be worth swapping out existing constants in the code base
that should instead be using these macros, so that they actually have a
use and so that we can see whether using them adds legibility?

For example, block/nvme.c, block/qapi.c, block/sheepdog.c, blockdev.c,
util/async.c, util/oslib-win32.c, util/qemu-thread-posix.c,
util/qemu-timer.c all seem to be dealing with conversions between
seconds and subdivisions thereof, where constants 1000000 or larger are
in use and could be rewritten with these.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HiLtQ3DdZ8XCWIKAvt4hCw70UY75O2AIj--

--Cm6vvV9HKlee57jGXobL0RitmNjXVUzop
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1Nk5oACgkQp6FrSiUn
Q2olbwf9EiWMfQORaB72qRUOnv/d8xbrsMvwfspNTXKENFxPQjpEsxO691KWyxLE
pOZuCoLOSKIRV2gYjnxh/rGzMlOhkVlpPSUJIueQRto6IYcxpJ5We1365GzBqVPY
/yoKHvpXf68qwFjBLwSeuV04NZEob07wJ0qYhf7uSxI1GeDEj8jpb7kKX/q8SJpy
LaMc6XAoS6LMLMHabf4dfBTPq2Hz2XkwVMzr8cNueBkzWmQUPgrLoYmvpITQyrsT
AIKib/8H38V2yFFlEdt+l1gg0ZSsG+QLSOHVh6NCBCelN3H9amSbh2BEllhTHigz
GxZH7jRJtSdKsUznWL8X3oXwZxva1w==
=4xJq
-----END PGP SIGNATURE-----

--Cm6vvV9HKlee57jGXobL0RitmNjXVUzop--

