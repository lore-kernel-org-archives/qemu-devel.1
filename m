Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751F4C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494A420818
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494A420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEFEd-0005sY-Hx
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:33:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEFDf-0005Wj-7K
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEFDe-0007hV-5B
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:32:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hEFDb-0007ez-Qk; Wed, 10 Apr 2019 11:32:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D8097F6A8;
	Wed, 10 Apr 2019 15:32:49 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B8D3017CEF;
	Wed, 10 Apr 2019 15:32:48 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20190410152429.8076-1-berto@igalia.com>
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
Message-ID: <bc400e47-0140-1983-9a1b-16eb1f30fdb3@redhat.com>
Date: Wed, 10 Apr 2019 10:32:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410152429.8076-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SSfFH4GuxXhoBL1jyp2RhZk14GPbZhGxk"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 10 Apr 2019 15:32:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1] commit: Make base read-only if
 there is an early failure
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410153247.FgN_jT7bwixKu25MR0xzq5Jq_YGHRzT2pEuf7KYO1i4@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SSfFH4GuxXhoBL1jyp2RhZk14GPbZhGxk
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <bc400e47-0140-1983-9a1b-16eb1f30fdb3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] commit: Make base read-only if there
 is an early failure
References: <20190410152429.8076-1-berto@igalia.com>
In-Reply-To: <20190410152429.8076-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 10:24 AM, Alberto Garcia wrote:
> You can reproduce this by passing an invalid filter-node-name (like
> "1234") to block-commit. In this case the base image is put in
> read-write mode but is never reset back to read-only.
>=20

Is it worth iotest coverage?

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/block/commit.c b/block/commit.c
> index ba60fef58a..698eda1dfe 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -384,6 +384,9 @@ fail:
>      if (s->top) {
>          blk_unref(s->top);
>      }
> +    if (s->base_read_only) {
> +        bdrv_reopen_set_read_only(base, true, NULL);
> +    }
>      job_early_fail(&s->common.job);
>      /* commit_top_bs has to be replaced after deleting the block job,
>       * otherwise this would fail because of lack of permissions. */
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--SSfFH4GuxXhoBL1jyp2RhZk14GPbZhGxk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuDJ8ACgkQp6FrSiUn
Q2om6Af+JXBOhMwwGuFpb2hnTImvIhSc5xvm0LU2yQa3sfaVOvIwueqq3bzMMFYU
kxxfBQ2SQYEnWFpVqB0eOPQamzmT8vXGBOvACvxXYDtffPAswhoqKGYZOetZWadE
MRIYM018C9J0OcZ38DKNUzV/2hlBClGSL+fCDwvC6C2gf7AeSwZv5xk2uX0kIv5Z
ZoWXkIs/oyoAjNGqOiRwrqMQ2W2iLbRCRbJgBoec4i2odqw093PgRgYwfqmzuCZr
qcIWPKiWgKafVI+GgYhrr7GH7BS0vr9wYRVVMWeIf+bbhQyhk5JSreO8M0zoKzMU
Bkc5mCL3DZMwF0bsDo3N9sTpBJOTzw==
=4eFA
-----END PGP SIGNATURE-----

--SSfFH4GuxXhoBL1jyp2RhZk14GPbZhGxk--

