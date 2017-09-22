Received: from eggs.gnu.org ([2001:4830:134:3::10]:37844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLzr-0004i8-D3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLzo-0007DZ-6W
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:19:51 -0400
Date: Fri, 22 Sep 2017 20:58:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922105855.GO4998@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-10-clg@kaod.org>
	<20170919073615.GN27153@umbus>
	<52f31e9e-f7de-ae27-a8a6-bd2f37666659@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ck22u5fw4m2k6hx2"
Content-Disposition: inline
In-Reply-To: <52f31e9e-f7de-ae27-a8a6-bd2f37666659@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/21] ppc/xive: extend the
 interrupt presenter model for XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--Ck22u5fw4m2k6hx2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 09:28:45PM +0200, C=E9dric Le Goater wrote:
> On 09/19/2017 09:36 AM, David Gibson wrote:
> > On Mon, Sep 11, 2017 at 07:12:23PM +0200, C=E9dric Le Goater wrote:
> >> The XIVE interrupt presenter exposes a set of Thread Interrupt
> >> Management Areas, also called rings, one per different level of
> >> privilege (four in all). This area is used to handle priority
> >> management and interrupt acknowledgment among other things.
> >>
> >> We extend the ICPState object with a cache of the register data for
> >> XIVE. The integration with the sPAPR machine is much easier and we
> >> need a common framework to switch from one controller model to
> >> another: XICS <-> XIVE.
> >=20
> > This sounds like an even worse idea than referencing the ICS state.
>=20
> ok ok.
>=20
> > The TIMA really needs to be managed by a different object than the ICP.
>=20
> like an array under the machine indexed by the cpu index ?=20

Or individual TIMA objects which the cpus point to using their intc
pointers.

> at some point, we will need to :
>=20
>     PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>     ICPState *icp =3D ICP(cpu->intc);
>=20
> and=20
>=20
>     icp =3D xics_icp_get(xive->ics->xics, target);
>=20
>=20
> isn't the cpu->intc pointer  the best option to hold that information ?=
=20
> and it is migrated.

No, it shouldn't be migrated.  It's set up during machine construction.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ck22u5fw4m2k6hx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE7O4ACgkQbDjKyiDZ
s5IY4g/6AjhDUCm0NYojde2zyHBjy2TYnjfw8hiFXvfoNoQ/IHs7oAtyxXgECR6z
Xw6jszdOhOX09qButdcp9e+3o53UcIzVfEZRxOgq4RhdFqzfbH81m2/XobFiaAHf
0+glyJMyMerTtSho3ZyJ2+oCLqbJC3Wg82rzaUlEgvgKme5uGJh99WMQubAgNvKk
FWIaZC9ZXZnxmP1WStC4NYa1FCj/N6hYYdAbLgvO+LWDwVl9EqIowa73/75ZYtRa
TNOl4Q0hivv2pMYFyyKk6YtPVxMDyX1Z1RgmIwwDcfGpEP3s2bBLb03ZYq59DC13
UnNxnUYp7t5lzx0Zsga4nX/AilCUC+7hBoyC7d6VZBPdOcKA2NiSetT9EKNdHTt+
KOr2piqg+0HYVVBH4uyiuxaRVwwtVDWBhzhXcfjugGUScd6X6EAR2yMc6t+RSNV+
kk8hJMFda4CRDa1iAub5s6d9/lSyacL20EwsSfUMC6iIxsM3jaDR0D17TpoJ3I1P
bhzT1NHq1ImrSyChuLV78ZoGINqxTIAPFiW0xnivuaNFLSYmSrsPG0B4DqlW2W3r
6jlYL6/Psglmo7Uda0M5GirO9U+jB9+04SdMxPNW11ufvhgux3XwLtH7/ci8fkt3
Qqf0l4yOchSV8ulzrsZqpbDZuMJlOYKp5ENP+/zWIvDRblnYzcI=
=9L9y
-----END PGP SIGNATURE-----

--Ck22u5fw4m2k6hx2--
