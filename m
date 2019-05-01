Received: from eggs.gnu.org ([209.51.188.92]:50779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLs12-0004r1-DA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLs0z-00088Q-C2
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:23:28 -0400
Date: Wed, 1 May 2019 12:23:16 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190501162316.GD21155@stefanha-x1.localdomain>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CACPK8Xc5KgiaYCTs=8ceRu_hV=vC3M6pGV0=7jJNsbuz2a6LDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <CACPK8Xc5KgiaYCTs=8ceRu_hV=vC3M6pGV0=7jJNsbuz2a6LDA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 12:53:48PM +0000, Joel Stanley wrote:
> On Fri, 26 Apr 2019 at 09:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > A user-friendly error message is needed here.  The check for -kernel was
> > too specific and is not desirable for microbit where we use -device
> > loader.
> >
> > Old boards probably want to continue using -kernel.  New boards like
> > microbit may use just -device loader.  Perhaps there is even a group
> > that wants both options.
>=20
> FWIW, I used -kernel exclusively when working on the microbit model.
> Other users may chose to use the device loader/hex file.
>=20
> I am all for usability, but getting rid of the ability to use -kernel
> on some machine types would be a step in the wrong direction.

-kernel doesn't support the .hex file format that is most commonly used
for micro:bit programs.  Are you loading ELFs?

Stefan

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJx/QACgkQnKSrs4Gr
c8hpZggAukJnmfzU1WV5yz34v06vaJnRghdLQe54TmxuZRJiTjwhsVwfcTwTEsTe
4SgJ9LRi4dGz7+F4IvNUjLzePJX9dpcJ7SKFFoFUxAN1SvgPMTY26na56a4wJPNj
2ATUZsujzI4z9W4tl55U+iaxUTv5jSMwyGl3k4BsHHe5o25Ce97YNfd8fpoLBU0R
+fCGsjkebSSnSXARnLvy2hKefxwW7dlhQC0THL7pISY7rX6btRnuNzbe2eJvOvhG
kFtbEfaNrkObhVEqL+oz/s1+Xyo4lcLijm5Sxi95V4F6zmHMPHbVe+3GXGtABNoY
xp3NsWSV5Da4mY6HWloAQOjBIHixsA==
=W2f4
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
