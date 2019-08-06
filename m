Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A44C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024A52086D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024A52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv7Mh-0001HL-Ay
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 17:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hv7MF-0000ry-Np
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hv7ME-0002iC-PM
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hv7ME-0002hi-HT
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E39EC0022F1
 for <qemu-devel@nongnu.org>; Tue,  6 Aug 2019 21:51:01 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9A2B19C65;
 Tue,  6 Aug 2019 21:51:00 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-3-armbru@redhat.com>
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
Message-ID: <5ef8c26c-bdc7-7c1f-130b-70d0cf3bfd38@redhat.com>
Date: Tue, 6 Aug 2019 16:50:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aWBgcplvV2m89izE9Cvu1DQs9rrF7KmgK"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 06 Aug 2019 21:51:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/29] Include generated QAPI headers
 less
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aWBgcplvV2m89izE9Cvu1DQs9rrF7KmgK
Content-Type: multipart/mixed; boundary="Mw7OGS1yA9mYAW5GgIvrsGSjdmp0JZjxK";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5ef8c26c-bdc7-7c1f-130b-70d0cf3bfd38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/29] Include generated QAPI headers less
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-3-armbru@redhat.com>
In-Reply-To: <20190806151435.10740-3-armbru@redhat.com>

--Mw7OGS1yA9mYAW5GgIvrsGSjdmp0JZjxK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/6/19 10:14 AM, Markus Armbruster wrote:
> Some of the generated qapi-types-MODULE.h are included all over the
> place.  Changing a QAPI type can trigger massive recompiling.  Top
> scorers recompile more than 1000 out of some 6600 objects (not
> counting tests and objects that don't depend on qemu/osdep.h):
>=20
>     6300 qapi/qapi-builtin-types.h
>     5700 qapi/qapi-types-run-state.h
>     3900 qapi/qapi-types-common.h
>     3300 qapi/qapi-types-sockets.h
>     3000 qapi/qapi-types-misc.h
>     3000 qapi/qapi-types-crypto.h
>     3000 qapi/qapi-types-job.h
>     3000 qapi/qapi-types-block-core.h
>     2800 qapi/qapi-types-block.h
>     1300 qapi/qapi-types-net.h
>=20
> Clean up headers to include generated QAPI headers only where needed.
> Impact is negligible except for hw/qdev-properties.h.
>=20
> This header includes qapi/qapi-types-block.h and
> qapi/qapi-types-misc.h.  They are used only in expansions of property
> definition macros such as DEFINE_PROP_BLOCKDEV_ON_ERROR() and
> DEFINE_PROP_OFF_AUTO().  Moving their inclusion from
> hw/qdev-properties.h to the users of these macros avoids pointless
> recompiles.  This is how other property definition macros, such as
> DEFINE_PROP_NETDEV(), already work.
>=20
> Improves things for some of the top scorers:
>=20
>     3600 qapi/qapi-types-common.h
>     2800 qapi/qapi-types-sockets.h
>      900 qapi/qapi-types-misc.h
>     2200 qapi/qapi-types-crypto.h
>     2100 qapi/qapi-types-job.h
>     2100 qapi/qapi-types-block-core.h
>      270 qapi/qapi-types-block.h
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Mw7OGS1yA9mYAW5GgIvrsGSjdmp0JZjxK--

--aWBgcplvV2m89izE9Cvu1DQs9rrF7KmgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1J9kQACgkQp6FrSiUn
Q2oIiAf/e+6yTZWFPGypyldSwPW73oEOA2cmIhRkY6N55y6iFOlrEJWHw7p0eUks
BmKqv4Vs/Lkqm2Kwx45N0xvzDS9i0dAK+/2H/7uINJdeSnU8EU8BvpLg9bXuN6fS
NSzCkqSezd0e1WH4tHB/b/0bbbXf9xW3GH7JMg4sb7ErWiuTVfNrjOou3BuXL5KX
SkkmzIHijunIrmYSgrMkukjac5q7yaXLf/uVsD9fQ1EsngpqeAFPom62k9k/bETR
orh5bnlVOTOM+WHZ9tEyEIS3KE8k4EtbJqqK2ZeIsksIXlZOeNCyow9bCmoKOwqA
ZxgO+TPp/oXaNtwwu6ZJ+lvdA5mAvQ==
=f9lX
-----END PGP SIGNATURE-----

--aWBgcplvV2m89izE9Cvu1DQs9rrF7KmgK--

