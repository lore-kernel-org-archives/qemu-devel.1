Received: from eggs.gnu.org ([2001:4830:134:3::10]:54164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRTC2-0004V1-W2
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 19:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRTC1-0005Cb-Qq
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 19:24:38 -0500
Date: Thu, 12 Jan 2017 10:18:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170111231849.GB14026@umbus.fritz.box>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<CACXAS8AGTGJ-3yEzf9gzOmfRfppL2REmTyB2SAkb3Nd8eyVYig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <CACXAS8AGTGJ-3yEzf9gzOmfRfppL2REmTyB2SAkb3Nd8eyVYig@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] ppc: add a IBM 40p machine (RS/6000,
 PReP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel <qemu-devel@nongnu.org>, Giancarlo Teodori <gteodori@gmail.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2017 at 05:58:40PM +0100, Artyom Tarasenko wrote:
> Hi Herv=E9,
>=20
> nice work!
>=20
> On Thu, Dec 29, 2016 at 11:12 PM, Herv=E9 Poussineau <hpoussin@reactos.or=
g> wrote:
> > Hi,
> >
> > This patchset adds the emulation of the IBM RS/6000 7020 (40p). The rea=
l machine is
> > able to run AIX (up to 4.3.3), Windows NT (up to 4.0 SP1), the beta of =
OS/2 PowerPC,
> > Solaris, Linux, NetBSD/PReP ...
> >
> > I've tested current emulation with Open Hack'Ware, OpenBIOS and officia=
l firmware.
> >
> > Linux kernel starts, and freezes during boot (like with 'prep' machine).
>=20
> If prep can't do it anymore, it looks like a regression. I definitely
> remember seen a sitting penguin and a login prompt ~ 2 years ago. At
> least with OFW.
>=20
> > Windows NT starts up to the point where it wants to change endianness.
>=20
> I hit that with Solaris/PPC a few years back as you published your
> previous attempt. Do you know what is missing? I guess CPU endianness
> switch emulation is working because it is used in the newer POWER
> CPUs. Is it just the systemIO which has to be improved, or is it more?

It could be the system peripherals.  On the other hand, I think the
endian switch mechanism is a bit different on those older CPUs
compared to the new ones which PAPR uses, so it's possible that's not
properly implemented.

> > Other OSes have not been tested.
> >
> > This machine is a superset of the 'prep' one, because we know exactly w=
hat is/should
> > emulated, and that operating system list running on it is quite wide.
> > I hope that 'prep' machine can be deprecated soon and then later remove=
d.
>=20
> Would be nice to keep 'prep' until the 40p can boot Linux and NetBSD
> 6.1.3 (this version used to work with -M prep last time I checked).
>=20
> Artyom
>=20
> > Patches 1 to 3 are cleanups, and can probably be committed first.
> > Patches 4 to 6 are the real implementation of the IBM 40p.
> >
> > Herv=E9 Poussineau (6):
> >   pci: add pci_vga_type(), giving the device name of the chosen VGA
> >     device
> >   vga: increase priority of 0xa0000 memory region
> >   prep: do not use global variable to access nvram
> >   prep: QOM'ify System I/O
> >   prep: add IBM RS/6000 7020 (40p) memory controller
> >   prep: add IBM RS/6000 7020 (40p) machine emulation
> >
> >  default-configs/ppc-softmmu.mak |   2 +
> >  hw/display/vga.c                |   2 +-
> >  hw/pci/pci.c                    |  22 ++-
> >  hw/ppc/Makefile.objs            |   2 +
> >  hw/ppc/prep.c                   | 235 ++++++++++++++++++++++++++++++-
> >  hw/ppc/prep_systemio.c          | 302 ++++++++++++++++++++++++++++++++=
++++++++
> >  hw/ppc/rs6000_mc.c              | 232 ++++++++++++++++++++++++++++++
> >  hw/ppc/trace-events             |  11 ++
> >  include/hw/pci/pci.h            |   1 +
> >  9 files changed, 800 insertions(+), 9 deletions(-)
> >  create mode 100644 hw/ppc/prep_systemio.c
> >  create mode 100644 hw/ppc/rs6000_mc.c
> >
> >
> >
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdr1XAAoJEGw4ysog2bOSEVEP/1lEsdl2fPpTZ8nVz66X7VvB
cECvO7DPCCHbrPUCE6msXaMBe3S9riwgu3Ee/BMZUr+F5v7C/DnDAj077NY7Ce9+
8soiXe9Us4n5wAfOjFN8gFgrFQ5vziwNpJMpyWtNpUI6q46yuyNsWV4mu1wOQ60m
DkzN1fvm0S8oRHdWvcEnSTwbc2vRcdOJszIzzTHkUO9fH2TUVm2Uym0fICc+t1So
JoQ89NENA5hJ4dMs4kUCdxR5xbcT3nl/kf+dt8qKaD/8M6UmsuACC7sMQ70nylBx
C3+jYQ4j7o5OPB0ASCr1extze5QLs7kRbBl7QWIcA/liWo2jZZibhRkRTsf6dkb0
0of30mBhTmPGSrTNwOVDeR9YQS+IcNHJnfgbPKNprxq7KbFslsQHjwf/lo7aDuuc
vV/5/NdR9I1UFSIfBf377qk2u5TwAGg8u9Rm2GkP6XoHtrLH5htbKm9oayA2o47G
0umSS9QGqugiaxk7hfnPgVeXTclz1/jU6HZGVhxE/1G/jgAgVMN5aMHmNecVNb1h
UnRT3RCGFeQBZwworafymYRbFffmUxnGmxK+RlmrBwrYhCHYHV2243AUqVdUEa2W
9GPB7txFgJ4/pMNyRKR6JfAVewZe+G1Do3KEDhjnLw54wThZfjIY1R05+qZS9qua
M1ANZTAcTJhTdG5AUbfb
=CDAe
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
