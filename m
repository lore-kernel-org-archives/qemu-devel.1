Received: from eggs.gnu.org ([2001:4830:134:3::10]:56700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIDI7-0000iK-4z
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIDI4-0000qw-0C
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:13:27 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:52468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fIDI3-0000qZ-OG
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:13:23 -0400
Received: by mail-wm0-x231.google.com with SMTP id w194-v6so13358224wmf.2
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 06:13:23 -0700 (PDT)
Date: Mon, 14 May 2018 14:13:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514131320.GC5182@stefanha-x1.localdomain>
References: <CA+EEy5tEYtEXPH-vXcdcb1XsAD_5MEaz_JQ+_rwK3RfZn4b+nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <CA+EEy5tEYtEXPH-vXcdcb1XsAD_5MEaz_JQ+_rwK3RfZn4b+nQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Question about QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?7Jyg7JuQ7IOB?= <wonsange@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 05:55:38PM +0900, =EC=9C=A0=EC=9B=90=EC=83=81 wrote:
> Hi,
> This is Wonsang Ryu.
> I'm developer working in South Korea.

Welcome!

> Do you have forum or community for any developer?
> I want share my issues with other developers.
> I have some question about QEMU.

That's what the qemu-devel@nongnu.org mailing list is for.  You can also
ask questions on the #qemu irc.oftc.net IRC channel.

> I am porting an embedded OS for emulator to QEMU.
> My environment is
> Host OS : Ubuntu 14.04 64bit
> Guest OS : x86 Embedded Linux OS (like as open embedded)
> Guest UI Options : using SDL2, virglrenderer
> Basic running is ok.
>=20
> I have a problem about screen resolution.
> Recommended resolution of my guest OS is 1920x1080.
> If a QEMU window size is 1920x1080, it is clear.
> But, if I change smaller of a QEMU window size, it does not display
> clearly.(ex: 1280x720)
> In this case, QEMU windows size in host is 1280x720, and guest screen
> resolution is 1920x1080.
> For example, it is similar with same resolution support of different
> monitor size.
>=20
> I think, it need to enable the MultiSampling(or anti-aliasing) of OpenGL.
> Does not support MultiSampleing in QEMU yet?
> Or, is it related with virglrenderer?
>=20
> I found, QEMU does not use MULTISAMPLING option in "sdl2-gl.c".
> And, "nr_samples" is always zero in "virtio-gpu-3d.c".
> I think, it need to apply multisampling to texture received from
> virglrenderer.
> How can I enable a multisampling option in QEMU?
>=20
> I want to hold the resolution of the guest OS and scale the QEMU windows =
in
> the host OS.
> When scale QEMU windows, I want display is more clear even though small.
> Is it possible?

CCing Gerd (graphics maintainer) and Marc-Andr=C3=A9, who might know the an=
swer.

Stefan

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+YtwAAoJEJykq7OBq3PIesAH/R1X9ZPT/g/6/M/8dlB3BfaP
R2shkNSpG/9JMmrgV0kEby7RsN5lbGQ+j4/Mqssd6lfGXPyfIRfr4gWxPVQVy/6A
fPBtRDuKpyjuMV5Ke9xv23BLlk+5rwnhxLnIiS2mCu66fjnvY/wrFAisuOVtY4jC
w74wzIiBGrqBf8lejZ0UgZhEHmz7EzYXBbhbr44axNx35yNLURDa345RD4MbL+bC
n3+G8+0gU4WN99AJ5YKoWg0cGM5gVvtoiyceQtEKFMapMmi2LHiiM38PCZiX0o4i
hug1R9W8f0ASrfbvWw5oXZMIGu96jgCMADAzGvi/PcDdFvlzHUkAnc7xookjAXo=
=CSSi
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
