Received: from eggs.gnu.org ([2001:4830:134:3::10]:54276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elMaj-0002OI-0e
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elMaf-0001U5-3l
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:28:53 -0500
Date: Tue, 13 Feb 2018 09:11:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180212221104.GI11634@umbus.fritz.box>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
	<d54c87e3-6919-2834-82a2-aab319d94b04@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6yxL3IctpgIvrN+d"
Content-Disposition: inline
In-Reply-To: <d54c87e3-6919-2834-82a2-aab319d94b04@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180212
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: peter.maydell@linaro.org, groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--6yxL3IctpgIvrN+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 07:46:21PM +0100, Laurent Vivier wrote:
> On 12/02/2018 04:40, David Gibson wrote:
> > The following changes since commit c7b02d7d032d6022060e4b393827c963c93c=
e63f:
> >=20
> >   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedu=
p-090218-1' into staging (2018-02-09 16:12:34 +0000)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180212
> >=20
> > for you to fetch changes up to 51f233ec92cdab7030cb7407dd7f009911c805b0:
> >=20
> >   misc: introduce new mos6522 VIA device and enable it for ppc builds (=
2018-02-11 10:18:52 +1100)
> >=20
> > ----------------------------------------------------------------
> > ppc patch queue 2018-02-12
> >=20
> > Here's the accumulatead ppc and pseries related patches for the last
> > while.  Highlights are:
> >     * A number of Macintosh / CUDA cleanups from Mark Cave-Ayland
> >     * An important bug fix (missing "break;") for
> >       H_GET_CPU_CHARACTERISTICS
> >     * Yet another fix for SMT mode handling
> >     * Assorted other cleanups and fixes
> >=20
> > ----------------------------------------------------------------
> > Daniel Henrique Barboza (1):
> >       hw/ppc: rename functions in comments
> >=20
> > Greg Kurz (1):
> >       spapr: add missing break in h_get_cpu_characteristics()
> >=20
> > Laurent Vivier (1):
> >       spapr: set vsmt to MAX(8, smp_threads)
> >=20
> > Mark Cave-Ayland (9):
> >       cuda: do not use old_mmio accesses
> >       cuda: don't allow writes to port output pins
> >       cuda: introduce CUDAState parameter to get_counter()
> >       cuda: rename frequency property to tb_frequency
> >       cuda: minor cosmetic tidy-ups to get_next_irq_time()
> >       cuda: don't call cuda_update() when writing to ACR register
> >       cuda: set timer 1 frequency property to CUDA_TIMER_FREQ
> >       cuda: factor out timebase-derived counter value and load time
> >       misc: introduce new mos6522 VIA device and enable it for ppc buil=
ds
>=20
> David, following patches from Mark's series are missing in your pull
> request, is that normal?

I don't know about normal, but it's expected.  I didn't get around to
reviewing and merging those last few patches of his before preparing
the pull request.  They'll be in the next one.

>=20
>   cuda: convert to use the shared mos6522 device
>   ppc: move CUDAState and other CUDA-related definitions into separate
>        cuda.h file
>   cuda: convert to trace-events
>=20
> Thanks,
> Laurent
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6yxL3IctpgIvrN+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqCEPYACgkQbDjKyiDZ
s5Lj1Q/8CYNu+BQd2YASmIW1djwm8gSiFEqKWDF4wrYQkt/8HHa79i+qiClSmqV9
AlqXXbi3nByASufEAX+nsx75rDI/VTVoRhvn7Zk0huymXwrP96GDJJTipQqURXMw
HAY4fAdsFpb2+JlFUOP9QrZI2s2+MJ+eZgVT9l+GzW5Tg340vmyu4DJS2TFWxUsa
UkZdsIm4TSmv7B0VMIYZLk8L+D4RXCSkzBsSB8UwGlsrS/nhL9uZ15u/4wJrT5Vr
6peGOvAieQbcbASIg/sFP+Fft41vNzngDBHz0urXjQej3KkR+L8p0H/czMDNCLrZ
YDfDMvAjwgVVLQ/Jqy/x1QwiKTrQLpaz8VqTQo9QGxssvigRfZfAXtusX7Vy8e+R
kKidc/lu148atec4EtF4yc7iEF+64yWApoEhmx2LbObg4/flCHPrefkAbv/e+OO6
KMmtreu3c6X3zlaeE7cPoTYnRywKHjsmY0f/DSZ0OUjsc+xeFeOU7WKY+TqXEDcQ
8XryPebYrmJC3aSMuLjhb4fstsYhTmT1SjX6Yc5I2rpEDeBmbzeeiGKm7Wi2Qhof
a+gX3c4hxg6CKvSfYqzNZ/S/eZ/dM1x4eqp4Uj/84Yz+GmnC2hQtaZrXtcnW9rqj
ymMvicMWZ4Wodlp0Sheds5jQnNOWZpY7RAGnSpvjuwTbhpiJg60=
=Ojo1
-----END PGP SIGNATURE-----

--6yxL3IctpgIvrN+d--
