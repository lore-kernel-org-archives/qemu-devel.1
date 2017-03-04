Received: from eggs.gnu.org ([2001:4830:134:3::10]:39049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ck7Nh-0001p9-Dk
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 05:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ck7Ne-0000oF-CI
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 05:57:45 -0500
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:60222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ck7Ne-0000o2-5S
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 05:57:42 -0500
Received: from player726.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 8B58E290D8
	for <qemu-devel@nongnu.org>; Sat,  4 Mar 2017 11:57:40 +0100 (CET)
Date: Sat, 4 Mar 2017 11:57:35 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170304115735.02a378ee@bahia.lan>
In-Reply-To: <10a63c3b-26d7-998c-4dcc-c162f144e8b7@redhat.com>
References: <mailman.56273.1488553194.22740.qemu-devel@nongnu.org>
	<8FB6923C-8F97-497C-95DC-6F2D937725BC@gmail.com>
	<20170303164426.42472535@bahia.lan>
	<AA7BADA2-06D5-4A20-A38F-57D374B6C58D@gmail.com>
	<20170303162128.GD13631@redhat.com>
	<20170303174353.676c1a7b@bahia.lan>
	<a93b0903-cf60-d21b-2d68-cd182e06aed3@redhat.com>
	<20170303191524.048b2d1f@bahia.lan>
	<10a63c3b-26d7-998c-4dcc-c162f144e8b7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/b/rnLuRfaKwoQmP=V=5lBxq";
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
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, G 3 <programmingkidx@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

--Sig_/b/rnLuRfaKwoQmP=V=5lBxq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Mar 2017 12:28:01 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 03/03/2017 12:15 PM, Greg Kurz wrote:
>=20
> >=20
> > O_PATH | O_NOFOLLOW is a special case as described in the last paragraph
> > of O_PATH in the man page:
> >=20
> >               If  pathname  is a symbolic link and the O_NOFOLLOW flag =
is also
> >               specified, then the call returns a file descriptor referr=
ing  to
> >               the  symbolic  link.   This  file  descriptor can be used=
 as the
> >               dirfd argument in calls to fchownat(2),  fstatat(2),  lin=
kat(2),
> >               and readlinkat(2) with an empty pathname to have the call=
s oper=E2=80=90
> >               ate on the symbolic link. =20
>=20
> Only when coupled with AT_EMPTY_PATHNAME.  Without that additional flag,
> then it must be a directory.
>=20

And we don't use AT_EMPTY_PATHNAME, so this should work indeed.

--Sig_/b/rnLuRfaKwoQmP=V=5lBxq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli6nZ8ACgkQAvw66wEB28LvegCfZ4V56prmCWapN8sBnSxc7uEp
AuAAmQEeuRN6K7xIr1CAOOrV6dtEhW33
=fSm9
-----END PGP SIGNATURE-----

--Sig_/b/rnLuRfaKwoQmP=V=5lBxq--
