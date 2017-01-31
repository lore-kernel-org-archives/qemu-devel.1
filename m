Received: from eggs.gnu.org ([2001:4830:134:3::10]:50212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYZea-0007XS-LO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYZeU-0008B0-V7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:43:28 -0500
References: <20170131135703.5638-1-nirsof@gmail.com>
	<20170131135703.5638-2-nirsof@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b361c639-f7bb-b707-6010-6c0127aab10a@redhat.com>
Date: Tue, 31 Jan 2017 08:43:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170131135703.5638-2-nirsof@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UiVnQlEpMp1qQK7jMq0OlJbNSwUSvPXGi"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu-io: Return non-zero exit code
 on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Nir Soffer <nsoffer@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UiVnQlEpMp1qQK7jMq0OlJbNSwUSvPXGi
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Nir Soffer <nsoffer@redhat.com>, qemu-block@nongnu.org
Message-ID: <b361c639-f7bb-b707-6010-6c0127aab10a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu-io: Return non-zero exit code on
 failure
References: <20170131135703.5638-1-nirsof@gmail.com>
 <20170131135703.5638-2-nirsof@gmail.com>
In-Reply-To: <20170131135703.5638-2-nirsof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 07:57 AM, Nir Soffer wrote:
> From: Nir Soffer <nsoffer@redhat.com>
>=20
> The result of openfile was not checked, leading to failure deep in the
> actual command with confusing error message, and exiting with exit code=
 0.
>=20
> Here is a simple example - trying to read with the wrong format:
>=20
>     $ touch file
>     $ qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
>     can't open device file: Image is not in qcow2 format
>     no file open, try 'help open'
>     0
>=20
> With this patch, we fail earlier with exit code 1:
>=20
>     $ ./qemu-io -f qcow2 -c 'read -P 1 0 1024' file; echo $?
>     can't open device file: Image is not in qcow2 format
>     1
>=20
> Failing earlier, we don't log this error now:
>=20
>     no file open, try 'help open'
>=20
> But some tests expected it; the line was removed from the test output.
>=20
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---

Yay - v4 is a lot nicer! Thanks for putting up with our advice on making
your submission better.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UiVnQlEpMp1qQK7jMq0OlJbNSwUSvPXGi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkKJ8AAoJEKeha0olJ0NqRUUH/ib8IFz6lTOKYdmFf3rvbjRU
tOTCrSNHZjRFfJ0lSLcCH49clFsh1FIPFLzxLJbVHYuqOjNh//e9uE5zXwf4N45s
nrtUgHI41FLyXTJs6+Q4M363hqyElbBbuuUQ8XHnN+VOt7BcGE9aUBIvofqYaIR1
GlZ1GR/k2JnZ3hPWFPoDdw7lfB4opoRVtlubH9qV2i7LOncx4p+5uIAbqR47e2XT
rzKXEVK8ZekuJfsdNkt8vHp7eUiRVWHhZWL7t31QsTYyvUA/3xMhD5Mu+yS/UJTQ
3M100e74vsVXBewpBClSkF4ac8m7hiUJ2lfOooAii7GRlCQ/2Sq55EqRgBd2pxI=
=6yYM
-----END PGP SIGNATURE-----

--UiVnQlEpMp1qQK7jMq0OlJbNSwUSvPXGi--
