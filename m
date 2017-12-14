Received: from eggs.gnu.org ([2001:4830:134:3::10]:60574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePX9R-00066L-Tq
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePX9Q-0006P8-VN
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:18:29 -0500
Date: Thu, 14 Dec 2017 17:18:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214171810.GA18098@stefanha-x1.localdomain>
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<7bc179c8-5699-98b0-8a5b-b4d8e6843b25@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <7bc179c8-5699-98b0-8a5b-b4d8e6843b25@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 0/6] QTests: use Python to run complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 11:33:03AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Stefan,
>=20
> On 12/14/2017 06:39 AM, Stefan Hajnoczi wrote:
> [...]
> > Device qtests are better done in C than Python.  Python is not good at
> > binary I/O and porting this to Python 3 will be extra work later (Python
> > 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
> >=20
> > More importantly, we already have libqos in C with a guest memory
> > allocator, PCI, and virtio support.  Fragmenting the small amount effort
> > that goes into device testing will delay libqos reaching critical mass.
> > Critical mass is where libqos provides all the infrastructure you need
> > to set up a device and focus on your actual test instead of machine,
> > bus, or device initialization.  Starting a Python device testing effort
> > will just lead to duplication and 2 underdeveloped device testing
> > frameworks.
> >=20
> > Is there a specific reason why adding SD Card support to libqos is not
> > possible in C?
>=20
> Short (joking) answer: Would you write tests/qemu-iotests/041 in C? ;)

041 is not a device-level test.  It doesn't poke device registers, it's
a functional test.  In my email I said I support using Python for those
types of tests.

> Now thinking about the specific reasons...
>=20
> What I intend to do is add qtests for the SDHCI implementation.
> There are different revisions of the standard specs.

It would be great to have SDHCI support in libqos.  PCI and virtio are
covered today and support for more busses will help reach that critical
mass where tests can be written for most QEMU device models without
first writing a new device driver framework.

Please post your SDHCI test code, so we can discuss the details and
consider whether it's more like 041 or more like tests/ide-test.c.

Stefan

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMrJSAAoJEJykq7OBq3PIzEwH/2UjYhG5egHJVC51jcUE7sY/
LccTWkm8yHGnxbKQWS2hCZcjDKVNTHCgauTqD2vLxGx1s+WDAUuIqLjp04LU4ax8
CjNfSCuB5JJG3BZFj2ExFq50TOUKWavcBcbm7TC18VMUl2LjienwwfYvl6S4dgzo
SLqh+8Xq1Tb/GpnQgnGJyOEi7n8lziZHSyMPzeN5mCKgEkLVTfyAfH+pBefqFOTZ
xFfAwfH3+lCM0FF1ZxqRIExWd4AoUZcjDq+EaxhOlyzvpiLsuolxouahEtxMSR7K
Dcq9rSyh3xku2Nv0eTYoqUfeQATFXAi13XXQb4CLbpa/BFad7y/QL2jOA0jpszI=
=6UhA
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
