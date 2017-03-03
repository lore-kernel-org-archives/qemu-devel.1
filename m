Received: from eggs.gnu.org ([2001:4830:134:3::10]:44474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjpNo-0002bd-5X
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjpNj-0000Mw-8d
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:44:40 -0500
Received: from mo173.mail-out.ovh.net ([178.32.228.173]:43783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjpNj-0000Mp-2j
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:44:35 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 280DD26E65
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 16:44:31 +0100 (CET)
Date: Fri, 3 Mar 2017 16:44:26 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170303164426.42472535@bahia.lan>
In-Reply-To: <8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/3+oN2/nsodpnZr_53SPli_V";
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
To: G 3 <programmingkidx@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

--Sig_/3+oN2/nsodpnZr_53SPli_V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 10:28:00 -0500
G 3 <programmingkidx@gmail.com> wrote:

> On Mar 3, 2017, at 9:59 AM, qemu-devel-request@nongnu.org wrote:
> > On 02/03/17 17:40, Daniel P. Berrange wrote:
> > =20
> >> On Thu, Mar 02, 2017 at 05:28:24PM +0000, Mark Cave-Ayland wrote: =20
> >>> Does anyone else see the following error when trying to build git =20
> >>> master?
> >>>
> >>> cc -I/home/build/src/qemu/git/qemu/hw/9pfs -Ihw/9pfs
> >>> -I/home/build/src/qemu/git/qemu/tcg
> >>> -I/home/build/src/qemu/git/qemu/tcg/i386
> >>> -I/home/build/src/qemu/git/qemu/linux-headers
> >>> -I/home/build/src/qemu/git/qemu/linux-headers -I.
> >>> -I/home/build/src/qemu/git/qemu -I/home/build/src/qemu/git/qemu/=20
> >>> include
> >>> -I/usr/include/pixman-1   -I/home/build/src/qemu/git/qemu/dtc/libfdt
> >>> -Werror -pthread -I/usr/include/glib-2.0
> >>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -m64 -mcx16 -=20
> >>> D_GNU_SOURCE
> >>> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> >>> -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
> >>> -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
> >>> -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> >>> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> >>> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> >>> -fstack-protector-all -I/usr/include/p11-kit-1
> >>> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -=20
> >>> MMD -MP
> >>> -MT hw/9pfs/9p-util.o -MF hw/9pfs/9p-util.d -O2 -U_FORTIFY_SOURCE
> >>> -D_FORTIFY_SOURCE=3D2 -g   -c -o hw/9pfs/9p-util.o hw/9pfs/9p-util.c
> >>> In file included from hw/9pfs/9p-util.c:15:0:
> >>> hw/9pfs/9p-util.h: In function ?openat_dir?:
> >>> hw/9pfs/9p-util.h:25:57: error: ?O_PATH? undeclared (first use in =20
> >>> this
> >>> function)
> >>> hw/9pfs/9p-util.h:25:57: note: each undeclared identifier is =20
> >>> reported
> >>> only once for each function it appears in
> >>> hw/9pfs/9p-util.h:26:1: error: control reaches end of non-void =20
> >>> function
> >>> [-Werror=3Dreturn-type]
> >>>
> >>> Build platform is Debian Wheezy on an x86_64 host. =20
> >>
> >> IIUC, O_PATH was introduced in glibc 2.14 and Wheezy only has 2.13.
> >>
> >> So unless we want to make this 9pfs code a configurable option, this
> >> means Debian Wheezy is no longer a supportable platform for QEMU. =20
> >
> > Oh sure, I appreciate that wheezy is getting towards then end of its
> > lifetime - it's just a little bit inconvenient to break my development
> > environment just as we enter 2.9 freeze ;)
> >
> > If everyone agrees that wheezy is no longer supported after 2.9 then I
> > can look to upgrading, however my QEMU development is done on my =20
> > laptop
> > which is also setup for my day job so it's not a simple case of just
> > switching the repository and running dist-upgrade to get me going =20
> > again... =20
>=20
> I remember years ago something like O_PATH was not defined on Mac OS X,
> so the solution was to define the constant as zero. Something like this:
>=20
> #ifndef O_PATH
> 	#define O_PATH 0
> #endif
>=20
> Maybe this might work in 9p-util.h.
>=20

Yes. Please send a patch and I'll merge it.

Cheers.

--
Greg

--Sig_/3+oN2/nsodpnZr_53SPli_V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli5j1oACgkQAvw66wEB28Im1gCfXEg+7rRiEb0fwbFcxO4klyx5
lTEAn3+WwpS4EHVKvfhaNiPWTs2jRNaz
=F/Og
-----END PGP SIGNATURE-----

--Sig_/3+oN2/nsodpnZr_53SPli_V--
