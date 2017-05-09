Received: from eggs.gnu.org ([2001:4830:134:3::10]:36809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d81fD-0002TS-41
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d81f9-0001wv-6F
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:42:39 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:42310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d81f9-0001wL-05
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:42:35 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 89AB0EE365
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:42:33 +0200 (CEST)
Date: Tue, 9 May 2017 11:42:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170509114230.2592c51f@bahia>
In-Reply-To: <3d315a77-3e48-8441-de03-36b2cdda7a66@gaspard.io>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<3d315a77-3e48-8441-de03-36b2cdda7a66@gaspard.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/1XxPGz.o2vm5K0suV.CggJE";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 0/5] 9pfs: local: fix metadata of
 mapped-file security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leo Gaspard <leo@gaspard.io>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

--Sig_/1XxPGz.o2vm5K0suV.CggJE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 May 2017 17:33:43 +0200
Leo Gaspard <leo@gaspard.io> wrote:

> Greg,
>=20
> I just tested on 2.9.0 with the 5 patches applied, and it appears to
> work on my setup, thanks!
>=20
> Just a side note: .virtfs_metadata_root is set as u=3Drwx on the host file
> system (the "ret =3D fchmod(map_fd, 0700);" line in patch 4 I guess),
> while u=3Drw would be more appropriate, I think.
>=20

You're right. I'll change that.

> Thank you,
> Leo
>=20
>=20
> On 05/05/2017 04:36 PM, Greg Kurz wrote:
> > This series fixes two issues in the local backend when using the mapped=
-file
> > security mode:
> > - allow chmod and chown to succeed on the virtfs root (patch 4)
> > - completely hide the metadata files from the client (patch 5)
> >=20
> > Patch 2 resolves '.' and '..' in paths, and patch 3 reworks the way we =
open
> > files accordingly. They could be squashed together in a single patch (t=
his
> > was the case in earlier versions actually), but I decided to separate t=
hem
> > for easier review.
> >=20
> > L=C3=A9o,
> >=20
> > I'd appreciate if you could test this series (especially patch 4) on yo=
ur
> > setup.
> >=20
> > Cheers.
> >=20
> > --
> > Greg
> >=20
> > ---
> >=20
> > Greg Kurz (5):
> >       9pfs: check return value of v9fs_co_name_to_path()
> >       9pfs: local: resolve special directories in paths
> >       9pfs: local: simplify file opening
> >       9pfs: local: metadata file for the VirtFS root
> >       9pfs: local: forbid client access to metadata
> >=20
> >=20
> >  hw/9pfs/9p-local.c |  164 ++++++++++++++++++++++++++++++++++++++++----=
--------
> >  hw/9pfs/9p-util.c  |   26 +++-----
> >  hw/9pfs/9p.c       |   36 ++++++++---
> >  3 files changed, 160 insertions(+), 66 deletions(-)
> >  =20
>=20


--Sig_/1XxPGz.o2vm5K0suV.CggJE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkRjwYACgkQAvw66wEB28LsxwCfRvrsYwONwhmkzID/iz4Hfe7g
aDsAnj+pOzIcr5twHzji+u8VAkhq7CuA
=5aHs
-----END PGP SIGNATURE-----

--Sig_/1XxPGz.o2vm5K0suV.CggJE--
