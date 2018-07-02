Received: from eggs.gnu.org ([2001:4830:134:3::10]:50772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZmSH-0005Bd-KG
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 20:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZmSD-0000vX-Gv
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 20:12:33 -0400
Date: Mon, 2 Jul 2018 10:03:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702000331.GQ3422@umbus.fritz.box>
References: <cover.1530225513.git.balaton@eik.bme.hu>
	<beba73ec147c790500c6a57e405d5c5f83899af1.1530225513.git.balaton@eik.bme.hu>
	<20180629044840.GH3422@umbus.fritz.box>
	<20180629045931.GJ3422@umbus.fritz.box>
	<alpine.BSF.2.21.1806291410520.18342@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QVgWX4+QEldMe/r9"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806291410520.18342@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v6 4/5] ppc440_uc: Basic
 emulation of PPC440 DMA controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Cedric Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--QVgWX4+QEldMe/r9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 02:14:49PM +0200, BALATON Zoltan wrote:
> On Fri, 29 Jun 2018, David Gibson wrote:
> > On Fri, Jun 29, 2018 at 02:48:40PM +1000, David Gibson wrote:
> > > On Fri, Jun 29, 2018 at 12:38:33AM +0200, BALATON Zoltan wrote:
> > > > PPC440 SoCs such as the AMCC 460EX have a DMA controller which is u=
sed
> > > > by AmigaOS on the sam460ex. Implement the parts used by AmigaOS so =
it
> > > > can get further booting on the sam460ex machine.
> > > >=20
> > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > ---
> > > > v6:
> > > > - CamelCase type names
> > > > - Check return value of cpu_physical_memory_map
> > >=20
> > > I don't really have the knowledge to review this, but since it's a new
> > > device that no-one else is using, I've applied it.
> >=20
> > I take that back.  This breaks compile for me with:
> >=20
> >  CC      ppc-softmmu/hw/ppc/ppc440_uc.o
> > /home/dwg/src/qemu/hw/ppc/ppc440_uc.c: In function =E2=80=98dcr_write_d=
ma=E2=80=99:
> > /home/dwg/src/qemu/hw/ppc/ppc440_uc.c:907:35: error: =E2=80=98sidx=E2=
=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitia=
lized]
> >                     int width, i, sidx, didx;
> >                                   ^~~~
> > /home/dwg/src/qemu/hw/ppc/ppc440_uc.c:935:25: error: =E2=80=98didx=E2=
=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitia=
lized]
> >                         cpu_physical_memory_unmap(wptr, wlen, 1, didx);
> >                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > gcc 8.1.1 on Fedora 28.
>=20
> Sorry, this was introduced in v6 when trying to handle return values from
> cpu_physical_memory_map. I've sent a v7 of just this patch that should fix
> this.
>=20
> There was also a 5/5 in this series which is useful even by itself without
> the OpenBIOS patch as it allows MorphOS to get further on sam460ex even if
> it's not booting yet. Just let you know, that it's not tied to the OpenBI=
OS
> change in case this wasn't clear from the commit message.

Right.  I haven't forgotten it, I just hadn't yet found time to
research the change a bit more thorougly.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QVgWX4+QEldMe/r9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5a9AACgkQbDjKyiDZ
s5Ke8RAAxJGry41l929LZD2rLNJmm06JgJRV0PKUO09SeISIOvCT17BCMow0ss8E
ExnjHFKsV3ru+Ff6Xo5tpu3Exog2p4f1FSkKMZ+K553qr3w4xLvyb3zuKEPTDh8h
PxfJPfr+M3aMTsTww3lux9icAZE/WP6PQaLuFjRN+CqofqHBwxoWbklOns+MiAId
5chElUHwzBwisPcuLdwtNjuXpgKuDWL/i1ExNnlYWBQwDsz0NGfrCaWg+k77nM3l
K3BF2kanTr9cWqcK53ioOeWpl9t2e97h3LjlLT4UIyJbCOer0v9Rt46F+RYzaCuZ
YIGP4XiwDZRQQfrkLuySacIUgkdMVgTcYGtTUPtqHX0cwKyjxstfT1GY/EXS5WzM
K6SAEaavM1d2wzCOjbe0gXAsPiYElW5EyIFZ3vmlH3RymoooHifdrjobE1mEJfUy
ZzNG7yxiKiMPSyKtZUXt3USb1pQ7tUctA8O7BuZSlInzD3xUkFVhLOOXJDLhFZKB
AdWSQQicNkgkV2GsOYcaHYpVCB8CwOxyrz3xvXZwgZB9i2IRaxHUsiwneIzPFxUC
5NM7+o6PjrF5izZZVzlNJ8PWZJRAGbDil64ELdlGPVDZfm0T467AfaWOzQkWJHcB
l+pQXQ4SumPAdo+OPAkLVKBgWDd5L6UQ4guhoYw+AsNXnKeX2hM=
=Ayzy
-----END PGP SIGNATURE-----

--QVgWX4+QEldMe/r9--
