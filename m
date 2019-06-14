Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7455CC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3D02168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3D02168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmVh-000419-Fr
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbmGl-000111-0s
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbmGj-0006YL-Qv
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hbmGg-0006Ub-WA
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:29:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68DF93091754
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 13:29:14 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A40241798D;
 Fri, 14 Jun 2019 13:29:11 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190613175435.6575-1-philmd@redhat.com>
 <7c44bcb6-1c72-e327-9091-394e6abfb51e@redhat.com>
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
Message-ID: <c02e3358-f195-51e7-171f-aab2b0314c72@redhat.com>
Date: Fri, 14 Jun 2019 08:29:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7c44bcb6-1c72-e327-9091-394e6abfb51e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="upJd2Pbei5SAAgRbjEeUvqI0mFimoEZC3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 14 Jun 2019 13:29:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] roms/edk2-build.sh: Allow to run
 edk2-build.sh from command line
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
Cc: Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--upJd2Pbei5SAAgRbjEeUvqI0mFimoEZC3
Content-Type: multipart/mixed; boundary="CzNBKKf7lEeQzcBPhO2smGeFf6GEsvkvP";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c02e3358-f195-51e7-171f-aab2b0314c72@redhat.com>
Subject: Re: [PATCH] roms/edk2-build.sh: Allow to run edk2-build.sh from
 command line
References: <20190613175435.6575-1-philmd@redhat.com>
 <7c44bcb6-1c72-e327-9091-394e6abfb51e@redhat.com>
In-Reply-To: <7c44bcb6-1c72-e327-9091-394e6abfb51e@redhat.com>

--CzNBKKf7lEeQzcBPhO2smGeFf6GEsvkvP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/14/19 5:16 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Cc'ing Eric :)
>=20

>> When running this script out of 'make', we get:
>>
>>   $ cd roms
>>   $ ./edk2-build.sh aarch64 --arch=3DAARCH64 --platform=3DArmVirtPkg/A=
rmVirtQemu.dsc > /dev/null
>>   ./edk2-build.sh: line 46: MAKEFLAGS: unbound variable
>>
>> Fix this by checking the variable is defined before using it,
>> else use a default value.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  roms/edk2-build.sh | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
>> index 4f46f8a6a2..5390228b4e 100755
>> --- a/roms/edk2-build.sh
>> +++ b/roms/edk2-build.sh

This is running under /bin/bash (hmm - not '/bin/env bash' like other
scripts in qemu?), so...

>> @@ -43,7 +43,13 @@ fi
>>  # any), for the edk2 "build" utility.
>>  source ../edk2-funcs.sh
>>  edk2_toolchain=3D$(qemu_edk2_get_toolchain "$emulation_target")
>> -edk2_thread_count=3D$(qemu_edk2_get_thread_count "$MAKEFLAGS")
>> +if [ -v MAKEFLAGS ]; then

the non-portable bashism '[ -v' works. However, it's just as easy to
work around this problem portably for all POSIX shells without needing 'i=
f':

>> +  edk2_thread_count=3D$(qemu_edk2_get_thread_count "$MAKEFLAGS")
>> +else
>> +  # We are not running within 'make', let the edk2 "build" utility to=
 fetch
>> +  # the logical CPU count with Python's multiprocessing.cpu_count() m=
ethod.
>> +  edk2_thread_count=3D0
>> +fi

edk2_thread_count=3D$(qemu_edk2_get_thread_count "${MAKEFLAGS:-0}")

at which point the really long comment needs a bit of a tweak.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--CzNBKKf7lEeQzcBPhO2smGeFf6GEsvkvP--

--upJd2Pbei5SAAgRbjEeUvqI0mFimoEZC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0DoSYACgkQp6FrSiUn
Q2rKeQf+NgtRyDOIbTQF6ULJgp7AsGqTV+sQr3bNme3EoBT0gEUsdXbJRFespLy+
xUjG19g7zqcZ/dPeFk1eNUyvET+sHcNC8gsV3g25viZYUzsQEBx0cfJlTu3ZMySX
/X80kUY1Gv6bH6DO2Shh4QUTtEG6c04t/SUjwYr/TwjHdL1iEMs0MpR744paNx4A
xPv454BRbjMBRA+GG0e/5G3fvVNofB2VJGprE7ydivD+XbCPPbOiPja2uZhPU4f1
LsvS4f3rYbJESZez3WVQALoBeurAq+xC6rht5BSXP7kKzEzkII9stNJDEF2RNFCV
Jt0tPIZzLXZJavRJ9e5lVjVOP4rwoA==
=f0r5
-----END PGP SIGNATURE-----

--upJd2Pbei5SAAgRbjEeUvqI0mFimoEZC3--

