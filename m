Received: from eggs.gnu.org ([2001:4830:134:3::10]:58593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVtZ-0006Le-Pu
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVtY-0005Z5-Mx
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:17:45 -0500
Date: Thu, 12 Jan 2017 14:17:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112031734.GI14026@umbus.fritz.box>
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/7] POWER9 TCG enablements - BCD
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, eblake@redhat.com


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 12:10:07AM -0200, Jose Ricardo Ziviani wrote:
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

Patches 1-5 applied to ppc-for-2.9, remainder left with a suggestion
for improvement.

>=20
> bcds.: Decimal signed shift
> bcdus.: Decimal unsigned shift
> bcdsr.: Decimal shift and round
> bcdtrunc.: Decimal signed trucate
> bcdutrunc.: Decimal unsigned truncate
>=20
> Jose Ricardo Ziviani (7):
>   host-utils: Move 128-bit guard macro to .c file
>   host-utils: Implement unsigned quadword left/right shift and unit
>     tests
>   ppc: Implement bcds. instruction
>   ppc: Implement bcdus. instruction
>   ppc: Implement bcdsr. instruction
>   ppc: Implement bcdtrunc. instruction
>   ppc: Implement bcdutrunc. instruction
>=20
>  include/qemu/host-utils.h           |  27 +++++
>  target/ppc/helper.h                 |   5 +
>  target/ppc/int_helper.c             | 217 ++++++++++++++++++++++++++++++=
++++++
>  target/ppc/translate/vmx-impl.inc.c |  16 +++
>  target/ppc/translate/vmx-ops.inc.c  |  13 ++-
>  tests/Makefile.include              |   5 +-
>  tests/test-shift128.c               | 139 +++++++++++++++++++++++
>  util/Makefile.objs                  |   2 +-
>  util/host-utils.c                   |  66 +++++++++++
>  9 files changed, 483 insertions(+), 7 deletions(-)
>  create mode 100644 tests/test-shift128.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdvVOAAoJEGw4ysog2bOSZqMQAJxvdAXwIg9PmexjTpnvMafO
0hd2XU4w5ezMrN8tHtS4/YPQ5pPQusFOrV2Jqs6WQHij5OYCXVAAuTq/WBfsLRhg
WRvR0cBNaWcjGyFyqrrruUu2u6MOym02QA9eUaza04fIpC+KQXXz6iXyZwReI1MS
5BHD3RV3TpgMZAL7E95JMmYvJHyUzZKTgeHQYkTcZS5/evrALSDzKBS9TR+KB1gT
XYioiNlAv8XcLkZhVEuYZlA0EFqThg2tgzd8xNIU5tBwf9GeJUh9+QcsUERRxIan
8hdV71htdIxwrZN5r4eJvajiLeCbzaFvhaYOhNyozpcgPCveEMdTY3uTj/jXGda/
7NZtbtlHbS6mRjO+LxJCRJrNG8Cx3awUofImV+oH7FwfW703NWMoJxCQR7y+REZ3
Uzf4Jzf0Yae41PQDTKTPuDb7KlEwjM/U7obSMs/+0I1kNaTiL2LFTNYKWrMMv3Vi
HCWi224V45PderyLofWrknUYnMp8HTBNoBSsPTWEuN//0s02nKy78OPJlkZxoHvr
J63uBbIyEQjBs8okQh23Kq7CA/s1U3iv8/ojFPcxQL4QUSKsjWn/EzKTsEvVjXVg
80T9UDTXbMAgze6jOj5WgJRJ0OLCAJOtuJWYZuVZ2BN6/0/i68fPY5FHKwdchmHJ
REjoYexLk0ZEkdd9LJ7g
=oMGp
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
