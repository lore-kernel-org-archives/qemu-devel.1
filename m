Received: from eggs.gnu.org ([2001:4830:134:3::10]:45016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEdRw-0006ve-Eb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEdRv-0001MO-MG
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:48:32 -0500
References: <20171004152553.30263-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5b518c81-288b-065d-ba18-3d27f9dd7e52@redhat.com>
Date: Tue, 14 Nov 2017 16:48:21 +0100
MIME-Version: 1.0
In-Reply-To: <20171004152553.30263-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qiQ1ukccetvjiCNVx1KImqEEqXvagJ5Cv"
Subject: Re: [Qemu-devel] [PATCH v6 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qiQ1ukccetvjiCNVx1KImqEEqXvagJ5Cv
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5b518c81-288b-065d-ba18-3d27f9dd7e52@redhat.com>
Subject: Re: [PATCH v6 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
References: <20171004152553.30263-1-mreitz@redhat.com>
In-Reply-To: <20171004152553.30263-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-04 17:25, Max Reitz wrote:
> bdrv_reopen_prepare() assumes that all BDS options are strings, which i=
s
> not necessarily correct. This series introduces a new qobject_is_equal(=
)
> function which can be used to test whether any options have changed,
> independently of their type.
>=20
>=20
> v6:
> - Patch 2: Added corresponding Coccinelle rule [Eric]
> - Patch 6:
>   - Added .gitignore entry [Eric]
>   - Removed leading underscore [Markus]
>   - Replaced test_equality() by check_equal()+check_unequal() [Markus]
>   - Put type conversion (or rather non-conversion) tests into an own
>     function [Markus]
>   - Fixed a line > 80 characters

Dropping from my queue because of a clang compiler warning in
tests/check-qobject.c.

Max


--qiQ1ukccetvjiCNVx1KImqEEqXvagJ5Cv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLEEUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlXwH/0jgcgEMrQLTjlt6WMDgEEOtmWDgoh2a
VLmHyKt7JGK0Nmm7/z6xO2TEaVTbjYNDo5PLHi7Ki484e6H8fi+eMxvxIgP3jbIi
ogZKpYnEw8Dd2dqKR33KVDDSC8VyYg1erGbK3Gi2HP+B3wGSdmoa5Sne7ChHLyn4
pvgccRKPQdtpQeWNtrOjcMXteJuIz3DMyrLJwxNLAbuwAiYIwwGXzBS0uuJ4VbwM
BvM+j7H4pi1YySKgaOByy+FMmyldnkGsvclccZIbNxtPUH42nW0mEooIacPY0Txh
vpAfATN3VpxiBzWLr1gapbUCSTHGTqSjwo2Dj6VfqbXKRVOs2rb/LjE=
=yxis
-----END PGP SIGNATURE-----

--qiQ1ukccetvjiCNVx1KImqEEqXvagJ5Cv--
