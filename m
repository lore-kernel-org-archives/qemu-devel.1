Received: from eggs.gnu.org ([2001:4830:134:3::10]:58628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciIQV-0006AY-NI
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciIQQ-0007xs-LQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:21:07 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciIQQ-0007wg-EV
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:21:02 -0500
Received: by mail-wr0-x242.google.com with SMTP id g10so9512877wrg.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 02:21:02 -0800 (PST)
Date: Mon, 27 Feb 2017 10:20:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227102058.GC28403@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760159100.31154.15503472827834963062.stgit@bahia.lan>
	<20170223111644.GD30636@stefanha-x1.localdomain>
	<20170223125621.1d03281c@bahia.lan>
	<20170224171730.GE27402@stefanha-x1.localdomain>
	<20170224231744.0f629a65@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20170224231744.0f629a65@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Prasad J Pandit <prasad@redhat.com>, qemu-devel@nongnu.org, Jann Horn <jannh@google.com>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 11:17:44PM +0100, Greg Kurz wrote:
> On Fri, 24 Feb 2017 17:17:30 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> [...]
> > > > This function doesn't handle absolute paths?  It ignores leading '/=
' and
> > > > therefore treats all paths as relative paths.
> > > >  =20
> > >=20
> > > Yes because any path coming from the client is supposed (*) to be rel=
ative to the
> > > shared directory and openat(2) says: =20
> >=20
> > Please change the function name since this isn't openat with nofollow
> > behavior, it's a subset of openat that only takes relative paths with
> > nofollow behavior.
>=20
> In the v2, this function is only called by local_open_nofollow() actually.
> Maybe I should move the stripping of leading '/' characters there ?

As long as the function name is clear then I'm happy.  If it has
different semantics from openat() then it should have a different name
(e.g. relative_openat_nofollow()).

Stefan

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYs/2KAAoJEJykq7OBq3PINQkIAIDeJMPYyDrsHVirSWecySqe
vkz5X/DG0kgDQrbSHFSknyU8o/4B9EVn18NNBYHz9PVYp95UQ/UYe9FlylbIHSnT
ay1pkRo6giq07afS8ksOGvogTZUP9T82dx2VvN3iPl2oP2gcv/o07sEemm2C6uk8
eKwGplEV+82tCXjboxGo92EM6oPgxd2eqf+8G0lwcQHHaaL61Y2rFSB7QPjzq0IU
ZaLx/pUUFjlWw7mBPl4QSbxSQ0xqZ/RbiHN/lw8vW7BGitQ0w3qSAlZZn5CNp/4H
pYijZ1U6PWKLpG+lS8PpMjJAqdN5Umn2aRrrtV/8XSKlHMbXL63j+M5TR+xEoVg=
=PR0g
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
