Received: from eggs.gnu.org ([2001:4830:134:3::10]:36735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKyz-0006bD-TM
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKxv-0007Ox-U6
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:57:17 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<a9c6939ebedb97fb500bfb5e0e533afde4d8955a.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8aa3c78d-3c97-cfb5-54a0-40ae99ba58ca@redhat.com>
Date: Thu, 1 Feb 2018 20:48:48 +0100
MIME-Version: 1.0
In-Reply-To: <a9c6939ebedb97fb500bfb5e0e533afde4d8955a.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nv3pXvRN3Vd0425MHBRcZzLizux4zLYBP"
Subject: Re: [Qemu-devel] [PATCH v3 32/39] qcow2: Rename l2_table in
 qcow2_alloc_compressed_cluster_offset()
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
--nv3pXvRN3Vd0425MHBRcZzLizux4zLYBP
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <8aa3c78d-3c97-cfb5-54a0-40ae99ba58ca@redhat.com>
Subject: Re: [PATCH v3 32/39] qcow2: Rename l2_table in
 qcow2_alloc_compressed_cluster_offset()
References: <cover.1516978645.git.berto@igalia.com>
 <a9c6939ebedb97fb500bfb5e0e533afde4d8955a.1516978645.git.berto@igalia.com>
In-Reply-To: <a9c6939ebedb97fb500bfb5e0e533afde4d8955a.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices instead of full tables, the l2_table
> variable is renamed for clarity.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--nv3pXvRN3Vd0425MHBRcZzLizux4zLYBP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzbyASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AV5YIAJA9aebhdmyTTeiKKV8/+2vplL6dgbt7
ijXLEFsfaH9GUJNnQBuuz+4C4hPEjgPKbuERPo+NqcA5LfJ4uIxRQzklQsN54GnZ
o0af4zvwVBV+8UYU7Ay2hJRyYiROZjaYVDVI9sAWbLGxIj4dAdn54pALx7cIfVXd
5X0kizDjg3pqDFAYZZ8gWGrjXdHJ2nhKiiPdWnOCLulRbPNHbkwyGTT0SwwAQvPk
7LTZN+2hqszf7mU1jUOlZbnOivUsKL6Nd9+Y3fsOhj+SiFoKAmZiCN1etm5GpUCt
bfZvx9KkILLUEC7Kv9jD4WeBLmbSEvsn4PRRx96jYl2mAIKx3iamvRI=
=ErBP
-----END PGP SIGNATURE-----

--nv3pXvRN3Vd0425MHBRcZzLizux4zLYBP--
