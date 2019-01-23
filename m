Received: from eggs.gnu.org ([209.51.188.92]:59452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmLmf-0004Y3-8Z
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmLma-0000oz-Hw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:53:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gmLmZ-0000mX-Sn
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:53:44 -0500
Received: by mail-wm1-x32e.google.com with SMTP id t200so83818wmt.0
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 08:53:42 -0800 (PST)
Date: Wed, 23 Jan 2019 16:53:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190123165338.GA8724@stefanha-x1.localdomain>
References: <20190103153320.21687-1-stefanha@redhat.com>
	<975d05a9-57f1-4183-b84e-231265e3177e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <975d05a9-57f1-4183-b84e-231265e3177e@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web RFC] Add GSoC/Outreachy 2018
 retrospective blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, jim@groklearning.com, Fam Zheng <famz@euphon.net>, Thomas Huth <thuth@redhat.com>, joel@jms.id.au, marcandre.lureau@redhat.com, airlied@redhat.com, kraxel@redhat.com


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 03:50:05PM +0100, Paolo Bonzini wrote:
> On 03/01/19 16:33, Stefan Hajnoczi wrote:
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Dear mentors,
> > Let's post an overview of what was achieved in GSoC/Outreachy 2018.  I
> > have populated a blog post with information available to me, but I'm
> > sure it can be improved to explain how the project went and the current
> > status.
> >=20
> > Please let me know what should be changed, thanks!
> > ---
> >  _posts/2019-01-03-internships-wrapup.md | 61 +++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 _posts/2019-01-03-internships-wrapup.md
> >=20
> > diff --git a/_posts/2019-01-03-internships-wrapup.md b/_posts/2019-01-0=
3-internships-wrapup.md
> > new file mode 100644
> > index 0000000..ec245e6
> > --- /dev/null
> > +++ b/_posts/2019-01-03-internships-wrapup.md
> > @@ -0,0 +1,61 @@
> > +---
> > +layout: post
> > +title:  "GSoC and Outreachy 2018 retrospective"
> > +date:   2019-01-03 07:50:00 +0100
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
> > +## Patchew REST API improvements
> > +
> > +Shubham Jain (GSoC) created a REST API for the Patchew continuous inte=
gration
> > +system that is at the heart of QEMU's development process.  The previo=
us API
> > +was not RESTful and exposed database schema internals.
>=20
> The improvements to the REST API have been included into Patchew and are
> deployed on http://patchew.org/.  They are not in use yet, pending more
> work on authentication; this may be the topic of a future Summer of Code
> internship.
>=20
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
> > +variant into the test.
>=20
> Emanuele also converted several existing tests.  His framework was also
> presented at KVM Forum 2019 by Laurent Vivier, Emanuele's mentor,  and
> should be merged in 4.0.

Thank you, I have included your feedback in v2.

Stefan

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSJwSAAoJEJykq7OBq3PItEkH/27cCZiSUwVwGYIfNbwSObGn
S++wWIGQjcqjPWD4SYncKED/g6W1iHxuPKKlbhnWQ1fObUKLYGyqtrZYxVwCZxdk
lg6uB/9waGLx/EuKOssn78HETCf/4yCB2iM4T/l53z11pEUWsmorZ4tYw3PvTI5V
lU4KxXFqpBA93mvpCMMVjxFx5mIJj+e0bOuAJwyw2yglH+bRgzCLrI39XSt2JHM6
NNE5sQ85c62XRF/twyZoYFgZkAKuHOiGjpxZGiUH+IW6S9aUTgQ98R0k4hxrhZ6g
LXLWmZ3IIZ6y3B1ZE+S5i8w5OnkDK3JHHu9/Slj6ULFsvwv3YhaqLPep+MJSpbI=
=PXdG
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
