Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A595C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6052214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6052214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCqiK-0003iM-3s
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 15:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCqhO-00032H-VX
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCqhM-0002U3-5G
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iCqhL-0002Tj-R1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E907B19D369;
 Tue, 24 Sep 2019 18:46:44 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE25E600CC;
 Tue, 24 Sep 2019 18:46:38 +0000 (UTC)
Subject: Re: [PATCH 21/25] qapi: Avoid redundant definition references in
 error messages
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-22-armbru@redhat.com>
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
Message-ID: <1e6435a5-b059-ba0a-f881-8c7512560df1@redhat.com>
Date: Tue, 24 Sep 2019 13:46:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924132830.15835-22-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="17X3jkg5qB8qQbhrXbfQCTTbmimVqMnkT"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 24 Sep 2019 18:46:53 +0000 (UTC)
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
--17X3jkg5qB8qQbhrXbfQCTTbmimVqMnkT
Content-Type: multipart/mixed; boundary="HW5pj7C9nNMdxZy7omsghS4TNZqyvAbCH";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <1e6435a5-b059-ba0a-f881-8c7512560df1@redhat.com>
Subject: Re: [PATCH 21/25] qapi: Avoid redundant definition references in
 error messages
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-22-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-22-armbru@redhat.com>

--HW5pj7C9nNMdxZy7omsghS4TNZqyvAbCH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 8:28 AM, Markus Armbruster wrote:
> Many error messages refer to the offending definition even though
> they're preceded by an "in definition" line.  Rephrase them.

This is the cleanup promised earlier in the series.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py                        | 113 +++++++-----------=

>  tests/qapi-schema/alternate-array.err         |   2 +-

>  def check_command(expr, info):
> -    name =3D expr['command']
>      args =3D expr.get('data')
>      boxed =3D expr.get('boxed', False)
> =20
>      if boxed and args is None:
>          raise QAPISemError(info, "'boxed': true requires 'data'")
> -    check_type(args, info, "'data' for command '%s'" % name,
> -               allow_dict=3Dnot boxed)
> -    check_type(expr.get('returns'), info,
> -               "'returns' for command '%s'" % name,
> -               allow_array=3DTrue)
> +    check_type(expr.get('data'), info, "'data'", allow_dict=3Dnot boxe=
d)
> +    check_type(expr.get('returns'), info, "'returns'", allow_array=3DT=
rue)

Why are you repeating expr.get('dat') here instead of reusing args?  I
guess it adds consistency with the expr.get('returns') in the next line.

> =20
> =20
>  def check_event(expr, info):
> -    name =3D expr['event']
>      args =3D expr.get('data')
>      boxed =3D expr.get('boxed', False)
> =20
>      if boxed and args is None:
>          raise QAPISemError(info, "'boxed': true requires 'data'")
> -    check_type(args, info, "'data' for event '%s'" % name,
> -               allow_dict=3Dnot boxed)
> +    check_type(expr.get('data'), info, "'data'", allow_dict=3Dnot boxe=
d)
Again, why not reuse args?


> +++ b/tests/qapi-schema/args-member-case.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/args-member-case.json: In command 'no-way-this-will-=
get-whitelisted':
> -tests/qapi-schema/args-member-case.json:2: member of 'data' for comman=
d 'no-way-this-will-get-whitelisted' uses uppercase in name 'Arg'
> +tests/qapi-schema/args-member-case.json:2: 'data' member 'Arg' uses up=
percase in name 'Arg'

Better, but still feels redundant for calling out 'Arg' twice.  Maybe
you further clean this one later?

> +++ b/tests/qapi-schema/enum-member-case.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/enum-member-case.json: In enum 'NoWayThisWillGetWhit=
elisted':
> -tests/qapi-schema/enum-member-case.json:4: member of enum 'NoWayThisWi=
llGetWhitelisted' uses uppercase in name 'Value'
> +tests/qapi-schema/enum-member-case.json:4: 'data' member uses uppercas=
e in name 'Value'

Here's a similar error about uppercase that does not have the
redundancy, for comparison.


> +++ b/tests/qapi-schema/union-branch-case.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/union-branch-case.json: In union 'Uni':
> -tests/qapi-schema/union-branch-case.json:2: member of union 'Uni' uses=
 uppercase in name 'Branch'
> +tests/qapi-schema/union-branch-case.json:2: 'data' member 'Branch' use=
s uppercase in name 'Branch'

Another related one.

> +++ b/tests/qapi-schema/union-optional-branch.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/union-optional-branch.json: In union 'Union':
> -tests/qapi-schema/union-optional-branch.json:2: member of union 'Union=
' uses invalid name '*a'
> +tests/qapi-schema/union-optional-branch.json:2: 'data' member '*a' use=
s invalid name '*a'

Similar type of redundancy, but this time not related to uppercase.

Overall an improvement.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HW5pj7C9nNMdxZy7omsghS4TNZqyvAbCH--

--17X3jkg5qB8qQbhrXbfQCTTbmimVqMnkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KZI0ACgkQp6FrSiUn
Q2rCbgf/c7D38Ld1Vvns7oy0n8hRtloYSsZ6k72iqr1BGOW7zwE9T3qRz342syfP
qEzrLLZ2e/90VA2LetdMviKtRjHvyNds648+eVAZQ7cwJrX8IRDE0bWnmnlfUV3R
4j0JQF4wi8/0owIsYqCbkUL7vJSrw1JAdGxs+b5Q6Nt4v4gAnw4EKAZYxPB+pzxE
uuCz5IDeNrGGs8g9uv9neD8VPm7XknTCKohgFcR8QUMSt+IhhEO4EEJ+XE/rOHNc
zS2UpiXWrw5gGlYZSaSaona9xxO1AzhBmkectQKRKhxb0psv2h3b1qf3/gf6wGSO
KaxD6lbbZF8iFchvt72/4lDbP/ux1A==
=OY0e
-----END PGP SIGNATURE-----

--17X3jkg5qB8qQbhrXbfQCTTbmimVqMnkT--

