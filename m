Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F283AC48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01222080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01222080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfq3Y-00065A-6c
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hfq1k-0004o8-4u
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hfq1i-0008WJ-6s
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:18:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hfq1h-00084f-KD
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1FC5E3082231
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 18:18:11 +0000 (UTC)
Received: from [10.3.116.44] (ovpn-116-44.phx2.redhat.com [10.3.116.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D13D60C43;
 Tue, 25 Jun 2019 18:18:02 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190625161629.302-1-imammedo@redhat.com>
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
Message-ID: <2647871f-34f2-0f8d-adb7-0265f951acd3@redhat.com>
Date: Tue, 25 Jun 2019 13:18:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625161629.302-1-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n6W4FGBdU8B1olm1kq2H1mllZa3glgEuX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 25 Jun 2019 18:18:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH v2] deprecate -mem-path fallback
 to anonymous RAM
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
Cc: libvir-list@redhat.com, ehabkost@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n6W4FGBdU8B1olm1kq2H1mllZa3glgEuX
Content-Type: multipart/mixed; boundary="HPdYq1vJL2oSD4R259K97fXLysNzQevw1";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, ehabkost@redhat.com, dgilbert@redhat.com
Message-ID: <2647871f-34f2-0f8d-adb7-0265f951acd3@redhat.com>
Subject: Re: [libvirt] [PATCH v2] deprecate -mem-path fallback to anonymous
 RAM
References: <20190625161629.302-1-imammedo@redhat.com>
In-Reply-To: <20190625161629.302-1-imammedo@redhat.com>

--HPdYq1vJL2oSD4R259K97fXLysNzQevw1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/25/19 11:16 AM, Igor Mammedov wrote:
> Fallback might affect guest or worse whole host performance
> or functionality if backing file were used to share guest RAM
> with another process.
>=20
> Patch deprecates fallback so that we could remove it in future
> and ensure that QEMU will provide expected behavior and fail if
> it can't use user provided backing file.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>  * improve text language
>     (Markus Armbruster <armbru@redhat.com>)
>=20

Is this deprecation introspectible? Does it need to be?

Do we even need a deprecation period, or can we declare this a bug fix
(it was a bug that we didn't fail outright on an impossible request) and
do it immediately?

If it is not a bug fix, perhaps it could be made introspectible by
having a new boolean parameter to opt in to the failure now, rather than
2 releases from now?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HPdYq1vJL2oSD4R259K97fXLysNzQevw1--

--n6W4FGBdU8B1olm1kq2H1mllZa3glgEuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0SZVkACgkQp6FrSiUn
Q2pBQAgAh8EaxXNt3ID7XEDlvzth1oZHzuo5HS7mpwwEw3b0ETyoag2Dz7AE/vdj
1SborBlUJl7uk1NfYPTBdDMVYPA7lk9lwivCWM77rE+i722Mo/Ejo7Bxyi/RU2Lg
xPdwKt0MQcjLmiNacTbaiE8e9BmwFCERBGTx+V8AzxqUh6ZOqRjGvSHvNFnZJxfN
OK6YlcCq/MNi2YvSkoiYsPAQbK96s0F0lTGj1VrzOXPKegn+IfTbnGxU9cZNV2OY
AYI1nYlg6NX8UbPHtVVp5WSHmbVi0NlKCGyOAjaZCsxQ9PrmwXBGbIeeqNRj7C00
j3kJaQYU1cyw5Gw49ONTpA2ueEl1dQ==
=Pgno
-----END PGP SIGNATURE-----

--n6W4FGBdU8B1olm1kq2H1mllZa3glgEuX--

