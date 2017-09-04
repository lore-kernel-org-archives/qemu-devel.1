Received: from eggs.gnu.org ([2001:4830:134:3::10]:56662)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1douLq-0004LS-5X
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1douLl-0002Os-8m
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:35:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:55489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1douLk-0002O5-UK
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:35:49 -0400
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
	<941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
	<c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
	<CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
	<a91359d6-457c-7164-18f9-050193f2d419@vivier.eu>
	<CAFEAcA8VYnJgru6bV7_tNkPoJSKm3pwTH=8oJRdpTEW9PXycug@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <b79a96fa-74ac-cab3-8f87-a94be96e7ae5@gmx.com>
Date: Mon, 4 Sep 2017 18:38:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8VYnJgru6bV7_tNkPoJSKm3pwTH=8oJRdpTEW9PXycug@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HF7wsGGERimce3FkprV7CvcH6x2OLSFsQ"
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HF7wsGGERimce3FkprV7CvcH6x2OLSFsQ
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <b79a96fa-74ac-cab3-8f87-a94be96e7ae5@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
References: <20170903163130.14288-1-n54@gmx.com>
 <9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
 <1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
 <941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
 <c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
 <CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
 <a91359d6-457c-7164-18f9-050193f2d419@vivier.eu>
 <CAFEAcA8VYnJgru6bV7_tNkPoJSKm3pwTH=8oJRdpTEW9PXycug@mail.gmail.com>
In-Reply-To: <CAFEAcA8VYnJgru6bV7_tNkPoJSKm3pwTH=8oJRdpTEW9PXycug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 18:17, Peter Maydell wrote:
> On 4 September 2017 at 16:53, Laurent Vivier <laurent@vivier.eu> wrote:=

>> Le 04/09/2017 =C3=A0 17:02, Peter Maydell a =C3=A9crit :
>>> On 4 September 2017 at 15:09, Laurent Vivier <laurent@vivier.eu> wrot=
e:
>>>> You can:
>>>>
>>>> either replace the "#define floatx80_pi make_floatx80(...)" by a "co=
nst
>>>> floatx80 floatx80_pi =3D make_floatx80_init(...)"
>>>>
>>>> or replace all the macros in the m68k/fpu_helper.c array by
>>>> make_floatx80_init(...)
>>>
>>> Taking a step back, what's different about floatx80 and float12
>>> that means they need separate _init and non-init versions of
>>> the macros, when for float16/float32/float64 we instead have
>>> #define make_float32(x) __extension__ ({ float32 f32_val =3D {x}; f32=
_val; })
>>> #define const_float32(x) { x }
>>
>> floatx80/float128 are structureq while float16/float32/float64 are
>> native data types.
>=20
> If USE_SOFTFLOAT_STRUCT_TYPES is defined then float16/32/64 are
> also struct types and use the make_ and const_ macros as above.
>=20
> (We should check whether USE_SOFTFLOAT_STRUCT_TYPES still builds,
> it tends to bitrot. If it does then maybe we should use it by default
> since gcc 3 is now just a memory...)
>=20

USE_SOFTFLOAT_STRUCT_TYPES breaks for me on SmartOS:

migration/vmstate-types.c: In function 'put_float64':
migration/vmstate-types.c:430:5: error: conversion to non-scalar type
requested

>>> ? Could we move to consistency for the macro naming we're using?
>>
>> Do you mean "s/make_floatx80_init/const_floatx80/"?
>=20
> Yes (and the same implementation would be nice too).
>=20

I will push my patch as is and later it can be refactored by a
maintainer. Is this fine?

https://github.com/NetBSD/pkgsrc-wip/blob/master/qemu-git/patches/patch-t=
arget_m68k_fpu__helper.c

> thanks
> -- PMM
>=20



--HF7wsGGERimce3FkprV7CvcH6x2OLSFsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrYFyAAoJEEuzCOmwLnZseLMP/iKldqG1mp4C+SSCMQDnO/eG
jw2Ty7B5YNlTLQUCNz1YIFCB+wWu0xjM/JzQlBf2N4xlVFfHV1FNkniWVI6p5Njl
tHdj0sTB7eeNr7Q/Yk3woKxXDI9rza4xVeLUS5Uq1+K85xtABux3ALw0m4RDzGNv
QVuA7ewRNhScRGLjmuwvH5noswytm8gGmhtnDeUWzR4Ku2q8x2LFoafwh2aAPEJ2
zS3ghPzvkrzg19c9z53sXwsJdU8oYP9ySkxMtpyqcu/49y74sD/svtlFZMNCfBBm
vTMFpx088ZpUDGj3ycdLpTGuO4X5ymO6t/sG0cWD/kQC8yRLIKD65/qLOD8/t78q
/ughTfXLYn2fhfDrbHyVjKEm9FpcaJBi8GY2jfC2V0EuVfDEsxO8kSemi7nBx2Sf
sPrLEcGBQIHyGkjM/42p7FGz1SPKEG3n9JeYRZJE/RmRVzu+UVB0jB4J+jLLZLxU
Nhe0X/rSTOVkw6mFk7eRo2LrN5mVSZZV5R1RyKXLfMVhIDf1lVr5jSAZ+2fIhSPg
ty5b39z/XhHi8nojY2OnBnFOn77vC1aA0kHS5sMgapaNlPetIVmgeONiBFie0nwb
4oQPy5t4Ofr2QWChNcrJqmv9o4asYzpu4ESKN6PdZRW2Dcgf/HBbnSiRezE96KAx
TMPNP9qFWy1/Enp/Amo+
=36jE
-----END PGP SIGNATURE-----

--HF7wsGGERimce3FkprV7CvcH6x2OLSFsQ--
