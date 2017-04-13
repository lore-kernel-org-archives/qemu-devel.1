Received: from eggs.gnu.org ([2001:4830:134:3::10]:52191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cym3y-0006r3-AA
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cym3x-0000hp-CW
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:13:58 -0400
References: <20170413203401.3213-1-mreitz@redhat.com>
	<20170413203401.3213-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d1c07ac-38d3-806e-5682-2c5d519de049@redhat.com>
Date: Thu, 13 Apr 2017 16:13:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170413203401.3213-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tadn27PUUdUvXQOOegLjRdOh7r8MgBc3l"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/3] qemu-img/convert: Use @opts
 for one thing only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tadn27PUUdUvXQOOegLjRdOh7r8MgBc3l
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <2d1c07ac-38d3-806e-5682-2c5d519de049@redhat.com>
Subject: Re: [PATCH for-2.10 2/3] qemu-img/convert: Use @opts for one thing
 only
References: <20170413203401.3213-1-mreitz@redhat.com>
 <20170413203401.3213-3-mreitz@redhat.com>
In-Reply-To: <20170413203401.3213-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 03:34 PM, Max Reitz wrote:
> After storing the creation options for the new image into @opts, we
> fetch some things for our own information, like the backing file name,
> or whether to use encryption or preallocation.
>=20
> With the -n parameter, there will not be any creation options; this is
> not too bad because this just means that querying a NULL @opts will
> always return the default value.
>=20
> However, we also use @opts for the --object options. Therefore, @opts i=
s
> not necessarily NULL if -n was specified; instead, it may contain those=

> options. In practice, this probably does not cause any problems because=

> there most likely is no object that supports any of the parameters we
> query here, but this is neither something we should rely on nor does
> this variable reuse make the code very nice to read.
>=20
> Therefore, just use an own variable for the --object options.
>=20
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tadn27PUUdUvXQOOegLjRdOh7r8MgBc3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7+oMAAoJEKeha0olJ0NqcWkH/RdROx0zqvYYhPHXUj392JpK
czmPjbOzpJp6oAHfh13xcxqtR2Y/SDp/FStjk0cWq9PgrWqLCLfswpifJQdmLtwU
LYZXjxHmetcqFiokUDKL8WWTBbEsF98LIRobbE/3U6aQoiifWHYpOW2md0Nn3e88
18eV/xy7SrzbMyw7SecaBrrpwEjSCU6bcpnKzGqNJi+r+6T+iFsBs0MGVK1zNyTY
Pdo0SsMMP9sRC1kbmFnvELctZYe6LoVgD0xR3kNGFfGaGutooqfBZ5++Uv5Q1Yzj
8psIioS8S01bDvmDcEF/PRm2LlTI4a+nVkVeKrqcsmaqL5BKvSTv77wmkl32QU0=
=5s1v
-----END PGP SIGNATURE-----

--tadn27PUUdUvXQOOegLjRdOh7r8MgBc3l--
