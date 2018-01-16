Received: from eggs.gnu.org ([2001:4830:134:3::10]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebY8T-0005YA-OG
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebY8S-0004N6-T6
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:47:09 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<cc1ca55a4f93a0eaf582286ce1f1f93b2a94d727.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6eb7f158-3acb-b3ee-d41f-e6b6b15bb8a3@redhat.com>
Date: Tue, 16 Jan 2018 14:47:00 -0600
MIME-Version: 1.0
In-Reply-To: <cc1ca55a4f93a0eaf582286ce1f1f93b2a94d727.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fYm3TTe8z6UpLkjfKQc86onhoGt6MVtQn"
Subject: Re: [Qemu-devel] [PATCH v2 01/32] qcow2: Fix documentation of
 get_cluster_table()
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
--fYm3TTe8z6UpLkjfKQc86onhoGt6MVtQn
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <6eb7f158-3acb-b3ee-d41f-e6b6b15bb8a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/32] qcow2: Fix documentation of
 get_cluster_table()
References: <cover.1513342045.git.berto@igalia.com>
 <cc1ca55a4f93a0eaf582286ce1f1f93b2a94d727.1513342045.git.berto@igalia.com>
In-Reply-To: <cc1ca55a4f93a0eaf582286ce1f1f93b2a94d727.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function has not been returning the offset of the L2 table since
> commit 3948d1d4876065160583e79533bf604481063833
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index a3fec27bf9..8163983d28 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -648,8 +648,7 @@ fail:
>   * for a given disk offset, load (and allocate if needed)
>   * the l2 table.
>   *
> - * the l2 table offset in the qcow2 file and the cluster index
> - * in the l2 table are given to the caller.
> + * the cluster index in the l2 table is given to the caller.
>   *
>   * Returns 0 on success, -errno in failure case
>   */
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fYm3TTe8z6UpLkjfKQc86onhoGt6MVtQn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeZMQACgkQp6FrSiUn
Q2oPGAf9GvL972W7RoxTlXroxP6/SCNyZg66vAj+xZChTe/DAwFQVl1aV7UdIPWp
c6PrkQT9GGgNzonBpn9lZzup2N1as5dGkVre/lMb19wz0mEtIN4AScW7mb3/IUMY
izIOr49sdMKP7oDR3iJ/DGZhDPEbJBZIw/4nE44fxG3mD4D0zuAAaO0nIA4gFm3X
x6fRR/gv10BKGfyJ9msSjI7ciXfnpx8c7Zpe49203D3bN3CH3EGgTLm0Iy//Sm3X
G8Cd66IrS5hEMyJXk4+64kHiiRQ0hf3BjUFRvQmwD56+CVkSbPHSZmQT0EUq744X
wHz/dnMGhFTEVxJdmkwE0dU4Ugk+5g==
=XFE+
-----END PGP SIGNATURE-----

--fYm3TTe8z6UpLkjfKQc86onhoGt6MVtQn--
