Received: from eggs.gnu.org ([209.51.188.92]:59106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glsW0-0006AI-GN
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glsKk-0002k7-3O
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:27:07 -0500
Date: Tue, 22 Jan 2019 09:26:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190122092657.GA17452@stefanha-x1.localdomain>
References: <20190110094020.18354-1-stefanha@redhat.com>
	<CAFEAcA8bz7ViuZeZqCBZHy49=dbYxW7Q04MbuVKapEfT5K56ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8bz7ViuZeZqCBZHy49=dbYxW7Q04MbuVKapEfT5K56ug@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] arm: Stub out NRF51 TWI
 magnetometer/accelerometer detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 04:21:03PM +0000, Peter Maydell wrote:
> On Thu, 10 Jan 2019 at 09:40, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > v2:
> >  * Move stub code into a separate device [Peter]
> >  * Instantiate stub from microbit board instead of nRF51 SoC since this=
 is
> >    microbit-specific.  Other boards using the nRF51 wouldn't necessaril=
y want
> >    to see these TWI/I2C devices.
> >  * Add test case
> >
> > This series stubs out the microbit's TWI/I2C devices so the microbit-dal
> > firmware boots successfully.  The accelerometer and magnetometer are pr=
obed at
> > startup.  If they are not found the firmware panics.
> >
> > Stefan Hajnoczi (1):
> >   tests/microbit-test: add TWI stub device test
> >
> > Steffen G=F6rtz (1):
> >   arm: Stub out NRF51 TWI magnetometer/accelerometer detection
> >
> >  hw/i2c/Makefile.objs          |   1 +
> >  include/hw/arm/nrf51.h        |   2 +
> >  include/hw/arm/nrf51_soc.h    |   1 +
> >  include/hw/i2c/microbit_i2c.h |  42 +++++++++++
> >  hw/arm/microbit.c             |  15 ++++
> >  hw/i2c/microbit_i2c.c         | 127 ++++++++++++++++++++++++++++++++++
> >  tests/microbit-test.c         |  44 ++++++++++++
> >  7 files changed, 232 insertions(+)
> >  create mode 100644 include/hw/i2c/microbit_i2c.h
> >  create mode 100644 hw/i2c/microbit_i2c.c
>=20
> Applied to target-arm.next, thanks. Can you provide a
> MAINTAINERS file update for the new files, please?
> (You can send that separately or stick it in another
> nrf51 series if you're sending one.)

Sure, will do.

Stefan

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRuHhAAoJEJykq7OBq3PIoXYH/2kCnoguR7EO1X7TnB+GAArT
BdAJYlGbXTLepUjO9IQ2Q8B4CMC2/jg9YopD9zJGJJJRFUckHCZkL6bHZDNloKfr
y33j3g5g5estByYfYBz8X0zm1xbpd/3FF2KwRFDDbCg87cOGr7CLfRl1Pq92kn0F
Lr0Wc3VSDtVBdLNSgBcAaicZL1CUOJtdrLCTtauQuedAUg61uPdjvqXT0b4impfT
2LUXVZO/En5AgbGwxdk2q3vgNWXa5gxqKw9IzkGcJIoHBIbS6IKTsL7sAB+A1Oob
ic+AYhPR7U8qZHI13DGEFLuIB6LyFkBMidVsvnP1PZAqsNM86sGFSMPmYnMMaFw=
=jj9T
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
