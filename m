Received: from eggs.gnu.org ([2001:4830:134:3::10]:60158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eSKQ9-0006yN-SL
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eSKQ7-0005Rx-29
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:19:17 -0500
Date: Fri, 22 Dec 2017 21:09:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171222100911.GC26042@umbus.fritz.box>
References: <20171221165456.8609-1-clg@kaod.org>
	<20171222003906.GA26042@umbus.fritz.box>
	<edb67b7f-7592-d21c-901a-1d4671903d65@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <edb67b7f-7592-d21c-901a-1d4671903d65@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: more use of the PPC_*() macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2017 at 08:01:41AM +0100, C=E9dric Le Goater wrote:
> On 12/22/2017 01:39 AM, David Gibson wrote:
> > On Thu, Dec 21, 2017 at 05:54:56PM +0100, C=E9dric Le Goater wrote:
> >> Also introduce utilities to manipulate bitmasks (originaly from OPAL)
> >> which be will be used in the model of the XIVE interrupt controller.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Applied to ppc-for-2.12, thanks.  Unfortunately getting my tree pulled
> > is held up because something is breaking on arm.
>=20
> yes. I saw. I gave it a try on ppc64,pp64el,x86-64 hosts and didn't=20
> see anything wrong. I also have a raspberrypi3. Would that be a good=20
> candidate ?

No idea.  I tried on a RasPi 1 and a couple of other arms I borrowed.
Haven't managed to reproduce.  I'm now suspecting it's something to do
with the distro/library versions on Peter Maydell's system rather than
anything particularly to do with ARM.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo82cQACgkQbDjKyiDZ
s5K4lg/+OY9QXiKtFp4TqXmIbcgEio9KtUnJd7KAb4IV4nKvS55rEkqzG5ARRPW/
GKg+QEVlAejKPjCai2KChwspWOGMjxVOipZr9a8ToantTzFlbXOWcwEOgB7bS0Rn
Mck+8AsMFPFC+JOo8mtzsmL4uxm8cBiEezCqqslVbwPZjvcALwV4Ra+X3v4bOgRt
gAOF1XRYlCVDAvdKemG8YR4h2uxCwpHdDeR/+NZixYFlZ1zyPhKTMbuiDEyyjFqm
wL13eMVWXeHDusH33vRFqVZP5Cc9SIFaebgi7cbMatJsH/aZ5DWCLXM4EpE0fSgg
jCvLOqmCQU6aDKiCk8R+g+mV3Sy8JdV9qtjFzdCQ3+JjaPFNVDfPSE06KixeVkUx
qeXSR3A5m+tPdef5pd4F0GckfSvSX6gTJ5JaPAG9cSacwOmNyBqWEpJoL23J7roY
f+qTaiYM+2R77g2jzIvViPAvr+sjLupdpevISU4TDUpukLBBcKoppnEuUcBOYan6
nwAIqLaa5n9+LqwkPQz5lSnIU2VEwfuWNX7+8l7E6dKW1oszmHFGqeRKJDjzxwcb
apLI2lwFtIn3Sos0FSbjtWU8nJ/qww45YoE08ZCCsHhgMlSFDLuhsT7cA09VvfbS
EvpbjUS12QCSatJEWc5eYzOMu4zuP0iAlln8XfJitl/92zlOQGE=
=uWP5
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
