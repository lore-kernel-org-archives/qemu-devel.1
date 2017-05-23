Received: from eggs.gnu.org ([2001:4830:134:3::10]:46589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDC4X-0003lo-4f
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDC4R-0004ck-1r
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:50:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDC4Q-0004cY-Ot
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:50:02 -0400
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149554994914.23396.9158086745678389330.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f769a5b-7059-070d-d9c4-8f730f0d4127@redhat.com>
Date: Tue, 23 May 2017 10:49:58 -0500
MIME-Version: 1.0
In-Reply-To: <149554994914.23396.9158086745678389330.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1CCNFX3OnJwXRqlj8MvWJdkcqcVoH0Up1"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] 9pfs: local: resolve special
 directories in paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1CCNFX3OnJwXRqlj8MvWJdkcqcVoH0Up1
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>
Message-ID: <0f769a5b-7059-070d-d9c4-8f730f0d4127@redhat.com>
Subject: Re: [PATCH v2 2/4] 9pfs: local: resolve special directories in paths
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <149554994914.23396.9158086745678389330.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <149554994914.23396.9158086745678389330.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:32 AM, Greg Kurz wrote:
> When using the mapped-file security mode, the creds of a path /foo/bar
> are stored in the /foo/.virtfs_metadata/bar file. This is okay for all
> paths unless they end with '.' or '..', because we cannot create the
> corresponding file in the metadata directory.
>=20
> This patch ensures that '.' and '..' are resolved in all paths.
>=20
> The core code only passes path elements (no '/') to the backend, with
> the notable exception of the '/' path, which refers to the virtfs root.=

> This patch preserves the current behavior of converting it to '.' so
> that it can be passed to "*at()" syscalls ('/' would mean the host root=
).
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> +            } else {
> +                char *tmp =3D g_path_get_dirname(dir_path->data);
> +                /* Symbolic links are resolved by the client. We can a=
ssume
> +                 * that ".." relative to "foo/bar" is equivalent to "f=
oo"
> +                 */

Thanks for tweaking this since v1.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1CCNFX3OnJwXRqlj8MvWJdkcqcVoH0Up1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJFomAAoJEKeha0olJ0NqGDoIAKOkLr80SkWKLtgiu/izsPLq
1z0aurl0aUlZgBRaSLsdE5hKqaVHrpJwJAfbsht8ZDsyQeOzZiWDyxvK0QWYysJP
ObwqJTBAi67BNhJGmDj6C2RcJPyZnBxnh3D+4bmWwVO0kUx2+RB6Q+jDXApIZ689
qIK0aUznCS6FVcMCpicwarfWUh0NJnq8Hw48bZ8qNkABibX1C+sm5I6vPcIfozKR
BAki0AyuE+lPpyojZ4tJejvkqw4dvEKyBxBf1E8IG94J8BHcffnQbjxNxT5aO9k6
QAXqbJyOnZ6mDBHktAJUk+lorIFWMM41Lat41PO4knbzugCkD+JYI64trJPa8KY=
=00y8
-----END PGP SIGNATURE-----

--1CCNFX3OnJwXRqlj8MvWJdkcqcVoH0Up1--
