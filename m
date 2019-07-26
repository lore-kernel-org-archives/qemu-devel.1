Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2641FC76191
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0366022CE5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0366022CE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0fr-0003Gl-5K
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hr0ff-0002d2-VC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hr0fd-00011j-QR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:54:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hr0fZ-0000zc-UA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:54:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20C7936887
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 13:54:00 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF0FD62667;
 Fri, 26 Jul 2019 13:53:59 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-4-armbru@redhat.com>
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
Message-ID: <293774d4-dd12-22b1-65e2-727670b49458@redhat.com>
Date: Fri, 26 Jul 2019 08:53:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-4-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="32Ix9bL0nSEQd2ic9Gv7EbiZi2cgV41HW"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 26 Jul 2019 13:54:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/28] qapi: Split error.json off
 common.json
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
--32Ix9bL0nSEQd2ic9Gv7EbiZi2cgV41HW
Content-Type: multipart/mixed; boundary="xtdTvWqeIAxyNWS1UQFC036ua4K1hRsS9";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <293774d4-dd12-22b1-65e2-727670b49458@redhat.com>
Subject: Re: [PATCH 03/28] qapi: Split error.json off common.json
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-4-armbru@redhat.com>
In-Reply-To: <20190726120542.9894-4-armbru@redhat.com>

--xtdTvWqeIAxyNWS1UQFC036ua4K1hRsS9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/26/19 7:05 AM, Markus Armbruster wrote:
> In my "build everything" tree, changing a type in qapi/common.json
> triggers a recompile of some 3600 out of 6600 objects (not counting
> tests and objects that don't depend on qemu/osdep.h).
>=20
> One common dependency is QapiErrorClass: it's used only in in
> qapi/error.h, which uses nothing else, and is widely included.
>=20
> Move QapiErrorClass from common.json to new error.json.  Touching
> common.json now recompiles only some 2900 objects.
>=20
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS           |  2 ++
>  include/qapi/error.h  |  2 +-
>  qapi/Makefile.objs    |  2 +-
>  qapi/common.json      | 24 ------------------------
>  qapi/error.json       | 29 +++++++++++++++++++++++++++++
>  qapi/qapi-schema.json |  1 +
>  6 files changed, 34 insertions(+), 26 deletions(-)
>  create mode 100644 qapi/error.json


> +++ b/qapi/qapi-schema.json
> @@ -80,6 +80,7 @@
>  # stable order, it's best to include each sub-schema just once, or
>  # include it first right here.
> =20
> +{ 'include': 'error.json' }
>  { 'include': 'common.json' }
>  { 'include': 'sockets.json' }
>  { 'include': 'run-state.json' }

Any reason why error.json is needed before common.json? But I don't see
it as being a problem, so

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xtdTvWqeIAxyNWS1UQFC036ua4K1hRsS9--

--32Ix9bL0nSEQd2ic9Gv7EbiZi2cgV41HW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl07BfYACgkQp6FrSiUn
Q2qpGwgAgufsSpcCgxPbLI1uBKYVCtZYOWx2RC1GlE+FkKZWSo0uBvmZt9aFjNeG
tLqLU8urWS/zQxX+3NI/GR1Z4r7F+/J5G0OpfBfs3SLXTcwx8EdKj0ZqFlpKZXHJ
RM+Pt+czJpRg6h8AmrR0taYYjfQL+uniufIQeBZoGQdtxPsWIEk/qepCU4ecdf6O
a0b0qEf16dePlUWfS6G3YbyT09ukOauR6h2n4scWO6xANqqE8NFmo/0orGOOSUSm
L7Qq+b6oEP6wtTlT6Q3i8NA9m78qqM+L5CfhDmoSoOKbt8+udzg6JByL7kU0fftr
Mc5B5HAtoXkLD2mK2vfB4/X1D5o6GA==
=JML/
-----END PGP SIGNATURE-----

--32Ix9bL0nSEQd2ic9Gv7EbiZi2cgV41HW--

