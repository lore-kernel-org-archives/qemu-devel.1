Received: from eggs.gnu.org ([2001:4830:134:3::10]:47951)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1drWTY-0007Qx-GK
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1drWTT-0005ba-GJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:42:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:56200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1drWTT-0005Yq-52
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:42:35 -0400
References: <20170911213328.9701-1-f4bug@amsat.org>
	<20170911213328.9701-6-f4bug@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <aa266e28-853b-4703-8495-8fa862aea106@gmx.com>
Date: Mon, 11 Sep 2017 23:44:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170911213328.9701-6-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U7hftUUmkm2T8p4FB0QitsganAIJCI6el"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tcg: restrict i386 regs definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U7hftUUmkm2T8p4FB0QitsganAIJCI6el
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <aa266e28-853b-4703-8495-8fa862aea106@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tcg: restrict i386 regs definitions
References: <20170911213328.9701-1-f4bug@amsat.org>
 <20170911213328.9701-6-f4bug@amsat.org>
In-Reply-To: <20170911213328.9701-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.2017 23:33, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> cleaning while here :)
>=20
>  accel/tcg/user-exec.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 2a975eaf69..484a3f5f8f 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -25,15 +25,6 @@
>  #include "exec/cpu_ldst.h"
>  #include "translate-all.h"
> =20
> -#undef EAX
> -#undef ECX
> -#undef EDX
> -#undef EBX
> -#undef ESP
> -#undef EBP
> -#undef ESI
> -#undef EDI
> -#undef EIP
>  #ifdef __linux__
>  #include <sys/ucontext.h>
>  #endif
> @@ -131,6 +122,15 @@ static inline int handle_cpu_signal(uintptr_t pc, =
unsigned long address,
>  }
> =20
>  #if defined(__i386__)
> +#undef EAX
> +#undef ECX
> +#undef EDX
> +#undef EBX
> +#undef ESP
> +#undef EBP
> +#undef ESI
> +#undef EDI
> +#undef EIP
> =20
>  #if defined(__NetBSD__)
>  #include <ucontext.h>
>=20

Why to move under i386?

SmartOS pollutes namespace with these symbols on x86_64.


--U7hftUUmkm2T8p4FB0QitsganAIJCI6el
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZtwPKAAoJEEuzCOmwLnZsTKIQAMRpGr67lArZDWcAJ6w4P/li
WT+JGEvw9GGUhgUKS7xB8cbAPGRAeVhbjtX2gSvsN9ESqFdYIIKA2XxJNjB9C2fd
ZjJfS+Pz66ARlMgajkGYSUjkjZXdn7pZXY7xIgDyeoPU90JzuoRajVll9HAb4Qqv
LA0WRRVt7gVgsRHSy7w2k9hSeZcPk7X+o54fcpmIoeLY2k8FaRL7n3hbpj2wxp9x
g7UzPL0iUbzZzF6Gy6+k/gc/PDw5XKaeklhVQ+TwpsLOGTIaTYOV+RxVH0a+f63J
Vg6/5Y9jzwzCl170tRHMszw/YsnVTOkB59qX2xGscPbAicSlmVTb+f5l4FX74zFw
uF0LqUni4o3A8or7cRzejMPoz2wibimkRSvJRF2iEMvKdybu154JngAF/u1mQ3nG
7umOmRuHzP5xsDE76nHwyhEy6RRhVF9L3qH+4I+jFSM0icqO0xB1iXKztq2Kg+lM
kG8C7xAQ2O5FWsG1hrXD5EVjRF4CbkFdjHc/KF8r1BxAjFiDtqN2sL90c/Eihm4d
kR98i2B3cP8mgeeqaXC9WP+c6sNLbO4r5gtUastrwN63rTE4vkZ0V88vuDQLie0E
KYlx9WPPfcRi9ld5FfB8GGbNBqO60VV5oSb8Qij1trY/5FccSIFXDeYa0zdsYw02
So+ADSlJfPETq9Iu2iDE
=jRGl
-----END PGP SIGNATURE-----

--U7hftUUmkm2T8p4FB0QitsganAIJCI6el--
