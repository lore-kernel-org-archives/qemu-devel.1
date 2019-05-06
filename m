Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F191C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248C320830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248C320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59813 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhRP-0006v8-CD
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:30:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNhLU-00023l-Kv
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNhLQ-0001uk-Bo
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hNhLN-0001cZ-PC
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2EEE309B14D;
	Mon,  6 May 2019 17:23:56 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B5CFC5C1B5;
	Mon,  6 May 2019 17:23:55 +0000 (UTC)
To: Antonio Ospite <ao2@ao2.it>, qemu-devel@nongnu.org
References: <20190503082728.16485-1-ao2@ao2.it>
	<20190503082728.16485-2-ao2@ao2.it>
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
Message-ID: <6822ade4-2859-6d2a-d778-7fc115af5081@redhat.com>
Date: Mon, 6 May 2019 12:23:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503082728.16485-2-ao2@ao2.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lA7UKGnyznKjIVMegEYCk5MViPF3I1xfy"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 06 May 2019 17:23:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 1/2] configure: set source_path only
 once and make its definition more robust
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
--lA7UKGnyznKjIVMegEYCk5MViPF3I1xfy
From: Eric Blake <eblake@redhat.com>
To: Antonio Ospite <ao2@ao2.it>, qemu-devel@nongnu.org
Cc: Antonio Ospite <antonio.ospite@collabora.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <6822ade4-2859-6d2a-d778-7fc115af5081@redhat.com>
Subject: Re: [PATCH v2 1/2] configure: set source_path only once and make its
 definition more robust
References: <20190503082728.16485-1-ao2@ao2.it>
 <20190503082728.16485-2-ao2@ao2.it>
In-Reply-To: <20190503082728.16485-2-ao2@ao2.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/3/19 3:27 AM, Antonio Ospite wrote:
> From: Antonio Ospite <antonio.ospite@collabora.com>
>=20
> Since commit 79d77bcd36 (configure: Remove --source-path option,
> 2019-04-29) source_path cannot be overridden anymore, move it out of th=
e
> "default parameters" block since the word "default" may suggest that th=
e
> value can change, while in fact it does not.
>=20
> While at it, only set source_path once and separate the positional
> argument of basename with "--" to more robustly cover the case of path
> names starting with a dash.
>=20
> Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
> ---
>  configure | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lA7UKGnyznKjIVMegEYCk5MViPF3I1xfy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzQbakACgkQp6FrSiUn
Q2q53ggAlb6Alj+piZ7r1nBHL3SPkdlWa+QpCgrm7RJ29TScWWxonpSqGkMzPyty
WaZFHzdEkurAN19QlONLoysyJewCGOhG1Cok1uCRj5m3UbrjFDW9sp75Vt43A6c2
q59C1FVWJudQZ1CYW3jydKVpvrjAOCYlpuoDJS5pXgibmfxn1MBrxGVDj8ag7WUn
LBgfZXI1oixyQqUBbMfn8bLTotE3yoBXjC358xSSwv4/O3YNTtUpOZyr/Mw0uMkB
5SSfe2div8aq4aDs1L9P9NW24CbPb7OGdDDl98B2GTa8xAPimYF7IS+YbaT651LN
80Tb5Y3p5A2SJe0qbw2LS2GOxcyMaA==
=7f6T
-----END PGP SIGNATURE-----

--lA7UKGnyznKjIVMegEYCk5MViPF3I1xfy--

