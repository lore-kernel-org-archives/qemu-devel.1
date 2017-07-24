Received: from eggs.gnu.org ([2001:4830:134:3::10]:46402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZeTb-0004wh-UU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZeTb-00037t-3g
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:36:51 -0400
Date: Mon, 24 Jul 2017 15:36:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724143643.GG2784@stefanha-x1.localdomain>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
	<20170714094521.4909-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <20170714094521.4909-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 1/7] block: move ThrottleGroup membership
 to ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 12:45:15PM +0300, Manos Pitsidianakis wrote:
> This commit eliminates the 1:1 relationship between BlockBackend and
> throttle group state.  Users will be able to create multiple throttle
> nodes, each with its own throttle group state, in the future.  The
> throttle group state cannot be per-BlockBackend anymore, it must be
> per-throttle node. This is done by gathering ThrottleGroup membership
> details from BlockBackendPublic into ThrottleGroupMember and refactoring
> existing code to use the structure.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>=20
> Notes:
>     Dropped R-b because I changed some of the comments (removed all Block=
Backend
>         references in block/throttle-groups.c comments)
>=20
>  block/block-backend.c           |  66 +++++----
>  block/qapi.c                    |   8 +-
>  block/throttle-groups.c         | 288 ++++++++++++++++++++--------------=
------
>  blockdev.c                      |   4 +-
>  include/block/throttle-groups.h |  39 +++++-
>  include/sysemu/block-backend.h  |  20 +--
>  tests/test-throttle.c           |  53 ++++----
>  7 files changed, 252 insertions(+), 226 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdgX7AAoJEJykq7OBq3PI9psH/R3VjKDRQW6EADfcaflT60BW
zcNwRh45iZcSY5riKv6JMINgiNTLz5dvaiLmotttvKTp3bU0sLy9yq91ukDyKUR4
VPY0Hi5+Q0F7SqBTmKQ8BXGmfLx9gmWySWzvpaYsEwAiKmUwgXEiU9kPQ42TmnJD
JyPV0YdwrYLpIMOCiH3ktNcDLil+sAuKswWaoy0mOrywP6loPlJRvfreQet87tAc
Q2yPj9jalL/eewVceqmxWcaEKjVmJ97kVNGZAA9ibRW3KCBY9JXOtxPD6lVCqmBc
CtvUPh0iU1kge3RhhA3F27SsZtdJW2lVry2l/xMkEe0z5WrjqqeIJWyTIWQny0c=
=HCJK
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
