Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E98C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8322089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8322089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hoE-0001in-BP
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i7hnC-0000eC-VE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i7hnA-0002zY-A3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:10:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i7hnA-0002xQ-1O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:10:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF56C81F0F;
 Tue, 10 Sep 2019 15:10:49 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5853C6013A;
 Tue, 10 Sep 2019 15:10:42 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-5-armbru@redhat.com>
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
Message-ID: <06d179fd-e96a-7560-4fcc-a2271ab0b4b7@redhat.com>
Date: Tue, 10 Sep 2019 10:10:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910063724.28470-5-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M4OUwGPTAuZqOxoOOmUBay1J2nJ3733Ec"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 10 Sep 2019 15:10:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/16] docs/devel/qapi-code-gen: Minor
 specification fixes
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
--M4OUwGPTAuZqOxoOOmUBay1J2nJ3733Ec
Content-Type: multipart/mixed; boundary="ar1dRGhhvx8fW3Rf4iZa1UTAyNh6tNQ0t";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <06d179fd-e96a-7560-4fcc-a2271ab0b4b7@redhat.com>
Subject: Re: [PATCH v2 04/16] docs/devel/qapi-code-gen: Minor specification
 fixes
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-5-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-5-armbru@redhat.com>

--ar1dRGhhvx8fW3Rf4iZa1UTAyNh6tNQ0t
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/10/19 1:37 AM, Markus Armbruster wrote:
> The specification claims "Each expression that isn't an include
> directive may be preceded by a documentation block", but the code also
> rejects them for pragma directives.  The code is correct.  Fix the
> specification.
>=20
> The specification reserves member names starting with 'has_', but the
> code also reserves name 'u'.  Fix the specification.

Reservation of 'u' was done in 5e59baf9 (and claimed we could add a
munge to q_u in the future if we ever needed a name 'u' after all).

>=20
> The specification claims "The string 'max' is not allowed as an enum
> value".  Untrue.  Fix the specification.  While there, delete the
> naming advice, because it's redundant with the naming rules in section
> "Schema overview"

Used to be true; missed when commit 7fb1cf16 got rid of the collision.

>=20
> The specification claims "No branch of the union can be named 'max',
> as this would collide with the implicit enum".  Untrue.  Fix the
> specification.

Fixed around the same time (although I didn't check if it was in the
same commit)

>=20
> The specification claims "It is not allowed to name an event 'MAX',
> since the generator also produces a C enumeration of all event names
> with a generated _MAX value at the end."  Untrue.  Fix the
> specification.

And similar comment.

I don't know if you want to do exact commit ids where all of these doc
problems were introduced (because of code patches that lifted the
limitations).

>=20
> The specification claims "All branches of the union must be complex
> types", but the code permits only struct types.  The code is correct.
> Fix the specification.
>=20
> The specification claims a command's return type "must be the string
> name of a complex or built-in type, a one-element array containing the
> name of a complex or built-in type" unless the command is in pragma
> 'returns-whitelist'.  The code does not permit built-in types.  Fix
> the specification.

Umm:

qapi/migration.json:{ 'command': 'query-migrate-cache-size', 'returns':
'int' }

I don't know if we use an array of a built-in-type, but we definitely
have unfortunate commands that return a non-JSON-object.  [1]

>  A flat union definition avoids nesting on the wire, and specifies a
>  set of common members that occur in all variants of the union.  The
>  'base' key must specify either a type name (the type must be a
>  struct, not a union), or a dictionary representing an anonymous type.
> -All branches of the union must be complex types, and the top-level
> +All branches of the union must be struct types, and the top-level

We have hit cases where it might have been nicer to permit a flat union
whose branch is itself another flat union.  But until we actually code
that up to work, this is accurate.


> @@ -578,8 +578,8 @@ The 'returns' member describes what will appear in =
the "return" member
>  of a Client JSON Protocol reply on successful completion of a command.=

>  The member is optional from the command declaration; if absent, the
>  "return" member will be an empty dictionary.  If 'returns' is present,=

> -it must be the string name of a complex or built-in type, a
> -one-element array containing the name of a complex or built-in type.
> +it must be the string name of a complex type, or a
> +one-element array containing the name of a complex type.
>  To return anything else, you have to list the command in pragma
>  'returns-whitelist'.  If you do this, the command cannot be extended
>  to return additional information in the future.  Use of

[1] Aha - it's 'returns-whitelist' that makes the difference.  Okay,
your wording change here makes sense: a built-in is NOT permitted UNLESS
you whitelist it.

Summary: you may want to improve the commit message with git
archaeology, but the wording changes themselves make sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ar1dRGhhvx8fW3Rf4iZa1UTAyNh6tNQ0t--

--M4OUwGPTAuZqOxoOOmUBay1J2nJ3733Ec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl13vPEACgkQp6FrSiUn
Q2o3mgf/QFXGYkXxveBYAYF62cVoMT5QlIWrUUfVLOrNxtwvk5HYH6wwpg2R0RbF
9lci0Pp0s9euYoZNPHBRdYX1hS52Db30/E5ql9CxMOrLq2PxzGUflWzAHdn0+snK
mD/z48mdN2vR78X89VAfP/cVAGRhILvObhHCnyYOgBjdp14UFb2tNN9z5kf+hxjt
KooJcQrmsoo7B9OeMfHwDao0AHolu8Yc/TH7N7+2PCTlS6hDIWsS2k42JHgWVEOC
bvnyTLjtM5kweqME7LjJdWiy8HF5wNbN78qgbTP0kT8ddDIQc3lQ2zC5MiL13Efn
uKcfOa5LMVbn/4m0HCfKkDtGImcrbg==
=wawN
-----END PGP SIGNATURE-----

--M4OUwGPTAuZqOxoOOmUBay1J2nJ3733Ec--

