Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED80EC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CAD2173C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CAD2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTW09-0002rv-Mp
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 14:30:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTVzN-0002Bi-6p
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTVzM-0008Ro-3C
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hTVuT-0005XC-6i; Wed, 22 May 2019 14:24:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C23B306C9F2;
	Wed, 22 May 2019 18:24:14 +0000 (UTC)
Received: from [10.3.116.207] (ovpn-116-207.phx2.redhat.com [10.3.116.207])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C412D60240;
	Wed, 22 May 2019 18:24:13 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190522170352.12020-1-mreitz@redhat.com>
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
Message-ID: <6c13016d-9951-775c-9c54-62e0dd676ca2@redhat.com>
Date: Wed, 22 May 2019 13:24:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qIifbQaEuGd0pPsSAUHx41Y0Q7hs020wh"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 22 May 2019 18:24:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qIifbQaEuGd0pPsSAUHx41Y0Q7hs020wh
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <6c13016d-9951-775c-9c54-62e0dd676ca2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
References: <20190522170352.12020-1-mreitz@redhat.com>
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/22/19 12:03 PM, Max Reitz wrote:
> Hi,
>=20
> This series is mainly a fix for
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1703793.  The problem
> described there is that mirroring to a gluster volume, then switching
> off the volume makes qemu crash.  There are two problems here:
>=20
> (1) file-posix reopens the FD all the time because it thinks the FD it
>     has is RDONLY.  It actually isn=E2=80=99t after the first reopen, w=
e just
>     forgot to change the internal flags.  That=E2=80=99s what patch 1 i=
s for.
>=20
> (2) Even then, when mirror completes, it drops its write permission on
>     the FD.  This requires a reopen, which will fail if the volume is
>     down.  Mirror doesn=E2=80=99t expect that.  Nobody ever expects tha=
t
>     dropping permissions can fail, and rightfully so because that=E2=80=
=99s what
>     I think we have generally agreed on.
>     Therefore, the block layer should hide this error.  This is what th=
e
>     last two patches are for.
>=20
> The penultimate patch adds two assertions: bdrv_replace_child() (for th=
e
> old BDS) and bdrv_inactivate_recurse() assume they only ever drop
> assertions.  This is now substantiated by these new assertions.
> It turns out that this assumption was just plain wrong.  Patches 3 to 5=

> make it right.
>=20
>=20
> v3:
> - Received no reply to my =E2=80=9CHm, warnings break 'make check', so =
maybe we
>   should just keep quiet if loosening restrictions fails?=E2=80=9D ques=
tion, so
>   I assume silence means agreement.  Changed patch 7 accordingly.
>=20

I don't know if there is an easy way to warn for normal users, but
silence the warnings if run under test setups to keep 'make check'
output unchanged (I know we've silenced warnings in the past when we
detect we are running qtest, but this isn't necessarily the same setup).
 So not a show-stopper for me.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--qIifbQaEuGd0pPsSAUHx41Y0Q7hs020wh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzlk8wACgkQp6FrSiUn
Q2pyeAf6A7mq+crJ6MCREsDqg/XAbwSvUoLa873UwRnz0aVl5863zy0AepydIWZB
04sLFAnKyJdEh0tZOTjCjdjj0zpczMs5LLOZv40Loz49hiF+p/5rWEBAwR5P9gzt
XDmf4XGAkPWG6DYQjvk4cCMn1yy96EL69/4rVWG4s1fB46DZCOY5XR4fbJG8fhzB
+YK9pHGlGV1Q/A8fEH4pV0W0vF1Yqpa1LUxCgG61cyNTHmXVP91/4G+Y9pvomi/4
OxcTu08lu7C8Jlt+ajJSkRMiQ4yLpH/SV1ejcicUvsnJztBoQ/nmyzIGe/Kq4Lbn
+G98bYZMSqzjEYAzNNwQldXjTZwqNA==
=1dJn
-----END PGP SIGNATURE-----

--qIifbQaEuGd0pPsSAUHx41Y0Q7hs020wh--

