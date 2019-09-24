Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F62C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2F12146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2F12146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmx6-0002EA-10
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iClpr-0000Xw-2Y
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iClpq-0000tp-0m
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iClpm-0000hE-6R; Tue, 24 Sep 2019 10:30:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F4E0A26682;
 Tue, 24 Sep 2019 14:30:28 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8F0F3D8E;
 Tue, 24 Sep 2019 14:30:27 +0000 (UTC)
Subject: Re: [PULL 4/4] tests: Use iothreads during iotest 223
To: Nir Soffer <nsoffer@redhat.com>
References: <20190924123933.10607-1-eblake@redhat.com>
 <20190924123933.10607-5-eblake@redhat.com>
 <CAMRbyyuwaRPgO0G5Jj8_tFO+rGbMi_F0V3JuQR-0qU3BAEoEJQ@mail.gmail.com>
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
Message-ID: <798c8885-6255-a3c2-bd85-5441262385b9@redhat.com>
Date: Tue, 24 Sep 2019 09:30:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyuwaRPgO0G5Jj8_tFO+rGbMi_F0V3JuQR-0qU3BAEoEJQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MXYf4VYP4ysEhavpK18gQbBVLE1vhPWGq"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 24 Sep 2019 14:30:28 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MXYf4VYP4ysEhavpK18gQbBVLE1vhPWGq
Content-Type: multipart/mixed; boundary="UHfl3vqihAyzYbigFaGJ633Dp62as9L55";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <798c8885-6255-a3c2-bd85-5441262385b9@redhat.com>
Subject: Re: [PULL 4/4] tests: Use iothreads during iotest 223
References: <20190924123933.10607-1-eblake@redhat.com>
 <20190924123933.10607-5-eblake@redhat.com>
 <CAMRbyyuwaRPgO0G5Jj8_tFO+rGbMi_F0V3JuQR-0qU3BAEoEJQ@mail.gmail.com>
In-Reply-To: <CAMRbyyuwaRPgO0G5Jj8_tFO+rGbMi_F0V3JuQR-0qU3BAEoEJQ@mail.gmail.com>

--UHfl3vqihAyzYbigFaGJ633Dp62as9L55
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 8:49 AM, Nir Soffer wrote:
> On Tue, Sep 24, 2019 at 4:18 PM Eric Blake <eblake@redhat.com> wrote:
>=20
>> Doing so catches the bugs we just fixed with NBD not properly using
>> correct contexts.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20190920220729.31801-1-eblake@redhat.com>
>> ---
>>  tests/qemu-iotests/223     | 6 ++++--
>>  tests/qemu-iotests/223.out | 1 +
>>  2 files changed, 5 insertions(+), 2 deletions(-)

>> -_launch_qemu 2> >(_filter_nbd)
>> +_launch_qemu -object iothread,id=3Dio0 2> >(_filter_nbd)
>>
>=20
> But now we will not catch bugs in flows that do not use iothreads.
>=20
> I think it will be better to run this test twice, one with iothreads, o=
ne
> without.

Too late for this pull request, but I will propose that as a followup pat=
ch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--UHfl3vqihAyzYbigFaGJ633Dp62as9L55--

--MXYf4VYP4ysEhavpK18gQbBVLE1vhPWGq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KKIMACgkQp6FrSiUn
Q2qlPAf7BNPT6rWOtreoiJkhQ7Qa6McH+WGSmVQPBMt7SqUhCHqxgH5klKVCtzSV
Sn4HJNPmXFQvAlJG66R/nmonzyq0ZyMfGaS5xWFmuuQdCSzw9nd8oLNHpGsZxWFc
JxfviDwshfEFeJF2IF0w47ZVjV9z5cd/r1qAkIQAN9mYkL7A/uBsSGVF+fRymSBm
cmIb/lDvnk5LtefUWl9vJATjKVAMouj78Z4WKvIMzHpg06w71F/WU8kEkhmFLxXg
7lu3QOkVAUZCn/SUZibw6Ui/5sz+l49vj9yujy6FPIrkihkOOgZnoVVDCmWXDtnP
Qc2AaVYj6uXjquGuHBr9+n/2mKMigA==
=tHLa
-----END PGP SIGNATURE-----

--MXYf4VYP4ysEhavpK18gQbBVLE1vhPWGq--

