Received: from eggs.gnu.org ([2001:4830:134:3::10]:39700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZzmQ-0004ng-KT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZzmP-0005tN-GE
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:42 -0400
Date: Tue, 25 Jul 2017 22:24:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725122406.GF8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
	<1500894439.10674.76.camel@kernel.crashing.org>
	<20170725041841.GA8978@umbus.fritz.box>
	<1500961657.10674.105.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <1500961657.10674.105.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 03:47:37PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-07-25 at 14:18 +1000, David Gibson wrote:
> > > Well, at this point I think nothing will set that flag.... It's there
> > > for workaround around HW bugs on some chips. At least in full emu it
> > > shouldn't happen unless we try to emulate those bugs. Hopefully direct
> > > MMIO will just work.
> >=20
> > Hm.  That doesn't seem like a good match for a per-irq state
> > structure.
>=20
> The flag is returned to the guest on a per-IRQ basis, so are the LSI
> etc... flags, but at the HW level, indeed, they correspond to
> attributes of blocks of interrupts.
>=20
> It might be easier in qemu to keep that in the per-source flags
> though.

Yeah, I think so.

> Especially when we start having actual HW interrupts under the
> hood with KVM. it's easier to keep the state self contained
> for each of them.
>=20
> Ben.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll3OGYACgkQbDjKyiDZ
s5JihhAAu+TLuSxbQ98veE9x2TvuNr2er4Ph67e7Sg1zZ3hXgA/WoYYb3IFmbzpQ
/77ON0OHz9QqVroPcQuoYYyafdZe1jVjBh33JhnYydJDspIaZ7ejinq1s49rQyS5
joCUZn+ck/B2rz1vcx9nCuwTRmZjhj3ho8V7+ANmLpaoXGQSIWNFfQ9VUXz1yTzI
wHho8md+ecxtgOJ0CDaJu+ucu/zP8mycnbhqzadzVVwjXHTsuidpBQUQ5JLX6YT5
ikiW9WqiJ+wI/1OAre+UY7wjYRcOWk8K4p7GDDNFkqGFK8ipYJv0MIh81l3ckTb3
TNNCFcarLQMShd+7UEAh6yM8SIBn8MqB1pEKd7S5yZ4bocoTHu2mIJsI74cIQyl9
MqIUDlLsY8mo3Thl7yHLS7MvyB6fea/ZIjR8aXdmAGhGgnd7J89MvnhRoU1/p3ak
Qlpaye3crF0Zi6VplcZ6zicoigcQh5uT+uZkpZNhQ4TNbPvwi0HjSTzzDhMLvdc2
l8/6ziQ7HSaZxRS+NOGPEuXHGQs8kqxGu+7qhHvXSffmOy/F0a5kvQHYPWl/gh5p
Co6EqyZySqnqvVOKRh7+UQt0DWaUfe9SDum04p+vQ2HNV/XjUq6cmgWeckZL5NvO
sVqVfIvZWBN422LbbixdagoqElwFvHq10cVL6AY7ikC5IPvRDTQ=
=ZBr/
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
