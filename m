Received: from eggs.gnu.org ([2001:4830:134:3::10]:43880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDBwd-0008Gi-PU
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDBwc-0001ld-TC
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:41:59 -0400
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
	<1495548064-10926-4-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2bf654ba-4f30-78f6-ea71-50a12274540e@redhat.com>
Date: Tue, 23 May 2017 10:41:27 -0500
MIME-Version: 1.0
In-Reply-To: <1495548064-10926-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ACrEk1GTejjsgxkqFwR1DMxtISkNQw3Tv"
Subject: Re: [Qemu-devel] [PATCH 3/4] migration/block: Clean up BBs in
 block_save_complete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ACrEk1GTejjsgxkqFwR1DMxtISkNQw3Tv
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com
Message-ID: <2bf654ba-4f30-78f6-ea71-50a12274540e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] migration/block: Clean up BBs in
 block_save_complete()
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
 <1495548064-10926-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495548064-10926-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:01 AM, Kevin Wolf wrote:
> We need to release any block migrations BlockBackends on the source
> before successfully completing the migration because otherwise
> inactivating the images will fail (inactivation only tolerates device
> BBs).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  migration/block.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ACrEk1GTejjsgxkqFwR1DMxtISkNQw3Tv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJFgnAAoJEKeha0olJ0NqHnIH/j8gWdMp6qrxwhev3BfmjcWS
x6Td0FgpRbXCRjOQWZLpVMf0cVd7ILRpA1KLAIhaWMw8IkM24L+g+hJch6l414SU
rOnE6yebaxWWXtNPBhYIV3zOYn5b8JWH6RYYUOCp6Tg25SgX4sx8zI1Ti38k/sh7
duRjUbmXfiBzgWzMm+ehE22Cz7I+DfTS3KpZvA+Io4AJOaLyUmsGqnvZmDXlZ3pg
nA4/Jf4M4fJDcUsXtsxWQqJ2ScuL009Jx61d/xaRguYRcwuygqp07Yb/aKJwkLxn
WWwO/Xpa/uQKFDhJv33BzXC7xaWa3bTXJfII3aWLwH+l4cMik/RlN3gdAIS3SIk=
=4CNK
-----END PGP SIGNATURE-----

--ACrEk1GTejjsgxkqFwR1DMxtISkNQw3Tv--
