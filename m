Received: from eggs.gnu.org ([2001:4830:134:3::10]:53933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL9Ws-0004m8-In
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL9Wo-00084T-GO
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:18 -0400
Date: Wed, 14 Jun 2017 22:41:24 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170614144124.GC2614@umbus>
References: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v5 0/3] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 03:28:43PM +0200, Greg Kurz wrote:
> Cc'ing Laurent because I needed to incorporate the "spapr: manage hotplug=
ged
> devices while the VM is not started" patch in this series to be able to
> verify that the "CPU core unplug" part of patch 3 behaves as
> expected.

I've merged patches 2 & 3.  I haven't applied 1/3, because I think
it's really just a bandaid for other problems with the DRC state
management.

If you want to expedite getting that fixed, you could start by
reviewing my part IV DRC cleanups...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQUsTAAoJEGw4ysog2bOSBo4P+wZBNcoiMcMjMmEkwGJ8++J6
v5/6heNpDfbMkUvIDCXUKBokXQo2alX4YL6edjfq7umAVgyRtNb+mjW9xpsZvHXl
bBJ4FPKU0khwDbYxvv62elBqKFtS8OepX5uJ6iPQ5Ll8IGXmvahVdyO2QJR4jCcx
Qyq/ZJ2HIHQ8IjzNAhPM7Ye0W1eYeMKNmy7jugYnKDXLiFceZrC01dcATQF8mdG0
thAsKx9g+laSaMPOrjRlqX2tl8+7+Nkbpb7YQ2hf3bibJ67OwyYMTQBcO5Zj21np
Gt0mNrM3Z2BLGbPiGFrpIytjvK0rzLgRFPTdaUjGu+Lp9i0zNyUP+H4esob6TBtq
LorYZ9Jbhns8a5gR39ad2znFbZT1Fu2CMa4zkQCXgMXe8Sj3f+iy5FzGXz6abIFR
OUZM1U8b6Uj070g8oDgtt/NQjIgQAqppGzr2lc8MRaQWW6F+2B9bwNuRiU+SwBv+
fyyvzQKYWB0EB0RE1Q+o8K7AkehZ+m01igjJSnNeWVbHBV1IZC3PkXA0mUdjI14y
H/xS9hSfdsSjqo9vzMrZ1xGhqgmBaDQjviGyxj5Dm2iFWNg9CSSiTZvNTs7eATdq
jLM7LBPXnKA2ywGDbPWlJodNXW+EWzf18sc7pAyJ1ZbY5jM/92zFntLLkZVQJ/NA
wtxm01iW2kEPeXh6JWj2
=s50D
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
