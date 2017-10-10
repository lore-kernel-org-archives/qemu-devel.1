Received: from eggs.gnu.org ([2001:4830:134:3::10]:45800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e24Qt-0002T8-Rl
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e24Qp-0001Us-Ie
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:59:31 -0400
Date: Wed, 11 Oct 2017 10:20:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010232036.GB10496@umbus.fritz.box>
References: <20171010132159.15787-1-david@gibson.dropbear.id.au>
	<1507648227.3683.24.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <1507648227.3683.24.camel@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: Correct RAM size
 calculation for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: lvivier@redhat.com, groug@kaod.org, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 05:10:27PM +0200, Andrea Bolognani wrote:
> On Wed, 2017-10-11 at 00:21 +1100, David Gibson wrote:
> > In order to prevent the guest from forcing the allocation of large amou=
nts
> > of qemu memory (or host kernel memory, in the case of KVM HV), we limit
> > the size of Hashed Page Table (HPT) it is allowed to allocated, based on
> > its RAM size.
> >=20
> > However, the current calculation is not correct: it only adds up the si=
ze
> > of plugged memory, ignoring the base memory size.  This patch corrects =
it.
> >=20
> > While we're there, use get_plugged_memory_size() instead of directly
> > calling pc_existing_dimms_capacity().  The only difference is that it
> > will abort on failure, which is right: a failure here indicates somethi=
ng
> > wrong within qemu.
>=20
> Does this change invalidate in any way the calculation performed
> by libvirt to figure out the memory locking limit for guests?

No.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlndVcIACgkQbDjKyiDZ
s5LQAA//fOd6/2ortVDrAcg+9Q8YgXceSr7d3LDKSS6ZA9aNR5IycnSvCdrfoqcm
iU6VgPkf5zLCiGdl2f4ot16CJLhX8pi/9760b4bmtiEzUgL0o25tm/dKWDedJY9C
rGhCOcOstc9mpqvhNiQRoejJ30lW4vlv90TkpIRroshJQtChiP9vDT2cMzb5V0Cq
Zbf2to+oIgBVqMDOe68lR6b/uK8xzJ50rj4FlpH55AsYxUp3IqV5C9NlX+vCH5w4
XvARAiMlMsbma2vZaKU4oioBDM5oP1v1oUrjrDX0paNNpdM3v4hbMbtnwlJz/xYd
5FXEuMVKI54NJvvS0zwnN5St198ZG+ODYgzllJ5LhHctHpYA3GVutxwCj8aw2Itl
66+c0+BJTWM9K5G/Bllfu47lDA63vJe688xstyQH8Jm3CQ9V0jQ0uqawMs8ygbeK
/O2JZNoo31uRacCs0YA0m/pM3jHeyBjzpZGSkiAptYlHGI3YXEA8MlBXNAWj2yjR
yWgd5P2GIRAma9I1Blij/J2bZId7EmCHiYH/FjFd34Drytm9YbzqS80hKLaNDczE
OwyL6cRJxjHiQlXxT68744xNiN2vjvl4TVpWDr6oF2+R9kHurr9jFmuLWBY70tMR
hHARe8xjQ/vMlRw/3TqTjBvBOBO4ij/2htPfyqixRGDulZs5qmw=
=lenz
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
