Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQsHS-00010U-O8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQsHP-0000ax-Jp
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:36:34 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:34916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQsHP-0000a2-CV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:36:31 -0400
Received: by mail-wm0-x22f.google.com with SMTP id j15-v6so17964208wme.0
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 03:36:31 -0700 (PDT)
Date: Thu, 7 Jun 2018 11:36:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607103628.GE19032@stefanha-x1.localdomain>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
	<CAJSP0QWELqGP56Dm5qyS7zGe_xdPwB5t6CZXkqhdmX16RKM9nw@mail.gmail.com>
	<CAG7hfcJxiPYou5dNaWcL8p9uQxHUX1Qa7PDaku_z80Qx-S=yGg@mail.gmail.com>
	<CAJSP0QW4dDpifDJgyuLKo3Ar53OGwUMP16e++HnDe69NA3-Mmw@mail.gmail.com>
	<CAG7hfcLvhTgz2497-wDD0e02U7hX4eeRPuzqwaL+ugxemPSkzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <CAG7hfcLvhTgz2497-wDD0e02U7hX4eeRPuzqwaL+ugxemPSkzg@mail.gmail.com>
Subject: Re: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 07:15:01AM -0400, Liviu Ionescu wrote:
> On 4 June 2018 at 14:10:08, Stefan Hajnoczi (stefanha@gmail.com) wrote:
>=20
> > What is the status of the Cortex M0 in that source tree? Is it complete?
>=20
> all supported Cortex-M devices run blinky demos using the official
> CMSIS initialisations, but I would not qualify them as complete.
>=20
> they also include graphics support, the leds and buttons are active in
> the board picture. highly appreciated by users.

Thanks!

Julia is doing a 12-week Google Summer of Code internship, so I'm
hesitant to ask her to take on out-of-tree code that isn't complete and
close to mergeable.

If you do want to upstream the code you linked, please let us know the
details of how you want to do it and how long it might take.  Maybe
there is a way to work together on it...

Stefan

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGQqsAAoJEJykq7OBq3PISE0IALG4qmfPTnDROlSfnrzld1dq
1Y1YtP7FvEbylN0pLD+n5q3iXiyrMLF2e0SnDRIw4srG8/owrkCcPGVJnvE76pwe
rbH/qFyAnHxlWL4e8dnkx+6RbF29jOEJwKGcYbGTbKlKLdZSaU0YLMRJxdiV4Qki
LWWKRl4dOoO409XHh18JkkfBE+nCWIWlJ15YuQ1WxT9MJc2XWyMH9vshAGhZ/tMK
XOI3x5Iq+ptdU9Fx5+LjXYGgFKnDZ0sRtVeluH8QabCoBy2+pJS2FKzxJ38G2gMv
DN2TiKd7o1DtxbLbfPef5tSdLkZJcWNpWtdm9iAt7exRJ3xkKUkKMJIv9z1ky0A=
=0KMT
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
