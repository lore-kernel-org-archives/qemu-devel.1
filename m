Received: from eggs.gnu.org ([2001:4830:134:3::10]:41582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkyx2-0002tC-2n
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 16:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkywy-0007iQ-2Y
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 16:42:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dkywx-0007i5-Or
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 16:41:59 -0400
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
Date: Thu, 24 Aug 2017 16:41:53 -0400
MIME-Version: 1.0
In-Reply-To: <74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nt3M5lG37V8bUU5xxw482Xxa0fP02KPmH"
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nt3M5lG37V8bUU5xxw482Xxa0fP02KPmH
From: Cleber Rosa <crosa@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>, qemu-devel@nongnu.org
Message-ID: <60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
Subject: Re: [Qemu-devel] Make test
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
 <74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
In-Reply-To: <74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/24/2017 03:10 PM, Programmingkid wrote:
> I think 'make test' is an abandoned testing option for QEMU so this rep=
ort might be unimportant. Here is my results for running 'make test':
>=20
> $ make test
> make -C tests/tcg test
>   LINK    test_path
> Undefined symbols for architecture x86_64:
>   "_buffer_is_zero", referenced from:
>       _qemu_iovec_is_zero in test_path.o
> ld: symbol(s) not found for architecture x86_64
> clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
> make[1]: *** [test_path] Error 1
> make: *** [test] Error 2
>=20
>=20

I went through the same experience, and reported it (in the form of
patches) here:

http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg00378.html

Although it looks like you're clang, so it'd be nice to check if these
fixes work for you too.

Regards,

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--nt3M5lG37V8bUU5xxw482Xxa0fP02KPmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmfOhIACgkQZX6NM6Xy
CfPcnA/+LgNxzK0dxDLAI1nADLYA81pWG2vEBKQUP3/d6Dn7/x3Xp855WKiIYLvi
YFX88U3ZrKuO2xFvE7FJAv3BYP10Xlaw3KuS+7/4xgOMYuqzoQvM7t/9U06h80np
jZBqJDZXh8GCqXi4vSHuZYeer0FBlen6Yi4zDNRMOtcos0znW9hIX13G9dSEYKxs
uU2DOxNxPh4nuUAlIrMDK/W2il6svRrbXjs/739Z6RXvpjrNjF+0H1UW+3fEu/vq
e2n5F66Po4mH5KIFL6bon36zoBLlrBhYXcJvPnn0/qQ3RyDdKq1ZsKNK9Dxuwp23
nBuituPKSu+JylTO0ALNlnMEg8qcP82PU9Tfn0cg+u7QkqWeeLeQpLZnX5o4rbGR
fnlKcRaOrwhZd7aOnWgrUtVRnW4eYaRXR1U94IjUOXlPc5yGD5LLWHg3f//JRrbh
gdi0xsgBcsu6Ch3+5pfuvQerwF11Lb2vga1usfIxBsJaa0DKzCysXJNsz8eHLRQE
kIAGYsYY1tOhtIj018gO5TyVCxi/skbY8nz/E+Yg+npeXQ0jQC10Ahz4UGMVJEvD
HgNVudzllJyFzW+JYV/8iqnG3GtdwzpxXlTqDDZt/u5w3mxVI0bd3s9Uv4jnZkNw
2+Q20S5u47+xnxcdQMILcq/vmiQ9S8Ij+KeTR50wgihXyXNCZ68=
=1RYc
-----END PGP SIGNATURE-----

--nt3M5lG37V8bUU5xxw482Xxa0fP02KPmH--
