Received: from eggs.gnu.org ([2001:4830:134:3::10]:42915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZaEX-00015S-5c
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZaEW-000786-34
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:05:01 -0400
Date: Mon, 24 Jul 2017 19:50:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724095052.GO17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7KxW38SoMauyveo"
Content-Disposition: inline
In-Reply-To: <1500879657.10674.64.camel@kernel.crashing.org>
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


--i7KxW38SoMauyveo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 05:00:57PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2017-07-24 at 14:36 +1000, David Gibson wrote:
> > On Wed, Jul 05, 2017 at 07:13:21PM +0200, C=E9dric Le Goater wrote:
> > > These flags define some characteristics of the source :
> > >=20
> > >  - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with a
> > >                        specific hcall H_INT_ESB
> >=20
> > What's the other option?
>=20
> Direct MMIO access. Normally all interrupts use normal MMIOs,
> each interrupts has an associated MMIO page with special MMIOs
> to control the source state (PQ bits). This is something I added
> to the PAPR spec (and the OPAL <-> Linux interface) to allow firmware
> to work around broken HW (which happens on some P9 versions).

Ok.. and that's something that can be decided at runtime?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i7KxW38SoMauyveo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1wvoACgkQbDjKyiDZ
s5JXHhAAyrRvU6SWkJK406OqCB0JvqKoOVVWiv4+8Mr8rEngKaSNIA65gbbP7c8D
c2RVqgRZ/7XOI2S+BMrxLZj0qFOuStVcuRrKV+xnWwc/BL0UfhHPsZBSPOcI5vHY
Qq3kcecocePOUNUzjfggAvUwKPbD76oXu8LWy6c0LvGapiUDMEo3zkxDb9jOFzu7
Jgp3Y1Kv5NjmDpBuvoaRCseSYjaGmv12C081sz9BLCgZJdUpr9fNtAUcuVzr5l/Q
Nh37buz17YuF8jLsLO/aSwT8a5IWdseC80POWIjdVAqjasqc+iwnQumdSeLqGv8j
a82OZHxoCOjdsYcpBMurC9N0eBKzbIuNHqB5kqmjwBMUh1j5FOq+l6pit0fosKQz
uBzDzkf/mI0/wtDyxXyR4kwTcBWWEkHGAEpZlRG5Wiyv9rG+WYQlzrVgZzFVnfbp
2xrDQZaaHCiB05CHmE4b7+yU8B3VvoggIwmVHDcXvp/4fGB/vzQXSanZuPsh8cYP
44Xacpi17yRrGRPXnHo7tf4p7TDufyJNGX7PElDL0OAyNLYlQp0H1E6LI4lzk+/8
dy4DPm6vq6CkDbmdr+reLuOf+7ETCmYucSQdIPAOdEZtz1RGAY4RjNgIwmEYyrwL
qFrmVa2drF/5cncbgOcKGT9w6L1c4s+jERd+HJ6KbButP8f5cI0=
=715D
-----END PGP SIGNATURE-----

--i7KxW38SoMauyveo--
