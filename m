Received: from eggs.gnu.org ([2001:4830:134:3::10]:55338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOK8Q-0001lH-QL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOK8L-0007oa-Ti
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:44:42 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOK8L-0007nc-Mh
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:44:37 -0400
Received: by mail-wr0-x241.google.com with SMTP id f16-v6so17008899wrm.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 02:44:37 -0700 (PDT)
Date: Thu, 31 May 2018 10:44:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531094434.GJ26429@stefanha-x1.localdomain>
References: <20180529220338.10879-1-jusual@mail.ru>
	<97e86c94-b0f3-be30-627a-19a25783cba6@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CxDuMX1Cv2n9FQfo"
Content-Disposition: inline
In-Reply-To: <97e86c94-b0f3-be30-627a-19a25783cba6@amsat.org>
Subject: Re: [Qemu-devel] [RFC 0/3] nRF51 SoC: Add UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>


--CxDuMX1Cv2n9FQfo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 11:57:47PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Julia,
>=20
> On 05/29/2018 07:03 PM, Julia Suvorova via Qemu-devel wrote:
> > This series adds basic support for the nRF51 SoC UART, that used in
> > BBC Micro:bit board, and QTest for it.
> >=20
> > Based-on: <20180503090532.3113-1-joel@jms.id.au>
> >=20
> > Julia Suvorova (3):
> >   hw/arm/nrf51_soc: Fix compilation and memory regions
>=20
> Since Joel's series isn't merged, you can simply take his patches, fix
> them, and include them in your following series.  Usually you keep his
> Signed-off-by line, add a comment with your changes, then add your
> S-o-b, such:
>=20
>     [PATCH ...] hw/arm: Add Nordic Semiconductor nRF51 SoC
>=20
>     The nRF51 is a Cortex-M0 microcontroller with an on-board radio modul=
e,
>     plus other common ARM SoC peripherals.
>=20
>     This defines a basic model of the CPU and memory, with no peripherals
>     implemented at this stage.
>=20
>     Signed-off-by: Joel Stanley <joel@jms.id.au>
>     [Julia: Fixed BBC Micro:bit board ROM/RAM size, added FICR defines]
>     Signed-off-by: Julia Suvorova <jusual@mail.ru>

I think Joel will send another revision of his series.  It would make
sense for him to squash in this patch.

Stefan

--CxDuMX1Cv2n9FQfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD8QCAAoJEJykq7OBq3PIfVwH/Aru9Eux4DuYYM8ARspCXrNw
LC0lhdO1VCvtsx329wHMNFH9l+aeLDJd7RPt1eofLc1Lf5p+C6PCSE1HZtVYDkeL
sagMnJSwfV4s+FbPaLDWnOx/OItcLvw6KmW1BvM/C5sFbi3H7B/2dgO/WmqyLdgh
RXgGqe0Vm3/Ax9qt4EO9T2LQzqMWUnzPfFZ9K5UDigwi/M6ktb5tjkxk8jtiU6uS
md785Qtr2IXbCRXskpp6WBLUdFg09RmFg0AoqoCUD/qaw8qtM1a9O1Bfap486snn
25PnHsR5zOjfJj7pAkqKEKOq37pUtfoA+Jnla69M/nYIRS7YIyg0deStMEQSDeU=
=irQQ
-----END PGP SIGNATURE-----

--CxDuMX1Cv2n9FQfo--
