Received: from eggs.gnu.org ([2001:4830:134:3::10]:33880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbJq-0008Ko-8V
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbJp-0003K1-0I
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:48:58 -0400
Date: Wed, 21 Jun 2017 16:05:46 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170621080546.GC12089@umbus>
References: <149789192064.8356.6383758991647148922.stgit@bahia.lan>
	<3f9a94c6-6391-d45e-fbd9-32a8e1e8504f@redhat.com>
	<20170620161901.50113a5d@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20170620161901.50113a5d@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr/ppc: fix backward
 migration to QEMU 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 04:19:01PM +0200, Greg Kurz wrote:
> On Tue, 20 Jun 2017 15:08:47 +0200
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
> > On 19/06/2017 19:05, Greg Kurz wrote:
> > > Commit c783b0012708 ("ppc: Rework CPU compatibility testing across
> > > migration") added a subsection to the vmstate description of CPUs.
> > > This subsection is sent when the CPU compat_pvr field is non-zero,
> > > which is likely to happen after CAS negociation (since QEMU 2.9) or
> > > even before CAS negociation if the user explicitely asked for compat
> > > mode.
> > >=20
> > > This breaks backward migration of existing pseries-2.9 machine types
> > > since they don't know about this "compat" subsection:
> > >=20
> > > qemu-system-ppc64: error while loading state for instance 0x0 of
> > >  device 'cpu'
> > >=20
> > > This patch reverts to the behavior of simply ignoring the PVR when
> > > migrating older machines (ie, let the migration succeed if the user
> > > is sure that the CPU on the destination is close enough to work).
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> >=20
> > but I think it should be merged with patch ("ppc: Rework CPU
> > compatibility testing across migration") that is not merged and in the
> > maintainer tree.
> >=20
>=20
> I agree this would be better for bisect.

As suggested, folded into the existing patch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSijYAAoJEGw4ysog2bOSYMYP/A3ky4lFadrl3423Lcb09jy3
sBy/PHV18wGWX5UwZ8tCtVpJNiidE0Mtr7ut5yEbK7SbV0uNnsjWb9aFpugE1KBs
hm2dhcnta+TfTnlyrvqaN3M5eZtR6k4LTXQHIdOysYYgIxhM7KxgAc/M5ewuud2g
/qKBSrQHBQgvxdt8cgbB8wowW624Sb8AMVQCqxM4jfHplSwmF8eF01qqkN3oJi+c
oVLHgp17PBHnBaSzWG82Q0EWiJ5SYjmR8qt7ca89XS/z+UPk1qGfYxOICH/t6fuF
GCzNEddvY/rhj9UzesycTtdOAGhVj3ePXqe4ShzYhkVWytkWeKZzxeeDHxP04Gox
84m8Ds6V6fJmeRhnwUfAVxKWz1EvRLiT80RdSpyNIGEoRfJwkXGZvr7+uhw8P8n6
ASepLwtvROFeAqWJJt5qp3lx/jwoEIiPjjB0ww48WwvoViinVoDiKohwvJCCOK/4
9OtqxrM835D6ok5fv8CvUXYdYoyMb+9FiDIuOYq+TX7RIjXlT9XAqrUzlxncadks
SuGajCjT0QdqIbJqvoCJVYJs38gYIeL0ds50Pi0UW/vOWg9Sf2Jq//Q3mQqDlPCt
XCfGXGcH7IPKf6AqacX/K18+CwUi2gxM//8a+eYuYB3xhfNSKJ2z13nFnyBQL/yy
q9XZ/IBGxWW08Q5JCwbm
=3gvk
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
