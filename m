Received: from eggs.gnu.org ([2001:4830:134:3::10]:60498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edinM-0005ll-Tp
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edinM-0006An-3t
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:34:20 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<8149f6ab70fda930585b8ee38a583a006343730c.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f4aa43d-629a-b450-9770-2fe7edbf6cd4@redhat.com>
Date: Mon, 22 Jan 2018 14:34:12 -0600
MIME-Version: 1.0
In-Reply-To: <8149f6ab70fda930585b8ee38a583a006343730c.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s7z2AINGVH93IZwjw4DNFDnTazHgR7UuY"
Subject: Re: [Qemu-devel] [PATCH v2 29/32] qcow2: Rename l2_table in
 count_contiguous_clusters_unallocated()
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
--s7z2AINGVH93IZwjw4DNFDnTazHgR7UuY
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <2f4aa43d-629a-b450-9770-2fe7edbf6cd4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 29/32] qcow2: Rename l2_table in
 count_contiguous_clusters_unallocated()
References: <cover.1513342045.git.berto@igalia.com>
 <8149f6ab70fda930585b8ee38a583a006343730c.1513342045.git.berto@igalia.com>
In-Reply-To: <8149f6ab70fda930585b8ee38a583a006343730c.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices intead of full tables, the l2_table
> variable is renamed for clarity.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s7z2AINGVH93IZwjw4DNFDnTazHgR7UuY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmSsQACgkQp6FrSiUn
Q2oqXQf+PLWK3ncn54mDLqmuPQOI69dqwyJojgneu5xtqVJqnGNjiQ6i4HeG9PnJ
O8qES/x3I2F1ij+CAeNZRybJ/DQNfenwwcB+oJLVqt7WwEFnPZW6quCNNZlYCG2t
vQbLLeXcAgwLn3r5eIFwXwFJKnQ8ILEiMqvDY7+RpNf2savPrwmKAIvCJtEpKv5F
csRD0ZJ2Ao0vzxKI5nLWFxhDgg++IVlBMyrUNSE7fw+3uuXQsaSZCAWYSWSllkW+
4JpayDIwkhj4mN7c/xPiLLeN39po7Qkao+X8klvZTq9ekl0p+ozzxpd9zR2Tve5L
g3dBBXagcc8Wx19jun4n4EJ+0xs0nQ==
=lV6j
-----END PGP SIGNATURE-----

--s7z2AINGVH93IZwjw4DNFDnTazHgR7UuY--
