Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF57C468B0
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4BE2184B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4BE2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbsu4-0006oA-LF
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 16:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbsoq-0003BO-Lp
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbson-0002Vy-Dk
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hbsog-0001oW-8H; Fri, 14 Jun 2019 16:28:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 178C030860B6;
 Fri, 14 Jun 2019 20:28:22 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 767B8601AC;
 Fri, 14 Jun 2019 20:28:21 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-22-mreitz@redhat.com>
 <9ab668f2-1ce2-c9ac-ab8a-325f0d3ea15e@virtuozzo.com>
 <66ddd9e0-5d96-cf78-edd1-55246159fd60@redhat.com>
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
Message-ID: <f88c59dc-ff45-cc12-b96f-a36e9c3587ee@redhat.com>
Date: Fri, 14 Jun 2019 15:28:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <66ddd9e0-5d96-cf78-edd1-55246159fd60@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XI1A6yL1j1ciMzPl7tUEO42FKCAOEywHP"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 14 Jun 2019 20:28:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 21/42] block: Use CAFs for debug
 breakpoints
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XI1A6yL1j1ciMzPl7tUEO42FKCAOEywHP
Content-Type: multipart/mixed; boundary="sL3Wjoj12OPADGPLar4Ah4xZKxZ5KcKZy";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <f88c59dc-ff45-cc12-b96f-a36e9c3587ee@redhat.com>
Subject: Re: [PATCH v5 21/42] block: Use CAFs for debug breakpoints
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-22-mreitz@redhat.com>
 <9ab668f2-1ce2-c9ac-ab8a-325f0d3ea15e@virtuozzo.com>
 <66ddd9e0-5d96-cf78-edd1-55246159fd60@redhat.com>
In-Reply-To: <66ddd9e0-5d96-cf78-edd1-55246159fd60@redhat.com>

--sL3Wjoj12OPADGPLar4Ah4xZKxZ5KcKZy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/14/19 11:12 AM, Max Reitz wrote:
> On 14.06.19 17:29, Vladimir Sementsov-Ogievskiy wrote:
>> 13.06.2019 1:09, Max Reitz wrote:
>>> When looking for a blkdebug node (which implements debug breakpoints)=
,
>>> use bdrv_primary_bs() to iterate through the graph, because that is
>>> where a blkdebug node would be.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>
>> Honestly, don't know why blkdebug is always searched in ->file sequenc=
e,
>=20
> Usually, blkdebug is just above the protocol node.  So
>=20
> $format --file--> $protocol
>=20
> becomes
>=20
> $format --file--> blkdebug --file--> $protocol
>=20
> This is why the existing code generally looks for blkdebug under the
> ->file link.

blkdebug is an interesting beast; there are use cases for both:

blkdebug -> qcow2 -> file

for debugging only guest-visible actions, and

qcow2 -> blkdebug -> file

for debugging specific qcow2 metadata actions.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--sL3Wjoj12OPADGPLar4Ah4xZKxZ5KcKZy--

--XI1A6yL1j1ciMzPl7tUEO42FKCAOEywHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0EA2QACgkQp6FrSiUn
Q2obGgf9GMFmqt4F0Fq7CKzKC5lUZNjToIugBT8tL8qKxVoouwsqTMq+kzp8Xuob
oiZ8B+pkgyeC8+gs6McGndrvoRYuMxii99OTBUa/yIL04RLswbAkL2wvdwahz91a
k06nn9TwmXCjCuqBbeCMbRQpW6CmiBmfONa3t7NIgYplH4vCr9hqT4ZlqsB2/9qN
Tc9VGt3E03HGlHEb35eQrG2g0ga6hnXvyFiLBr2zGJo9vY2R0FqACQIEBvCWeKI4
zgWamJLa1xTOjLep09JHzC1Sr+a7OkFQH7kaCeQUZH5Ck6/hgMssNArSfTyfvKFU
ZeYYf1ZmM8jYSuZ0/UI/PhYBHKNIsA==
=OBC3
-----END PGP SIGNATURE-----

--XI1A6yL1j1ciMzPl7tUEO42FKCAOEywHP--

