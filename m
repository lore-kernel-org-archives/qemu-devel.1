Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE6C32751
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 02:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4D020B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 02:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4D020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvXl2-0001kR-Uq
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 22:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hvXkT-0001F2-6U
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 22:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hvXkS-0003lN-6j
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 22:01:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hvXkP-0003kc-Ub; Wed, 07 Aug 2019 22:01:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4AC8065F4B;
 Thu,  8 Aug 2019 02:01:44 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1113560BE1;
 Thu,  8 Aug 2019 02:01:40 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
 <20190618114328.55249-4-vsementsov@virtuozzo.com>
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
Message-ID: <c6fdfabd-7982-8608-559e-5a2c54d32ebb@redhat.com>
Date: Wed, 7 Aug 2019 21:01:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618114328.55249-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uam7jvwbPejuPVRssAZnWOZPwyEKr8i78"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 08 Aug 2019 02:01:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 3/9] block/nbd: move from quit to state
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
--uam7jvwbPejuPVRssAZnWOZPwyEKr8i78
Content-Type: multipart/mixed; boundary="4o04BDKGT2gJfJPl9lx1q9RoxCAtrKGdK";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <c6fdfabd-7982-8608-559e-5a2c54d32ebb@redhat.com>
Subject: Re: [PATCH v7 3/9] block/nbd: move from quit to state
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
 <20190618114328.55249-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190618114328.55249-4-vsementsov@virtuozzo.com>

--4o04BDKGT2gJfJPl9lx1q9RoxCAtrKGdK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/18/19 6:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> To implement reconnect we need several states for the client:
> CONNECTED, QUIT and two different CONNECTING states. CONNECTING states
> will be added in the following patches. This patch implements CONNECTED=

> and QUIT.
>=20
> QUIT means, that we should close the connection and fail all current
> and further requests (like old quit =3D true).
>=20
> CONNECTED means that connection is ok, we can send requests (like old
> quit =3D false).
>=20
> For receiving loop we use a comparison of the current state with QUIT,
> because reconnect will be in the same loop, so it should be looping
> until the end.
>=20
> Opposite, for requests we use a comparison of the current state with
> CONNECTED, as we don't want to send requests in future CONNECTING
> states.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/nbd.c | 58 ++++++++++++++++++++++++++++++++++-------------------=

>  1 file changed, 37 insertions(+), 21 deletions(-)

> @@ -556,7 +572,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk=
(
>      s->requests[i].receiving =3D true;
>      qemu_coroutine_yield();
>      s->requests[i].receiving =3D false;
> -    if (s->quit) {
> +    if (s->state !=3D NBD_CLIENT_CONNECTED) {
>          error_setg(errp, "Connection closed");
>          return -EIO;
>      }
> @@ -640,7 +656,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
>                                            request_ret, qiov, payload, =
errp);
> =20
>      if (ret < 0) {
> -        s->quit =3D true;
> +        nbd_channel_error(s, ret);

Minor merge conflict with changes in the meantime; easy enough to sort ou=
t.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4o04BDKGT2gJfJPl9lx1q9RoxCAtrKGdK--

--uam7jvwbPejuPVRssAZnWOZPwyEKr8i78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1LgoQACgkQp6FrSiUn
Q2r11Af/eBHj+ah95OdWcpuXaPLWBc1sSsu9Z91klKAJlZMzuQnh1Exbm+PGNLVX
nBTBTQ74zOlXO8ZMLykii9t/x+1xRp1mOCMCrIZG40TOpwO+tLzT7HIuSTKcieE4
nrQOhJ7BZ7FNGTAscaZkWgBwmZ+McHgBG5TwCVfGKhZirn5aRiZ/ZrBSDDhj51SR
0Vniq+LbIsNUwocR3N8I74/wsYV0sMdoDhLz3vDbqVdurLpgOZGAtJxWyEKuS8ZN
DnH/R8f8ANOET4FFthUrXjjFoeJoMX1Psaz5mgUYh/qc/p6/CVplq4dFHAYzXzHc
JedgnBQx3hwX8+5V7afCrQ0GK9EuqQ==
=zTId
-----END PGP SIGNATURE-----

--uam7jvwbPejuPVRssAZnWOZPwyEKr8i78--

