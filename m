Received: from eggs.gnu.org ([2001:4830:134:3::10]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRTDK-0006JW-Kf
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 22:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRTDG-0002dJ-M5
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 22:02:46 -0400
Date: Sat, 9 Jun 2018 12:01:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180609020125.GX3344@umbus.fritz.box>
References: <20180608124816.22140-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eGyD7iWN192kf2IJ"
Content-Disposition: inline
In-Reply-To: <20180608124816.22140-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] spapr: machine hotplug handler
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>


--eGyD7iWN192kf2IJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 02:48:10PM +0200, David Hildenbrand wrote:
> I'll be messing with machine hotplug handlers of pc/spapr/s390x in the
> context of
>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
>=20
> So this is a spin-off of the cleanup patches in the context of hotplug
> handlers.

Applied to ppc-for-3.0, thanks.

>=20
> v1 -> v2:
> - dropped the three "local_err" patches
> - tweaked some patch descriptions
> - Split "spapr: move all DIMM checks into spapr_memory_plug" up
> -- Move the memory hotplug check into the pre_plug handler
> - Use &error_abort instead of NULL
>=20
> David Hildenbrand (6):
>   spapr: no need to verify the node
>   spapr: move lookup of the node into spapr_memory_plug()
>   spapr: move memory hotplug support check into spapr_memory_pre_plug()
>   spapr: introduce machine unplug handler
>   spapr: handle pc-dimm unplug via hotplug handler chain
>   spapr: handle cpu core unplug via hotplug handler chain
>=20
>  hw/ppc/spapr.c | 67 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 24 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eGyD7iWN192kf2IJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsbNPMACgkQbDjKyiDZ
s5LABhAA4xeY9yyUEvdP2p/8rUglfNgtFDbTGX6B09+oovtPWCV5uihVgiCzpIMw
Ox+3ACCMq7sYUpUhxVqdbmEpBamAwin5VgOMXLLbv631QpQZPaT5QWIAorpAFfdY
ZaSWtxh9t+um+tqjJOSCSL/1OqtWSNdYGOSS2WTQquHkYv/PZSa0gjKreTzDBJm1
lyNDHx0eF73s7aDzsV3kLBp/NbvPuGcvzV8XgLt5Voa/7wgBXDety5guPTJN9k7f
VNkilscEiqol7XScOnWwYbuC5wpAhBPya3X1DssbvSCIzwpTYNbq+DEkZn4qvpW7
GAsTTLdKhllDcNAIByiuzetW8nheG/6QM/10q21VXXYW3/9e8yvCXroxFaW94RWW
wdZfmc6PpdMAGQ1GpHfKIk3BuPD3MHhZFmiDqsgU2IJh8ym4ScnFaVoyZIfyBUTv
COKfZnG8jaRepm9uUDqPNPulRuYZUSlcgWfAkFSvYcU1TBq52azdUnqonC0KwxxQ
GuFWpbP7qdGYov0mQbLzSIEOE/s2zWOsO1O2eYAqTnqk9QHTgzwWNEMkYy0gluX5
xj/qMX5qaigPoBt5JBj22q+oiAPkLkl5WTAvL+wTk52M+KAns9hV3kAqsEXupOgS
oJQc3e/EWLkK1B/Ykd04CH6RjvdDGVgl2DuuDqIIBxerfr65hXM=
=E1jq
-----END PGP SIGNATURE-----

--eGyD7iWN192kf2IJ--
