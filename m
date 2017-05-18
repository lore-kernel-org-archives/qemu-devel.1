Received: from eggs.gnu.org ([2001:4830:134:3::10]:49278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBGzm-0003Jp-12
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBGzg-0002z0-W7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:41:18 -0400
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:41555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBGzg-0002ya-Ou
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:41:12 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2DA3DD3350
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:41:10 +0200 (CEST)
Date: Thu, 18 May 2017 10:41:06 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170518104106.39639439@bahia.lan>
In-Reply-To: <20170509111258.4c4f3de9@bahia>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399503288.29022.13904385823492355197.stgit@bahia.lan>
	<093d42d3-a4a5-94bd-3a7a-b2a2f867ae89@redhat.com>
	<20170509111258.4c4f3de9@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Cp_bYcFiMAO=DV0IK4dYJQy";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/5] 9pfs: local: resolve special
 directories in paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?B?TMOpbw==?= Gaspard <leo@gaspard.io>, qemu-devel@nongnu.org

--Sig_/Cp_bYcFiMAO=DV0IK4dYJQy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 9 May 2017 11:12:58 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 5 May 2017 11:59:15 -0500
> Eric Blake <eblake@redhat.com> wrote:
>=20
> > On 05/05/2017 09:37 AM, Greg Kurz wrote: =20
> > > When using the mapped-file security mode, the creds of a path /foo/bar
> > > are stored in the /foo/.virtfs_metadata/bar file. This is okay for all
> > > paths unless they end with '.' or '..', because we cannot create the
> > > corresponding file in the metadata directory.
> > >=20
> > > This patch ensures that '.' and '..' are resolved in all paths.
> > >=20
> > > The core code only passes path elements (no '/') to the backend, with
> > > the notable exception of the '/' path, which refers to the virtfs roo=
t.
> > > This patch preserve the current behavior of converting it to '.' so  =
 =20
[...]
> > > +        } else if (!strcmp(name, "..")) {
> > > +            if (!strcmp(dir_path->data, ".")) {
> > > +                /* ".." relative to the root is "." */
> > > +                v9fs_path_sprintf(target, ".");
> > > +            } else {
> > > +                char *tmp =3D g_path_get_dirname(dir_path->data);
> > > +                /* ".." relative to "foo/bar" is equivalent to "foo"=
 */   =20
> >=20
> > True only if bar is not a symlink to some other directory.  What
> > guarantees do you have that you are not going to be inadvertently
> > skipping a traversal through symlinks and thereby picking the wrong
> > location for '..'?
> >  =20
>=20
> My understanding is that symlinks are supposed to be resolved by the clie=
nt,
> and we shouldn't follow them in the server.
>=20

Eric,

Do you have any comment further comment or can I go on with this change ?

Cheers,

--
Greg

--Sig_/Cp_bYcFiMAO=DV0IK4dYJQy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkdXiIACgkQAvw66wEB28IXvQCfQKPQ2pzvzVvY3ZhGUusbxxGe
M0wAnih8xgVnM6M3+a/pROuBn86Y+nmB
=eY2E
-----END PGP SIGNATURE-----

--Sig_/Cp_bYcFiMAO=DV0IK4dYJQy--
