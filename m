Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59738C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3962146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3962146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmyc-0003xe-Gd
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCmGs-00022n-PH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCmGq-000231-EZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iCmGq-00022R-5s
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:58:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 277763090FC7;
 Tue, 24 Sep 2019 14:58:26 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F25C510013D9;
 Tue, 24 Sep 2019 14:58:21 +0000 (UTC)
Subject: Re: [PATCH 04/25] qapi: Prefix frontend errors with an "in
 definition" line
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-5-armbru@redhat.com>
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
Message-ID: <706dce25-b3c5-2911-a0d8-fa6582892c4b@redhat.com>
Date: Tue, 24 Sep 2019 09:58:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924132830.15835-5-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sLpG8uA8IIAIAG2HOyDiW4SxLuTKzU0oY"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 24 Sep 2019 14:58:26 +0000 (UTC)
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
--sLpG8uA8IIAIAG2HOyDiW4SxLuTKzU0oY
Content-Type: multipart/mixed; boundary="fppU9ciGNShQXAAAZs705RCjlMmyZ3w8D";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <706dce25-b3c5-2911-a0d8-fa6582892c4b@redhat.com>
Subject: Re: [PATCH 04/25] qapi: Prefix frontend errors with an "in
 definition" line
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-5-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-5-armbru@redhat.com>

--fppU9ciGNShQXAAAZs705RCjlMmyZ3w8D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 8:28 AM, Markus Armbruster wrote:
> We take pains to include the offending expression in error messages,
> e.g.
>=20
>     tests/qapi-schema/alternate-any.json:2: alternate 'Alt' member 'one=
' cannot use type 'any'
>=20
> But not always:
>=20
>     tests/qapi-schema/enum-if-invalid.json:2: 'if' condition must be a =
string or a list of strings
>=20
> Instead of improving them one by one, report the offending expression
> whenever it is known, like this:
>=20
>     tests/qapi-schema/enum-if-invalid.json: In enum 'TestIfEnum':
>     tests/qapi-schema/enum-if-invalid.json:2: 'if' condition must be a =
string or a list of strings

Works for me.

>=20
> Error messages that mention the offending expression become a bit
> redundant, e.g.
>=20
>     tests/qapi-schema/alternate-any.json: In alternate 'Alt':
>     tests/qapi-schema/alternate-any.json:2: alternate 'Alt' member 'one=
' cannot use type 'any'
>=20
> I'll take care of that later in this series.

Temporary verboseness is not a problem.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py                            | 15 ++++++++++++++-=

>  tests/qapi-schema/alternate-any.err               |  1 +
>  tests/qapi-schema/alternate-array.err             |  1 +

Touches a lot.  But such is refactoring life.

> +++ b/scripts/qapi/common.py
> @@ -64,6 +64,12 @@ class QAPISourceInfo(object):
>          self.fname =3D fname
>          self.line =3D line
>          self.parent =3D parent
> +        self.defn_meta =3D None
> +        self.defn_name =3D None
> +
> +    def set_defn(self, meta, name):
> +        self.defn_meta =3D meta
> +        self.defn_name =3D name
> =20
>      def next_line(self):
>          info =3D copy.copy(self)
> @@ -73,6 +79,12 @@ class QAPISourceInfo(object):
>      def loc(self):
>          return '%s:%d' % (self.fname, self.line)
> =20
> +    def in_defn(self):
> +        if self.defn_name:
> +            return "%s: In %s '%s':\n" % (self.fname,
> +                                          self.defn_meta, self.defn_na=
me)
> +        return ''
> +
>      def include_path(self):
>          ret =3D ''
>          parent =3D self.parent
> @@ -82,7 +94,7 @@ class QAPISourceInfo(object):
>          return ret
> =20
>      def __str__(self):
> -        return self.include_path() + self.loc()
> +        return self.include_path() + self.in_defn() + self.loc()
> =20
> =20
>  class QAPIError(Exception):
> @@ -1127,6 +1139,7 @@ def check_exprs(exprs):
>          normalize_if(expr)
>          name =3D expr[meta]
>          add_name(name, info, meta)
> +        info.set_defn(meta, name)
>          if doc and doc.symbol !=3D name:

Rather simple addition.  Everything else in the patch is fallout.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--fppU9ciGNShQXAAAZs705RCjlMmyZ3w8D--

--sLpG8uA8IIAIAG2HOyDiW4SxLuTKzU0oY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KLwwACgkQp6FrSiUn
Q2rVrQf+OmIsGk+YZ6x8+UAb4EkHed/hgyzgxtWZyQEajQCzrswWk7uHv8kNMzP5
0gIgjLoT2nVOv3uCHU2hEN7gdvVsbBCh3Bsw3ZBiJS7nrNJToGNeGOm+MR2PI/dB
prtvZSeDWBuQwe70U7f9w90nPFGpOnxf+7JLuo2J4IsBihyerxlJKSvSdG/vYCDY
7vIUKKW1wbzTCO1oy4PuHcvrONODY6RrixZ46u6FIkzVUgMJTW2PkD+zpfOHZdbO
prsSEBhwmrsLtWazaCkgGJH41xXXsSUvV97VV/IyyBegq7RmROLY8PBBnEau/6Hj
7yNlpk0HpjhcSDogJGTL0QXw4rZoqg==
=Fc41
-----END PGP SIGNATURE-----

--sLpG8uA8IIAIAG2HOyDiW4SxLuTKzU0oY--

