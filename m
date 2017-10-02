Received: from eggs.gnu.org ([2001:4830:134:3::10]:44156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2sJ-0005x7-V2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2sI-00031B-TB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:43:20 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<20171002143919.207741-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7afabb38-abb6-a261-20a0-48aa6526c315@redhat.com>
Date: Mon, 2 Oct 2017 10:43:04 -0500
MIME-Version: 1.0
In-Reply-To: <20171002143919.207741-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xush7muGLxKAvb7vG0N40g4KxN2O33diC"
Subject: Re: [Qemu-devel] [PATCH 1/5] hbitmap: add next_zero function
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xush7muGLxKAvb7vG0N40g4KxN2O33diC
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Message-ID: <7afabb38-abb6-a261-20a0-48aa6526c315@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] hbitmap: add next_zero function
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
 <20171002143919.207741-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171002143919.207741-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> The function searches for next zero bit.
> Also add interface for BdrvDirtyBitmap.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/dirty-bitmap.h |  1 +
>  include/qemu/hbitmap.h       |  8 ++++++++
>  block/dirty-bitmap.c         |  5 +++++
>  util/hbitmap.c               | 29 +++++++++++++++++++++++++++++
>  4 files changed, 43 insertions(+)
>=20

> +++ b/block/dirty-bitmap.c
> @@ -715,3 +715,8 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitma=
p *bitmap, Error **errp)
>  {
>      return hbitmap_sha256(bitmap->bitmap, errp);
>  }
> +
> +int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t =
offset)
> +{
> +    return hbitmap_next_zero(bitmap->bitmap, offset);
> +}

Returns an answer in the same scale as the underlying hbitmap; if this
is applied before my byte-based dirty bitmap series, that means offset
is a sector count and the result is likewise a sector number (awkward);
if this is applied after my series, you pass in a byte offset start and
get a byte result (nice).

I don't see any obvious errors in the implementation, but DO think that
you should include a testsuite enhancement in tests/test-hbitmap.c to
cover the new functionality before we accept this.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xush7muGLxKAvb7vG0N40g4KxN2O33diC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSXogACgkQp6FrSiUn
Q2p7BwgAgN3dVI6NZQRN8+wpOvjdLphW3uAAEX8GKb1woG2MFBnpjNMrgjgUwgXj
6LAbUjOeM2erdvRNjjugEQGzY/gEBiCRzP2M2z8osIzOY2hv92uIDF4ZYTUryp5u
KuDlsgGJwk0xM7Y1UuKXaGjigAPiENi+Bzw9dnp4OJUPXcbkqMlJHPjFIfkJ83qk
QBxRizzdoSgU3eOgaStpz59/3wlWuOoLitpmteYMaoBjzg7EUkW0MLQvHEVtv600
00349R0P9B0dBL62MgZ2L0yUceY6+B3gCndDjPPJPlm08SVTYVAwQLKWAXB5defm
GrLC6WK21Mccyu06YECAE4Wcw31UWw==
=Zsa6
-----END PGP SIGNATURE-----

--Xush7muGLxKAvb7vG0N40g4KxN2O33diC--
