Received: from eggs.gnu.org ([2001:4830:134:3::10]:33507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcqKQ-0001U0-Hk
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcqKP-0005dC-P4
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:52:34 -0400
Date: Wed, 2 Aug 2017 10:52:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802095226.GC5531@stefanha-x1.localdomain>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <20170801134907.31253-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 2/3] block: skip implicit nodes in
 snapshots, blockjobs
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


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 04:49:06PM +0300, Manos Pitsidianakis wrote:
> diff --git a/block.c b/block.c
> index 886a457ab0..9ebdba28b0 100644
> --- a/block.c
> +++ b/block.c
> @@ -4947,3 +4947,20 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverSt=
ate *bs, const char *name,
> =20
>      return drv->bdrv_can_store_new_dirty_bitmap(bs, name, granularity, e=
rrp);
>  }
> +
> +/* Get first non-implicit node down a bs chain. */
> +BlockDriverState *bdrv_get_first_non_implicit(BlockDriverState *bs)

Linguistically non-implicit =3D=3D explicit and that would be simpler.

Alternatives to implicit/explicit are:

  transient/permanent
  internal/external
  self-created/user-created
  worker/user

Let's agree on one and use it consistently.  I like the worker nodes vs
user nodes because it reflects their function.

implicit/explicit is fine by me too.  I just think non-implicit is
clunky.

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgaDaAAoJEJykq7OBq3PIcnwH/1b14hEMBECDdt+lyz0vDJQK
7UJHVLoLKy3dWGCae52UjU/rMuom0E6ZEs3bXQeYEqVxm4iI3o2nmpfqIC16eRbQ
2WnoQIfigrg827+MvHqPCU5RvXq9buPeaGVOgcpOgf6qXixRcINSovb7jA5/++Po
xbwMkCl7MDLNFwwYcvIEZOY8cIMJcmCdGWpMuKCK6C4NHxnYF/GSC0wzgkZLDDHb
el7RP7n//QjEDzJ0Q87vznPq0kTSlWpwmEx3xai718SSWsnVYFQRx07CFHIdaWwi
KZkspZk5YbICsViuce/7S/rdivRNp5Cg4yqWdlVn+eDwHgXbEXNLjTrRZw52eus=
=PjLU
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
