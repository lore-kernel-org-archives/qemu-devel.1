Received: from eggs.gnu.org ([2001:4830:134:3::10]:57567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFeT8-0003x4-Pn
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFeT3-0000BV-T9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:33:42 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:53581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFeT3-0000B3-N1
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:33:37 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 92D20FFB96
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 12:33:35 +0200 (CEST)
Date: Tue, 30 May 2017 12:33:29 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170530123329.4342ba5d@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170530102622.GG21566@redhat.com>
References: <1496048740-26578-1-git-send-email-groug@kaod.org>
	<20170530094212.GL11362@stefanha-x1.localdomain>
	<20170530122112.2dc44db9@bahia.ttt.fr.ibm.com>
	<20170530102622.GG21566@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/EtUCGIEn+tvtuHaf.i5Kc0N";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 00/11] 9pfs patches for 2.10 20170525
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/EtUCGIEn+tvtuHaf.i5Kc0N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 May 2017 11:26:22 +0100
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Tue, May 30, 2017 at 12:21:12PM +0200, Greg Kurz wrote:
> > On Tue, 30 May 2017 10:42:12 +0100
> > Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >  =20
> > > On Mon, May 29, 2017 at 11:05:29AM +0200, Greg Kurz wrote: =20
> > > > The following changes since commit 9964e96dc9999cf7f7c936ee854a7954=
15d19b60:
> > > >=20
> > > >   Merge remote-tracking branch 'jasowang/tags/net-pull-request' int=
o staging (2017-05-23 15:01:31 +0100)
> > > >=20
> > > > are available in the git repository at:
> > > >=20
> > > >   https://github.com/gkurz/qemu.git tags/for-upstream
> > > >=20
> > > > for you to fetch changes up to f0a4da86cff2e600255324793daddd7ce59b=
9862:
> > > >=20
> > > >   9pfs: local: metadata file for the VirtFS root (2017-05-25 10:30:=
14 +0200)
> > > >=20
> > > > ----------------------------------------------------------------
> > > > Various bugfixes and code cleanups. Most notably, it fixes metadata=
 handling in
> > > > mapped-file security mode (especially for the virtfs root).   =20
> > >=20
> > > Please fix the compiler warning reported by patchew.
> > >  =20
> >=20
> > In file included from /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/=
9p-local.c:18:0:
> > /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-local.c: In functio=
n =E2=80=98local_set_mapped_file_attrat=E2=80=99:
> > /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-util.h:19:5: error:=
 =E2=80=98map_dirfd=E2=80=99 may be used uninitialized in this function [-W=
error=3Dmaybe-uninitialized]
> >      close(fd);
> >      ^~~~~~~~~
> > /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-local.c:235:9: note=
: =E2=80=98map_dirfd=E2=80=99 was declared here
> >      int map_dirfd, map_fd;
> >          ^~~~~~~~~
> > cc1: all warnings being treated as errors
> >=20
> > This is a false positive: map_dirfd is necessarily initialized, but I g=
uess
> > gcc isn't smart enough to see that :-\
> >=20
> > It is acceptable to close(-1) so I guess I'll just do:
> >=20
> > -    int map_dirfd, map_fd;
> > +    int map_dirfd =3D -1, map_fd; =20
>=20
> By 'acceptable' I guess you mean it'll return EBADF. I would not
> be surprised, however, if coverity were to then complain if it sees
> code path where we pass -1 to close, since it is indicative of a
> potential bug. So in addition to your initialization, also protecting
> the close() call with '!=3D -1' condition is a safer approach.
>=20

Thanks for the tip, I'll do that as well.

BTW is there a way to run patchew without posting to the list ?

> Regards,
> Daniel


--Sig_/EtUCGIEn+tvtuHaf.i5Kc0N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlktSnkACgkQAvw66wEB28LXLACfar6oDpjD2W5SDI/qPrVoS5aM
uKYAoJS25s6N3dZAckR6MPQM+G3HhQab
=+dGV
-----END PGP SIGNATURE-----

--Sig_/EtUCGIEn+tvtuHaf.i5Kc0N--
