Received: from eggs.gnu.org ([209.51.188.92]:36690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goJXC-00059H-86
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goJXB-0007HH-Jm
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:53:58 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1goJXB-0007H1-Dt
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:53:57 -0500
Received: by mail-pf1-x442.google.com with SMTP id r136so8966237pfc.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 18:53:57 -0800 (PST)
Date: Tue, 29 Jan 2019 10:53:52 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190129025352.GB3264@stefanha-x1.localdomain>
References: <154842501977.29408.13715859935418850955.malonedeb@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <154842501977.29408.13715859935418850955.malonedeb@soybean.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1813305] [NEW] trace-root.h is not
 regerenerated after re-configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1813305 <1813305@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 02:03:39PM -0000, Christophe Lyon wrote:
> I've just realized that after I reconfigured my qemu with
> ../configure --target-list=3Darm-softmmu,arm-linux-user,aarch64-softmmu,a=
arch64-linux-user --enable-trace-backends=3Dsimple
>=20
> $ make
> did rebuild some stuff for the 'simple' trace, but it did not update trac=
e-root.h until after I
> $ make clean
>=20
>=20
> I took me while to understand why I didn't get the traces I wanted (my tr=
ace-root.h still thought it was configured for the default 'log').
>=20
> I didn't check how easy it is to fix this in the build system.

Thank you for reporting this.  I have sent a patch to fix the makefile.

Stefan

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcT8BAAAoJEJykq7OBq3PIJTsH/jJLiJRwSNzzm2gDM2l0TjsZ
S+LC5ds3c0OmnXGJntfr+X2MiXuNamk4IRZG7bHis7w754Cl+ibqcJ7XPygOibTF
6mHqT1FWlvdD4fV7vcjvQCeiPcIoz8S+J/IuP7QqkANBY0Khqeezbxp9SptsA4y3
LJJ8hQ3lApADih2521z622m9f4O0MTebydFAGfEIW7yObKyzDi7gr8YfnPIAoVxU
ABCci6aUNYJdL4rUnxX/uO5qKE+GLJZrZTMk3+n8ogbHZK1J6aGnweK8owew75Y7
AN7pnMXB2/t22Uw80X9mFNdAROB3XICQ+LhuLmRrNFZ/POLzja4i0iR5aETP7Vc=
=6i/x
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
