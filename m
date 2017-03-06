Received: from eggs.gnu.org ([2001:4830:134:3::10]:42497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzAS-0007bU-Dl
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzAR-0003Lg-Ei
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:23:40 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-6-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <803f7526-e205-a555-e77a-687aa5410ae0@redhat.com>
Date: Mon, 6 Mar 2017 14:23:32 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-6-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="muPA05sfDjt1QGc4OX63qi1d1moTEum64"
Subject: Re: [Qemu-devel] [PATCH 05/10] block: Fix blockdev-snapshot error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--muPA05sfDjt1QGc4OX63qi1d1moTEum64
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <803f7526-e205-a555-e77a-687aa5410ae0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/10] block: Fix blockdev-snapshot error
 handling
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-6-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:21 AM, Kevin Wolf wrote:
> For blockdev-snapshot, external_snapshot_prepare() accepts an arbitrary=

> node reference at first and only checks later whether it already has a
> backing file. Between those places, other errors can occur.
>=20
> Therefore checking in external_snapshot_abort() whether state->new_bs
> has a backing file is not sufficient to tell whether bdrv_append() was
> already completed or not. Trying to undo the bdrv_append() when it
> wasn't even executed is wrong.
>=20
> Introduce a new boolean flag in the state to fix this.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

By the way, how are you finding all these spots? Is it existing qemu-io
tests that are failing? And if so, would mentioning which test exposed
the problem being fixed be worth adding in the commit messages?  If not,
are there some qemu-io tests to be added?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--muPA05sfDjt1QGc4OX63qi1d1moTEum64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvcVEAAoJEKeha0olJ0NqMAIIAKEnsCR8I5c18v1DGwzVhIaJ
pEts8Gqv7ajYGdazHU2LHMPvErb/YD7ACAOzadRnOfhrlZ4xs3YB/9HgZ9ND4WPZ
5S5B3kZ4jHMZrHH9gL1Bpa8unZh0gygSn2pU5NuNrj+pUMV4ihMIBtRJ7IPTvzo5
gibWEL+B0QAsiqLTOpJfoI09hrjBNEHEHqsg7D/085g++S2zRZoGD21+TZUITJu8
PAxTZV29MoxqedTEKw5I/QqFUPLskbAvEbEioIq2f/oqdiR4uYOCNqpJyshHc5L8
PXCNp7Gj95/hQzJlY5MRQG32T+pIE8BzTSIk+WibymIOvYkwgxa7WAOpBO6pduc=
=sDlo
-----END PGP SIGNATURE-----

--muPA05sfDjt1QGc4OX63qi1d1moTEum64--
