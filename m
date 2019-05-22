Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4112FC072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E87217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E87217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTFNt-0003zy-C1
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:45:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTFMx-0003QR-Sp
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTFI7-0007Ng-1H
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hTFI5-0007MT-KM; Tue, 21 May 2019 20:39:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DA2085539;
	Wed, 22 May 2019 00:39:32 +0000 (UTC)
Received: from [10.3.116.56] (ovpn-116-56.phx2.redhat.com [10.3.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DEC117C5B;
	Wed, 22 May 2019 00:39:27 +0000 (UTC)
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-2-mehta.aaru20@gmail.com>
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
Message-ID: <d932237b-03bc-5dbb-17dd-bcca5ce121c8@redhat.com>
Date: Tue, 21 May 2019 19:39:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521235215.31341-2-mehta.aaru20@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mnUkawKqWGg89jCHMWYBAISTAdHksFtqY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 22 May 2019 00:39:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RFC PATCH 1/9] qapi/block-core: add option for
 io_uring
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mnUkawKqWGg89jCHMWYBAISTAdHksFtqY
From: Eric Blake <eblake@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <d932237b-03bc-5dbb-17dd-bcca5ce121c8@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/9] qapi/block-core: add option for
 io_uring
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
 <20190521235215.31341-2-mehta.aaru20@gmail.com>
In-Reply-To: <20190521235215.31341-2-mehta.aaru20@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/21/19 6:52 PM, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>

Sparse on the details. The subject line says what, but without a 'why'
for how io_uring is different from existing aio options, it's hard to
see why I'd want to use it. Do you have any benchmark numbers?

> ---
>  qapi/block-core.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..116995810a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2776,11 +2776,12 @@
>  #
>  # @threads:     Use qemu's thread pool
>  # @native:      Use native AIO backend (only Linux and Windows)
> +# @io_uring:    Use linux io_uring

Missing a '(since 4.1)' tag.

>  #
>  # Since: 2.9
>  ##
>  { 'enum': 'BlockdevAioOptions',
> -  'data': [ 'threads', 'native' ] }
> +  'data': [ 'threads', 'native','io_uring' ] }

Missing space after ',' (not essential, but matching style is nice).
Should the new element be defined conditionally, so that introspection
only sees the new enum member when compiled for Linux?



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mnUkawKqWGg89jCHMWYBAISTAdHksFtqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzkmj8ACgkQp6FrSiUn
Q2oFlwf+JGTroDF71aFEYd+SANO3w4DxWMlqjAcVcVClSKJQdUJxBiHQA15FUDdB
W5FNiaNBecsjiN7DqB+Wk/pSkcVAdgBlDJpm7XETymCVzhSA3EUn/+WBH0VgsRMN
MRU7SXinFnYNB3qblYILGzkgZMxSwI+KZSiM5x3lDg2lhsPZpai/VWtkaH7UZ1Qt
DNZt2gI4/R/urAiwi9YogTsO42pNGaxdR1NmtKnkW5cnxbYQMWLy25zMcNS6lqe+
DhCZCw/BzVbg+kMsTdx8QmcLelsz+UK8Dd+CmKWli5N0haXSHMdotG+n5+32woXX
i/l2bR4z/CzwZ3+QA9lkNumA2VMlqA==
=M1Fo
-----END PGP SIGNATURE-----

--mnUkawKqWGg89jCHMWYBAISTAdHksFtqY--

