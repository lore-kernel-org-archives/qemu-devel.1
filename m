Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D6C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 20:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF132075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 20:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF132075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMekJ-0000bv-EE
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 16:25:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMejF-0008Sh-UE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMejE-0006jl-R4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hMejE-0006jC-Hy
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC2F7309175E;
	Fri,  3 May 2019 20:24:19 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E0D5C231;
	Fri,  3 May 2019 20:24:12 +0000 (UTC)
To: Ernest Esene <eroken1@gmail.com>, qemu-devel@nongnu.org
References: <20190503193141.GA17700@erokenlabserver>
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
Message-ID: <7f3b0a70-cec4-f267-c1fa-0bed6851b8cf@redhat.com>
Date: Fri, 3 May 2019 15:24:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503193141.GA17700@erokenlabserver>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4jyUahZ2QlZqfdy7UQNKii21mIGjnj14T"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 03 May 2019 20:24:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] chardev/char-i2c: Implement Linux I2C
 character device
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503202406.3Jl0NPAg5JtgaE6Fa8A2gqoK1jJ_dVcGojQhKNMWFmw@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4jyUahZ2QlZqfdy7UQNKii21mIGjnj14T
From: Eric Blake <eblake@redhat.com>
To: Ernest Esene <eroken1@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <7f3b0a70-cec4-f267-c1fa-0bed6851b8cf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] chardev/char-i2c: Implement Linux I2C
 character device
References: <20190503193141.GA17700@erokenlabserver>
In-Reply-To: <20190503193141.GA17700@erokenlabserver>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 5/3/19 2:31 PM, Ernest Esene wrote:
> Add support for Linux I2C character device for I2C device passthrough
> For example:
> -chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
>=20
> Signed-off-by: Ernest Esene <eroken1@gmail.com>
> ---

Just an interface review:

> +++ b/qapi/char.json
> @@ -240,6 +240,21 @@
>    'data': { 'device': 'str' },
>    'base': 'ChardevCommon' }
> =20
> +##
> +# @ChardevI2c:
> +#
> +# Configuration info for i2c chardev (only on linux).

Rather than a parenthetical comment, you could use:

> +#
> +# @device: The name of the special file for the device,
> +#          i.e. /dev/i2c-0 on linux
> +# @address: The address of the i2c device on the host.
> +#
> +##

Missing a 'Since: 4.1' line.

> +{ 'struct': 'ChardevI2c',
> +  'data': { 'device': 'str',
> +            'address': 'int16'},
> +  'base': 'ChardevCommon'}

'if': 'defined(CONFIG_LINUX)'

as part of the usage of this struct, so that introspection will only see
the struct where it can be used.

> +
>  ##
>  # @ChardevSocket:
>  #
> @@ -398,6 +413,7 @@
>    'data': { 'file': 'ChardevFile',
>              'serial': 'ChardevHostdev',
>              'parallel': 'ChardevHostdev',
> +            'i2c': 'ChardevI2c',
>              'pipe': 'ChardevHostdev',
>              'socket': 'ChardevSocket',
>              'udp': 'ChardevUdp',
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4jyUahZ2QlZqfdy7UQNKii21mIGjnj14T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzMo2YACgkQp6FrSiUn
Q2rwswf/QuCvomakkSEIKszFbrcjiNzaJ+LfYqlRP1m2a8y4nMLlgGHwxivEgZ3N
xcL3VbclxVcl/YnFQgznBvUgmgTe7pR1k3z/fFbbgLCMGNaOF0qslOuqKlMT3ThX
55qv7yZDVokbHyfariasd1uhSU/vVMBX3gg6TWlgq153QycMHRQFFmLD1A0ZnH0V
yAgv8yYuMWPHhenTBhrrNgm5vVZU+IN8+gb/3CnS3WxqZmciApycl9l12xUOZq+n
C6OjDeI0dD1Y3DEbj2VSsWzz97EVqw3DpXuUGQhXCUTZ14A72bLAjSSMBi8MCaKi
AQzNwFATDlOCxeTxiZCrKsYg4k7uQQ==
=btx/
-----END PGP SIGNATURE-----

--4jyUahZ2QlZqfdy7UQNKii21mIGjnj14T--

