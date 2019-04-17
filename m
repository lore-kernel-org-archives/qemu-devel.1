Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107CEC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84402173C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84402173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGnuf-0003xL-0p
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 12:59:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGntq-0003bc-At
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGntp-0005fI-Bq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:59:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGntm-0005cg-KJ; Wed, 17 Apr 2019 12:59:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F82E81F11;
	Wed, 17 Apr 2019 16:59:00 +0000 (UTC)
Received: from [10.3.116.103] (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C44660143;
	Wed, 17 Apr 2019 16:58:58 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20190401145741.28322-1-eblake@redhat.com>
	<d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
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
Message-ID: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Date: Wed, 17 Apr 2019 11:58:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VbYyaMBiNNYFYGw4M5JJOIt4UxXFzctrx"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 17 Apr 2019 16:59:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417165857.A31BEigTYtmojN8W3Nyd33u1CIMJhAArbXldqZbeE60@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VbYyaMBiNNYFYGw4M5JJOIt4UxXFzctrx
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Subject: Re: [PATCH for-4.1 v2] qemu-img: Saner printing of large file sizes
References: <20190401145741.28322-1-eblake@redhat.com>
 <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
In-Reply-To: <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 2:28 PM, Max Reitz wrote:
> On 01.04.19 16:57, Eric Blake wrote:
>> Disk sizes close to INT64_MAX cause overflow, for some pretty
>> ridiculous output:
>>
>>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info =
$nbd'
>>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>>   file format: raw
>>   virtual size: -8388607T (9223372036854775296 bytes)
>>   disk size: unavailable
>>

>=20
> There are more iotests this breaks.  First, there is 059 for vmdk, whic=
h
> looks just like the rest.

Easy enough; I was able to reproduce.

>=20
> But for -m32, it gets a bit more difficult.  Every size above 999 GB
> (1000 GB gets rounded to 1 TB, which is 2^31 * 512) gets printed as
> "inf [unit]":

Ouch - pre-existing bug in size_to_str(); I'll have to fix that, then
send a v3.

Kevin, do you want to unqueue this from block-next until then?

>=20
> But regardless of the iotests, we shouldn=E2=80=99t show the size as in=
finite
> just because of -m32.

Is there an easy docker setup for building -m32?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VbYyaMBiNNYFYGw4M5JJOIt4UxXFzctrx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3W1EACgkQp6FrSiUn
Q2o5QAgAoup69jIha5tJTEzZu3qIqFpbruAnlNoQCO2wqBlK9t//+vaPW52lDHYV
xfLMly9mK3F5eJlIjkWkh432LSrSx5eRH66tdYtPTXnVmNeCw4GZ82B45kyUQLAO
x5kAyoKB1OY5dkqxLEt6YoLTrwV8qgBnwO8vrbi5tlFMjkuQar00tiLU02mZ74c7
jbeEK8HX3sPxaeJhUox3QiBx7CiC45rGKpCAkcq2t/DPawdI2QOvkywyfu8jvV+v
+mUDGQL3c2U0zBEMhEOFmnQH6KIj2X4OHGkI75r1eUnNt82gOczrnSdvh1N6zm36
feHuR903W6Z8xjKdMeKOEb15DzfQ8A==
=A9BI
-----END PGP SIGNATURE-----

--VbYyaMBiNNYFYGw4M5JJOIt4UxXFzctrx--

