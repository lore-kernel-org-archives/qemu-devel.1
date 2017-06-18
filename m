Received: from eggs.gnu.org ([2001:4830:134:3::10]:42142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMZGH-00008S-QZ
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 08:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dMZGE-0000rU-MM
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 08:25:01 -0400
Date: Sun, 18 Jun 2017 20:24:35 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170618122435.GH22449@umbus>
References: <201706051722.v55HMrD0024174@linux03a.ddci.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <201706051722.v55HMrD0024174@linux03a.ddci.com>
Subject: Re: [Qemu-devel] [PATCH v3] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Larson <alarson@ddci.com>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 10:22:53AM -0700, Aaron Larson wrote:
> Previously QEMU open-pic implemented the 4 open-pic timers including
> all timer registers, but the timers did not "count" or generate any
> interrupts.  The patch makes the timers both count and generate
> interrupts.  The timer clock frequency is fixed at 25MHZ.

Applied to ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZRnEAAAoJEGw4ysog2bOS4wMP/iAHnU/PzxVjBMygkU3/Hn5B
YbD08RzHs3Od1ZFKyUuSk2zOP+kRO9rQuvI/rhp2RNk9S3h0me3jL5mKlpx6Ld5w
KHgOlpk8X4gfPSCIezQ4+rY5ep817Q/J/KQ8RIYir8HzEyWYEfLu8J2qfYDdEnv2
47oeOEbisKJgcthpJjVE0Yk7rERJz+270kok3UPSA+ZGtkW2DiKpPlkojIwZd1VC
wwD5IBLb65LvUduZvrdgw9a2SAHXZHJRaqYzPg8y7iJDMG9Zm3ufLRN5/cMf8K2i
miVWqoe/Ee/OFwhIEEPB8u/ISyZ1zD700tsAeOWJDjrfa21/tgE856Zt/gDOfjMb
/zl0YhY/XF4N5RXcb8ryEs7LzpHKmwq/kLVH0mD7lf5/zOSQFt7T/uhWOgcK2/Km
G0UnDadQpAoQetxEm+yRDFB0jQ4uBLVF1PtxlouYPvluyrF6QuL22uM2Z12Ik0yA
xOAxtFdsOfG4ZSQjNTC7VwTZqd/xpu92JuiO3Cb9etwRW0tu/i2KEz9yJUOWbWdz
fpNvG9cxzSJYQs5x5AphwXROHIW8gVMmAKom3whZikX3U4VzQvYTcLgkVMojSQuB
9kziXdy9KbyPqAlE3ut2IyjfOT5+mDCm1zRI46z8Xjj+y6mftCfZEnmMHh9EE+D9
7d8TOpkTmJp0lJClqPa4
=aXq7
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--
