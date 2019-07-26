Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C54CC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C0E208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C0E208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr19Q-0005pm-Ly
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hr19G-0005NZ-Aw
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hr19F-0003t4-1g
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:24:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hr19C-0003pe-Gn; Fri, 26 Jul 2019 10:24:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49728C059B6F;
 Fri, 26 Jul 2019 14:24:37 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2048E607C0;
 Fri, 26 Jul 2019 14:24:36 +0000 (UTC)
To: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726140954.31921-3-ptoscano@redhat.com>
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
Message-ID: <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
Date: Fri, 26 Jul 2019 09:24:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726140954.31921-3-ptoscano@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aF6NOmsbxFBP0inKuxZV985RlRSli7AgQ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 26 Jul 2019 14:24:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, pkrempa@redhat.com,
 rjones@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aF6NOmsbxFBP0inKuxZV985RlRSli7AgQ
Content-Type: multipart/mixed; boundary="amEnnUvxjoj5TAySJyeHX0wUyjf4cJoqc";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, rjones@redhat.com,
 mreitz@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726140954.31921-3-ptoscano@redhat.com>
In-Reply-To: <20190726140954.31921-3-ptoscano@redhat.com>

--amEnnUvxjoj5TAySJyeHX0wUyjf4cJoqc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/26/19 9:09 AM, Pino Toscano wrote:
> Add a 'private-key' option which represents the path of a private key
> to use for authentication, and 'private-key-secret' as the name of an
> object with its passphrase.
>=20
> Signed-off-by: Pino Toscano <ptoscano@redhat.com>

> +++ b/qapi/block-core.json
> @@ -3226,6 +3226,11 @@
>  # @password-secret:     ID of a QCryptoSecret object providing a passw=
ord
>  #                       for authentication (since 4.2)
>  #
> +# @private-key:         path to the private key (since 4.2)
> +#
> +# @private-key-secret:  ID of a QCryptoSecret object providing the pas=
sphrase
> +#                       for 'private-key' (since 4.2)

Is password-secret intended to be mutually-exclusive with
private-key/private-key-secret?  If so, this should probably utilize an
enum for a discriminator
{ 'enum': 'SshAuth', 'data': ['ssh-agent', 'password', 'private'key'] }

then update BlockdevOptionsSsh to be a union type with an optional
discriminator (defaulting to ssh-agent) for back-compat, where
'auth':'ssh-agent' needs no further fields, 'auth':'password' adds in a
'secret' field for use as password, or where 'auth':'private-key' adds
in both 'key-file' and 'secret' for use as the two pieces needed for
private key use.

Markus may have other suggestions on how best to represent this sort of
union type in QAPI.

> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsSsh',
> @@ -3233,7 +3238,9 @@
>              'path': 'str',
>              '*user': 'str',
>              '*host-key-check': 'SshHostKeyCheck',
> -            '*password-secret': 'str' } }
> +            '*password-secret': 'str',
> +            '*private-key': 'str',
> +            '*private-key-secret': 'str' } }
> =20
> =20
>  ##
>=20

On a different topic, how much of this work overlaps with the nbdkit ssh
plugin? Should we be duplicating efforts with both projects supporting
ssh natively, or is it worth considering getting qemu out of the ssh
business and instead connecting to an nbd device provided by nbdkit
connecting to ssh?  (For comparison, we've already decided that nbdkit
does not plan on writing a qcow2 plugin, because it defers to qemu to be
the expert there; or in the other direction, qemu-nbd has deprecated its
partial support for exposing only a partition of a disk in favor of
qemu-nbd having much more partition support through its filters)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--amEnnUvxjoj5TAySJyeHX0wUyjf4cJoqc--

--aF6NOmsbxFBP0inKuxZV985RlRSli7AgQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl07DSIACgkQp6FrSiUn
Q2rH9wgArS6t+UiPx3HaMJ9FsBEE3asbFRLDhpK7yEbpfrESMpUZIyoBkKptqNlD
jeyeq/rlLOYOD4Qu/kvyTd3rGkGIuu0NNMphWXnTUUSXw7pOKBi+MfbIVF9DQdPO
1D+C9ZEvheIVx8aVnwm5aXbRBeNZztUyaruZITxX47PDNiJiGLACDfJoQl12d8MB
y7EK/qoii0lnbr0uYLchgkio03R8e3w+73RXa6T5vWU2GayNEbi8T7ihKAibVq/x
0eJsRSUG3PdJ3GMv4tGCEQ0x+pJtFm/xqCNcp3c7UWH90QZofZbeWk3DHu5UNV6Q
rpstM3UydddWrjwMCnQee4qImXT/cQ==
=Ybgx
-----END PGP SIGNATURE-----

--aF6NOmsbxFBP0inKuxZV985RlRSli7AgQ--

