Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY94i-00063b-DS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY94h-0001Jt-K7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:57:28 -0400
Date: Wed, 27 Jun 2018 12:57:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627115721.GJ5955@stefanha-x1.localdomain>
References: <20180626142434.22090-1-kwolf@redhat.com>
	<20180626142434.22090-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <20180626142434.22090-6-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] block: Use tracked request for
 truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 04:24:33PM +0200, Kevin Wolf wrote:
> When growing an image, block drivers (especially protocol drivers) may
> initialise the newly added area. I/O requests to the same area need to
> wait for this initialisation to be completed so that data writes don't
> get overwritten and reads don't read uninitialised data.
>=20
> To avoid overhead in the fast I/O path by adding new locking in the
> protocol drivers and to restrict the impact to requests that actually
> touch the new area, reuse the existing tracked request infrastructure in
> block/io.c and mark all discard requests as serialising.
>=20
> With this change, it is safe for protocol drivers to make
> .bdrv_co_truncate actually asynchronous.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int.h |  1 +
>  block/io.c                | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM3uhAAoJEJykq7OBq3PIRBIH/iu9VW9FEFtQDE0pSlNoCiwF
Y9WJi+CDqCVFABgnzoekA51mJiGaaoo1FEyB3h6pKpxKsdtMevFU3xMC885Kc4NS
DipUGR3+Bdg+CQGjwT5g0WUnMVF8TsPekkR7QF/697Ni5KOSySFt2Jl58gecxLz9
bTM+ZjNpyLmk5qxf3arSibpEUhcj27Xo1ae6PRDvT5gQSiy2NrbRYyb18T4LDxBo
1RxWAeweEdzn9ZEInUFrulEcZtYQi9LAz2g3S7UOrZGeGpJH02ybBaz1OtNdkNUv
vexU4+a94c32zbIQWG3hsCidc2vKLOs7Rai1ibyMbOBm9Ew7BMgze1gEexmV1hw=
=+1Fi
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
