Received: from eggs.gnu.org ([2001:4830:134:3::10]:52564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddc8U-000416-OV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddc7i-0007u6-Up
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:55:26 -0400
Date: Fri, 4 Aug 2017 13:53:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170804125313.GE14565@stefanha-x1.localdomain>
References: <cover.1501827395.git.maozy.fnst@cn.fujitsu.com>
	<563a64c240fea15b4ed3902db9e4415ba85d7075.1501827395.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <563a64c240fea15b4ed3902db9e4415ba85d7075.1501827395.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] hw/block: Fix the return type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 06:26:41PM +0800, Mao Zhongyi wrote:
> When the function no success value to transmit, it usually make the
> function return void. It has turned out not to be a success, because
> it means that the extra local_err variable and error_propagate() will
> be needed. It leads to cumbersome code, therefore, transmit success/
> failure in the return value is worth.
>=20
> So fix the return type of blkconf_apply_backend_options(),
> blkconf_geometry() and virtio_blk_data_plane_create() to avoid it.
>=20
> Cc: John Snow <jsnow@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/block/block.c                | 15 +++++++++------
>  hw/block/dataplane/virtio-blk.c | 12 +++++++-----
>  hw/block/dataplane/virtio-blk.h |  2 +-
>  include/hw/block/block.h        |  4 ++--
>  4 files changed, 19 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZhG45AAoJEJykq7OBq3PIk+8H/3gtVuMWOIW5wArCZyDkJwyI
B5b8eHbwWTm9bT7jG6csEiU7Wbc7EXwAd6RIhL0QySJGFLmJxDD6qr03p89QVj53
QhPi+cmo7hXJ4U+GFwcxvvRjG6W+KEVnFKeK7NxK57tZS1DvfBGdNj3vrBjSPQeH
WrD6OnSL8qvgnwWkBuX1rZTeH3Y03wKT57wyKJ1KqNYNqfzkXmu5zPpOetNA1nMG
8DE6rKC8svK1g8uw7B2oWkso1K7t2pS+pX0ZRHrJ8ttbUett/HZaZZvCTlWlNPSs
3Nq1r7Gz83x3kF3cXJIBYhAE8P92i7f82feeDIMCRSZfH/UdrY+N7ZxtTiGRRv4=
=aqv4
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
