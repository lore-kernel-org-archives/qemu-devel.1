Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39114C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 20:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB6020693
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 20:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB6020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoZVq-0005qF-0M
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 16:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37151)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hoZVf-0005Qu-IA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hoZVe-0007mb-2s
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:29:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hoZVd-0007cb-MV
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:29:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE581A3B6F;
 Fri, 19 Jul 2019 20:29:16 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E43B5579B7;
 Fri, 19 Jul 2019 20:29:11 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190614173140.19159-1-vsementsov@virtuozzo.com>
 <87v9wtn634.fsf@dusky.pond.sub.org>
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
Message-ID: <548af442-ed15-3065-ddbd-a3728a4e752c@redhat.com>
Date: Fri, 19 Jul 2019 15:29:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87v9wtn634.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="draai8Zms6z3r6p3mxTZftxmVvZjvkXzd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 19 Jul 2019 20:29:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] qapi: Add InetSocketAddress member
 keep-alive
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
Cc: den@openvz.org, berrange@redhat.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--draai8Zms6z3r6p3mxTZftxmVvZjvkXzd
Content-Type: multipart/mixed; boundary="npq6aa0XFlVEItDnSh5kH8r5waVsdxygx";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: den@openvz.org, kraxel@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <548af442-ed15-3065-ddbd-a3728a4e752c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qapi: Add InetSocketAddress member
 keep-alive
References: <20190614173140.19159-1-vsementsov@virtuozzo.com>
 <87v9wtn634.fsf@dusky.pond.sub.org>
In-Reply-To: <87v9wtn634.fsf@dusky.pond.sub.org>

--npq6aa0XFlVEItDnSh5kH8r5waVsdxygx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/25/19 8:32 AM, Markus Armbruster wrote:
> I apologize for dragging my feet on this review.
>=20
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> It's needed to provide keepalive for nbd client to track server
>> availability.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>

>> +++ b/qapi/sockets.json
>> @@ -53,6 +53,9 @@
>>  #
>>  # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and =
IPv6
>>  #
>> +# @keep-alive: enable keep-alive when connecting to this socket. Not =
supported
>> +#              for server-side connections. (Since 4.1)

It looks like this missed 4.1.  Are you planning on sending v4, to addres=
s

>> +#
>=20
> Is "server-side connection" is an established term?
>=20
> For what it's worth, "passive socket" is, see listen(2).
>=20
>>  # Since: 1.3
>>  ##
>>  { 'struct': 'InetSocketAddress',
>> @@ -61,7 +64,8 @@
>>      '*numeric':  'bool',
>>      '*to': 'uint16',
>>      '*ipv4': 'bool',
>> -    '*ipv6': 'bool' } }
>> +    '*ipv6': 'bool',
>> +    '*keep-alive': 'bool' } }
>> =20
>>  ##
>>  # @UnixSocketAddress:
>> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
>> index 8850a280a8..813063761b 100644
>> --- a/util/qemu-sockets.c
>> +++ b/util/qemu-sockets.c
>> @@ -438,6 +438,12 @@ int inet_connect_saddr(InetSocketAddress *saddr, =
Error **errp)
>>      struct addrinfo *res, *e;
>>      int sock =3D -1;
>> =20
>> +    if (saddr->keep_alive) {
>> +        error_setg(errp, "keep-alive options is not supported for ser=
ver-side "
>> +                   "connection");
>> +        return -1;
>> +    }
>> +
>>      res =3D inet_parse_connect_saddr(saddr, errp);
>>      if (!res) {
>>          return -1;
>=20
> I'm afraid you added this to the wrong function; ...
>=20
>> @@ -457,6 +463,19 @@ int inet_connect_saddr(InetSocketAddress *saddr, =
Error **errp)
>>      }
>> =20
>>      freeaddrinfo(res);
>> +
>> +    if (saddr->keep_alive) {
>=20
> ... it renders this code unreachable.
>=20
> I guess the "not supported for passive sockets" check should go into
> inet_listen_saddr() instead.

this comment?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--npq6aa0XFlVEItDnSh5kH8r5waVsdxygx--

--draai8Zms6z3r6p3mxTZftxmVvZjvkXzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0yKBcACgkQp6FrSiUn
Q2qVVQgAr/VNsONEONXu+FPq7EEGbd3Lw1A+S/bzFNeoF6Hwe2TYUO2pR4y+BG+P
NIPJoz2K2MYBgaHqIYYeCaW0SxkcGthl7ytc9Ntq8IPADMYBwWh/gPPDVK1iB9lR
eK/gv/mU7QPmcL/wseLqg8AIxHDCFkR4+ca0tVNlOJfzXCEQV/XkK0TnRRLwz48D
JbVmvpYsrZCDBFxqwRh46dsRqClciiH/EMBduiku8Fwkjt3e2LcaNkpQ4pSfV/LH
lTV55VS3jIL52Gq/Vh/9GM3Wf7enw+AUDLAbTqCU30yFyz+G4wvuMX0otP/Y9mYt
dQ1IwcHANbN0mobzOVqNydC7X/Q23A==
=IaXg
-----END PGP SIGNATURE-----

--draai8Zms6z3r6p3mxTZftxmVvZjvkXzd--

