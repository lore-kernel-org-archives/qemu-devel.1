Received: from eggs.gnu.org ([2001:4830:134:3::10]:59050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMQ9N-0005RS-Qq
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMQ9M-0005fQ-PK
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:13:33 -0500
Date: Wed, 6 Dec 2017 14:12:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206031228.GR3057@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-3-mdavidsaver@gmail.com>
	<20171122033643.GH2380@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Content-Disposition: inline
In-Reply-To: <20171122033643.GH2380@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 02/12] e500: consolidate mpc8540 guts with
 e500-ccsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 02:36:43PM +1100, David Gibson wrote:
> On Sun, Nov 19, 2017 at 09:24:10PM -0600, Michael Davidsaver wrote:
> > Preparation for adding more MPCxxxx control
> > registers.
> >=20
> > Use e500 SVR to enable part specific registers.
> > Only the mpc8544 reset register at present.
> >=20
> > Expose CCSR as SysBusDevice region to eliminate
> > e500-ccsr.h.
> >=20
> > Track CCSR base address within device, and map on reset,
> > in preparation for CCSRBAR.
> >=20
> > Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>=20
> Applied to ppc-for-2.12.

Sorry.  I've now pulled this from ppc-for-2.12, because it caused a
breakage of make check (specifically the boot-serial-test with ppc64).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlonYBoACgkQbDjKyiDZ
s5K4ZBAAzRzFcycmedDdoVhmg5LsLIE2/7kqW8JcYusnprrN4AntKBJGzQPAz9NA
wE6hPImyFh8OeO+EMLU4hdKssuqO7RL4rweyp5A4UejMdne4JBDXqgSm2M/QHdtB
6zzkx3dCziV5qNr14pKK7ODKzNxOofwd37Ni/1RFPLtugon3UEKxxh9fRCKxcYM7
oPCeZxXwSBQ3Zof/h8+lSXh+EgBpEFCGwZHwMcfndBtsohX/doKfgUk0N/De7wqO
2poxzlyGTtqk7V89lOCrt6D5o3OeCdliTAHhIjm8MAGX99W3q9H5swN4oGRV9lnh
wuz9RiVhJ/d/hUryTzijBEiae4ZcKhSU1dcd4GdeiM0ZioRutt3riyOC4IhmFtZV
tsg54FMmcwlCeePIfghYKNBzueQz9XOOEqfS9PsHjU8xtCW8+q78x+D8npmrG4o3
LF3dw18pv10dq2VozlPtZ8b+orssnKrBFbRXMc8xG3gXNxrZ/VU7zaCdTxMx/l0O
/BT7ekxDkW7NjaN8n8fJFQ+35wTsOjQLqqicRNCD3zwfGSS2jaH65hnaeJ4CJHyt
sLgotzAU4y+mBoespXEr4NheNrdlKWac6pkbMts1USLNZ6lNjyU8W6krV5qUlwFy
iAYRaYcBdiyoDFKjf1oHXdK6pQoZjSevvWjkQUc0m9Nk5WBKYAs=
=4IfC
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--
