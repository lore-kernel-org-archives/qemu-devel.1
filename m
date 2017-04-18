Received: from eggs.gnu.org ([2001:4830:134:3::10]:37632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UB6-0002ym-Ow
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UB2-0006UL-Ju
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:32:24 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d0UB2-0006TS-Dr
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:32:20 -0400
Received: by mail-wr0-x244.google.com with SMTP id u18so25148238wrc.1
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 07:32:20 -0700 (PDT)
Date: Tue, 18 Apr 2017 15:32:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418143217.GH21261@stefanha-x1.localdomain>
References: <CAJy91CZHb_aJncY1KSqTorZF3Gex=4_xd9=FmS5_QGzkXDNwGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Content-Disposition: inline
In-Reply-To: <CAJy91CZHb_aJncY1KSqTorZF3Gex=4_xd9=FmS5_QGzkXDNwGg@mail.gmail.com>
Subject: Re: [Qemu-devel] guest host time synchronization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 09:01:40AM +0200, Jiahuan Zhang wrote:
> I made a test to check the time difference of QEMU emulated ARM-based Lin=
ux
> guest and the Windows host. The result is, the guest time is around 0.2
> second faster than the host. I used the "-rtc base" option.
>=20
> So can I say that, the time precision of QEMU emulation is in seconds? Is
> it possible to make it more precise? because I need to test the latency of
> my guest/host communication with high time resolution, at least in
> miliseconds.
>=20
> Please let me know if you have any method  for the communication
> performance testing. Thank you very much.

This can depend on the exact board (machine type) being emulated because
the emulated clock and timer hardware may be different.

Please share your QEMU command-line so we can see the exact ARM guest
hardware configuration.

Stefan

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9iNxAAoJEJykq7OBq3PIAFsH/i6fmFyzyKQf8dIaJTyNde3U
D/p1RG4pxrkOll43K+2IdKi4GC+l+NC3wyCAw1f6Jl8o4xz8oCbC3fxoJ/bsg+Pn
Tc9cHPPuhKkQfr05FBP6zAaqs6yl1JASUh7LFuPwV777kU2q4JwxpgxjLcT5+k9m
YuQF/XTgiTdv0HpVf+nFrdyrClIXvwQSwZywCKgQ+Ls/j3V3Eg4F7HQe/FJdwCuO
EhJ2mx/kvjGI8qW8Cfhh04nCuYh0BEhHdY8PVa8J1GhWge1L/4c0vvUdECsCtvcW
zZUY9ACrkc5VTCmHDV/9CYf5w/P2Wd54Fo8JG4As9F5vdDgjpy36hQ2F8mX8AFI=
=rbp/
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
