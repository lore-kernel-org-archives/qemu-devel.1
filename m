Received: from eggs.gnu.org ([2001:4830:134:3::10]:48311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRQnZ-0004OO-S7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRQnV-0004an-06
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:51:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRQnU-0004aA-N3
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:51:08 -0500
References: <20170111182455.15160-1-nirsof@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <750c2d41-dac2-61f7-29c3-82d8d13a0de6@redhat.com>
Date: Wed, 11 Jan 2017 15:51:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170111182455.15160-1-nirsof@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TIGg5iml2InmqFkbxonn3xDivhisQVxFH"
Subject: Re: [Qemu-devel] [PATCH] qemu-io: Return non-zero exit code on
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TIGg5iml2InmqFkbxonn3xDivhisQVxFH
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>
Message-ID: <750c2d41-dac2-61f7-29c3-82d8d13a0de6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-io: Return non-zero exit code on
 failure
References: <20170111182455.15160-1-nirsof@gmail.com>
In-Reply-To: <20170111182455.15160-1-nirsof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 12:24 PM, Nir Soffer wrote:
> From: Nir Soffer <nsoffer@redhat.com>
>=20
> The result of openfile was not checked, leading to failure deep in the
> actual command with confusing error message, and exiting with exit code=
 0.
>=20
> Here is one example - trying to read a pattern from an invalid chain:
>=20
>     $ qemu-io -c 'read -P 1 0 1024' top.qcow2; echo $?

As written, you have to guess some context about how top.qcow2 was
created.  The example can be made a bit more reproducible with:

$ : > file
$ qemu-io -f qcow2 -c ... file

>     can't open device top.qcow2: Could not open backing file: Image is =
not in qcow2 format
>     no file open, try 'help open'
>     0
>=20
> With this patch, we fail earlier with exit code 1:
>=20
>     $ ./qemu-io -c 'read -P 1 0 1024' top.qcow2; echo $?
>     can't open device top.qcow2: Could not open backing file: Image is =
not
>     in qcow2 format
>     1
>=20
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>  qemu-io.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Whether or not the commit message is improved,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TIGg5iml2InmqFkbxonn3xDivhisQVxFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdqjJAAoJEKeha0olJ0NqJekIAKZN1MpB7WKA9bHUE9d1w5XA
UNflUtlxVZYxm2ZNN/gXVJPmmKI4TkmtXpLBUilmeB8DUXQm4eUCi2zf1KBZes7p
6h1j9pCnJNYotMglgdV8uzqPjKrKs8cGQwxlZ9jZt/9uzR5mG3S0w6bQO4s6bXmU
KfOEUGcXAC4Pl2RY+Kyq+Ws2R94AMEpYk3lVR9UhyJsupvm8rvqtn5+P2keeTIBX
H+m/Qj3Dcaonfp0NXyIhD+YFozb45oDKOzBloYfNsaKXbhUWbJoDkAszjYibKj1Z
sYyMDjXF33TFWNjBI7i+DO644W6H8nBKwItLvKNZIRJOE6GVHexEKrE5bHCpB5I=
=nYHM
-----END PGP SIGNATURE-----

--TIGg5iml2InmqFkbxonn3xDivhisQVxFH--
