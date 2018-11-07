Received: from eggs.gnu.org ([2001:4830:134:3::10]:60473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFmF-0005HO-91
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKFmB-0007PV-Vw
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 23:49:15 -0500
Date: Wed, 7 Nov 2018 15:48:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181107044859.GF5575@umbus.fritz.box>
References: <20181011061609.11423-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <20181011061609.11423-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 0/3] ppc/spapr: Add support
 for nested kvm-hv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@ozlabs.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2018 at 05:16:06PM +1100, Suraj Jitindar Singh wrote:
> This patch series adds the qemu support for running nested kvm-hv on a
> POWER9 platform with appropriate hypervisor support and migration of
> these guests.
> That is, the ability to run kvm-hv guests as guests of an operating system
> which is itself a kvm-hv guest.
>=20
> The host (L0 hypervisor) and level 1 guest (L1 guest hypervisor) require
> the following patch series:
> KVM: PPC: Book3S HV: Nested HV virtualization
>=20
> And this patch series in the qemu instance running on the L0 hypervisor.
>=20
> Patch series based on: ppc-for-3.1
>=20
> The cap number is now in Paolo's tree so hopefully we can rely on it not
> changing.

Now that the kernel changes are in upstream master, can you resend a
final version of this?

>=20
> V2 -> V3:
> - The enable cap ioctl no longer takes an enable field to indicate
>   disable/enable, but just enables the cap. So update to match this
>   kernel change. (The cap starts out disable by default)
>=20
> Suraj Jitindar Singh (3):
>   target/ppc: Update linux-headers for v4.19-rc7
>   target/ppc: Add one reg id for ptcr
>   ppc/spapr_caps: Add SPAPR_CAP_NESTED_KVM_HV
>=20
>  hw/ppc/spapr.c                  |  2 ++
>  hw/ppc/spapr_caps.c             | 32 ++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h          |  5 ++++-
>  linux-headers/asm-powerpc/kvm.h |  1 +
>  linux-headers/linux/kvm.h       |  1 +
>  target/ppc/kvm.c                | 12 ++++++++++++
>  target/ppc/kvm_ppc.h            | 12 ++++++++++++
>  target/ppc/translate_init.inc.c | 10 +++++-----
>  8 files changed, 69 insertions(+), 6 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvibrsACgkQbDjKyiDZ
s5IxoA//Z9vkQ7sv9+mDmn6s52lCq1LCQVq645BKu0EB5Yd50W+VpMEjT5DhlFh6
NgYroVGe2+abNaxzM23SElSEEc7mhrQT3CT25o0AjrCQI79Lx4f4aosFFCTtdUlG
nZho1ZERyShwsD3ECQUOdk+XaHDYMU7dN9hs8CCivqsf8ImKiskLKs2gNWitEmfn
aCTI6AuZrccKToqf3+1TdiA9T9Bfhc5Me+vrzx7uEEOWYQvTWrcLnL5VvrBqVRLo
25e5RR6GfQZOPNr/bdY66dC4ewE+6OY0dKAdeagb4nIqOn2KugbJ3dk1auF83116
WE4ZzD8/vtZhJv178T23gpemWaLzNMaEhIEn9Ln5rvQHD9XJRw5WiJcwt6rN13IV
V339wLMbd7owyK5wYuy9COK+2ThzOl3+5Ag/9XsDuGYd/0o1ubP+C0ROFuN5I7p4
nmHau/6OKvs3JqxaYCkEyZflmdpnZrb42MZVj6tdDkAYHtHEsk72ecfsIdfSlEzo
aVeHzw2Qf5Nhc5h2Wu7/R4X2WZbDgtnkfn5JsspY393bomJqCbCUmUzQ39j0+YBf
o+yLM5bQG2B5Yd5M7FqygEcBAXkmjKxQHNaSmy0QreLjNpxZMqa8Ge/S4s93fIV2
uPAPmjjViiiwoJszxRy0mFOcjch0bI/8y0PNWjoJec9w6XR+YWM=
=XzI3
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
