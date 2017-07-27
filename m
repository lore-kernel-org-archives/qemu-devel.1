Received: from eggs.gnu.org ([2001:4830:134:3::10]:39091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dafmd-00034i-Tf
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dafmd-0002mQ-0T
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:12:43 -0400
Date: Thu, 27 Jul 2017 11:12:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170727101235.GD10129@stefanha-x1.localdomain>
References: <20170726130337.24102-1-stefanha@redhat.com>
	<20170726130913.GM7620@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <20170726130913.GM7620@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, el13635@mail.ntua.gr


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 02:09:13PM +0100, Daniel P. Berrange wrote:
> On Wed, Jul 26, 2017 at 02:03:37PM +0100, Stefan Hajnoczi wrote:
> > Block driver documentation is available in qemu-doc.html.  It would be
> > convenient to have documentation for formats, protocols, and filter
> > drivers in a man page.
> >=20
> > Extract the relevant part of qemu-doc.html into a new file called
> > docs/qemu-block-drivers.texi.  This file can also be built as a
> > stand-alone document (man, html, etc).
>=20
> Is there perhaps benefit it taking it further and creating one
> man page per block driver. Many of the block drivers are optional
> and can be turned off, so this would let us leave out the docs
> for disabled block drivers too.

That's a great idea - especially in the world of modular block drivers
(they can be installed after the core QEMU package).

Can we leave that for later when also documenting the open parameters?
We can still make use of a qemu-block-drivers(7) index for
discoverability - a introductory man page with references to all
possible block drivers (some of which may not be installed).  This is a
common man page idiom for programs with subcommands, like git(1).

Stefan

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZebyTAAoJEJykq7OBq3PIDFAH/055NEka6o4F1FbBRLMKIDlE
OAxGeAcGKY7IXeOolVCLahvwUopasYsiXqbEi3n8sbf5f/dtWIHUaFuouOyHHUx1
1rAF71cX/towVkXQ/xukLDoiTdQapL1z2tIdU7A12Rq/qy5cCMR1DkOaglHli5gG
lY25lXo1CVMIjnKb1edgDicCmvrDC4fYtHSc8jJzH1gMzGkzzXvZ7iZThGca06Lp
OMJfWXDtGVr1K7ESDmcHzhanlN0tnC9R+0FDLa1jS+ZGhzoS4uGzLlKusRMpVq9A
Mejo5Ai4NkVyPFlA27WQ5ptbfcFp8wbMWGIjQz1Iu1J77IFgJmzpHOwVOyf4d+8=
=SFO8
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
