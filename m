Received: from eggs.gnu.org ([2001:4830:134:3::10]:46891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvWT-0000sY-CS
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvWS-0008Ld-CN
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:39:29 -0400
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ec4e7ce-e748-1676-ff81-590321b1379b@redhat.com>
Date: Fri, 15 Sep 2017 13:39:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170915101008.16646-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lVptb4qcNjfm0S8LjX3FSAsqegGk09KnF"
Subject: Re: [Qemu-devel] [PATCH 3/6] block: Add reopen queue to
 bdrv_check_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lVptb4qcNjfm0S8LjX3FSAsqegGk09KnF
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <7ec4e7ce-e748-1676-ff81-590321b1379b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] block: Add reopen queue to
 bdrv_check_perm()
References: <20170915101008.16646-1-kwolf@redhat.com>
 <20170915101008.16646-4-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 05:10 AM, Kevin Wolf wrote:
> In the context of bdrv_reopen(), we'll have to look at the state of the=

> graph as it will be after the reopen. This interface addition is in
> preparation for the change.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lVptb4qcNjfm0S8LjX3FSAsqegGk09KnF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8HlYACgkQp6FrSiUn
Q2qotwf9GP50tQZnSK8nIAnHbzyd76oJYQN0ZAaaG7KwxrSg2fxaabR5jeMamJmi
vyNFsT9PTBdS2MuA0LBVqhrnAXQ4fVP+BV/fdRdB+dHQCLt7uGx5iIuRrxBbZCmh
wOXCz4+ghWFOKMFTC3cXfvgmX80zulrx9oqaIXU5p1d0Bcvt+mOnY4ReUxPCbltw
gB1Xmj5CHnKHjTcKFKYZo7g/IAjcP6U6vRMRGfDs9GyoM44LJgMlBzSYxqMhj+LZ
CiGKjSnnYXvVeh83onTMdNRrtA2KnXtUswHzXQEKYOKGFASKbbM4Eib0FyLPDBcs
L6bxZzjclAdNenO+/8WL+zve0eim+g==
=2NJl
-----END PGP SIGNATURE-----

--lVptb4qcNjfm0S8LjX3FSAsqegGk09KnF--
