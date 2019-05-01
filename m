Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E68C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 12:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3794321670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 12:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3794321670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLnwQ-0002mG-7i
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 08:02:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLnuz-0002AA-IS
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLnuw-00031u-GD
	for qemu-devel@nongnu.org; Wed, 01 May 2019 08:00:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hLnuw-00031U-6o; Wed, 01 May 2019 08:00:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12CE1308212A;
	Wed,  1 May 2019 12:00:53 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 90FEE71D4C;
	Wed,  1 May 2019 12:00:04 +0000 (UTC)
To: Laurent Vivier <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
	<503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
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
Message-ID: <af19377f-4874-0374-99b6-ee9ab5b0f446@redhat.com>
Date: Wed, 1 May 2019 07:00:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cWuKhQNXUyPcCDWb7oTARORvy0k7wUsDw"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 01 May 2019 12:00:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501120003.7d6BYurOrtXdL64YS0S1KIKaWTtXr8LwPAuzOy-G3w4@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cWuKhQNXUyPcCDWb7oTARORvy0k7wUsDw
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <af19377f-4874-0374-99b6-ee9ab5b0f446@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
References: <cover.1556666645.git.alistair.francis@wdc.com>
 <14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
 <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
In-Reply-To: <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/1/19 4:40 AM, Laurent Vivier wrote:
> On 01/05/2019 01:28, Alistair Francis wrote:
>> Fix this warning when building with GCC9 on Fedora 30:
>> In function =E2=80=98strncpy=E2=80=99,
>>     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/li=
nux-user/uname.c:94:3:
>> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin=
_strncpy=E2=80=99 output may be truncated copying 64 bytes from a string =
of length 64 [-Werror=3Dstringop-truncation]
>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos =
(__dest));
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  linux-user/uname.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/uname.c b/linux-user/uname.c
>> index 313b79dbad..2fc6096a5b 100644
>> --- a/linux-user/uname.c
>> +++ b/linux-user/uname.c
>> @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
>>  #define COPY_UTSNAME_FIELD(dest, src) \
>>    do { \
>>        /* __NEW_UTS_LEN doesn't include terminating null */ \
>> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
>> +      (void) memcpy((dest), (src), MIN(strlen(src), __NEW_UTS_LEN)); =
\
>=20
> You should use MIN(strlen(src) + 1, __NEW_UTS_LEN) to copy the NUL
> character if it is present and fit in __NEW_UTS_LEN.

No, the NUL character is already present, due to the memset() prior to
any use of COPY_UTSNAME_FIELD().  However, the commit message should
call that out, as it is not part of the default 3-line diff.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cWuKhQNXUyPcCDWb7oTARORvy0k7wUsDw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzJikQACgkQp6FrSiUn
Q2qfuAgApDJvUYWkMmk2kJMcz8AzL8zkLXtT1lbru3HnonwcauRyRUmLeUHgn7hq
I0lNxoR1/rxZmOr3cuiRxuO2N2Y6bLMNgYlRXeW7cgGnkEYVsjwuSD3dVkJ53ggh
pfIfVmiY2V1+WgoTj/9OL+RVDK5iu18GT3/D3FCqbjJTuDX4UlrCM0usd9kt616j
C0A5THCh7JhfY0GuqgkzrZmMUofBwR6CJTriAFPfEWQhNQRoTSCGS8kRjYNwGeW4
QZkOfRwZIX/3Mc1RsAf1Zba40mwtNAIKDfJNahYqidK4GulptiGIK2Mi33xKIocW
W0OqU6jTHk6ocLw7NjSwgC5wp0jwnw==
=74z3
-----END PGP SIGNATURE-----

--cWuKhQNXUyPcCDWb7oTARORvy0k7wUsDw--

