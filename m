Received: from eggs.gnu.org ([2001:4830:134:3::10]:49469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBH1M-0004BL-U5
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBH1I-0003Eu-3I
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:42:57 -0400
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:38161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBH1H-0003Ee-SP
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:42:52 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 776F0D336E
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:42:50 +0200 (CEST)
Date: Thu, 18 May 2017 10:42:47 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170518104247.66828f52@bahia.lan>
In-Reply-To: <20170509112305.439c4d85@bahia>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399504137.29022.4985100698645275511.stgit@bahia.lan>
	<3c8abd95-b490-1b71-b467-4f00d6ce121d@redhat.com>
	<20170509112305.439c4d85@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WGlwHQrsfhj=WuE7QE8pZkq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/5] 9pfs: local: simplify file opening
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

--Sig_/WGlwHQrsfhj=WuE7QE8pZkq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 9 May 2017 11:23:05 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 5 May 2017 12:01:55 -0500
> Eric Blake <eblake@redhat.com> wrote:
>=20
> > On 05/05/2017 09:37 AM, Greg Kurz wrote: =20
> > > All paths in the virtfs directory now start with "./" (except the vir=
tfs
> > > root itself which is exactly ".").
> > >=20
> > > We hence don't need to skip leading '/' characters anymore, nor to ha=
ndle
> > > the empty path case. Also, since virtfs will only ever be supported on
> > > linux+glibc hosts, we can use strchrnul() and come up with a much sim=
plier
> > > code to walk through the path elements. And we don't need to dup() the
> > > passed directory fd.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/9pfs/9p-local.c |    5 -----
> > >  hw/9pfs/9p-util.c  |   26 ++++++++++----------------
> > >  2 files changed, 10 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > > index 92262f3c3e37..bb6e296df317 100644
> > > --- a/hw/9pfs/9p-local.c
> > > +++ b/hw/9pfs/9p-local.c
> > > @@ -54,11 +54,6 @@ int local_open_nofollow(FsContext *fs_ctx, const c=
har *path, int flags,
> > >  {
> > >      LocalData *data =3D fs_ctx->private;
> > > =20
> > > -    /* All paths are relative to the path data->mountfd points to */
> > > -    while (*path =3D=3D '/') {
> > > -        path++;
> > > -    }   =20
> >=20
> > Is it worth adding any assert()s in place of the deleted code?
> >  =20
>=20
> The assert() added by this patch ensures that we never pass an empty
> string to relative_openat_nofollow(), which isn't related to this
> hunk of deleted code... so I'm not sure I understand the question :-\
>=20

Ping ?

> > Otherwise looks okay.
> >  =20
>=20


--Sig_/WGlwHQrsfhj=WuE7QE8pZkq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkdXocACgkQAvw66wEB28Lh0ACdFmPtrVuyJLk30sQnhkwA4uFe
ZtcAnjNwYIS2KpuLSopUjehVFFqPJJF9
=GyCn
-----END PGP SIGNATURE-----

--Sig_/WGlwHQrsfhj=WuE7QE8pZkq--
