Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEF9C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FE3208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FE3208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55831 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6xM-0006wY-Oy
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:45:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hT6wZ-0006Y8-KX
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hT6wY-0006wt-MF
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hT6wY-0006ZA-Dq
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:44:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 089D13082E91
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 15:44:16 +0000 (UTC)
Received: from [10.3.116.56] (ovpn-116-56.phx2.redhat.com [10.3.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 707E117F50;
	Tue, 21 May 2019 15:44:15 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190521153835.23233-1-berrange@redhat.com>
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
Message-ID: <66cec3d4-a47b-19eb-72f2-3f1b7f7d5764@redhat.com>
Date: Tue, 21 May 2019 10:44:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521153835.23233-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nvZvue6X1IU6JADnIHbKVaUslFq36xFOn"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 21 May 2019 15:44:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] qapi: report the default CPU type for each
 machine
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nvZvue6X1IU6JADnIHbKVaUslFq36xFOn
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Message-ID: <66cec3d4-a47b-19eb-72f2-3f1b7f7d5764@redhat.com>
Subject: Re: [PATCH] qapi: report the default CPU type for each machine
References: <20190521153835.23233-1-berrange@redhat.com>
In-Reply-To: <20190521153835.23233-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/21/19 10:38 AM, Daniel P. Berrang=C3=A9 wrote:
> When user doesn't request any explicit CPU model with libvirt or QEMU,
> a machine type specific CPU model is picked. Currently there is no way
> to determine what this QEMU built-in default is, so libvirt cannot
> report this back to the user in the XML config.
>=20
> This extends the "query-machines" QMP command so that it reports the
> default CPU model typename for each machine.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/misc.json | 6 +++++-
>  vl.c           | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..0bb7995bd4 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2018,12 +2018,16 @@
>  #
>  # @hotpluggable-cpus: cpu hotplug via -device is supported (since 2.7.=
0)
>  #
> +# @default-cpu-type: default CPU model typename if none is requested v=
ia
> +#                    the -cpu argument. (since 4.2.0)

4.1 is sufficient (unless you think this is so controversial as to miss
the current release cycle).

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nvZvue6X1IU6JADnIHbKVaUslFq36xFOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzkHM4ACgkQp6FrSiUn
Q2onMAgAmd5zWTfCuepgQiQK1PFvRxA7leiaCzB2uazh+f8ZceMeBnpx8wCuLG9J
/O4Ipt+0zSG3FqfXX+Af8/3ScCpPs2qCIJjRU0qy/Qr7VgQymeHo2mRfWuOuRSjh
5xjgevJn/fo/16JZTef+azEjZoaeZkl0DzfMGVqlS8w5LxRnC95RyNUiOq8mHRkw
02Pm2bdhUywb4lIlSRn20X4JamwBCNDOB8KsL3me8FKTdxO2Nesb2mlDROsOL6qU
UxkJeiPK5132CWhD+lokM6KCvdVYN4tUUqfZARMh1RoxCJl57Gh/VEAxJkHVfRqA
Yjq5g6MdVFRuLxI+iJk1rNzru6Dykg==
=LZFk
-----END PGP SIGNATURE-----

--nvZvue6X1IU6JADnIHbKVaUslFq36xFOn--

