Received: from eggs.gnu.org ([2001:4830:134:3::10]:39320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce7EN-0002RR-Lw
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce7EK-00019t-Jl
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:35:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ce7EK-00019n-As
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:35:16 -0500
References: <cover.1487139038.git.ben@skyportsystems.com>
	<96c621a0c1588234e473bf0c0d068af8812f3225.1487139038.git.ben@skyportsystems.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebde49dc-fd80-895e-b73f-545ec9a966c8@redhat.com>
Date: Wed, 15 Feb 2017 15:35:13 -0600
MIME-Version: 1.0
In-Reply-To: <96c621a0c1588234e473bf0c0d068af8812f3225.1487139038.git.ben@skyportsystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vfHGGhrqNwP0VEU1vI5CKlnTbUtFp2IMb"
Subject: Re: [Qemu-devel] [PATCH v6 6/7] tests: Move reusable ACPI macros
 into a new header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, lersek@redhat.com, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vfHGGhrqNwP0VEU1vI5CKlnTbUtFp2IMb
From: Eric Blake <eblake@redhat.com>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, lersek@redhat.com, mst@redhat.com
Message-ID: <ebde49dc-fd80-895e-b73f-545ec9a966c8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 6/7] tests: Move reusable ACPI macros into
 a new header file
References: <cover.1487139038.git.ben@skyportsystems.com>
 <96c621a0c1588234e473bf0c0d068af8812f3225.1487139038.git.ben@skyportsystems.com>
In-Reply-To: <96c621a0c1588234e473bf0c0d068af8812f3225.1487139038.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 12:15 AM, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
>=20
> Also usable by upcoming VM Generation ID tests
>=20
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  tests/acpi-utils.h       | 75 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/bios-tables-test.c | 72 +---------------------------------------=
------
>  2 files changed, 76 insertions(+), 71 deletions(-)
>  create mode 100644 tests/acpi-utils.h
>=20
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> new file mode 100644
> index 0000000..d5e5eff
> --- /dev/null
> +++ b/tests/acpi-utils.h
> @@ -0,0 +1,75 @@
> +#ifndef TEST_ACPI_UTILS_H
> +#define TEST_ACPI_UTILS_H

No copyright blurb? Also, does MAINTAINERS need an update to cover the
new file?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vfHGGhrqNwP0VEU1vI5CKlnTbUtFp2IMb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpMmRAAoJEKeha0olJ0NqhCgH/2QcgUyZkq+UF4Yc8uLtrdey
i2DjIXO2r0/MvRjVYkvQtSInxTczvdxjQRYgZHrMBHtYoi+H7oBNjDWnvr9bf5AM
MPn92aTCbYrwop1JlzhhQBssW7MGfcrjJNJbDWXIoQwz0ylko9iNd9yQqzcqZ8aJ
ze4dtBKZu1wzMppqYHaNQ1w5KVA5QT38mDTUkiEttIhFXp9XEl7kq+7eOz0qt1N5
SjPjAcR6FAPGKdUuKJqjIi4viUsDPr5AgllQgrkjkLBv4Na4661CNkgGF+40KlSh
tGN7mJjCIDzbG/ti3IYcs2IbyXpQR22uZ5J7Ns6ZjsPRPYk50rZkw2beIX8SRtc=
=LfN0
-----END PGP SIGNATURE-----

--vfHGGhrqNwP0VEU1vI5CKlnTbUtFp2IMb--
