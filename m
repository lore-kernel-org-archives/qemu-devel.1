Received: from eggs.gnu.org ([2001:4830:134:3::10]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDBMB-0003hR-Gk
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDBM5-0000pp-MA
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:04:19 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:46225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDBM5-0000ox-GD
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:04:13 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E4E6AF4DA4
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 17:04:11 +0200 (CEST)
Date: Tue, 23 May 2017 17:04:06 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170523170406.6e862ab2@bahia.ttt.fr.ibm.com>
In-Reply-To: <149555082900.1095.16206351753645529469@c05f1edc8ed1>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149555082900.1095.16206351753645529469@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/fTDCqt5Zv/tAumNJa8O2nKp";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 0/4] 9pfs: local: fix metadata of
 mapped-file security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, leo@gaspard.io

--Sig_/fTDCqt5Zv/tAumNJa8O2nKp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2017 07:47:09 -0700 (PDT)
no-reply@patchew.org wrote:

> Hi,
>=20
> This series failed build test on s390x host. Please find the details belo=
w.
>=20
> Message-id: 149554993519.23396.2947622015408783770.stgit@bahia.lab.toulou=
se-stg.fr.ibm.com
> Type: series
> Subject: [Qemu-devel] [PATCH v2 0/4] 9pfs: local: fix metadata of mapped-=
file security mode
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
> # branch
> set -e
> echo "=3D=3D=3D ENV =3D=3D=3D"
> env
> echo "=3D=3D=3D PACKAGES =3D=3D=3D"
> rpm -qa
> echo "=3D=3D=3D TEST BEGIN =3D=3D=3D"
> CC=3D$HOME/bin/cc
> INSTALL=3D$PWD/install
> BUILD=3D$PWD/build
> echo -n "Using CC: "
> realpath $CC
> mkdir -p $BUILD $INSTALL
> SRC=3D$PWD
> cd $BUILD
> $SRC/configure --cc=3D$CC --prefix=3D$INSTALL
> make -j4
> # XXX: we need reliable clean up
> # make check -j4 V=3D1
> make install
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
[...]
>   CC      hw/9pfs/9p-xattr-user.o
> In file included from /var/tmp/patchew-tester-tmp-5niyvzwz/src/hw/9pfs/9p=
-local.c:18:0:
> /var/tmp/patchew-tester-tmp-5niyvzwz/src/hw/9pfs/9p-local.c: In function =
=E2=80=98local_set_mapped_file_attrat=E2=80=99:
> /var/tmp/patchew-tester-tmp-5niyvzwz/src/hw/9pfs/9p-util.h:19:5: error: =
=E2=80=98map_dirfd=E2=80=99 may be used uninitialized in this function [-We=
rror=3Dmaybe-uninitialized]
>      close(fd);
>      ^~~~~~~~~
> /var/tmp/patchew-tester-tmp-5niyvzwz/src/hw/9pfs/9p-local.c:235:9: note: =
=E2=80=98map_dirfd=E2=80=99 was declared here
>      int map_dirfd, map_fd;
>          ^~~~~~~~~
> cc1: all warnings being treated as errors

This is a false positive AFAICT... what compiler is this ?

> /var/tmp/patchew-tester-tmp-5niyvzwz/src/rules.mak:69: recipe for target =
'hw/9pfs/9p-local.o' failed
> make: *** [hw/9pfs/9p-local.o] Error 1
> make: *** Waiting for unfinished jobs....
>   CC      hw/9pfs/9p-posix-acl.o
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

--Sig_/fTDCqt5Zv/tAumNJa8O2nKp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkkT2YACgkQAvw66wEB28K9cACfTuNXTjX1GhkIaydKQ8lLeIZ7
8aUAoIV1NidTex+o5dGXBKcQtWY6ogOX
=efm/
-----END PGP SIGNATURE-----

--Sig_/fTDCqt5Zv/tAumNJa8O2nKp--
