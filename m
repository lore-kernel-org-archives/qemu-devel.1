Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BA2C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F326E205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F326E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgtX-0005yF-9D
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:55:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNgrI-0004vt-Uf
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNgrH-0004hk-Bs
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:52:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hNgr7-0004Yo-Vk; Mon, 06 May 2019 12:52:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED6573082E1E;
	Mon,  6 May 2019 16:52:43 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F8665C21E;
	Mon,  6 May 2019 16:52:43 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
References: <20190501134127.21104-1-thuth@redhat.com>
	<ff77f7bb-650d-4a95-42da-55d0c8b49a6a@redhat.com>
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
Message-ID: <423e6bb2-493f-991d-2d35-4a9f84093625@redhat.com>
Date: Mon, 6 May 2019 11:52:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ff77f7bb-650d-4a95-42da-55d0c8b49a6a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hOBKIMWukAw8A4wozmDiOnydPe3VGtdgs"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 06 May 2019 16:52:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] tests/qemu-iotests: Fix more reference
 output files due to recent qemu-io change
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hOBKIMWukAw8A4wozmDiOnydPe3VGtdgs
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <423e6bb2-493f-991d-2d35-4a9f84093625@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/qemu-iotests: Fix more reference
 output files due to recent qemu-io change
References: <20190501134127.21104-1-thuth@redhat.com>
 <ff77f7bb-650d-4a95-42da-55d0c8b49a6a@redhat.com>
In-Reply-To: <ff77f7bb-650d-4a95-42da-55d0c8b49a6a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/6/19 10:32 AM, Max Reitz wrote:
> On 01.05.19 15:41, Thomas Huth wrote:
>> The output of qemu-io changed recently - most tests have been fixed in=

>> commit 36b9986b08787019ef42 ("tests/qemu-iotests: Fix output of qemu-i=
o
>> related tests") already, but the qcow1 and the vmdk test was still mis=
sing.
>>
>> Fixes: 99e98d7c9fc1a1639fad ("qemu-io: Use error_[gs]et_progname()")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/059.out |  8 ++++----
>>  tests/qemu-iotests/092.out | 24 ++++++++++++------------
>>  2 files changed, 16 insertions(+), 16 deletions(-)
>=20
> Hmm, nbd's 083 is also broken.  Would you mind fixing that, too? O:-)
>=20

See below for what to squash in. With that, I can give:
Reviewed-by: Eric Blake <eblake@redhat.com>

In fact, I don't mind taking it through my NBD tree, since there is at
least one other iotest fix for NBD pending.

diff --git i/tests/qemu-iotests/083.out w/tests/qemu-iotests/083.out
index 7419722cd7a..eee6dd13794 100644
--- i/tests/qemu-iotests/083.out
+++ w/tests/qemu-iotests/083.out
@@ -1,43 +1,43 @@
 QA output created by 083
 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect after neg1 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 8 neg1 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 16 neg1 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect before export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect after export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 4 export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 12 export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 16 export =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect before neg2 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D

@@ -45,11 +45,11 @@ read failed: Input/output error

 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect 10 neg2 =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect before request =3D=3D=3D

@@ -86,23 +86,23 @@ read 512/512 bytes at offset 0

 =3D=3D=3D Check disconnect before neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect 8 neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect 16 neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect 24 neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect 28 neg-classic =3D=3D=3D

-can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D

@@ -110,43 +110,43 @@ read failed: Input/output error

 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect after neg1 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 8 neg1 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 16 neg1 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect before export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect after export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 4 export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 12 export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 16 export =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect before neg2 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D

@@ -154,11 +154,11 @@ read failed: Input/output error

 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 10 neg2 =3D=3D=3D

-can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect before request =3D=3D=3D

@@ -195,23 +195,23 @@ read 512/512 bytes at offset 0

 =3D=3D=3D Check disconnect before neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 8 neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 16 neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 24 neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect 28 neg-classic =3D=3D=3D

-can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock

 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hOBKIMWukAw8A4wozmDiOnydPe3VGtdgs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzQZloACgkQp6FrSiUn
Q2orfAf/ZAyPcNbwGEvyX5h8CH63r3qoPjjmh7wJyf4EdcG6HresgRMWT7nle7xY
UrUjmafohQr2z7NNVFlch1nwAZWQvJiMxxBACx3KQ0YMYNGLxj0YlkHtolsgKoiM
LSU4NgfAve9q+nvSKN2/DL2Q5sdImMi+GSAcf0glQ/Dsy+CZ9tWTTuvjYr6HuQlS
iOmH+6wAh3VSblRLekUCyzHfTZTUYJdlQ7VvurTb0ptt1LZl38VRRCxjIWNBHIOQ
/xMq2+sdoTJiO1p06S5+V61AeyMOtsNyequkzqJ3IhcIdtVVtUob87KL0eLkBqG6
Q8Y+ESAHGsZwM8dwmYGoWRN2AbSeTg==
=SNie
-----END PGP SIGNATURE-----

--hOBKIMWukAw8A4wozmDiOnydPe3VGtdgs--

