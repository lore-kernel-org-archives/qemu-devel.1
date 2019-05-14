Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D5C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F4920879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F4920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQf7T-0007Dj-UG
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:37:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQf6Z-0006tV-4L
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQf6X-0002ID-TV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hQf6V-0002Eb-2D; Tue, 14 May 2019 17:36:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA6B23082B4F;
	Tue, 14 May 2019 21:36:53 +0000 (UTC)
Received: from [10.3.116.43] (ovpn-116-43.phx2.redhat.com [10.3.116.43])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE5F960F81;
	Tue, 14 May 2019 21:36:52 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
References: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
	<5e56cded-5097-ce97-6f2b-7afee8e480af@redhat.com>
	<ce551fef-3987-a5fd-7280-e406226c6a20@redhat.com>
	<20a7f01f-894c-e121-afc9-03415f55aa82@redhat.com>
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
Message-ID: <f9865b64-0882-6e29-e80a-6cbb5998d181@redhat.com>
Date: Tue, 14 May 2019 16:36:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20a7f01f-894c-e121-afc9-03415f55aa82@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5qthRLOizTGiBaxJQbeQMm1GWhhPvRVak"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 14 May 2019 21:36:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Unaligned images with O_DIRECT
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5qthRLOizTGiBaxJQbeQMm1GWhhPvRVak
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <f9865b64-0882-6e29-e80a-6cbb5998d181@redhat.com>
Subject: Re: Unaligned images with O_DIRECT
References: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
 <5e56cded-5097-ce97-6f2b-7afee8e480af@redhat.com>
 <ce551fef-3987-a5fd-7280-e406226c6a20@redhat.com>
 <20a7f01f-894c-e121-afc9-03415f55aa82@redhat.com>
In-Reply-To: <20a7f01f-894c-e121-afc9-03415f55aa82@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/14/19 12:28 PM, Max Reitz wrote:

>>>
>>> The tail of an unaligned file is generally inaccessible to O_DIRECT,
>>
>> Especially with this.
>>
>>> where it is easier to use ftruncate() up to an aligned boundary if yo=
u
>>> really must play with that region of the file, and then ftruncate() b=
ack
>>> to the intended size after I/O. But that sounds hairy.  We could also=

>>> round down and silently ignore the tail of the file, but that is at o=
dds
>>> with our practice of rounding size up.  So for the short term, I'd be=

>>> happy with a patch that just rejects any attempt to use cache.direct=3D=
on
>>> (O_DIRECT) with a file that is not already a multiple of the alignmen=
t
>>> required thereby. (For reference, that's what qemu as NBD client
>>> recently did when talking to a server that advertises a size
>>> inconsistent with forced minimum block access: commit 3add3ab7)
>>
>> OK, I=E2=80=99ll send a patch.  Thanks for you explanation!
> Well, or maybe not.
>=20
> $ ./qemu-img create -f qcow2 foo.qcow2 64M
> $ ./qemu-img map --image-opts \
>     driver=3Dqcow2,file.filename=3Dfoo.qcow2,cache.direct=3Don
> qemu-img: Could not open
> 'driver=3Dqcow2,file.filename=3Dfoo.qcow2,cache.direct=3Don': File leng=
th
> (196616 bytes) is not a multiple of the O_DIRECT alignment (512 bytes)
> Try cache.direct=3Doff, or increasing the file size to match the alignm=
ent
>=20
> That may be considered a bug in qcow2.  Maybe it should always fill all=

> clusters.  But even if we did so and fixed it now, we can=E2=80=99t dis=
allow
> qemu from opening such images.
>=20
> Also, well, the tail is accessible, we just need to access it with the
> proper alignment (and then we get a short read).  This seems to be
> handled just fine.

Oh. Yeah, short reads with O_DIRECT are possible (short writes not so
much; for those, you have to write a full buffer then ftruncate back
down). But we DO want to support short reads because of pre-existing
images, whether or not we also improve qcow2 to always create aligned
image sizes. The qcow2 spec allows unaligned images, even if we quit
creating new ones.

>=20
> So I think file-posix should just return a rounded result.  Well, or
> bdrv_co_Block_status() could ignore it for the EOF, because it throws
> away everything past the EOF anyway with:
>=20
>     if (*pnum > bytes) {
>         *pnum =3D bytes;
>     }
>=20
> On one hand, I agree that file-posix should return an aligned result.
> On the other, it doesn=E2=80=99t make a difference, so I don=E2=80=99t =
think we need to
> enforce it (at EOF).

My thoughts:

Right now, only io.c sets (or even reads) BDRV_BLOCK_EOF, and it is
documented as an internal flag for optimizations.  But it would be very
easy to amend the contract of driver's .bdrv_co_block_status to state
that a driver may set BDRV_BLOCK_EOF at the end of a file, and MUST set
that flag if the end of the file also happens to be unaligned with
respect to the driver's request_alignment. (Most drivers won't need to
care, but file-posix.c under O_DIRECT would have to start caring).  Then
fix io.c to relax the assertion - the result must either be aligned
(current condition) OR the driver must have reported BDRV_BLOCK_EOF (new
condition). At that point, the block layer can take care of rounding out
the block status for the unaligned tail beyond EOF up to the alignment
boundary (similar to the rounding I have proposed in my other patches).
If you don't get to that first, then it looks like I'll have to fold
that in to my v2 patches when I get back to addressing those block
status alignment problems.

Thanks again for testing, and forcing me to think about the issue.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5qthRLOizTGiBaxJQbeQMm1GWhhPvRVak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzbNPMACgkQp6FrSiUn
Q2pZJAgAlcXGsB0X4PpXznSS4YtwScRRtxq+0SQ8IXDXvPELjLeNb2jPbepvG99i
OW8gA+oO/+p9FmmARACh3eFzcK0gMeY/FTYxh9aiqdfCqN35pDjAr3/JIWDECyV6
SxdMLxyniSF4aKDrvVsS+bhZicB81smP7TvOz7XgX8u8xrJwRsLxLTq4kYl+3wF3
ji+St2SUlPYSl0xip75+uu/QUm6ZhtHc7fvOshpNwddBjnprEI6cyk34gpDBm2mi
BOpr+dxgZa0N4iNJ8IW9YWQQjtfUpm/h7GIr8o64HA7cZYYh2KraKESEuEVpcio5
oR5puG8OixGJQWV/LRoEDaphtwkHYg==
=HkLV
-----END PGP SIGNATURE-----

--5qthRLOizTGiBaxJQbeQMm1GWhhPvRVak--

