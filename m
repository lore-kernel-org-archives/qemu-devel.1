Received: from eggs.gnu.org ([2001:4830:134:3::10]:38087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDHmN-0007RD-Dl
	for qemu-devel@nongnu.org; Tue, 23 May 2017 17:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDHmK-0004tY-CZ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 17:55:47 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:59849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDHmK-0004qA-65
	for qemu-devel@nongnu.org; Tue, 23 May 2017 17:55:44 -0400
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5697B85334
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 23:55:42 +0200 (CEST)
Date: Tue, 23 May 2017 23:55:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170523235538.764a0e24@bahia.ttt.fr.ibm.com>
In-Reply-To: <73732d9a-e7df-9d33-1293-eafe5553b8dc@redhat.com>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149554995611.23396.9322039196246265398.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<73732d9a-e7df-9d33-1293-eafe5553b8dc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/67giOZsRqHoLU_w7ScK28Lp";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] 9pfs: local: simplify file opening
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Leo Gaspard <leo@gaspard.io>

--Sig_/67giOZsRqHoLU_w7ScK28Lp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2017 10:51:26 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/23/2017 09:32 AM, Greg Kurz wrote:
> > The logic to open a path currently sits between local_open_nofollow() a=
nd
> > the relative_openat_nofollow() helper, which has no other user.
> >=20
> > For the sake of clarity, this patch moves all the code of the helper in=
to
> > its unique caller. While here we also:
> > - drop the code to skip leading "/" because the backend isn't supposed =
to
> >   pass anything but relative paths without consecutive slashes. The ass=
ert()
> >   is kept because we really don't want a buggy backend to pass   an abs=
olute =20
>=20
> odd spacing
>=20
> >   path to openat().
> > - use strchrnul() to get a simpler code. This is ok since virtfs if for=
 =20
>=20
> s/if/is/
>=20

Yeah, I spotted these two nits just after posting the series, as usual :)

I'll fix them before merging.

> >   linux+glibc hosts only.
> > - don't dup() the initial directory and add an assert() to ensure we do=
n't
> >   return the global mountfd to the caller. BTW, this would mean that the
> >   caller passed an empty path, which isn't supposed to happen either.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > --- =20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--Sig_/67giOZsRqHoLU_w7ScK28Lp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkkr9oACgkQAvw66wEB28JXPACdHHjewJkUKmIRcYhtuABqsEj1
1OwAn2xRxcLdzkyxPdz5sBN1Nq+VsV6c
=do01
-----END PGP SIGNATURE-----

--Sig_/67giOZsRqHoLU_w7ScK28Lp--
