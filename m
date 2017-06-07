Received: from eggs.gnu.org ([2001:4830:134:3::10]:44673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dId85-0001Ok-Ih
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dId84-0000SZ-JK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:44:17 -0400
References: <cover.1496844254.git.berto@igalia.com>
	<8e633db98543522f6e5bd0f98dd1eb58291f6210.1496844254.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16e8f2c2-f429-96d3-8d37-fd5bd2ab498c@redhat.com>
Date: Wed, 7 Jun 2017 10:44:01 -0500
MIME-Version: 1.0
In-Reply-To: <8e633db98543522f6e5bd0f98dd1eb58291f6210.1496844254.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kTvXdmSaVTQcXFswMRl8t969b8c1i3jd8"
Subject: Re: [Qemu-devel] [PATCH v2 1/7] qcow2: Remove unused Error variable
 in do_perform_cow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kTvXdmSaVTQcXFswMRl8t969b8c1i3jd8
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <16e8f2c2-f429-96d3-8d37-fd5bd2ab498c@redhat.com>
Subject: Re: [PATCH v2 1/7] qcow2: Remove unused Error variable in
 do_perform_cow()
References: <cover.1496844254.git.berto@igalia.com>
 <8e633db98543522f6e5bd0f98dd1eb58291f6210.1496844254.git.berto@igalia.com>
In-Reply-To: <8e633db98543522f6e5bd0f98dd1eb58291f6210.1496844254.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 09:08 AM, Alberto Garcia wrote:
> We are using the return value of qcow2_encrypt_sectors() to detect
> problems but we are throwing away the returned Error since we have no
> way to report it to the user. Therefore we can simply get rid of the
> local Error variable and pass NULL instead.
>=20
> Alternatively we could try to figure out a way to pass the original
> error instead of simply returning -EIO, but that would be more
> invasive, so let's keep the current approach.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kTvXdmSaVTQcXFswMRl8t969b8c1i3jd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOB9CAAoJEKeha0olJ0NqxkYH+gOYP/oP4ONF1tsulcnv9TJh
2gUx7Z9+Zcb2xqkuX5DNq7K+3MlkVOBzEziwuHmskRZcK2h2NnswgT398KREOXf2
gWjVu7MHMlRJCLq03YpKnTgjMTK50gwqE6AYZEh1KlfbVC9kM0sImUgfg5YnkTfr
EDK/rzL0CjcucqXO3/pgXP8iKmiKOdrcEt1JcAi0gaPgq/8UErlRmizaXZw8rVXd
98IVyghO8nufAu0GIYtt8ABbPny3hhTtF/6OVDdwVfjmLlMD5ONOusUQOux9Gxoa
qnLSXzR2KUbT9pz3DtecpKFE+oMfYhfeq16g2VBWMl4j03uBTLrPCczZphALfcA=
=XexF
-----END PGP SIGNATURE-----

--kTvXdmSaVTQcXFswMRl8t969b8c1i3jd8--
