Received: from eggs.gnu.org ([2001:4830:134:3::10]:50970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnxsr-0001RY-P2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnxsn-0005wj-8u
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnxsn-0005wM-2f
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:37:45 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-35-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09cc4d47-3ab1-0017-ebf4-701dd63bf1da@redhat.com>
Date: Tue, 14 Mar 2017 20:37:42 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-35-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QnRcvvi9bkwF4FbCgdWEWMPpOF56gh11c"
Subject: Re: [Qemu-devel] [PATCH for-2.9 34/47] qapi: Move empty doc section
 checking to doc parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QnRcvvi9bkwF4FbCgdWEWMPpOF56gh11c
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <09cc4d47-3ab1-0017-ebf4-701dd63bf1da@redhat.com>
Subject: Re: [PATCH for-2.9 34/47] qapi: Move empty doc section checking to
 doc parser
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-35-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-35-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Results in a more precise error location, but the real reason is
> emptying out check_docs() step by step.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py                         | 20 ++++++++++++++------
>  tests/qapi-schema/doc-empty-section.err |  2 +-
>  2 files changed, 15 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QnRcvvi9bkwF4FbCgdWEWMPpOF56gh11c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyJrmAAoJEKeha0olJ0NqWmYIAIqlGxrFhos4WTqgezWvOEcP
fu2FOsm778xBpM1hYHk/lVDZTGeq3qgSTcxPP/wcuxlUISQQoGpKdlhU4v24AgSn
+YwcBGqCQvvW4qTfCUxYt9Pf9Nt/u+vJkNf4I+1tBE6F8YOJy5ZiIu7nyJnP5S2I
v4vef5jpKpSBWyYTqDUfkj9Z7dJtVd5FK3J5YcSBScBxZmxxjZmNvcvXvW4fgQWG
5arBzVqpxlXsodF+z7YtgxxMhOLHgmxgkT1Q875TdB7IJLaiD4Puh1qYNg6rCJvk
QH4Q1MRfUJGUQRnMTRRy1DYRdJ3owTUGckHh0j4BukuqRyjItVNqzFIDJEF0o5o=
=lHpb
-----END PGP SIGNATURE-----

--QnRcvvi9bkwF4FbCgdWEWMPpOF56gh11c--
