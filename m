Received: from eggs.gnu.org ([2001:4830:134:3::10]:58439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVse-00049q-Gh
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVsd-0005C7-K8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:48 -0500
Date: Thu, 12 Jan 2017 13:51:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112025101.GE14026@umbus.fritz.box>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 00/11] POWER9 TCG enablements - part11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 02:20:32PM +0530, Nikunj A Dadhania wrote:
> This series contains 10 new instructions for POWER9 ISA3.0
>     VSX Scalar Insert Exponent
>     VSX Vector Insert Exponent
>     VSX Vector Extract Exponent/Significand
>     VSX Scalar Truncate & Convert Quad-Precision
>     Couple of fixes
>=20
> Bharata B Rao (2):
>   softfloat: Fix the default qNAN for target-ppc
>   target-ppc: Add xscvqps[d,w]z instructions
>=20
> Nikunj A Dadhania (9):
>   target-ppc: xscvqpdp zero VSR
>   target-ppc: Add xsiexpdp instruction
>   target-ppc: Add xsiexpqp instruction
>   target-ppc: Add xviexpsp instruction
>   target-ppc: Add xviexpdp instruction
>   target-ppc: Add xvxexpsp instruction
>   target-ppc: Add xvxexpdp instruction
>   target-ppc: Add xvxsigsp instruction
>   target-ppc: Add xvxsigdp instruction
>=20
>  fpu/softfloat-specialize.h          |   2 +-
>  target/ppc/fpu_helper.c             |  62 ++++++++++++-
>  target/ppc/helper.h                 |   3 +
>  target/ppc/translate/vsx-impl.inc.c | 172 ++++++++++++++++++++++++++++++=
++++++
>  target/ppc/translate/vsx-ops.inc.c  |  11 +++
>  5 files changed, 248 insertions(+), 2 deletions(-)

Patches 1&2 merged to ppc-for-2.9.  The rest pending a query on 3/11.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdu8UAAoJEGw4ysog2bOSSbkP/2unglN9XUl9P8jGd1oxsAu8
k9gNZqTxwS2vbpmz9cIKW3iK6JxkcwJdiRoMyU2kmTd1WUIm28l/x/DwE9lt6oct
tktq1z5RnE0Yd+glQN27X8XVBcpTtP/nZl7OuVlT5tlFYjIURMKHmuAVMzeBTDUU
BTf1yrw3SIWN1jmJOOxhu7s+9nuMwT1SXWmsjO63TGV8wL33Y0Y9PNMlc06DyY94
TYIwof4Vto3FOMebbe9QCkyXZzsSaLlcmvfNwZsotnngZ8JBb7T7y6P52oy1uvPm
9aob9vmvdN/c//uJti7TdZiOWRQBHzhr5+aLZXRktfrr5lFCZdPVO96MwIjhe3HN
Ns3v3E56I+4bdu70Uh8oZGBR9Of5bcYmmDoU6g/vymt8b8jp+v/5igsRZ/SjJ/bd
GhVbENbjlj+Ye+j/C5aN0G4f/F4klfA9ptk5UOpU0m0QubeBmi0haMQHHh8K8T11
LPR1cx2w9u/zE0CSn7Fr5WD9ghScGwvWTtSIUM9E/mtHwV0d5JFpIRqffnhbLpJh
Erli/ghKWGy86+qE655augODYNiqdfrmGwwy3P4d6WuIkr/0+2dovdwAlbiudvFT
Ee9/z3mPVB+R5RAiOqK61UxdCCygrWhBqHKxa+ZrzU4duvbzdoaZwy17KOYRAxx/
J0R11HCLrHF2wFEWoOJ3
=kO8n
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
