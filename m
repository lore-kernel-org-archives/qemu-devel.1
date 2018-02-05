Received: from eggs.gnu.org ([2001:4830:134:3::10]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiwk-0005Hu-KQ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiwj-0000eW-Pc
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:44:42 -0500
References: <cover.1517840876.git.berto@igalia.com>
	<5f4db199b9637f4833b58487135124d70add8cf0.1517840877.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2a2a8555-6ee3-39dc-ac0f-fbc03efebaca@redhat.com>
Date: Mon, 5 Feb 2018 16:44:30 +0100
MIME-Version: 1.0
In-Reply-To: <5f4db199b9637f4833b58487135124d70add8cf0.1517840877.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OhVUictyLr3yzmtku1IzBtP7MfG5gx7Gq"
Subject: Re: [Qemu-devel] [PATCH v4 27/39] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OhVUictyLr3yzmtku1IzBtP7MfG5gx7Gq
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <2a2a8555-6ee3-39dc-ac0f-fbc03efebaca@redhat.com>
Subject: Re: [PATCH v4 27/39] qcow2: Update qcow2_update_snapshot_refcount()
 to support L2 slices
References: <cover.1517840876.git.berto@igalia.com>
 <5f4db199b9637f4833b58487135124d70add8cf0.1517840877.git.berto@igalia.com>
In-Reply-To: <5f4db199b9637f4833b58487135124d70add8cf0.1517840877.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-05 15:33, Alberto Garcia wrote:
> qcow2_update_snapshot_refcount() increases the refcount of all
> clusters of a given snapshot. In order to do that it needs to load all
> its L2 tables and iterate over their entries. Since we'll be loading
> L2 slices instead of full tables we need to add an extra loop that
> iterates over all slices of each L2 table.
>=20
> This function doesn't need any additional changes so apart from that
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--OhVUictyLr3yzmtku1IzBtP7MfG5gx7Gq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp4e94SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ak/MH/iY8FiJviUDt+loP/4dc9qheuJ2i34p7
IZSLmpVnG/D+I4L5egJtGLTQKIOZ3mOapn27cRlihyWQYfQMWpFmURW0Ci5WiAzv
GEaVXIN0VCLADGY0KhbeC3Kc4vCtr2bqgr3b5luxcYvtA+Bx5MfQf0Vn4iVbVNcF
5YNqJWb7lFoq0ofxP3qg8TQvDCTn5qMAI6s7thsqnsuhOFbOSKQHXWp5cXDv1IaT
O3jqzMpMyvgkuLDRBEhz2a03sfofRToAmQE1VJ1uMwjHq5AVzoYoKnFKWimfp1LA
LZt+KaLbzQrMVU2dnngYiiKzhMBzatNRMiUXdKvmkl30kN+L66MeILY=
=koYl
-----END PGP SIGNATURE-----

--OhVUictyLr3yzmtku1IzBtP7MfG5gx7Gq--
