Received: from eggs.gnu.org ([2001:4830:134:3::10]:53639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elI6C-0008Nv-9o
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elI6B-0006Kw-Fw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:41:04 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-24-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5354a1e2-855a-2dea-84d4-b93b852f480b@redhat.com>
Date: Mon, 12 Feb 2018 18:40:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-24-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KNUPilNNXcAjtZ7gZLd4xupX47RhrshjA"
Subject: Re: [Qemu-devel] [PATCH 23/27] ssh: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KNUPilNNXcAjtZ7gZLd4xupX47RhrshjA
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <5354a1e2-855a-2dea-84d4-b93b852f480b@redhat.com>
Subject: Re: [PATCH 23/27] ssh: Support .bdrv_co_create
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-24-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-24-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to ssh, which enables
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 16 ++++++++-
>  block/ssh.c          | 92 +++++++++++++++++++++++++++++---------------=
--------
>  2 files changed, 67 insertions(+), 41 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--KNUPilNNXcAjtZ7gZLd4xupX47RhrshjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqB0ZsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A24gH/3f4y2vHXWru8MfafylqCRCjD+df7iYD
z2boNMDZf8cN9mJ5CMWIemr/WIEzo1j7TyDCYZ5PYjuBI7tNJqBQdnTabI5KOkmH
Nzz6Fn8czZmGgOdc49PvnpZQf+McRm90GuqNHFWPQIMnoqQCtDUl8c8IvMshW++P
ABQ0qYV7bEdmgCAa7rb5bUJhaO1pRU4vcSulkMF5xemII2kBbPxH3pRx+gUiakTW
td6e/XQHX/9e/thMiwAqg5ASan8jvJsGqqvZ0rlN9ck+FIqKIevysWNkCYs0YbVg
Q+unsWC0T0poxEiIqEShDqv5lG6k904xI4bD2Rm+RjZ3+2ClVLvcpes=
=9tIK
-----END PGP SIGNATURE-----

--KNUPilNNXcAjtZ7gZLd4xupX47RhrshjA--
