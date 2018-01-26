Received: from eggs.gnu.org ([2001:4830:134:3::10]:51443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef7eN-0006a6-Sw
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef7eM-0006gQ-Vz
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:18:51 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a072d58-8bec-b23a-4ac9-2f4c1ec866ce@redhat.com>
Date: Fri, 26 Jan 2018 10:39:11 -0600
MIME-Version: 1.0
In-Reply-To: <9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ipHRGM55qzipOOeVJXiZQBwUgsSrlFSZe"
Subject: Re: [Qemu-devel] [PATCH v3 19/39] qcow2: Update get_cluster_table()
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ipHRGM55qzipOOeVJXiZQBwUgsSrlFSZe
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <1a072d58-8bec-b23a-4ac9-2f4c1ec866ce@redhat.com>
Subject: Re: [PATCH v3 19/39] qcow2: Update get_cluster_table() to support L2
 slices
References: <cover.1516978645.git.berto@igalia.com>
 <9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
In-Reply-To: <9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
> This patch updates get_cluster_table() to return L2 slices instead of
> full L2 tables.
>=20
> The code itself needs almost no changes, it only needs to call
> offset_to_l2_slice_index() instead of offset_to_l2_index(). This patch
> also renames all the relevant variables and the documentation.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ipHRGM55qzipOOeVJXiZQBwUgsSrlFSZe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprWa8ACgkQp6FrSiUn
Q2r0RAf/b6uE8ei6cSxBItYW7Ql37pv/d36LnI4N+mh2sOHMtRHMOmrxhjrCeL6n
RjwOLN6cvCRCcqQzwh0aF/aBOVNh6F9tq7wzfjqYGKcdpq46A57ut+Q8+3N8zDsQ
fE55nSIn7oGN4HHfi4W4a70FclNsGlCLlJp4AONm+6gUVDOJ40nLBIGvLiCA7HJg
K+Seek9i1nvB8zHCwiNXkwST9swEsdgJ3t74wjXCIWjzfijVqQQ7vPCay4sEKb77
4v20psGYtI2HQetB5TLF1x27r40TAHLPRxITImC7fzwh2llWoaS+H8O4TaCmdGLH
7D7GrZfYvetFLtONFa8d0F7WHRgUbg==
=5x0W
-----END PGP SIGNATURE-----

--ipHRGM55qzipOOeVJXiZQBwUgsSrlFSZe--
