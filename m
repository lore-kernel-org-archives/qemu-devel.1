Received: from eggs.gnu.org ([2001:4830:134:3::10]:44080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuZFU-0006ty-0F
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 02:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cuZFS-0007yH-VB
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 02:44:28 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cuZFS-0007xT-IB
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 02:44:26 -0400
Date: Sun, 2 Apr 2017 16:44:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170402064417.GF16790@umbus.fritz.box>
References: <CA+KKJYD3duCUjOuYH-fsH1HTUkGLugF6-YX0L1+Kdd9z-sVYqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <CA+KKJYD3duCUjOuYH-fsH1HTUkGLugF6-YX0L1+Kdd9z-sVYqw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 09/43] ppc: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2017 at 04:44:36PM +0300, Danil Antonov wrote:
> >From 236c82fee189c22b88313fda71816e486edab8a6 Mon Sep 17 00:00:00 2001
> From: Danil Antonov <g.danil.anto@gmail.com>
> Date: Wed, 29 Mar 2017 12:23:58 +0300
> Subject: [PATCH 09/43] ppc: made printf always compile in debug output
>=20
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug
> output is turned off and, in turn, will prevent bitrot of the format
> strings.
>=20
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>

Hrm.  Long term we really wantto change these to tracepoints anyway,
so I'm not sure how useful this is on its own.  I'd apply it anyway,
except it no longer applies clear against ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4J2+AAoJEGw4ysog2bOShY8P/Rf8wuTV9Ab2IPpYZSLA5CJH
dfVbf4mLhqQ7g2a8SGUwZVlhuR2m0rGI6LXuubhPhFdDBTrxncojv3ezgU9VD1NY
GirMxRAnws9L6pbdoJPOrrj1rAKdMxxp/We6gX7X7YyHZQtAg6cGcG6iYGNusc0Q
ymnZnhrEtuCmtIVOK4bC698V/bMBGU8n+Hnk3CmRlrXyqTXNbl2zmwFCErzYtb/R
bdfaBfYbnXfFscjbh3Z8peZVI6wf8oN642SfKMu6NRjpb235GEPLpNRw7Hl8mpUi
dep/esmEqiHn5vd3Qbi/7XDrHIXh9nyjre9ac1eU6HlXV7KU89JK7LnSGMiU2afF
XJPatchlZ6DVr2PBS8u8tpoR4eCNalA1e8uQigi0/j5ndOeXu+Z2nphKox8d2Ug8
Iy6ECf+fa1rx5umExofAxHltnFkF8SLLWBF626Vzsk0g3wvTmjuAnLOBP3tb+2pK
ikW6idJy4FKobGJ20x2mfS5/xhItrmgN7WcgxYwWQMTKgFUfD9i99zJjlkRikMp9
VS9hKFmmb3tWAriKyFJMZeoge+UcnsjCO9/oP5EPGBicC7GOR8m7Fc5V37rybD+Q
YqcisnLz/3wK+rEvzUWK6xb7V9RNfXUSalayEDVtIUk/1KFEWF3oiLlKuuZbBz9a
MUgCaQn3FlLz8tno/Pua
=uj0P
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
