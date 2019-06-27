Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9AFC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B6720663
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 14:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B6720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgVlg-0006Od-4P
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 10:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hgVkN-0005jr-DG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hgVkL-0007XJ-Di
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:51:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hgVkF-0007RD-Ht; Thu, 27 Jun 2019 10:51:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CA4281F01;
 Thu, 27 Jun 2019 14:51:16 +0000 (UTC)
Received: from [10.3.116.142] (ovpn-116-142.phx2.redhat.com [10.3.116.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2168E19C59;
 Thu, 27 Jun 2019 14:51:11 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
References: <20190626215301.30733-1-jsnow@redhat.com>
 <20190627083453.GC5618@localhost.localdomain>
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
Message-ID: <13d0a05e-a445-39e1-841b-d84c5e5352b2@redhat.com>
Date: Thu, 27 Jun 2019 09:51:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627083453.GC5618@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="chbRJbj9PxXYEIZv07mxyGxiHNC4JzD2C"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 27 Jun 2019 14:51:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/qcow: Improve error when opening
 qcow2 files as qcow
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
Cc: Qemu-Trivial <qemu-trivial@nongnu.org>, radmehrsaeed7@gmail.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--chbRJbj9PxXYEIZv07mxyGxiHNC4JzD2C
Content-Type: multipart/mixed; boundary="ZdcMIC0mldM7erXSWOfpOBTXfJwXbkGnZ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Cc: Qemu-Trivial <qemu-trivial@nongnu.org>, radmehrsaeed7@gmail.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <13d0a05e-a445-39e1-841b-d84c5e5352b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/qcow: Improve error when opening qcow2
 files as qcow
References: <20190626215301.30733-1-jsnow@redhat.com>
 <20190627083453.GC5618@localhost.localdomain>
In-Reply-To: <20190627083453.GC5618@localhost.localdomain>

--ZdcMIC0mldM7erXSWOfpOBTXfJwXbkGnZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/27/19 3:34 AM, Kevin Wolf wrote:
> Am 26.06.2019 um 23:53 hat John Snow geschrieben:
>> Reported-by: radmehrsaeed7@gmail.com
>> Fixes: https://bugs.launchpad.net/bugs/1832914
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/qcow.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/qcow.c b/block/qcow.c
>> index 6dee5bb792..a9cb6ae0bd 100644
>> --- a/block/qcow.c
>> +++ b/block/qcow.c
>> @@ -156,7 +156,12 @@ static int qcow_open(BlockDriverState *bs, QDict =
*options, int flags,
>>          goto fail;
>>      }
>>      if (header.version !=3D QCOW_VERSION) {
>> -        error_setg(errp, "Unsupported qcow version %" PRIu32, header.=
version);
>> +        error_setg(errp, "qcow (v%d) does not support qcow version %"=
 PRIu32,
>> +                   QCOW_VERSION, header.version);
>> +        if (header.version =3D=3D 2 || header.version =3D=3D 3) {
>> +            error_append_hint(errp, "Try the 'qcow2' driver instead."=
);
>=20
> I think we want a \n at the end here.
>=20

Yes, we do. Good spot.

> Kevin
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ZdcMIC0mldM7erXSWOfpOBTXfJwXbkGnZ--

--chbRJbj9PxXYEIZv07mxyGxiHNC4JzD2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0U194ACgkQp6FrSiUn
Q2qXMQgAqJhuAfXHl7msQ+TrN6jRNOMQFybOG+7J0dekRdWJCmxSkLJDHuTLbF8K
pSe/RTEcuDAb6iaUFY5blZSVKGX2zx1KV0DnU4vM7xAG9Ml3uaVzvJbnTrZSVhD/
akrx0aCVX/sfqolmEm/RctlrhjPoVHzqU0TQGkC7ewpYzWBuMKqWCqpuWBLehmJm
cD66Y5R1hLQSeFsKeJn0n8LN/CUu2s5zzFcxNknX5fbKn8gGrYO8vPshJk7pcRJ+
O+FVfaGegjOl6bsdSEgV2VH2J4mY2mGhAK/VR0JPBnEWnC61Nbj6au7oPehmiCIT
o54Mp1UawjRLXrc19/15XYIadOwmVQ==
=jYst
-----END PGP SIGNATURE-----

--chbRJbj9PxXYEIZv07mxyGxiHNC4JzD2C--

