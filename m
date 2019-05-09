Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01695C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA107217D6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA107217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60769 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOpws-0005YW-Ck
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:47:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hOpvd-000598-8Z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hOpvc-0002Ga-9s
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hOpvW-0002Dk-5p; Thu, 09 May 2019 16:46:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0F2F30917F0;
	Thu,  9 May 2019 20:45:59 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E0475C269;
	Thu,  9 May 2019 20:45:58 +0000 (UTC)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Max Reitz <mreitz@redhat.com>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-23-alex.bennee@linaro.org>
	<2dcd2689-ca10-b014-e7f0-1967f4901fe2@redhat.com>
	<87r2974b4e.fsf@zen.linaroharston>
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
Message-ID: <35209a95-7ee0-5818-00a1-05da6115de3f@redhat.com>
Date: Thu, 9 May 2019 15:45:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87r2974b4e.fsf@zen.linaroharston>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BxNB9stheBw9htyCXhBSkjSTvFQu3ssn4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 09 May 2019 20:45:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v1 22/23] tests/qemu-iotests: re-format
 output to for make check-block
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BxNB9stheBw9htyCXhBSkjSTvFQu3ssn4
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <35209a95-7ee0-5818-00a1-05da6115de3f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 22/23] tests/qemu-iotests: re-format
 output to for make check-block
References: <20190509165912.10512-1-alex.bennee@linaro.org>
 <20190509165912.10512-23-alex.bennee@linaro.org>
 <2dcd2689-ca10-b014-e7f0-1967f4901fe2@redhat.com>
 <87r2974b4e.fsf@zen.linaroharston>
In-Reply-To: <87r2974b4e.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/9/19 3:38 PM, Alex Benn=C3=A9e wrote:

>> Hm, this makes every iotest print two lines:
>>
>> $ ./check -T -qcow2
>> [...]
>> 001 [20:06:27] -> [20:06:27]
>> 001 0s (last 1s)
>=20
> Yes - it was a compromise to ensure we printed a start and end
> timestamp but I guess we can fix it up with a bit more shell ugliness:
>=20
> --8<---------------cut here---------------start------------->8---
>=20
> Subject: [PATCH] fixup! tests/qemu-iotests: re-format output to for mak=
e
>  check-block
>=20
> ---
>  tests/qemu-iotests/check | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index fb239967a32..9f083f06b46 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -726,7 +726,11 @@ _report_test_result()
>      if $pretty; then
>          echo "  TEST    iotest: $1 $2"
>      else
> -        echo "$1 $2"
> +        if $timestamp; then
> +            echo " $2"
> +        else
> +            echo "$1 $2"
> +        fi

Why not just make $1 '' in the case where you've already printed a
timestamp, so that this code is still unconditionally echo "$1 $2"?

>      fi
>  }
>=20
> @@ -793,7 +797,7 @@ do
>                      $run_command >$tmp.out 2>&1)
>          fi
>          sts=3D$?
> -        $timestamp && echo " [$(date "+%T")]"
> +        $timestamp && echo -n " [$(date "+%T")]"

'echo -n' is not portable (even in bash, since you can compile a
different default for shopt xpg_echo). Better is to use 'printf %s', as
is already done in _timestamp().

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--BxNB9stheBw9htyCXhBSkjSTvFQu3ssn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzUkYUACgkQp6FrSiUn
Q2oD3QgAipa3ETF2rQ1zvovTU8unzAn53rm01h3gvbM7L4GBLJxUu2ptNxOqLr6E
a9GD7CXHYtHjf3gQ3MX5Fx1/LExGiSG1x1lKwfwXemZ1rPFWUBvULe4ukhE2z4yW
LR/dnJ+x3XqYfrbICzMONS9cd0nFNYWPHS0TcFcVrqaiy9XFNMFqKJo7ByEJwDoW
9CWpnkblPlDiGnQqo/1zKCdFVGl3m0254OWhpMTbI2t6GND3sgrUtGDPQU3RYvP7
sszlWC7WgDPo03OxvBS1JGROAsMdrm/F5hP1rCPQV06XUkTOnTDamOubVKIQrxSZ
yPCHba6/7kHcpTGooR70AUGJPMdaVg==
=pQEa
-----END PGP SIGNATURE-----

--BxNB9stheBw9htyCXhBSkjSTvFQu3ssn4--

