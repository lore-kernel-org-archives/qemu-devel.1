Received: from eggs.gnu.org ([209.51.188.92]:50371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hMQkM-0007Xm-DJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hMQkL-0000fK-Cy
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:28:34 -0400
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003719.10233-1-driver1998@foxmail.com>
	<db80e5ca-ab98-9c0b-a8c5-8e0c88c58638@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <8b04e42b-fdf7-4a9a-b36c-8a60bace27fe@weilnetz.de>
Date: Fri, 3 May 2019 07:28:21 +0200
MIME-Version: 1.0
In-Reply-To: <db80e5ca-ab98-9c0b-a8c5-8e0c88c58638@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="79E37so4yXGw8zLXAQ8jl8XTF3dybt9eo"
Subject: Re: [Qemu-devel] [PATCH v3 4/4] osdep: Fix mingw compilation
 regarding stdio formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>

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
