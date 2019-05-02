Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC8DC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DA22053B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DA22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58988 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMJe0-00038w-O5
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 17:53:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJdB-0002pk-OJ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJdA-00028r-NG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:52:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hMJdA-00028X-En
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:52:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69E033082AF4;
	Thu,  2 May 2019 21:52:39 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A7D15D9C4;
	Thu,  2 May 2019 21:52:37 +0000 (UTC)
To: driver1998 <driver1998@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
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
Message-ID: <d23b59fa-2909-f124-3aab-cc5ded90f063@redhat.com>
Date: Thu, 2 May 2019 16:52:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q408gS0RnRblfdc4E9BjHNYJ8W6F8pMxq"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 02 May 2019 21:52:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion
 warningin commands-win32.c, hit by clang.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502215237.sJFq9hmVONx5c3Q0mmITCkd0faNp9pzzy6zgZY8tkQk@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q408gS0RnRblfdc4E9BjHNYJ8W6F8pMxq
From: Eric Blake <eblake@redhat.com>
To: driver1998 <driver1998@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <d23b59fa-2909-f124-3aab-cc5ded90f063@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion warningin
 commands-win32.c, hit by clang.
References: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
In-Reply-To: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 4:18 PM, driver1998 wrote:
> On 5/1/19 2:25 AM, Eric Blake wrote:
>> This adds lots of explicit casts. Are they actually necessary? Without=

>> seeing the actual warning, it seems fishy to have to be this explicit.=

>=20
> So here are the warnings, on clang version 9.0.0 (trunk 351977).
>=20
> qga/commands-win32.c:461:24: error: implicit conversion from enumeratio=
n type 'enum GuestDiskBusType' to different
>       enumeration type 'STORAGE_BUS_TYPE' (aka 'enum _STORAGE_BUS_TYPE'=
) [-Werror,-Wenum-conversion]
>     [BusTypeUnknown] =3D GUEST_DISK_BUS_TYPE_UNKNOWN,
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~

> qga/commands-win32.c:486:12: error: implicit conversion from enumeratio=
n type 'STORAGE_BUS_TYPE'
>       (aka 'enum _STORAGE_BUS_TYPE') to different enumeration type 'Gue=
stDiskBusType' (aka 'enum GuestDiskBusType')
>       [-Werror,-Wenum-conversion]
>     return win2qemu[(int)bus];
>     ~~~~~~ ^~~~~~~~~~~~~~~~~~

Where is enum STORAGE_BUS_TYPE defined? I see GuestDiskBusType (via
qga/qapi-schema.json's 'enum':'GuestDiskBusType'), but if
STORAGE_BUS_TYPE is a type declared by some external project, we are
probably better off writing a two-way conversion table or switch
statement, rather than relying on the two enums currently happening to
have identical values (but where that might break if we accidentally
rearrange our .json QAPI file or if the external file changes their
enum).  In fact, it looks like win2qemu[] is supposed to be that table,
but it was incorrectly written.  You WANT to do:

diff --git i/qga/commands-win32.c w/qga/commands-win32.c
index d40d61f605c..6b67f16faf1 100644
--- i/qga/commands-win32.c
+++ w/qga/commands-win32.c
@@ -457,7 +457,7 @@ void qmp_guest_file_flush(int64_t handle, Error **err=
p)

 #ifdef CONFIG_QGA_NTDDSCSI

-static STORAGE_BUS_TYPE win2qemu[] =3D {
+static GuestDiskBusType win2qemu[] =3D {
     [BusTypeUnknown] =3D GUEST_DISK_BUS_TYPE_UNKNOWN,
     [BusTypeScsi] =3D GUEST_DISK_BUS_TYPE_SCSI,
     [BusTypeAtapi] =3D GUEST_DISK_BUS_TYPE_IDE,

with no casts needed, either in the table or in the function that
references the table.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Q408gS0RnRblfdc4E9BjHNYJ8W6F8pMxq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzLZqUACgkQp6FrSiUn
Q2r8+QgAgIfrpzuIMPxr4fUBmtMhGDGm7SLvTTXn6UpK57wFa/mPcRp+HVYH5epJ
0TQOCWopMshCsXNbH8FvBnSnF4Q4rQlKEzGNxoVlJSXQF6rFHXl+g1WLjjO64+Vp
E4Ld9/ay6ui9r9q3kk+Fmo1/waTwtkpZSVUHf7a2aVsItDww/gL9r2jvTxNNy5Z/
8M6s3fvUcgAuIbELWghbw1cKimNEmeSYdu6tvMZ33aUGGtKCdab7uFuqEDZUB2Dp
Z0R/KjDA6lMkWb93LXWU3i5fEU1HXQnrexSlJZ2hP1FYv+/km/9AiDd0RvVsLVvH
oZFpvFQPZZ+1OKj3SVsKd6yXazfLdw==
=e+Oi
-----END PGP SIGNATURE-----

--Q408gS0RnRblfdc4E9BjHNYJ8W6F8pMxq--

