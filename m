Received: from eggs.gnu.org ([209.51.188.92]:49694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvvcn-0004Ai-0U
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 21:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvvcl-0001WG-3R
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 21:59:12 -0500
Date: Tue, 19 Feb 2019 13:58:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219025851.GO9345@umbus.fritz.box>
References: <20190218092202.26683-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XVTPT6MZt3zd/C+/"
Content-Disposition: inline
In-Reply-To: <20190218092202.26683-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] tests: Add device unplug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--XVTPT6MZt3zd/C+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 10:21:56AM +0100, David Hildenbrand wrote:
> This is a set of tests to test basic device unplugging functionality for
> - some PCI implementations
> - CCW devices on s390x
> - spapr memory and cpu core devices
>=20
> I plaed with ACPI CPU unplug but getting that to run with qtest is more
> involved. (remove devices on reset, trick cpu-hotplug-legacy property,
> somehow create cpu hotplug state objects ...). Well we no have at least
> one unplug test for DIMMs and one for CPUs.

I believe we were talking about merging this via the ppc tree, so I've
merged it into ppc-for-4.0 (with Connie's acks).

If I was mistaken about that, let me know and I'll pull them out
before I send my next pull request.

>=20
> v2 -> v3:
> - Use a smaller DIMM for spapr memory unplug request test
> - Combine both spapr test registrations in a single if statement
> - Use "-" instead of "_" in test names
> - Add a huge load of r-b/a-b :) hpe I didn't forget some.
>=20
> v1 -> v2:
> - Tests for CCW, spapr memory and spapr cpu core unplug added
> - Fix a deadlock when unplugging dummy CPUs
> - Style fixes / simplifications (Thomas)
> - Don't use the global_qtest variable (Thomas)
> - Fix double-free (Greg)
>=20
> David Hildenbrand (6):
>   cpus: Properly release the iothread lock when killing a dummy VCPU
>   spapr: support memory unplug for qtest
>   tests/device-plug: Add a simple PCI unplug request test
>   tests/device-plug: Add CCW unplug test for s390x
>   tests/device-plug: Add CPU core unplug request test for spapr
>   tests/device-plug: Add memory unplug request test for spapr
>=20
>  cpus.c                   |   1 +
>  hw/ppc/spapr_ovec.c      |   6 ++
>  tests/Makefile.include   |   4 +
>  tests/device-plug-test.c | 162 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 173 insertions(+)
>  create mode 100644 tests/device-plug-test.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XVTPT6MZt3zd/C+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrcOsACgkQbDjKyiDZ
s5Kpjg//W/k2b8qhH/5NYISulbxHQ9Sx6nUTcvPyh04gY+OtZFN7nhrRd79xadjh
QpQ1BkW8LamBBnGi95Lj8G33WjxqoNWeZ6UMeF6DJm27LbB03FOIVuyW05Mfydbk
1bPvxNJh8u7bw0cPUeiKvVkF2WFnjJcTzG/JdpZkB5z9sPGk1Su6oHObEQJB8ze4
mi4FOFsw5w6EQ4RwLcbAo1oi/8gHiOGuNrK+sYDU+ZfU5rTzOTMp4nlkQG7yvE3i
rvUwBilk9HkUmC6V409yeb1Jl5lbnGnGBma03R3M9Tkw+SYD9AAE7XKEJjThM2mE
hK8Dr2HKQNyDPGT2OH5VVJMY36ERxUEp117nHgfIh/H8g9zUQcHCc/J2cqqFbHLr
YJBV0WKB20PatukjB//7KlADy9yFNonneW0PBwoWga/9gbz8vRvf1ZQ6GqBrpZwl
CpaHhUzK/v9UBjTLG40KR6gnNK+qREsIs97Hcyt3f6R92dDe2rlQY2HK0WMyhfSj
PK+PrRJmLKS8J0xmkE0yJ8gd3TtiXF1KwdclzyXm/TSkbaQf7ztpw5AxezTC/UTi
GlFgALEYhAQ4fyjQ4L6dt9pbgU52cwCvRkMlZlt7f5f3g7rf+eMCqV49hxq3Xbbc
muxenHVGAp/iI+BCXG9RcXqhsF7ZXBo0+0/uOVAG6sadjpLni9Y=
=VX6h
-----END PGP SIGNATURE-----

--XVTPT6MZt3zd/C+/--
