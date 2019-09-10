Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362B6C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE5521479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE5521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7i52-0005MN-5t
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i7i4M-0004oY-Ia
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i7i4L-0006Ph-JD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i7i4L-0006PM-B0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:28:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9270830821BF;
 Tue, 10 Sep 2019 15:28:36 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B766012D;
 Tue, 10 Sep 2019 15:28:30 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-8-armbru@redhat.com>
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
Message-ID: <88fcdceb-85f8-ff7b-97b0-588ed45ba021@redhat.com>
Date: Tue, 10 Sep 2019 10:28:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910063724.28470-8-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bpqU2em9yIKdXkL2zKvzKKE9xdxbYvAvC"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 10 Sep 2019 15:28:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/16] qapi: Drop support for escape
 sequences other than \\
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
--bpqU2em9yIKdXkL2zKvzKKE9xdxbYvAvC
Content-Type: multipart/mixed; boundary="LzZvFDsjc4CWW8WA2neOQ4sOlNZPSm06H";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <88fcdceb-85f8-ff7b-97b0-588ed45ba021@redhat.com>
Subject: Re: [PATCH v2 07/16] qapi: Drop support for escape sequences other
 than \\
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-8-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-8-armbru@redhat.com>

--LzZvFDsjc4CWW8WA2neOQ4sOlNZPSm06H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/10/19 1:37 AM, Markus Armbruster wrote:
> Since the previous commit restricted strings to printable ASCII,
> \uXXXX's only use is obfuscation.  Drop it.
>=20
> This leaves \\, \/, \', and \".  Since QAPI schema strings are all
> names, and names are restricted to ASCII letters, digits, hyphen, and
> underscore, none of them is useful.
>=20
> The latter three have no test coverage.  Drop them.
>=20
> Keep \\ to avoid (more) gratuitous incompatibility with JSON.

We have to parse it (to get a sane error message for someone writing
"a\b" and thinking they were getting a backspace), but we can still
reject "a\\b" as being a non-QAPI-name.  An alternative might be to
reject QAPI strings the moment \ is encountered (as the only possible
use is to introduce a character that is not valid as a name), to the
point that we could check for name validity at the time we parse strings
rather than later on.  Up to you.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---


> --- a/tests/qapi-schema/escape-outside-string.err
> +++ /dev/null
> @@ -1 +0,0 @@
> -tests/qapi-schema/escape-outside-string.json:3:27: Stray "\"

Do we still want to test that \ is an invalid character outside of
strings (whether or not \ is also made invalid inside strings)?

> +++ b/tests/qapi-schema/unknown-escape.json
> @@ -1,3 +1,3 @@
> -# we only recognize JSON escape sequences, plus our \' extension (no \=
x)
> +# we only recognize \\
>  # { 'command': 'foo', 'data': {} }
>  { 'command': 'foo', 'dat\x61':{} }
>=20

At any rate, this change seems reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--LzZvFDsjc4CWW8WA2neOQ4sOlNZPSm06H--

--bpqU2em9yIKdXkL2zKvzKKE9xdxbYvAvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl13wR4ACgkQp6FrSiUn
Q2r5SQf/SdWYPCuUVB1ww7VmRYdfoPr6/So7YTgFNSGd/48qlRfQ1X/PHAGN8qNe
8ThrHbK2Kr4TdEparnkY23j6B4iZxZVXveYXqLjTZFeA1KwFhzrK6IiqM79pMAM/
8DRV/o53tMvybz4J5vxtbuXvSHcm9k4oFfl927RjhpIPwyJOAL+8hSnd7i7HNXoc
psY/+fRX0+FyAXCH7WxqDj6Ok0LLWSZwlJldTjHQQq7acGaHtK4GHfDJmmu3nqF2
oI8XUtKl8rmx6GURYQE2ngZVQ6dUkbLc1Ay0huL6Jwc4tWNZXg4BV5nFTYZQZ5qX
6vificHxGHnLPbubOw5iMOXGcY4LEg==
=9eR0
-----END PGP SIGNATURE-----

--bpqU2em9yIKdXkL2zKvzKKE9xdxbYvAvC--

