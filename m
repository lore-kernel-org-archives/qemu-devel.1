Received: from eggs.gnu.org ([209.51.188.92]:55966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmP7N-0000YA-5q
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmP7L-0007IG-LN
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:27:25 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gmP7L-0007GN-Cm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:27:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so706264wmf.5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:27:22 -0800 (PST)
Date: Wed, 23 Jan 2019 20:27:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190123202717.GA11941@stefanha-x1.localdomain>
References: <20190123165310.9380-1-stefanha@redhat.com>
	<20190123175507.7nwm5gjx3ic2v5rm@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20190123175507.7nwm5gjx3ic2v5rm@steredhat>
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add GSoC/Outreachy 2018
 retrospective blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, thuth@redhat.com, Fam Zheng <famz@euphon.net>, airlied@redhat.com, jim@groklearning.com, qemu-devel@nongnu.org, joel@jms.id.au, Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com, kraxel@redhat.com


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 06:55:07PM +0100, Stefano Garzarella wrote:
> On Wed, Jan 23, 2019 at 04:53:10PM +0000, Stefan Hajnoczi wrote:
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v2:
> >  * Added mentor names
> >  * Added additional details from Marc-Andr=E9 and Paolo
> > ---
> >  _posts/2019-01-23-internships-wrapup.md | 79 +++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >  create mode 100644 _posts/2019-01-23-internships-wrapup.md
> >=20
> > diff --git a/_posts/2019-01-23-internships-wrapup.md b/_posts/2019-01-2=
3-internships-wrapup.md
> > new file mode 100644
> > index 0000000..fefcc2a
> > --- /dev/null
> > +++ b/_posts/2019-01-23-internships-wrapup.md
> > @@ -0,0 +1,79 @@
> > +---
> > +layout: post
> > +title:  "GSoC and Outreachy 2018 retrospective"
> > +date:   2019-01-23 07:50:00 +0100
> > +categories: [gsoc, outreachy, internships]
> > +---
> > +QEMU participates in open source internship programs including Google =
Summer of
> > +Code (GSoC) and Outreachy.  These full-time remote work opportunities =
allow
> > +talented new developers to get involved in our community.  This post h=
ighlights
> > +what our interns achieved in 2018.
> > +
> > +## micro:bit board emulation
> > +
> > +Julia Suvorova (Outreachy) and Steffen G=F6rtz (GSoC) tackled adding e=
mulation
> > +support for the [micro:bit ARM board](https://microbit.org/).  Althoug=
h QEMU
> > +already has plenty of ARM emulation code, the Cortex-M0 CPU used in the
> > +micro:bit was not yet implemented and the nRF51 system-on-chip was also
> > +missing.
> > +
> > +The goal of this project was to run micro:bit programs (usually create=
d with
> > +the [MicroPython](https://python.microbit.org/v/1.1) or
> > +[Javascript/Blocks](https://makecode.microbit.org/) IDEs) with a core =
set of
> > +emulated devices, including the serial port, pushbuttons, and LEDs.
> > +
> > +QEMU 3.1 already shipped the groundwork for the new `qemu-system-arm -M
> > +microbit` machine type.  Enough functionality to run basic micro:bit p=
rograms
> > +is expected in the next QEMU release.
> > +
> > +This project was mentored by Jim Mussared, Joel Stanley, and Stefan Ha=
jnoczi.
> > +
> > +## Patchew REST API improvements
> > +
> > +Shubham Jain (GSoC) created a REST API for the Patchew continuous inte=
gration
> > +system that is at the heart of QEMU's development process.  The previo=
us API
> > +was not RESTful and exposed database schema internals.
> > +
> > +The improvements to the REST API have been included into Patchew and a=
re
> > +deployed on <a href=3D"https://patchew.org/">patchew.org</a>.  They ar=
e not in
> > +use yet, pending more work on authentication; this may be the topic of=
 a future
> > +Summer of Code internship.
> > +
> > +This project was mentored by Paolo Bonzini and Fam Zheng.
> > +
> > +## Qtest Driver Framework
> > +
> > +Emanuele Esposito (GSoC) enhanced QEMU's test infrastructure with an e=
ngine
> > +that starts tests with all variants of devices that they are capable of
> > +driving.
> > +
> > +This is a complicated task in QEMU since certain devices and busses are
> > +available in an architecture-specific way on each emulation target, ma=
king it
> > +hard to write test cases without lots of hardcoded dependencies - and =
to keep
> > +them up-to-date!
> > +
> > +The qgraph framework that Emanuele created eliminates the need to hard=
code each
> > +variant into the test.  Emanuele also converted several existing tests=
=2E  His
> > +framework was also <a
> > +href=3D"https://www.youtube.com/watch?v=3DN8Go4NEw0Ss">presented at KV=
M Forum 2019
>=20
> s/2019/2018

Thanks!

Thomas: Please s/KVM Forum 2019/KVM Forum 2018/ when merging.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSM4lAAoJEJykq7OBq3PIiU0H/RDQ8gN1B5004TlYJ0i+xLTx
yQcjlgn/56MZM+ZM6joqtQlngEy/Q0OYFCJpBJmFkOp7rN2Ldd1mVfn6yozVbxGZ
VyJY49D41+nzXMtqM60691XhC23j0fkBj/bAdIlZ8CEjjsqKylfgHKSkqrZw6VF8
9GEBIbviOLD5I5pJ+zTe/QsuWyUZ4RglRpvz50oab54pvxBEKLegskd+tHplFxYH
Ve8+W6lNxX8XOamq2jRdAda8RUMy5P1SIBr5SZMHpAgvZhd6PGVtrJTRUGpyxkiX
uR3W/WbkYQ/8x24GIqA8kZPpVr/aTySxKdjf95S6AUox0qxl2/neYjLPqzWpwIU=
=JSsD
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
