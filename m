Received: from eggs.gnu.org ([2001:4830:134:3::10]:43970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epDl1-0001pG-Iu
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epDl0-0006xB-MQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:51:27 -0500
References: <20180214204915.7980-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f28b6063-ac44-719f-9472-a365556620f9@redhat.com>
Date: Fri, 23 Feb 2018 14:51:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180214204915.7980-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cTdiNAFcJSSsHXJ8bh56sg6cGRDjCEm8V"
Subject: Re: [Qemu-devel] [PATCH 0/3] block/ssh: Add basic .bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cTdiNAFcJSSsHXJ8bh56sg6cGRDjCEm8V
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>
Message-ID: <f28b6063-ac44-719f-9472-a365556620f9@redhat.com>
Subject: Re: [PATCH 0/3] block/ssh: Add basic .bdrv_truncate()
References: <20180214204915.7980-1-mreitz@redhat.com>
In-Reply-To: <20180214204915.7980-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-14 21:49, Max Reitz wrote:
> For (x-)blockdev-create, all protocol drivers that support image
> creation also need to offer a .bdrv_truncate() implementation that
> matches in features.  A previous series of mine brought gluster's and
> sheepdog's implementation up to par regarding preallocated truncation;
> but I forgot about drivers that have a .bdrv_create() but no
> .bdrv_truncate() at all.
>=20
> There is only one of these, and that is ssh.  Since libssh2 does not
> seem to know any way of truncating files, we can only support growing
> files -- but that is what we need for (x-)blockdev-create.
>=20
> Note that there are also drivers which do not support growing files,
> namely iscsi and file-posix for host devices (maybe more?  I hope not).=

> But these also pretty much ignore the specified size on .bdrv_create()
> and just use the size of the existing device.  They just check that the=

> specified size does not exceed the actual size, so that pretty much
> matches what their .bdrv_truncate() supports, and we should be fine
> there.
>=20
>=20
> Max Reitz (3):
>   block/ssh: Pull ssh_grow_file() from ssh_create()
>   block/ssh: Make ssh_grow_file() blocking
>   block/ssh: Add basic .bdrv_truncate()
>=20
>  block/ssh.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
--------
>  1 file changed, 53 insertions(+), 8 deletions(-)

Applied to my block branch.

Max


--cTdiNAFcJSSsHXJ8bh56sg6cGRDjCEm8V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqQHFUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AtiwH/Rf6t9KD2weJz1SubaEd1QYcWdfkw8jY
TED2rSfyu3Gigf6utkNxxf0DGB/v66CBdBGZdYMkaJ2rvvII59QWPQu+HInyH1kL
ecYW7jB/A2H0Zyw5Oc9+XZF8XH9ZHb6Cgt6V6sdkwVWA9vFHFAFEsGk3E6dhjn0V
qS1i2rymalDHxanSPA8MPoRo3m0DIhacX25vyOd8EmQ5YStvKV1xrVKYTCHczTJy
lEGCtz9h6gCC1TT6+qVQaIyTSsEg0P9FQOknjNu+jdgwUb5D7hCADHRDZy8Xz7F6
6ipcvbdwjsizmk2AJPQt7AyuKs3pnHIhhY2oA8cJdTPHHEjolKlco30=
=DUS2
-----END PGP SIGNATURE-----

--cTdiNAFcJSSsHXJ8bh56sg6cGRDjCEm8V--
