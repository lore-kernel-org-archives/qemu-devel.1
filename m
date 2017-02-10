Received: from eggs.gnu.org ([2001:4830:134:3::10]:47060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzFD-0002Ml-2L
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF9-000675-31
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:23 -0500
Date: Fri, 10 Feb 2017 11:28:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210002857.GO27610@umbus.fritz.box>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xexMVKTdXPhpRiVT"
Content-Disposition: inline
In-Reply-To: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] POWER9 TCG enablements - part15
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


--xexMVKTdXPhpRiVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 04:03:59PM +0530, Nikunj A Dadhania wrote:
> This series contains 6 new instructions for POWER9 ISA3.0

I've merged 1-4, 5 has comments.

>=20
> Nikunj A Dadhania (6):
>   target-ppc: generate exception for copy/paste
>   target-ppc: add slbieg instruction
>   target-ppc: add slbsync implementation
>   target-ppc: add wait instruction
>   target-ppc: support for 32-bit carry and overflow
>   target-ppc: add mcrxrx instruction
>=20
>  target/ppc/cpu.h        | 26 ++++++++++++++++++
>  target/ppc/helper.h     |  1 +
>  target/ppc/mmu-hash64.c | 16 +++++++++--
>  target/ppc/translate.c  | 72 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 113 insertions(+), 2 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xexMVKTdXPhpRiVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQlIAAoJEGw4ysog2bOS0QQP/0+lNne2z9Nc6QGTvQihxhSI
kgairn7AlH5OKY5wxlAy8rBWnYYtCbWEF3UG6qy2J2mbOtfSyM9rrt3lhcJwQ3C/
pc4qfTKzBwPPf4XgIVtREYU8IVb5S7OVUF63sUMT7THof2hyGVyfj0fsgV97bx0o
6nPFJVLYhdHG3riBZooIf4NLlvg0ghOA0fUZU5fMS65z3e4LNj54GXJj65IbAex5
AJXKTWceu+muIkmmb7GQ71RrvZe6YQRw0ITa/Bpb3+OX5UL7MjCOCZagti3BrUi6
oj9LelwZLF68U704jOJXMLd8wMbE4u+PBTOe1cNA4m7dGXf6ng87vEwknvdlEBQn
ko5zeVeAW0Ah8yldk6qif7aX8oHJewcScg0Ace107cZpNvFkl/ormYyuDU+HuGU2
NXstMBOg/5X6reXPwwlQCovqoCFZHmB5B0i6IKgT67vSQbzKstBj7sSaAbfcHbTl
ee9jRRLpuWo6PDzUN3aTNLE/ExVNZt40e+0cif0y4dqEpbj047RDwToDrjBx4HY8
aNJA4qenLVMtvRD2rW6JeOE88+0IyD2AbUsqMd97X0uuzvBhriZ1JrumLyGzT/m8
+wU5ClHtrmNmHynegQB7IfsdtfNOpho99Vm9IFIdinCLnO6J2n6a/pBjncNORLdg
4p78R7/WKzpDN2OakCDh
=dBCn
-----END PGP SIGNATURE-----

--xexMVKTdXPhpRiVT--
