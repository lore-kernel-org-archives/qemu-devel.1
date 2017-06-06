Received: from eggs.gnu.org ([2001:4830:134:3::10]:37991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWI-0003Zv-Oh
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWF-0002S8-1v
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:30 -0400
Date: Wed, 7 Jun 2017 09:45:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170606234506.GF13397@umbus.fritz.box>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BqNvIJgrK1/MQy2W"
Content-Disposition: inline
In-Reply-To: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] ppc: fix memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org


--BqNvIJgrK1/MQy2W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 05:22:42PM +0200, Greg Kurz wrote:
> Coverity just reported a memory leak introduced by this commit (QEMU 2.9):
>=20
> commit df58713396f8b2deb923e39c00b10744c5c63909
> Author: Thomas Huth <thuth@redhat.com>
> Date:   Wed Feb 15 10:21:44 2017 +0100
>=20
>     hw/ppc/spapr: Check for valid page size when hot plugging memory
>=20
> It boils down to the fact that object_property_get_str() returns a string
> allocated with g_strdup(), which must be deallocated with g_free() at some
> point.

Applied to ppc-for-2.10.  Do we need to queue this for 2.9 stable as
well?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BqNvIJgrK1/MQy2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNz5/AAoJEGw4ysog2bOSu+UQAN9xvfE0F0oUw5JPPGz0uwHF
aBtXhbWHmUMMR2SgA3kt/Zbv3p2afvUHhHhsXa3vEoe6iLD66EDf5mjWxsD62+MR
Kt+cz/Rwelhj5KjveEeHnNS3HVutKGezp/4GP+xMzNXZ+yAUVNOqhijNH2AD1HBF
WjiJiE88V1SvqcClCPq570Gi0m1S1OYm8AyJApapGSQcxjNbj9NMwfXaclVr5AQV
7fxmEQqqO5MFo1quOXyu6DOPknsn2btiFqTk5eK6kWwuo3YJs/0rtSPSm+ziPb61
JOjRluHinongV6aw/R9PNmA2TDW+iiBHcwUr6cqrhCkgMoGjgiKsIOrxR+fshkWC
baeEXfkzXlW0RfJ2rdmoBgMRFj0W4LxR2h4F0NJ2r/oQ+tfk35B6gZHww+h49mQb
3WNcT3ACqvYz7TaiPADJXVArBCMRaG2hyZ2YphJmhvZzmfOm//V4EE6+WM1MbB1f
Z3myvmwkpuZ26sBOy1Dh3vR4ViHuY+fECksInOlQSLVQcQozEpa6Fk9y+zMR5fxl
fl9RuJwPoWaXl0sT9kAzCr4eTAnaXzjN7apPa154lVQfmGb3+s07Jr+LRyQ6hHLm
XEwndcKjnFOLmmpLywK82/2o5TzbenRN4zS/n+9dNh0e9SYPQg4QyYC2UIv7+Kxm
0RZkoizHqcuIvnzGdzgT
=Khuk
-----END PGP SIGNATURE-----

--BqNvIJgrK1/MQy2W--
