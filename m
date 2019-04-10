Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C1C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFBE20830
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFBE20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEK7T-0005AE-UB
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:46:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEK5o-0003v4-FW
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEK5n-0001Ht-5O
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:45:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hEK5k-0001Cu-2H; Wed, 10 Apr 2019 16:45:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3FE189C37;
	Wed, 10 Apr 2019 20:45:06 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC9FB5C666;
	Wed, 10 Apr 2019 20:44:59 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-5-eblake@redhat.com>
	<7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
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
Message-ID: <77387fd3-3265-b48a-c2f6-a8a0613dfbb1@redhat.com>
Date: Wed, 10 Apr 2019 15:44:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lXN7o32Pb9Z2M95NEAcAeW39pdi9YvpYS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 10 Apr 2019 20:45:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 4/7] iotests: Update 241 to expose backing
 layer fragmentation
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
Cc: Kevin Wolf <kwolf@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410204458.WVF-2lhm8GqKfiTZTMKKK20QVUdBn1OsxQvCvZ25KF8@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lXN7o32Pb9Z2M95NEAcAeW39pdi9YvpYS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <77387fd3-3265-b48a-c2f6-a8a0613dfbb1@redhat.com>
Subject: Re: [PATCH 4/7] iotests: Update 241 to expose backing layer
 fragmentation
References: <20190403030526.12258-1-eblake@redhat.com>
 <20190403030526.12258-5-eblake@redhat.com>
 <7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
In-Reply-To: <7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/19 8:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 03.04.2019 6:05, Eric Blake wrote:
>> Previous commits have mentioned that our NBD server still sends
>> unaligned fragments when an active layer with large advertised minimum=

>> block size is backed by another layer with a smaller block
>> size. Expand the test to actually cover this scenario, by using qcow2
>> encryption (which forces 512-byte alignment) with an unaligned raw
>> backing file.
>>
>> The test passes, but only because the client side works around the
>> server's non-compliance; if you repeat the test manually with tracing
>> turned on, you will see the server sending a status for 1000 bytes
>> data then 1048 bytes hole, which is not aligned. But reverting commit
>> 737d3f5244 shows that it is indeed the client working around the bug
>> in the server.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Oops, 241 fails for me:
>=20
> -WARNING: Image format was not specified for '/home/eblake/qemu/tests/q=
emu-iotests/scratch/t.raw' and probing guessed raw.
> +WARNING: Image format was not specified for '/work/src/qemu/eric/tests=
/qemu-iotests/scratch/t.raw' and probing guessed raw.
>=20
> We forget to filter output :(

The filter bug is pre-existing; separate patch for that is now posted.

>=20
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I saw this email before -rc3, but thought I had only introduced the
problem in this patch which I omitted from my rc3 pull request. Oh well,
the actual break in iotests came earlier; if there's an -rc4 for other
reasons, we'll get the test fixed then.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lXN7o32Pb9Z2M95NEAcAeW39pdi9YvpYS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuVcoACgkQp6FrSiUn
Q2o0cQf+IAtnrEi0vQYdC1KCx134jRTfmA4IXXmcSuxbYlDoA7/0Mt00SbwzMl/L
6dZMWkNjS79YpvzmjgwV7BSGuaygwIoDNqc4tWb3d624zgCXKEq5WOiN7Rq9k3hA
9kO/u8ES8WmoQ6Zb7lU0rDe3TXXc5+4eAk6p+lG8BUxx9P2GXUBbjy7E7eaClj0t
Urk1PLLpDFmeBSylGI3g1RJKNYh00OlVhE468drOBH1t5ey34s3J9MCQpEI5cIIB
H+sI515YLBYYNGzjdhRUqn1yeskWTRz1VRch3TEFjpk9m1Rxp2SRr/m+/mdepxlx
oMwrkJP9COPZQHgNW3DxUD46ANKPWg==
=ecaD
-----END PGP SIGNATURE-----

--lXN7o32Pb9Z2M95NEAcAeW39pdi9YvpYS--

