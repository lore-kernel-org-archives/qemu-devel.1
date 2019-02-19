Received: from eggs.gnu.org ([209.51.188.92]:36267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gw5dV-0004Lt-If
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gw5dT-0002N1-IE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:40:37 -0500
Date: Tue, 19 Feb 2019 16:19:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219051924.GA9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="livrSZtJkVq9DDdS"
Content-Disposition: inline
In-Reply-To: <20190215170029.15641-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 00/12] ppc: add native hash and radix
 support for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--livrSZtJkVq9DDdS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 06:00:17PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here is another series of fixes and extensions from Ben providing
> support for POWER9 native hash MMU and POWER9 native radix MMU. These
> prepare ground for the support of QEMU POWER9 PowerNV machines.
>=20
> >From there, I hand over the patchset to Suraj for any follow-ups.

I've now merged all of these except the include cleanup, which I've
partly done in a different way.  A couple of the later patches are
tweaked so that doesn't break compile.

>=20
> Thanks,
>=20
> C.
>=20
> Benjamin Herrenschmidt (12):
>   target/ppc/spapr: Set LPCR:HR when using Radix mode
>   target/ppci/mmu: Use LPCR:HR to chose radix vs. hash translation
>   target/ppc: Re-enable RMLS on POWER9 for virtual hypervisors
>   target/ppc: Fix #include guard in mmu-book3s-v3.h
>   target/ppc: Cleanup 64-bit MMU includes
>   target/ppc: Fix ordering of hash MMU accesses
>   target/ppc: Add basic support for "new format" HPTE as found on POWER9
>   target/ppc: Fix synchronization of mttcg with broadcast TLB flushes
>   target/ppc: Flush the TLB locally when the LPIDR is written
>   target/ppc: Rename PATB/PATBE -> PATE
>   target/ppc: Support for POWER9 native hash
>   target/ppc: Basic POWER9 bare-metal radix MMU support
>=20
>  include/hw/ppc/spapr.h          |  1 +
>  target/ppc/cpu.h                |  7 ++-
>  target/ppc/helper.h             |  1 +
>  target/ppc/helper_regs.h        | 27 ++++------
>  target/ppc/mmu-book3s-v3.h      | 89 +++++++++++++++++++++++++++---
>  target/ppc/mmu-hash64.h         | 22 ++------
>  target/ppc/mmu-radix64.h        |  4 +-
>  hw/ppc/spapr.c                  | 86 ++++++++++++++++++++++++-----
>  hw/ppc/spapr_hcall.c            | 69 +++++++-----------------
>  hw/ppc/spapr_rtas.c             |  6 +--
>  target/ppc/misc_helper.c        | 15 ++++++
>  target/ppc/mmu-book3s-v3.c      | 31 +++++++++--
>  target/ppc/mmu-hash32.c         |  6 +++
>  target/ppc/mmu-hash64.c         | 28 ++++++++--
>  target/ppc/mmu-radix64.c        | 96 ++++++++++++++++++++++++++-------
>  target/ppc/mmu_helper.c         |  9 +---
>  target/ppc/translate_init.inc.c |  7 ++-
>  17 files changed, 361 insertions(+), 143 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--livrSZtJkVq9DDdS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrkdoACgkQbDjKyiDZ
s5J5RBAAslcQgUqGGKrMDEuMU5WjLnsy4WpPPAcgsalssDcMkCJY6+F7G41EIjEK
JAoeeUnFw35SOONsa7Q8l8xb9cat3MOD3VsKbWUVBh+CaNpss7sqc/MmmT+xygPH
pdWq/GUQH13XjSSXOLlePf7ccd68WpqQBUXVm7YS8v+1w9Qb4ZKIVam9uAB9cYpD
vAsVKtdbcRXsDsJLAnzfN4GrtuEgHBOIQ6lyqUGNdnznlq6MexBwPxAta9Xi6L+k
5e04epHNiu8VYH3tTew2kCskgo26OaalfGGrjNXkkZ4mLwyErvCEej27DtxZ/gus
A3xXLiq6WTwiBLdRkxQRmh0yy3feVe98agMSZ8z6/16g4A1qDBcjyPB0McVj4Puc
qGXC85BXxLEytAD1Pa4QP3V6STWYXm2OixQFVNfaOY4InZsFZ3gOXazQsAKlKrUc
wmWlHI0WALIZ+cmy0+qNiWeGv43jYnShynbY7KhR3kTtrap0tGrAVxBHznoBpamY
J87MVehwWpZY5TwWlQAI6oqpxZud6pTbi2o7ODxXTL6TrC0RzbjtCMIXdz5nrJaU
tszcDtB7Pui/yEkQgZaQWWdUaOZXYwzA4UJvjRYffCrRlw0B0ejc6ehsSSDO9MaI
Ol97pZF53ZeKiEcYHUxsdWEvzVGoXNYK9GqMOearvAEtc5/klcw=
=nFGB
-----END PGP SIGNATURE-----

--livrSZtJkVq9DDdS--
