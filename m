Received: from eggs.gnu.org ([2001:4830:134:3::10]:55884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVEyX-0003SH-SH
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVEyX-00088H-5B
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:34:33 -0400
Date: Wed, 12 Jul 2017 11:34:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712103423.GD6923@stefanha-x1.localdomain>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <20170711163748.17817-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v4 1/4] block: pass bdrv_* methods to
 bs->file by default in block filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 07:37:45PM +0300, Manos Pitsidianakis wrote:
> The following functions fail if bs->drv is a filter and does not
> implement them:
>=20
> bdrv_probe_blocksizes
> bdrv_probe_geometry
> bdrv_truncate
> bdrv_has_zero_init
> bdrv_get_info
>=20
> Instead, the call should be passed to bs->file if it exists, to allow
> filter drivers to support those methods without implementing them. This
> commit makes `drv->is_filter =3D true` imply that these callbacks will be
> forwarded to bs->file by default, so disabling support for these
> functions must be done explicitly.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c                   | 21 +++++++++++++++++++--
>  include/block/block_int.h |  6 +++++-
>  2 files changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZfsvAAoJEJykq7OBq3PIE9IH/ROWj9xOi7JsoC3Ctox06Wy7
NNCKVbKnNe78h/NZ3hnwmR8ZEW8VDIEbA4NjXqfFlCLTzPXarp8bONCazgecTFT5
a5ggEbIQ33fsScXU6GEvogQ9qRFEMTaUIs37YilDSJjKnv5wcrPEUYOqZP6VqP2Z
iTU6Ks31vFZKNERHexTpw7jEaPBOxDCPgwhKM0z6m7LujLUKwXmuoRRGKvRNvu/s
Xza7V4p78B6tYNK3+EMNJe5IANJmirZgAaj4Mt1xW6WhH9tqOtANgFFBai9D083n
fcmLiCWXB2NNzi8eBgp9C42l8l7QJ64wnfXt2Y0TB/+S42jj3QtOXkd8S5GTgLs=
=m6eK
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
