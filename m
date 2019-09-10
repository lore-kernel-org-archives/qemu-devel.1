Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FAC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E232082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E232082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jQJ-0000z7-Ru
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i7jDz-0003YG-AF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i7jDx-000604-VX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:42:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i7jDx-0005zc-Lz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:42:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFB9A300BEAC;
 Tue, 10 Sep 2019 16:42:36 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A2A85D9DC;
 Tue, 10 Sep 2019 16:42:34 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-14-armbru@redhat.com>
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
Message-ID: <60b61f7c-fe08-e78b-dd52-775959af99d9@redhat.com>
Date: Tue, 10 Sep 2019 11:42:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910063724.28470-14-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rTgNV085A5fAp8vdPley3C2BjHEZiKZp0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 10 Sep 2019 16:42:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 13/16] docs/devel/qapi-code-gen: Rewrite
 compatibility considerations
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rTgNV085A5fAp8vdPley3C2BjHEZiKZp0
Content-Type: multipart/mixed; boundary="Y1lvbK758f6qRbHE6aZjNT52jPxyRmqLe";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <60b61f7c-fe08-e78b-dd52-775959af99d9@redhat.com>
Subject: Re: [PATCH v2 13/16] docs/devel/qapi-code-gen: Rewrite compatibility
 considerations
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-14-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-14-armbru@redhat.com>

--Y1lvbK758f6qRbHE6aZjNT52jPxyRmqLe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/10/19 1:37 AM, Markus Armbruster wrote:
> We have some compatibility advice buried in sections "Enumeration
> types" and "Struct types".  Compatibility is actually about commands
> and events.  It devolves to the types used there.  All kinds of types,
> not just enumerations and structs.
>=20
> Replace the existing advice by a new section "Compatibility
> considerations".
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 95 +++++++++++++++++++++++-------------=

>  1 file changed, 60 insertions(+), 35 deletions(-)
>=20

> +=3D=3D Compatibility considerations =3D=3D
> +
> +Maintaining backward compatibility at the Client JSON Protocol level
> +while evolving the schema requires some care.  This section is about
> +syntactic compatibility.  Necessary, but not sufficient for actual
> +compatibility.

This last sentence no verb.  Maybe:

s/compatibility.  Necessary/compatibility, which is necessary/
s/sufficient/sufficient,/

> +
> +Clients send commands with argument data, and receive command
> +responses with return data and events with event data.
> +
> +Adding opt-in functionality to the send direction is backwards
> +compatible: adding commands, optional arguments, enumeration values,
> +union and alternate branches; turning an argument type into an
> +alternate of that type; making mandatory arguments optional.  Clients
> +oblivious of the new functionality continue to work.
> +
> +Incompatible changes include removing commands, command arguments,
> +enumeration values, union and alternate branches, adding mandatory
> +command arguments, and making optional arguments mandatory.
> +
> +The specified behavior of an absent optional argument should remain
> +the same.  With proper documentation, this policy still allows some
> +flexibility; for example, when an optional 'buffer-size' argument is
> +specified to default to a sensible buffer size, the actual default
> +value can still be changed.  The specified default behavior is not the=

> +exact size of the buffer, only that the default size is sensible.
> +
> +Adding functionality to the receive direction is generally backwards
> +compatible: adding events, adding return and event data members.
> +Clients are expected to ignore the ones they don't know.
> +
> +Removing "unreachable" stuff like events that can't be triggered
> +anymore, optional return or event data members that can't be sent
> +anymore, and return or event data member (enumeration) values that
> +can't be sent anymore makes no difference to clients, except for
> +introspection.  The latter can conceivably confuse clients, so tread
> +carefully.
> +
> +Incompatible changes include removing return and event data members.
> +
> +Any change to a command definition's 'data' or one of the types used
> +there (recursively) needs to consider send direction compatibility.
> +
> +Any change to a command definition's 'return', an event definition's
> +'data', or one of the types used there (recursively) needs to consider=

> +receive direction compatibility.
> +
> +Any change to types used in both contexts need to consider both.
> +
> +Members of enumeration types, complex types and alternate types may be=

> +reordered freely.  For enumerations and alternate types, this doesn't
> +affect the wire encoding.  For complex types, this might make the
> +implementation emit JSON object members in a different order, which
> +the Client JSON Protocol permits.

Worth mentioning that type names themselves are NOT part of the
interface, and may be freely renamed?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Y1lvbK758f6qRbHE6aZjNT52jPxyRmqLe--

--rTgNV085A5fAp8vdPley3C2BjHEZiKZp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl130nkACgkQp6FrSiUn
Q2rqSAgAsHdakyxwYhtIvgSgLG2s6sV9bfHR89ZhGSj0yo/uUN2iy/vSugYBZpcj
90Hi8KOO3h2jnXCTKO0SIFV4/w/wCcPdnQ2yqi8j5xmGuhrE6/HPJ0p8RXHNU9nf
4N0SYFjA6ZbKHyEXKU6bYrmqDcY+38V9rXbzZRQek57C3mjUhDYOt/u/vdedkaE5
HBAhF4DWBPKdgDYmY2ntcq8AYBsE9B7lCpihZqInEQH+6Uxx4j9EeK+XWt1gF38h
WlM5eapEYMEMep7OgOa3rA/2pfbvPe3oTrY2Y4iobpzzOUIaWpYvlMGYf454ZgfV
3i/13ZytX+90oJMssIMPX0dQVOp5XQ==
=x7ZW
-----END PGP SIGNATURE-----

--rTgNV085A5fAp8vdPley3C2BjHEZiKZp0--

