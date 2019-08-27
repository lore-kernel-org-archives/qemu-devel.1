Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF84C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61982206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61982206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2c6h-0000nH-Gg
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2c4p-0007ZN-Gv
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2c4o-0005kQ-9m
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:04:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i2c4n-0005jp-Vs
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:04:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35F9D8980EF;
 Tue, 27 Aug 2019 14:04:00 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83C0060BF7;
 Tue, 27 Aug 2019 14:03:54 +0000 (UTC)
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-3-yury-kotov@yandex-team.ru>
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
Message-ID: <e377939e-ffa0-9000-88bf-45410611ded6@redhat.com>
Date: Tue, 27 Aug 2019 09:03:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827120221.15725-3-yury-kotov@yandex-team.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gSdeU5GdwS0EUmG5WmMrLpNp3ExEL5JsN"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 27 Aug 2019 14:04:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/libqtest: Allow to set expected
 exit status
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gSdeU5GdwS0EUmG5WmMrLpNp3ExEL5JsN
Content-Type: multipart/mixed; boundary="DzdnqAuFT6m50LrJ3BWHg4fIUjqRCiYTS";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Message-ID: <e377939e-ffa0-9000-88bf-45410611ded6@redhat.com>
Subject: Re: [PATCH 2/3] tests/libqtest: Allow to set expected exit status
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-3-yury-kotov@yandex-team.ru>
In-Reply-To: <20190827120221.15725-3-yury-kotov@yandex-team.ru>

--DzdnqAuFT6m50LrJ3BWHg4fIUjqRCiYTS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/27/19 7:02 AM, Yury Kotov wrote:

In the subject: 'Allow to $verb' is not idiomatic; either 'Allow
$subject to $verb' or 'Allow ${verb}ing' sound better.  In this case,
I'd go with:

tests/libqtest: Allow setting expected exit status

> Add qtest_set_expected_status function to set expected exit status of
> child process. By default expected exit status is 0.
>=20

> @@ -130,11 +136,12 @@ static void kill_qemu(QTestState *s)
>       * fishy and should be logged with as much detail as possible.
>       */
>      wstatus =3D s->wstatus;
> -    if (wstatus) {
> +    if (WEXITSTATUS(wstatus) !=3D s->expected_status) {
>          if (WIFEXITED(wstatus)) {

Wrong ordering. WEXITSTATUS() is not reliable unless WIFEXITED() is true.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--DzdnqAuFT6m50LrJ3BWHg4fIUjqRCiYTS--

--gSdeU5GdwS0EUmG5WmMrLpNp3ExEL5JsN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1lOEkACgkQp6FrSiUn
Q2pl2Af+JLFSsgYLsKm4n9JsKPnvM8zE0BZObzYwxQVWkfM2w8RDTVTau5kr1Uf0
ALrQ7DQ8Cb/R1jPGaEDwuG2vNMzJqM6iC2Wc1axhZwdBdYVam3PTcxLD5+C6h1wW
KuMHTYDDG1Jc+F4et0jMMh8QYpJCcWUNnp2c8ZVyLLUoWPqERmMjCefUo2VrTVt3
6SK5P5HX5Kl0OUd2Hbf4LJ+O+M/yaqWU2ritLBz4wO7Oh0db/TVPuO9r+2AY+Fyi
1MsyT9oA58ptPBVV/L+eWvgSiPkaP0bRZrcO9+6dYT72xGts4nC/UUEq0JWqX85E
U1iEwb/HWfNeka4q2qy9WnyxJqJ1bg==
=eU2B
-----END PGP SIGNATURE-----

--gSdeU5GdwS0EUmG5WmMrLpNp3ExEL5JsN--

