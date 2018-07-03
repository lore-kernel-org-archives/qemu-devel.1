Received: from eggs.gnu.org ([2001:4830:134:3::10]:56372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fa9BH-00085s-Q0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fa9BG-0001wN-OI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:28:31 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fa9BF-0001ro-LX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:28:30 -0400
Date: Tue, 3 Jul 2018 10:28:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180703002815.GF3422@umbus.fritz.box>
References: <cover.1530047900.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1806302231400.45338@zero.eik.bme.hu>
	<CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="py13wRIzy9nU46ee"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ymngY5i5BWQ6-xAveCWjs0QKrORSAy9nH1A8m9672Fg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>


--py13wRIzy9nU46ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 10:42:07AM +0100, Peter Maydell wrote:
> On 30 June 2018 at 21:34, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > On Tue, 26 Jun 2018, BALATON Zoltan wrote:
> >>
> >> Version 2 of the sm501 changes with fixes that are needed to get
> >> AmigaOS 4.1FE to boot and able to produce graphics.
> >>
> >> The strange blue-white colors that first appear are actually correct
> >> and because of AmigaOS selecting a low resolution PAL mode by default
> >> instead of a board specific mode. To work around this one can select
> >> the last option to boot the live CD and then select a better board
> >> specific mode from ScreenMode Prefs. It takes a while for the
> >> ScreenMode window to appear and graphics operations are slow which
> >> could use some improvement but at least it seems to work correctly now
> >> apart from some unimplemented drawing modes for compositing.
> >>
> >> If this could be merged before the freeze with the sam460ex patches
> >> and Sebastian's ehci patch then QEMU 3.0 could be the first version
> >> that can boot AmigaOS.
> >
> >
> > Ping? Sorry to push it but it would be great if this could get in for 3=
=2E0.
> > Peter, this may need your attention like last time as it's not clear wh=
ose
> > tree it should go through and David did not seem to be confident taking=
 it
> > via the ppc tree.
>=20
> I can have a look, but really I think these should go via the
> ppc tree -- the device is used in a ppc machine and an sh4 one,
> and the ppc tree is much more active than sh4.

Hm, well, if you like.  Although the gradual creep of my
maintainership scope into things I know less and less about makes me
rather nervous.  I tried to convince Balaton Zoltan to become sm501
maintainer, but he didn't bite.

Zoltan, I'm sorry I haven't been following this series closely since I
asked you to direct it to Peter.  If you resend to me, with whatever
accumulated reviews you have, I'll merge it via the ppc tree.  It
won't make the soft freeze, but seems we have a quorum to consider it
close enough to a bug fix, so we should be able to squeeze it in
before the hard freeze.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--py13wRIzy9nU46ee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls6wx4ACgkQbDjKyiDZ
s5IAthAAkUCh9zD6AO2rrZQfQyEBr8ScX9jNG1luIlUrXwMx4gKxHAYqOjpibLYe
PyEgHY2ukDP2MQKWLzIv+vfJi5HsQDqcUcjyfMPD1zT2BTEEG/3YyWT/CWE//OwU
5wmv28LW5WXZOnYDbgGwEsS/KKlpNWY9xYerEwGeMQLJruduolBrDMKnnNmGbY3q
0CBPAKo25WgsBN7pJ3zVtvvP/DoVw60lHn5VrlLXBjbkJSWfVjiro1c4kW6y8gZG
uq+Y4S5bvgr15XxHY2yCZd5t4lY8FoNPzMMVVeeANwymcoq/PJUDk4nTFtt8hjWZ
QZDxsz6l6jNX7gi6h9uCh9qt4iLFeI+UIfi6VQY4lpPmjb97S5PwCxwg549H/nka
sr+EjPkjKr8WshwfypCalIsymBcl3UEOEK7kbQAy/fJDEKgeZpgZId9YLKeUboru
7RcWjNJjLy90AZ2Ihcpb1G9KcrE7iD8TNnfyqf6rll3csvazBD5SDDogtpEMfiwF
E2LfpJ8oC6MLBRB95/w8okeGC0+rF2deyxke17+a+KeKy5xR+V00meQrkBwQFE0M
l5iAcDnh+rRD8dMEbFAJyt/VzUR00qz8sZ2frS6hRBxlyUiHld/z8Tkp5sTuO6Yo
R4gRKFLJP3+9BoIO5D7d/dcwxmBUstvsdovslAaD0x1yEko7tPs=
=wDjC
-----END PGP SIGNATURE-----

--py13wRIzy9nU46ee--
