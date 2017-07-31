Received: from eggs.gnu.org ([2001:4830:134:3::10]:37401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcBw6-0002Aj-Sz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcBw3-0007xW-Nt
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:44:46 -0400
References: <cover.1501508049.git.jcody@redhat.com>
	<3064c6292e5771533bab598210f7cbb791faa384.1501508049.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d9fbac9-b630-2bbc-3b9f-64cec1eedbf0@redhat.com>
Date: Mon, 31 Jul 2017 09:44:13 -0500
MIME-Version: 1.0
In-Reply-To: <3064c6292e5771533bab598210f7cbb791faa384.1501508049.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IBSwuwENntm9f9bjXtgEMW5xvPFKQLVLK"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 1/3] qemu-iotests: set TEST_DIR
 to a unique dir for each test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IBSwuwENntm9f9bjXtgEMW5xvPFKQLVLK
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com
Message-ID: <9d9fbac9-b630-2bbc-3b9f-64cec1eedbf0@redhat.com>
Subject: Re: [PATCH v2 for-2.11 1/3] qemu-iotests: set TEST_DIR to a unique
 dir for each test
References: <cover.1501508049.git.jcody@redhat.com>
 <3064c6292e5771533bab598210f7cbb791faa384.1501508049.git.jcody@redhat.com>
In-Reply-To: <3064c6292e5771533bab598210f7cbb791faa384.1501508049.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 08:47 AM, Jeff Cody wrote:
> Right now, all qemu-iotests output data into the same scratch directory=
,
> and so each tests needs to be responsible for cleanup up its own files.=


s/cleanup up/cleaning up/

>=20
> Have each test use 'scratch/$seq' as its temp directory, so the check
> script can do simple cleanup of removing the whole temporary directory.=

>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

R-b stands (thanks for adding the && fix from v1).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IBSwuwENntm9f9bjXtgEMW5xvPFKQLVLK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/Qj0ACgkQp6FrSiUn
Q2rmgwgAj1Bj3mJ2B5um1VoBnCDBhg9OLx+fxtsWgod/j9MR8iFnayPmGHul6Q1h
9fiAvsJnOKu9x76kL6Kg8sZqMVaVVfelczueVP4Qf3qoza2NTI6/P5+TA9XVK7PL
h6eiNIpIeJg+jS0D0PChpQphVI8QAfLcOyEEnvjjFUA45xx2vic9rglWwOnWU9hH
FwrORwZWN03OW0wG8+dA/w8gE6x7Ud35ZNkF6ZcWbk9Azbf6QdXtZ+lt2OBVAPZ2
JIvF6bTZ71KGgGxoKGOQ7j1mzpZy8wH80GZlrzYjICwHKb5q6f0gcitXV8O3ZxJ+
GFnbOc69oKILw1i9QE9aSQ+rRvtGlw==
=LJNv
-----END PGP SIGNATURE-----

--IBSwuwENntm9f9bjXtgEMW5xvPFKQLVLK--
