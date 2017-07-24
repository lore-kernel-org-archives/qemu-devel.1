Received: from eggs.gnu.org ([2001:4830:134:3::10]:41298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZcI3-0006Nd-Sd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZcI2-0007oH-0R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:16:47 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-20-f4bug@amsat.org>
	<CAJ+F1CJL8krrmFwCgqx6qZepkNZbcvTJrkOEVcsWiHurCBcUZw@mail.gmail.com>
	<3b25ec9f-5711-de4c-eade-eecef96b6379@redhat.com>
	<a49428cc-88e9-dbd8-3d2f-207acbef68f9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90438d63-2cfc-ad79-a490-7a50e40fe53a@redhat.com>
Date: Mon, 24 Jul 2017 07:16:41 -0500
MIME-Version: 1.0
In-Reply-To: <a49428cc-88e9-dbd8-3d2f-207acbef68f9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9hvfmm8o325U8VpeThWUicNTF58AjdgqO"
Subject: Re: [Qemu-devel] [PATCH 19/29] disas: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu trival <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, QEMU <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9hvfmm8o325U8VpeThWUicNTF58AjdgqO
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 qemu trival <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Message-ID: <90438d63-2cfc-ad79-a490-7a50e40fe53a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 19/29] disas: use QEMU_IS_ALIGNED macro
References: <20170718061005.29518-1-f4bug@amsat.org>
 <20170718061005.29518-20-f4bug@amsat.org>
 <CAJ+F1CJL8krrmFwCgqx6qZepkNZbcvTJrkOEVcsWiHurCBcUZw@mail.gmail.com>
 <3b25ec9f-5711-de4c-eade-eecef96b6379@redhat.com>
 <a49428cc-88e9-dbd8-3d2f-207acbef68f9@redhat.com>
In-Reply-To: <a49428cc-88e9-dbd8-3d2f-207acbef68f9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/23/2017 09:52 AM, Paolo Bonzini wrote:

>=20
> But I agree that QEMU_IS_ALIGNED looks weird here.  I think it should
> mostly be used when the argument is a pointer, to hide the cast.  Uses
> for non-pointer arguments should be decided on a one-by-one basis; "is
> the first argument an address" is definitely a good thing to consider.
> Another might be "is the second argument a variable", because "i % n =3D=
=3D
> 0" is less efficient than "(i & (n - 1)) =3D=3D 0".

How often is QEMU_IS_ALIGNED used on non-power-of-2?  Would it be worth
rewriting it into bit-wise ops, at the expense of declaring that any
code aligning to other values must open-code their own %?  Can we have
the compiler help us ensure that the second argument is a power-of-2?
Conversely, if the compiler is given a constant for the second argument,
and is not optimizing modulo power of two into bitwise ops (at least at
CFLAGS=3D-O2), then that's a compiler bug.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9hvfmm8o325U8VpeThWUicNTF58AjdgqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll15SkACgkQp6FrSiUn
Q2orHgf/Q3alf1cx9tr1nTJ/dQ0GuruPZDZxWHU6KEIKYnNCUD/aa4VWzFswQAiG
MPpSFm76cKusH5B1FlMA5cwgvP2MKVdOYAlWI8BplQAwJI8h7PDlP2STEDPOoWey
susrV8qWQ69iZlOGA3i4xvdN8xvwknrQl9+sGv5dRxA+02OPxvIST4531vzD8egD
XxmE4scret21BswRSEmNVQAcY6PVG1Fa85FKMF6BswgxsGI3QCSdNxzByPBdrWQS
qVZ+AJs7ZGFhwyaPfJDn7OFi+v3NxzGMWoUsViZLaknqW03laVf6cE0mHlcqA/q0
Ye3ax+qKpo0xj+8//WsNKrbJ/v1vIA==
=ND9r
-----END PGP SIGNATURE-----

--9hvfmm8o325U8VpeThWUicNTF58AjdgqO--
