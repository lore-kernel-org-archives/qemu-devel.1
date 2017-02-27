Received: from eggs.gnu.org ([2001:4830:134:3::10]:33682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciIgs-0005JO-2Z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciIgo-0005Pj-3I
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:38:02 -0500
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:51425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciIgn-0005PE-S9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:37:58 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6F997B3869
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:37:56 +0100 (CET)
Date: Mon, 27 Feb 2017 11:37:43 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170227113743.0920003b@bahia.lan>
In-Reply-To: <20170227102058.GC28403@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760159100.31154.15503472827834963062.stgit@bahia.lan>
	<20170223111644.GD30636@stefanha-x1.localdomain>
	<20170223125621.1d03281c@bahia.lan>
	<20170224171730.GE27402@stefanha-x1.localdomain>
	<20170224231744.0f629a65@bahia.lan>
	<20170227102058.GC28403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/0fe7PAYG97I2IbPA47/pd.U";
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Prasad J Pandit <prasad@redhat.com>, qemu-devel@nongnu.org, Jann Horn <jannh@google.com>

--Sig_/0fe7PAYG97I2IbPA47/pd.U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2017 10:20:58 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Fri, Feb 24, 2017 at 11:17:44PM +0100, Greg Kurz wrote:
> > On Fri, 24 Feb 2017 17:17:30 +0000
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > [...] =20
> > > > > This function doesn't handle absolute paths?  It ignores leading =
'/' and
> > > > > therefore treats all paths as relative paths.
> > > > >    =20
> > > >=20
> > > > Yes because any path coming from the client is supposed (*) to be r=
elative to the
> > > > shared directory and openat(2) says:   =20
> > >=20
> > > Please change the function name since this isn't openat with nofollow
> > > behavior, it's a subset of openat that only takes relative paths with
> > > nofollow behavior. =20
> >=20
> > In the v2, this function is only called by local_open_nofollow() actual=
ly.
> > Maybe I should move the stripping of leading '/' characters there ? =20
>=20
> As long as the function name is clear then I'm happy.  If it has
> different semantics from openat() then it should have a different name
> (e.g. relative_openat_nofollow()).
>=20

I've moved the stripping to the caller. This makes the code simpler.

> Stefan


--Sig_/0fe7PAYG97I2IbPA47/pd.U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli0AXcACgkQAvw66wEB28JoxQCfXcRBP/2b1EFWw7UwsIltH7Ep
HZ8An2h6rhXWI0KkZABKw8tZpSDaHHwU
=1eba
-----END PGP SIGNATURE-----

--Sig_/0fe7PAYG97I2IbPA47/pd.U--
