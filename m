Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B11C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43E82067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43E82067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHfM-0000xW-2n
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAHee-0000XF-6F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAHed-0006Xa-5p
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAHec-0006XP-U5
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:52:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 36BDB83F3C;
 Tue, 17 Sep 2019 17:52:42 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B339860BEC;
 Tue, 17 Sep 2019 17:52:39 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-8-armbru@redhat.com>
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
Message-ID: <5a159310-b9fd-834e-651b-a19129efef83@redhat.com>
Date: Tue, 17 Sep 2019 12:52:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190914153506.2151-8-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QpicouARh5Xs42Mfq3Ys8fSoxHszzopTS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 17 Sep 2019 17:52:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/19] qapi: Use quotes more consistently
 in frontend error messages
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
--QpicouARh5Xs42Mfq3Ys8fSoxHszzopTS
Content-Type: multipart/mixed; boundary="43bwG8m1UwGc8yrTfKgfPQrmuGGwwqPnL";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <5a159310-b9fd-834e-651b-a19129efef83@redhat.com>
Subject: Re: [PATCH 07/19] qapi: Use quotes more consistently in frontend
 error messages
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-8-armbru@redhat.com>
In-Reply-To: <20190914153506.2151-8-armbru@redhat.com>

--43bwG8m1UwGc8yrTfKgfPQrmuGGwwqPnL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/14/19 10:34 AM, Markus Armbruster wrote:
> Consistently enclose error messages in double quotes.  Use single
> quotes within, except for one case of "'".
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/scripts/qapi/common.py
> @@ -214,7 +214,7 @@ class QAPIDoc(object):
>          # recognized, and get silently treated as ordinary text
>          if not self.symbol and not self.body.text and line.startswith(=
'@'):
>              if not line.endswith(':'):
> -                raise QAPIParseError(self._parser, "Line should end wi=
th :")
> +                raise QAPIParseError(self._parser, "Line should end wi=
th ':'")

Makes it more obvious what belongs in the .json file (where we DO want
the use of ''), so this looks nicer.


> @@ -522,7 +522,7 @@ class QAPISchemaParser(object):
>                      ch =3D self.src[self.cursor]
>                      self.cursor +=3D 1
>                      if ch =3D=3D '\n':
> -                        raise QAPIParseError(self, 'Missing terminatin=
g "\'"')
> +                        raise QAPIParseError(self, "Missing terminatin=
g \"'\"")

And this would be the one exception mentioned in the commit message.


> @@ -592,20 +592,20 @@ class QAPISchemaParser(object):
>              self.accept()
>              return expr
>          if self.tok not in "{['tfn":
> -            raise QAPIParseError(self, 'Expected "{", "[", "]", string=
, '
> -                                 'boolean or "null"')
> +            raise QAPIParseError(
> +                self, "Expected '{', '[', ']', string, boolean or 'nul=
l'")

Definite improvement here.

Reviewed-by: Eric Blake <eblake@redhat.com>

And of course, you can correlate which tests changed output to a measure
of how well we've covered the various error paths.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--43bwG8m1UwGc8yrTfKgfPQrmuGGwwqPnL--

--QpicouARh5Xs42Mfq3Ys8fSoxHszzopTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2BHWYACgkQp6FrSiUn
Q2q40Qf8DsvachcwM46IZhVXisz4aYouNkP700klAnM2SOMWi5WdSA9Rt2yc7RAg
WbViNX+F+Egc6QFoTT87OA09nZ9NJ5Z/to+6QyzvJGF6VvqrwgrGNsUeQL1vWuPM
T4XbRwtHNuQo2v9MsBxf1rs+UhrnZqJ9wwMLN18ih4hCUnvjP4YCSI5kh8rKWXc9
kgcw+7CbeHhVRjFwtyV6ZLPv5EBF4rEtUpbmrWX9fCVJbKmBawby2gJjhuATNFe8
5lLi/tbLacIQOSgkTiZgyG9Sq40CCgqUHNwQq0IAw8jCeoYvYoyj7dSItkfwL6PE
m9nA4jSNxOeWafq2rrlaAjtw1ETzQA==
=KKMl
-----END PGP SIGNATURE-----

--QpicouARh5Xs42Mfq3Ys8fSoxHszzopTS--

