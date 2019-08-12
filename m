Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF9EC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCEB20684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCEB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxHmZ-0000m8-NA
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 17:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42603)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hxHm0-0000HM-Dn
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hxHlz-0003M3-HF
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hxHlx-0003Jq-Aw; Mon, 12 Aug 2019 17:22:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 031E03090FEC;
 Mon, 12 Aug 2019 21:22:32 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 142CC6A74E;
 Mon, 12 Aug 2019 21:22:30 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726140954.31921-3-ptoscano@redhat.com>
 <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
 <20190729110830.GA5757@localhost.localdomain>
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
Message-ID: <6432a340-bf63-2850-4f8d-d16d060c5fb6@redhat.com>
Date: Mon, 12 Aug 2019 16:22:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729110830.GA5757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3LM0JWFQshhqvn8U8Ex5H1GX5YB8PlUsI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 12 Aug 2019 21:22:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com, mreitz@redhat.com,
 Pino Toscano <ptoscano@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3LM0JWFQshhqvn8U8Ex5H1GX5YB8PlUsI
Content-Type: multipart/mixed; boundary="xZXyVktSl9mjbPPTYR9C90wyIuieDXVjg";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, pkrempa@redhat.com, rjones@redhat.com,
 mreitz@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <6432a340-bf63-2850-4f8d-d16d060c5fb6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726140954.31921-3-ptoscano@redhat.com>
 <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
 <20190729110830.GA5757@localhost.localdomain>
In-Reply-To: <20190729110830.GA5757@localhost.localdomain>

--xZXyVktSl9mjbPPTYR9C90wyIuieDXVjg
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/29/19 6:08 AM, Kevin Wolf wrote:

>> On a different topic, how much of this work overlaps with the nbdkit s=
sh
>> plugin? Should we be duplicating efforts with both projects supporting=

>> ssh natively, or is it worth considering getting qemu out of the ssh
>> business and instead connecting to an nbd device provided by nbdkit
>> connecting to ssh?
>=20
> ssh behaves essentially like a filesystem whereas NBD behaves like a
> block device. This is especially relevant for everything related to the=

> file size. As far as I know, using an image format like qcow2 that want=
s
> to grow the image file isn't possible over NBD, whereas I expect it to
> work with the ssh block driver.

Resizing NBD devices isn't available yet, but it is rapidly moving
higher on my list of TODO items to implement as an extension (the ideas
for how it should work have been tossed around, but having code to back
up those ideas is the next step).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xZXyVktSl9mjbPPTYR9C90wyIuieDXVjg--

--3LM0JWFQshhqvn8U8Ex5H1GX5YB8PlUsI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1R2JYACgkQp6FrSiUn
Q2pvnggAm4fUtVSQa75BQ+MWMdln+hnFHqLelwz07FXzwD7yHUdFGmZKqyQlmuO/
XVbp21vLK3r/q7ygMKqvxYJoeWJKcf5AqmzSqER5K4NZXYStVM4BIAxDJUDhGkFy
Pkny+YD6QvfJWh04WLf4XfPDWI4NScwVz4odiJ7xOBI3HMeyZw+qmB1tHGvtT+D6
tgr6R6i+P0v2/YA7vIOoJzOWH40lxE6/Ks4odOTHmduO8aXpZ8m/HEgsUfA5dxie
nINCIy/oV2ZsHb5ijeKle06Yy6yDQ7esbdEorQkTmQjy7qhn+jw14PuF61SogQKC
kWyyJbhDDOehmcUkhW2KNwUw2q8AdQ==
=Ya0L
-----END PGP SIGNATURE-----

--3LM0JWFQshhqvn8U8Ex5H1GX5YB8PlUsI--

