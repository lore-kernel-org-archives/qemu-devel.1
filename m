Received: from eggs.gnu.org ([2001:4830:134:3::10]:39881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9NUB-0004w6-DP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9NU8-0005KD-61
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:17:23 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:46693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9NU7-0005Iq-Ti
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 00:17:20 -0400
Received: by mail-qk0-x22f.google.com with SMTP id s70so7663432qks.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 21:17:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180419164642.9536-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <585ca5e3-8477-49d0-7132-981a95435a75@amsat.org>
Date: Fri, 20 Apr 2018 01:17:08 -0300
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="QonWoDzHDd6sh5l4PgFL8QTEjAMmEBFiI"
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] avocado: Add acceptance tests
 parsing the Linux boot console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, avocado-devel@redhat.com, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QonWoDzHDd6sh5l4PgFL8QTEjAMmEBFiI
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>,
 Alistair Francis <alistair23@gmail.com>, avocado-devel@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <585ca5e3-8477-49d0-7132-981a95435a75@amsat.org>
Subject: Re: [RFC PATCH 0/7] avocado: Add acceptance tests parsing the Linux
 boot console
References: <20180419164642.9536-1-f4bug@amsat.org>
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Cross-posting qemu-devel + avocado-devel.

> While previously working on a Super I/O refactor, I encountered some pr=
oblems
> at runtime, after building the codebase successfully and running qtests=
=2E
> I had to manually start to boot different guests and check the bootlog.=

>=20
> I wanted to give a try at Avocado which seems designed to simplify that=
 kind
> of functional tests.
>=20
> I applied Amador Pahim work following Cleber Rosa documentation from
> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03891.html,
> however I had to modify few things to parse the boot console.
> Since his work is not merged, I included it in this series.
>=20
> The tests simply expect to find a string reported by Linux printk when =
a
> device is detected/initialized, such "ttyS0 at I/O 0x3f8 (irq =3D 4) is=
 a 16550A"
> and "i8042 KBD port at 0x60,0x64 irq 1" for the Super I/O chip, or such=

> "registered as PCnet/PCI II 79C970A" to confirms the PCI subsystem and =
network
> device are correctly detected:
>=20
>=20
>     self.assertIn(u'ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A', bootlo=
g)
>     self.assertIn(u'ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A', bootlo=
g)
>     self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
>     self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)
>=20
> Example of the tests output:
>=20
>     $ avocado run test_linux-boot-console.py -m test_linux-boot-console=
=2Epy.data/parameters.yaml=20
>     JOB ID     : 695094c9bbe8f6011226da7c2031c2c53e949910
>     JOB LOG    : /home/phil/avocado/job-results/job-2018-04-19T13.36-69=
5094c/job.log
>      (1/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boot=
_console;alpha-2582: PASS (4.76 s)
>      (2/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boot=
_console;mips-4a72: PASS (0.00 s)
>      (3/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boot=
_console;alpha-2582: PASS (0.00 s)
>      (4/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boot=
_console;mips-4a72: PASS (3.92 s)
>      (5/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boot=
_console;alpha-2582: PASS (0.00 s)
>      (6/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boot=
_console;mips-4a72: PASS (4.08 s)
>     RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUP=
T 0 | CANCEL 0
>     JOB TIME   : 13.31 s
>=20
> Please apologize my ugly Python, this series is just a proof-of-concept=
 :)
> I couldn't figure out how to use the @skipUnless(correct arch) decorato=
r.

Eduardo asked me to share my first impressions after trying this
framework with QEMU.

So far it seems more designed to run tests _inside_ a qemu instance
(think user-space), eventually testing packages/scripts.

My tests are targeting the machine model itself, if the devices are
correctly instantiated and so.
The fastest approach was to check the Linux kernel bootlog, but if you
look at the TestAlphaClipperBoot console you'll see a boot "firmware" is
executed before the kernel. Casually this firmware also send information
on the console, but what if the console is not accessible?
We can use a chardev for the ioport80 POST, but some firmwares post boot
events via I2C, SPI, CAN...

To improve the testing, my idea is to use the Tracing framework.
The machine trace events would be logged in a db and avogado would
verify some of the trace events, did they occur? in the correct sequence
order? with the correct arguments? We can also check relative
timestamps, is this sequence timing fast enough?

I plan to use the gdb API to insert breakpoints and follow part
execution flow, eventually injecting (faulty) events.

The multi-arch/machines support is a bit weak yet.

I'm personally more interested in automatically testing [real world]
firmware or full machine boot process, the kind of integration testing I
can not do with qtests.

I liked the possibility to generate coredumps, or the replay function.

I also liked to be able to write a test on how a machine boots, in ~20
LOC (see TestAlphaClipperBoot2_6).

The storage API is OK to fetch a full VM image, but not a single file
like a kernel or a flash image.

Enough for my second try, good work :)

I hope this was helpful.

Regards,

Phil.


--QonWoDzHDd6sh5l4PgFL8QTEjAMmEBFiI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrZacYACgkQ4+MsLN6t
wN7m/Q/+Lw2KzOBx0bo/GqJU68fJ2qCH95qUPyNQAIUp4W3qXKb+s2tZlnKoqx11
pYZFMlhaxTzroJ5Tfg+xqliLdpKIvt2tiQcMIskbSUQ2DvAPOtaCEwQg7j/yX1JH
XmnIuZ21f1ez6ABL8oGeBpI07V8MXgFU9LjIXEbVE9E8qUYtTH933N5HSY13JaLg
j9pw73dFbngLIMIGjOtSUgIx4t0wz9VDWcB6bSBhTNyPXUOloEXWJCK8K+A/0SiP
d0JeaG40LQmS0vZj+PnTjnN0AEwW96Im9JAUr6ebRCFiqAsUmsG/fc0NZOqwcVWj
2zjasOOaSlt6TfWy2nD6HJlbvMCszc9eQy5OQTL61BGSNif1RUZuAaRuuDfKZzk7
JpDKTwTwxKwjuka5oazmaBrJdRthoGaUq59xFMwaENb5g6Fd6pxbOo6Z4u3mFSX2
uMNw8ORHfCcqVkOK0d2DJyoSBvLrv0oQBU/+iLUgWjX979S1p2Q8vXQnZdzmWLVD
whxgUTUgJQ+x1GDRcF3aWTCmNKP2U0XZTWck947NLd3OqcOOlGbeutXl4FpWFXNq
cwiNrqJ2NSIYkVXIMv/l4fuv/HsVIEKHX9qf09v1VVmHEig+didr+f3916aCLi2Q
MmwrY9WXoKFOol7cvzn2CfKGpWdUlTkWIn8kpUmDnEMG6qqrjDU=
=2SIQ
-----END PGP SIGNATURE-----

--QonWoDzHDd6sh5l4PgFL8QTEjAMmEBFiI--
