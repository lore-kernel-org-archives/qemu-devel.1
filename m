Received: from eggs.gnu.org ([2001:4830:134:3::10]:48695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek9BW-0005kQ-Dt
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ek9BV-0001vT-Ov
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:57:50 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-4-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <96c44a8d-8058-cbd8-4fba-57da9387dcbc@redhat.com>
Date: Fri, 9 Feb 2018 14:57:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aAClGavif514HYjFxM1UiNZzYnpDXP8Yb"
Subject: Re: [Qemu-devel] [PATCH 03/27] qcow2: Let qcow2_create() handle
 protocol layer
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
--aAClGavif514HYjFxM1UiNZzYnpDXP8Yb
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <96c44a8d-8058-cbd8-4fba-57da9387dcbc@redhat.com>
Subject: Re: [PATCH 03/27] qcow2: Let qcow2_create() handle protocol layer
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-4-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Currently, qcow2_create() only parses the QemuOpts and then calls
> qcow2_create2() for the actual image creation, which includes both the
> creation of the actual file on the file system and writing a valid empt=
y
> qcow2 image into that file.
>=20
> The plan is that qcow2_create2() becomes the function that implements
> the functionality for a future 'blockdev-create' QMP command, which onl=
y
> creates the qcow2 layer on an already opened file node.
>=20
> This is a first step towards that goal: Let's move out anything that
> deals with the protocol layer from qcow2_create2() into qcow2_create().=

> This means that qcow2_create2() doesn't need a file name any more.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c | 64 +++++++++++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 38 insertions(+), 26 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--aAClGavif514HYjFxM1UiNZzYnpDXP8Yb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp9qNUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMxYH/R99x/hzonge/DSzBu1cCbcRFG7ujNIS
4G/UhD/Dn4P3hN8PVOCg4Q3SRJ2qwNkbsrCkDKvQLHzpUqCX4dEzYpniRqj52zsD
k/XBWuY+5+wh3qvV4o9X0Am3Vg6Ow0V4tcb3Fo0jkL0bvaDHDQR+L8PXfiucIB3J
rvHO+6DH4qYiCo0U98I+em2kj6d9+Fj/dV+rW0Vi8V3q4iJRxli119WmRM8jtCbP
OTrlKezcEiU7c2uZnFCHy3LCrFSS4nEHYbopPJV/a2HqeblUpXNuVQ743YpvuojC
14g1lS24yFDhiJuUhCN21OngPfm8mFNuxZ38lfg5gr5cgzl5Zh+t+aE=
=w5JN
-----END PGP SIGNATURE-----

--aAClGavif514HYjFxM1UiNZzYnpDXP8Yb--
