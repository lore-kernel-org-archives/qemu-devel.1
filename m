Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC318C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 02:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA2A2077B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 02:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA2A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKZqF-0002j7-PX
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 22:46:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hKZof-0001ad-C8
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 22:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hKZga-0000aY-Gr
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 22:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hKZgZ-0000Zr-81; Sat, 27 Apr 2019 22:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCC5281F33;
	Sun, 28 Apr 2019 02:36:56 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 77FE15D717;
	Sun, 28 Apr 2019 02:36:55 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
	<20190426105301.GA20769@localhost.localdomain>
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
Message-ID: <eca8f98a-6f39-837a-6d55-606d881c44ed@redhat.com>
Date: Sat, 27 Apr 2019 21:36:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426105301.GA20769@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fFn5zBvpKTXX1sH1VD7iw60JrU5yvgXZk"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Sun, 28 Apr 2019 02:36:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Failing qemu-iotest 005 with raw
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
Cc: Max Reitz <mreitz@redhat.com>, hch@lst.de,
	Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428023654.aPaNFVdC8m1iFbj_eeN2SXALk_nr_hCH9ZCFMZPlLqM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fFn5zBvpKTXX1sH1VD7iw60JrU5yvgXZk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: hch@lst.de, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Message-ID: <eca8f98a-6f39-837a-6d55-606d881c44ed@redhat.com>
Subject: Re: [Qemu-devel] Failing qemu-iotest 005 with raw
References: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
 <20190426105301.GA20769@localhost.localdomain>
In-Reply-To: <20190426105301.GA20769@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/26/19 5:53 AM, Kevin Wolf wrote:

>>  creating large image
>> +qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file
>> format 'IMGFMT'
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D5368709120000
>> [...]
>>
>> Could this be fixed somehow, or should the test rather be skipped for
>> IMGFMT=3Draw?
>=20
> The test passes for me on XFS. Looks like the raw driver can handle
> large image files, but your host filesystem can't.
>=20
> We would have to check whether the host filesystem can support large
> files and skip the test if it can't. I'm not sure how to do that. But
> actually, this isn't testing anything interesting for raw, so just
> unconditionally disabling the test for raw could be reasonable enough.

iotest 220 in commit 3b94c343 can serve as such an example (it skips the
test on at least ext4, while passing on tmpfs which allows larger sparse
files).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--fFn5zBvpKTXX1sH1VD7iw60JrU5yvgXZk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzFEcYACgkQp6FrSiUn
Q2rDRQf9FOPXF+jJARGgTgg0qI/7J69K+C4b8i0gzFWVkSyFUt/IhckK+uKxtH6/
XKl4uRHxRHJXgBtrkUvwJkxFPdv+dAUmi0lUrZjyQzKxuLh4GTnuHrrXy9nqhmTU
13qDX7RgSAR654uIbSDCRtHnk8EEPeIt5qyC8Yf1KfBAI/vc/KCnEYxKBPPb+7/b
IaqkXYZv3miruA33l0XJborI4tKBjb4e3L6GnNyi4+MxL3O+OjPJp+kOr18sZtlN
x7P8rqUMeK0L4H0GxstMeygp8doulIP7O8jFxMXeoitSFhllRpz32rLBzwOh9U7S
/t7fv2ZlUSEX+i5MGEICm9VBF1SP4g==
=E/SY
-----END PGP SIGNATURE-----

--fFn5zBvpKTXX1sH1VD7iw60JrU5yvgXZk--

