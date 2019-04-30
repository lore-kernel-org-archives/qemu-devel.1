Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1518BC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6F220651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6F220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLUCP-0005j0-5t
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 10:57:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUBN-0005Bv-FJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUBK-0007zg-QF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hLUBF-0007wh-68; Tue, 30 Apr 2019 10:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4753A308622F;
	Tue, 30 Apr 2019 14:56:22 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98CB8438A;
	Tue, 30 Apr 2019 14:56:21 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
	mreitz@redhat.com
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
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
Message-ID: <dd8e89d4-b9eb-da1f-5afa-52c3399cf7e5@redhat.com>
Date: Tue, 30 Apr 2019 09:56:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KM2JIEuPxsez22lvFycvPTytsdfFe6E95"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 30 Apr 2019 14:56:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] [RFC] qcow2: add compression type feature
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430145620.1z04w2BkeKBKDEJq93BxRloVD84suhpJJ-jLtlaO1U4@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KM2JIEuPxsez22lvFycvPTytsdfFe6E95
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com
Message-ID: <dd8e89d4-b9eb-da1f-5afa-52c3399cf7e5@redhat.com>
Subject: Re: [PATCH] [RFC] qcow2: add compression type feature
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/5/19 3:08 AM, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type=

> feature into QCOW2 header that indicates that *all* compressed clusters=

> must be (de)compressed using a certain compression type.
>=20
> It is implied that the compression type is set on the image creation an=
d
> can be changed only later by image convertion, thus the only compressio=
n

s/convertion/conversion/

> algorithm is used for the image.
>=20
> The plan is to add support for ZSTD and then may be something more effe=
ctive
> in the future.
>=20
> ZSDT compression algorithm consumes 3-5 times less CPU power with a

s/ZSDT/ZSTD/

> comparable comression ratio with zlib. It would be wise to use it for

s/comression/compression/

> data compression f.e. for backups.
>=20
> The default compression is ZLIB.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 25 +++++++++++++++++++++++++
>  block/qcow2.h | 26 ++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8c91b92865..cb3d6cc1c0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> +#define  QCOW2_EXT_MAGIC_COMPRESSION_TYPE 0x434D5052

This appears to be adding a new header extension magic number, but
didn't actually modify the specification. I'd expect this patch to touch
docs/interop/qcow2.txt before it can be considered complete.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KM2JIEuPxsez22lvFycvPTytsdfFe6E95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIYhQACgkQp6FrSiUn
Q2rmiggAqzP0L8JnSkfqyUKjaopPtS+F8W2w+RmzssZuAkJifk0yLOkVwtcW4EVH
St15IHLsPTlhyuYo89v4Jno530E0Lnu8EX9MAXhkisZ9aGT6k3T5b2GBQxQCmXyy
Enq+XHR5+ookoNywn51l+xDb5wZq87eKxJZOMi9jOmN+TE3HU9RwI66V6VMYw1tu
7vK9yUYIPGccbulSuSDcY3wBzfHC7HZem2nGymbj/Zc6/cVgB19PQiVR9+UTUXR2
hmqN0F+pqcBO5WxbGnuUOaL8LfG8XKKgpZRYmijQjOEeL6KkHULvzHJPH7Vg0970
1BtLk+5d3OosZkBwyXlNTSs6Ot990w==
=x0uO
-----END PGP SIGNATURE-----

--KM2JIEuPxsez22lvFycvPTytsdfFe6E95--

