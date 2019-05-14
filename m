Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F84C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482E020879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZeX-0002QP-Hg
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:47:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQZd0-0001mh-LR
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQZcz-0007vf-H7
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hQZcw-0007m1-ST; Tue, 14 May 2019 11:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56C6066982;
	Tue, 14 May 2019 15:45:52 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A26695D720;
	Tue, 14 May 2019 15:45:49 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
References: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
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
Message-ID: <5e56cded-5097-ce97-6f2b-7afee8e480af@redhat.com>
Date: Tue, 14 May 2019 10:45:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NHkBRa74zw5c2QAdBQXEujCYaClruw1yY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 14 May 2019 15:45:52 +0000 (UTC)
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
--NHkBRa74zw5c2QAdBQXEujCYaClruw1yY
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <5e56cded-5097-ce97-6f2b-7afee8e480af@redhat.com>
Subject: Re: Unaligned images with O_DIRECT
References: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
In-Reply-To: <c276dc0c-0190-1e83-d491-8157d78ec817@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/14/19 10:06 AM, Max Reitz wrote:
> Hi,
>=20
> Unaligned images don=E2=80=99t work so well with O_DIRECT:
>=20
> $ echo > foo
> $ qemu-img map --image-opts driver=3Dfile,filename=3Dfoo,cache.direct=3D=
on
> Offset          Length          Mapped to       File
> qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
> QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset' faile=
d.
> [1]    10954 abort (core dumped)  qemu-img map --image-opts
> driver=3Dfile,filename=3Dfoo,cache.direct=3Don
>=20
> (compare https://bugzilla.redhat.com/show_bug.cgi?id=3D1588356)
>=20
> This is because the request_alignment is 512 (in my case), but the EOF
> is not aligned accordingly, so raw_co_block_status() returns an aligned=

> *pnum.

Uggh. Yet another reason why I want qemu to support byte-accurate
sizing, instead of rounding up. The rounding keeps raising its head in
more and more places. I have pending patches that are trying to improve
block status to round driver answers up to match request_alignment (when
the protocol layer has finer granularity than the format layer); but
this sounds like it is a bug in the file driver itself for returning an
answer that is not properly rounded according to its own
request_alignment boundary, and not one where my pending patches would he=
lp.

>=20
> I suppose having an unaligned tail is not so bad and maybe we can just
> adjust the assertion accordingly.  On the other hand, this has been
> broken for a while.  Does it even make sense to use O_DIRECT with
> unaligned images?  Shouldn=E2=80=99t we just reject them outright?

The tail of an unaligned file is generally inaccessible to O_DIRECT,
where it is easier to use ftruncate() up to an aligned boundary if you
really must play with that region of the file, and then ftruncate() back
to the intended size after I/O. But that sounds hairy.  We could also
round down and silently ignore the tail of the file, but that is at odds
with our practice of rounding size up.  So for the short term, I'd be
happy with a patch that just rejects any attempt to use cache.direct=3Don=

(O_DIRECT) with a file that is not already a multiple of the alignment
required thereby. (For reference, that's what qemu as NBD client
recently did when talking to a server that advertises a size
inconsistent with forced minimum block access: commit 3add3ab7)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NHkBRa74zw5c2QAdBQXEujCYaClruw1yY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlza4qwACgkQp6FrSiUn
Q2qPMwf/fyHsOQsLCktt5LrNMDzdKkTvHzYQ7tHhKtegtUpQCIKfXF4Of2I/q9U6
Yq8stjF9IAzAgjFMqL7CNXUGrS8CXQNxvEaONzpizh9wzuPZbRP+RkmPXw0Ura/T
rHYvJhOJhbsHl7y+UFrvFMMev3m7iQtYrHrKNE1DVjTolc25WKmJl5Vvr9uQhzKc
6qjWKFPF43b7ilOE5h0wt5R2QwXjf6e7MDEFJynA0P0Q0fU1fPx+cMmRitUG/Gf7
T4WFjHba7bHBq24j+hjFY6//L4usTswPW7Jyc0qUZAbdnB69v036N85weRMdWZwJ
/DJVvzccy2lVZOHgPBom3wWp9/CBJQ==
=nAm8
-----END PGP SIGNATURE-----

--NHkBRa74zw5c2QAdBQXEujCYaClruw1yY--

