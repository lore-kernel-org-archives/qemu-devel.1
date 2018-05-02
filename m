Received: from eggs.gnu.org ([2001:4830:134:3::10]:36699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fDtJM-0005h4-6m
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fDtJG-0001ox-6b
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:04:52 -0400
Date: Thu, 3 May 2018 00:59:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180502145935.GA13229@umbus.fritz.box>
References: <20180424113045.25687-1-clg@kaod.org>
	<20180424113045.25687-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20180424113045.25687-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 1/5] target/ppc: return a nil HPT base
 address on sPAPR machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 01:30:41PM +0200, C=E9dric Le Goater wrote:
> commit e57ca75ce3b2 ("target/ppc: Manage external HPT via virtual
> hypervisor") exported a set of methods to manipulate the HPT from the
> core hash MMU. But SPR_SDR1 is still used under some circumstances to
> get the base address of the HPT, which is incorrect for the sPAPR
> machines.
>=20
> Only the logging should be impacted.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Even better would be having an asserT(!vhyp) here, but that would
require some irritating fiddling with the callers.

This is a fine interim step, applued.

> ---
>=20
>  Changes since v3:
>=20
>  - removed spapr_hpt_base() ops and just return zero instead
>=20
>  target/ppc/mmu-hash64.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index f23b78d78754..53dcec5b9316 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -101,6 +101,9 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
> =20
>  static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
>  {
> +    if (cpu->vhyp) {
> +        return 0;
> +    }
>      return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrp0lQACgkQbDjKyiDZ
s5KKehAA28vc5/AYwKzmGd19XktGSMhCczFvHCScO746AaCR+l8CWbiqMl8f93YW
53CBd3gGD8Omi1IGCDcZfhPqcAa8G4d3SiQ6No03hwm+t+nriB2a/q6QRHZn5uHI
Q9I1t3gB7tvhW/H6/VXn5m9WFjXVmQqmxX4plrUT6Sti4vothFeMfwc3fims2Xtu
Ooduq3KOtAHccQopbcnuVwktusuigeTA6ZRvTf7fSsSWANVLdAAgMPlQdKZJ73xO
rsgJkg8b1+d3tOfi80c6Ay76lPlcJXRquR4AHeGog235QxEwUq6RIYaygiNZIXbE
9gCwSTfDARuezGoJZLuqLMd+pua+D27oUTNh1j17mPVocB9MWI2GMwOYwsEl4nB+
9WOOM6guheVgMP9/2XqrnHTj0bKFjniehlYpjXgFl4YZDXoPO7i35/+P7QytkDWT
fNBarPHoxl4X9kWjJGAEIPZRg5iKf965GKl/mj4y1A/f1GPCfTcUhSFzSETRgmww
dHpDGCO3XFJSDXhva9Uies+aHwidpLwdxIUowS90/ZVC6QYDe5TkhyEvTU/G1j+B
0pjABPpmmKPaK6juwZjFRNMt2GNikQ84l7WRHTOx4lTNDbZ3fyDc7QDECCrnlD34
aLY7jz/mBmAgT+wWvnCrV8z1eeSQLLb/MFDv3TIkqKcMwe5P5as=
=kTgl
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
