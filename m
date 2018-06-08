Received: from eggs.gnu.org ([2001:4830:134:3::10]:58899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR6tu-0006UN-73
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 22:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR6tt-00009f-9P
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 22:13:14 -0400
Date: Fri, 8 Jun 2018 11:41:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608014126.GB3344@umbus.fritz.box>
References: <20180607165955.10232-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20180607165955.10232-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/3] ppc: trivial Mac fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 05:59:52PM +0100, Mark Cave-Ayland wrote:
> Here are some trivial Mac fixes taken from various working branches in my
> local git repository. Since they should need minimal review it seems
> worthwhile to send them separately.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.0, thanks.

>=20
>=20
> Mark Cave-Ayland (3):
>   ppc: remove obsolete pci_pmac_init() definitions from mac.h
>   ppc: remove obsolete macio_init() definition from mac.h
>   ppc: add missing FW_CFG_PPC_NVRAM_FLAT definition
>=20
>  hw/ppc/mac.h         | 9 ---------
>  include/hw/ppc/ppc.h | 1 +
>  2 files changed, 1 insertion(+), 9 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ3sMACgkQbDjKyiDZ
s5KR3A/9E4JpXEn/rx8isOpcpsHVTS1PtRODxjMZCyGuIjZt87NCZkIqeiNjLieN
ewPCktAQNKW7/NcU1HZo8Wyou+KrWgqj71jdj6iBBSWlDY+kLiS4XJWtfbSfr19H
WNiMBGu1g7hUzP+/85DjTsIO/1f/U2xjkkR8suWQET8v8xyPMcwd3JGHlcB2dP9u
NRk3wlcTa+HMcLp6cCBwxaFaOtItNk6r/SG1jfzUQsEls0V2JdQ9DdQZyYDyhqaB
1mQY5ccrfa9k/xBSY9+t4kJZUHos/ZdgDMmyRaCEO6COft3bsn/hoqblpuOeo46I
O5O/0u2sLdp4gNyIE4JqNUeGbAa+OFUBFAA4uhJHei9ITfHTJTVGZRSvHIM1cNGf
mrpmksIfAkExOezv4rrJ8UXJK7RF7ncIOlKjexlXebHPoE6Zx46mwcAbu77F8SkH
jy1kO1rXL9UPR6+fb6VL3rlT8h+RREzjN/TfTFgBFCBkrwXqAq6YEEVVPc01B8nN
5VxhL5mmFqrynjUVr6y/FNOzZBkEWp+wOBXBfl+V8Jz5AEh+XCTrfaa82D5ftBBO
Ts56UseqgQi/zodjdnkUYUe2OkSUW5hkSfKM3/og3iCWhNmfU+ZxwOlry9QsmsIU
B+tcjV1uQLd/7hK0EWBk8Oc1X6Z25Bv9DvAqxFBdHgCgdJn9MIY=
=pv68
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
