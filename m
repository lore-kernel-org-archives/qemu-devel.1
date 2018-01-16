Received: from eggs.gnu.org ([2001:4830:134:3::10]:48259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eba4B-0002ht-AE
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eba47-0001tu-4D
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:50:51 -0500
Date: Wed, 17 Jan 2018 09:34:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116223413.GQ30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xiprIVX1FSGBv8kC"
Content-Disposition: inline
In-Reply-To: <1516113980.3278.1.camel@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc:
 Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, paulus@ozlabs.org, qemu-devel@nongnu.org


--xiprIVX1FSGBv8kC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 03:46:20PM +0100, Andrea Bolognani wrote:
> On Wed, 2018-01-17 at 00:54 +1100, David Gibson wrote:
> > > Correct me if I'm wrong, but it seems to me like there's no way
> > > to figure out through QMP whether these new machine options can be
> > > used for a given QEMU binary.
> >=20
> > Uh, I don't think so.  These are machine options like any other (just
> > constructed a bit differently).  So they'll appear in qemu -machine
> > pseries,? and I believe that info can also be retrieved with QMP.
>=20
> Yes, they will indeed show up in the output of -machine pseries,?
> but there's AFAICT no way to retrieve them via QMP.

Really!?  I thought introspecting object properties was QMP's bread
and butter.

> And libvirt
> can't afford to spawn a QEMU process for each machine type
> implemented by each QEMU binary installed on the system just to
> figure out what properties they support; in fact, we've been
> pushing away from that approach - which was used initially - for
> years and we're now at the point where we only fall back to it
> for positively ancient QEMU versions. So the information needs
> to be available through QMP for libvirt to consume it.

Right, I'm not arguing with that.  It's just that I thought that
standard QOM properties on QOM objects (the machine in this case) met
the criteria.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xiprIVX1FSGBv8kC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpefeMACgkQbDjKyiDZ
s5Jisg/8DYApk6NE17hXtPvSIGl3vKptktdYywN44//9VuVgIRbISGbvHdP0pUxY
e7qBrxmis/e1ISndWqBr0l+r0ZOqw8q09HoA/v77lsc5azvQ9bqT4TGGoqgZ3J/O
OC2pfUNn3Y45VF87P50oUbYVGFOU8Xfzos8epMMT5+rxD08AvIWCAA1MSMOxe4En
ON8a7UuNv61UdAGhCMJ2g2UeWH2ZhstVSIXaXaJU8g/njz9Nw1W2MS9uJjxMBjuT
yVsIfRyXThFhjUVk5lsrBCs/ATNxGyIQYuM88tu0B9wNIOh1WgZU+qC17XiQ5eCA
4X2JaUtK0iwoMPPYlUlyHD3jObBBLl1Ta/AwPky9MADy8EpH5O/asYuAePsCOO3S
S2f4yQtzPbcJwcOistAcEAEefI3wMajnmKVb3+UZUZpgGrs2ACm6za48QeKgjxQM
qr2TzWCHE+W50m1jA274x0IJcp190TGR3u0WgQp6p7mV3hwMSSiC4lg6tXOok1Vj
+TzDk1MwZNlaHlRy7Zz5VdAYwNG97ch3Ek0BCKljwAVazSUJoKU8FEcgR2ROVyBU
/DJtMO1ldavEHoOSFJvvvgTgXO3xIn/Th5ywYhmHIAny3JVY44QiWUeo8e9txDjM
+EhU+s7vzl5E/MfW9KJ5WX213IOSXhn2PwUC7Fs2PxA9Tz1ioM0=
=kyaO
-----END PGP SIGNATURE-----

--xiprIVX1FSGBv8kC--
