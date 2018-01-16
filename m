Received: from eggs.gnu.org ([2001:4830:134:3::10]:44431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZlY-0002wc-Aa
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZlX-0000os-9J
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:31:36 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<a54e0dd26c8894b31890a0681a7b95dbe444451c.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45b4a5de-034f-b669-5180-b37c58a7f27b@redhat.com>
Date: Tue, 16 Jan 2018 16:31:20 -0600
MIME-Version: 1.0
In-Reply-To: <a54e0dd26c8894b31890a0681a7b95dbe444451c.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7sDl5ua5XAd1iaXQnuU6ymLcGCwWHWQ9m"
Subject: Re: [Qemu-devel] [PATCH v2 17/32] qcow2: Update get_cluster_table()
 to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7sDl5ua5XAd1iaXQnuU6ymLcGCwWHWQ9m
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <45b4a5de-034f-b669-5180-b37c58a7f27b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/32] qcow2: Update get_cluster_table()
 to support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <a54e0dd26c8894b31890a0681a7b95dbe444451c.1513342045.git.berto@igalia.com>
In-Reply-To: <a54e0dd26c8894b31890a0681a7b95dbe444451c.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This patch updates get_cluster_table() to return L2 slices instead of
> full L2 tables.
>=20
> The code itself needs almost no changes, it only needs to call
> offset_to_l2_slice_index() instead of offset_to_l2_index(). This patch
> also renames all the relevant variables and the documentation.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index ecb75b6be6..3d43dc2307 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -660,20 +660,20 @@ fail:
>   * get_cluster_table
>   *
>   * for a given disk offset, load (and allocate if needed)
> - * the l2 table.
> + * the appropiate slice of its l2 table.

s/appropiate/appropriate/

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7sDl5ua5XAd1iaXQnuU6ymLcGCwWHWQ9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpefTgACgkQp6FrSiUn
Q2oMTAf6AjzwsWSvW68VMEXbF9vO1AQHvNxhDtpAkqbVY/wGTdUc5b+h5ddsHgAz
gU6fqPqQpPQ3pl8Shz4cI1Q4OIGDblxZ/+RvThmYcFmlN3n50n9xvROxm3IvhJAa
G9bTtohJ5a4iglBRoc3s4MaPxKMcWBUB9jQm+FCW1iXDtSFUa9/YZ5aKUhg1v++m
u9H7nA8rs/Zanl6yU5iFtgsx1d7SvVSUGLgc1GUsqq5sFY1iXK3ajg+PPHEX3jw4
v8bq/mHi4Lf272ekwvBVB8eDUhxarrlstaLmI1uPoqjRAo5uuzYYGEysd5ZWxbPl
NYVLFxIwsAUEjz6EWPawdb8TR+LphA==
=QjsM
-----END PGP SIGNATURE-----

--7sDl5ua5XAd1iaXQnuU6ymLcGCwWHWQ9m--
