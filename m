Received: from eggs.gnu.org ([2001:4830:134:3::10]:35882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjqJJ-0006p6-75
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjqJE-0007Iq-8a
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:44:05 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:41868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjqJD-0007Hx-VR
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:44:00 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 453AD2981C
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 17:43:58 +0100 (CET)
Date: Fri, 3 Mar 2017 17:43:53 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170303174353.676c1a7b@bahia.lan>
In-Reply-To: <20170303162128.GD13631@redhat.com>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<20170303162128.GD13631@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/x166/8xQPgIQLIi940PXG5r";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: G 3 <programmingkidx@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

--Sig_/x166/8xQPgIQLIi940PXG5r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 16:21:28 +0000
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Fri, Mar 03, 2017 at 10:55:01AM -0500, G 3 wrote:
> >=20
> > On Mar 3, 2017, at 10:44 AM, Greg Kurz wrote:
> >  =20
> > > On Fri, 3 Mar 2017 10:28:00 -0500
> > > G 3 <programmingkidx@gmail.com> wrote:
> > >  =20
> > > > On Mar 3, 2017, at 9:59 AM, qemu-devel-request@nongnu.org wrote: =20
> > > > > On 02/03/17 17:40, Daniel P. Berrange wrote:
> > > > >  =20
> > > > > > On Thu, Mar 02, 2017 at 05:28:24PM +0000, Mark Cave-Ayland wrot=
e: =20
> > > > > > > Does anyone else see the following error when trying to build=
 git
> > > > > > > master?
> > > > > > >=20
> > > > > > > cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
> > > > > > > -I/home/build/src/qemu/git/qemu/tcg
> > > > > > > -I/home/build/src/qemu/git/qemu/tcg/i386
> > > > > > > -I/home/build/src/qemu/git/qemu/linux-headers
> > > > > > > -I/home/build/src/qemu/git/qemu/linux-headers -I.
> > > > > > > -I/home/build/src/qemu/git/qemu -I/home/build/src/qemu/git/qe=
mu/
> > > > > > > include
> > > > > > > -I/usr/include/pixman-1
> > > > > > > -I/home/build/src/qemu/git/qemu/dtc/libfdt
> > > > > > > -Werror -pthread -I/usr/include/glib-2.0
> > > > > > > -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 -
> > > > > > > D_GNU_SOURCE
> > > > > > > -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototy=
pes
> > > > > > > -Wredundant-decls -Wall -Wundef -Wwrite-strings
> > > > > > > -Wmissing-prototypes
> > > > > > > -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
> > > > > > > -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> > > > > > > -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifie=
rs
> > > > > > > -Wold-style-declaration -Wold-style-definition -Wtype-limits
> > > > > > > -fstack-protector-all -I/usr/include/p11-kit-1
> > > > > > > -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tes=
ts -
> > > > > > > MMD -MP
> > > > > > > -MT hw/9pfs/9p-util.o -MF hw/9pfs/9p-util.d -O2 -U_FORTIFY_SO=
URCE
> > > > > > > -D_FORTIFY_SOURCE=3D2 -g   -c -o hw/9pfs/9p-util.o hw/9pfs/9p=
-util.c
> > > > > > > In file included from hw/9pfs/9p-util.c:15:0:
> > > > > > > hw/9pfs/9p-util.h: In function ?openat_dir?:
> > > > > > > hw/9pfs/9p-util.h:25:57: error: ?O_PATH? undeclared (first us=
e in
> > > > > > > this
> > > > > > > function)
> > > > > > > hw/9pfs/9p-util.h:25:57: note: each undeclared identifier is
> > > > > > > reported
> > > > > > > only once for each function it appears in
> > > > > > > hw/9pfs/9p-util.h:26:1: error: control reaches end of non-void
> > > > > > > function
> > > > > > > [-Werror=3Dreturn-type]
> > > > > > >=20
> > > > > > > Build platform is Debian Wheezy on an x86_64 host. =20
> > > > > >=20
> > > > > > IIUC, O_PATH was introduced in glibc 2.14 and Wheezy only has 2=
.13.
> > > > > >=20
> > > > > > So unless we want to make this 9pfs code a configurable
> > > > > > option, this
> > > > > > means Debian Wheezy is no longer a supportable platform for QEM=
U. =20
> > > > >=20
> > > > > Oh sure, I appreciate that wheezy is getting towards then end of =
its
> > > > > lifetime - it's just a little bit inconvenient to break my
> > > > > development
> > > > > environment just as we enter 2.9 freeze ;)
> > > > >=20
> > > > > If everyone agrees that wheezy is no longer supported after 2.9
> > > > > then I
> > > > > can look to upgrading, however my QEMU development is done on my
> > > > > laptop
> > > > > which is also setup for my day job so it's not a simple case of j=
ust
> > > > > switching the repository and running dist-upgrade to get me going
> > > > > again... =20
> > > >=20
> > > > I remember years ago something like O_PATH was not defined on Mac OS
> > > > X,
> > > > so the solution was to define the constant as zero. Something like
> > > > this:
> > > >=20
> > > > #ifndef O_PATH
> > > > 	#define O_PATH 0
> > > > #endif
> > > >=20
> > > > Maybe this might work in 9p-util.h.
> > > >  =20
> > >=20
> > > Yes. Please send a patch and I'll merge it.
> > >=20
> > > Cheers.
> > >=20
> > > --
> > > Greg =20
> >=20
> >=20
> > Here is the patch. I think we should let Mark or some else test it to s=
ee if
> > it does fix the problem before a real patch is submitted.
> >=20
> > ---
> >  hw/9pfs/9p-util.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> > index 091f3ce..254d2a9 100644
> > --- a/hw/9pfs/9p-util.h
> > +++ b/hw/9pfs/9p-util.h
> > @@ -13,6 +13,10 @@
> >  #ifndef QEMU_9P_UTIL_H
> >  #define QEMU_9P_UTIL_H
> >=20
> > +#ifndef O_PATH
> > +    #define O_PATH 0
> > +#endif =20
>=20
> Isn't the use of O_PATH required in order to fix the recent
> security vulnerability in 9p ?  If so, then defining it to
> 0 means the QEMU is silently becoming vulnerable once again
> which I don't think is a good idea.
>=20

O_PATH was supposed to be used as an optimization here, since fds returned =
by
this function are only passed to openat()... but your comment makes me real=
ize
I inadvertently dropped O_NOFOLLOW between v1 and v2 of the patchset. And t=
his
IS an actual vulnerability issue :) And reading the openat() manpage, I see
that O_PATH | O_NOFOLLOW doesn't cause openat() to fail, but to return a fd
pointing to the symlink which is certainly not what I want :)

I guess I'll just stop using O_PATH then. I'll send a patch.

>=20
> Regards,
> Daniel


--Sig_/x166/8xQPgIQLIi940PXG5r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli5nUkACgkQAvw66wEB28LqgQCdF2JCvTSyjcsJec3CV98PD1at
fesAnAwd1Jr4RU0mTrBdpK5g14q9FRXC
=K4tN
-----END PGP SIGNATURE-----

--Sig_/x166/8xQPgIQLIi940PXG5r--
