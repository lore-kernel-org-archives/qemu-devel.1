Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E76C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E638C206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E638C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHoi-0004Im-1T
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 14:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAHnV-0003aw-DY
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAHnO-0000yq-Lb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:01:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAHnM-0000xU-0t
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:01:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 756EC300DA78;
 Tue, 17 Sep 2019 18:01:42 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F02D85D9DC;
 Tue, 17 Sep 2019 18:01:39 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-10-armbru@redhat.com>
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
Message-ID: <57b4bcf2-8af7-cec3-c4b0-4df5dc7f1750@redhat.com>
Date: Tue, 17 Sep 2019 13:01:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190914153506.2151-10-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S2UyJXKQ6b8Az3v97YJpU3FRQ6HlJaL8s"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 17 Sep 2019 18:01:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 09/19] qapi: Remove null from schema
 language
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
--S2UyJXKQ6b8Az3v97YJpU3FRQ6HlJaL8s
Content-Type: multipart/mixed; boundary="ZpykBQgJwOQ08NkhqijMwYVlgYPBcaAGm";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <57b4bcf2-8af7-cec3-c4b0-4df5dc7f1750@redhat.com>
Subject: Re: [PATCH 09/19] qapi: Remove null from schema language
References: <20190914153506.2151-1-armbru@redhat.com>
 <20190914153506.2151-10-armbru@redhat.com>
In-Reply-To: <20190914153506.2151-10-armbru@redhat.com>

--ZpykBQgJwOQ08NkhqijMwYVlgYPBcaAGm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/14/19 10:34 AM, Markus Armbruster wrote:
> We represent the parse tree as OrderedDict.  We fetch optional dict
> members with .get().  So far, so good.
>=20
> We represent null literals as None.  .get() returns None both for
> "absent" and for "present, value is the null literal".  Uh-oh.
>=20
> Test features-if-invalid exposes this bug: "'if': null" is
> misinterpreted as absent "if".
>=20
> We added null to the schema language to "allow [...] an explicit
> default value" (commit e53188ada5 "qapi: Allow true, false and null in
> schema json", v2.4.0).  Hasn't happened; null is still unused except
> as generic invalid value in tests/.

Might happen as a way to default a '*value':'str', but we can deal with
that at the point where someone actually justifies a need for a way to
express a default like that.

>=20
> To fix, we'd have to replace .get() by something more careful, or
> represent null differently.  Feasible, but we got more and bigger fish
> to fry right now.  Remove the null literal from the schema language.

Fair enough.

> Replace null in tests by another invalid value.
>=20
> Test features-if-invalid now behaves as it should.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/tests/qapi-schema/features-if-invalid.json
> @@ -1,5 +1,4 @@
>  # Cover feature with invalid 'if'
> -# FIXME not rejected, misinterpreded as unconditional

Obvious conflict resolution with the typo fix earlier in the series.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ZpykBQgJwOQ08NkhqijMwYVlgYPBcaAGm--

--S2UyJXKQ6b8Az3v97YJpU3FRQ6HlJaL8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2BH4IACgkQp6FrSiUn
Q2pNnwf/ZxlNgxvrgmic1NgTuzDgK0LS2FCEN4WaC4JqrZORMzHlCB+Gn0SUQone
VUtDBiXfq7370t+sbHKfPv8ZWF3dhdFtiLernNTznX9vPfB+1LPyyLvvCbmqU+/K
NdPkEFEN8VPVuqUDiRgWEYtpuhkXKvnLb7FjKVubyA9k2t5KcqscVtEHXJewm/BZ
zHQ/xznUYT9UxA6246QhbXBNVFYWC/Aa9WS64NQiXxt8MzIRG+9MRnsrpurPxLve
2BmwL5sUdYDVf0/Uu+V4H4Nw+7aIbUL+LSG/A3KUee9d1iO2OPboNLnUpY+4k+Zt
KlYb0CkKel7RQBpougANh6L1wrpfjw==
=WDto
-----END PGP SIGNATURE-----

--S2UyJXKQ6b8Az3v97YJpU3FRQ6HlJaL8s--

