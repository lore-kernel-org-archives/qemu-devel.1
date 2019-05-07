Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76054C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEC72087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEC72087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0q7-0000vP-MR
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 10:13:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO0oV-0008ID-UU
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO0oS-0000WJ-DO
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:11:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hO0oS-0000UP-4d
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:11:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC62D59468;
	Tue,  7 May 2019 14:11:16 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A2C895EDE4;
	Tue,  7 May 2019 14:11:10 +0000 (UTC)
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org,
	peter.maydell@linaro.org
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
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
Message-ID: <0da3ec00-9040-f367-7666-a54824f1dcde@redhat.com>
Date: Tue, 7 May 2019 09:11:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GJxKokgzwqP1e9kn0SJy4OnMhEW59lnaA"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 07 May 2019 14:11:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule
 project
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
Cc: jan.kiszka@siemens.com, stefanha@redhat.com,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GJxKokgzwqP1e9kn0SJy4OnMhEW59lnaA
From: Eric Blake <eblake@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: stefanha@redhat.com, jan.kiszka@siemens.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <0da3ec00-9040-f367-7666-a54824f1dcde@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule
 project
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 5:30 PM, Samuel Thibault wrote:
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e=
41df:
>=20
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-reques=
t' into staging (2019-05-02 12:04:51 +0100)
>=20
> are available in the Git repository at:
>=20
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>=20
> for you to fetch changes up to 7c57bdd82026ba03f3158bbcd841afde7c2dc43a=
:
>=20
>   build-sys: move slirp as git submodule project (2019-05-03 00:15:37 +=
0200)
>=20
> ----------------------------------------------------------------
> slirp: move slirp as git submodule project
>=20
> Marc-Andr=C3=A9 Lureau (2):
>   build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
>   build-sys: move slirp as git submodule project
>=20
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (2):
>       build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
>       build-sys: move slirp as git submodule project

After this series, an in-tree build is seeing a dirty tree, thanks to:

> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working direct=
ory)
>   (commit or discard the untracked or modified content in submodules)
>=20
> 	modified:   slirp (untracked content)

which in reality is due to:

$ cd slirp/
$ git status
HEAD detached at 59a1b1f
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	libslirp.a
	src/arp_table.d
	src/arp_table.o
=2E..

libslirp probably needs a .gitignore for *.a, *.o, *.d, and
src/libslirp-version.h

And actually getting it to apply during qemu's build will need another
submodule update.

In the meantime, where do we stand on our goal of disabling in-tree build=
s?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--GJxKokgzwqP1e9kn0SJy4OnMhEW59lnaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzRkf0ACgkQp6FrSiUn
Q2rlPAf+Jbqd1cH5wyKXgOd9zO+ALBsRY9LEL5zwMDqkAN4njNSxDVpcHlh69aE5
8BIoMR2ZT9LnYL0JVUdcP9uq1G0rY+bo/0R09xFyC+XZadhDRQXOLr6jBDKWPVtQ
TrXTrRrZV4FEfo1FJj0joEVbMnnMK47bOtPewgeODdd4Mz+NXM55DcnkDENqrmVF
FMILpxChkAgx+3K3DnVcRL6r9rqXnh0rMu8kYTtBgKoEsK5c+mRw8zCUbT7SBlSr
yWVwGVBgR1GqXezL3Xcn6fD5HdqvN/heaqVBoAzBOuhWYGW+kg3+X3r5NADRlEMX
BUJn8PDi46migFKYvHSIbGqJvZTt8g==
=LR93
-----END PGP SIGNATURE-----

--GJxKokgzwqP1e9kn0SJy4OnMhEW59lnaA--

