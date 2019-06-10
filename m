Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AA3C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCCB20862
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCCB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haLXt-00046h-Cz
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1haLRZ-0005ow-Lv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1haLDX-0003ag-5P
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1haLDV-0003Z8-Rk; Mon, 10 Jun 2019 10:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7782430C1AE7;
 Mon, 10 Jun 2019 14:24:08 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE2C35DA99;
 Mon, 10 Jun 2019 14:24:05 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1560105348-459129-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560105348-459129-2-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <96a6fd48-9e84-1285-1932-3ce1736cd08c@redhat.com>
Date: Mon, 10 Jun 2019 09:24:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560105348-459129-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HZZSEw2KXfz9MWLuEfASSy0jK7YNVdzUa"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 10 Jun 2019 14:24:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/7] iotests: allow Valgrind checking all
 QEMU processes
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 rkagan@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HZZSEw2KXfz9MWLuEfASSy0jK7YNVdzUa
Content-Type: multipart/mixed; boundary="6DLXkSZpoEfnSRAHoijyaLNT8iqK7L7d2";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 rkagan@virtuozzo.com, den@openvz.org
Message-ID: <96a6fd48-9e84-1285-1932-3ce1736cd08c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] iotests: allow Valgrind checking all
 QEMU processes
References: <1560105348-459129-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560105348-459129-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560105348-459129-2-git-send-email-andrey.shinkevich@virtuozzo.com>

--6DLXkSZpoEfnSRAHoijyaLNT8iqK7L7d2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/9/19 1:35 PM, Andrey Shinkevich wrote:
> With the '-valgrind' option, let all the QEMU processes be run under
> the Valgrind tool. The Valgrind own parameters may be set with its
> environment variable VALGRIND_OPTS, e.g.
> VALGRIND_OPTS=3D"--leak-check=3Dyes" ./check -qcow2 -valgrind <test#>

Let's spell this --valgrind; long options should prefer the use of --
(as in getopt_long), whether or not we also have a reason to support
-valgrind (as in getopt_long_only). Yes, qemu is an oddball in this
regards, but no need to make it worse.

>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/common.rc | 65 ++++++++++++++++++++++++++++++++----=
--------
>  1 file changed, 48 insertions(+), 17 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.r=
c
> index 93f8738..3caaca4 100644


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6DLXkSZpoEfnSRAHoijyaLNT8iqK7L7d2--

--HZZSEw2KXfz9MWLuEfASSy0jK7YNVdzUa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz+aAMACgkQp6FrSiUn
Q2rDqAf/cYkHenw0lk+FiJzuvJGR1zW0iwJq0wql2W6mbEUFvhrgujKUQwjTJz89
FV7FSoa13KTU/IfaaUz8UiDII2Usjw6x9wlsoo2gEphTZYZVoHM08JZcVTSb0+52
/g6V++qLDnYOxqBHhdlSh4F3duTlry+hCC9TH9GE+lDwjfZXXx3YzVTf9kG5bv5m
JUF+1Vr+1Nnq9J5ABScEwXkQ0KsXfiZqsptATJ6CKylCam1tEbA0nwbzkXYeYla0
evUom13CHLTlwJiLx77D4jVMBhmlr0852IW9+6EHrp9I8p5QL45HMlFdYjeR+J/c
BhcpgmcegufKFfdqprHLhQgcuc7kng==
=q72G
-----END PGP SIGNATURE-----

--HZZSEw2KXfz9MWLuEfASSy0jK7YNVdzUa--

