Received: from eggs.gnu.org ([2001:4830:134:3::10]:34753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0I-0008FP-It
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0E-0001xr-Mq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:58 -0500
Date: Fri, 13 Jan 2017 10:32:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112233206.GE13656@umbus.fritz.box>
References: <1484251713-25560-1-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <1484251713-25560-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] POWER9 TCG enablements - BCD
 functions - final part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Applied to ppc-for-2.9.

On Thu, Jan 12, 2017 at 06:08:31PM -0200, Jose Ricardo Ziviani wrote:
> v6:
>  - improves bcdtrunc/bcdutrunc overflow comparison
>  - removes bcds/bcdus/bcdsr applied patches
>=20
> v5:
>  - removes 'unlikely' gcc branch pred. hints from not unlikely places
>  - adds comments in host-utils functions
>  - adds more test cases for shift functions
>  - handles "shift backwards" with signed shifts
>  - rebases branch
>=20
> v4:
>  - improves functions to behave exactly like the target
>=20
> v3:
>  - moves shift functions to host-utils.c and added config_int128 guard
>  - changes Makefile to always compile host-utils.c
>  - redesigns bcd[u]trunc to use bitwise operations
>  - removes "target-ppc: Implement bcd_is_valid function" (merged)
>=20
> v2:
>  - bcd[s,sr,us] uses 1 byte for shifting instead of 4 bytes
>  - left/right functions in host-utils are out of CONFIG_INT128
>  - fixes overflowing issue in left shift and added a testcase
>=20
> This serie contains 5 new instructions for POWER9 ISA3.0, left/right shif=
ts for=20
> unsigned quadwords and a small improvement to check whether a bcd value i=
s=20
> valid or not.
>=20
> bcdtrunc.: Decimal signed trucate
> bcdutrunc.: Decimal unsigned truncate
>=20
> Jose Ricardo Ziviani (2):
>   ppc: Implement bcdtrunc. instruction
>   ppc: Implement bcdutrunc. instruction
>=20
>  target/ppc/helper.h                 |  2 +
>  target/ppc/int_helper.c             | 88 +++++++++++++++++++++++++++++++=
++++++
>  target/ppc/translate/vmx-impl.inc.c |  9 ++++
>  target/ppc/translate/vmx-ops.inc.c  |  6 +--
>  4 files changed, 102 insertions(+), 3 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYeBH2AAoJEGw4ysog2bOS/JUP/1APfF9JhyrTYpwyit8ae29g
I8PmmVBLwviJ2EXPNa+ajstKPN1GPFnfEB2ERaerub38n9FDiQyGdP7E5m0399WD
1r1fpiWzxJefMlvmJamuxQfJ7684afJkRylJ9Z/o7PtHn6UHNlB5Zgz1gPAAb8yB
2YmWTciuLZ14Nq8uBNYyIyGnZsQBefw2d2jM/A4k3eOVPwB3HoyE7ck4rKtG/nKK
8+PTyr0Sv6yf/VIohL98iGIN6c3OMK+hL0b1crg/lhQtwuebl00CnwLYbP2gW/uX
+zMpKYKKwDHowilbvqZLDxP3NpOeSVoK6dRVolbB7amqg1r/pDVU0AuYqr5EHcHd
2VotccYVRCtsmUqaaJox+91m6S+AIxeHA4b/u/BhAzsVg7kUqY/qHDomWmTkIu8u
z8pwv2cWWOVICiWiSh7AX+FX34jQfb94NQZQbNwPA66OfWme/8eOAGbjJ806LUYB
vVHc/Ggdite8x8ISa1ozM4+NxjRN7rCbhrz3sl+y//uu2om1lHnNj5O3o9SUA40k
4gsSferb+wKkQvtKIZCHLBDGAMcSpePUwiypa5UxnHaSq1zD/bqKa3qdlqevS/uK
ych3hyFpPa4OSRdCNDBKqMh5q3SD7pO8Tp6kfQO9Bf2jRsTKg+TpCCShqKdyq33o
9nDqHcThoHrImb3eJ5yc
=LKwz
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
