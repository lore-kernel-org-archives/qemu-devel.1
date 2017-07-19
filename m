Received: from eggs.gnu.org ([2001:4830:134:3::10]:60934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXgBp-0003LG-JG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXgBo-00010W-4T
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:02:21 -0400
Date: Wed, 19 Jul 2017 14:01:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170719040150.GU3140@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436617.3350.9.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B0+HW0pjZ+2jqF7e"
Content-Disposition: inline
In-Reply-To: <1500436617.3350.9.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
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


--B0+HW0pjZ+2jqF7e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 01:56:57PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2017-07-19 at 13:08 +1000, David Gibson wrote:
> > On Wed, Jul 05, 2017 at 07:13:17PM +0200, C=E9dric Le Goater wrote:
> > > Let's provide an empty shell for the XIVE controller model with a
> > > couple of attributes for the IRQ number allocator. The latter is
> > > largely inspired by OPAL which allocates IPI IRQ numbers from the
> > > bottom of the IRQ number space and allocates the HW IRQ numbers from
> > > the top.
> > >=20
> > > The number of IPIs is simply deduced from the max number of CPUs the
> > > guest supports and we provision a arbitrary number of HW irqs.
> > >=20
> > > The XIVE object is kept private because it will hold internal tables
> > > which do not need to be exposed to sPAPR.
>=20
> It does have an MMIO presence though... more than one even. There's the
> TIMA (per-HW thread control area) and there's the per-interrupt MMIO
> space which are exposed to the guest. There's also the per-queue
> MMIO control area too.

Ok.  Always?  Or just on powernv?

If it only has an MMIO presence on powernv, then the "core" xive
object should probably be TYPE_DEVICE, with the powernv specific
device being a SysBusDevice which incorporates the core xive device
inside it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B0+HW0pjZ+2jqF7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllu2asACgkQbDjKyiDZ
s5IGNxAA4p2BIkzfw5Kib5iAIqAxcATr4OlncQqbxJ12E8+oiSKfUrPqqlDSpbuF
9J8ih/NpuOBjbsasvVK3MqSTvfZfdkdU3K7slvk+zKsAZhLZNe7d1CvB7vduB9Qz
rlunAt5Buhe1tIHnHEDS9jdf9ZFABQvduqab6YlcO4iCIpC24qmChQgTAWopWZZm
z6TIGxHlU7kCzV1FkgYv4GaeIBplNuQHXwWwzqhaVDgR/MhqT8wv3/4JU/sUZEuJ
3nrXDGfh7A5RavvhiCmz3uHVtlpVPesH5qsCpey/qK705O5F1NbabYz7XLGUd7jT
n6SGNeVt1mDMVC7Ykcv6UcWGpN09LT+t73wud7/6WsutcxxD5svRSLMPaEN27Xj3
dmI/0LOuMusnipoA5aJB3vzWi6rmgwqdPSbZjDOszdJSFkRxqa07JHxOv93YsUil
EcF/puzgZW8X2ztXunfd5Et6+V4Pw5yJWtU6Jwbe6CprLJdb9b6oelZJmDeNKBMf
l01iuVg4q2qQfwFvrgiFyTrbGCQAydnm3GOiZhbv3vCIqq7Na2QBw8IQ5pYjykzP
pJguG3D2N8b95MnHHPUiiWc2lkkNqORQvydbGzrH5pjYZft/H3ru+cBjsmJNQsxN
w6N5ki38cZQIQxgV/BVI8t+HjS9pNnfIAufTYFv3KL3GXsYG7qY=
=eU4r
-----END PGP SIGNATURE-----

--B0+HW0pjZ+2jqF7e--
