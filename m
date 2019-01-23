Received: from eggs.gnu.org ([209.51.188.92]:60459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmNNU-0001QI-8r
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmNNT-0002CZ-GH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:35:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gmNNT-0002CG-8C
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:35:55 -0500
Date: Wed, 23 Jan 2019 18:33:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190123183319.GF8724@stefanha-x1.localdomain>
References: <20190122162924.26491-1-stefanha@redhat.com>
	<a60dbcd8-df39-ebe9-a86b-92bc468b8ec2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <a60dbcd8-df39-ebe9-a86b-92bc468b8ec2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update microbit ARM board
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, contrib@steffen-goertz.de, joel@jms.id.au, jusual@mail.ru


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 07:19:57AM +0100, Thomas Huth wrote:
> On 2019-01-22 17:29, Stefan Hajnoczi wrote:
> > New source files were added without corresponding ./MAINTAINERS file
> > entries.  Let's get things up to date.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > This also includes the I2C/TWI stub which Peter has merged into his
> > target-arm.next tree but isn't in qemu.git/master yet.
> > ---
> >  MAINTAINERS | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index af339b86db..e3cb67e81d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -833,7 +833,19 @@ L: qemu-arm@nongnu.org
> >  S: Maintained
> >  F: hw/arm/nrf51_soc.c
> >  F: hw/arm/microbit.c
> > +F: hw/char/nrf51_uart.c
> > +F: hw/gpio/nrf51_gpio.c
> > +F: hw/i2c/microbit_i2c.c
> > +F: hw/misc/nrf51_rng.c
> > +F: hw/timer/nrf51_timer.c
> >  F: include/hw/arm/nrf51_soc.h
> > +F: include/hw/arm/nrf51.h
> > +F: include/hw/char/nrf51_uart.h
> > +F: include/hw/gpio/nrf51_gpio.h
> > +F: include/hw/i2c/microbit_i2c.h
> > +F: include/hw/misc/nrf51_rng.h
> > +F: include/hw/timer/nrf51_timer.h
> > +F: tests/microbit-test.c
>=20
> Looks like using wildcards would be easier here:
>=20
> F: hw/*/nrf51*.c
> F: hw/*/microbit*.c
> F: include/hw/*/nrf51*.h
> ...
>=20
> ?

Will send v2.

Stefan

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSLNuAAoJEJykq7OBq3PImKoH/2h0OdX2vuMRCWsNtLYOlGtc
CRCYk5dj3LUZdoJsPsb4ZqrnWAFlvOfpRfrcUh1asxcCOThZFSifanMoTPxmSENG
bGOShqDOJql/zoUyVdqBirvX0FtjSEVyit90EInLvVMiKqVuwtGsS0vYAUZgOBQ3
3pEoyuvNMgc9h4fS9DAYROSs0PqDIi8Yquu5zYIzly4BLfcEX2pT/fvf3ww66bVc
wLLa6KrF3CBQ4fqRQroJnSEMmCXx6M+pv5ciDhI0An/nz7z3l4tFyP2xW02K7XbT
Bg4EU/zSQcWjTMi5Pf1wF1xMzed5br/zSjpWP58AoElAIPf7bg62NlZZ0jaEik4=
=mNpC
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
