Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98584C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB5F218FC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB5F218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJGA-0002kF-D2
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:52:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hJIzQ-00053B-Uq
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hJIl4-0001in-UQ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hJIfT-0004A8-7A; Wed, 24 Apr 2019 10:14:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66C04883C2;
	Wed, 24 Apr 2019 14:14:34 +0000 (UTC)
Received: from [10.3.116.149] (ovpn-116-149.phx2.redhat.com [10.3.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B9FDE60C81;
	Wed, 24 Apr 2019 14:14:30 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-4-thuth@redhat.com>
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
Message-ID: <167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
Date: Wed, 24 Apr 2019 09:14:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424103747.10173-4-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gihy7ScO5bQVPVVZmlxviIEpVeYcfDTsn"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 24 Apr 2019 14:14:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code
 the path to bash
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424141429.CGunx06XGbA9cDDlCA2ixtLm4gh8lW2LtN4osm-NOzw@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gihy7ScO5bQVPVVZmlxviIEpVeYcfDTsn
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Message-ID: <167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code the
 path to bash
References: <20190424103747.10173-1-thuth@redhat.com>
 <20190424103747.10173-4-thuth@redhat.com>
In-Reply-To: <20190424103747.10173-4-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/24/19 5:37 AM, Thomas Huth wrote:
> bash is installed in a different directory on non-Linux systems like
> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
> there, too.

These tests were obviously copy-and-pasted from a fork point prior to
commit 11a82d14.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/239 | 2 +-
>  tests/qemu-iotests/240 | 2 +-
>  tests/qemu-iotests/241 | 2 +-
>  tests/qemu-iotests/243 | 2 +-
>  tests/qemu-iotests/244 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--gihy7ScO5bQVPVVZmlxviIEpVeYcfDTsn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzAb0UACgkQp6FrSiUn
Q2pSpggAn0Vi5CAUsUPfx4aPFC1TACLvJBiPKzD38UtY9PYx4vx6/ahUXBSdeB2P
nApO9+iHFT1z+gjkXnBTnUCbNjO7KLzvDvX9KnLN0+f8YW0iPm8n7mUQN7uOhBnR
R0VkmdWN0Cw4UQ/gVLp+OOV50nVPOpcqApOisSI47fThJxytzXx7TyCSumqKurxi
+bSFD00bHo/N5c0TWZyFdbe/CGS7M/mM77Ww1N+JipJQ+tr/y+D2pybphG5/flAp
xlULDH2FByZOt5APqeG9/VKSUsjx9mLkMFNNkZoIbFfbhHC0RhvUWJm6XQb6+RpZ
Q5cWZPKfQroXALmQJPrEFhW5HS78lg==
=AmWS
-----END PGP SIGNATURE-----

--gihy7ScO5bQVPVVZmlxviIEpVeYcfDTsn--

