Received: from eggs.gnu.org ([209.51.188.92]:41767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmcQU-0001PT-6G
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmcQS-0005Xj-76
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:40:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmcQO-0005KQ-Bj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:39:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so2524765wmc.5
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:39:54 -0800 (PST)
References: <20190124013625.27239-1-philmd@redhat.com>
	<48ad7886-5e8a-fc84-77ec-c76628fb6603@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9777fd8f-5170-c7f4-f458-749a173397ce@redhat.com>
Date: Thu, 24 Jan 2019 11:39:51 +0100
MIME-Version: 1.0
In-Reply-To: <48ad7886-5e8a-fc84-77ec-c76628fb6603@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sFWNH228jd3pbyxRdpXpxvFKwyPIBGc97"
Subject: Re: [Qemu-devel] [RFC PATCH] ui/egl: Silent '__HAIKU__ undefined'
 warnings on OpenBSD 6.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sFWNH228jd3pbyxRdpXpxvFKwyPIBGc97
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>
Message-ID: <9777fd8f-5170-c7f4-f458-749a173397ce@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] ui/egl: Silent '__HAIKU__ undefined'
 warnings on OpenBSD 6.1
References: <20190124013625.27239-1-philmd@redhat.com>
 <48ad7886-5e8a-fc84-77ec-c76628fb6603@gmx.com>
In-Reply-To: <48ad7886-5e8a-fc84-77ec-c76628fb6603@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 3:00 AM, Kamil Rytarowski wrote:
> On 24.01.2019 02:36, Philippe Mathieu-Daud=C3=A9 wrote:
>> OpenBSD display various warnings about the use of an undefined __HAIKU=
__:
>>
>=20
> Please report it to OpenBSD and/or 3rd party libs. It's just a warning
> in public headers, not an issue on the qemu side.

Brad said it should be fixed in OpenBSD 6.5:

https://cgit.freedesktop.org/mesa/mesa/commit/include/EGL/eglplatform.h?i=
d=3Df744c6c1e28fe363474550b94af42a8b7fc1c755

>=20
>>     CC      ui/egl-context.o
>>   In file included from /usr/X11R6/include/epoxy/egl_generated.h:10:0,=

>>                    from /usr/X11R6/include/epoxy/egl.h:46,
>>                    from include/ui/egl-helpers.h:5,
>>                    from include/ui/egl-context.h:5,
>>                    from ui/egl-context.c:3:
>>   /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is =
not defined [-Wundef]
>>    #elif __HAIKU__
>>          ^
>>   CC      ui/egl-helpers.o
>> /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is no=
t defined [-Wundef]
>>   CC      ui/egl-headless.o
>> /usr/X11R6/include/EGL/eglplatform.h:128:7: warning: "__HAIKU__" is no=
t defined [-Wundef]
>>
>> This is due to a old <epoxy/egl_generated.h>:
>>
>>      70 #if defined(_WIN32) || defined(__VC32__) && !defined(__CYGWIN_=
_) && !defined(__SCITECH_SNAP__) /* Win32 and WinCE */
>>         ...
>>     108 #elif defined(__unix__) || defined(__APPLE__)
>>     128 #elif __HAIKU__
>>     134 #else
>>     135 #error "Platform not recognized"
>>     136 #endif
>>
>> Kludge this by adding a check to ./configure: if this warning occurs,
>> define __HAIKU__ from the CFLAGS.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> This is ugly, hopefully someone can come with a clever idea :)
>>
>>  configure | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 8f312ac3e2..7c7eee44da 100755
>> --- a/configure
>> +++ b/configure
>> @@ -4036,6 +4036,17 @@ EOF
>>    if compile_prog "" "" ; then
>>      opengl_dmabuf=3Dyes
>>    fi
>> +  cat > $TMPC << EOF
>> +#include <epoxy/egl.h>
>> +int main(void) { return 0; }
>> +EOF
>> +  if test "$targetos" =3D "OpenBSD" ; then
>> +    if ! compile_prog "-Wundef -Werror" "" ; then
>> +      if compile_prog "-Wundef -Werror -D__HAIKU__=3D0" "" ; then
>> +        QEMU_CFLAGS=3D"$QEMU_CFLAGS -D__HAIKU__=3D0"
>> +      fi
>> +    fi
>> +  fi
>>  fi
>> =20
>>  ##########################################
>>
>=20
>=20


--sFWNH228jd3pbyxRdpXpxvFKwyPIBGc97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlxJlfgACgkQoqP9bt6t
wN4hRhAAvcDqtR9G9pVPRoCHhj9nQgJFSEDJM0s+0sWWJV7LZKahiQKRa+aTuu1q
5yZM49rO+mbcpt2bOP+YiaXQ/SKk3qeRPZHLFFpL+BFzTKM1FiFH3F6erBTVkt+L
LXz9n6lDBGPatw8JEVlBRi9jKitTCW3+yxqrsGkcfaSnsAyBH7x7/R9Y9abmLpJp
RMRac3+2Yks2r2+4UceaKuIuWARbzqqDxJFNx+KVB+NhdQknsOws2IXgdvD+A9oK
Gn6/UR59qHdnfJaG1kznYDS/lEqab0TpAcrZKm1B7V2OVd8hoPwA57YoI2V8EZde
711AM3F43WAApldbrTiZKAVJ4oTrgtPuhz1r+4ZeZg1PQJMehfjJGJvp9xwBnCwK
w8QEWiLNjJxyJ/67JZSp2zL8PXMPR8/YHVXmhqn/u9okMQZuVQ+3EfEJBY25hit8
MIXg8IoytvEQiQEgrmgGU3we4/WFTuFQlCNRU8VzlxbiFK7n31v4DHUfLkXbvNQO
32WOXrrlVTZ6wtyJqLSrB0yIHkuwW07NBhhfFfGi4DtQ74D23IRrUCJPDGqm7q6J
JUfquoaUFrzcvgWp4yNdjezYUseMgct44+Rb2/ctQVHlotPAoC2yRfp34QyQy6Bc
1XVGmOhI7GRM+9fwdGxj7CCE1/EwgoayxzttL6gAySemCd3G8Ws=
=QoCk
-----END PGP SIGNATURE-----

--sFWNH228jd3pbyxRdpXpxvFKwyPIBGc97--
