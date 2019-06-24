Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864EBC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F0620673
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F0620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfSVN-000683-CI
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41922)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hfSTb-0005SI-AF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hfSTa-0004rx-0a
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:09:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hfSTW-00047Q-QR; Mon, 24 Jun 2019 13:09:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CBFFC04D2F7;
 Mon, 24 Jun 2019 17:09:22 +0000 (UTC)
Received: from [10.3.116.44] (ovpn-116-44.phx2.redhat.com [10.3.116.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D01319C6A;
 Mon, 24 Jun 2019 17:09:20 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <dc4ae7d2-64bf-ab12-4712-5752f848b5dd@virtuozzo.com>
 <5b57cb61-7eef-b89e-7ea7-053e65c9f227@virtuozzo.com>
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
Message-ID: <538b1e90-c5c6-671a-7b73-1833b20982ec@redhat.com>
Date: Mon, 24 Jun 2019 12:09:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5b57cb61-7eef-b89e-7ea7-053e65c9f227@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j9a02lqnMXT8lRXBws4JPNgqC6SpOooMM"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 24 Jun 2019 17:09:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: new file to suppress
 Valgrind errors
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j9a02lqnMXT8lRXBws4JPNgqC6SpOooMM
Content-Type: multipart/mixed; boundary="1JSZxzR14BQ6npParKNBI41sNFx8WQfB4";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan
 <rkagan@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Message-ID: <538b1e90-c5c6-671a-7b73-1833b20982ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: new file to suppress
 Valgrind errors
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <dc4ae7d2-64bf-ab12-4712-5752f848b5dd@virtuozzo.com>
 <5b57cb61-7eef-b89e-7ea7-053e65c9f227@virtuozzo.com>
In-Reply-To: <5b57cb61-7eef-b89e-7ea7-053e65c9f227@virtuozzo.com>

--1JSZxzR14BQ6npParKNBI41sNFx8WQfB4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/24/19 11:55 AM, Andrey Shinkevich wrote:

>>> +++ b/tests/qemu-iotests/common.rc
>>> @@ -17,6 +17,8 @@
>>>    # along with this program.  If not, see <http://www.gnu.org/licens=
es/>.
>>>    #
>>>   =20
>>> +readonly VALGRIND_SUPPRESS_ERRORS=3D./valgrind.supp
>>
>> Why readonly?
>>
>> I think it should be defined near and in same manner as VALGRIND_LOGFI=
LE,
>> with use of TEST_DIR
>>
>=20
> The new file 'valgrind.supp' is intended to be a part of the QEMU=20
> project. So, it will be located in the test directory tests/qemu-iotest=
s.
> The variable TEST_DIR may change the working directory. In that case,=20
> moving the project file will be a hassle.

My personal thoughts are that no serious POSIX or bash shell script ever
uses readonly (it offers the illusion of security but cannot actually
back it up, and in reality ends up causing more bugs than it prevents
when your script breaks because you tried to modify a readonly
variable).  I've only ever dealt with one project that tried to use
readonly in earnest (the 'cygport' script for building Cygwin packages)
and it got in the way more than it saved me from bugs.

Declaring that VALGRIND_SUPPRESS_ERRORS is initialized hard-coded to ./
instead of relative to ${TEST_DIR} is orthogonal to whether you declare
that the variable VALGRIND_SUPPRESS_ERRORS can no longer be further
modified by the rest of the script.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--1JSZxzR14BQ6npParKNBI41sNFx8WQfB4--

--j9a02lqnMXT8lRXBws4JPNgqC6SpOooMM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0RA7kACgkQp6FrSiUn
Q2qlQwf/b+T44z5+lA28XxmGZTzF+/7BKiAouwFSqi7c82/SnkgoaVXqeouMTr6T
wY7DPRGLpHsIe9zJEoyJMUlj8lOPH80y6oohTRLBKV8DwHLAT7+Ls1ac4Qdy5p5O
ZNnLsi2X059XVE2/ZdErGh8EFhYVH7gnWbStVTCQgpYDQ9EXvNb645d+ZwzUlF/R
y6bewV/1AMyYeZlgW4rpz8f1yAFfuc9l7jPZQl3H0yc6FlaldbW4P0pvn684QjOq
rPDRL0416+4Vshce6yst73M0VQvx6j6BtqHH5ZzFhswxvkvEzWcIobo59qnvnUG3
LfZ1ussSrBb9NDfYO9sdVkuHb8Uelg==
=8XLX
-----END PGP SIGNATURE-----

--j9a02lqnMXT8lRXBws4JPNgqC6SpOooMM--

