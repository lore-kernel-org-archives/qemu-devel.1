Received: from eggs.gnu.org ([2001:4830:134:3::10]:38115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chOBY-0007Bs-3q
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 17:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1chOBV-0000XA-05
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 17:17:56 -0500
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:51868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1chOBU-0000UC-QM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 17:17:52 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 527F9B2BED
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 23:17:51 +0100 (CET)
Date: Fri, 24 Feb 2017 23:17:44 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170224231744.0f629a65@bahia.lan>
In-Reply-To: <20170224171730.GE27402@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760159100.31154.15503472827834963062.stgit@bahia.lan>
	<20170223111644.GD30636@stefanha-x1.localdomain>
	<20170223125621.1d03281c@bahia.lan>
	<20170224171730.GE27402@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/v.lMAcMP2dYL9_.r+Vys65G";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 04/29] 9pfs: introduce openat_nofollow()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Prasad J Pandit <prasad@redhat.com>, qemu-devel@nongnu.org, Jann Horn <jannh@google.com>

--Sig_/v.lMAcMP2dYL9_.r+Vys65G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Feb 2017 17:17:30 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:
[...]
> > > This function doesn't handle absolute paths?  It ignores leading '/' =
and
> > > therefore treats all paths as relative paths.
> > >  =20
> >=20
> > Yes because any path coming from the client is supposed (*) to be relat=
ive to the
> > shared directory and openat(2) says: =20
>=20
> Please change the function name since this isn't openat with nofollow
> behavior, it's a subset of openat that only takes relative paths with
> nofollow behavior.

In the v2, this function is only called by local_open_nofollow() actually.
Maybe I should move the stripping of leading '/' characters there ?

--Sig_/v.lMAcMP2dYL9_.r+Vys65G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAliwsQgACgkQAvw66wEB28JCPACfZGqhjOR3aDCaMx7dayneS/wT
lDgAoKMnFUDsTsHdLgwZvgK6YTruMv9d
=aSVb
-----END PGP SIGNATURE-----

--Sig_/v.lMAcMP2dYL9_.r+Vys65G--
