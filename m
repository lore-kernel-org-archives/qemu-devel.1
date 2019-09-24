Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD0C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3731207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3731207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoxh-0005np-LT
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCowb-0004z7-Mh
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCowY-0001Pk-S4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:49:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iCowY-0001PH-IL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6A5A300CB2B;
 Tue, 24 Sep 2019 17:49:40 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39B5A5D9CA;
 Tue, 24 Sep 2019 17:49:35 +0000 (UTC)
Subject: Re: [PATCH 16/25] qapi: Move context-sensitive checking to the proper
 place
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-17-armbru@redhat.com>
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
Message-ID: <15b817d6-afa5-53c0-1fdd-2af4ad2a0bd8@redhat.com>
Date: Tue, 24 Sep 2019 12:49:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924132830.15835-17-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YXcU3n1uqZgESWtipECgN7UM5qlPuHZZb"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 24 Sep 2019 17:49:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
--YXcU3n1uqZgESWtipECgN7UM5qlPuHZZb
Content-Type: multipart/mixed; boundary="B1SLAKtOonigmG2sYWzIrVvVtfqpI0tfi";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <15b817d6-afa5-53c0-1fdd-2af4ad2a0bd8@redhat.com>
Subject: Re: [PATCH 16/25] qapi: Move context-sensitive checking to the proper
 place
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-17-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-17-armbru@redhat.com>

--B1SLAKtOonigmG2sYWzIrVvVtfqpI0tfi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 8:28 AM, Markus Armbruster wrote:
> When we introduced the QAPISchema intermediate representation (commit
> ac88219a6c7), we took a shortcut: we left check_exprs() & friends
> alone instead of moving semantic checks into the
> QAPISchemaFOO.check().  The .check() assert check_exprs() did its job.
>=20
> Time to finish the conversion job.  Move exactly the context-sensitive
> checks to the .check().  They replace assertions there.  Context-free
> checks stay put.
>=20
> Fixes the misleading optional tag error demonstrated by test
> flat-union-optional-discriminator.
>=20
> A few other error message improve.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index f5599559ac..ac4c898e51 100644
> --- a/scripts/qapi/common.py

Thankfully, our large coverage of tests goes a long way to show that the
conversion is correct.  I didn't notice anything obvious that might have
been overlooked (we may still find things down the road, but I'm not
going to hold up this patch trying to find those things).  Meanwhile,
the conversion from assert to conditionals inside .check() looks complete=
=2E


> +++ b/tests/qapi-schema/args-union.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/args-union.json: In command 'oops':
> -tests/qapi-schema/args-union.json:3: 'data' for command 'oops' cannot =
use union type 'Uni'
> +tests/qapi-schema/args-union.json:3: command's 'data' can take union t=
ype 'Uni' only with 'boxed': true

This one is definitely nicer.

> +++ b/tests/qapi-schema/flat-union-discriminator-bad-name.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/flat-union-discriminator-bad-name.json: In union 'My=
Union':
> -tests/qapi-schema/flat-union-discriminator-bad-name.json:7: discrimina=
tor of flat union 'MyUnion' uses invalid name '*switch'
> +tests/qapi-schema/flat-union-discriminator-bad-name.json:6: discrimina=
tor '*switch' is not a member of 'base'
> diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.json b=
/tests/qapi-schema/flat-union-discriminator-bad-name.json
> index ea84b75cac..3ae8c06a89 100644
> --- a/tests/qapi-schema/flat-union-discriminator-bad-name.json
> +++ b/tests/qapi-schema/flat-union-discriminator-bad-name.json
> @@ -1,5 +1,4 @@
>  # discriminator '*switch' isn't a member of base, 'switch' is
> -# reports "uses invalid name", which is good enough
>  { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
>  { 'struct': 'Base',
>    'data': { '*switch': 'Enum' } }

I find this one to be borderline in quality (if we have '*switch' in the
base, claiming that '*switch' is not a member of base is confusing until
you realize that base actually has an optional member named 'switch') -
but anyone that actually stumbles into this one will probably quickly
figure out their problem, and we may be revisiting it later anyways when
we finally include patches for a default discriminator.

> +++ b/tests/qapi-schema/flat-union-optional-discriminator.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/flat-union-optional-discriminator.json: In union 'My=
Union':
> -tests/qapi-schema/flat-union-optional-discriminator.json:7: discrimina=
tor 'switch' is not a member of 'base'
> +tests/qapi-schema/flat-union-optional-discriminator.json:6: discrimina=
tor member 'switch' of base type 'Base' must not be optional
> diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b=
/tests/qapi-schema/flat-union-optional-discriminator.json
> index 143ab23a0d..2e7f766f60 100644
> --- a/tests/qapi-schema/flat-union-optional-discriminator.json
> +++ b/tests/qapi-schema/flat-union-optional-discriminator.json
> @@ -1,5 +1,4 @@
>  # we require the discriminator to be non-optional
> -# FIXME reports "discriminator 'switch' is not a member of base struct=
 'Base'"
>  { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
>  { 'struct': 'Base',
>    'data': { '*switch': 'Enum' } }

And while the other one is borderline, I agree that this one is better.

> +++ b/tests/qapi-schema/union-unknown.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/union-unknown.json: In union 'Union':
> -tests/qapi-schema/union-unknown.json:2: member 'unknown' of union 'Uni=
on' uses unknown type 'MissingType'
> +tests/qapi-schema/union-unknown.json:2: union uses unknown type 'Missi=
ngType'
> diff --git a/tests/qapi-schema/union-unknown.json b/tests/qapi-schema/u=
nion-unknown.json
> index aa7e8143d8..64d3666176 100644
> --- a/tests/qapi-schema/union-unknown.json
> +++ b/tests/qapi-schema/union-unknown.json
> @@ -1,3 +1,3 @@
>  # we reject a union with unknown type in branch
>  { 'union': 'Union',
> -  'data': { 'unknown': 'MissingType' } }
> +  'data': { 'unknown': ['MissingType'] } }
>=20

And here you covered one more code path by going through an array type.

Overall looks good.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--B1SLAKtOonigmG2sYWzIrVvVtfqpI0tfi--

--YXcU3n1uqZgESWtipECgN7UM5qlPuHZZb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KVy4ACgkQp6FrSiUn
Q2q3bgf+JDXdVEv01z6fAbRH/bOIfB63gs1yuHxYPZuMZuW+q8JjQA45Rm+wgfay
17AFgvo9NyRWHw6inXDG+FhCDPIzfr0xaNfGE4bfDYEclPYbQTiUwcsHk6tCIx+s
Z5xxgfrFrrWFtHntY+CvoOkKisDbQBj57iKt7FnO1gmbFZNakMJpVJrOVTPX/fcU
kjsRexHgXvKoxLwkLtfmHF43mgn9GwQPVrGpV1hzkGcjvSRpY3GGSHUbrEDWL/Hu
CsZjauJQdD3sW/ThBj9XWlP/UiTIuD+lRLB6iJCGqLNptjAiAqIGUgMsXnk87yvF
D+rrKD/UEEC2XwjAh4sFIJ72XsSQWQ==
=NHu6
-----END PGP SIGNATURE-----

--YXcU3n1uqZgESWtipECgN7UM5qlPuHZZb--

