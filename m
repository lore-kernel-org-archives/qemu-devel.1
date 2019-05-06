Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6701C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AC620830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AC620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhUT-0000Me-P9
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:33:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNhP5-0005Ih-4z
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNhP3-0005bt-JP
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hNhP3-0005ab-Am
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21343C130719;
	Mon,  6 May 2019 17:27:48 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FF0160857;
	Mon,  6 May 2019 17:27:47 +0000 (UTC)
To: Antonio Ospite <ao2@ao2.it>, qemu-devel@nongnu.org
References: <20190503082728.16485-1-ao2@ao2.it>
	<20190503082728.16485-3-ao2@ao2.it>
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
Message-ID: <541bfc5c-0e45-58e6-f0b1-81e9b0c8881d@redhat.com>
Date: Mon, 6 May 2019 12:27:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503082728.16485-3-ao2@ao2.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7ju2hnhq9bgSHdVmKiw2i7aB1u2kJ7fLg"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 06 May 2019 17:27:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/2] configure: disallow spaces and
 colons in source path and build path
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Antonio Ospite <antonio.ospite@collabora.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ju2hnhq9bgSHdVmKiw2i7aB1u2kJ7fLg
From: Eric Blake <eblake@redhat.com>
To: Antonio Ospite <ao2@ao2.it>, qemu-devel@nongnu.org
Cc: Antonio Ospite <antonio.ospite@collabora.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <541bfc5c-0e45-58e6-f0b1-81e9b0c8881d@redhat.com>
Subject: Re: [PATCH v2 2/2] configure: disallow spaces and colons in source
 path and build path
References: <20190503082728.16485-1-ao2@ao2.it>
 <20190503082728.16485-3-ao2@ao2.it>
In-Reply-To: <20190503082728.16485-3-ao2@ao2.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/3/19 3:27 AM, Antonio Ospite wrote:
> From: Antonio Ospite <antonio.ospite@collabora.com>
>=20
> The configure script breaks when the qemu source directory is in a path=

> containing white spaces, in particular the list of targets is not
> correctly generated when calling "./configure --help" because of how th=
e
> default_target_list variable is built.
>=20
> In addition to that, *building* qemu from a directory with spaces break=
s
> some assumptions in the Makefiles, even if the original source path doe=
s
> not contain spaces like in the case of an out-of-tree build, or when
> symlinks are involved.
>=20
> To avoid these issues, refuse to run the configure script and the
> Makefile if there are spaces or colons in the source path or the build
> path, taking as inspiration what the kbuild system in linux does.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1817345
>=20
> Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
> ---
>  Makefile  | 4 ++++
>  configure | 6 ++++++
>  2 files changed, 10 insertions(+)
>=20

> +++ b/Makefile
> @@ -1,5 +1,9 @@
>  # Makefile for QEMU.
> =20
> +ifneq ($(words $(subst :, ,$(CURDIR))), 1)
> +  $(error main directory cannot contain spaces nor colons)
> +endif
> +
>  # Always point to the root of the build tree (needs GNU make).
>  BUILD_DIR=3D$(CURDIR)
> =20
> diff --git a/configure b/configure
> index 9832cbca5c..f7ad4381bd 100755
> --- a/configure
> +++ b/configure
> @@ -279,6 +279,12 @@ ld_has() {
>  # make source path absolute
>  source_path=3D$(cd "$(dirname -- "$0")"; pwd)
> =20
> +if printf "%s\n" "$source_path" | grep -q "[[:space:]:]" ||
> +  printf "%s\n" "$PWD" | grep -q "[[:space:]:]";

For less typing and fewer processes, you could shorten this to:

if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";

but that's trivial enough for a maintainer to fold in if desired.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7ju2hnhq9bgSHdVmKiw2i7aB1u2kJ7fLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzQbpIACgkQp6FrSiUn
Q2qNuAf/YRVor6YRh4GKA+Ni7PQiZBl2/WpPnglG75OyCwfXkHBVpRDqYtuQ83hP
kdpsNrKfH2kpEtVvOkkAeLnRGUtWgYplbfih5Hi/4EBkZ23FWxZb6WenrRL/1ltH
gltSjwJZRiUOog8w7KnkGxJhhAmy8CgjWKgPP6h4kNGMWBdy8nzj5TUZLgdSLX1o
9xUTLFnRVZh44fMpDnWkuGTSr7uP2HNa7s6iDxS/2wDkbuyZAboQ9Mg3m7BAmhX9
zad+pqoVcRwL+g7wWEoqNOpLRMP7wnMEuiqNEKG+8vXXQrLfIQoRKstvniGWWHpF
IqhyMI2SDVTUTL8vTuAmAsbyopT4xw==
=Jgf4
-----END PGP SIGNATURE-----

--7ju2hnhq9bgSHdVmKiw2i7aB1u2kJ7fLg--

