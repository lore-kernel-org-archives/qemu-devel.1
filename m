Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D37C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC7B2081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC7B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMQlT-00087i-V2
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:29:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hMQkM-0007Xm-DJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hMQkL-0000fK-Cy
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:28:34 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:51346
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>)
	id 1hMQkL-0000eC-2o; Fri, 03 May 2019 01:28:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by v2201612906741603.powersrv.de (Postfix) with ESMTP id F287CDB6250;
	Fri,  3 May 2019 07:28:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
	by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id Yv3w1FEJ0mOs; Fri,  3 May 2019 07:28:29 +0200 (CEST)
Received: from [192.168.178.24] (p57B42786.dip0.t-ipconnect.de [87.180.39.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id BFC6DDB6163; 
	Fri,  3 May 2019 07:28:29 +0200 (CEST)
To: Thomas Huth <thuth@redhat.com>, Cao Jiaxi <driver1998@foxmail.com>,
	qemu-devel@nongnu.org
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003719.10233-1-driver1998@foxmail.com>
	<db80e5ca-ab98-9c0b-a8c5-8e0c88c58638@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Openpgp: preference=signencrypt
Autocrypt: addr=sw@weilnetz.de; prefer-encrypt=mutual; keydata=
	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
Message-ID: <8b04e42b-fdf7-4a9a-b36c-8a60bace27fe@weilnetz.de>
Date: Fri, 3 May 2019 07:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <db80e5ca-ab98-9c0b-a8c5-8e0c88c58638@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="79E37so4yXGw8zLXAQ8jl8XTF3dybt9eo"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 4/4] osdep: Fix mingw compilation
 regarding stdio formats
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503052821.TmBlhKC_CLuxEk0ZrbpCsdbnQIJbTE78Tj6320ZIKeU@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--79E37so4yXGw8zLXAQ8jl8XTF3dybt9eo
From: Stefan Weil <sw@weilnetz.de>
To: Thomas Huth <thuth@redhat.com>, Cao Jiaxi <driver1998@foxmail.com>,
 qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>
Message-ID: <8b04e42b-fdf7-4a9a-b36c-8a60bace27fe@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] osdep: Fix mingw compilation
 regarding stdio formats
References: <20190503002206.9751-1-driver1998@foxmail.com>
 <20190503003719.10233-1-driver1998@foxmail.com>
 <db80e5ca-ab98-9c0b-a8c5-8e0c88c58638@redhat.com>
In-Reply-To: <db80e5ca-ab98-9c0b-a8c5-8e0c88c58638@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.05.19 07:11, Thomas Huth wrote:
> On 03/05/2019 02.37, Cao Jiaxi wrote:
>> I encountered the following compilation error on mingw:
>>
>> /mnt/d/qemu/include/qemu/osdep.h:97:9: error: '__USE_MINGW_ANSI_STDIO'=
 macro redefined [-Werror,-Wmacro-redefined]
>>  #define __USE_MINGW_ANSI_STDIO 1
>>         ^
>> /mnt/d/llvm-mingw/aarch64-w64-mingw32/include/_mingw.h:433:9: note: pr=
evious definition is here
>>  #define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it should=
 be 0 */
>>
>> It turns out that __USE_MINGW_ANSI_STDIO must be set before any
>> system headers are included, not just before stdio.h.
>>
>> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
>> ---
>>  include/qemu/osdep.h | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 303d315c5d..af2b91f0b8 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -85,17 +85,17 @@ extern int daemon(int, int);
>>  #endif
>>  #endif
>> =20
>> +/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or lat=
er) */
>> +#ifdef __MINGW32__
>> +#define __USE_MINGW_ANSI_STDIO 1
>> +#endif
>> +
>>  #include <stdarg.h>
>>  #include <stddef.h>
>>  #include <stdbool.h>
>>  #include <stdint.h>
>>  #include <sys/types.h>
>>  #include <stdlib.h>
>> -
>> -/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or lat=
er) */
>> -#ifdef __MINGW32__
>> -#define __USE_MINGW_ANSI_STDIO 1
>> -#endif
>>  #include <stdio.h>
>> =20
>>  #include <string.h>
>>
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Stefan Weil <sw@weilnetz.de>


--79E37so4yXGw8zLXAQ8jl8XTF3dybt9eo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESSNv6nXJXWmOwreK4Iwh1Wd0UK0FAlzL0X0ACgkQ4Iwh1Wd0
UK2R9g/9Gw+96R8Ut9N214NusnvjhbwqVDflZV3Js0pTz8ny1kM6wGP5aZEtqR8d
A1CZlA7rwLeGmF0Bz9uTwd/d4amsxvLLz5qM3XVAr6vqcyiyYiKk4fJ8ATv6IQID
rL0U3u1dgP3IFl8J4GCJsv9kX/BZyiOTJZ1Y+xX9ZJosOlrQG/Zx8D5cdNtz/svQ
vczbe+dU2buYUpvYNnMr4zB5lPrXqapDJYeFbdTYofrFn6UVZYiUAqXRPabk6c5X
R/UJHpYq8DkPpupAFwRSAvlfaeKgSCq3uNBt/i0UJ7cuSZjjdn+i1eREdps7bbBg
aowCio8GzN6q2P6GFatYe+N65pMRCfS5kd3e0fJN29DdeAL69sQHF056M0djOqV2
+wJCYQwbiLLmWR4JFuF+8owayq/BZTqxlYqv3MuY/Ho2Oh+OcZ6NVtITjP5OYWHM
xkLAo+cHIl7mN1pfCcQUs2FEoxbo8n0zhAP4swPkqqtbdT2S9zQXlYfOOcz99aDW
nMkKtSY6gHQqP5gBWBOHQwQFa2AYL4clDqVJeAx5KqRRgWluiyjsXm30kEqw0FWn
YzZboYa8PaBmDdIacTOGQ6XCkPgDAR+L0aPuEAIZ2UohAXTDyLEHO83xkDa7985H
9UbUfrM5v86ftcnUfELb2q++ohRFLysaDKO6gRIxEGHE7RfqPbQ=
=1+BK
-----END PGP SIGNATURE-----

--79E37so4yXGw8zLXAQ8jl8XTF3dybt9eo--

