Received: from eggs.gnu.org ([2001:4830:134:3::10]:53857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL9Wp-0004kH-Fp
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL9Wo-00084O-GH
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:44:15 -0400
Date: Wed, 14 Jun 2017 22:39:14 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170614143914.GB2614@umbus>
References: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
	<149744695984.5507.11604157257247801492.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <149744695984.5507.11604157257247801492.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v5 3/3] spapr: fix migration of ICPState
 objects from/to older QEMU
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


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 03:29:19PM +0200, Greg Kurz wrote:
> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> sPAPRCPUCore") moved ICPState objects from the machine to CPU cores.
> This is an improvement since we no longer allocate ICPState objects
> that will never be used. But it has the side-effect of breaking
> migration of older machine types from older QEMU versions.
>=20
> This patch allows spapr to register dummy "icp/server" entries to vmstate.
> These entries use a dedicated VMStateDescription that can swallow and
> discard state of an incoming migration stream, and that don't send anythi=
ng
> on outgoing migration.
>=20
> As for real ICPState objects, the instance_id is the cpu_index of the
> corresponding vCPU, which happens to be equal to the generated instance_id
> of older machine types.
>=20
> The machine can unregister/register these entries when CPUs are dynamical=
ly
> plugged/unplugged.
>=20
> This is only available for pseries-2.9 and older machines, thanks to a
> compat property.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQUqRAAoJEGw4ysog2bOS+dQP/jmGKX/EhsLCf7IY1ohQUJ7Q
RrYswERtQYwEg0JnLOxaTSLLX21UmVxsBtsHMR+gAoxS/ba4bky7CY47JSxJbOiQ
p2r/0bV8gKPD/lIZTiORAHsa6pSkdeFS1kNJJCdN/T7j2fHwtepxZK9Jk1mQqTrg
+gzRslcUm2Z20MfumsUoOe9nrxNDoqm0EfBk4VcWvxev0ahnExKUUhuO0YpOALtR
0qtg3OXqL+jzcRP8RowjUAGZwR3iqYTuBTyhmf8Xdx4wOTXbOWs9xw7HN/90+KZk
+FqJpD41NB+ZbwNhNrqjQ9rhLT8GUtkrGM9YVF/ewE7+IV+x3bamgXzq1zKqUuwi
IZKWhyD99mHl4QiVULv/PKDm9M19zlSDoNO9toPyul9smqwFbcvC46MIY0t7MpDa
eAxtQpuKyC9GVV5MRmx9uKwyoBD75V7B6ZmswhdAwvTJ3R/uFra+v2sq7Z2A2wKA
TAxMDUERMS+UkTwh3EmR4wp3oMiEGvE4gagfYF5uzY68g4LIpdiWGsUfV9ng0yCS
yChCclvRgI4tNOKyKbyksCeq8+jALcjyNIj7tgScwodByj2sDhwU2Aem/N/giqJW
Mb5k1Pji0vzAU/iSnAi64vC5zftz+/es+w9eoDqK5Ncd87V3WtUFufW7bpYY+Hxw
HZt0b4xfGM2YJeoNSRu7
=TFYc
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
