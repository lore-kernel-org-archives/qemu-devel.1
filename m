Received: from eggs.gnu.org ([2001:4830:134:3::10]:51576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duPuR-0005ta-H7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duPuO-0000KW-Cp
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:18:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duPuO-0000ID-4x
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 17:18:20 -0400
References: <20170919211012.13507-1-laurent@vivier.eu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5e9a983-6543-28d3-8e4c-c49b2ac1b694@redhat.com>
Date: Tue, 19 Sep 2017 16:18:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170919211012.13507-1-laurent@vivier.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gKitFua22Mrq7GhNIb9gWx0CvWiqhdden"
Subject: Re: [Qemu-devel] [PATCH v2] softfloat: rename
 make_float[x80|128]_init to const_float[x80|128]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gKitFua22Mrq7GhNIb9gWx0CvWiqhdden
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <c5e9a983-6543-28d3-8e4c-c49b2ac1b694@redhat.com>
Subject: Re: [PATCH v2] softfloat: rename make_float[x80|128]_init to
 const_float[x80|128]
References: <20170919211012.13507-1-laurent@vivier.eu>
In-Reply-To: <20170919211012.13507-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 04:10 PM, Laurent Vivier wrote:
> We already have const_float16(), const_float32() and const_float64(),
> so rename make_floatx80_init() and make_float128_init() as

s/as/to now be/

> const_floatx80() and const_float128().

s/\./, for consistency./

>=20
> Redefine make_float16(), make_float32() and make_float64() as

s/as/to be like/

> make_floatx80() and make_float128() using a cast.

s/ using a cast/, by using a compound literal/

I almost wonder if splitting this patch into two parts makes more sense
(one for the renaming of make_float[x80,128]_init, the other for the
rewriting of make_float[16,32,64] from gcc extension to compound literal)=
=2E

At any rate, the code itself looks fine.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gKitFua22Mrq7GhNIb9gWx0CvWiqhdden
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBiZgACgkQp6FrSiUn
Q2qX7AgArEMsdVufdj3UU6W0KBP1SRfJ3sEW5soi5O+b52Vq4F6pDxRkpR//4Hv1
Qob8PP2VTCRIeXd41LymlDMZmJ+qzuF+ICi7NX3VUKGII+dpw6qGB+/kruua9PVl
s1JR5Z7EHhR7ux5F4z6yccog4SSXIsh5z6y1uVsF5hFboe4YAMn0X86H0vmmrAeF
rCiOqzEAVbg6F6NlWOUxIcitWQpRIVQd/liCn41zU3FZGxrlegMsm0jxi2fXR/ox
bNZGqvadt5zxYASoxCIchrmulUxVI+oWIBqcnvjiYJ639eRsRev6Es2rC/jGKJ4A
DObxbRF4V182Br5NBXpuy5iINAY7gA==
=MuOF
-----END PGP SIGNATURE-----

--gKitFua22Mrq7GhNIb9gWx0CvWiqhdden--
