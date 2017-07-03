Received: from eggs.gnu.org ([2001:4830:134:3::10]:46667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRvuD-0003gj-CG
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRvu4-0007zC-S2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:36:25 -0400
Date: Mon, 3 Jul 2017 16:49:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170703064955.GT13989@umbus.fritz.box>
References: <20170703061948.18220-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UsbkURXZxe2ekgES"
Content-Disposition: inline
In-Reply-To: <20170703061948.18220-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-PPC] [PATCH 0/3] target/ppc: Implement radix
 mmu debug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, bsingharora@gmail.com


--UsbkURXZxe2ekgES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 04:19:45PM +1000, Suraj Jitindar Singh wrote:
> When the radix mmu emulation code was implemented the translation
> debug functions were left as a todo.
>=20
> Implement the functions ppc_radix64_get_phys_page_debug() and=20
> ppc_radix64_dump_level() to translate a single address and dump all the=
=20
> address translations respectively.
>=20
> This functionality is already implemented for the hash mmu.
>=20
> A slight refactor of the radix mmu emulation code was necessary to enable
> the debug code to call existing functions.

I've applied 1&2 to ppc-for-2.10.  I have some further comments on 3/3.

>=20
> Suraj Jitindar Singh (3):
>   target/ppc: Refactor tcg radix mmu code
>   target/ppc: Add debug function for radix mmu translation
>   target/ppc: Add debug function to dump radix mmu translations
>=20
>  target/ppc/mmu-radix64.c | 116 +++++++++++++++++++++++++++++++++++++++++=
------
>  target/ppc/mmu-radix64.h |   2 +
>  target/ppc/mmu_helper.c  |   5 +-
>  3 files changed, 107 insertions(+), 16 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UsbkURXZxe2ekgES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZWekQAAoJEGw4ysog2bOSkD4QANyR3U/iIE616RlwYOu7hNkU
7j8P+B2Dj3bShZislj3kBlKTAe/0rBUDVfVsic3Uw/fmv94bgeH5BkssoN9LOTpy
OpeHNV7BcAN4XaZ6TjKYnySsW5V5V00+AlIFcOl5xo1k44Q9L/sCXPeQBwQATv99
qVZQ3cy1d79PJnZawx8vCF2Qzl/P7T97nX0kVJhBE7k946sIwl7I5BbREDBDgEUa
H3chsdrEPow6HKAsiZ4uFEbaU64Gu4sLUE5Qc8Z+aOOuIBtpJ3/pk3X/MQHN7ncU
HABmANyA1GKSkNgWr1NrkfJyHkzvY+OOA84ieswV7aEprWrnykph815iPt9jjAeI
RBt3wVEBPA15seXbdZFFT8QVNLald1YRzL1W8cTjkGjsY0ekZj03UkZvTlBXdKGc
zILoE3NlNBGoFuqs1ucsuMjogjlcvqGxOvrH2bfnjbOmnUB19qBUzVXrcLt1JyxO
s3Z3nSjwNDHC1xABnc3SlHNDW953XqT1GekpsqBAguVWVE3rZNt4gQjC57WvRtPF
JWI2ka6XfnNKX0HNMtIGHHqj1aGujj5dBR2u6eJN15rqDQ03E6lmmrbOEeoRWNF/
vJBliW3pU5JY+KphIfgA9qFDDx9kmcODVTMhkjygp5Hmzo+XWTSTIRrw0AUuNL7n
974FvCp+lwJBvF2dRTEh
=0rLk
-----END PGP SIGNATURE-----

--UsbkURXZxe2ekgES--
