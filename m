Received: from eggs.gnu.org ([2001:4830:134:3::10]:53794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzv0-0003BQ-Qp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzuz-0007Wc-R0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:42:02 -0400
References: <20170714103105.5781-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9a31f2d-6ff5-bb85-79ef-b06f569e5b6f@redhat.com>
Date: Fri, 14 Jul 2017 07:41:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170714103105.5781-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sfJojiCVVVcv9fOnrPgWtPGD0tLfqpn4h"
Subject: Re: [Qemu-devel] [PATCH] qcow: fix memory leaks related to
 encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sfJojiCVVVcv9fOnrPgWtPGD0tLfqpn4h
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <c9a31f2d-6ff5-bb85-79ef-b06f569e5b6f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow: fix memory leaks related to encryption
References: <20170714103105.5781-1-berrange@redhat.com>
In-Reply-To: <20170714103105.5781-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 05:31 AM, Daniel P. Berrange wrote:
> Fix leak of the 'encryptopts' string, which was mistakenly
> declared const.
>=20
> Fix leak of QemuOpts entry which should not have been deleted
> from the opts array.
>=20
> Reported by: coverity
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow.c  | 5 +++--
>  block/qcow2.c | 7 ++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sfJojiCVVVcv9fOnrPgWtPGD0tLfqpn4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaLwRAAoJEKeha0olJ0NqrpkIAJ8qTk//8eY59RreI7ZTf47E
aiFJltwYlBFn380UYElXWvSOQ/50Y6MSwe9M1neLQE6Xrnc2or1u053K7snhxd6u
7zKbz3ZaCOt8E3Zu4ROv/jvz7IN80YVdgN3DzYbIKWkiII9ggt1u4KNM8A2r4ECW
7nrnysKQc7T/pp0qAY+f1S1pCElHQI/3NoJrxijZpngfRi7824AH49CvOiWRcwCS
zDU1uyFlBp0uApemADsBuvzwv8FRBIAXWOmhnLI+kbMO9NsLo8UpJOrpk2qnvt7F
rY+dIBQFeP5/PSOt5yVjTLUEdUUk7bWfLF/Acu1tz82e49FhkOnlIGpfxF4ugpM=
=NJtI
-----END PGP SIGNATURE-----

--sfJojiCVVVcv9fOnrPgWtPGD0tLfqpn4h--
