Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC58BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE5F2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE5F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHbN-0006tr-HJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAHa4-0006Cg-Vp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAHa2-0005Jg-Oa
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAHa1-0005Ic-II
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:47:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5991A1DA0;
 Tue, 17 Sep 2019 17:47:54 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9AA25D9DC;
 Tue, 17 Sep 2019 17:47:51 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-6-armbru@redhat.com>
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
Message-ID: <ca7e3eba-98ba-56cb-574f-d9974f39122b@redhat.com>
Date: Tue, 17 Sep 2019 12:47:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190914153506.2151-6-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5sEFNuptRUu7BhyQvnRJUme0qYTzhDWQg"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 17 Sep 2019 17:47:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 05/19] tests/qapi-schema: Demonstrate
 insufficient 'if' checking
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
--5sEFNuptRUu7BhyQvnRJUme0qYTzhDWQg
Content-Type: multipart/mixed; boundary="HX4JmN5QSq5753khRmjhyMbn7mD9s1aQi";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <ca7e3eba-98ba-56cb-574f-d9974f39122b@redhat.com>
Subject: Re: [PATCH 05/19] tests/qapi-schema: Demonstrate insufficient 'if'
 checking
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-6-armbru@redhat.com>
In-Reply-To: <20190914153506.2151-6-armbru@redhat.com>

--HX4JmN5QSq5753khRmjhyMbn7mD9s1aQi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/14/19 10:34 AM, Markus Armbruster wrote:
> Cover invalid 'if' in struct members, features, union and alternate
> branches.  Four out of four are broken.  Mark FIXME.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Embarrassing. But the fact that you're pointing them out presumably
means that you fix it later in the series ;)

> +++ b/tests/qapi-schema/features-if-invalid.json
> @@ -0,0 +1,5 @@
> +# Cover feature with invalid 'if'
> +# FIXME not rejected, misinterpreded as unconditional

misinterpreted

With the typo fix,

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/tests/qapi-schema/struct-member-if-invalid.json
> @@ -0,0 +1,4 @@
> +# Cover member with invalid 'if'
> +# FIXME not rejected, would generate '#if True\n'

Which might actually compile, depending on what else is present in
various headers!  But certainly not what was intended.

> +++ b/tests/qapi-schema/union-branch-if-invalid.json
> @@ -0,0 +1,7 @@
> +# Cover branch with invalid 'if'
> +# FIXME not rejected, would generate '#if \n'
> +{ 'enum': 'Branches', 'data': ['branch1'] }
> +{ 'struct': 'Stru', 'data': { 'member': 'str' } }
> +{ 'union': 'Uni',
> +  'base': { 'tag': 'Branches' }, 'discriminator': 'tag',
> +  'data': { 'branch1': { 'type': 'Stru', 'if': [''] } } }

So you're pointing out a difference between an empty string and a string
not containing a C macro name (possibly because later patches will give
them different error messages).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HX4JmN5QSq5753khRmjhyMbn7mD9s1aQi--

--5sEFNuptRUu7BhyQvnRJUme0qYTzhDWQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2BHEYACgkQp6FrSiUn
Q2oFDAgAmlLtw+wHB3Zcihr07zN3tG8DmM4KgFyYZhfjmYVzQZpGm+7hvBblgSU/
kcCOXlPXiSt+c4VRO2YEoPkWUzfuhvqwFqugjh5oYdXcpqoE2jrj/uaiUAGUk0A8
AaxxVVZ3CZMsXh/EbAhQJjqakcqPgXNfzBcNv3rEEfD4oZKdu8rODGgkY3wQOGSV
DjpfvONvvpKG9Y4IVCsqSLVbkseYcET5T9KhodnxqIxLEsgcYZqkOuemoXrCWaxo
SfhQnoUuDXctVPKrG4Xhn3w+omlEho0VB0tCAqWqm3MKRM3GzLY4siT0+sK1hBHp
B0jHpQHXtfk1KaQ08G8j8QcM8b6ymA==
=0vuu
-----END PGP SIGNATURE-----

--5sEFNuptRUu7BhyQvnRJUme0qYTzhDWQg--

