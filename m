Received: from eggs.gnu.org ([2001:4830:134:3::10]:56856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebr2E-0003UK-HY
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebr2D-0004Pr-Ku
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:57:58 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<93ac7be373e194f4dfcc73c0bea96bd1c00209da.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c598660-ccc6-226b-57ce-9198cc89bc78@redhat.com>
Date: Wed, 17 Jan 2018 10:57:35 -0600
MIME-Version: 1.0
In-Reply-To: <93ac7be373e194f4dfcc73c0bea96bd1c00209da.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iw5EHgkJotJrz6BJmYX2bvYnLSMnOL4Fa"
Subject: Re: [Qemu-devel] [PATCH v2 28/32] qcow2: Rename l2_table in
 count_contiguous_clusters()
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
--iw5EHgkJotJrz6BJmYX2bvYnLSMnOL4Fa
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <7c598660-ccc6-226b-57ce-9198cc89bc78@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 28/32] qcow2: Rename l2_table in
 count_contiguous_clusters()
References: <cover.1513342045.git.berto@igalia.com>
 <93ac7be373e194f4dfcc73c0bea96bd1c00209da.1513342045.git.berto@igalia.com>
In-Reply-To: <93ac7be373e194f4dfcc73c0bea96bd1c00209da.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices intead of full tables, the l2_table
> variable is renamed for clarity.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iw5EHgkJotJrz6BJmYX2bvYnLSMnOL4Fa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfgH8ACgkQp6FrSiUn
Q2pU/wf+KjAX7/AHa7q09SZqqxwhlRRg3jqlL7Z1ppyws6szuQV24Igkd0qkIqzh
/2fc1o30+L5u2+g18NlLAtaDWBhWsbavmoonuef14AEALlhA7kdLyKVcGwFREZ/O
oMbt7APheb+nuERj/HP3tGtJnsNIuZQCst+oIrl3fCvnOrHaiega1KgQoSM1s4At
/8SHU6hdPRpFaeZ1ERegOh16qDNNwPzfj+iqztXcR1Y4xXsnBVyeGfiAnoJ4NdsY
KIFXgBl/N7tlY/f0FBGssyqPN3F/kwU/Ey/N6cP2E+LdTK+YgHP09jsYtUEyY7rg
xwrGdHr4exDHalH43KBYD7Sd1tpY4g==
=hmTQ
-----END PGP SIGNATURE-----

--iw5EHgkJotJrz6BJmYX2bvYnLSMnOL4Fa--
