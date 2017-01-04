Received: from eggs.gnu.org ([2001:4830:134:3::10]:56041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOcvA-0000GC-MJ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOcv7-00022y-G6
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:11:28 -0500
Date: Wed, 4 Jan 2017 14:28:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170104032811.GY12761@umbus.fritz.box>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
	<20170102222831.GB12761@umbus.fritz.box>
	<A1654386-0C53-4C64-BE97-A6804E1AA4F3@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5T9d2Bf7JajBsgKp"
Content-Disposition: inline
In-Reply-To: <A1654386-0C53-4C64-BE97-A6804E1AA4F3@163.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--5T9d2Bf7JajBsgKp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 10:02:21PM +0800, =E8=B5=B5=E5=B0=8F=E5=BC=BA wrote:
> Hi=EF=BC=8Cdavid=EF=BC=9A
>=20
>    To my understanding=EF=BC=8Cwhat must be put in the realize function  =
is
>    code which depends on property values. What's the benefit of
>    moving memory region initialization into realize function?  I can
>    not figure out, can you make some explanations?

If nothing else it's better in realize() for consistency with other
devices.

I'm not familiar enough with the details to be sure, but I also think
it's not safe in instance_init.  Once memory regions are registered,
the device can potentially interact with other devices in the virtual
machine.  realize() is sequenced to expect that, instance_init is not.

>     Thanks for your review.
>=20
> Best wishes =EF=BC=81
>=20
> > =E5=9C=A8 2017=E5=B9=B41=E6=9C=883=E6=97=A5=EF=BC=8C06:28=EF=BC=8CDavid=
 Gibson <david@gibson.dropbear.id.au> =E5=86=99=E9=81=93=EF=BC=9A
> >=20
> >> On Sat, Dec 31, 2016 at 09:18:27AM +0800, xiaoqiang zhao wrote:
> >> This is some QOM'ify work relate with ppc.
> >> See each commit message for details.
> >>=20
> >> xiaoqiang zhao (4):
> >>  hw/gpio: QOM'ify mpc8xxx.c
> >>  hw/ppc: QOM'ify e500.c
> >>  hw/ppc: QOM'ify ppce500_spin.c
> >>  hw/ppc: QOM'ify spapr_vio.c
> >>=20
> >> hw/gpio/mpc8xxx.c     | 20 +++++++++++---------
> >> hw/ppc/e500.c         | 17 ++++-------------
> >> hw/ppc/ppce500_spin.c | 18 ++++++++----------
> >> hw/ppc/spapr_vio.c    |  2 --
> >> 4 files changed, 23 insertions(+), 34 deletions(-)
> >=20
> > Patches 1-3 all have the same problem - they move memory region
> > initialization and similar to an instance_init function.  This is not
> > how things are generally done in the qdev model.  Instead that phase
> > of initialization should be done from a dc->realize() function.
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5T9d2Bf7JajBsgKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbGvJAAoJEGw4ysog2bOS3sIQAISEFuqbNeTsIAAl19P2to4T
h25sDztwDRuEWHWKrzAxBgNCdZ7TR3NVqpMoomBqI6LCxJ6iXUee3Usyp8MIKcO9
nLGI3A6uEhhLokDHES8TPjeqjV5U7G7QykPR8+N4FhwmxoL0OVyYduMOI/gg6w/a
4ssANFP8C/Mv22ofAh2ecPxoMWCMu8q/6QmmT+IO7Blg4U7GPa3rWOyGa+r66EmI
Ke8U+zvq4HMtfqfX3QR3nOfXJpD0PlqdC37KZWwXEUJqJzNE++crIyEKFQN3V0KW
kGFkMAGERpZNBj5FmuGMtWUeCQNByBBC9sX12EheuO6TGMKmXLysnungg6G57kyV
+yr8qP941eYZhJb26o9s1tzOoQ9JM2hEVg4MjLpwvoKtXdH7FuQTAA+vAObrKy/k
migwOVIJCBR3Q9P+XgG/W0C2srmyAW/jCyvQPrNTvu9o2CaDnyPVuNspNwedFVZn
HzeYkit/c9pcyQGY0n7VA7wTMVn12ZP8OaGFm+/8Y3THaqHKh5ChgXKdJ4u2DrmK
3ANh0dL5G5Ra0DvkRZfLmo4J5BQTUJMbg8hQkdHXE77ZfriLQw9rTLGOWVk65p8o
eycCaC8fNIivOV+IJ06flcGko20Bz8BPZw+WAuKSvOFwZ+A8dYxZS3aaE/lWomTR
WZcYkEFOxyjPmLt1FejC
=d4NG
-----END PGP SIGNATURE-----

--5T9d2Bf7JajBsgKp--
