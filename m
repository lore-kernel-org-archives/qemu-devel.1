Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C37C04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBBE2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBBE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58021 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfI0-0003vU-BK
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:12:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNfGn-0003KM-FU
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNfGm-0005Ju-IL
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hNfGm-0005JJ-8w
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:11:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81D1580E7A;
	Mon,  6 May 2019 15:11:07 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E86DEB04A1;
	Mon,  6 May 2019 15:11:05 +0000 (UTC)
To: Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-devel@nongnu.org
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-9-S.E.Harris@kent.ac.uk>
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
Message-ID: <9697659b-7523-2712-25a9-7c7c1eaad32b@redhat.com>
Date: Mon, 6 May 2019 10:11:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504083638.13380-9-S.E.Harris@kent.ac.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Yqj5cajlhZITJLfYeEldkBhMI1Q7wMdv9"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 06 May 2019 15:11:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: A.M.King@kent.ac.uk, mrolnik@gmail.com, E.J.C.Robbins@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yqj5cajlhZITJLfYeEldkBhMI1Q7wMdv9
From: Eric Blake <eblake@redhat.com>
To: Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, A.M.King@kent.ac.uk, E.J.C.Robbins@kent.ac.uk
Message-ID: <9697659b-7523-2712-25a9-7c7c1eaad32b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support with
 the rest of QEMU, the build system, and the MAINTAINERS file
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
 <20190504083638.13380-9-S.E.Harris@kent.ac.uk>
In-Reply-To: <20190504083638.13380-9-S.E.Harris@kent.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/4/19 3:36 AM, Sarah Harris wrote:
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> ---

> +++ b/qapi/common.json
> @@ -187,7 +187,7 @@
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32'=
,
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',=
 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',

Missing documentation that the new 'avr' member is available only since 4=
=2E1.

> diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
> new file mode 100644
> index 0000000000..41355dea1e
> --- /dev/null
> +++ b/target/avr/Makefile.objs
> @@ -0,0 +1,23 @@
> +#
> +#  QEMU AVR CPU
> +#
> +#  Copyright (c) 2016 Michael Rolnik

Do you want to also claim through 2019?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Yqj5cajlhZITJLfYeEldkBhMI1Q7wMdv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzQTokACgkQp6FrSiUn
Q2pSAAgAre4eitFIiZUKCmXeGmCXSh/BzjutVwjUsAVJu3a8/Sw5+n7n9jAB3eRZ
Rethax3RBi9lW9BhZjWQ/ZZQS1xJFObbUb+7G+bUGondSAIrAkNYgHzzD8PZ2JzB
thW10fre1UZaLiZS2ZcgLtpis4pEgqpd0Ks08ncADaSApiIvTGYI6arEPGJWKWhx
dexzM7yIDEJHMwnz+unC2ppXMyXRWsABHUXvXap7unPS4ocYpCxSzw9u4AQNDCbl
Uww0qobPCotRNmdU/oiODxRGlT8sDwp+AbOI8G/almSoL9ZsICIpRSJTdPBwEelH
pen6c05fzZ1Vh3B6MTGFKb+f02tihg==
=aZzN
-----END PGP SIGNATURE-----

--Yqj5cajlhZITJLfYeEldkBhMI1Q7wMdv9--

