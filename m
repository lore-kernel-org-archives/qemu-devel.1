Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAcdG-0000Eq-0B
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAcdF-0003HM-8N
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:35:22 -0400
Date: Tue, 16 May 2017 14:34:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516133458.GE8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/18] block: access copy_on_read with
 atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:41:51PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: use atomic_fetch_dec [Stefan]
>=20
>  block.c                   |  6 ++++--
>  block/io.c                |  8 ++++----
>  blockdev.c                |  2 +-
>  include/block/block_int.h | 11 ++++++-----
>  4 files changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGwACAAoJEJykq7OBq3PISHAIAMP0ZdFYivPVv9iGhKLwzfST
RLU1tqINtiUwrvfBtEZcm1Ok5mp1p0TWRLET3h4TjOl7TdnrOc+Nj5FYzzBqYoaK
JzEaOH+fHtEtmd97oHzRtJTXT7yEZHH+GZ3kW91AI0RwQqg/diyeEhrUPvUiCq4b
B/xkp5qckZ8R7WHkbUloWPyqCgyTv40RVWR2unGm4bOXC0aN1YNqbvXP45a59ioy
So4xeDjRIW7nC7J4sPWgxHLVYs18ZJKW7DTZfFrXw2pBfszIhjx+QKHfEZQWeQ8T
Qql7Bo/5M/L9ebfXa8mljo0Ws5Lxs0y4/UZY0OhGauJDlQkI4dTVji4/R744AKY=
=RoLc
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
