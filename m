Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A136C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1851206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1851206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAG7B-00022a-BO
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAFwe-0001Ih-9x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAFwc-0005fI-4j
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:03:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48144)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAFwa-0005dX-2C
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:03:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4CA29356C5;
 Tue, 17 Sep 2019 16:03:06 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C89C85D6A9;
 Tue, 17 Sep 2019 16:03:05 +0000 (UTC)
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
References: <cover.1568735079.git.pkrempa@redhat.com>
 <61c6b9409ee33b88ba63eb781e6ab66be3bbf80d.1568735079.git.pkrempa@redhat.com>
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
Message-ID: <ab0b904b-cec5-9793-88ba-22b8157ac862@redhat.com>
Date: Tue, 17 Sep 2019 11:03:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <61c6b9409ee33b88ba63eb781e6ab66be3bbf80d.1568735079.git.pkrempa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hYCgp71VlDBTZy278XCF9z8UgvNCuSsxA"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 17 Sep 2019 16:03:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: Add feature flags to commands in
 qapi introspection
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hYCgp71VlDBTZy278XCF9z8UgvNCuSsxA
Content-Type: multipart/mixed; boundary="L3vvdvLrN35ybZmw7jYIuUkynkGUYIjDL";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <ab0b904b-cec5-9793-88ba-22b8157ac862@redhat.com>
Subject: Re: [PATCH 1/2] qapi: Add feature flags to commands in qapi
 introspection
References: <cover.1568735079.git.pkrempa@redhat.com>
 <61c6b9409ee33b88ba63eb781e6ab66be3bbf80d.1568735079.git.pkrempa@redhat.com>
In-Reply-To: <61c6b9409ee33b88ba63eb781e6ab66be3bbf80d.1568735079.git.pkrempa@redhat.com>

--L3vvdvLrN35ybZmw7jYIuUkynkGUYIjDL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/17/19 10:49 AM, Peter Krempa wrote:
> Similarly to features for struct types introduce the feature flags also=

> for commands. This will allow notifying management layers of fixes and
> compatible changes in the behaviour of an command which may not be

s/ an / a /

> detectable any other way.
>=20
> The changes were heavily inspired by commit 6a8c0b51025.
>=20
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt   |  4 ++--

May be some rebase churn needed here as Markus has been reworking that fi=
le:
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02959.html

>  qapi/introspect.json           |  6 ++++-
>  scripts/qapi/commands.py       |  3 ++-
>  scripts/qapi/common.py         | 40 +++++++++++++++++++++++++++++-----=

>  scripts/qapi/doc.py            |  3 ++-
>  scripts/qapi/introspect.py     |  7 +++++-
>  tests/qapi-schema/test-qapi.py |  7 +++++-
>  7 files changed, 58 insertions(+), 12 deletions(-)
>=20
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.tx=
t
> index e8ec8ac1de..38682daace 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -726,8 +726,8 @@ change in the QMP syntax (usually by allowing value=
s or operations that
>  previously resulted in an error). QMP clients may still need to know
>  whether the extension is available.
>=20
> -For this purpose, a list of features can be specified for a struct typ=
e.
> -This is exposed to the client as a list of string, where each string
> +For this purpose, a list of features can be specified for a command or=
 struct
> +type. This is exposed to the client as a list of string, where each st=
ring

Pre-existing, but "list of strings" or "list of string entries"

>  signals that this build of QEMU shows a certain behaviour.
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--L3vvdvLrN35ybZmw7jYIuUkynkGUYIjDL--

--hYCgp71VlDBTZy278XCF9z8UgvNCuSsxA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2BA7gACgkQp6FrSiUn
Q2rzAwf/eQATKRjGftIP6kgrJuquZnfFA8LU1MlxSr0F1CdePKDJPldRemYpn0PD
jrFNPGPPPy0GmFoEXMHpVTiMx2ZIzBDvNuXvXmDu5TrJvqCzQtJxr7NRya9ZWduq
gl2NmLbcz8n01fNDIXBWpMwclpwOD3XmE9yAM/4HHIMxOY/6r+FW7iyrGttD+ayh
Vm0zCFfF2y5DU1mpmcHt65ny0WNxUwqvA0CzcD3QEEDqcTg+/TD7iqfUlf7+3dp7
BDUr/d7TGzkq7HLkwXoin7zQdPd+X783B0oCM845U/WuFFlDEjKrMEwmfHLo7CCM
VNArEUd5+In+YWjjaSNx4bY/wtnL5A==
=fLo0
-----END PGP SIGNATURE-----

--hYCgp71VlDBTZy278XCF9z8UgvNCuSsxA--

