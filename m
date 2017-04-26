Received: from eggs.gnu.org ([2001:4830:134:3::10]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Ddv-0007vS-LO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Ddu-0000Fk-Gh
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d3Ddt-0000DI-GT
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:26 -0400
Date: Wed, 26 Apr 2017 12:43:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170426024321.GL16882@umbus.fritz.box>
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
	<1493103101-25165-3-git-send-email-clg@kaod.org>
	<CAFEAcA9Y0C_byA8KsiMXdzsMDE73ZKmMcQZaMc7uwAF2bZC+hg@mail.gmail.com>
	<d48c2177-ad8e-a820-c640-898075110ee3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Content-Disposition: inline
In-Reply-To: <d48c2177-ad8e-a820-c640-898075110ee3@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] ipmi: don't try to open a NULL filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2017 at 04:06:17PM +0200, C=E9dric Le Goater wrote:
> On 04/25/2017 03:31 PM, Peter Maydell wrote:
> > On 25 April 2017 at 07:51, C=E9dric Le Goater <clg@kaod.org> wrote:
> >> Currenlty, the code relies on the fact that open() handles NULL
> >> filenames but that can cause an error with new clang:
> >>
> >>   hw/core/loader.c:67:15: runtime error: null pointer passed as argume=
nt 1,
> >>   which is declared to never be null
> >=20
> > This isn't "new clang", incidentally, it's just clang with the
> > runtime-static-analysis enabled, which causes warnings to be
> > printed at runtime for undefined behaviours. You can enable
> > this by passing configure --extra-cflags=3D-fsanitize=3Dundefined .
> > (I have clang 3.8.0 here.)
>=20
> OK. So I have now reproduced the issue on a f24. That made be=20
> realize that the IPMI tests check for the arch they are being=20
> run on and that more changes are required for them to run on=20
> ppc64.=20
>=20
> We can drop patch 1/2. Tell me if you want a resend.

No, that's fine.  A patch to enable the tests on ppc properly ASAP
would be great, though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAAlJAAoJEGw4ysog2bOSy2wP/3xSmIo19EzpENTSqVKiFooU
IzYC/+Z+toETdYlcsGzGAY4t2t6hl8RgxUlgIGJbMQ3hnJpx1lX5Gyz60XIH/x8F
yrkNFy5NyMh6/2Fc8mqTWY4hRr9Rx8pcL903Qg8ZYl6ujlhusHaZYTSnb1HULCd+
Soe/KbYL6iSgKH4zymvHgDIXXdyyvn59xPruFuYhhrHDCsCG3fR1ilhHBrLA2VWK
9u4BEY9xF4kR0gVCFW+OZZWiDzPo2S7MK3VFdQOMhCVhLKAMOxbw8V2mfYiAz0Zq
Gg/q0qLGJ5NVqztJ5LL0eG4oifXPirfftYZZ6TLM6MFNXDD6nGHc5YCExWogl0ax
/Er44aQz6RYsAHeUHXLsxh+4CIxLcDh+sqxf7awRsY3AEfplB2U8cioK+v3/VfdI
RN02/A+9bW46LDwjMBbKZh7zD6/FsQISagUL0WjZsX+f9KnJ7I1ln/oHrLROYbVH
+hsPSie2hLV6gHL3E2yNamT7bD3ejXdDcbvN7KSrlXP1/6rJgQu/EWarjpht/KBt
ykBsSvdiJ1wwbQeC0pc4XAvWlsSIeli3O2vFf3NTCRKz+cijP/x1ujR/qoSSwJWs
TR6f4785gn0yZG3mHY4KozKrK0/KDztj/hPcN79ZkoCdpaDHqY46VTYssBvjt0mj
F+jgao/I2NwxeIoj3ZAV
=JaA/
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--
