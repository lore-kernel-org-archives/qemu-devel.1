Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C25C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF4521881
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF4521881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hzK-0000vZ-G1
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i7hyc-0000QJ-Ch
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i7hya-0002MW-EY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:22:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i7hya-0002MH-6O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:22:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58AA610CC1FE;
 Tue, 10 Sep 2019 15:22:39 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3B1B1001B01;
 Tue, 10 Sep 2019 15:22:33 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-7-armbru@redhat.com>
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
Message-ID: <fedc30f3-4b34-4a1d-8791-a294b9cdc646@redhat.com>
Date: Tue, 10 Sep 2019 10:22:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910063724.28470-7-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p5BpIuTYSHmPb4alVlVwrly6jFMIB3lWX"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 10 Sep 2019 15:22:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/16] qapi: Restrict strings to
 printable ASCII
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
--p5BpIuTYSHmPb4alVlVwrly6jFMIB3lWX
Content-Type: multipart/mixed; boundary="I9vZwxX9wq0NYrFqTZzvD750AuHykzSO0";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <fedc30f3-4b34-4a1d-8791-a294b9cdc646@redhat.com>
Subject: Re: [PATCH v2 06/16] qapi: Restrict strings to printable ASCII
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-7-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-7-armbru@redhat.com>

--I9vZwxX9wq0NYrFqTZzvD750AuHykzSO0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/10/19 1:37 AM, Markus Armbruster wrote:
> RFC 8259 on string contents:
>=20
>    All Unicode characters may be placed within the quotation marks,
>    except for the characters that MUST be escaped: quotation mark,
>    reverse solidus, and the control characters (U+0000 through
>    U+001F).
>=20
> The QAPI schema parser accepts both less and more than JSON: it
> accepts only ASCII with \u (less), and accepts control characters
> other than LF (new line) unescaped.  How it treats unescaped non-ASCII
> input differs between Python 2 and Python 3.
>=20
> Make it accept strictly less: require printable ASCII.  Drop support
> for \b, \f, \n, \r, \t.

Fair enough.  It doesn't prevent QMP clients from sending strings with
non-ASCII characters, merely that those strings will never match the
schema because we have guaranteed our schema is limited to ASCII.  (This
change means we are promising to never allow { "execute": "a\tb" } as a
valid QMP command, for instance.)

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> @@ -523,17 +523,7 @@ class QAPISchemaParser(object):
>                      if ch =3D=3D '\n':
>                          raise QAPIParseError(self, 'Missing terminatin=
g "\'"')
>                      if esc:
> -                        if ch =3D=3D 'b':
> -                            string +=3D '\b'
> -                        elif ch =3D=3D 'f':
> -                            string +=3D '\f'
> -                        elif ch =3D=3D 'n':
> -                            string +=3D '\n'

Is it worth a comment in the code that we are specifically not parsing
all possible JSON escapes, because of the later requirement that QAPI
strings be limited to the subset of printable ASCII?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--I9vZwxX9wq0NYrFqTZzvD750AuHykzSO0--

--p5BpIuTYSHmPb4alVlVwrly6jFMIB3lWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl13v7gACgkQp6FrSiUn
Q2p4YggAj+QEGfKTCQpZsm/2xrUguaebuGJhDGpk12nihwGzzfUga0smrv0Ns5BU
7R9r2z3rIhz3DJ57HUbeh8rsXcZhQLSsPFKU3QcJehm/S1242NpzWflxfrvV7Gd/
mywVv3Z6H63No1ZpQ2oVohBPUCdEWlX4jloCemWoVeDnljkrILOEiQ7At5H1PuqU
EIQdXVX0bSlYZ6Qo2z1Fz9GqYw0RBQqvFcz+Gy6WTZrN6DwFwml4Q8uRQjT8/pGF
J/9leU9YwEVQIyswrZ/DNyWr2vO6YOBj746R3h8a0mvOOYv6Lggakf881d8zMTjD
v6w/rUrIl3G1CH+Me+/pf1cd2Yuw2Q==
=0MOR
-----END PGP SIGNATURE-----

--p5BpIuTYSHmPb4alVlVwrly6jFMIB3lWX--

