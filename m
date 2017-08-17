Received: from eggs.gnu.org ([2001:4830:134:3::10]:47501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1diKtu-0008Mk-Gx
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1diKtr-0006ta-D4
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1diKtr-0006t2-3f
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:31:51 -0400
From: Cleber Rosa <crosa@redhat.com>
References: <20170802201512.29142-1-crosa@redhat.com>
	<20170802201512.29142-2-crosa@redhat.com>
	<c9d1d353-855e-40fe-9f43-aecd9d4c34db@amsat.org>
	<1fbb4089-b58f-d98c-0fe3-7bc6d1ce2eb5@redhat.com>
Message-ID: <8b5d3268-6d98-1431-29c7-752fa76d9ca8@redhat.com>
Date: Thu, 17 Aug 2017 09:26:04 -0400
MIME-Version: 1.0
In-Reply-To: <1fbb4089-b58f-d98c-0fe3-7bc6d1ce2eb5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WGvErVBHXlkj6SEsmoKFGVUnbt2K2IpM6"
Subject: Re: [Qemu-devel] [PATCH 1/6] tests/tcg/test_path.c: include
 utils/bufferiszero.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WGvErVBHXlkj6SEsmoKFGVUnbt2K2IpM6
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Message-ID: <8b5d3268-6d98-1431-29c7-752fa76d9ca8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] tests/tcg/test_path.c: include
 utils/bufferiszero.c
References: <20170802201512.29142-1-crosa@redhat.com>
 <20170802201512.29142-2-crosa@redhat.com>
 <c9d1d353-855e-40fe-9f43-aecd9d4c34db@amsat.org>
 <1fbb4089-b58f-d98c-0fe3-7bc6d1ce2eb5@redhat.com>
In-Reply-To: <1fbb4089-b58f-d98c-0fe3-7bc6d1ce2eb5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 08/02/2017 06:24 PM, Cleber Rosa wrote:
>=20
>=20
> On 08/02/2017 05:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Cleber,
>>
>> On 08/02/2017 05:15 PM, Cleber Rosa wrote:
>>> Which contains one specific function used by iov.c.
>>>
>>> Without this, "make -C tests/tcg test_path" (and consequently
>>> "make -C tests/tcg" or simply "make test") fails quite early.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>   tests/tcg/test_path.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
>>> index 1c29bce..74dbdaf 100644
>>> --- a/tests/tcg/test_path.c
>>> +++ b/tests/tcg/test_path.c
>>> @@ -3,6 +3,7 @@
>>>   #include "util/cutils.c"
>>>   #include "util/hexdump.c"
>>>   #include "util/iov.c"
>>> +#include "util/bufferiszero.c"
>>
>> This fixes the build, however why not take this opportunity to fix it
>> through the Makefile instead of including .c?
>>
>=20
> Do you mean for all of the .c includes?  I just took a baby step, which=

> seemed more consistent with the mission (get it to build), without
> changing a lot.
>=20

Hi Phil,

Can you clarify what you meant here?

Thanks!

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--WGvErVBHXlkj6SEsmoKFGVUnbt2K2IpM6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmVmWwACgkQZX6NM6Xy
CfOJ0w//T4IZ+9j9+AzCG6a1yYw1+fjXK24+zecwuI/NnoWWKGkfeMLU7BamYK+4
16s/9cQB8oh1zwjhz2XALz+DhbQqXNtII1xQkCaU9ccwKTWVHUA+ScmsyBGDcKR8
CIRzh4ryDpZgp3nCaKFhgfQS/nnHQ1x15NK0CDYu3IrgEo8LaT6yToAfoRRIgjD4
4dHF8j5ztYcUG/titp12sek1wXkIC0HdENgz4euWLUCr9bK6Xmk/vWGMbPEG86k3
NgKpEsRouZRor4xjdt+4jhkvsYCeu5JglBZPZxCG+C2B153Okudbb9BqutVFqHNI
T2YcyiLM7W8Kwc9cdu2IdlhRuLiYj4jPF8lgQUMsV8qmgf8k0ErT7vzx5CeqAgjT
GBenNuiW2qje6tSt7UYeTQWg3/OrFc3xQVhO+87rJ+Llwt9rPjSzrB04R9vNBUjH
GDQFYiTbTUFtnkV9rpBbB5z0/t2s03v0dfieK2KAL8WN4V1wEdYBk8bAoqE2VJAW
gxshEH2Yxydx7ja59TbTPsQVSzgo1LfR7eo+amrYt4XsfEmomhR00EWTQBPtCzpR
pA5lNVqfvBgrE2idOgWClqoruwYr5U5OWmbILuD3Q4phMiO6FXSI8H+osQ4d+TGT
rbio4Yc5wjVYQOvbcG3x9EDo3Oa0SsDZpBG2U06QZg2ESk9GS9s=
=yL57
-----END PGP SIGNATURE-----

--WGvErVBHXlkj6SEsmoKFGVUnbt2K2IpM6--
