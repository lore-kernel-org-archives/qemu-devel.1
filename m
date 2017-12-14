Received: from eggs.gnu.org ([2001:4830:134:3::10]:43237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePUZr-0001TK-9C
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePUZq-0005Wm-6Q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:33:35 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7bc179c8-5699-98b0-8a5b-b4d8e6843b25@amsat.org>
Date: Thu, 14 Dec 2017 11:33:03 -0300
MIME-Version: 1.0
In-Reply-To: <20171214093907.GA14433@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="BsSxMXTeUgfa6EfP64fxc4AwwE5nuswTI"
Subject: Re: [Qemu-devel] [PATCH 0/6] QTests: use Python to run complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BsSxMXTeUgfa6EfP64fxc4AwwE5nuswTI
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org
Message-ID: <7bc179c8-5699-98b0-8a5b-b4d8e6843b25@amsat.org>
Subject: Re: [PATCH 0/6] QTests: use Python to run complex tests
References: <20171213213557.26561-1-f4bug@amsat.org>
 <20171214093907.GA14433@stefanha-x1.localdomain>
In-Reply-To: <20171214093907.GA14433@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On 12/14/2017 06:39 AM, Stefan Hajnoczi wrote:
[...]
> Device qtests are better done in C than Python.  Python is not good at
> binary I/O and porting this to Python 3 will be extra work later (Pytho=
n
> 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
>=20
> More importantly, we already have libqos in C with a guest memory
> allocator, PCI, and virtio support.  Fragmenting the small amount effor=
t
> that goes into device testing will delay libqos reaching critical mass.=

> Critical mass is where libqos provides all the infrastructure you need
> to set up a device and focus on your actual test instead of machine,
> bus, or device initialization.  Starting a Python device testing effort=

> will just lead to duplication and 2 underdeveloped device testing
> frameworks.
>=20
> Is there a specific reason why adding SD Card support to libqos is not
> possible in C?

Short (joking) answer: Would you write tests/qemu-iotests/041 in C? ;)

Now thinking about the specific reasons...

What I intend to do is add qtests for the SDHCI implementation.
There are different revisions of the standard specs.

Currently QEMU implements a mixed subset of v1.10 and v2.00, while the
real SDHCI hardware implemented is v2.00 or v3.01. I also saw 2 series
adding SDHCI devices supporting the v4.00 (not yet in /master).

With the current codebase we can plug SDSC/SDHC cards (up to 32 GB) but
we can not plug a SDXC card, so:
- plugging a 64GB card into the ZynqMP machine fails,
- plugging a 64GB card into the SABRE Lite machine fails,
- booting a Win10 guest on a exFAT formatted SD card also fails.

A later test create different cards with [2GB, 16GB, 64GB] and test if
the SDHCI correctly access them.
Machines using the Exynos4210 SoC which only support the v2.00 spec are
expected to fail with 64GB SDXC cards.

The Zynq machine has 2 SD buses, another later test unplug/replug the
same card between the buses. This test is expected to be useful to test
the custom SDHOST controller from the BCM2835 SoC (Raspi2 machine).

It is surely possible to write all those tests in C, but it resulted way
faster to me to write them in Python...

I could think of a bunch of I2C tests too, more generally I found using
Python for bus backend testing is much easier, as with the Block backends=
=2E

Regards,

Phil.


--BsSxMXTeUgfa6EfP64fxc4AwwE5nuswTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAloyi58ACgkQ4+MsLN6t
wN6Hqw/8CSQ38r/TmjVE3yt0mq8F3LPJ3QWKRZS1GgxXx0+dE/KgzGgRtsOuY8Ww
YguOLpmrh0j25f/wUyGbgTVArjYeGU09B8GuOFDmJ88cCoyUbClSVZZSyaBxLzc/
cfN+U9/oLW/SzVKxBxNv9AQlPccm+LaWbkKrHszlo+6gWVPyZZOCchAT7I1tT0C/
sVC5CwNAAwQ75Ji7bfdQeV16PV+9MAR6H0hLP8fImBO9qV5yrZcsMCL/q4Yll4TW
5tjjnFsXRrUrSCkJQbcTFUCpdnL+TrJGK4bep7Y7bPnEBTUNFEJ4d/Asi+q0PVsw
dT1z/npC5qoxlZfyA+wefCtu+apbRCn7olMVj6LNSIsDLueSADvBDn6Ztqxn0re+
+sEYxnDmFrNMqA6Cd2FSs8BDQP7lA205KC/odUWZvajeUWwBGO3dSmPKyL0IpIdM
QhWUV5dQ5va+FazHquLvBsVBrGSNoZR6G90LqoOxuJAAp0yfct06fFbVDz6HlHAU
tErJDAuQ19q7DNU7EJwxign1uBfXJCmCQqR0Xi5Eyq1qZOmUYn0akOevl0I3JY/I
Xj+lstQutPeVK6hFbqkYFYOTwMSUQlaXsEjzFNfVYA881a9jJDX4XYGe9JN3vj0s
9QsmfrknZDvXttEcZHlDPy0reMb/q2V6KZ6hzBWkYjFice4iBqE=
=/fH0
-----END PGP SIGNATURE-----

--BsSxMXTeUgfa6EfP64fxc4AwwE5nuswTI--
