Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A35C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B536217F5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B536217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FOr-0007hH-II
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2FNX-00076q-TX
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2FNW-0005De-SX
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i2FNU-0005C1-L8; Mon, 26 Aug 2019 09:49:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F414318012F0;
 Mon, 26 Aug 2019 13:49:47 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 714C25C207;
 Mon, 26 Aug 2019 13:49:47 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-devel@nongnu.org
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
 <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
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
Message-ID: <8a5eef62-27eb-9936-3db7-08d06532add7@redhat.com>
Date: Mon, 26 Aug 2019 08:49:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v2Cz1QLGB7Hi5CHKayelHjAs7zTj3bvk7"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 26 Aug 2019 13:49:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: posix: Always allocate the
 first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v2Cz1QLGB7Hi5CHKayelHjAs7zTj3bvk7
Content-Type: multipart/mixed; boundary="U1UhuXtfyvGRbcUdCp5TSKReSJs4BnUF2";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <8a5eef62-27eb-9936-3db7-08d06532add7@redhat.com>
Subject: Re: [PATCH v2 1/2] block: posix: Always allocate the first block
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
 <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
In-Reply-To: <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>

--U1UhuXtfyvGRbcUdCp5TSKReSJs4BnUF2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/26/19 7:31 AM, Max Reitz wrote:

>>  # the file size.  This function hides the resulting difference in the=

>>  # stat -c '%b' output.
>>  # Parameter 1: Number of blocks an empty file occupies
>> -# Parameter 2: Image size in bytes
>> +# Parameter 2: Minimal number of blocks in an image
>> +# Parameter 3: Image size in bytes
>>  _filter_blocks()
>>  {
>>      extra_blocks=3D$1
>> -    img_size=3D$2
>> +    min_blocks=3D$2
>> +    img_size=3D$3
>> =20
>> -    sed -e "s/blocks=3D$extra_blocks\\(\$\\|[^0-9]\\)/nothing allocat=
ed/" \
>> -        -e "s/blocks=3D$((extra_blocks + img_size / 512))\\(\$\\|[^0-=
9]\\)/everything allocated/"
>> +    sed -e "s/blocks=3D$((min_blocks))\\(\$\\|[^0-9]\\)/min allocatio=
n/" \
>=20
> Superfluous parentheses ($(())), but not wrong.

Note that $((..)) has a purpose: it can convert any variable content
into decimal.  I can write min_blocks=3D0x1000, and $((min_blocks))
results in 4096 while $min_blocks is still 0x1000.  But I'd need more
context as to what the callers expect to pass as to whether the $((...))
is superfluous here.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--U1UhuXtfyvGRbcUdCp5TSKReSJs4BnUF2--

--v2Cz1QLGB7Hi5CHKayelHjAs7zTj3bvk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1j43oACgkQp6FrSiUn
Q2pJhQf/VEdQGuN1LCFUfF49DIjaZ8kAf1DyB3A3nmmZ0bewb2ZDlGF5olHUrEx5
ZU0YuAmEYMfttQo8yp3OJDHW4UvHymL44Fl+oycdcsldLRpdJ+wx9rQguJEE9/R7
rPA5cKN4Y6HThKc7NYvRwv3PWXtAE9ZAQYEQZ7CTXNu8A+rYKZTZ/OyFkTT3Olal
n+gBi19JOTC82WnG7rq3ssxRyJ7mNMS9Fi37aTNFMC6KFotfTqlUcT+gFEsaCYyy
uWp3adJEy4TIzdSNDYwUDUXmuQyIwOQHSjg1q/ej3RCsh/usF2JgsKWCnM38/mH9
fSppBUgGydQ9QBlEg3wUicQFDqggEw==
=I3+A
-----END PGP SIGNATURE-----

--v2Cz1QLGB7Hi5CHKayelHjAs7zTj3bvk7--

