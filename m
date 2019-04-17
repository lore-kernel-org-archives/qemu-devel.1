Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9F1C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 14:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CCC206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 14:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CCC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54867 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGlsO-0005ZV-1a
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 10:49:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGlrO-0005FY-Qe
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGlrN-0003pG-PK
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGlrL-0003ml-10; Wed, 17 Apr 2019 10:48:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47AC930833A0;
	Wed, 17 Apr 2019 14:48:22 +0000 (UTC)
Received: from [10.3.116.103] (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB021001E8A;
	Wed, 17 Apr 2019 14:48:18 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
	<20190417100929.39943-2-vsementsov@virtuozzo.com>
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
Message-ID: <dd1f30c4-e6ab-6481-ae34-412fa8533a5f@redhat.com>
Date: Wed, 17 Apr 2019 09:48:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417100929.39943-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Il8CR8COfxCetBk0W7SE0XdQMkisZjfL4"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 17 Apr 2019 14:48:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
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
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, stefanha@redhat.com,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417144817.sB5d4vY94vAqVwV5v4Xl6JK7Vde4SsPQkCyA5PK65wM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Il8CR8COfxCetBk0W7SE0XdQMkisZjfL4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com,
 stefanha@redhat.com
Message-ID: <dd1f30c4-e6ab-6481-ae34-412fa8533a5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/io: bdrv_pdiscard: support int64_t
 bytes parameter
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
 <20190417100929.39943-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190417100929.39943-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 5:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> This fixes at least one overflow in qcow2_process_discards.

It's worth calling out how long the problem of passing >2G discard
requests has been present (my reply to the cover letter tracked down
0b919fae as tracking a 64-bit discard region but passing it to
bdrv_discard() which took an int sectors; I'm not sure if later changes
to byte-based rather than sector-based made a difference).


> @@ -2664,14 +2664,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry=
(void *opaque)
>      aio_wait_kick();
>  }
> =20
> -int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, in=
t bytes)
> +int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
> +                                  int64_t bytes)
>  {
>      BdrvTrackedRequest req;
>      int max_pdiscard, ret;
>      int head, tail, align;
>      BlockDriverState *bs =3D child->bs;
> =20
> -    if (!bs || !bs->drv) {
> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {

This change seems unrelated? Oh, it's because you are inlining the rest
of what bdrv_check_byte_request used to do.

>          return -ENOMEDIUM;
>      }
> =20
> @@ -2679,9 +2680,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *chil=
d, int64_t offset, int bytes)
>          return -EPERM;
>      }
> =20
> -    ret =3D bdrv_check_byte_request(bs, offset, bytes);
> -    if (ret < 0) {
> -        return ret;

If we keep this call in place, we can flag if there were any other
callers that were passing truncated 64-bit quantities. But I also agree
that now that we are switching to a 64-bit interface, we no longer have
to check whether callers were properly limiting their requests.

Hmm - I just realized that bdrv_check_byte_request() takes a size_t
(rather than int64_t) size argument - could this result in any other
truncations on a 32-bit platform that don't affect 64-bit platforms?

> @@ -2711,12 +2711,13 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *ch=
ild, int64_t offset, int bytes)
>          goto out;
>      }
> =20
> -    max_pdiscard =3D QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pdiscard,=
 INT_MAX),
> +    max_pdiscard =3D QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pdiscard,=

> +                                                BDRV_REQUEST_MAX_BYTES=
),
>                                     align);

This change is a no-op, since BDRV_REQUEST_MAX_BYTES is already INT_MAX
aligned down to sector size, and align is at least sector size.

>      assert(max_pdiscard >=3D bs->bl.request_alignment);
> =20
>      while (bytes > 0) {
> -        int num =3D bytes;
> +        int64_t num =3D bytes;
> =20
>          if (head) {
>              /* Make small requests to get to alignment boundaries. */
> @@ -2778,7 +2779,7 @@ out:
>      return ret;
>  }
> =20
> -int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes)
> +int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
>  {
>      Coroutine *co;
>      DiscardCo rwco =3D {
>=20

I'm not sure the patch is perfect, but I definitely agree that we want
to support 64-byte discard length (where the block layer fragments the
request as needed) rather than the current 32-byte discard length (where
callers have to be careful to not suffer from truncation).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Il8CR8COfxCetBk0W7SE0XdQMkisZjfL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3PLEACgkQp6FrSiUn
Q2oy6AgAo5cCga5p/j860/OxocJuLIHml0oQlrDTCx2+WTmJVEEW1gidAfmISRRe
VOkvSIKSmK9Yur91GOVjL0Oa2Yb2SlnIBxw0kiGuVi11C6JxWDWNPZRvoKwkaXIb
4wov68M0Elrj9gaPlO5iRIbkJqj4VJuSeyQVPccL+6XmohUroBgTKwgENyOQNAzO
Pau3zNes/Vy77gUOm6Kro28rEg46GlOOcaPhsxYoERwc2jXSyHGa2IFdLIEoenQ2
eln1Z4iDQ6DPM5MFKkrVRld2mdnoOTfLvRw8IxQWKzmtnM2FI+BfqOgsxfY/f2xy
atfXVqPVdI0bKusLeO0guYJnpG8m2A==
=gbF3
-----END PGP SIGNATURE-----

--Il8CR8COfxCetBk0W7SE0XdQMkisZjfL4--

