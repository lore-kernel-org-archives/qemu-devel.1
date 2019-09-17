Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DADC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2588120665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2588120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGH6-00032t-R6
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAGFD-0001dw-KV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAGFB-0004EC-83
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:22:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48377)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAGF9-0004DI-7T
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:22:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 347DA18C8919;
 Tue, 17 Sep 2019 16:22:17 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D9B60852;
 Tue, 17 Sep 2019 16:22:16 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190913201349.24332-1-armbru@redhat.com>
 <20190913201349.24332-14-armbru@redhat.com>
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
Message-ID: <afbfd0e5-4441-e028-ec3e-ca7129fca342@redhat.com>
Date: Tue, 17 Sep 2019 11:22:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913201349.24332-14-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SJL5DqLfPuSq2rFuolYLjeIxF0bVWZIP6"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 17 Sep 2019 16:22:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 13/16] docs/devel/qapi-code-gen: Rewrite
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
--SJL5DqLfPuSq2rFuolYLjeIxF0bVWZIP6
Content-Type: multipart/mixed; boundary="HTmI1tKvRSobzmG5Znobb7o5lrdokXFbV";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <afbfd0e5-4441-e028-ec3e-ca7129fca342@redhat.com>
Subject: Re: [PATCH v3 13/16] docs/devel/qapi-code-gen: Rewrite compatibility
 considerations
References: <20190913201349.24332-1-armbru@redhat.com>
 <20190913201349.24332-14-armbru@redhat.com>
In-Reply-To: <20190913201349.24332-14-armbru@redhat.com>

--HTmI1tKvRSobzmG5Znobb7o5lrdokXFbV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/13/19 3:13 PM, Markus Armbruster wrote:
> We have some compatibility advice buried in sections "Enumeration
> types" and "Struct types".  Compatibility is actually about commands
> and events.  It devolves to the types used there.  All kinds of types,
> not just enumerations and structs.
>=20
> Replace the existing advice by a new section "Compatibility
> considerations".
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 95 +++++++++++++++++++++++-------------=

>  1 file changed, 60 insertions(+), 35 deletions(-)

You asked me a question on v2 about a possible sentence to add about
renaming types. Up to you if you want to fold that one in here, or leave
it for a separate patch.


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
> +
> +
>  =3D=3D Code generation =3D=3D
> =20
>  The QAPI code generator qapi-gen.py generates code and documentation
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HTmI1tKvRSobzmG5Znobb7o5lrdokXFbV--

--SJL5DqLfPuSq2rFuolYLjeIxF0bVWZIP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2BCDgACgkQp6FrSiUn
Q2rh4gf/Rp6oxagg7BqZI/+f4BVzdBSd53Xc7N8F/u2aQJKqvWHmdMkZaN6sN3zl
yZgTuFM6nXwObMMwZL8uuNEx/yOvs/FmXd56m9c4RvTUAAloBx9ni/2om3IaiYs3
ocYh20zuC2+ZwiE2nBJDwX/yolcCj6gHQJD4X9dOcJMc7S2XfBZ9qt+UwZqP6w9Y
zUCtLwo5HTZqRHTQULx9RU5WZ06Z/Qi1FE8IrjKjktELhKam4U/qZWZZd1Y8Qd3k
gDvm2Poppkpz5uF+q9KWeNGymXgPA+cWPtsvepId9iwRASFwTCvct/4RVgV9622D
I+xxwfjoBk7GfAXTSzIM2IzzKIJWWg==
=TA1f
-----END PGP SIGNATURE-----

--SJL5DqLfPuSq2rFuolYLjeIxF0bVWZIP6--

