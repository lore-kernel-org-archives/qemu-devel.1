Received: from eggs.gnu.org ([2001:4830:134:3::10]:41798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYlWw-0006Aw-DR
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 00:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYlWv-0005Uu-H3
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 00:33:26 -0500
Date: Mon, 17 Dec 2018 16:29:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181217052902.GD5597@umbus.fritz.box>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v8 00/12] ppc: support for the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:38:11PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here is the version 8 of the QEMU models adding support for the XIVE
> interrupt controller to the sPAPR machine, under TCG only. KVM support
> will be proposed in an other patchset, along with the KVM XIVE device
> patchset, so will PowerNV.
>=20
> The most important changes for sPAPR are the introduction of a 'ic-mode'
> machine option to select the interrupt mode of the machine and the fix
> for CPU hotplug.

I've applied 1-6, I have some minor comments on 7, still reviewing the
remainder.

We also need to fix that Windows build bug - I'm planning to fold /
insert that fix into the series so as not to break bisection.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwXNB4ACgkQbDjKyiDZ
s5I3ng//XDr8J1Ppm6nEo2kQOVKJgXmM6Y9Dq2WhQu9Lv2umxJI65Q33Ivywnj/V
8gmWL4BxwOFEn9fwqgomyk9acyk1lcGVPv9xtFDRcIvspAiMBAPG+BHv6l7KWaSW
SgDQjLWHHdZMtvPdyZehNW+agg6EnmVnzgMG3w1Q3cCneX2BYOTc3mIpn/N5Kaxu
ckTENrv+F9A6hr5cmaR/jWzPCwm7KxlIK3/770UYOdE+yDQ4adDZUzrAaxeexuRL
AsPtmQqixZZpofXuKIycZ5gfkrSb6R6HqV9PkitXso6Bm8kulzZjvCUOBxPNv2Xa
xvWYwSniFqIvF8igJIs5Fz+xvaJWiQGKocth9mWGmnf9FggPGEfsz3pJeq67Q8sx
fx0Jk26ctu8OqjF9FhgU8bgageUHA0MKRCxX8Vzl6jRO6Q0ztHmgVhwQRxWNagWt
xUCiEheQj8Bviss+f7YgLQR0NEwG6uElSxRQq8wvKerfzMOQ00WYHk4ejrUCHcUQ
Ng/oB4oKsgfnjPMCaJHXPoCmMwr9MvBmGss9eW3E0Sx1uuv8MQ50uWGiDkyxtoha
da+fPQNJ5c2RmGScnGx7mm5fwjI7uMNgPlDnqrWx3lGMC6ZQbgDtYangB27LYvfM
GD6VsUrDF+tIxTSwWI5EOxl4+Xzk+SOfOniD3Av48SAOOYR2u1w=
=p+T4
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
