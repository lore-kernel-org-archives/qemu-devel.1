Received: from eggs.gnu.org ([2001:4830:134:3::10]:56262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPos4-0000WB-Qk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPos0-0007uO-Pv
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:46:00 -0400
Date: Mon, 4 Jun 2018 13:45:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180604124553.GG13674@stefanha-x1.localdomain>
References: <20180602141446.29982-1-stefanha@redhat.com>
	<20180602141446.29982-3-stefanha@redhat.com>
	<CAFEAcA9cnV6fyc4AMO--jvvycrHPdy1Syvrqxy3J=OyM3cqGpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9cnV6fyc4AMO--jvvycrHPdy1Syvrqxy3J=OyM3cqGpg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 2/2] arm: add ARMv6-M device container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 02, 2018 at 05:16:00PM +0100, Peter Maydell wrote:
> On 2 June 2018 at 15:14, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > --- /dev/null
> > +++ b/hw/arm/armv6m.c
> > @@ -0,0 +1,190 @@
> > +/*
> > + * ARMV6M System emulation.
> > + *
> > + * Copyright (C) 2018 Red Hat, Inc.
> > + *
> > + * Based on hw/arm/armv7m.c (written by Paul Brook),
> > + * Copyright (c) 2006-2007 CodeSourcery.
> > + *
> > + * This code is licensed under the GPL.
> > + */
>=20
> There's a lot of code duplication here with the armv7m object;
> can't we avoid that? What (if anything) needs to be done
> differently from armv7m/armv8m (which both share the same
> code)? Can we handle it by parameterizing or a shared base
> class or something instead?
>=20
> (This code will break if the "check we actually have an
> NVIC for M profile cores" patchset I sent the other day
> is applied, because changes made there to armv7m would
> need to be propagated across to this copied code. It would
> be nice not to have to change multiple places for that
> sort of thing.)

Okay, will rebase on qemu.git/master in a few days and work out how to
share the armv7m code.

Stefan

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFTSBAAoJEJykq7OBq3PIWo8H/i/LoHUQzBN4t/7++5weBVBG
mVNF3YFsiHNIVQj+SAO4Z+9HAKJpM9TzOjc8HqmUHU/RXT/tB8U68JbuMhgS3oje
VcODkibXxR/6qfjMGNzai71XUT7uxUMUsl+Iysx/8TPyWPxOe4/7e/4oIGFG1OQe
Wy4hLTDwIDelAMjT5KJDdw6Qos9xSGOfl4I8s93pmzRjSWW0o1+BU/9WZ9Hgd2a2
zHHr5tXrwrl+1XC9igYOKzzww7WnDe2OPXxloA0N510DU+UP534GzZjNUa2HbgXt
nK/HFlHUHt0XR2lEzjceU9baHB8vr/CDYbeqSh1gIN48A/o+cccxCN2rKr7giLM=
=hP4n
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
