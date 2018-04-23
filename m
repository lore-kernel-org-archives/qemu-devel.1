Received: from eggs.gnu.org ([2001:4830:134:3::10]:33717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAZHW-0004FJ-MI
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 07:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAZHM-0008DS-TB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 07:05:14 -0400
Date: Mon, 23 Apr 2018 20:44:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180423104435.GI19804@umbus.fritz.box>
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-3-david@redhat.com>
	<20180423032825.GD19804@umbus.fritz.box>
	<a6d6e760-bffe-515d-de78-cc698f7341dc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <a6d6e760-bffe-515d-de78-cc698f7341dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] machine: make MemoryHotplugState
 accessible via the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 11:36:48AM +0200, David Hildenbrand wrote:
> On 23.04.2018 05:28, David Gibson wrote:
> > On Fri, Apr 20, 2018 at 02:34:55PM +0200, David Hildenbrand wrote:
> >> Let's allow to query the MemoryHotplugState from the machine.
> >>
> >> This allows us to generically detect if a certain machine has support
> >> for memory devices, and to generically manage it (find free address
> >> range, plug/unplug a memory region).
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >=20
> > So, we're creating a hook where it seems very likely that the only
> > implementationss will be simply to retrieve the right field from the
> > machine specific structure.
> >=20
> > So.. should we instead just move the hotplug_memory structure to the
> > based MachineState type?
>=20
> It allows us in patch nr. 3 to report different error messages.
>=20
> "Not supported" vs. "Not enabled (maxmem)".
>=20
> We could also handle that via a simple boolean flag inside of the
> struct. What do you think?

A third option would be to make it a pointer, rather than directly
embedded in the MachineState.  That would also avoid the extra
allocation for machines that don't use it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrduREACgkQbDjKyiDZ
s5KLRxAA2NhwtvxmY0cHu6352/VCObQHEszw44yL7kf3ZgaELi9CeUcD3L8GUP7d
RJB8M/ZK4qWR4QSFoMVIFp6EWmKFvNH5NX2OjKW6MT99YzHIPKP0l7a0b5+gKe1K
RXfjzTE4Gwdj5EZ6UDm8ipthKKgkT0d7/sO4PD6wmqRZGn01ZqnhN9b7N4EB/8S/
FY4eRlFsmns1bF5AxxylO8DZGh21ezL3CByc128hm7+ik7Tk7BTFVhz9swNz6B2L
KF20C5tezc/9Lrvsswldu+rb9G+/wLXNU37Loj1JQPBM6oVzFTl3J1td7y7HL7Dh
DU22L4+T4Rx6vt5sOQl7n19ZgLhKkt/q7YDTqyLf42fXZOpgVvaHH4CaJP99uukB
PPfve1ClI3Dr5MEUv+D5EQ/pAgUzHtT8DPZcNNutTLc66Z/BbKS6cOJxUJ6XWKyg
T5PRBrKLE5MWp7Ghe4EhlP07lfAbJggyhWvMs7t2ir+Hos0orLxAujmYquzKDCcH
WaFih/D9z2vkaKsJrcUx7YihfLBVhkA7sd07cxTbdik30xx3Kd8eMhy4RXsmAbQV
xwu7WkIf5PLhgEl+bYjHDNQdATYUtud9d9ASICWxyinr+ym2I5pMfln7cCsZatrD
ifkrA5p9/OxOXMUw8EcbI+zjcWjdhKVls1c1vPOEoeil9xGCOWU=
=pSYu
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
