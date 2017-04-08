Received: from eggs.gnu.org ([2001:4830:134:3::10]:39068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cx6v4-0007ng-Rv
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 03:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cx6v1-0000N2-Lo
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 03:05:54 -0400
Date: Sat, 8 Apr 2017 16:51:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170408065107.GG27571@umbus>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 11:37:49AM +0530, Nikunj A Dadhania wrote:
> The series enables Multi-Threaded TCG on PPC64
>=20
> Patch 01: Use atomic_cmpxchg in store conditional
>       02: Handle first write to page during atomic operation
>       03: Generate memory barriers for sync/isync and load/store conditio=
nal
>=20
> Patches are based on ppc-for-2.10

Applied to ppc-for-2.10.  Anyone object to that for 2/3, which isn't
within ppc code?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6IhZAAoJEGw4ysog2bOSFxAP/itlEISwDN1kFWxrRo4C/38d
1q3J1MNRfaWjw1kgXtJ23Xj2uEOG7+ci20VXPsL6hMb91NsbMqfCOiNwwsMxhIc9
OvLEukyxnXQIDTRNOwoPQprfj6uQkbWoKxXvtjCg9LTEe4KdExqmwmqyzHN6tOoX
VHsKsMKoNyMJ0PQap4IPjRQV3s5PynkypSJ0//Ako9NpcjI5EeY7GEcsrByRH//U
vUjcR9cQ03ViTWcLnjr8cdqrVtozGBzBsvG2ffy8HwtV1OrDrwcPc2ZCrZnBDB2x
eS52PebWkaFhgA6Er1WfjHm2f+DOAC5gi07tBfylqd/exO2uXGTgSiarPfDT/3tN
rOcEnPFXW3zq4ZMg16bkmoH7Nf8vCImcQUfxwBcty1mwDlUH86aAzMfbw/JRtK4C
NCAAaLbWR8TxoIVfZcSSTulFE9FnHIgbeySxGfnEGqyGFx51AXF1nxuub5LyLPFK
oU+ra+99bfQ8x8M8PmQgS1UWQNb7/BuzQiZNmQz6kWeubUlIMzQZi5uIt7J6hfu5
YW6QhNkdVhNAd10lULVmzVgVNkYtORsR9H+RMoGjCSMOc7fXxO01FIJCZnxEiCqh
cbeU81JOcPDtasq9mMCNsGdIXMpTNGU/d1tcXbTosunflJXwRxBAu7U+y1AGqTp8
xF5zjwT43uA/e4+xczv9
=ye3j
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
