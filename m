Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60226C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393442173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393442173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3U9-0005fv-H8
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:03:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hT3SP-0004mt-92
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hT3SK-00072c-AF
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hT3SI-0006zA-PJ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DC4A85A03;
	Tue, 21 May 2019 12:01:06 +0000 (UTC)
Received: from [10.3.116.56] (ovpn-116-56.phx2.redhat.com [10.3.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 03BB55E7DE;
	Tue, 21 May 2019 12:00:13 +0000 (UTC)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190521081227.30799-1-richardw.yang@linux.intel.com>
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
Message-ID: <c184d4f7-686b-d54a-f969-a05ab965028a@redhat.com>
Date: Tue, 21 May 2019 07:00:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521081227.30799-1-richardw.yang@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="31vSkqcqpZQbvqNP0pwJ6RRhV9wVD1wz4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 21 May 2019 12:01:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] Makefile: simplify qapi-py definition with
 wildcard
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
Cc: alex.bennee@linaro.org, berrange@redhat.com, philmd@redhat.com,
	kraxel@redhat.com, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--31vSkqcqpZQbvqNP0pwJ6RRhV9wVD1wz4
From: Eric Blake <eblake@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, berrange@redhat.com, kraxel@redhat.com,
 alex.bennee@linaro.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <c184d4f7-686b-d54a-f969-a05ab965028a@redhat.com>
Subject: Re: [PATCH] Makefile: simplify qapi-py definition with wildcard
References: <20190521081227.30799-1-richardw.yang@linux.intel.com>
In-Reply-To: <20190521081227.30799-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/21/19 3:12 AM, Wei Yang wrote:
> All the python script in scripts/qapi is used to generate qapi code. Us=
e
> wildcard to simplify it.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  Makefile | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

I'm not a fan of $(wildcard). It makes your tarball creation
non-deterministic - if there is a leftover file from development that is
no longer part of the build, wildcard will still pick it up.  Explicit
lists are better.  I'm inclined to NACK this, but Markus has final say
since he maintains the qapi generator.

>=20
> diff --git a/Makefile b/Makefile
> index 155f066a20..38b74782d9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -541,13 +541,7 @@ qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-gen=
erated
>  qemu-keymap$(EXESUF): LIBS +=3D $(XKBCOMMON_LIBS)
>  qemu-keymap$(EXESUF): QEMU_CFLAGS +=3D $(XKBCOMMON_CFLAGS)
> =20
> -qapi-py =3D $(SRC_PATH)/scripts/qapi/commands.py \
> -$(SRC_PATH)/scripts/qapi/events.py \
> -$(SRC_PATH)/scripts/qapi/introspect.py \
> -$(SRC_PATH)/scripts/qapi/types.py \
> -$(SRC_PATH)/scripts/qapi/visit.py \
> -$(SRC_PATH)/scripts/qapi/common.py \
> -$(SRC_PATH)/scripts/qapi/doc.py \
> +qapi-py =3D $(wildcard $(SRC_PATH)/scripts/qapi/*.py) \
>  $(SRC_PATH)/scripts/qapi-gen.py
> =20
>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.=
h \
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--31vSkqcqpZQbvqNP0pwJ6RRhV9wVD1wz4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzj6EwACgkQp6FrSiUn
Q2rlHAf+KxesHnNK2z+Rny/B0dWhqcBF12LlqDUjmtP7eQE43pTC4+U8c8C6coj6
WFz8NtZ88yfbn2dzfat26jkr3d1y4a/aG/CSOZdh8Rls5zo4To5ipHIfsDF2bZ6B
bZal7OgcNWqaS7HnKWdRN1Fe/9hP+7IYQJ4LggzjXpmvo2qX96dR9/cIjJMNIpP/
DaJ3in2jtG+7fvMbYkUQtMUgg7FbBP7yNMZsJL8GfzrzOIwVlstbj8BNg/xEiYTk
8kg5ObxW6Z2iesExae5FtYtfEa1qPtBKu4c2Te2Pv1eXfyNO7MClHy7NS+LQNI1B
KYqoXyhaEz2Dp9+VGAZiZuVDNO71TA==
=alBY
-----END PGP SIGNATURE-----

--31vSkqcqpZQbvqNP0pwJ6RRhV9wVD1wz4--

