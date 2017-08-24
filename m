Received: from eggs.gnu.org ([2001:4830:134:3::10]:59689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl0VP-0005uu-24
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl0VK-0003m1-AM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dl0VK-0003lW-0s
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:21:34 -0400
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
	<230513EB-08AB-41E9-97A6-69C646A5D205@gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <0f7c2030-f9dc-1069-cb94-6d42030e8bc7@redhat.com>
Date: Thu, 24 Aug 2017 18:21:31 -0400
MIME-Version: 1.0
In-Reply-To: <230513EB-08AB-41E9-97A6-69C646A5D205@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sb57jPvXM47KejQcdogVMfOe7bLCAcO5V"
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sb57jPvXM47KejQcdogVMfOe7bLCAcO5V
From: Cleber Rosa <crosa@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org
Message-ID: <0f7c2030-f9dc-1069-cb94-6d42030e8bc7@redhat.com>
Subject: Re: [Qemu-devel] Make test
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
 <74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
 <60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
 <230513EB-08AB-41E9-97A6-69C646A5D205@gmail.com>
In-Reply-To: <230513EB-08AB-41E9-97A6-69C646A5D205@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/24/2017 06:18 PM, Programmingkid wrote:
> After applying the patches I saw this error:
>=20
> $ make test
> make -C tests/tcg test
>   CC      test_path.o
>   LINK    test_path
> ./test_path
> cc -m32 -nostdlib -Wall -O2 -g -fno-strict-aliasing -static  -o hello-i=
386 hello-i386.c
> hello-i386.c:1:10: fatal error: 'asm/unistd.h' file not found
> #include <asm/unistd.h>
>          ^
> 1 error generated.
> make[1]: *** [hello-i386] Error 1
> make: *** [test] Error 2
>=20

Thanks for testing it.

>=20
> The path to this header file is /usr/include/unistd.h and /usr/include/=
sys/unistd.h on my computer. Maybe you could add this to your patches to =
make them more Mac-friendly:
>=20
> #ifdef __MACH__ /* Mach kernel - what's used in Mac OS X */
> 	#include <unistd.h>
> #endif
>=20
> http://pubs.opengroup.org/onlinepubs/7908799/xsh/unistd.h.html
> Then again this page states you should be able to do a "#include <unist=
d.h>" on your posix compatible platform.
>=20
> Thank you.
>=20

I'll take a look and attempt a more portable fix on a v2.

Regards!

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--sb57jPvXM47KejQcdogVMfOe7bLCAcO5V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmfUWsACgkQZX6NM6Xy
CfOP9w//eD+RpfyKzHY5DXI+OAXzQvwXqW1UwzO52GBLMP8Anq18hJiIBmESgtWE
h5d0//SvqY/VpDIANwmv7EHOTS9YX51RpfFHtnUd/m80z0maf9ciOWRNncjYXYWP
MTgm9h8fqvqwyIBB3Iyi4jIOQtX9tmRc2hW/cZlLHlgnoB9IAbtjd40YanAPe+uO
d9AOyk4wHYXIruOwnMdEEyNILZgCmft1uxXCyyTGMNP3NwQiMhwLry9kR/hWiLlG
Jp6vmXltq7mxXIqETjPHp97H2n6ganEA/eojThZICSpHHl8DqQgV7e6F1NuZ174q
QxKdR8364efLvYY6Vvi6YyDfaBAl+g1DeDJWxvbrN89Y7QSrDFuKy5wHd4kyEz/m
KzrjEcYiNvJLCZAVJQDWVacJycPm1SFrjKC4p1rXagaARatwXXBG2oo6hIrjH6ik
zR+qke6cv6y6hnxttPloxOhpWZTEX+YeeM+n09ORRU/KrBb+h+c4G2814eIcW3qr
TvkMdAJbYy0sA3sWNINVQzgiewPsvttpULYGoQqaKt7VJpmF0aBRfIXQ6oSh5Csk
p5ll8f/4rFBa0Dk5YMokdtWGAy3MoLu3GrqRlswvcnjLLAmvUGnBcL7Oblq3G90p
UXW83JqN6yr09lMD0A3A8hhDny9Ggg1lXuVQbqc/C/F8H04vRJY=
=snTt
-----END PGP SIGNATURE-----

--sb57jPvXM47KejQcdogVMfOe7bLCAcO5V--
