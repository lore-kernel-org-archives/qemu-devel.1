Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB3C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B43520879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B43520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQfL5-0005Cu-D5
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:51:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQfK7-0004lL-Fp
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQfK6-0005Lb-8B
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hQfJz-0005Fy-LZ; Tue, 14 May 2019 17:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8653308FED4;
	Tue, 14 May 2019 21:50:49 +0000 (UTC)
Received: from [10.3.116.43] (ovpn-116-43.phx2.redhat.com [10.3.116.43])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C2501001E67;
	Tue, 14 May 2019 21:50:40 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190514214230.22601-1-mreitz@redhat.com>
	<20190514214230.22601-2-mreitz@redhat.com>
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
Message-ID: <88ab9614-e1ec-650f-8834-4a906768aedb@redhat.com>
Date: Tue, 14 May 2019 16:50:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514214230.22601-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wvHelhw4PiKCjPM2sbVXIUGhjhEl9fFaY"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 14 May 2019 21:50:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] block/file-posix: Unaligned O_DIRECT
 block-status
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wvHelhw4PiKCjPM2sbVXIUGhjhEl9fFaY
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org
Message-ID: <88ab9614-e1ec-650f-8834-4a906768aedb@redhat.com>
Subject: Re: [PATCH 1/2] block/file-posix: Unaligned O_DIRECT block-status
References: <20190514214230.22601-1-mreitz@redhat.com>
 <20190514214230.22601-2-mreitz@redhat.com>
In-Reply-To: <20190514214230.22601-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/14/19 4:42 PM, Max Reitz wrote:
> Currently, qemu crashes whenever someone queries the block status of an=

> unaligned image tail of an O_DIRECT image:
> $ echo > foo
> $ qemu-img map --image-opts driver=3Dfile,filename=3Dfoo,cache.direct=3D=
on
> Offset          Length          Mapped to       File
> qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
> QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset'
> failed.
>=20
> This is because bdrv_co_block_status() checks that the result returned
> by the driver's implementation is aligned to the request_alignment, but=

> file-posix can fail to do so, which is actually mentioned in a comment
> there: "[...] possibly including a partial sector at EOF".
>=20
> Fix this by rounding up those partial sectors.
>=20
> There are two possible alternative fixes:
> (1) We could refuse to open unaligned image files with O_DIRECT
>     altogether.  That sounds reasonable until you realize that qcow2
>     does necessarily not fill up its metadata clusters, and that nobody=

>     runs qemu-img create with O_DIRECT.  Therefore, unpreallocated qcow=
2
>     files usually have an unaligned image tail.

Yep, non-starter.

>=20
> (2) bdrv_co_block_status() could ignore unaligned tails.  It actually
>     throws away everything past the EOF already, so that sounds
>     reasonable.
>     Unfortunately, the block layer knows file lengths only with a
>     granularity of BDRV_SECTOR_SIZE, so bdrv_co_block_status() usually
>     would have to guess whether its file length information is inexact
>     or whether the driver is broken.

Well, if I ever get around to my thread of making the block layer honor
byte-accurate sizes, instead of rounding up, then there is no longer
than inexactness. I think our mails crossed, and you missed another idea
of mine of having block drivers (probably only file-posix, per your
audit) set BDRV_BLOCK_EOF when returning an unaligned answer due to EOF,
as the key for letting the block layer know whether the unaligned answer
was due to size rounding.

>=20
> Fixing what raw_co_block_status() returns is the safest thing to do.

Agree.

>=20
> There seems to be no other block driver that sets request_alignment and=

> does not make sure that it always returns aligned values.

Thanks for auditing.

>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index e09e15bbf8..f489a5420c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2488,6 +2488,9 @@ static int coroutine_fn raw_co_block_status(Block=
DriverState *bs,
>      off_t data =3D 0, hole =3D 0;
>      int ret;
> =20
> +    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment) &&
> +           QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
> +

Can write in one line as:

assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));

>      ret =3D fd_open(bs);
>      if (ret < 0) {
>          return ret;
> @@ -2513,6 +2516,20 @@ static int coroutine_fn raw_co_block_status(Bloc=
kDriverState *bs,
>          /* On a data extent, compute bytes to the end of the extent,
>           * possibly including a partial sector at EOF. */
>          *pnum =3D MIN(bytes, hole - offset);
> +
> +        /*
> +         * We are not allowed to return partial sectors, though, so
> +         * round up if necessary.
> +         */
> +        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
> +            int64_t file_length =3D raw_getlength(bs);
> +            if (file_length > 0) {
> +                /* Ignore errors, this is just a safeguard */
> +                assert(hole =3D=3D file_length);
> +            }
> +            *pnum =3D ROUND_UP(*pnum, bs->bl.request_alignment);
> +        }

Reviewed-by: Eric Blake <eblake@redhat.com>

bl.request_alignment is normally 1 (making this a no-op), but is
definitely larger for O_DIRECT images (where rounding up and treating
the post-EOF hole the same as the rest of the sector is the same thing
that NBD chose to do).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--wvHelhw4PiKCjPM2sbVXIUGhjhEl9fFaY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzbOC8ACgkQp6FrSiUn
Q2oOJQf6A6mIaz+Ca8ufpHWA+l4HsmYAqtvbsngFOD825+SvYRb7I+OdDuEt01H1
4M9OA7bGN86MHal3GiVipa3fZwqrcVacvlhuK8XItHsO1qMbw/agOHmjFJeYxQMr
V6WkUYBMdMRcrVvb+4kTRaPhgDsNqHfefYG1wuNqYQwBH6VcUPcpXkiCBRaBCpg0
Ymse4Bybse6T24udPpcb77cSxe4hmKVLi3nqFIDLNt5rDVdcefMXYZeHeF1lQCrY
baVbUwYVVJESf8k2uFEaSFIedzBGvyuyl/d2K2tCifKBoRQjOhC7X2ve+KGyB7G3
AQeeVyuPN32zTBvdaSgFy/FVA5ndfg==
=Gtms
-----END PGP SIGNATURE-----

--wvHelhw4PiKCjPM2sbVXIUGhjhEl9fFaY--

