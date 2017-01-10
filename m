Received: from eggs.gnu.org ([2001:4830:134:3::10]:40285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQmyI-0002Si-Gx
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQmyF-0004O9-6a
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:38 -0500
Date: Tue, 10 Jan 2017 11:28:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170110002837.GK12515@umbus.fritz.box>
References: <1483802623-5507-1-git-send-email-hpoussin@reactos.org>
	<317d34e8-a3fa-2748-1245-3f8555d0738b@tuxfamily.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Content-Disposition: inline
In-Reply-To: <317d34e8-a3fa-2748-1245-3f8555d0738b@tuxfamily.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 0/4] ppc: add a IBM 40p
 machine (RS/6000, PReP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, Giancarlo Teodori <gteodori@gmail.com>, qemu-ppc@nongnu.org


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 08:43:47AM +0100, Thomas Huth wrote:
> On 07.01.2017 16:23, Herv=E9 Poussineau wrote:
> > Hi,
> >=20
> > This patchset adds the emulation of the IBM RS/6000 7020 (40p). The rea=
l machine is
> > able to run AIX (up to 4.3.3), Windows NT (up to 4.0 SP1), the beta of =
OS/2 PowerPC,
> > Solaris, Linux, NetBSD/PReP ...
> >=20
> > I've tested current emulation with Open Hack'Ware, OpenBIOS and officia=
l firmware.
> >=20
> > Linux kernel starts, and freezes during boot (seems like a problem with=
 the SCSI adapter).
> > Windows NT starts up to the point where it wants to change endianness.
> > Other OSes have not been tested.
> >=20
> > This machine is a superset of the 'prep' one, because we know exactly w=
hat is/should
> > emulated, and that operating system list running on it is quite wide.
> > I hope that 'prep' machine can be deprecated soon and then later remove=
d.
> >=20
> > Patch 1 is a cleanup, and can probably be committed first.
> > Patches 2 to 4  are the real implementation of the IBM 40p.
> >=20
> > Changes since v2:
> > - patch 2: fix mismatch between read and write functions for port 92
> > - patch 4: use error_report instead of fprintf/hw_error
> >=20
> > Changes since v1:
> > - removed patches related to display adapter:
> >   Let's wait for an emulation of the real display adapter (an S3 Trio),=
 as current
> >   VGA adapter already mostly works with Open Hack'Ware and OpenBIOS
> > - various changes due to David Gibson's remarks
> >=20
> > Herv=E9 Poussineau (4):
> >   prep: do not use global variable to access nvram
> >   prep: add PReP System I/O
> >   prep: add IBM RS/6000 7020 (40p) memory controller
> >   prep: add IBM RS/6000 7020 (40p) machine emulation
> >=20
> >  default-configs/ppc-softmmu.mak |   2 +
> >  hw/ppc/Makefile.objs            |   2 +
> >  hw/ppc/prep.c                   | 233 +++++++++++++++++++++++++++++-
> >  hw/ppc/prep_systemio.c          | 303 ++++++++++++++++++++++++++++++++=
++++++++
> >  hw/ppc/rs6000_mc.c              | 232 ++++++++++++++++++++++++++++++
> >  hw/ppc/trace-events             |  11 ++
> >  6 files changed, 781 insertions(+), 2 deletions(-)
> >  create mode 100644 hw/ppc/prep_systemio.c
> >  create mode 100644 hw/ppc/rs6000_mc.c
>=20
> By the way, the PReP machine currently does not have a proper maintainer
> according to the MAINTAINERS file ... would you maybe volunteer to do
> that job? If so, could you please send a patch for the MAINTAINERS file?

Yes, that would be much appreciated.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdCq1AAoJEGw4ysog2bOS4LYP/1Lfos7rSIi23kjy0aQQz48c
ev30rAmSBymTrXZVlKWu0yMX1gC/1W9diikicS+f6p0zK1ev8DzZXHmX3oYYPIxM
lyBdd+NUHq4AtVKj+Q6t1xtDeDg00ZARcSfTK15Kp/6inDZIYZrly43lOm82ezzp
crCYyA/AQmvOO2yIo38PPpPthMdpGPNNSeOYIYklbJLeroAcYezG2YZkNn8FhGyP
Dl5n/prwVe9QH9VQmRZwKjdu9PQqM2aV0wHUk180yisEfHjHjzrZ380asv6+Xoo9
asNi6e2h/sC+mkFs1Ta42hylkzWwxAfZzvvxiVPFQZwFHrEBZCoYzUG196Y5vfQF
eACMFACG2I70tKz6lQn6ykSd0+0HZFdRxEFncHxuVUs99XYtvm6+keRO4AyiQdyu
pULc7WdD+0stdOskU1jGwgtYPaZpovPfL9D7ldNzITXHB/OJQ5ogg2SD6k6dNWHR
NE1j1BOxxfPYoQYfi2bJho6oD4uKV3tRGTjHB9xMDdhRL0BMLvf5MMb4yocLavew
7QkEBq+9ueR2kz46dvuMlHymxWF5W24mDa19UJT0Ou1Upv1TxXQzFZeE9VtaUajA
iuDrCtA+/yImEAgKTWpWv3QY8SZPyX3O31KVmrADTjDi+aMsjaAxYGgnEttVVwM9
0cYxcQ37fJ5UU+r0ka1P
=v1sR
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
