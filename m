Received: from eggs.gnu.org ([209.51.188.92]:51695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLs3d-0006M4-Si
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLs3Y-0001cx-3t
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:26:08 -0400
Date: Wed, 1 May 2019 12:25:51 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190501162551.GE21155@stefanha-x1.localdomain>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CAFEAcA8OVKO087uiNvwDGObiaxHAPYHwoXLEN1t5Y4v9B43r9A@mail.gmail.com>
	<20190429122819.GB7587@stefanha-x1.localdomain>
	<CAFEAcA9_=a72BAmyb0eJhLF_nYLhRb_O7e=__MPazQ0nLC9Tmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9_=a72BAmyb0eJhLF_nYLhRb_O7e=__MPazQ0nLC9Tmw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 01:58:46PM +0100, Peter Maydell wrote:
> On Mon, 29 Apr 2019 at 13:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Fri, Apr 26, 2019 at 12:45:37PM +0100, Peter Maydell wrote:
> > I was going to add a function to check kernel_filename and the presence
> > of -device loader.  Then each machine type init function would call the
> > function with flags indicating which modes are allowed:
> >
> >   /* Allow both -kernel and -device loader */
> >   check_kernel_loaded(KERNEL_CMDLINE | KERNEL_LOADER);
> >
> >   /* Allow only -kernel */
> >   check_kernel_loaded(KERNEL_CMDLINE);
> >
> >   /* Allow only -device loader */
> >   check_kernel_loaded(KERNEL_LOADER);
>=20
> Every machine should permit -device loader: the point
> of it is that it is entirely generic and works the same
> way on every machine.

It seems every person has a slightly different preference :).  Can we
reach a consensus?

1. Should QEMU print a readable error message when launched without a
   kernel?

If yes:

2. What checks are sensible?

Stefan

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJyI8ACgkQnKSrs4Gr
c8hBDQgAtG/Dxap2gsiS1yWR1zi3RCHdY8hzRGJ1Sp/514jLWc/nWTfBRM+nIkd0
Um+NzuJwoX+M0eeECmfMJOrhmimHIHS1P3fZChGWzucj7eQb0RDV741Ahs+olxJk
ri+N0mNQMtHn3RUURRDDSeHrJedLPYvLZSYsUpIeVxywyWv1wmnRn+yE7GrBKi3L
WprN/VWQZiduVLlm7/eMjsbcJ5AIalTowuNJoCtXRc0YxjHwcOlAfrtDL9vkE0Ln
mdHCxbHy+oRBerkH4ziudOj7galnyjRLZJ8jVqgwN/FVGuMv3WJlKWtMsGqUlWrh
Zcy4zMSeom55p74grZ+MDxZmjUceeA==
=q6kg
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
