Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2B5C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D06214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D06214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hznZz-0004ml-To
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hznZ8-00041v-6y
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hznZ7-0001Sb-9c
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:43:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hznZ2-0001Kz-Dw; Mon, 19 Aug 2019 15:43:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE8C3C08E2B8;
 Mon, 19 Aug 2019 19:43:31 +0000 (UTC)
Received: from [10.3.117.3] (ovpn-117-3.phx2.redhat.com [10.3.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3152C5DC1B;
 Mon, 19 Aug 2019 19:43:31 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-13-mreitz@redhat.com>
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
Message-ID: <272cbeba-2053-9aa6-7ceb-e1b3827de540@redhat.com>
Date: Mon, 19 Aug 2019 14:43:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819185602.4267-13-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FFzN3Rm2uOWZOI1opAQxxiFurDhY92GPd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 19 Aug 2019 19:43:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/16] qcow2: Fix overly long snapshot
 tables
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FFzN3Rm2uOWZOI1opAQxxiFurDhY92GPd
Content-Type: multipart/mixed; boundary="wG891ny1Gc90OmVik4zfeCEEZNAvhBxgj";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <272cbeba-2053-9aa6-7ceb-e1b3827de540@redhat.com>
Subject: Re: [PATCH v2 12/16] qcow2: Fix overly long snapshot tables
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-13-mreitz@redhat.com>
In-Reply-To: <20190819185602.4267-13-mreitz@redhat.com>

--wG891ny1Gc90OmVik4zfeCEEZNAvhBxgj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/19/19 1:55 PM, Max Reitz wrote:
> We currently refuse to open qcow2 images with overly long snapshot
> tables.  This patch makes qemu-img check -r all drop all offending
> entries past what we deem acceptable.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-snapshot.c | 88 +++++++++++++++++++++++++++++++++++++-----=

>  1 file changed, 78 insertions(+), 10 deletions(-)

I know I was reluctant in v1, but you also managed to convince me that
it really takes a LOT of effort to get a table with that many entries.
And a user has to opt-in to 'qemu-img -r' (it may discard a snapshot
they value, but that beats not being able to use the image under qemu at
all, and we don't erase it for plain 'qemu-img check').  So I'm okay
with this going in.  Maybe the commit message can state this sort of
reasoning.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--wG891ny1Gc90OmVik4zfeCEEZNAvhBxgj--

--FFzN3Rm2uOWZOI1opAQxxiFurDhY92GPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1a++IACgkQp6FrSiUn
Q2q+/QgAnF0rC8yrYNxsFppSZGsEaa+5q59/Y9DcBOXegtjkXD5iUJhzGsVuQ5dt
101z46HARFqHJsCzEpHU7+bOwbJcPUShPLHavJNFqvY8LNK079NORstnw+cjm96v
8GgynkTCkL0Keb4YDy8yVtGDMjX011i97nWpkw6+R/RhM2lKPCIlAhi0WT4PhYVL
dc2pPPNigibJquCLbJn1a0JmqmQwQr48GLdUp++RRD0ChXzPQv2AdWGs6v9P4veV
oEMHeQrPwYRqHDJd4gE9t5kDXuOVsz4H3WLLaKJAYrKsz/yGQdxfMqk2iy/x9ea4
J3+VxE0k5cpLjWPmuapBZzUqsNeIkA==
=UgdB
-----END PGP SIGNATURE-----

--FFzN3Rm2uOWZOI1opAQxxiFurDhY92GPd--

