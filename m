Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D808C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE1520674
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE1520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGmhH-0006T6-MM
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 11:42:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGmfh-0005P9-56
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGmfe-0008JP-7m
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:40:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGmfW-00088v-F4; Wed, 17 Apr 2019 11:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C7613199392;
	Wed, 17 Apr 2019 15:40:02 +0000 (UTC)
Received: from [10.3.116.103] (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D01B5D9D6;
	Wed, 17 Apr 2019 15:39:59 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190417153005.30096-1-mreitz@redhat.com>
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
Message-ID: <5897a475-e056-a0d6-f979-5cea490451d1@redhat.com>
Date: Wed, 17 Apr 2019 10:39:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417153005.30096-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UD44ldDwPNCTgR0vWmaNzV1JDeP8REgSh"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 17 Apr 2019 15:40:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 182 do without device_add
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417153957.PtAl4d8n0DIMHfYXth_tZyChmHeTHzKvlLzLYCCuYlQ@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UD44ldDwPNCTgR0vWmaNzV1JDeP8REgSh
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Message-ID: <5897a475-e056-a0d6-f979-5cea490451d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 182 do without device_add
References: <20190417153005.30096-1-mreitz@redhat.com>
In-Reply-To: <20190417153005.30096-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 10:30 AM, Max Reitz wrote:
> 182 fails if qemu has no support for hotplugging of a virtio-blk device=
=2E
> Using an NBD server instead works just as well for the test, even on
> qemus without hotplugging support.
>=20
> Fixes: 6d0a4a0fb5c8f10c8eb68b52cfda0082b00ae963
> Reported-by: Danilo C. L. de Paula <ddepaula@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> To reintroduce the bug for which this test was written, revert the
> following commits:
>=20
> $ git revert -n \
>     23dece19da41724349809873923e20a48b619cb7 \
>     6ceabe6f77e4ae5ac2fa3d2ac1be11dc95021941 \
>     a6aeca0ca530f104b5a5dd6704fca22b2c5edefa \
>     577a133988c76e4ebf01d050d0d758d207a1baf7

Useful instructions; with them, I was able to:

Tested-by: Eric Blake <eblake@redhat.com>

> ---
>  tests/qemu-iotests/182     | 22 +++++++++++++++++-----
>  tests/qemu-iotests/182.out |  1 +
>  2 files changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Do you want me to take this through my NBD tree, since it now depends on
NBD? I'm also fine letting it go through your iotests tree

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--UD44ldDwPNCTgR0vWmaNzV1JDeP8REgSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3SM0ACgkQp6FrSiUn
Q2pPsQgAmFlgPNHkSyLJZXYzjaKmTV9etpHIo1YprNYzXi8RCCnNowveZnZ/qVVn
6DzCGeYU7O70btDPHR848EhCpfayQVmRH1ooQNeTi4u2PUxv2kYO8ki7b8i/VPEA
wyz4g9uMXxzvZPDZgFJ1zkW9NRjJgQVXbzX0yM1aOMLdSBGFqGWyx6JK3KwlqNiC
b99CSobUj8or/Ikvj/4aj8hZFK/AjgAtnhDe2BDoGDOAHJlTvfQOzqAwfxxwgIf9
6hZ6EAbMJjn8ucs8saY6fGjffoUFDX1l3Dxn9tkw3FW+bqfcCHMtl6EeqPQBiC+/
RMYWKqYSSxK07hQD0d6NZLTq3KQQIg==
=QzvC
-----END PGP SIGNATURE-----

--UD44ldDwPNCTgR0vWmaNzV1JDeP8REgSh--

