Received: from eggs.gnu.org ([2001:4830:134:3::10]:39298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f67ES-00041y-Dc
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 00:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f67ER-00065F-BI
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 00:19:40 -0400
Date: Wed, 11 Apr 2018 14:15:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180411041553.GA2124@umbus.fritz.box>
References: <20180409062538.1095-1-bharata@linux.vnet.ibm.com>
	<20180410030245.GF3361@umbus.fritz.box>
	<0344e7f6-2861-7a13-6510-19d63c01d96a@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <0344e7f6-2861-7a13-6510-19d63c01d96a@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH v2] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 01:56:14PM +1000, Alexey Kardashevskiy wrote:
1;5002;0c> On 10/4/18 1:02 pm, David Gibson wrote:
> > On Mon, Apr 09, 2018 at 11:55:38AM +0530, Bharata B Rao wrote:
> >> The new property ibm,dynamic-memory-v2 allows memory to be represented
> >> in a more compact manner in device tree.
> >=20
> > I still need to look at this in more detail, but to start with:
> > what's the rationale for this new format?
> >=20
> > It's more compact, but why do we care?  The embedded people always
> > whinge about the size of the deivce tree, but I didn't think that was
> > really a concern with PAPR.
>=20
>=20
> Well, booting a guest with 500 pci devices (let's say emulated e1000 or
> virtio-net) creates >20sec delay in the guest while it is fetching the
> device tree in early setup, property by property, I even have a patch for
> pseries guest to get FDT as a whole blob from SLOF. It is not The Problem
> but still annoying.

Right, but 500 PCI devices is not this case.  Sounds like the slowness
there is mostly from having lots of nodes and properties and therefore
lots of individual OF calls.  The old dynamic memory format is still
just one big property, so it shouldn't have nearly the same impact.

Besides, Bharata pretty much convinced me already with his other reasons.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrNi/cACgkQbDjKyiDZ
s5IHlxAA2MAwg39+oVLf/JqcFM3BZSb8VeT+BKzz8WVmMUlxo7cE/dAwAllr41QH
IzH1P2K1wFw18v9UNKwunh6qkznlI+dpVhNefQvJ1WuWYsad2gw2itYGVKP/RkPr
RXWaScSOWpf/h2ScMjXvFQpTAENvAcr3P8bADSCtrdLldc5LdfuRKpU6UVEQg6O9
VpTIFm6S5+xdi0y8p/CVIhus0JBdM5rwf0m6/oYY311OLyUEbGS6k52wllxwqv+Q
Qu1Zj/SMHhH2BFK2PYLqB2RkHQj146s6CzZ/bSHgw2wnPs6fNuef1poPbQAgIEjz
fNx4BF+75wqUaQrw//XAfR3ahJfYC0VviJ0K8qBER2ZwzunDM3lRef0pqifkGDf1
VXpJD8mrrmI7L3+PFqhJUIDne+3987biXQYdPmUogdvTL2eLams/s5udC412v7CY
egxAkbwynNyd1ubBzRI/Ak99LVM7r5nw4gl9ochCineD3V+WSfCdjx4Tz0I3yP0/
TAN+ny9d8kadF5CbpzS0HCGxpg/OrUaDD1qQ8ejZJ8mNlaMUvsuHYyWzcTr6q+S3
PNawlQ55dgqj1RX4it2F+++S7lzLpVRGBvc635q4rLJLt/xAAHi9KeJ7Bgk02ZSc
oeIp3Y+cw8WMTS8dNQhvw8ZZ8ue4n7ONJQVq0AvpHLi72mzdukI=
=ryx3
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
