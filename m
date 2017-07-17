Received: from eggs.gnu.org ([2001:4830:134:3::10]:52751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX2cF-0006gP-Hv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX2cB-0006QG-LJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:46:59 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dX2cB-0006P8-Ek
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:46:55 -0400
Received: by mail-wm0-x242.google.com with SMTP id p204so22043561wmg.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 02:46:55 -0700 (PDT)
Date: Mon, 17 Jul 2017 10:46:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170717094651.GE7163@stefanha-x1.localdomain>
References: <20170714101549.28665-1-berrange@redhat.com>
	<20170714101549.28665-2-berrange@redhat.com>
	<20170714170617.GJ6020@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <20170714170617.GJ6020@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] docs: document support lifetime for
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 02:06:17PM -0300, Eduardo Habkost wrote:
> On Fri, Jul 14, 2017 at 11:15:48AM +0100, Daniel P. Berrange wrote:
> > There is currently no explicit guidance on the duration of support
> > for features such as versioned machine types, which have a finite
> > useful lifespan. Thus apps / users cannot predict how much time
> > they might be able to use a feature for, before it is removed (if
> > ever).
> >=20
> > This adds a new appendix that lists items which have finite lifecycles,
> > such as machine types. For items which are generally expected to be
> > supported indefinitely, it sets out the policy around deprecation
> > and removal, should it be needed.
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-doc.texi | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >=20
> > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > index 48af5155c7..f067015d4b 100644
> > --- a/qemu-doc.texi
> > +++ b/qemu-doc.texi
> > @@ -38,6 +38,7 @@
> >  * QEMU Guest Agent::
> >  * QEMU User space emulator::
> >  * Implementation notes::
> > +* Support lifetime::
> >  * License::
> >  * Index::
> >  @end menu
> > @@ -3128,6 +3129,42 @@ Run the emulation in single step mode.
> > =20
> >  @include qemu-tech.texi
> > =20
> > +@node Support lifetime
> > +@appendix Support lifetime
> > +
> > +In general features are intended to be supported indefinitely once
> > +introduced into QEMU.
> > +
> > +In the event that a feature needs to be removed, it will be listed
> > +in the ``Deprecated features'' appendix of this document. The feature
> > +will remain functional for 2 major releases prior to actual removal.
>=20
> Is a "major release" a x.0 release?  So if we decide to to
> deprecate a feature in QEMU 2.10, does this mean we will be able
> to remove it only on QEMU 4.0?
>=20
> This doesn't sound like a predictable feature lifetime, if we
> don't have a predictable policy for major release numbering.

Agreed, I thought it was <major>.<minor>.<patch> so "major" should
probably be "minor".

Stefan

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbIeLAAoJEJykq7OBq3PIuuEH/RA7uiP30ppfFhlkIysUMR65
22ar4NKUXKn2wPdK/NaUBgGEOFycpYBsApN8fm2scewqrEtA+7US7a8WMPWTrU04
wm0lJ2jvWEOMoq3NK0K0bHLaMB7o7NnoT4EbGtAXpQnxz3qdcLre1bhZNy5XI41B
ERazQQtPNFnLMqLlFptOd44ESKPFmGbhZGetpawoOQ2+KO0NN/AmPS8q5hiuFFoi
TQmZQ9WglnmdSsOfzkL/51bYkUYYHUlw4+gQR4oYZYyI0akTRo/CSX6LVMVOXsS/
/tV3gYTwfsAJ59I05PNtudBYqph9eZlygHuDm99T6W4YLhkndfUNcqeIemRh+VE=
=cIP7
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
