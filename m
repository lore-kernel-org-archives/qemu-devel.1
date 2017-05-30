Received: from eggs.gnu.org ([2001:4830:134:3::10]:54121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFeHN-0000er-Qy
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFeHK-0004SX-MO
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:21:33 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:38866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFeHK-0004S2-G8
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:21:30 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5088FEBA69
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 12:21:17 +0200 (CEST)
Date: Tue, 30 May 2017 12:21:12 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170530122112.2dc44db9@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170530094212.GL11362@stefanha-x1.localdomain>
References: <1496048740-26578-1-git-send-email-groug@kaod.org>
	<20170530094212.GL11362@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/_RuTiMkvikCb35EEWTefALn";
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/_RuTiMkvikCb35EEWTefALn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 May 2017 10:42:12 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, May 29, 2017 at 11:05:29AM +0200, Greg Kurz wrote:
> > The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d1=
9b60:
> >=20
> >   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into st=
aging (2017-05-23 15:01:31 +0100)
> >=20
> > are available in the git repository at:
> >=20
> >   https://github.com/gkurz/qemu.git tags/for-upstream
> >=20
> > for you to fetch changes up to f0a4da86cff2e600255324793daddd7ce59b9862:
> >=20
> >   9pfs: local: metadata file for the VirtFS root (2017-05-25 10:30:14 +=
0200)
> >=20
> > ----------------------------------------------------------------
> > Various bugfixes and code cleanups. Most notably, it fixes metadata han=
dling in
> > mapped-file security mode (especially for the virtfs root). =20
>=20
> Please fix the compiler warning reported by patchew.
>=20

In file included from /var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-l=
ocal.c:18:0:
/var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-local.c: In function =
=E2=80=98local_set_mapped_file_attrat=E2=80=99:
/var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-util.h:19:5: error: =E2=
=80=98map_dirfd=E2=80=99 may be used uninitialized in this function [-Werro=
r=3Dmaybe-uninitialized]
     close(fd);
     ^~~~~~~~~
/var/tmp/patchew-tester-tmp-3cnydauu/src/hw/9pfs/9p-local.c:235:9: note: =
=E2=80=98map_dirfd=E2=80=99 was declared here
     int map_dirfd, map_fd;
         ^~~~~~~~~
cc1: all warnings being treated as errors

This is a false positive: map_dirfd is necessarily initialized, but I guess
gcc isn't smart enough to see that :-\

It is acceptable to close(-1) so I guess I'll just do:

-    int map_dirfd, map_fd;
+    int map_dirfd =3D -1, map_fd;

> Thanks,
> Stefan


--Sig_/_RuTiMkvikCb35EEWTefALn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlktR5gACgkQAvw66wEB28LJoQCffK2T4EDp4iJB1JuxuG2ytixj
IsAAnjasTtJxmynSYwsgDOPizveCWlnw
=sc2g
-----END PGP SIGNATURE-----

--Sig_/_RuTiMkvikCb35EEWTefALn--
